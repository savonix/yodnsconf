###
# Program:: http://www.docunext.com/wiki/Sinatra
# Component:: yodnsconf.rb
# Copyright:: Savonix Corporation
# Author:: Albert L. Lash, IV
# License:: Gnu Affero Public License version 3
# http://www.gnu.org/licenses
# 
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as published by
# the Free Software Foundation; either version 3 of the License, or
# (at your option) any later version.
# 
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
# 
# You should have received a copy of the GNU Affero General Public License
# along with this program; if not, see http://www.gnu.org/licenses
# or write to the Free Software Foundation, Inc., 51 Franklin Street,
# Fifth Floor, Boston, MA 02110-1301 USA
##
require 'sinatra/base'
require 'rack/contrib/config'
require 'rack-rewrite'
require 'builder'
require 'sass'
require 'yajl'
require 'xml/xslt'
require File.dirname(File.dirname(__FILE__)) + '/Rack-XSLView/lib/rack-xslview' if ENV['RACK_ENV'] == 'development'
require 'rack-xslview' unless ENV['RACK_ENV'] == 'development'
require 'rack/cache'
require 'sinatra/xslview'
require 'sinatra/simplerdiscount'

require File.dirname(File.dirname(__FILE__)) + '/sinatra-stuff/sinatra-bundles/lib/sinatra/bundles' if ENV['RACK_ENV'] == 'development'
require 'sinatra/bundles' unless ENV['RACK_ENV'] == 'development'

require 'rexml/document'
require 'memcache'
require 'zonefile'
require 'net/dns/resolver'
require File.dirname(File.dirname(__FILE__)) + '/svxbox/lib/svxbox' if ENV['RACK_ENV'] == 'development'
require 'svxbox' unless ENV['RACK_ENV'] == 'development'

module Sinatra
  module ModBox
    include SvxBox::Sinatricus
    include SvxBox::MarkupGuppy
  end
  helpers ModBox
end

# The container for the Yodnsconf application
module Yodnsconf

  class << self
    attr_accessor(:conf, :memcdb)
  end

  # Create the app which will run
  def self.new(conf)
    self.conf = conf
    if self.conf[:ccf]
      puts self.conf[:ccf]
      if File.exists?(self.conf[:ccf])
        puts "reading custom conf"
        json = File.new(self.conf[:ccf], 'r')
        parser = Yajl::Parser.new(:symbolize_keys => true)
        customconf = parser.parse(json)
        self.conf.merge!(customconf)
      end
    end
    if self.conf[:memc_srv]
      self.memcdb = MemCache.new self.conf[:memc_srv], :namespace => self.conf[:memc_ns]
    end
    Main
  end
  class ZonefileNotFound < Sinatra::NotFound
    attr_reader :name

    def initialize(name)
      @name = name
    end
  end

  # The sub-classed Sinatra application
  class Main < Sinatra::Base
    set :environment => ENV['RACK_ENV']
    set :js => 's/js'
    set :css => 's/css'
    register Sinatra::Bundles
    puts ENV['RACK_ENV']

    configure do
      set :static => true, :public => 'web'
      set :xslviews => 'views/xsl/'
      set :uripfx => Proc.new { Yodnsconf.conf[:uripfx] }
      set :started_at => Time.now.to_i
      set :zonegroups => Proc.new { Yajl::Parser.parse(File.new(Yodnsconf.conf[:zonegroups], 'r'), :symbolize_keys => true) }

      # Set request.env with application mount path
      use Rack::Config do |env|
        env['analytics_key'] = Yodnsconf.conf[:analytics_key] if Yodnsconf.conf[:analytics_key]
        env['RACK_ENV'] = ENV['RACK_ENV']
        env['path_prefix'] = uripfx
        env['link_prefix'] = uripfx
        env['TS'] = Time.now.to_i
      end

      use Rack::Rewrite do
        rewrite Yodnsconf.conf[:uripfx]+'zones', '/s/xhtml/zones.html'
        rewrite Yodnsconf.conf[:uripfx]+'welcome', '/s/xhtml/welcome.html'
      end

      myxslfile = File.open('views/xsl/html_main.xsl') { |f| f.read }
      myxsl = XML::XSLT.new()
      myxsl.xsl = REXML::Document.new myxslfile
      set :xsl, myxsl
      set :xslfile, myxslfile
      set :noxsl, ['/raw/', '/s/img/', '/s/js/']
      set :passenv, ['PATH_INFO', 'RACK_MOUNT_PATH', 'RACK_ENV','link_prefix','path_prefix','analytics_key','TS']

    end
    configure :development do
      set :logging => false, :reload_templates => true
    end
    configure :demo do
      set :logging => true, :reload_templates => false
    end

    if ENV['RACK_ENV'] == 'production' && Yodnsconf.conf[:cache_base]
      use Rack::Cache,
        :verbose     => true,
        :metastore   => Yodnsconf.conf[:cache_base]+'/meta',
        :entitystore => Yodnsconf.conf[:cache_base]+'/body'
    end

    # Use Rack-XSLView
    use Rack::XSLView,
      :myxsl => xsl,
      :noxsl => noxsl,
      :passenv => passenv,
      :xslfile => xslfile,
      :reload => ENV['RACK_ENV'] == 'development' ? true : false,
      :content_type => 'application/xhtml+xml'

      set(:bundle_cache_time,0)
      set(:warm_bundle_cache,0)
      set(:cache_bundles,0)
 
      stylesheet_bundle(:all, %w(droppy yui-reset-min thickbox))
      javascript_bundle(:all, %w(jquery/jquery-1.4.2.min jquery/plugins/jquery.quicksearch jquery/plugins/jquery.droppy jquery/plugins/jquery.history-201006 jquery/plugins/jquery.pagination))

    # Sinatra Helper Gems
    helpers Sinatra::XSLView
    helpers Sinatra::ModBox
    helpers Sinatra::SimpleRDiscount

    helpers do
      def link_prefix
        "#{Yodnsconf.conf[:uripfx]}"
      end
      def rootxml
        '<root />'
      end
      # These should be different based upon development vs. production
      def get_servers(domain=nil)
        servers = []
        server = Hash.new
        server[:id] = 1
        server[:server] = 'Franklin'
        server[:host_name] = 'mx2.example.com'
        server[:modified] = Time.now.to_i
        servers << server
        return servers
      end
      def get_domains(domain_group=nil)
        # TODO caching
        zone = Yodnsconf.conf[:zonelist]
        zf = Zonefile.from_file(zone)
        idx_json = []
        zf.txt.each do |res|
          unless res[:ttl][0].to_i == 2
            if domain_group.nil?
              idx_json << res[:text]
            else
              idx_json << res[:text] if res[:ttl][1].to_i == domain_group
            end
          end
        end
        return idx_json
      end

      def open_zonefile(zone)
        zonefile = "data/zones/#{zone}.zone"
        if File.exists?(zonefile)
          return Zonefile.from_file(zonefile)
        else
          raise ZonefileNotFound.new(zone)
        end
      end

      def check_rr_type(type)
        Zonefile::RECORDS.include?(type)
      end

      def get_public_ns(domain)
        res = Net::DNS::Resolver.new(:nameservers => "8.8.4.4")
        packet = res.query(domain, Net::DNS::NS)
        ns = packet.answer.map do |rr|
          rr.nsdname
        end
        return ns
      end
    end

    before do
      cache_control :'no-store'
    end
    get '/' do
      mredirect 'welcome'
    end
    get %r{/(host|record|zone-group|service|redirect|ip)s$} do
      xslview rootxml, params[:captures].first.gsub('-','_') + 's.xsl', { 'link_prefix' => link_prefix }
    end
    get %r{/(host|zone-group|service|redirect|ip)-edit} do
      xslview rootxml, params[:captures].first.gsub('-','_') + '_edit.xsl', { 'link_prefix' => link_prefix }
    end

    get '/zone/:zone/:type' do
      zf = open_zonefile(params[:zone].to_s)
      type = params[:type].to_s
      begin
        check_rr_type(type)
        rs = zf.send type.to_sym
        rsarr = []
        if rs
          rs[0][:type] = type unless rs[0].nil?
          rsarr << rs[0] unless rs[0].nil?
        end
        if type=='soa'
          rsarr = rs
        end
        "<pre>#{rsarr.to_s}</pre>"
      rescue NoMethodError
        '<span class="errblk">Not a valid record type.</span>'
      end
    end
    
    get '/raw/yd-zones/' do
      xslview rootxml, 'zones.xsl'
    end
    get '/raw/json/yd-zone-groups' do
      content_type :json
      zg = File.open('data/json/zone_groups.json') { |f| f.read }
      zg.to_s
    end
    get '/raw/json/zones' do
      content_type :json
      get_domains.to_json
    end
    get '/raw/json/zones/:group' do
      content_type :json
      get_domains.to_json
    end
    get '/raw/json/records/:type/:zone' do
      content_type :json
      zone = params[:zone].to_s
      zf = open_zonefile(params[:zone].to_s)
      type = params[:type].to_s
      rs = zf.send type.to_sym
      rsarr = []
      if rs
        rs[0][:type] = type unless rs[0].nil?
        rsarr << rs[0] unless rs[0].nil?
      end
      if type=='soa'
        rsarr = rs
      end
      rsarr.to_json
    end
    get '/raw/json/public-ns/:zone' do
      content_type :json
      zone = params[:zone].to_s
      ns = get_public_ns(zone)
      ns.to_json
    end
    not_found do
      cache_control :'no-store', :max_age => 0
      %(<div class="block"><div class="hd"><h2>Error</h2></div><div class="bd">This is nowhere to be found. <a href="#{Yodnsconf.conf[:uripfx]}">Start over?</a></div></div>)
    end

    get '/s/css/stylesheet.css' do
      cache_control :public, :max_age => 600
      content_type 'text/css', :charset => 'utf-8'
      sass :yodnsconf
    end
  end

end

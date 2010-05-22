###
# Program:: http://www.docunext.com/wiki/Sinatra
# Component:: notapp.rb
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
require 'xml/xslt'
require 'rack-xslview'
require 'rack/cache'
require 'sinatra/xslview'
require 'sinatra/simplerdiscount'
require 'sinatra/bundles'
require 'rexml/document'
require 'memcache'
require 'json'
require 'dbi'
require 'net/ssh'
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
      if File.exists?(self.conf[:ccf])
        myconf = File.open(self.conf[:ccf]) { |f| f.read }
        customconf = eval(myconf)
        self.conf.merge!(customconf)
      end
    end
    if self.conf[:memc_srv]
      self.memcdb = MemCache.new self.conf[:memc_srv], :namespace => self.conf[:memc_ns]
    end
    Main
  end

  # The sub-classed Sinatra application
  class Main < Sinatra::Base
    register Sinatra::Bundles
    
    configure do
      set :static => true, :public => 'web'
      set :xslviews => 'views/xsl/'
      set :uripfx => Proc.new { Yodnsconf.conf[:uripfx] }
      set :started_at => Time.now.to_i
      stylesheet_bundle(:all, %w(droppy yui-reset-min))
      javascript_bundle(:all, %w(jquery/plugins/*))

      # Set request.env with application mount path
      use Rack::Config do |env|
        env['analytics_key'] = Yodnsconf.conf[:analytics_key] if Yodnsconf.conf[:analytics_key]
        env['RACK_ENV'] = ENV['RACK_ENV']
        env['path_prefix'] = uripfx
        env['link_prefix'] = uripfx
      end

      myxslfile = File.open('views/xsl/html_main.xsl') { |f| f.read }
      myxsl = XML::XSLT.new()
      myxsl.xsl = REXML::Document.new myxslfile
      set :xsl, myxsl
      set :xslfile, myxslfile
      set :noxsl, ['/raw/', '/s/img/', '/s/js/']
      set :passenv, ['PATH_INFO', 'RACK_MOUNT_PATH', 'RACK_ENV','link_prefix','path_prefix','analytics_key']

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
      :reload => ENV['RACK_ENV'] == 'development' ? true : false

    # Sinatra Helper Gems
    helpers Sinatra::XSLView
    helpers Sinatra::ModBox
    helpers Sinatra::SimpleRDiscount

    helpers do
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
        if Yodnsconf.conf[:memc_srv]
          idx_json = Yodnsconf.memcdb.get('dig_index')
        else
          idx_json = '["docunext.com"]'
        end
        return JSON.parse(idx_json)
      end
    end

    get '/' do
      'welcome'
    end
    get '/yd-zones/' do
      xml = '<root />'
      xslview xml, 'zones.xsl', { 'link_prefix' => "#{Yodnsconf.conf[:uripfx]}"  }
    end
    get '/not-yd-zones/' do
      xml = '<root />'
    end
    get '/raw/yd-zones/' do
      xml = '<root />'
      xslview xml, 'zones.xsl'
    end

    get '/raw/json/yd-domain-list' do
      content_type :json
      idx_json = get_domains.to_json
      idx_json
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

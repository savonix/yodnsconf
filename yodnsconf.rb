###
# Program:: http://www.yodnsconf.com
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
require 'xml/xslt'
require 'rack-xslview'
require 'rack/cache'
require 'sinatra/xslview'
require 'rexml/document'
require 'memcache'
require 'json'
require 'dbi'
require 'net/ssh'

# The container for the YoDNSAdmin application
module YoDNSAdmin

  class << self
    attr_accessor(:conf, :runtime, :memc, :memcdb)
  end

  # Create the app which will run
  def self.new(conf)
    self.conf = conf
    if File.exists?(self.conf[:ccf])
      myconf = File.open(self.conf[:ccf]) { |f| f.read }
      customconf = eval(myconf)
      self.conf.merge!(customconf)
    end
    Main
  end

  # The sub-classed Sinatra application
  class Main < Sinatra::Base

    configure do
      set :static, true
      set :public, 'public'
      set :xslviews, 'views/xsl/'
      set :uripfx, Proc.new { YoDNSAdmin.conf[:uripfx] }

      # Set request.env with application mount path
      use Rack::Config do |env|
        env['RACK_ENV'] = ENV['RACK_ENV'] ? ENV['RACK_ENV'] : 'development'
        env['path_prefix'] = YoDNSAdmin.conf[:uripfx]
        env['link_prefix'] = YoDNSAdmin.conf[:uripfx]
      end

      YoDNSAdmin.runtime = Hash.new
      # Setup XSL - better to do this only once
      YoDNSAdmin.runtime[:xslt]    = XML::XSLT.new()
      YoDNSAdmin.runtime[:xslfile] = File.open('views/xsl/html_main.xsl') {|f| f.read }
      YoDNSAdmin.runtime[:xslt].xsl = REXML::Document.new YoDNSAdmin.runtime[:xslfile]

      # Setup paths to remove from Rack::XSLView, and params to include
      YoDNSAdmin.runtime[:omitxsl] = ['/raw/', '/s/js/']
      YoDNSAdmin.runtime[:passenv] = ['PATH_INFO', 'RACK_MOUNT_PATH', 'RACK_ENV','link_prefix','path_prefix']

      # Used in runtime/info
      YoDNSAdmin.runtime['started_at'] = Time.now.to_i
    end
    configure :development do
      set :logging, false
      set :reload_templates, true # This does work! :-)
    end
    configure :demo do
      set :logging, true
      set :reload_templates, false # This does work! :-)
    end

    configure :test do
      #
    end

    # Rewrite app url patterns to static files
    use Rack::Rewrite do
      rewrite YoDNSAdmin.conf[:uripfx]+'welcome', '/s/xhtml/welcome.html'
      rewrite YoDNSAdmin.conf[:uripfx]+'cma-alias-edit', '/s/xhtml/alias_form.html'
      rewrite %r{#{YoDNSAdmin.conf[:uripfx]}cma-mailbox-edit/(.*)}, '/s/xhtml/mailbox_form.html?email=$1'
      rewrite %r{#{YoDNSAdmin.conf[:uripfx]}cma-import-(.*)}, '/s/xhtml/import_form.html?type=$1'
      rewrite %r{#{YoDNSAdmin.conf[:uripfx]}cma-spamassassin-edit}, '/s/xhtml/spam_spamassassin_form.html?type=$1'
      rewrite YoDNSAdmin.conf[:uripfx]+'cma-mailbox-edit', '/s/xhtml/mailbox_form.html'
      rewrite YoDNSAdmin.conf[:uripfx]+'cma-server-edit', '/s/xhtml/server_form.html'
      rewrite YoDNSAdmin.conf[:uripfx]+'cma-domain-edit', '/s/xhtml/domain_form.html'
    end

    use Rack::Cache,
      :verbose     => false,
      :metastore   => 'file:/tmp/cache/rack/meta',
      :entitystore => 'file:/tmp/cache/rack/body'

    # Use Rack-XSLView
    use Rack::XSLView, :myxsl => YoDNSAdmin.runtime[:xslt], :noxsl => YoDNSAdmin.runtime[:omitxsl], :passenv => YoDNSAdmin.runtime[:passenv]

    # Sinatra Helper Gems
    helpers Sinatra::XSLView

    helpers do
      # Just the usual Sinatra redirect with App prefix
      def mredirect(uri)
        redirect YoDNSAdmin.conf[:uripfx]+uri
      end
      def markdown(template, options={})
        output = render :md, template, options
        '<div>'+output+'</div>'
      end
    end

    get '/' do
      "hi"
    end

  end

end

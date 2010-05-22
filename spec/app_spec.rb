###
# Program: http://www.docunext.com
# Component: app_spec.rb
# Copyright: Savonix Corporation
# Author: Albert L. Lash, IV
# License: Gnu Affero Public License version 3
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
require File.dirname(__FILE__) + '/spec_helper'

describe "YoDNSConf" do
  include Rack::Test::Methods

  def app
    conf = Hash[:uripfx, '/']
    myapp = Yodnsconf.new(conf)
    @app ||=   myapp
  end
  myurls = Array.new
  myurls << '/raw/json/yd-domain-list'
  myurls << '/s/css/stylesheet.css'


  myurls.each { |url|
    it "should respond to #{url}" do
      get url
      last_response.should be_ok
    end
  }

end
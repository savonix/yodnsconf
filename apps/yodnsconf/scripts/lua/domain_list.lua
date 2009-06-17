--[[ <!--
Program: YoDNSConf
Component: domain_list.lua
Copyright: Savonix Corporation
Author: Albert L. Lash, IV
License: Gnu Affero Public License version 3
http://www.gnu.org/licenses

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU Affero General Public License as published by
the Free Software Foundation; either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License
along with this program; if not, see http://www.gnu.org/licenses
or write to the Free Software Foundation, Inc., 51 Franklin Street,
Fifth Floor, Boston, MA 02110-1301 USA
--> --]]
require "luasql.mysql"
require "config"

env = assert (luasql.mysql())
con = assert (env:connect(dbconfig["database"],dbconfig["username"],dbconfig["password"],dbconfig["hostname"]))

function rows (connection, sql_statement)
  local cursor = assert (connection:execute (sql_statement))
  return function ()
    return cursor:fetch()
  end
end


for origin,ns,mbox,refresh,retry,minimum,ttl,expire,serial,id in rows (con, "select origin,ns,mbox,refresh,retry,minimum,ttl,expire,serial,id from soa WHERE serial>="..os.date("%Y%m%d00")) do
  myzone = "$ORIGIN "..origin.."\n".."$TTL 12h\n"
  myzone = myzone..origin.." IN SOA "..ns.." "..mbox.." ("
  myzone = myzone.."\n\t\t"..serial
  myzone = myzone.."\n\t\t"..refresh
  myzone = myzone.."\n\t\t"..retry
  myzone = myzone.."\n\t\t"..expire
  myzone = myzone.."\n\t\t"..minimum.."\n\t\t)"
  for name,data,ttl in rows (con, "select name,data,ttl from rr WHERE zone="..id) do
    myzone = myzone..name.." IN "..ttl
    if (type == "MX") then
        myzone = myzone .." "..aux
    end
    if (type == "SRV") then
        myzone = myzone .." "..aux.." "..weight.." "..port
    end
    if (type == "TXT") then
        myzone = myzone .." \""..data.."\""
    else
        myzone = myzone.." "..data
    end
    myzone = myzone.."\n"
  end
  F = io.open("zones/"..origin..".zone.","w")
  F:write(string.format ("%s", myzone))
  F:close()
end

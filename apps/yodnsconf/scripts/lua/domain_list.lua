require "luasql.mysql"
require "config"

env = assert (luasql.mysql())
con = assert (env:connect(dbconfig["database"],dbconfig["username"],dbconfig["password"],dbconfig["host"]))

function rows (connection, sql_statement)
  local cursor = assert (connection:execute (sql_statement))
  return function ()
    return cursor:fetch()
  end
end

for domain, transport in rows (con, "select origin from soa WHERE serial>="..os.date("%Y%m%d00")) do
  print (string.format ("%s", domain).."zone.")
end

#!/usr/bin/ruby
load "config.rb"
require 'dbi'
require 'dbm'


begin
    # connect to the MySQL server
    dbh = DBI.connect("DBI:Mysql:"+$dbconfig['database']+":"+$dbconfig['hostname'], $dbconfig["username"], $dbconfig['password'])
rescue DBI::DatabaseError => e
    puts "An error occurred"
    puts "Error code: #{e.err}"
    puts "Error message: #{e.errstr}"
end

sth = dbh.prepare("SELECT id,origin FROM soa WHERE zone_group_id=2 ORDER BY origin")

begin
    sth.execute()
    sth.fetch do |row|
        domain = row[1].gsub(/\.$/,'')
        puts "#{row[0]} #{domain}"
    end
rescue DBI::DatabaseError => e
    puts "An error occurred"
    puts "Error code: #{e.err}"
    puts "Error message: #{e.errstr}"
    dbh.disconnect if dbh
end





require 'rubygems'
require 'rake'
require 'spec/rake/spectask'


task :test => :spec
task :default => :spec
@application = 'yodnsconf'

begin
  require "vlad"
  Vlad.load(:app => nil, :scm => "git")
rescue LoadError
  # do nothing
end

namespace :vlad do
  remote_task :restart do
    run "sudo svc -d /service/#{application}"
    run "sudo svc -u /service/#{application}"
  end
  remote_task :fix do
    run "mkdir -p #{deploy_to}/current/public/d/xhtml"
    run "chmod 0777 #{deploy_to}/current/public/d/xhtml"
  end
  remote_task :logtail do
    run "tail /tmp/webapps/#{application}.log -n 100"
  end
  task :send_conf do
    command = "rsync config/customconf.rb #{domain}:#{deploy_to}/current/config/"
    puts `#{command}`
  end
  task :deploy => [:update, :restart, :fix, :send_conf]
end

task :geturls do
  command = %q~ echo "myurls = Array.new" && cat ~ + @application + %q~.rb | grep -E "get|r301|rewrite " | sed -r "s/    get //g" | sed -r "s/ do//g" | sed -r "s/[^\+]*\+'([^']+').+/'\/\1/g" | sort | uniq | awk '{print "myurls << " $1}'r~
  puts `#{command}`
end


Spec::Rake::SpecTask.new(:spec) do |t|
  t.spec_files = Dir.glob('spec/*_spec.rb')
  t.spec_opts << '--format specdoc'
  t.rcov = true
  t.rcov_opts = ['--exclude', '/var/lib/gems,/usr/bin/spec,spec']
end
begin
  require 'vlad'
  Vlad.load :scm => :git
rescue
 # do nothing
end

namespace :vlad do
  remote_task :bundle do
    run "cd #{deploy_to}/current/ && /usr/local/rvm/gems/ruby-1.9.2-p180/bin/bundle install --path vendor"
  end
  remote_task :restart do 
    run "sudo /sbin/service httpd restart" 
  end 
  task :deploy => [:update, :bundle, :restart]
end

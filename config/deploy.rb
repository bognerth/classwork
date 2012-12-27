require "bundler/capistrano"

set :scm, :git
set :repository, 'git://github.com/bognerth/classwork.git'
set :branch, "master"

server "188.138.121.50", :web, :app, :db, :primary => true


set :user, "railsadmin"
set :group, "railsadmin"
set :deploy_to, "/var/classwork"
set :use_sudo, false
set :deploy_via, :copy
set :copy_strategy, :export

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  desc "Restart the app"
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
  desc "Copy the Database.yml file into the latest release"
  task :copy_in_database_yml do
    run "cp #{shared_path}/config/database.yml #{latest_release}/config/"
  end
end

before "deploy:assets:precompile", "deploy:copy_in_database_yml"


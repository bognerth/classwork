require "bundler/capistrano"
require "rvm/capistrano"
set :rvm_ruby_string, '1.9.3'

server "188.138.121.50", :web, :app, :db, primary: true

set :application, "classwork"
set :user, "tb"
set :deploy_to, "/var/www/#{application}"
set :deploy_via, :remote_cache
set :use_sudo, false

set :scm, "git"
set :repository, "git@github.com:bognerth/#{application}.git"
set :branch, "master"

default_run_options[:pty] = true
ssh_options[:forward_agent] = true

after 'deploy', 'deploy:cleanup'
after 'deploy', 'deploy:migrate'

namespace :deploy do
  %w[start stop restart reload].each do |command|
    desc "#{command} unicorn server"
    task command, roles: :app, except: {no_release: true} do
      run "sudo /etc/init.d/unicorn_#{application} #{command}"
    end
  end

  # Use this if you know what you are doing.
  #
  # desc "Zero-Downtime restart of Unicorn"
  # task :restart, :except => { :no_release => true } do
  #   run "sudo /etc/init.d/unicorn_#{application} reload"
  # end
end


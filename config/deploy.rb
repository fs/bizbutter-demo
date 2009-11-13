set :application, "bizbutter-demo"
set :repository, "git@github.com:fs/#{application}"
set :scm, :git
set :branch, "master"
set :deploy_via, :remote_cache
set :deploy_to, "/var/www/rails/#{application}"
set :use_sudo, false

server "demo.flatsourcing.com", :app, :web, :db, :primary => true

after "deploy:symlink", "deploy:symlink_configs"

namespace :deploy do
  desc "Restarting mod_rails with restart.txt"
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{current_path}/tmp/restart.txt"
  end

  [:start, :stop].each do |t|
    desc "#{t} task is a no-op with mod_rails"
    task t, :roles => :app do ; end
  end
  
  desc "Symlink config files"
  task :symlink_configs, :roles => :db do
    run "ln -sf #{shared_path}/config/database.yml #{current_path}/config/database.yml"
  end
end

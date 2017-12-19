lock "3.9.1"

set :application,   'nomini'
set :repo_url,      'git@github.com:kimuray/nomini_reserve.git'
set :branch,        ENV['BRANCH'] || 'master'
set :deploy_to,     '/var/www/nomini'
set :linked_files,  %w(config/secrets.yml config/database.yml .env customer_sheet.csv)
set :linked_dirs,   %w(log tmp/pids tmp/cache tmp/sockets)
set :keep_releases, 5
set :rbenv_ruby,    '2.4.2'
set :rbenv_type,    :system
set :log_level,     :debug

namespace :deploy do
  desc 'Restart application'
  task :restart do
    invoke 'unicorn:restart'
  end

  desc 'Create database'
  task :db_create do
    on roles(:db) do |host|
      with rails_env: fetch(:rails_env) do
        within current_path do
          execute :bundle, :exec, :rake, 'db:create'
        end
      end
    end
  end

  desc 'Run seed'
  task :seed do
    on roles(:app) do
      with rails_env: fetch(:rails_env) do
        within current_path do
          execute :bundle, :exec, :rake, 'db:seed'
        end
      end
    end
  end

  after :publishing, :restart
  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
    end
  end
end

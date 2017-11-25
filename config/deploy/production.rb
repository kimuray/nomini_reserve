set :stage, :production
set :rails_env, 'production'
set :branch, ENV['BRANCH'] || 'master'
set :whenever_roles, :batch
set :whenever_environment, :production

role :app, %w{ app@app1.nomini.jp }
role :web, %w{ app@app1.nomini.jp }
role :db,  %w{ app@app1.nomini.jp }
role :batch, %w{ app@app1.nomini.jp }

set :stage, :production
set :rails_env, 'production'
set :branch, ENV['BRANCH'] || 'master'

role :app, %w{ app@app1.nomini.jp }
role :web, %w{ app@app1.nomini.jp }
role :db,  %w{ app@app1.nomini.jp }

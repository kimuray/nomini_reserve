set :stage, :production
set :rails_env, 'production'
set :branch, ENV['BRANCH'] || 'master'

role :app, %w{ app@reservation.nomini.jp }
role :web, %w{ app@reservation.nomini.jp }
role :db,  %w{ app@reservation.nomini.jp }

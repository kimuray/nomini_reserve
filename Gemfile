source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

# Core
gem 'rails', '~> 5.1.3'

# Model/DB
gem 'mysql2', '>= 0.3.18', '< 0.5'
gem 'jbuilder', '~> 2.5'

# Front
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'bootstrap_form'
gem 'kaminari'

# Server
gem 'unicorn'

# Authentication
gem 'devise', '~> 4.3'
gem 'omniauth', '~> 1.6'
gem 'omniauth-facebook', '~> 4.0'

# Image
gem 'mini_magick'
gem 'carrierwave'
gem 'fog'

# API
gem 'payjp'

# Util
gem 'dotenv-rails'
gem 'config'
gem 'enum_help'
gem 'whenever', require: false

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'capybara', '~> 2.13'
  gem 'selenium-webdriver'
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'pry-rails'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'faker'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'letter_opener'
  gem 'capistrano'
  gem 'capistrano-rails'
  gem 'capistrano-bundler'
  gem 'capistrano3-unicorn'
  gem 'capistrano-rbenv'
end

group :test do
  gem 'ffaker'
  gem 'database_cleaner'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

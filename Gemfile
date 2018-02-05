source 'https://rubygems.org'
ruby "2.4.1"

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.0.4'
gem 'pg', '~> 0.18'
gem 'puma', '~> 3.0'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'devise'
gem 'jquery-rails'
gem 'turbolinks', '~> 5'
gem 'bootstrap-sass'
gem "recaptcha", require: "recaptcha/rails"
gem 'faker'
gem "simple_calendar", "~> 2.0"
gem 'google-api-client', require: 'google/apis/calendar_v3'
gem 'oauth2'
gem 'httparty'
gem 'dotenv-rails'
gem 'activerecord-session_store'

group :development, :test do
  gem 'byebug', platform: :mri
end

group :test do
  gem 'rspec-rails'
  gem 'shoulda-matchers'
  gem 'factory_girl_rails'
  gem 'simplecov'
  gem 'rails-controller-testing'
  gem 'database_cleaner'
  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'chromedriver-helper'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.0.5'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'capistrano',         require: false
  gem 'capistrano-rvm',     require: false
  gem 'capistrano-rails',   require: false
  gem 'capistrano-bundler', require: false
  gem 'capistrano3-puma',   require: false
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

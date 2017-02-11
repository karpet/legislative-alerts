source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.0.1'
gem 'puma', '~> 3.0'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'jquery-rails'
gem 'jbuilder', '~> 2.5'
group :development, :test do
end

group :development do
  gem 'listen', '~> 3.0.5'
end

gem 'rails_12factor'
gem 'haml-rails'
group :development, :test do
  gem 'sqlite3'
  gem 'rspec', '~> 3.5.0'
  gem 'rspec-rails', '~> 3.5.0'
  gem 'factory_girl_rails'
  gem 'capybara'
#  gem 'cucumber-rails', branch: 'rails-5', require: false
#  gem 'guard-rspec', '~> 4.6.4', require: false
#  gem 'guard-cucumber'
  gem 'database_cleaner'
  gem 'launchy'
  gem 'vcr'
  gem 'faker'
  gem 'dotenv-rails'
  gem 'rdiscount'
  gem 'rails-controller-testing'
  gem 'better_errors'
  gem 'binding_of_caller'
end

group :test do
  gem 'webmock'
end

group :production do
  gem 'pg'
#  gem 'lograge'
end

gem 'bootstrap-sass'
gem 'modernizr-rails'
gem 'meta-tags', require: 'meta_tags'
gem 'responders', '~> 2.0'
gem 'bh'
gem 'simple_form'
gem 'gibbon'
gem 'premailer-rails'
gem 'nokogiri'
gem 'devise', '~> 4.2'
gem 'cancancan'
gem 'omniauth'
gem 'omniauth-oauth2', '1.3.1'
gem 'omniauth-facebook'
gem 'omniauth-twitter'
gem 'twitter'
gem 'omniauth-github'
gem 'octokit'
gem 'omniauth-google-oauth2'
gem 'google-api-client', '0.9.28', require: ['google/apis/plus_v1']

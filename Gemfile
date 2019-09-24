source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

#ruby '2.3.3'
ruby '2.6.1'

gem 'bh'
gem 'bootstrap-sass'
gem 'cancancan'
gem 'daemons'
gem 'delayed_job_active_record'
gem 'devise', '~> 4.7.1'
gem 'dotenv-rails'
gem 'erubi'
gem 'gibbon'
gem 'google-api-client', '0.9.28', require: ['google/apis/plus_v1']
gem 'haml-rails'
gem 'jbuilder', '~> 2.5'
gem 'jquery-rails'
gem 'meta-tags', require: 'meta_tags'
gem 'modernizr-rails'
gem 'nokogiri'
gem 'octokit'
gem 'omniauth'
gem 'omniauth-facebook'
gem 'omniauth-github'
gem 'omniauth-google-oauth2'
gem 'omniauth-oauth2', '1.3.1'
gem 'omniauth-twitter'
gem 'openstates', git: 'https://github.com/legalerts/ruby-openstates.git', branch: 'master'
gem 'pg', '~> 0.21.0'
gem 'premailer-rails'
gem 'puma', '~> 3.0'
gem 'rails'
gem 'rails_12factor'
gem 'responders', '~> 2.0'
gem 'sass-rails', '~> 5.0'
gem 'simple_form'
gem 'twitter'
gem 'uglifier', '>= 1.3.0'

group :development do
  gem 'listen', '~> 3.0.5'
end

group :development, :test do
  gem 'rspec', '~> 3.5.0'
  gem 'rspec-rails', '~> 3.5.0'
  gem 'factory_bot_rails'
  gem 'capybara'
  gem 'database_cleaner'
  gem 'launchy'
  gem 'mailcatcher'
  gem 'rails-controller-testing'
#  gem 'better_errors'
#  gem 'binding_of_caller'
#  gem 'sinatra', '2.0.0.beta2'
  gem 'timecop'
end

group :test do
  gem 'faker'
  gem 'webmock'
end

group :production do
  gem 'lograge'
end

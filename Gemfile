# frozen_string_literal: true

source "https://rubygems.org"

git_source(:github) {|repo_name| "https://github.com/#{repo_name}" }

# gem "rails"

gem "rake", "~> 12.3"

gem "sinatra-websocket", "~> 0.3.1"

gem "sinatra", "~> 2.0"
gem "activerecord", "~> 5.2"
gem "sinatra-activerecord", "~> 2.0"


group :development do 
    gem 'pry'
    gem "sqlite3", "~> 1.4"
end

group :test do 
   gem "rspec", "~> 3.8"
   gem "capybara", "~> 3.28"
   gem "selenium-webdriver", "~> 3.142"
end

group :production do
    gem "pg", "~> 1.1"
    gem "activerecord-postgresql-adapter", "~> 0.0.1"
end
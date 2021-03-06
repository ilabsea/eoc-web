# frozen_string_literal: true

source "https://rubygems.org"

git_source(:github) { |repo| "https://github.com/#{repo}.git" }


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
# gem 'rails', '~> 5.1.7'
gem "rails", "~> 6.0.2.1"
# Use postgresql as the database for Active Record
gem "pg", ">= 0.18", "< 2.0"
# Use Puma as the app server
gem "puma", "~> 4.3"
# Use SCSS for stylesheets
gem "sass-rails", "~> 5.0"
# Use Uglifier as compressor for JavaScript assets
gem "uglifier", ">= 1.3.0"
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby
gem "mini_racer", platforms: :ruby

# Use CoffeeScript for .coffee assets and views
gem "coffee-rails", "~> 5.0"
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem "turbolinks", "~> 5"
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem "jbuilder", "~> 2.5"
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use ActiveStorage variant
# gem 'mini_magick', '~> 4.8'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

gem "bootsnap", ">= 1.1.0", require: false

gem "haml-rails",     "~> 2.0"
gem "jquery-rails",   "~> 4.3.5"
gem "bootstrap",      "~> 4.3.1"
gem "simple_form",    "~> 5.0.0"
gem "carrierwave",    "~> 2.0"
gem "devise", "~> 4.7.1"

gem "elasticsearch-model",        "~> 7.0.0"
gem "elasticsearch-rails",        "~> 7.0.0"
gem "searchkick", "~> 4.1.1"

gem "roo", "~> 2.8.0"
gem "roo-xls"

gem "rubyzip", ">= 1.0.0" # will load new rubyzip version
gem "zip-zip" # will load compatibility for old rubyzip API.

gem "awesome_nested_set", "~> 3.2"
gem "fcm", "~> 0.0.6"

gem "pagy", "~> 3.6.0"

gem "webpacker"
gem "sidekiq", "~> 6.0.3"
gem "pdf-reader", "~> 2.4.0"

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
  # Adds support for Capybara system testing and selenium driver
  gem "capybara", ">= 2.15"
  gem "selenium-webdriver"
  gem "rspec-rails", "~> 4.0.0.beta3"
  gem "factory_bot_rails"
  gem "ffaker", "~> 2.9.0"
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem "web-console", ">= 3.3.0"
  gem "listen", ">= 3.0.5", "< 3.2"
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
  gem "annotate"

  gem "guard-rspec", require: false
  gem "rubocop-rails"
  gem "rubocop-performance"
  gem "pry-rails", "~> 0.3.9"
  gem "solargraph"
end

group :test do
  # Easy installation and use of chromedriver to run system tests with Chrome
  gem "webdrivers", "~> 4.1.2"
  gem "database_cleaner"
  gem "shoulda-matchers"
  gem "rails-controller-testing"
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]

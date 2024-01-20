# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }
ruby '3.3.0'

# Framework and Server
gem 'puma', '~> 6.4'
gem 'rails', '~> 7.1.3'
gem 'sprockets-rails', '~> 3.4'


# Database and db utils
gem 'pg', '~> 1.5'
gem 'friendly_id', '~> 5.4.0'
gem 'uuid_v6', '~> 0.1.1'

# JavaScript and CSS
gem 'importmap-rails', '~> 1.2'
gem 'stimulus-rails', '~> 1.3'
gem 'tailwindcss-rails', '~> 2.0.30'
gem 'turbo-rails', '~> 1.5.0'

# Redis
gem 'redis', '~> 5.0'

# Caching and Optimization
gem 'bootsnap', require: false
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw]

# Authentication and Authorization
gem 'authentication-zero', '~> 2.16.36'
gem 'bcrypt', '~> 3.1.7'
gem 'devise', '~> 4.9'
gem 'omniauth', '~> 2.1'
gem 'omniauth-discord', '~> 1.1'
gem 'omniauth-rails_csrf_protection', '~> 1.0'

# UI and Front-end
gem 'font-awesome-sass', '~> 6.4.0'
gem 'slim-rails', '~> 3.6.2'

# Image Processing
gem 'image_processing', '~> 1.2'

# Development and Test
group :development, :test do
  gem 'debug', platforms: %i[mri mingw x64_mingw]
  gem 'dotenv-rails', '~> 2.8.1'
  gem 'pry', '~> 0.14.1'
end

group :development do
  gem 'actual_db_schema'
  gem 'annotate', git: 'https://github.com/ctran/annotate_models.git'
  gem 'bcrypt_pbkdf', '~> 1.1'
  gem 'better_errors', '~> 2.10'
  gem 'binding_of_caller', '~> 1.0'
  gem 'brakeman', '~> 6.0'
  gem 'bundler-audit', '~> 0.9.1'
  gem 'hotwire-livereload', '~> 1.3'
  gem 'i18n-tasks', '~> 1.0.13'
  gem 'letter_opener', '~> 1.8.1'
  gem 'letter_opener_web', '~> 2.0.0'
  gem 'rack-mini-profiler', '~> 3.1'
  gem 'reek', '~> 1.3'
  gem 'rubocop', '~> 1.57'
  gem 'rubocop-performance', '~> 1.19'
  gem 'rubocop-rails', '~> 2.22'
  gem 'solargraph', '~> 0.49'
  gem 'web-console', '~> 4.2.0'
end

group :test do
  gem 'capybara', '~> 3.39.2'
  gem 'capybara-screenshot', '~> 1.0.18'
  gem 'cuprite', '~> 0.14.3'
  gem 'factory_bot_rails', '= 6.2'
  gem 'rails-controller-testing', '~> 1.0.5'
  gem 'rspec-mocks', '~> 3.12.6'
  gem 'rspec-rails', '~> 6.0.3'
  gem 'shoulda-matchers', '~> 5.3.0', require: false
  gem 'webmock', '~> 3.19.1'
end

# dry stack
gem 'dry-initializer', '~> 3.1'
gem 'dry-monads', '~> 1.6'
gem 'dry-validation', '~> 1.10'

# State Machine and Utilities
gem 'aasm', '~> 5.1', '>= 5.1.1'
gem 'class_variants', '~> 0.0.6'
gem 'http', '~> 5.1.1'
gem 'inline_svg', '~> 1.9'
gem 'kaminari', '~> 1.2.1'
gem 'meta-tags', '~> 2.18'
gem 'rails-i18n', '~> 7.0.8'
gem 'recaptcha', '~> 5.16'
gem 'sidekiq', '~> 7.2'
gem 'sidekiq-scheduler', '~>5.0.3'
gem 'view_component', '~> 3.7'

# File Upload
gem 'carrierwave', '~> 3.0'
gem 'carrierwave-i18n', '~> 0.2.0'

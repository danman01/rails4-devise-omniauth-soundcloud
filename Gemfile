source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.2'

# Use postgresql as the database for Active Record
gem 'pg'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'

# authentication using Devise (email / password) and omniauth (oauth)
gem "devise"
gem "omniauth-soundcloud"

# set env variables within config/application.yml
gem "figaro"

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

# User roles. ex: User.first.add_role!("admin")
gem "easy_roles"

# manage meta tags
gem "meta-tags", :require => "meta_tags"

# error notification. TODO - setup https://github.com/smartinez87/exception_notification
gem 'exception_notification', git: "git://github.com/smartinez87/exception_notification.git"

# nice rails urls for seo and readability
gem "friendly_id", '~> 5.0.0'

# use foreman start to startup multiple processes at once (i.e. rails and delayed job queue)
gem "foreman"

# admin panel, available at /admin
gem "rails_admin"

# cron scheduling for the server. See config/schedule
gem 'whenever', :require =>false

# tool to party
gem 'httparty'

# app permissions. set in models/ability.rb
gem "cancan", git: "https://github.com/nukturnal/cancan.git"

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

group :development do
  # preload rails app to speed things up
  gem "spring"
  gem "spring-commands-rspec"
  # better formatting of errors
  gem "better_errors"
  # do not output so much about assets to console
  gem "quiet_assets"
  # debugging tool: https://github.com/banister/binding_of_caller
  gem "binding_of_caller"
end

group :development, :test do
  gem 'rspec-rails'
  gem "faker"
  gem "factory_girl_rails", "~> 4.0"
end

group :test do
  gem 'capybara'
  gem "launchy"
  gem "database_cleaner"
end

# Rails view utilities

# use country-select with priority countries like: country_select("user", "country_name", [ "United Kingdom", "France", "Germany" ])
gem 'country-select'

# Use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.1.2'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano', group: :development


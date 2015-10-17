source 'https://rubygems.org'

gemspec

gem 'byebug', group: [:development, :test]

version = ENV["RAILS_VERSION"]
#gem 'rails', version ? "~> #{version}" : '= 4.2.0.beta2'
gem 'rails', version ? "~> #{version}" : '~> 4.2'
gem 'jquery-rails'

group :test do
  gem "capybara"
  gem 'database_cleaner'
end

group :development, :test do
  gem "sqlite3"
  gem 'watchr'
  gem 'simplecov', require: false
  gem 'slim'
end

source 'https://rubygems.org'

gemspec

version = ENV["RAILS_VERSION"]
gem 'rails', version ? "~> #{version}" : '~> 4.2'
gem 'jquery-rails'

group :test do
  gem 'observr'
  gem 'simplecov', require: false
  gem "capybara"
  gem 'database_cleaner'
end

group :development, :test do
  gem "sqlite3"
  gem 'slim'
  gem 'byebug'
end

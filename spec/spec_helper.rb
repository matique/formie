require 'simplecov'
SimpleCov.start "rails" do
#  add_filter '/application_controller.rb/'
end

require 'spork'
require 'bundler'
Bundler.setup :default, :development, :test

ActiveRecord::Migration.check_pending! if defined?(ActiveRecord::Migration)

Spork.prefork do
  ENV["RAILS_ENV"] ||= 'test'
#  require File.expand_path("../../config/environment", __FILE__)
  require File.expand_path("../../spec/dummy/config/environment", __FILE__)
  require 'rspec/rails'

  RSpec.configure do |config|
    config.mock_with :rspec
    config.fixture_path = "#{::Rails.root}/spec/fixtures"
#    config.use_transactional_fixtures = false
# increases speed; not sure why
    config.use_transactional_fixtures = true

    config.include(Capybara::DSL)
    config.infer_spec_type_from_file_location!
    ActiveSupport::Dependencies.clear
  end
end

Spork.each_run do
  load "#{Rails.root}/config/routes.rb"
  Dir["#{Rails.root}/app/**/*.rb"].each { |f| load f }
end

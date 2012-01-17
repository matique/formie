require 'rubygems'
require 'spork'

Spork.prefork do
  # Loading more in this block will cause your tests to run faster. However, 
  # if you change any configuration or code from libraries loaded here, you'll
  # need to restart spork for it take effect.
  
  ENV["RAILS_ENV"] = "test"

  require File.expand_path("../dummy/config/environment.rb",  __FILE__)
  require "rails/test_help"
  require "rspec/rails"

#  ActionMailer::Base.delivery_method = :test
#  ActionMailer::Base.perform_deliveries = true
#  ActionMailer::Base.default_url_options[:host] = "test.com"

  Rails.backtrace_cleaner.remove_silencers!

  # Configure capybara for integration testing
  require "capybara/rails"
  Capybara.default_driver   = :rack_test
  Capybara.default_selector = :css

  # Run any available migration
  ActiveRecord::Migrator.migrate File.expand_path("../dummy/db/migrate/", __FILE__)

  # Load support files
  Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

  RSpec.configure do |config|
    # Remove this line if you don't want RSpec's should and should_not
    # methods or matchers
    require 'rspec/expectations'
    config.include RSpec::Matchers

    # == Mock Framework
    config.mock_with :rspec
  end
end


Spork.each_run do
  # This code will be run each time you run your specs.
  Dir["#{File.dirname(__FILE__)}/../lib/controllers/*.rb"].each { |f| load f }

  unless ENV['COVERAGE'].nil?
    require 'simplecov'
    SimpleCov.start 'rails' do
      coverage_dir 'coverage'
    end
  end
end


# --- Instructions ---
# - Sort through your spec_helper file. Place as much environment loading 
#   code that you don't normally modify during development in the 
#   Spork.prefork block.
# - Place the rest under Spork.each_run block
# - Any code that is left outside of the blocks will be ran during preforking
#   and during each_run!

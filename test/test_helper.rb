require 'simplecov'
SimpleCov.start "rails" do
  add_filter '/application_controller.rb/'
end

# Configure Rails Environment
ENV["RAILS_ENV"] = "test"

require 'combustion'
Combustion.initialize! :active_record, :action_controller

require "rails/test_help"
require 'minitest/autorun'
require 'capybara/rails'
require 'slim'

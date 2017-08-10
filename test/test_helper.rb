require 'simplecov'
SimpleCov.start "rails" do
  add_filter '/application_controller.rb/'
end

# Configure Rails Environment
ENV["RAILS_ENV"] = "test"

require 'bundler'
Bundler.require :default, :development

require 'combustion'
#Combustion.initialize! :active_record, :action_view
#Combustion.initialize! :active_record, :action_view, :action_controller
#Combustion.initialize! :active_record, :action_controller
Combustion.initialize! :all

require "rails/test_help"
require 'minitest/autorun'
require 'capybara/rails'
require 'slim'

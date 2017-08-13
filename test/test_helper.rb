#require 'simplecov'
#SimpleCov.start do
#  add_filter '/test/'
#end

require "combustion"
Combustion.path = "test/internal"
Combustion.initialize! :all

require 'rails/test_help'
require 'minitest/autorun'
require 'capybara/rails'

#class ActiveSupport::TestCase
#  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
#  fixtures :all
#
#  # Add more helper methods to be used by all tests here...
#end

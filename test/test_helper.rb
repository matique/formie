if ENV['COVERAGE']
  require 'simplecov'
  SimpleCov.start do
    add_filter '/test/'
  end
end

require "combustion"
Combustion.path = "test/internal"
Combustion.initialize! :all

require 'rails/test_help'
require 'minitest/autorun'
require 'minitest/benchmark'
require 'capybara/rails'

if ENV["COVERAGE"]
  require "simplecov"
  SimpleCov.start do
    add_filter "/test/"
  end
end

require "combustion"
Combustion.path = "test/internal"
Combustion.initialize! :active_record

require "capybara/rails"
require "minitest/autorun"
require "minitest/benchmark"
require "rails/test_help"

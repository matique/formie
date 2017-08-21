require 'bundler/setup'
Bundler::GemHelper.install_tasks


# https://github.com/pat/combustion/issues/13
require "rails"
require "combustion"
require "active_record/railtie"
#Bundler.require :default, Rails.env


Bundler.require
#require "combustion"
Combustion.initialize!
Combustion::Application.load_tasks


require 'rake/testtask'

Rake::TestTask.new(:test) do |t|
  t.libs << 'lib'
  t.libs << 'test'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = false
end

task default: :test

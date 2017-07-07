$:.push File.expand_path('../lib', __FILE__)
require 'formie/version'

Gem::Specification.new do |s|
  s.name        = 'formie'
  s.version     = Formie::VERSION
  s.summary     = 'Formie is like a helper, but uses the notation of a partial.'
  s.description = <<-'END'
    Formie implements low level template-based helpers. It injects
    the formies into the ActionView module. The form-bounded as well as
    the unbounded templates are supported. Still, the ActionView
    functionality (e.g. text_field) is kept untouched.
  END
  s.authors     = ['Dittmar Krall']
  s.email       = ['dittmar.krall@matique.de']
  s.homepage    = 'http://matique.de'

  s.license     = 'MIT'
  s.platform    = Gem::Platform::RUBY

  s.files         = `git ls-files -z`.split("\x0")
#  s.executables   = s.files.grep(%r{^bin/}) { |f| File.basename(f) }
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})
  s.require_paths = ['lib']

  s.add_runtime_dependency 'rails'

  s.add_development_dependency 'bundler'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'slim'

  s.add_development_dependency 'combustion', '0.5.5'
  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'simplecov'
  s.add_development_dependency 'minitest'
  s.add_development_dependency 'capybara'
end

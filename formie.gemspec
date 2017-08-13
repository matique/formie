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
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})
  s.require_paths = ['lib']

  s.add_development_dependency 'bundler', '~> 1'
  s.add_development_dependency 'capybara', '~> 2'
  s.add_development_dependency 'combustion', '~> 0'
  s.add_development_dependency 'minitest', '~> 5'
  s.add_development_dependency 'rake', '~> 12'
#  s.add_development_dependency 'slim', '~> 3'
  s.add_development_dependency 'sqlite3', '~> 1'
end

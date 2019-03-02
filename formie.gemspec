lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'formie/version'

Gem::Specification.new do |s|
  s.name        = 'formie'
  s.version     = Formie::VERSION
  s.summary     = 'Formie is like a Rails helper, but uses the notation of a partial.'
  s.description = <<-'END'
    Formie implements low level template-based Rails helpers. It injects
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

  s.add_development_dependency 'bundler'
  s.add_development_dependency 'rake', '~> 12'
  s.add_development_dependency 'appraisal', '~> 2'
  s.add_development_dependency 'combustion', '~> 0'
end

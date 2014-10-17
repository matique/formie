$:.push File.expand_path("../lib", __FILE__)

require 'formie/version'

Gem::Specification.new do |s|
  s.name        = "formie"
  s.version     = Formie::VERSION
  s.summary     = "Formie is like a helper, but uses the notation of a partial."
  s.description = <<-'END'
    Formie implements low level template-based helpers. It injects
    the formies into the ActionView module. The form-bounded as well as
    the unbounded templates are supported. Still, the ActionView
    functionality (e.g. text_field) is kept untouched.
  END
  s.authors     = ['Dittmar Krall']
  s.email       = ['dittmar.krall@matique.de']
  s.homepage    = 'http://matique.de'

  s.license     = "MIT"

  s.files = Dir["{config,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["test/**/*"]

#  s.add_dependency "rails", "~> 4.2.0.beta2"
  s.add_dependency "rails", "~> 4.1"

#  s.add_development_dependency "sqlite3"
#  s.add_development_dependency 'minitest'
#  s.add_development_dependency 'capybara'
end

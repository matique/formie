lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require 'formie/version'

Gem::Specification.new do |s|
  s.name        = "formie"
  s.version     = Formie::VERSION
  s.platform    = Gem::Platform::RUBY
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

  files  = Dir["{app,lib,config}/**/*.rb"]
  files += %w{Gemfile MIT-LICENSE README.md formie.gemspec}
  s.files       = files
  s.require_paths = ["lib"]

  s.add_dependency "rails", "~> 3.1.0"
  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "capybara"
end

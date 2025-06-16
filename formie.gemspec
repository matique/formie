lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "formie/version"

Gem::Specification.new do |s|
  s.name = "formie"
  s.version = Formie::VERSION
  s.summary = "Formie is like a Rails helper, but uses the notation of a partial."
  s.description = <<-END
    Formie implements low level template-based Rails helpers. It injects
    the formies into the ActionView module. The form-bounded as well as
    the unbounded templates are supported. Still, the ActionView
    functionality (e.g. text_field) is kept untouched.
  END
  s.authors = ["Dittmar Krall"]
  s.email = ["dittmar.krall@matiq.com"]
  s.homepage = "https://github.com/matique/formie"
  s.license = "MIT"
  s.platform = Gem::Platform::RUBY

  s.files = `git ls-files -z`.split("\x0")
  s.require_paths = ["lib"]
  s.required_ruby_version = "~> 3"

  s.add_development_dependency "appraisal"
  s.add_development_dependency "combustion"
  s.add_development_dependency "minitest"
end

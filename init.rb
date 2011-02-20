# Include hook code here

ActionView::Base.send :include, Formie::ActionView


# inject formies from default directories

def inject(where, dir)
  Dir[File.join(dir, '*.html.erb')].each {|formie| where.define formie }
  Dir[File.join(dir, '*.yml')].each {|yml|
    formies = YAML.load(File.open(yml).read)
    formies.each {|formie, txt| where.define formie, :inline => txt}
  }
end

root = "#{RAILS_ROOT}/app/views/formie"
inject Formie::FormBuilder, "#{root}/forms"
inject Formie::ActionView,  "#{root}/templates"

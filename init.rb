ActionView::Base.send :include, Formie::ActionView


# inject formies from default directories

def define_formie(where, name, txt)
  txt = txt.force_encoding('UTF-8')  if txt.respond_to?(:force_encoding)
  where.define_formie name, :inline => txt
end

def inject(where, dir)
  Dir[File.join(dir, '*.html.erb')].each {|filename|
    formie = File.basename(filename, '.html.erb')
    define_formie(where, formie, File.open(filename).read)
  }
  Dir[File.join(dir, '*.yml')].each {|yml|
    formies = YAML.load(File.open(yml).read)
    formies.each {|formie, txt|  define_formie(where, formie, txt) }
  }
end

root = "#{::Rails.root.to_s}/app/views/formie"
inject Formie::FormBuilder, "#{root}/forms"
inject Formie::ActionView,  "#{root}/templates"

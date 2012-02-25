require 'formie/engine.rb'

module Formie

  def self.reload
    now = Time.now
    @last_update ||= Time.new(0)
    self.load_formies(::ActionView::Helpers::FormBuilder, 'app/formies/forms')
    self.load_formies(::ActionView::Helpers::TextHelper,  'app/formies/application')
    self.load_formies(::ActionView::Helpers::TextHelper,  'app/formies/templates')
    @last_update = now
  end

  def self.define_formie(where, name, txt)
    formiename = name

    where.send(:define_method, formiename, lambda {|*args, &block|
#p "** called #{where} #{formiename}", args, block
      params = args.extract_options!
      options = {}
      options[:inline] = txt
      options[:locals] = {}
      options[:locals].update params
      options[:locals].update :formiename => formiename,
		:block => block, :form => self, :args => args
      defined?(controller) == 'method' ?
	controller.render_to_body(options) :
	@template.render(options)
    })
#p "** defined  #{where} #{formiename}"
  end


 private
  def self.load_formies(where, dir)
    dir = "#{::Rails.root.to_s}/#{dir}"
    return  unless File.exists?(dir)
    Dir.chdir(dir) {|current_dir|
      Dir.glob('**/*.html.erb').each {|path|
	next  if File.new(path).mtime < @last_update

	name = File.basename(path, '.html.erb')
	self.inject(where, name, File.open(path).read)
      }
    }
  end

  def self.inject(where, name, txt)
#puts "** loading formie '#{where}' - '#{name}'"
    txt = txt.force_encoding('UTF-8')  if txt.respond_to?(:force_encoding)
    where.define_formie name, txt
  end

end


module ActionView::Helpers::TextHelper
  def self.define_formie(name, txt)
    Formie.define_formie(self, name, txt)
  end
end

class ActionView::Helpers::FormBuilder
  def self.define_formie(name, txt)
    Formie.define_formie(self, name, txt)
  end
end

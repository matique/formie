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

  def self.define_formie(where, name, path)
    formiename = name

    where.send(:define_method, formiename, lambda {|*args, &block|
#p "** called #{where} #{formiename}", args, block
      params = args.extract_options!
      options = {}
      options[:file] = path
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
 # avoid Dir.chdir (not thread safe)
    dir = File.join Rails.root, dir
    return  unless File.exist?(dir)
    hsh = {}
    Dir.glob(File.join(dir,'**','**')).sort.each { |path|
      base = File.basename(path).split('.').first
      hsh[base] = path  unless hsh[base]
    }
    hsh.each { |name, path|
      next  if File.new(path).mtime < @last_update

      x = File.expand_path(File.dirname(path))
      where.define_formie name, File.join(x, name)
    }
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

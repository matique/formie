require 'load'

module ActionView::Helpers::TextHelper
  def self.define_formie(name, txt)
    Formie::Helpers.define_formie(self, name, txt)
  end
end

class ActionView::Helpers::FormBuilder
  def self.define_formie(name, txt)
    Formie::Helpers.define_formie(self, name, txt)
  end
end


module Formie
  module Helpers

    def self.define_formie(where, name, txt)
#p ["** defining #{where} - #{name}"]
      formiename = name

      where.send(:define_method, formiename, lambda {|*args, &block|
#p ["** called #{where} #{formiename}", args, block]
	params = args.extract_options!
	options = {}
	options[:inline] = txt
	options[:locals] = {}
	options[:locals].update params
	options[:locals].update :formiename => formiename,
			:block => block,
			:form => self, :args => args
	(@template && @template.render(options)) ||
		controller._render_template(options)
      })
#p ["** defined  #{where} #{formiename}"]
    end

  end
end

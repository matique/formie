require 'load'

module Formie
  module Helpers

    def self.define_formie(where, name, txt)
#p ["** defining #{where}.#{name}"]
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


  class FormBuilder < ActionView::Helpers::FormBuilder

    def self.define_formie(name, txt)
      Helpers::define_formie(self, name, txt)
    end

  end
end


module Formie
  module ActionView

    def formie_for(record_or_name_or_array, *args, &proc)
      # used to ensure that the desired builder gets set before calling #form_for()
      options = args.extract_options!
      # hand control over to the original #form_for()
      form_for(record_or_name_or_array,
		*(args << options.merge!(:builder => Formie::FormBuilder)),
		&proc)
    end

    def self.define_formie(name, txt)
      Helpers::define_formie(self, name, txt)
    end

  end
end

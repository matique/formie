module Formie

  module Helpers

    def self.define_formie(where, name, *args)
      formiename = name
      options  = args.extract_options!
      inline = options.delete(:inline)

      where.send(:define_method, formiename, lambda {|*args|
#p ["** Lambda ** #{where} #{formiename}", args]
	params = args.extract_options!
	options = {}
	options[:inline] = inline
	options[:locals] = {}
	options[:locals].update params
	options[:locals].update :formiename => formiename,
			:inline => inline, :form => self,
			:args => args
	(@template && @template.render(options)) ||
		controller._render_template(options)
      })
#p ["** #{where} #{formiename} defined"]
    end
  end


  class FormBuilder < ActionView::Helpers::FormBuilder

    def self.define_formie(name, *args)
#p ["*** define Formie #{name} ", args]
      Helpers::define_formie(self, name, *args)
    end
  end


  module ActionView

   private
    # used to ensure that the desired builder gets set before calling #form_for()
    def form_for_with_builder(record_or_name_or_array, builder,
		*args, &proc)
      options = args.extract_options!
      # hand control over to the original #form_for()
      form_for(record_or_name_or_array,
		*(args << options.merge!(:builder => builder)), &proc)
    end

   public
    def formie_for(record_or_name_or_array, *args, &proc)
      form_for_with_builder(record_or_name_or_array,
		Formie::FormBuilder, *args, &proc)
    end

    def self.define_formie(name, *args)
#p ["** define Formie #{name} ", args]
      Helpers::define_formie(self, name, *args)
    end
  end

end

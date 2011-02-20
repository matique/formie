module Formie

  module Helpers

    def self.define_formie(where, form, name, *args)
      root = "#{RAILS_ROOT}/app/views/formie"
      formiename = File.basename(name.to_s, '.html.erb').to_sym
      filename   = name
      filename   = File.join(root, "#{name}.html.erb") if formiename == name

      options  = args.extract_options!
      if (template = options.delete(:template))
	filename = File.join(root, "_#{template}.html.erb")
      end

      unless inline = options.delete(:inline)
	inline = File.open(filename, "rb") {|f| f.read}
	inline ||= "formie '#{formiename}' missed"
      end

      where.send(:define_method, formiename, lambda {|*args|
#p "** Lambda ** #{where} #{formiename}", args
	params = args.extract_options!
	options = {}
	options.update :inline => inline
	options[:locals] = {}
	options[:locals].update params
	options[:locals].update :form => self
	options[:locals].update :formiename => formiename

	(@template && @template.render(options)) || controller.render(options)
      })
#p "formie #{where} #{formiename} defined"
    end
  end


  class FormBuilder < ActionView::Helpers::FormBuilder

    def self.define(name, *args)
#p "** define Formie #{name} ", args
      Helpers::define_formie(self, self, name, *args)
    end
  end


  module ActionView

   private
    # used to ensure that the desired builder gets set before calling #form_for()
    def form_for_with_builder(record_or_name_or_array, builder,
		*args, &proc)
      options = args.extract_options!
      # hand control over to the original #form_for()
##      form_for(record_or_name_or_array,
      fields_for(record_or_name_or_array,
		*(args << options.merge!(:builder => builder)), &proc)
    end

   public
    def formie_for(record_or_name_or_array, *args, &proc)
      form_for_with_builder(record_or_name_or_array,
		Formie::FormBuilder, *args, &proc)
    end

    def self.define(name, *args)
#p "** define Formie #{name} ", args
      Helpers::define_formie(self, nil, name, *args)
    end
  end

end

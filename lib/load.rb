module Formie
  module Load

    def self.reload
      now = Time.now
      @last_update ||= Time.new(0)
      self.load_formies(::ActionView::Helpers::FormBuilder, 'forms')
      self.load_formies(::ActionView::Helpers::TextHelper,  'application')
      @last_update = now
    end

   private
    def self.load_formies(where, dir)
      dir = "#{::Rails.root.to_s}/app/formies/#{dir}"
      raise "Missing Formie directory '#{dir}'"  unless File.exists?(dir)
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
end

module Formie
  module Load

    def self.reload
      now = Time.now
      @last_update ||= Time.new(0)
      self.conditional_load Formie::FormBuilder, 'forms'
      self.conditional_load Formie::ActionView,  'templates'
      @last_update = now
    end

   private
    def self.inject(where, name, txt)
      txt = txt.force_encoding('UTF-8')  if txt.respond_to?(:force_encoding)
      where.define_formie name, txt
    end

    def self.conditional_load(where, dir)
      dirfull = "#{::Rails.root.to_s}/app/views/formies/#{dir}"
      raise "Missing Formie directory '#{dirfull}'"  unless File.exists?(dirfull)
      mtime = File.new(dirfull).mtime
      return  if mtime < @last_update

      Dir[File.join(dirfull, '*.html.erb')].each {|filename|
	formie = File.basename(filename, '.html.erb')
	self.inject(where, formie, File.open(filename).read)
      }
      Dir[File.join(dirfull, '*.yml')].each {|yml|
	formies = YAML.load(File.open(yml).read)
	formies.each {|formie, txt|  self.inject(where, formie, txt) }
      }
    end

  end
end

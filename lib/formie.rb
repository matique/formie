# frozen_string_literal: true

require 'formie/engine'

module Formie
  Rails6 = Rails.version.to_f >= 6.0
  PATH = Rails6 ? 'app/views/formies' : 'app/formies'

  def self.reload
    if Rails6 && !File.directory?("#{Rails.root}/app/views/formies")
      raise 'Formies must be located in "app/views/formies" since Rails 6'
    end

    now = Time.now
    @last_update ||= Time.new(0)
    load_formies(::ActionView::Helpers::FormBuilder, "#{PATH}/forms")
    load_formies(::ActionView::Helpers::TextHelper,  "#{PATH}/application")
    load_formies(::ActionView::Helpers::TextHelper,  "#{PATH}/templates")
    @last_update = now
  end

  def self.define_formie(where, name, path)
    formiename = name

    where.send(:define_method, formiename, lambda { |*args, &block|
      # p "** called #{where} #{formiename}", args, block
      params = args.extract_options!
      options = {}
      if Rails6
        options[:template] = path.sub("#{Rails.root}/app/views", '')
      else
        options[:file] = path
      end
      options[:locals] = {}
      options[:locals].update params
      options[:locals].update formiename: formiename,
                block: block, form: self, args: args
      if defined?(controller) == 'method' &&
         controller.respond_to?(:render_to_body) # credits to MARS
        controller.render_to_body(options)
      else
        @template.render(options)
      end
    })
    # p "** defined  #{where} #{formiename}"
  end

  def self.load_formies(where, dir)
    # avoid Dir.chdir (not thread safe)
    dir = File.join Rails.root, dir
    return unless File.exist?(dir)

    hsh = {}
    Dir.glob(File.join(dir, '**', '**')).sort.each { |path|
      base = File.basename(path).split('.').first
      hsh[base] = path unless hsh[base]
    }
    hsh.each { |name, path|
      next if File.new(path).mtime < @last_update

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

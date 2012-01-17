def run(cmd)
  puts "***** #{cmd}"
  system "/usr/bin/time --format 'Elapsed time %E' #{cmd}"
end

def run_without(list)
  all = Dir.glob("spec/**/*_spec.rb")
  res = []
  list.each { |str|
    files = Dir.glob("spec/**/#{str}/*_spec.rb")
    res << files
  }
  run "rspec #{(all - res.flatten).sort.uniq.join(' ')}"
end

def run_matching(name)
  arr = name.gsub('_', '/').split('/')
  bool = false
  arr.each { |str|
    files = Dir.glob("spec/**/#{str}_spec.rb")
    files.each { |file|
      bool = true
      run "rspec #{file}"
    }
  }
  puts "***** Changed #{name}; not yet done"  unless bool
end


watch('spec/.*/*_spec\.rb')     { |match| run "rspec #{match[0]}" }
watch('spec/.*/.*/*_spec\.rb')  { |match| run "rspec #{match[0]}" }

watch('app/(.*)?\.rb') { |match|
  puts "** touched #{match[1]}"
  file = "spec/#{match[1]}_spec.rb"
  if File.exists?(file)
    run "rspec #{file}"
  else
    run_matching match[1]
  end
}

watch('app/views/(.*)?\.erb') { |match|
  puts "** touched #{match[1]}"
  run_without ['models']
}


# Ctrl-\ or ctrl-4
Signal.trap('QUIT') do
  puts "\n--- Running all tests ---\n"
  run 'rake spec'
end

# Ctrl-C
Signal.trap('INT') { abort("Interrupted\n") }

def unable_to_load
  puts <<-EOS
To use rspec for testing you must install rspec gem:
    gem install rspec
    
EOS
  nil
end

def require_spec
  require 'spec'
rescue LoadError
  require_spec_with_rubygems
end

def require_spec_with_rubygems
  require 'rubygems'
  require 'spec'
rescue LoadError
  unable_to_load
end

if require_spec
  begin
    require 'spec/rake/spectask'
  rescue LoadError
    unable_to_load
  end

  desc "Run the specs under spec/models"
  Spec::Rake::SpecTask.new do |t|
    t.spec_opts = ['--options', "spec/spec.opts"]
    t.spec_files = FileList['spec/**/*_spec.rb']
  end
end
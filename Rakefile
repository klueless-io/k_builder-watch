# frozen_string_literal: true

GEM_NAME = 'k_builder-watch'

require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
require 'k_builder/watch/version'

RSpec::Core::RakeTask.new(:spec)

require 'rake/extensiontask'

desc 'Compile all the extensions'
task build: :compile

Rake::ExtensionTask.new(GEM_NAME) do |ext|
  ext.lib_dir = 'lib/k_builder/watch'
end

desc 'Publish the gem to RubyGems.org'
task publish: :build do
  system "gem push #{GEM_NAME}-#{KBuilder::Watch::VERSION}.gem"
end

desc 'Remove old *.gem files'
task :clean do
  system 'rm *.gem'
end

task default: %i[clobber compile spec]

# task :default => :build

# task :build do
#   system "gem build " + GEM_NAME + ".gemspec"
# end

# task :install => :build do
#   system "gem install " + GEM_NAME + "-" + KBuilder::Watch::VERSION + ".gem"
# end

# task :publish => :build do
#   system 'gem push ' + GEM_NAME + "-" + GEM_VERSION + ".gem"
# end

# task :clean do
#   system "rm *.gem"
# end

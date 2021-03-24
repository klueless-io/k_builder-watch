# frozen_string_literal: true

require_relative 'lib/k_builder/watch/version'

Gem::Specification.new do |spec|
  spec.required_ruby_version  = '>= 2.5'
  spec.name                   = 'k_builder-watch'
  spec.version                = KBuilder::Watch::VERSION
  spec.authors                = ['David Cruwys']
  spec.email                  = ['david@ideasmen.com.au']

  spec.summary                = 'K-Builder-Watch will watch k_builder files and when they change, execute them'
  spec.description            = <<-TEXT
    K-Builder-Watch will watch k_builder files and when they change, execute them
  TEXT
  spec.homepage               = 'http://appydave.com/gems/k-builder-watch'
  spec.license                = 'MIT'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  raise 'RubyGems 2.0 or newer is required to protect against public gem pushes.' unless spec.respond_to?(:metadata)

  # spec.metadata['allowed_push_host'] = "Set to 'http://mygemserver.com'"

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/klueless-io/k_builder-watch'
  spec.metadata['changelog_uri'] = 'https://github.com/klueless-io/k_builder-watch/commits/master'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the RubyGem files that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      f.match(%r{^(test|spec|features)/})
    end
  end
  spec.bindir        = 'exe'
  
  spec.require_paths = ['lib']
  # spec.extensions    = ['ext/k_builder/watch/extconf.rb']

  spec.add_dependency 'filewatcher', '~> 0.0'
  spec.add_dependency 'k_builder', '~> 0.0'
  spec.add_dependency 'k_builder-package_json', '~> 0.0'
  spec.add_dependency 'k_builder-webpack5', '~> 0.0'
end

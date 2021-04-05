# frozen_string_literal: true

require 'pry'
require 'k_builder'
require 'json'
require 'getoptlong'
require 'forwardable'

module KBuilder
  module Watch
    # Action for creating a new app with .builders
    class ActionNewBuilder < KBuilder::Watch::BaseAction
      def run
        setup_file = File.join(options.new_watch_path, 'setup.rb')
        config_file = File.join(options.new_watch_path, 'config', '_.rb')

        FileUtils.mkdir_p(File.dirname(config_file))
        File.write(setup_file, "require 'config/_'")                                unless File.exist?(setup_file)
        File.write(config_file, "puts '_'\n\n#require 'config/_initialize'")        unless File.exist?(config_file)

        system("code #{File.join(options.new_app_path, '.')}")
      end
    end
  end
end

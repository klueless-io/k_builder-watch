# frozen_string_literal: true

require 'pry'
require 'k_builder'
require 'json'
require 'getoptlong'
require 'forwardable'

module KBuilder
  module Watch
    # Action for displaying CLI help
    class ActionDisplayHelp < KBuilder::Watch::BaseAction
      def run
        puts 'HELP: k_watcher [OPTION] ... DIR'
        puts ''
        puts '  -h, --help:                                   - show help'
        puts '  --debug                                       - display debug options'
        puts '  -n, --new [folder_name]                       - create a new .builders folder with setup file, optionally create it under the [FolderName]'
        puts ''
        puts ' DIR:                                           - The directory to watch, will default to current directory "."'
        puts ''
        puts 'examples'
        puts ''
        puts 'Get Help                                        - k_watcher -h'
        puts 'Debug                                           - k_watcher --debug'
        puts 'New builder project   (./.builders)             - k_watcher -n'
        puts 'New builder project   (./HelloWorld/.builders)  - k_watcher -n HelloWorld'
        puts 'Watch current folder  (.)                       - k_watcher'
        puts 'Watch the subfolder   (.builders)               - k_watcher .builders'
      end
    end
  end
end

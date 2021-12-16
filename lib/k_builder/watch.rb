# frozen_string_literal: true
require 'handlebars/helpers'

require 'k_doc'
require 'k_domain'
require 'k_util'
require 'k_log'

require 'k_builder'
require 'k_builder/dotnet'
require 'k_builder/package_json'
require 'k_builder/webpack5'

require 'k_builder/watch/version'
require 'k_builder/watch/cli'
require 'k_builder/watch/cli_options'
require 'k_builder/watch/base_action'
require 'k_builder/watch/action_display_help'
require 'k_builder/watch/action_display_debug'
require 'k_builder/watch/action_new_builder'
require 'k_builder/watch/action_watcher'
require 'k_builder/watch/execute'

module KBuilder
  module Watch
    # raise KBuilder::Watch::Error, 'Sample message'
    class Error < StandardError; end
  end
end

if ENV['KLUE_DEBUG']&.to_s&.downcase == 'true'
  namespace = 'KBuilder::Watch::Version'
  file_path = $LOADED_FEATURES.find { |f| f.include?('k_builder/watch/version') }
  version   = KBuilder::Watch::VERSION.ljust(9)
  puts "#{namespace.ljust(35)} : #{version.ljust(9)} : #{file_path}"
end

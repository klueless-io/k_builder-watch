# frozen_string_literal: true

require 'k_doc'
require 'k_builder/watch/version'
require 'k_builder/watch/cli'
require 'k_builder/watch/watcher'

module KBuilder
  module Watch
    # raise KBuilder::Watch::Error, 'Sample message'
    class Error < StandardError; end
  end
end

puts "KBuilder::Watch::Version: #{KBuilder::Watch::VERSION}" if ENV['KLUE_DEBUG']&.to_s&.downcase == 'true'
# frozen_string_literal: true

require 'k_builder/watch/version'
require 'k_builder/watch/cli'
require 'k_builder/watch/watcher'

module KBuilder
  module Watch
    # raise KBuilder::Watch::Error, 'Sample message'
    class Error < StandardError; end
  end
end

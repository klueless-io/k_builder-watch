# frozen_string_literal: true

require 'pry'
require 'k_builder'
require 'json'
require 'getoptlong'
require 'forwardable'

module KBuilder
  module Watch
    # Action for displaying CLI debug options
    class ActionDisplayDebug < KBuilder::Watch::BaseAction
      def run
        puts JSON.pretty_generate(@options.to_h)
      end
    end
  end
end

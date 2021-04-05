# frozen_string_literal: true

module KBuilder
  module Watch
    # Base Action
    class BaseAction
      attr_accessor :options

      def initialize(options)
        @options = options
      end

      def run
        raise KBuilder::Watch::Error, 'Descendants of BaseAction must implement the run method'
      end
    end
  end
end

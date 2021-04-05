# frozen_string_literal: true

require 'pry'
require 'k_builder'
require 'json'
require 'getoptlong'

module KBuilder
  module Watch
    # Execute based on CLI options
    class Execute
      DEFAULT_ACTIONS = {
        help: KBuilder::Watch::ActionDisplayHelp,
        debug: KBuilder::Watch::ActionDisplayDebug,
        new_builder: KBuilder::Watch::ActionNewBuilder,
        watcher: KBuilder::Watch::ActionWatcher
      }.freeze

      # watcher = KBuilder::Watch::Watcher.new(cli.watch_path)
      # watcher.start

      attr_accessor :actions
      attr_accessor :options

      # Execute one or more actions based on supplied options
      #
      # You can use dependency injection to provide your actions
      def initialize(options, actions: DEFAULT_ACTIONS)
        @actions = actions
        @options = options
      end

      def run_action(action_key)
        raise KBuilder::Watch::Error, "Unknown action: #{action_key}" unless @actions.key?(action_key)

        action = actions[action_key].new(options)
        action.run
      end

      def run
        if options.help?
          run_action(:help)

          exit
        end

        if options.debug?
          run_action(:debug)

          exit
        end

        run_action(:new) if options.new?
        run_action(:watcher)
      end
    end
  end
end

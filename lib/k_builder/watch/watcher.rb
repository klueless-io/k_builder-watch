# frozen_string_literal: true

require 'filewatcher'
# require 'json'
require 'io/console'
# require 'bundler/setup'
# require 'webpack5/builder'
# require 'handlebars/helpers/configuration'
module KBuilder
  # Watch supports any watch and execute processes for builders
  module Watch
    # Watcher does the actual file watching and run the processor
    class Watcher
      attr_accessor :directory

      def initialize(directory)
        @directory = directory
      end

      # May need some sort of pattern filters
      # watch_file = File.join(directory, 'DOMAIN_INSTRUCTIONS.MD')

      def start
        clear_screen
        puts "KBuilder-Watch: v#{KBuilder::Watch::VERSION} is watching for file changes"
        puts "Directory: #{directory}"
        # puts "Watch File: #{watch_file}"

        Filewatcher.new(directory).watch do |changes|
          changes.each do |filename, event|
            puts "File #{event}: #{filename}"

            process_updated_file(filename) if event == :updated
          end
        end
      end

      # rubocop:disable Lint/RescueException
      def process_updated_file(filename)
        clear_screen
        update_load_path(filename)

        puts "File updated: #{filename}"

        content = File.read(filename)
        Object.class_eval(content, filename)
      rescue Exception => e
        puts e.message
        puts e.backtrace
              .select { |ex| ex.start_with?(filename) }
              .map { |m| m.delete_suffix(":in `process_updated_file'") }
              .join("\n")
        # puts '-' * 70
        # puts e.backtrace.join("\n")
      end
      # rubocop:enable Lint/RescueException

      private

      def update_load_path(filename)
        dirname = File.dirname(filename)

        # This needs to be in detailed logging
        $LOAD_PATH.unshift(dirname) unless $LOAD_PATH.find { |path| path.start_with?(dirname) }
      end

      def clear_screen
        puts "\n" * 70
        $stdout.clear_screen
      end
    end
  end
end

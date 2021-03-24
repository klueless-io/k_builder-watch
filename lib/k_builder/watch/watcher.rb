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
        puts 'Watching for file changes'
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
        $LOAD_PATH.unshift(File.join(Dir.pwd, '.builders'))
        # Can I set __FILE__ during class_eval

        puts "File updated: #{filename}"

        content = File.read(filename)
        Object.class_eval(content, __FILE__, __LINE__)
      rescue Exception => e
        puts e.message
        puts e.backtrace.select { |ex| ex.start_with?(filename) }.join("\n")
      end
      # rubocop:enable Lint/RescueException
    end

    def clear_screen
      puts "\n" * 70
      $stdout.clear_screen
    end
  end
end

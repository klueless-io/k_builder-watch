# frozen_string_literal: true

require 'filewatcher'
# require 'json'
require 'io/console'
# require 'bundler/setup'
# require 'webpack5/builder'
# require 'handlebars/helpers/configuration'

module KBuilder
  module Watch
    # Watch fo
    class Watcher
      attr_accessor :directory

      def initialize(directory)
        @directory = directory
      end

      # May need some sort of pattern filters
      # watch_file = File.join(directory, 'DOMAIN_INSTRUCTIONS.MD')

      def start
        puts 'Watching for file changes'
        puts "Directory: #{directory}"
        # puts "Watch File: #{watch_file}"

        Filewatcher.new(directory).watch do |changes|
          changes.each do |filename, event|
            puts "File #{event}: #{filename}"
            
            process_updated_file(filename) if (event == :updated)
          end
        end
      end

      def process_updated_file(filename)
        puts "\n" * 70
        $stdout.clear_screen
        puts "File updated: #{filename}"

        content = File.read(filename)
        Object.class_eval content
      rescue StandardError => e
        puts e.message
        puts e.backtrace.join("\n")
      end
    end
  end
end

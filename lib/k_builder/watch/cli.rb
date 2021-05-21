# frozen_string_literal: true
require 'pry'
require 'k_builder'
require 'json'
require 'getoptlong'
require 'forwardable'

module KBuilder
  module Watch
    # Command line interface for starting the watcher
    class Cli
      extend Forwardable

      attr_accessor :opts

      def_delegators :opts, :base_path, :debug?, :help?, :new?
      
      def initialize
        @opts = KBuilder::Watch::CliOptions.new

        process_arguments
      end

      def self.parse_options
        new.opts
      end

      def process_arguments
        parse_arguments

        set_watch_path_arg
        set_watch_path
      end

      def options
        GetoptLong.new(
          ['--help' , '-h', GetoptLong::NO_ARGUMENT],
          ['--debug' , GetoptLong::NO_ARGUMENT],
          ['--new' , '-n', GetoptLong::OPTIONAL_ARGUMENT]
        )
      end

      def parse_arguments
        options.each do |opt, arg|
          # Arguments like -nKafeOwner and -n KafeOwner should both become 'KafeOwner'
          parse_option(opt, arg.strip)
        end
      end

      def to_h
        @opts.to_h
      end

      private

      # rubocop:disable Metrics/AbcSize
      def parse_option(opt, arg)
        case opt
        when '--help'
          @opts.help = true
        when '--debug'
          @opts.debug = true
        when '--new'
          parse_new_option(arg)
        end
      end

      def parse_new_option(arg)
        @opts.new_arg = arg.to_s
        if @opts.new_arg == ''
          @opts.new_app_path = @opts.base_path
          @opts.new_watch_path = File.join(@opts.base_path, '.builders')
        else
          @opts.new_app_path = File.join(@opts.base_path, @opts.new_arg)
          @opts.new_watch_path = File.join(@opts.base_path, @opts.new_arg, '.builders')
        end
      end
      # rubocop:enable Metrics/AbcSize

      def set_watch_path
        if new?
          @opts.watch_path = @opts.new_watch_path
          return
        end

        @opts.watch_path = if KUtil.file.home_or_absolute?(@opts.watch_path_arg)
                             File.expand_path(@opts.watch_path_arg)
                           else
                             File.absolute_path(@opts.watch_path_arg, @opts.base_path)
                           end
      end

      def set_watch_path_arg
        @opts.watch_path_arg = if ARGV.length == 1
                                 ARGV.shift
                               else
                                 '.'
                               end
      end
    end
  end
end

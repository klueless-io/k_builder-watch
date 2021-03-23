# frozen_string_literal: true

require 'pry'
require 'k_builder'
require 'json'
require 'getoptlong'

module KBuilder
  module Watch
    # Command line interface for starting the watcher
    class Cli
      # attr_accessor :repetitions
      # attr_accessor :name
      attr_accessor :debug
      attr_accessor :base_path
      attr_accessor :path
      attr_accessor :watch_path
      attr_accessor :help

      def initialize
        # @repetitions = 1
        # @name = nil
        @debug = false
        @watch_path = nil
        @base_path = Dir.pwd
        @path = nil

        parse_arguments
        post_process_arguments
      end

      def options
        # ['--repeat'  , '-r', GetoptLong::REQUIRED_ARGUMENT],
        # ['--name'    , '-n', GetoptLong::OPTIONAL_ARGUMENT]
        GetoptLong.new(
          ['--help' , '-h', GetoptLong::NO_ARGUMENT],
          ['--debug' , GetoptLong::NO_ARGUMENT]
        )
      end

      def post_process_arguments
        set_watch_path
      end

      def parse_arguments
        # bin/run -l -r 2 --name -- spec/samples
        options.each do |opt, arg|
          parse_option(opt, arg)
        end

        parse_final_argument
      end

      def parse_final_argument
        if ARGV.length != 1
          puts 'Missing dir argument (try --help)'
          exit 0
        end

        @path = ARGV.shift
      end

      def parse_option(opt, _arg)
        case opt
        when '--help'
          @help = true
        when '--debug'
          @debug = true
          # when '--repeat'
          #   @repetitions = arg.to_i
          # when '--name' # sample
          #   @name = (arg == '' ? 'John' : arg)
        end
      end

      def execute
        display_help      if help
        display_debug     if debug

        # Dir.chdir(dir)
        # for i in (1..repetitions)
        #   print "Hello"
        #   if name
        #     print ", #{name}"
        #   end
        #   puts
        # end
      end

      def display_help
        puts 'This is the help menu.'
        puts '  -h This help file'
        puts '  --debug debug options'

        # hello [OPTION] ... DIR

        # -h, --help:
        #   show help

        # --repeat x, -n x:
        #   repeat x times

        # --name [name]:
        #   greet user by name, if name not supplied default is John

        # DIR: The directory in which to issue the greeting.

        exit
      end

      def display_debug
        puts JSON.pretty_generate(to_h)
      end

      def to_h
        # repetitions: repetitions,
        # name: name,
        {
          debug: debug,
          base_path: base_path,
          watch_path: watch_path,
          path: path
        }
      end

      private

      def set_watch_path
        @watch_path = if path.start_with?('~')
                        File.expand_path(path)
                      else
                        File.absolute_path(path, base_path)
                      end
      end
    end
  end
end

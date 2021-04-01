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
      attr_accessor :path_relative
      attr_accessor :new_path
      attr_accessor :new_path_relative
      attr_accessor :new
      attr_accessor :app_path
      attr_accessor :watch_path
      attr_accessor :help

      def initialize
        # puts "Watch: #{KBuilder::Watch::VERSION}"
        # @repetitions = 1
        # @name = nil
        @debug = false
        @watch_path = nil
        @base_path = Dir.pwd
        @path_relative = nil # '.'
        @path = nil
        @app_path = nil
        @new_path = nil
        @new_path_relative = nil
        @new = nil

        parse_arguments
        post_process_arguments
      end

      def options
        # ['--repeat'  , '-r', GetoptLong::REQUIRED_ARGUMENT],
        GetoptLong.new(
          ['--help'     , '-h', GetoptLong::NO_ARGUMENT],
          ['--debug'    , GetoptLong::NO_ARGUMENT],
          ['--new'      , '-n', GetoptLong::OPTIONAL_ARGUMENT]
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
        # if ARGV.length != 1
        #   puts 'Missing dir argument (try --help)'
        #   exit 0
        # end

        @path_relative = if ARGV.length == 1
                           ARGV.shift
                         else
                           '.'
                         end

        return unless @path.nil?

        @path = File.join(base_path, path_relative)
      end

      def parse_option(opt, arg)
        case opt
        when '--help'
          @help = true
        when '--debug'
          @debug = true
          # when '--repeat'
          #   @repetitions = arg.to_i
        when '--new'
          # Maybe better to call @new, @app_name
          @new = arg
          @app_path = File.join(base_path, arg)
          @new_path_relative = arg == '' ? '.builders' : File.join(arg.to_s, '.builders')
          @new_path = File.join(base_path, @new_path_relative)
          @path = @new_path_relative
        end
      end

      def execute
        display_help      if help
        display_debug     if debug
        new_builder       unless @new.nil?

        # Dir.chdir(dir)
        # for i in (1..repetitions)
        #   print "Hello"
        #   if name
        #     print ", #{name}"
        #   end
        #   puts
        # end
      end

      def new_builder
        setup_file = File.join(new_path, 'setup.rb')
        config_file = File.join(new_path, 'config', '_.rb')

        FileUtils.mkdir_p(File.dirname(config_file))
        File.write(setup_file, "require 'config/_'")                                unless File.exist?(setup_file)
        File.write(config_file, "puts '_'\n\n#require 'config/_initialize'")        unless File.exist?(config_file)

        system("code #{File.join(app_path, '.')}")
      end

      def display_help
        puts 'HELP: k_watcher [OPTION] ... DIR'
        puts ''
        puts '  -h, --help:                                   - show help'
        puts '  --debug                                       - display debug options'
        puts '  -n, --new [folder_name]                       - create a new .builders folder with setup file, optionally create it under the [FolderName]'
        puts ''
        puts ' DIR:                                           - The directory to watch, will default to current directory "."'
        puts ''
        puts 'examples'
        puts ''
        puts 'Get Help                                        - k_watcher -h'
        puts 'Debug                                           - k_watcher --debug'
        puts 'New builder project   (./.builders)             - k_watcher -n'
        puts 'New builder project   (./HelloWorld/.builders)  - k_watcher -n HelloWorld'
        puts 'Watch current folder  (.)                       - k_watcher'
        puts 'Watch the subfolder   (.builders)               - k_watcher .builders'

        exit
      end

      def display_debug
        puts JSON.pretty_generate(to_h)
        exit
      end

      def to_h
        # repetitions: repetitions,
        # name: name,
        {
          debug: debug,
          app_path: app_path,
          base_path: base_path,
          path_relative: path_relative,
          watch_path: watch_path,
          new_path: new_path,
          new_path_relative: new_path_relative,
          new: new
        }
      end

      private

      # Refactor to use KUtil.file.expand_path(path, base_path)
      # Need tests
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

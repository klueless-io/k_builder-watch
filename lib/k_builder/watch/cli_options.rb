# frozen_string_literal: true

require 'pry'
require 'k_builder'
require 'json'
require 'getoptlong'

module KBuilder
  module Watch
    # List of and options paths that are relevant to the KBuilder::Watch::Cli
    class CliOptions
      # This is the path that the watcher was started from.
      # It is the default base path that other paths are relative to.
      #
      # Note: it is not used when paths are supplied in absolute form
      attr_accessor :base_path
      # attr_accessor :path

      # What watch_path argument is passed in for watching
      #
      # This attribute will be help to build :watch_path
      #
      # A relative path will be relative to base_path
      # An absolute path is used as is
      # A home path is used as is
      attr_accessor :watch_path_arg
      attr_accessor :watch_path

      # What :new_arg is passed in for creating a new application with
      # with .builder watch capability
      attr_accessor :new_arg

      # Path to where the application will reside
      attr_accessor :new_app_path

      # Path to where the .builder files will reside
      attr_accessor :new_watch_path

      attr_accessor :debug
      attr_accessor :help

      def initialize
        @base_path = Dir.pwd

        @watch_path_arg = nil
        @watch_path = nil

        @new_arg = nil
        @new_app_path = nil
        @new_watch_path = nil

        @debug = false
        @help = false
      end

      def help?
        !!@help
      end

      def debug?
        !!@debug
      end

      def new?
        !!@new_arg
      end

      def to_h
        {
          debug: debug?,
          help: help?,
          new: new?,
          base_path: base_path,
          watch_path_arg: watch_path_arg,
          watch_path: watch_path,
          new_arg: new_arg,
          new_app_path: new_app_path,
          new_watch_path: new_watch_path
        }
      end
    end
  end
end

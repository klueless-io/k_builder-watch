# frozen_string_literal: true

module KBuilder
  # Watch supports any watch and execute processes for builders
  module Watch
    # Create a new folder for application with builders
    class NewBuilder
      def execute(_paths)
        setup_file = File.join(new_watch_path, 'setup.rb')
        config_file = File.join(new_watch_path, 'config', '_.rb')

        FileUtils.mkdir_p(File.dirname(config_file))
        File.write(setup_file, "require 'config/_'")                                unless File.exist?(setup_file)
        File.write(config_file, "puts '_'\n\n#require 'config/_initialize'")        unless File.exist?(config_file)

        system("code #{File.join(new_app_path, '.')}")
      end
    end
  end
end

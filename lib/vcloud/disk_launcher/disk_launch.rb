module Vcloud
  module DiskLauncher
    class DiskLaunch

      # Initializes instance variables.
      #
      # @return [void]
      def initialize
        @config_loader = Vcloud::Core::ConfigLoader.new
      end

      # Parses a configuration file and provisions the networks it defines.
      #
      # @param  config_file [String]  Path to a YAML or JSON-formatted configuration file
      # @return [void]
      def run(config_file = nil)
        config = @config_loader.load_config(config_file, Vcloud::DiskLauncher::Schema::DISK_LAUNCH)

        config[:disks].each do |disk_config|
          puts disk_config
        end

      end
    end
  end
end

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

        config[:independent_disks].each do |disk_config|
          name = disk_config[:name]
          vdc_name = disk_config[:vdc_name]
          size = disk_config[:size]
          begin
            disk = Vcloud::Core::IndependentDisk.create(
              Vcloud::Core::Vdc.get_by_name(vdc_name),
              name,
              size
            )
          rescue Vcloud::Core::IndependentDisk::DiskAlreadyExistsException
            Vcloud::Core.logger.info(
              "Disk '#{name}' already exists in vDC '#{vdc_name}'. Skipping"
            )
            next
          end
          Vcloud::Core.logger.info(
            "Created disk '#{name}' in vDC #{vdc_name} successfully. (id: #{disk.id})"
          )
        end

      end
    end
  end
end

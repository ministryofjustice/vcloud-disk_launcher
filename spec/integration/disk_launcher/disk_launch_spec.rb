require 'spec_helper'
require 'pp'
require 'erb'
require 'ostruct'
require 'vcloud/tools/tester'

describe Vcloud::DiskLauncher::DiskLaunch do
  context "with minimum input setup" do

    before(:all) do
      @disks_to_delete = []
      @files_to_delete = []
    end

    it "should create a single disk" do
      test_data_1 = define_test_data
      minimum_data_erb = File.join(File.dirname(__FILE__), 'data/single_disk.yaml.erb')
      minimum_data_yaml = ErbHelper.convert_erb_template_to_yaml(test_data_1, minimum_data_erb)
      @files_to_delete.push(minimum_data_yaml)
      Vcloud::DiskLauncher::DiskLaunch.new.run(minimum_data_yaml)

      created_disk = Vcloud::Core::IndependentDisk.get_by_name_and_vdc_name(
        test_data_1[:disk_name],
        test_data_1[:vdc_1_name]
      )
      @disks_to_delete.push(created_disk)

      expect(created_disk).not_to be_nil
      expect(created_disk.name).to eq(test_data_1[:disk_name])
    end

    after(:all) do
      unless ENV['VCLOUD_TOOLS_RSPEC_NO_DELETE']
        @files_to_delete.each do |file|
          File.delete file
        end
        @disks_to_delete.each do |disk|
          disk.destroy
        end
      end
    end

  end

  def define_test_data

    config_file = File.join(File.dirname(__FILE__),
      "../vcloud_tools_testing_config.yaml")
    required_user_params = [
      "vdc_1_name",
      "vdc_2_name",
    ]
    parameters = Vcloud::Tools::Tester::TestSetup.new(config_file, required_user_params).test_params

    {
      disk_name: "vcloud-disk_launcher-tests-#{Time.now.strftime('%s')}",
      vdc_1_name: parameters.vdc_1_name,
      vdc_2_name: parameters.vdc_2_name,
    }

  end

end

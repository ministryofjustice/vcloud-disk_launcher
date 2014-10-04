require 'spec_helper'

describe Vcloud::DiskLauncher do

  context "DiskLaunch schema validation" do

    it "validates a legal minimal schema" do
      test_config = {
        :independent_disks => [
          :name     =>  "Valid disk name",
          :vdc_name =>  "Some vDC",
          :size     =>  "10GB"
        ]
      }
      validator = Vcloud::Core::ConfigValidator.validate(:base, test_config, Vcloud::DiskLauncher::Schema::DISK_LAUNCH)
      expect(validator.valid?).to be_true
      expect(validator.errors).to be_empty
    end

    it "validates a multiple disks" do
      test_config = {
        :independent_disks => [
          {
            :name     =>  "Valid disk 1",
            :vdc_name =>  "Some vDC",
            :size     =>  "10GB"
          },
          {
            :name     =>  "Valid disk 2",
            :vdc_name =>  "Another vDC",
            :size     =>  "500MB"
          },
        ]
      }
      validator = Vcloud::Core::ConfigValidator.validate(:base, test_config, Vcloud::DiskLauncher::Schema::DISK_LAUNCH)
      expect(validator.valid?).to be_true
      expect(validator.errors).to be_empty
    end

    it "validates an empty disk list" do
      test_config = {
        :independent_disks => []
      }
      validator = Vcloud::Core::ConfigValidator.validate(:base, test_config, Vcloud::DiskLauncher::Schema::DISK_LAUNCH)
      expect(validator.valid?).to be_true
      expect(validator.errors).to be_empty
    end

    it "does not validate an illegal schema" do
      test_config = {
        :no_disks_here => {
          :name => "I am not valid"
        }
      }
      validator = Vcloud::Core::ConfigValidator.validate(:base, test_config, Vcloud::DiskLauncher::Schema::DISK_LAUNCH)
      expect(validator.valid?).to be_false
      expect(validator.errors).to eq(["base: parameter 'no_disks_here' is invalid", "base: missing 'independent_disks' parameter"])
    end

  end
end

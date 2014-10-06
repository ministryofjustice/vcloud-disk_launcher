require 'spec_helper'

describe Vcloud::DiskLauncher::DiskLaunch do

  context "ConfigLoader returns two different disks" do
    let(:disk1) {
      {
        :name         => 'Test Disk 1',
        :vdc_name     => 'TestVDC 1',
        :size         => '500MB',
      }
    }
    let(:disk2) {
      {
        :name         => 'Test Disk 2',
        :vdc_name     => 'TestVDC 2',
        :size         => '10GiB',
      }
    }
    let(:mock_vdc_1) { double(:mock_vdc, :name => "TestVDC 1") }
    let(:mock_vdc_2) { double(:mock_vdc, :name => "TestVDC 2") }
    let(:mock_disk_1) { double(:mock_disk_1, :id => "12341234-1234-1234-1234-123455550001") }
    let(:mock_disk_2) { double(:mock_disk_2, :id => "12341234-1234-1234-1234-123455550002") }

    before(:each) do
      config_loader = double(:config_loader)
      expect(Vcloud::Core::Vdc).to receive(:get_by_name).with("TestVDC 1").and_return(mock_vdc_1)
      expect(Vcloud::Core::Vdc).to receive(:get_by_name).with("TestVDC 2").and_return(mock_vdc_2)
      expect(Vcloud::Core::ConfigLoader).to receive(:new).and_return(config_loader)
      expect(config_loader).to receive(:load_config).and_return({
        :independent_disks => [disk1, disk2]
      })
    end

    it "should call Core::IndependentDisk.create once for each disk" do
      expect(Vcloud::Core::IndependentDisk).
        to receive(:create).with(mock_vdc_1, disk1[:name], disk1[:size]).and_return(mock_disk_1)
      expect(Vcloud::Core::IndependentDisk).
        to receive(:create).with(mock_vdc_2, disk2[:name], disk2[:size]).and_return(mock_disk_2)
      expect(Vcloud::Core.logger).to receive(:info).exactly(2).times
      subject.run('input_config_yaml')
    end

    it "will still create disk2 if disk1 already exists (skipping disk1)" do
      expect(Vcloud::Core::IndependentDisk).
        to receive(:create).with(mock_vdc_1, disk1[:name], disk1[:size]).
        and_raise(Vcloud::Core::IndependentDisk::DiskAlreadyExistsException)
      expect(Vcloud::Core::IndependentDisk).
        to receive(:create).with(mock_vdc_2, disk2[:name], disk2[:size]).and_return(mock_disk_2)
      expect(Vcloud::Core.logger).to receive(:info).exactly(2).times
      subject.run('input_config_yaml')
    end

  end

end

require_relative 'spec_helper'

describe package('graphite-carbon') do
  it { should be_installed }
end

describe package('python-whisper') do
  it { should be_installed }
end

describe service('carbon-cache') do
  it { should be_enabled }
  it { should be_running }
end

describe port(2003) do
  it { should be_listening.with('tcp6') }
end

describe file('/etc/carbon/carbon.conf') do
  it { should contain(/LINE_RECEIVER_INTERFACE = ::1/) }
  it { should be_mode 640 }
  it { should be_owned_by '_graphite' }
end

describe file('/etc/carbon/storage-schemas.conf') do
  it { should contain('priority = 100').after('[stats]') }
  it { should be_mode 640 }
  it { should be_owned_by '_graphite' }
end

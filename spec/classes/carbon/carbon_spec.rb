require 'spec_helper'

describe 'carbon', :type => :class do

  let :params do
    {
      :carbon_settings => {
        'cache' => {
          'line_receiver_interface' => '::1',
        },
      },
      :storage_schemas => {
        'stats' => {
          'priority'   => '100',
          'pattern'    => '.*',
          'retentions' => '10:2160,60:10080,600:262974',
        },
      },
      :storage_aggregation => {
        'all_min' => {
          'pattern'           => '\.min$',
          'xFilesFactor'      => '0.1',
          'aggregationMethod' => 'min',
        },
      },
      :aggregation_rules => [
        '<env>.applications.<app>.all.requests (60) = sum <env>.applications.<app>.*.requests',
      ],
      :relay_rules => {
        'default' => {
          'default'      => 'true',
          'destinations' => '127.0.0.1:2004:a, 127.0.0.1:2104:b',
        }
      },
      :rewrite_rules => {
        'post' => {
          '_avg$' => '_average',
        },
      },
      :whitelist => [
        '.*',
      ],
      :blacklist => [
        '^some\.noisy\.metric\.prefix\..*',
      ]
    }
  end


  let(:facts) { {:osfamily => 'debian', :operatingsystem => 'Ubuntu', :lsbdistid => 'Ubuntu'} }
  it { should contain_class('carbon::install')}
  it { should contain_class('carbon::config')}
  it { should contain_class('carbon::service')}

  it { should contain_package('whisper')}
  it { should contain_package('carbon')}
  it { should contain_service('carbon') }

  it do
    should contain_file_line('/etc/default/graphite-carbon enable').with({
      :line => 'CARBON_CACHE_ENABLED=true',
    })
  end

  it do
    should contain_ini_setting('/etc/carbon/carbon.conf cache: line_receiver_interface = ::1').with({
      :setting => 'LINE_RECEIVER_INTERFACE',
      :value   => '::1',
    })
  end
  it { should contain_ini_setting('/etc/carbon/storage-schemas.conf stats: priority = 100') }
  it { should contain_ini_setting('/etc/carbon/storage-aggregation.conf all_min: pattern = \.min$') }
  it { should contain_file_line('/etc/carbon/aggregation-rules.conf: <env>.applications.<app>.all.requests (60) = sum <env>.applications.<app>.*.requests') }
  it { should contain_ini_setting('/etc/carbon/relay-rules.conf default: destinations = 127.0.0.1:2004:a, 127.0.0.1:2104:b') }
  it { should contain_ini_setting('/etc/carbon/rewrite-rules.conf post: _avg$ = _average') }
  it { should contain_file_line('/etc/carbon/whitelist.conf: .*') }
  it { should contain_file_line('/etc/carbon/blacklist.conf: ^some\.noisy\.metric\.prefix\..*') }

end

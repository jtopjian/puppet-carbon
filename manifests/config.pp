class carbon::config {

  include carbon::params

  file {
    [$::carbon::params::carbon_conf,
     $::carbon::params::storage_schemas_conf,
     $::carbon::params::storage_aggregation_conf,
     $::carbon::params::aggregation_rules_conf,
     $::carbon::params::relay_rules_conf,
     $::carbon::params::rewrite_rules_conf,
     $::carbon::params::whitelist_conf,
     $::carbon::params::blacklist_conf,
    ]:
    ensure => present,
    owner  => $::carbon::params::graphite_user,
    group  => $::carbon::params::graphite_group,
    mode   => '0640',
  }

  # Iterate over a nested hash of key/value settings for carbon.conf
  $::carbon::carbon_settings.each |$section, $settings| {
    $settings.each |$setting, $value| {
      ini_setting { "${::carbon::params::carbon_conf} ${section}: ${setting} = ${value}":
        ensure  => present,
        path    => $::carbon::params::carbon_conf,
        section => $section,
        setting => upcase($setting),
        value   => $value,
        require => File[$::carbon::params::carbon_conf],
      }
    }
  }

  # Iterate over a nested hash of key/value settings for storage-schemas.conf
  $::carbon::storage_schemas.each |$section, $settings| {
    $settings.each |$setting, $value| {
      ini_setting { "${::carbon::params::storage_schemas_conf} ${section}: ${setting} = ${value}":
        ensure  => present,
        path    => $::carbon::params::storage_schemas_conf,
        section => $section,
        setting => $setting,
        value   => $value,
        require => File[$::carbon::params::storage_schemas_conf],
      }
    }
  }

  # Iterate over a nested hash of key/value settings for storage_aggregation.conf
  $::carbon::storage_aggregation.each |$section, $settings| {
    $settings.each |$setting, $value| {
      ini_setting { "${::carbon::storage_aggregation_conf} ${section}: ${setting} = ${value}":
        ensure  => present,
        path    => $::carbon::params::storage_aggregation_conf,
        section => $section,
        setting => $setting,
        value   => $value,
        require => File[$::carbon::params::storage_aggregation_conf],
      }
    }
  }

  # Iterate over an array of lines for aggregation-rules.conf
  $::carbon::aggregation_rules.each |$rule| {
    file_line { "${::carbon::params::aggregation_rules_conf}: ${rule}":
      ensure  => present,
      line    => $rule,
      path    => $::carbon::params::aggregation_rules_conf,
      require => File[$::carbon::params::aggregation_rules_conf],
    }
  }

  # Iterate over a nested hash of key/value settings for relay_rules.conf
  $::carbon::relay_rules.each |$section, $settings| {
    $settings.each |$setting, $value| {
      ini_setting { "${::carbon::params::relay_rules_conf} ${section}: ${setting} = ${value}":
        ensure  => present,
        path    => $::carbon::params::relay_rules_conf,
        section => $section,
        setting => $setting,
        value   => $value,
        require => File[$::carbon::params::relay_rules_conf],
      }
    }
  }

  # Iterate over a nested hash of key/value settings for rewrite_rules.conf
  $::carbon::rewrite_rules.each |$section, $settings| {
    $settings.each |$setting, $value| {
      ini_setting { "${::carbon::rewrite_rules_conf} ${section}: ${setting} = ${value}":
        ensure  => present,
        path    => $::carbon::params::rewrite_rules_conf,
        section => $section,
        setting => $setting,
        value   => $value,
        require => File[$::carbon::params::rewrite_rules_conf],
      }
    }
  }

  # Iterate over an array of lines for whitelist.conf
  $::carbon::whitelist.each |$rule| {
    file_line { "${::carbon::params::whitelist_conf}: ${rule}":
      ensure  => present,
      line    => $rule,
      path    => $::carbon::params::whitelist_conf,
      require => File[$::carbon::params::whitelist_conf],
    }
  }

  # Iterate over an array of lines for blacklist.conf
  $::carbon::blacklist.each |$rule| {
    file_line { "${::carbon::params::blacklist_conf}: ${rule}":
      ensure  => present,
      line    => $rule,
      path    => $::carbon::params::blacklist_conf,
      require => File[$::carbon::params::blacklist_conf],
    }
  }

}

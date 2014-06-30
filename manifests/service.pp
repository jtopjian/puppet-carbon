class carbon::service {

  include carbon::params

  if $::carbon::carbon_service_ensure == 'running' {
    $enable = true
  } else {
    $enable = false
  }

  service { 'carbon':
    name       => $::carbon::params::carbon_service_name,
    ensure     => $::carbon::carbon_service_ensure,
    enable     => $enable,
    hasstatus  => true,
    hasrestart => true,
    require    => Package['carbon'],
  }

  case $::lsbdistid {
    'Ubuntu': {
      file_line { '/etc/default/graphite-carbon enable':
        path    => '/etc/default/graphite-carbon',
        match   => '^CARBON_CACHE_ENABLED=',
        line    => 'CARBON_CACHE_ENABLED=true',
        notify  => Service['carbon'],
        require => Package['carbon'],
      }
    }
  }

}

class carbon::install {

  include carbon::params

  package { 'carbon':
    name   => $::carbon::carbon_package_name,
    ensure => $::carbon::carbon_package_ensure,
  }

  package { 'whisper':
    name   => $::carbon::whisper_package_name,
    ensure => $::carbon::whisper_package_ensure,
  }

}

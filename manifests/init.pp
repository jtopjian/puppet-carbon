class carbon (
  $carbon_settings        = {},
  $storage_schemas        = {},
  $storage_aggregation    = {},
  $aggregation_rules      = [],
  $relay_rules            = {},
  $rewrite_rules          = {},
  $whitelist              = [],
  $blacklist              = [],
  $carbon_package_name    = $::carbon::params::carbon_package_name,
  $carbon_package_ensure  = $::carbon::params::carbon_package_ensure,
  $carbon_service_ensure  = $::carbon::params::carbon_service_ensure,
  $whisper_package_name   = $::carbon::params::whisper_package_name,
  $whisper_package_ensure = $::carbon::params::whisper_package_ensure,
  $whisper_storage_dir    = $::carbon::params::whisper_storage_dir,
) inherits carbon::params {
  class{'carbon::install': } ->
  class{'carbon::config': } ~>
  class{'carbon::service': } ->
  Class['carbon']
}

class carbon::params {

  # Package and Service parameters
  case $::osfamily {
    'Debian': {
      $carbon_package_name      = 'graphite-carbon'
      $carbon_package_ensure    = 'latest'
      $carbon_service_name      = 'carbon-cache'
      $carbon_service_ensure    = 'running'

      $whisper_package_name     = 'python-whisper'
      $whisper_package_ensure   = 'latest'
      $whisper_storage_dir      = '/var/lib/graphite/storage/whisper'

      $carbon_conf              = '/etc/carbon/carbon.conf'
      $storage_schemas_conf     = '/etc/carbon/storage-schemas.conf'
      $storage_aggregation_conf = '/etc/carbon/storage-aggregation.conf'
      $aggregation_rules_conf   = '/etc/carbon/aggregation-rules.conf'
      $relay_rules_conf         = '/etc/carbon/relay-rules.conf'
      $rewrite_rules_conf       = '/etc/carbon/rewrite-rules.conf'
      $whitelist_conf           = '/etc/carbon/whitelist.conf'
      $blacklist_conf           = '/etc/carbon/blacklist.conf'

      $graphite_user            = '_graphite'
      $graphite_group           = '_graphite'
    }
  }

}

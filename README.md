# puppet-carbon

A Puppet module for managing the installation of [Carbon](http://graphite.wikidot.com/).

Note that this module does not set up the Graphite web interface or API. This is mostly because I'm tired of trying to wedge Django `local_settings.py` files into Puppet manifests.

## Usage

This module takes a series of hash or array-based parameters. These parameters are used to create the various configuration files that Carbon can use.

```puppet
class { 'carbon':
  carbon_settings => {
    'cache' => {'line_receiver_interface' => '::1'},
  },
  storage_schemas => {
    'stats' => {
      'priority'  => '100',
      'pattern    => '.\*',
      'retentions => '10:2160,60:10080,600:262974',
    },
  },
}
```

Configuration is much cleaner when using Hiera:

```puppet
class { 'carbon':
  carbon_settings => hiera('carbon::settings'),
  storage_schemas => hiera('carbon::storage_schemas'),
}
```

## Notes

This module has only been tested against Ubuntu 14.04

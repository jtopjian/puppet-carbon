# puppet-carbon

A Puppet module for managing the installation of [Carbon](http://graphite.wikidot.com/).

## Usage

This module takes a series of hash or array-based parameters. These parameters are used to create the various configuration files that Carbon can use.

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

Configuration is much cleaner when using Hiera:

  class { 'carbon':
    carbon_settings => hiera('carbon::settings'),
    storage_schemas => hiera('carbon::storage_schemas'),
  }

## Notes

This module has only been tested against Ubuntu 14.04

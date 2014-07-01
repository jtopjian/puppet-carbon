#!/bin/bash
apt-get update
apt-get install -y puppet git
sed -i -e '/\[main\]/a parser = future' /etc/puppet/puppet.conf
sed -i -e '/\[main\]/a evaluator = current' /etc/puppet/puppet.conf
gem install r10k
cd /vagrant/puppet
r10k --verbose 3 puppetfile install

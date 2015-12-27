# == Class: nfsserver
#
# Full description of class nfsserver here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#
#
# $szKickStartBaseDirectory = hiera('KickStartBaseDirectory', '/var/ks')
#
# $szDefaultNfsOptionList =  'ro,no_root_squash'
# $szDefaultNfsClientList = hiera ( 'DefaultNfsClientList' )
#
# $hNfsExports = {
#  "$szKickStartBaseDirectory/configs" => {
#              'NfsOptionList' => "$szDefaultNfsOptionList",
#              'NfsClientList' => "$szDefaultNfsClientList",
#                                         }, 
#  "$szKickStartBaseDirectory" => {
#              'NfsOptionList' => "$szDefaultNfsOptionList",
#              'NfsClientList' => "$szDefaultNfsClientList",
#                                         }, 
#  "$szKickStartImageDirectory" => {
#              'NfsOptionList' => "$szDefaultNfsOptionList",
#              'NfsClientList' => "$szDefaultNfsClientList",
#                                         }, 
# }
# 
# class { 'nfsserver':
#    hohNfsExports => $hNfsExports,
# }
#
# === Authors
#
# Author Name <author@domain.com>
#
# === Copyright
#
# Copyright 2014 Your name here, unless otherwise noted.
#
class nfsserver (
  $hohNfsExports
) {

case $operatingsystem {
  'CentOS': {
            # TODO if this is 7.0 then it might be the same as for Fedora.
            $szNfsServerServiceName = 'nfs'
            package { 'rpcbind':
              ensure => present,
            }
            service { 'rpcbind':
              ensure => running,
              enable => true,
              require => Package[ 'rpcbind' ],
            }
            service { "$szNfsServerServiceName":
              ensure => running,
              enable => true,
              require => [
                           Package[ 'nfs-utils' ],
                           Service[ 'rpcbind' ],
                         ],
            }
          }
  'Fedora': {
            $szNfsServerServiceName = 'nfs-server'
            service { "$szNfsServerServiceName":
              ensure => running,
              enable => true,
              require => Package[ 'nfs-utils' ],
            }
          }
  default: { fail("!!! Unrecognized operating system '$operatingsystem' for nfsserver") }
}

file { '/etc/exports':
  ensure  => present,
  content => template('/etc/puppet/modules/nfsserver/templates/etc_exports.erb'),
  notify  => Service[ "$szNfsServerServiceName" ],
}

package { 'nfs-utils':
  ensure => present,
}


}

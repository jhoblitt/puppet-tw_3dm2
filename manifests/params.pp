# == Class: tw_3dm2::params
#
# provides parameters for the tw_3dm2 module
#
# === Authors
#
# Joshua Hoblitt <jhoblitt@cpan.org>
#
# === Copyright
#
# Copyright (C) 2012-2013 Joshua Hoblitt
#

class tw_3dm2::params {

  $emailserver = 'localhost'

  case $::osfamily {
    redhat: {
      $unzip_path = '/root/3ware'
    }
    default: {
      fail("Module ${module_name} is not supported on ${::operatingsystem}")
    }
  }
}

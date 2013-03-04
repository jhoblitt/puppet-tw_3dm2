# == Class: tw_3dm2::config
#
# installs the configuration file for 3dm2
#
# === Authors
#
# Joshua Hoblitt <jhoblitt@cpan.org>
#
# === Copyright
#
# Copyright (C) 2012-2013 Joshua Hoblitt
#

class tw_3dm2::config inherits tw_3dm2 {
  file { '/etc/3dm2/3dm2.conf':
    owner   => root,
    group   => root,
    mode    => '0644',
    content => template("${module_name}/3dm2.conf.erb"),
    require => Class['tw_3dm2::install'],
    notify  => Class['tw_3dm2::service'],
  }
}

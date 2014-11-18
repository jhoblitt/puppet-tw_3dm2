# == Class: tw_3dm2::install
#
# installs the package that provides 3dm2
#
# === Authors
#
# Joshua Hoblitt <jhoblitt@cpan.org>
#
# === Copyright
#
# Copyright (C) 2012-2013 Joshua Hoblitt
#

class tw_3dm2::install inherits tw_3dm2 {
  include wget

  file { $unzip_path:
    ensure => directory,
  }

  wget::fetch { $package_filename:
    source      => $package_url,
    destination => "${unzip_path}/${package_filename}",
    timeout     => 30,
    require     => File[$unzip_path],
  }

  exec { "unzip ${package_filename}":
    alias   => '3dm2.unzip',
    path    => ['/bin', '/usr/bin'],
    cwd     => $unzip_path,
    creates => "${unzip_path}/install.sh",
    require => Wget::Fetch[$package_filename],
  }

  exec { 'sh install.sh --install -fN0Y':
    path    => ['/bin', '/usr/bin'],
    cwd     => $unzip_path,
    creates => '/usr/sbin/3dm2',
    require => Exec['3dm2.unzip'],
  }
}

# == Class: 3dm2
#
# This module downloads via wget, unzips, installs, and configures the 3ware
# 3dm2/tdm2 RAID controller management software
#
# === Parameters
#
# package_url
#   url to fetch package zip file from
#
# package_filename
#   name of zip file
#
# unzip_path
#   absolute file path in which to unpack the zip file - defaults to
#   '/root/3ware'
#
# === Examples
#
#  class{ '3dm2':
#    package_filename  => '3DM2_CLI-Linux_10.2.1_9.5.4.zip',
#    package_url       => 'http://example.org/3DM2_CLI-Linux_10.2.1_9.5.4.zip',
#  }
#
# === Authors
#
# Joshua Hoblitt <jhoblitt@cpan.org>
#
# === Copyright
#
# Copyright (C) 2012 Joshua Hoblitt
#

class 3dm2 (
  $package_url,
  $package_filename,
  $unzip_path = $3dm2::params::unzip_path,
#  $ensure = 'present',
) inherits 3dm2::params
{
  validate_string($package_url)
  validate_string($package_filename)
  validate_absolute_path($unzip_path)
#  validate_re($ensure, '^present$|^absent$')

  class{'3dm2::install': } ->
  class{'3dm2::config': } ->
  class{'3dm2::service': } ->
  Class['3dm2']
}

# == Class: tw_3dm2
#
# This module downloads via wget, unzips, installs, and configures the 3ware
# 3dm2/tdm2 & tw_cli RAID controller management software
#
# === Parameters
#
# package_url
#   url to fetch package zip file from
#
# package_filename
#   name of zip file
#
# emailserver
#   sets the 3dm2.conf EmailServer variable - defaults to $::domain
#
# unzip_path
#   absolute file path in which to unpack the zip file - defaults to
#   '/root/3ware'
#
# === Examples
#
#  class{ 'tw_3dm2':
#    package_filename  => '3DM2_CLI-Linux_10.2.1_9.5.4.zip',
#    package_url       => 'http://example.org/3DM2_CLI-Linux_10.2.1_9.5.4.zip',
#    emailserver       => 'mail.example.org',
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

class tw_3dm2 (
  $package_url,
  $package_filename,
  $emailserver = $::domain,
  $unzip_path = $tw_3dm2::params::unzip_path,
#  $ensure = 'present',
) inherits tw_3dm2::params
{
  validate_string($package_url)
  validate_string($package_filename)
  validate_absolute_path($unzip_path)
#  validate_re($ensure, '^present$|^absent$')

  class{'tw_3dm2::install': } ->
  class{'tw_3dm2::config': } ->
  class{'tw_3dm2::service': } ->
  Class['tw_3dm2']
}

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

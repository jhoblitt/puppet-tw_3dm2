class tw_3dm2::params {

  case $::osfamily {
    redhat: {
      $unzip_path = '/root/3ware'
    }
    default: {
      fail("Module ${module_name} is not supported on ${::operatingsystem}")
    }
  }
}

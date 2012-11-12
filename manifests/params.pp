class 3dm2::params {

  case $::osfamily {
    redhat: {
      $unzip_path       = '/root/3ware'
    }
    default: {
      fail()
    }
  }
}

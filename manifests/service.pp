class 3dm2::service {
  service { 'tdm2':
    enable      => true,
    ensure      => running,
    hasrestart  => true,
    hasstatus   => true,
  }
}

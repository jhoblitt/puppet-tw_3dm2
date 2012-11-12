class 3dm2::config {
  file { '/etc/3dm2/3dm2.conf':
    owner   => root,
    group   => root,
    mode    => 0644,
    content => template('3dm2/3dm2.conf.erb'),
    require => Class['3dm2::install'],
    notify  => Class['3dm2::service'],
  }
}

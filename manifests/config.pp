class tw_3dm2::config {
  file { '/etc/3dm2/3dm2.conf':
    owner   => root,
    group   => root,
    mode    => 0644,
    content => template("${module_name}/3dm2.conf.erb"),
    require => Class['tw_3dm2::install'],
    notify  => Class['tw_3dm2::service'],
  }
}

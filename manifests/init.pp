class  rsyslog( $remotelogger  = $rsyslog::params::remotelogger ) inherits rsyslog::params {
 
  ensure_packages ( ['rsyslog' ] )  
  service { 'rsyslog':
    name       => 'rsyslog',
    ensure     => running,
    enable     => true,
    hasrestart => true,
    hasstatus  => true,
    require => Package['rsyslog']
  }

#  notify { "logging to $remotelogger" : }

  if ( "$remotelogger" == "pplogger") {


   file { '/etc/rsyslog.conf' :
    source  => "puppet:///modules/$module_name/rsyslog.conf.local",
    ensure  => 'present',
    mode    => '0644',
    owner   => 'root',
    group   => 'root', 
    notify => Service['rsyslog']
   }
  } 

  else {
   file { '/etc/rsyslog.conf' :
    source  => "puppet:///modules/$module_name/rsyslog.conf.grid",
    ensure  => 'present',
    mode    => '0644',
    owner   => 'root',
    group   => 'root',
    notify => Service['rsyslog']
   }
  }
}

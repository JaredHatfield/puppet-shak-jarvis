# = Class: shak-jarvis
#
# Manages shak-jarvis.
#
#
class shak-jarvis(
  $app_file,
  $java_path,
  $awsaccesskey,
  $awssecretkey,
  $queueurl,
  $dburl,
  $dbuser,
  $dbpassword,
  $pushover = '',
  $ensure = true) {

  jsvc::deamon { 'shak-jarvis':
    ensure          => $ensure,
    jsvc_name       => 'shak-jarvis',
    jsvc_class_path => '/etc/shak-jarvis/shak-jarvis.jar',
    jsvc_class      => 'com.unitvectory.shak.jarvis.App',
    jsvc_java_home  => $java_path,
  }

  file { '/etc/shak-jarvis/shak-jarvis.jar':
    ensure => file,
    owner  => root,
    group  => root,
    mode   => '0755',
    source => $app_file,
    notify => Service['shak-jarvis'],
  }

  file { '/etc/shak-jarvis/config.xml':
    owner   => root,
    group   => root,
    mode    => '0644',
    content => template('shak-jarvis/config.xml.erb'),
    notify  => Service['shak-jarvis'],
  }
}

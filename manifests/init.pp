
class shak-jarvis(
  $app_file,
  $java_path,
  $awsaccesskey,
  $awssecretkey,
  $queueurl,
  $dburl,
  $dbuser,
  $dbpassword,
  $ensure = running) {

  class { 'jsvc::deamon':
    jsvc_name       => 'shak-jarvis',
    jsvc_class_path => "/etc/shak-jarvis/shak-jarvis.jar",
    jsvc_class      => "com.unitvectory.shak.jarvis.App",
    jsvc_java_home  => $java_path,
    ensure          =>  $ensure,
  }

  file { "/etc/shak-jarvis/shak-jarvis.jar":
    ensure => file,
    owner  => root,
    group  => root,
    mode   => 755,
    source => $app_file,
    notify => Service['shak-jarvis'],
  }

  file { "/etc/shak-jarvis/config.xml":
    owner   => root,
    group   => root,
    mode    => 644,
    content => template("shak-jarvis/config.xml.erb"),
    notify  => Service['shak-jarvis'],
  }
}

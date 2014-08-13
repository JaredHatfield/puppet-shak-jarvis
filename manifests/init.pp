
class shak-jarvis(
  $app_file,
  $java_path
  $awsaccesskey,
  $awssecretkey,
  $queueurl,
  $dburl,
  $dbuser,
  $dbpassword) {

  jsvc::deamon { 'jarvis-shak':
    jsvc_name       => 'jarvis-shak',
    jsvc_class_path => "/etc/jarvis-shak/shak-jarvis.jar",
    jsvc_class      => "com.unitvectory.shak.jarvis.App",
    jsvc_java_home  => $java_path,
  }

  file { "/etc/jarvis-shak/shak-jarvis.jar":
    ensure => file,
    owner  => root,
    group  => root,
    mode   => 755,
    source => $app_file,
    notify => Service['jarvis-shak'],
  }

  file { "/etc/jarvis-shak/config.xml":
    owner   => root,
    group   => root,
    mode    => 644,
    content => template("shak-jarvis/config.xml.erb"),
    notify  => Service['jarvis-shak'],
  }
}

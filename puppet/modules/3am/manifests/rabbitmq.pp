class 3am::rabbitmq {

  include ::rabbitmq

  rabbitmq_user { 'sensu':
    admin    => false,
    password => hiera('rabbitmq_user_sensu_password'),
  }

  rabbitmq_vhost { 'sensu':
    ensure => present,
  }

  rabbitmq_user_permissions { 'sensu@sensu':
      configure_permission => '.*',
      read_permission      => '.*',
      write_permission     => '.*',
  }

  file {
    '/etc/rabbitmq/ssl/cacert.pem':
      owner   => 'rabbitmq',
      group   => 'rabbitmq',
      mode    => '0400',
      source  => 'puppet:///modules/ssl_certs/cacert.pem';

    '/etc/rabbitmq/ssl/cert.pem':
      owner   => 'rabbitmq',
      group   => 'rabbitmq',
      mode    => '0400',
      source  => 'puppet:///modules/ssl_certs/rabbitmq_cert.pem';

    '/etc/rabbitmq/ssl/key.pem':
      owner   => 'rabbitmq',
      group   => 'rabbitmq',
      mode    => '0400',
      source  => 'puppet:///modules/ssl_certs/rabbitmq_key.pem';
  }

}

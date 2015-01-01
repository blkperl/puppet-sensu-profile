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

  sensu::check { 'check_rabbitmq-cluster-health':
    command     => '/etc/sensu/plugins/sensu-community-plugins/plugins/rabbitmq/rabbitmq-cluster-health.rb',
    handlers    => 'default',
    subscribers => 'rabbitmq'
  }

}

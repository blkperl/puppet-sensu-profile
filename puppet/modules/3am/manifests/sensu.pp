class 3am::sensu {

  include ::redis

  package { 'ruby1.9.1-dev':
    ensure => present,
  }

  class { '::sensu':
    api                  => true,
    purge_config         => true,
    rabbitmq_password    => 'yolosensu',
    rabbitmq_ssl         => false,
    server               => true,
    use_embedded_ruby    => true,
    rabbitmq_host        => 'localhost',
    sensu_plugin_version => present,
    subscriptions        => ['rabbitmq', 'uchiwa'],
  }

  Class['::redis'] -> Class['::sensu']
}

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
    subscriptions        => ['general', 'rabbitmq', 'uchiwa'],
  }

  Class['::redis'] -> Class['::sensu']

  package { 'rest_client':
    ensure   => 'installed',
    provider => sensu_gem,
  }

  vcsrepo { '/etc/sensu/plugins/sensu-community-plugins':
    ensure   => present,
    provider => git,
    source   => 'https://github.com/sensu/sensu-community-plugins',
  }


  sensu::check { 'check_load':
    command     => '/etc/sensu/plugins/sensu-community-plugins/plugins/system/check-load.rb',
    handlers    => 'default',
    subscribers => 'general'
  }

  sensu::check { 'check_disk':
    command     => '/etc/sensu/plugins/sensu-community-plugins/plugins/system/check-disk.rb',
    handlers    => 'default',
    subscribers => 'general'
  }

  sensu::check { 'check_cpu':
    command     => '/etc/sensu/plugins/sensu-community-plugins/plugins/system/check-cpu.rb',
    handlers    => 'default',
    subscribers => 'general'
  }

  sensu::check { 'check_mem':
    command     => '/etc/sensu/plugins/sensu-community-plugins/plugins/system/check-mem.sh',
    handlers    => 'default',
    subscribers => 'general'
  }




}

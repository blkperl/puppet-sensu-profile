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
    subscriptions        => ['system_checks', 'service_rabbitmq_checks', 'service_uchiwa_checks'],
  }

  Class['::redis'] -> Class['::sensu']

  package { 'rest_client':
    ensure   => 'installed',
    provider => sensu_gem,
  }

  package { 'git':
    ensure => present,
  }

  vcsrepo { '/etc/sensu/sensu-community-plugins':
    ensure   => present,
    provider => git,
    source   => 'https://github.com/sensu/sensu-community-plugins',
    require => Package['git'],
  }

  sensu::handler { 'slack':
    command => '/etc/sensu/plugins/sensu-community-plugins/handlers/notification/slack.rb',
    config  => hiera('slack_config'),
    severities => ['warning', 'critical', 'unknown']
  }

}

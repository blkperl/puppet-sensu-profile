class 3am::sensu::server {

  include ::apt
  include ::redis
  include 3am::rabbitmq
  include 3am::sensu::dashboard
  include 3am::sensu::plugins
  include 3am::sensu::handlers

  class { '::sensu':
    api                      => true,
    purge_config             => true,
    rabbitmq_ssl             => true,
    rabbitmq_ssl_private_key => 'puppet:///modules/ssl_certs/sensu_key.pem',
    rabbitmq_ssl_cert_chain  => 'puppet:///modules/ssl_certs/sensu_cert.pem',
    server                   => true,
    use_embedded_ruby        => true,
    sensu_plugin_version     => present,
    subscriptions            => ['system_checks', 'service_rabbitmq_checks', 'service_uchiwa_checks'],
  }

  Class['::redis'] -> Class['3am::rabbitmq'] -> Class['::sensu']


  # TODO: the check doesn't support SSL
  # TODO: Move this somewhere more approriate
  # sensu::check { 'check_rabbitmq-cluster-health':
  #  command     => '/etc/sensu/sensu-community-plugins/plugins/rabbitmq/rabbitmq-cluster-health.rb',
  #  handlers    => 'slack',
  #  subscribers => 'service_rabbitmq_checks'
  # }

  # TODO: Move this somewhere more approriate
  sensu::check { 'check_uchiwa-health':
    command     => '/etc/sensu/sensu-community-plugins/plugins/uchiwa/uchiwa-health.rb',
    handlers    => 'default',
    subscribers => 'service_uchiwa_checks'
  }

}

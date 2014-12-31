
#/opt/sensu/embedded/bin/gem install rest_client --no-ri --no-rdoc

class { 'rabbitmq':
  config_cluster    => true,
  cluster_nodes     => ['derp1', 'derp2'],
  cluster_node_type => 'ram',
  erlang_cookie     => 'derpderp',
  wipe_db_on_cookie_change => true,
}

rabbitmq_user { 'sensu':
  admin    => false,
  password => 'yolosensu',
}

rabbitmq_vhost { 'sensu':
  ensure => present,
}

rabbitmq_user_permissions { 'sensu@sensu':
    configure_permission => '.*',
    read_permission => '.*',
    write_permission => '.*',
  }

include ::redis

  class { '::sensu':
    api               => true,
    purge_config      => true,
    rabbitmq_password => 'yolosensu',
    rabbitmq_ssl      => false,
    server            => true,
    use_embedded_ruby => true,
    rabbitmq_host      => 'localhost',
    sensu_plugin_version => present,
    subscriptions => ['rabbitmq', 'uchiwa'],
  }

  $uchiwa_api_config = [{
                          host  => 'derp1',
                        },
                       ]

  class { 'uchiwa':
    sensu_api_endpoints => $uchiwa_api_config,
    install_repo => false,
  }

package {'ruby1.9.1-dev':
	ensure => present,
}

      sensu::check { 'check_uchiwa-health':
        command     => '/etc/sensu/plugins/plugins/uchiwa/uchiwa-health.rb',
        handlers    => 'default',
        subscribers => 'uchiwa'
      }

      sensu::check { 'check_rabbitmq-cluster-health':
        command     => '/etc/sensu/plugins/plugins/rabbitmq/rabbitmq-cluster-health.rb',
        handlers    => 'default',
        subscribers => 'rabbitmq'
      }

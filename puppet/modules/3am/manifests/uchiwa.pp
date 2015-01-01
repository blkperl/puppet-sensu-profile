class 3am::uchiwa {

  contain ::uchiwa

  sensu::check { 'check_uchiwa-health':
    command     => '/etc/sensu/plugins/plugins/uchiwa/uchiwa-health.rb',
    handlers    => 'default',
    subscribers => 'uchiwa'
  }

}

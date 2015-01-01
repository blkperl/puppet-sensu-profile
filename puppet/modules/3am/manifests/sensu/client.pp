class 3am::sensu::client {
  include 3am::sensu
  include 3am::checks

  class { '::sensu':
    subscriptions     => 'system_checks',
    use_embedded_ruby => true,
   }

}

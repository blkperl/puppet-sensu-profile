class 3am {
  class { 'sensu':
    rabbitmq_host => 'derp1',
    subscriptions => 'general',
   }
}

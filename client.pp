
       class { 'sensu':
         rabbitmq_password  => 'yolosensu',
         rabbitmq_host      => 'derp1',
         subscriptions      => 'watchers',
       }

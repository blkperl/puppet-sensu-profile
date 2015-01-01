class 3am::sensu::client (
  $subscriptions = 'system_checks'
) {
  include 3am::sensu::plugins

  class { '::sensu':
    subscriptions     => $subscriptions,
    use_embedded_ruby => true,
   }
}

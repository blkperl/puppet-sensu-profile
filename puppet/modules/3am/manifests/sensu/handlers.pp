class 3am::sensu::handlers {

  $handlers = hiera('sensu_handlers')
  $handler_defaults= hiera('sensu_handler_defaults')

  # creates sensu::handler resources from the hash in Hiera
  create_resources(sensu::handler, $handlers, $handler_defaults)

}

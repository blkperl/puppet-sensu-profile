class 3am::sensu::standalone_checks {

  $checks = hiera('sensu_standalone_checks')
  $check_defaults = hiera('sensu_standalone_check_defaults')

  # creates sensu::check resources from the hash in Hiera
  create_resources(sensu::check, $checks, $check_defaults)

}

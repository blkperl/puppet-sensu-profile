class 3am::checks {

 $checks = hiera('checks')
 $check_defaults = hiera('check_defaults')

 create_resources(sensu::check, $checks, $check_defaults)

}

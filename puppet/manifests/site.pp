# sensu master servers
node /^sensu\d+$/
{
  include 3am::sensu::server
}

# stats servers
node /stats\d+$/ {
  include 3am::sensu::client
  include 3am::sensu::standalone_checks
}

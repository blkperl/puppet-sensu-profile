# sensu master servers
node /^sensu\d+$/
{
  include 3am::sensuservers
}

# stats servers
node /stats\d+$/ {
  include 3am
}

# rabbitmq / sensu master servers
node
  'derp1',
  'derp2'
{
  include 3am::sensuservers
}

# sensu client
node 'derpchild1' {
  include 3am
}

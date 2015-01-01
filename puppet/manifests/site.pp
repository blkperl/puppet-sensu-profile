
# rabbitmq / sensu master servers
node
  'derp1',
  'derp2'
{
  include apt
  include 3am::rabbitmq
  include 3am::sensu
  include 3am::uchiwa

  Class['3am::rabbitmq'] -> Class['3am::sensu'] -> Class['3am::uchiwa']
}

node 'derpchild1' {

}

# TODO
#/opt/sensu/embedded/bin/gem install rest_client --no-ri --no-rdoc


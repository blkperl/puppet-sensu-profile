class 3am::sensuservers {

  include ::apt
  include ::redis
  include 3am::rabbitmq
  include 3am::sensu
  include 3am::uchiwa
  include 3am::checks

  Class['3am::rabbitmq'] -> Class['3am::sensu'] -> Class['3am::uchiwa']

}

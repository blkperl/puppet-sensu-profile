class 3am::sensu::plugins {

  package { 'ruby1.9.1-dev':
    ensure => present,
  }

  package { 'rest_client':
    ensure   => 'installed',
    provider => sensu_gem,
  }

  package { 'git':
    ensure => present,
  }

  # Install the community plugins
  vcsrepo { '/etc/sensu/sensu-community-plugins':
    ensure   => present,
    provider => git,
    source   => 'https://github.com/sensu/sensu-community-plugins',
    require  => Package['git'],
  }

  $checks = hiera('checks')
  $check_defaults = hiera('check_defaults')

  # creates sensu::check resources from the hash in Hiera
  create_resources(sensu::check, $checks, $check_defaults)

}

class 3am {
  include 3am::checks

  class { '::sensu':
    subscriptions => 'system_checks',
    use_embedded_ruby    => true,
   }

  package { 'git':
    ensure => present,
  }

  vcsrepo { '/etc/sensu/sensu-community-plugins':
    ensure   => present,
    provider => git,
    source   => 'https://github.com/sensu/sensu-community-plugins',
    require => Package['git'],
  }

}

class disco::install {
    include anaconda
    
    # Fix:  Make this a parameter -- Disco needs large storage inside of here
    $disco_home = "${disco::anaconda_install}/var/disco"

    # Symlink init script
    file { "/etc/init.d/disco":
        ensure => link,
        target => "${disco::anaconda_install}/etc/init.d/disco",
        require => Class['anaconda'],
    }

    user { disco:
            comment => "created by puppet",
            home => "$disco_home",
            shell => "/bin/bash",
            managehome => true,
     }

     file { $disco_home:
        ensure => directory,
        owner => 'disco',
        group => 'disco',
        mode => 0755,
        require => [ User["disco"], Class['anaconda'] ],
     }

     file { "${disco_home}/.ssh":
        ensure => directory,
        owner => 'disco',
        group => 'disco',
        mode => 0700,
        require => File[$disco_home],
     }

     file { ".erlang.cookie":
        ensure => present,
        owner => 'disco',
        group => 'disco',
        mode => 0500,
        path => "${disco_home}/.erlang.cookie",
        content => "${disco::erlang_cookie}",
        require => Class['anaconda'],
     }

     file { "${disco_home}/.bashrc":
        ensure => directory,
        owner => 'disco',
        group => 'disco',
        mode => 0755,
        source => 'puppet:///modules/disco/disco_bashrc',
        require => Class['anaconda'],
     }

     file { "${disco_home}/.bash_profile":
        ensure => present,
        owner => 'disco',
        group => 'disco',
        mode => 0755,
        content => '. ~/.bashrc',
        require => File["${disco_home}/.bashrc"],
     }


     # Fix:  Private key in files
     file { "disco_id_rsa":
        ensure => present,
        owner => 'disco',
        group => 'disco',
        mode => 0500,
        source => "puppet:///modules/disco/id_rsa",
        path => "${disco_home}/.ssh/id_rsa",
        require => File["${disco_home}/.ssh"],
     }

     # Fix: Make a configuration parameter
     ssh_authorized_key{ "disco_pub_key":
        ensure => present,
        key => "AAAAB3NzaC1yc2EAAAABIwAAAQEAsUB2iQq1mRSvADi+4yb4uMJMs1onD++NTCCS8v2hdWtBJwhRBWp7Gqp7WvN2wff0dyvQyJM1qd+RQ/XhRSBBm7maW539VwJLVav8KmMrtnEuPUk/z4uArA+5N+SbYYeOzrHSwWrGCWZa95AfRl8YVeqWZG/DDRdFF0qjRf/IVYr4Vm/aqblT0RNbHW1c0iZVQGyK5INQTl8ZwgzZv4tqjQn4faddt7yR1EhEgK0tO4tqtEKzuY4sp4IIhyHq/TGKtbYVCRURhmBpThQRqcK91Lpp+yJoDjwXkdpufgreJUe/tUVug4XjUE3SxpTX81s2XO+RWAZtXVS/D8ukpFwhUQ==",
        type => "rsa",
        user => "disco",
        require => File["${disco_home}/.ssh"],
     }
}


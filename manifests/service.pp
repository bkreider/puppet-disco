class disco::service {

    if $disco::master == true {
        service { "disco":
            ensure => running,
            hasstatus => true,
            hasrestart => true,
            enable => true,
            path => "${anaconda_install}/etc/init.d",
        }

    }
}

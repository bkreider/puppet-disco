# Erlang cookie is a big hack and should be autogenerated and pushed out to the
# slave nodes

class disco ($master = false, $anaconda_install = "/opt/anaconda",
            $erlang_cookie = "fjiuapfKf87SF") {
    include disco::install, disco::config, disco::service
}
    

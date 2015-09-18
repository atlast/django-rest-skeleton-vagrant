class nginx {
    package { 'nginx':
        ensure => latest
    }

    file { "/etc/nginx/nginx.conf":
        ensure  => link,
        target  => "/vagrant/puppet/templates/conf.d/nginx.conf.erb",
        notify  => Service["nginx"],
        require => Package["nginx"],
    }

    file { "/etc/nginx/sites-enabled/app":
        ensure  => link,
        target  => "/vagrant/puppet/templates/conf.d/app.conf.erb",
        notify  => Service["nginx"],
        require => Package["nginx"]
    }

    service { "nginx":
        ensure            => running,
        hasrestart        => true,
        require           => Package["nginx"]
    }
}
class gunicorn {
    file { '/etc/systemd/system/django-app.service':
        ensure => file,
        content => template('/vagrant/puppet/templates/service/django-app.service')
    }

    file { '/lib/systemd/system/django-app.service':
        ensure => file,
        content => template('/vagrant/puppet/templates/service/django-app.service')
    }

    service { 'django-app.service':
        provider => systemd,
        ensure => running,
        enable => true,
        require => [File['/etc/systemd/system/django-app.service'], File['/lib/systemd/system/django-app.service']]
    }
}
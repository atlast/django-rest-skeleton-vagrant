node default {
    class { 'aptupdate': stage => 'aptupdate' }
    class { 'python': stage => 'py' }
    class { 'application': }
    class { 'nginx::override': }
    class { 'nginx::service-override': }
}

stage { 'aptupdate': before => Stage['py'] }
class aptupdate {
    exec { 'apt-get update':
        command => '/usr/bin/apt-get update'
    }
}

stage { 'py': before => Stage['main'] }
class python {
    package {
        'python-dev': ensure => latest;
        'python': ensure => latest;
        'python-pip': ensure => installed;
        'python-virtualenv': ensure => installed;
        'virtualenvwrapper': ensure => installed;
    }
}

stage { 'nginx::override': before => Stage['main'] }
class nginx::override inherits nginx::config {
    File['/etc/nginx/nginx.conf'] {
        content => template('/vagrant/templates/conf.d/nginx.conf.erb'),
    }
}

stage { 'nginx::service-override': before => Stage['main'] }
class nginx::service-override inherits nginx::service {
    Service["nginx"] {
        provider => systemd
    }
}

class application {
    package {
        'screen': ensure => installed;
        # 'uwsgi': ensure => installed;
        # 'uwsgi-plugin-python': ensure => installed, require => Package['uwsgi'];
        # 'libmysqlclient-dev': ensure => installed;
    }
    class { 'nginx': }
    # class { 'mysql::server':
    #     config_hash => { 'root_password' => '' }
    # }

    exec { 'create virtual environment':
        command => '/usr/bin/virtualenv -p /usr/bin/python3 /home/vagrant/.virtualenvs/app',
        creates => '/home/vagrant/.virtualenvs/app',
        user => 'vagrant',
        require => Package['virtualenvwrapper']
    }

    exec { 'install pip dependencies':
        command => '/home/vagrant/.virtualenvs/app/bin/pip install -r /vagrant/site/requirements/development.txt',
        user => 'vagrant',
        require => Exec['create virtual environment']
    }

    file { '/etc/systemd/system/django-app.service':
        ensure => file,
        content => template('/vagrant/templates/service/django-app.service')
    }

    file { '/lib/systemd/system/django-app.service':
        ensure => file,
        content => template('/vagrant/templates/service/django-app.service')
    }

    service { 'django-app.service':
        provider => systemd,
        ensure => running,
        enable => true,
        require => [Exec['install pip dependencies'], File['/etc/systemd/system/django-app.service'], File['/lib/systemd/system/django-app.service']]
    }

    file { '/etc/nginx/sites-enabled/app':
        ensure => 'link',
        target => '/vagrant/templates/conf.d/app.conf.erb',
    }
}
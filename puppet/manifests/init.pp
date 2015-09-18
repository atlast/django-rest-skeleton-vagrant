node default {
    class { 'aptupdate': stage => 'aptupdate' }
    class { 'python': stage => 'python' }
    class { 'nginx': }
    class { 'gunicorn': }
}

stage { 'aptupdate': before => Stage['python'] }
class aptupdate {
    exec { 'apt-get update':
        command => '/usr/bin/apt-get update'
    }
}

stage { 'python': before => Stage['main'] }
class python {
    package {
        'python-dev': ensure => latest;
        'python': ensure => latest;
        'python-pip': ensure => installed;
        'python-virtualenv': ensure => installed;
        'virtualenvwrapper': ensure => installed;
    }

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
}
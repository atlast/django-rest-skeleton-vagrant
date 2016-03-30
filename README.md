# Django/Rest Framework Skeleton Vagrant #

This repository is for rapidly setting up a Django/Rest Framework development environment.

### Prerequisites ###

* [VirtualBox](https://www.virtualbox.org/wiki/Downloads)
* [Vagrant](http://www.vagrantup.com/downloads.html)
* [Git](http://git-scm.com/book/en/v2/Getting-Started-Installing-Git) - *Mac users may want to install [X-Code](https://developer.apple.com/xcode/downloads/) and [X-Code Command Line Tools](http://osxdaily.com/2014/02/12/install-command-line-tools-mac-os-x/)*

### Installation ###

* Clone this repo and all of its submodules
~~~
git clone --recursive https://github.com/chrislondon/django-rest-skeleton-vagrant.git
~~~

* Run Vagrant from inside the `django-rest-skeleton-vagrant` repo folder
~~~
vagrant up
~~~

### Vagrant Quick Tips ###

* Start your Vagrant box. Use this anytime you need to start the box: after suspend, or halt, or destroy.
~~~
vagrant up
~~~

* Suspend your Vagrant box. This will save your machine's current state until you start it again.
~~~
vagrant suspend
~~~

* Halt your Vagrant box. This will shut down your virtual machine.
~~~
vagrant halt
~~~

* Destroy your Vagrant box. This completely obliterates your virtual machine. When you start Vagrant again it will install everything again from scratch
~~~
vagrant destroy
~~~

* Reload Vagrant config. If you make changes to the `Vagrantfile` you will need to reload Vagrant with this command.
~~~
vagrant reload
~~~

* SSH into your Vagrant box.
~~~
vagrant ssh
~~~

### Using this repo ###

My goal is to make this repo a good springboard for starting any Django/REST Framework app.  Feel free to
send me any suggestions and let me know how it's working for you.

Once you've initiated the code with `vagrant up` (it will take a while because it's downloading a bunch of
dependencies you can view the app at `http://localhost:8000`. If there was a port conflict in spinning up 
vagrant (watch the console output when running `vagrant up`) the site may be on a different port.

I have been having trouble getting puppet to enable the services to run on boot so you may have to run
`vagrant provision` instead of `vagrant reload` to get the app running again.

A default super user is created with the username of `admin` and a password of `password`

### Notes ###

This is still a work in progress. Ask me if you have any questions or need help: me@chrislondon.co

### TODO ###

* Set up Postgresql instead of Sqlite
* Set up frequently used features like registration and forgot password
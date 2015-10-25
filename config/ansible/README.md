## Getting started

### Requirements

1. GitHub account with [ssh key](https://help.github.com/articles/generating-ssh-keys/) from local system.
2. [Ansible](http://www.ansible.com/) `make install_ansible`
2. [VirtualBox](https://www.virtualbox.org/)
3. [Vagrant](https://www.vagrantup.com/downloads.html)
4. [nfs-server](http://help.ubuntu.ru/wiki/nfs)

### Make delelopment environment

```shell
git clone git@github.com:inem/activity-tracker.git
cd activity-tracker
vagrant up
vagrant ssh
cd app
```

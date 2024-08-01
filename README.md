# geOrchestra-ansible

A simple [ansible](http://docs.ansible.com) playbook to deploy a fullblown [geOrchestra](http://www.georchestra.org/) SDI instance.

Right now, this will deploy a working geOrchestra from the **master** branch with mostly default configs and empty databases/datadirs.

## Prerequisite

* Install ansible : 'sudo apt install ansible'
* Debian Bookworm (12.x) VM
* JAVA11 (could use [AdoptOpenJDK](https://adoptopenjdk.net/) project) (marche avec java 17 et pas 11)
* sudo apt install openjdk-17-jdk


* Token access to allow connection from VM to GitHub and allow to get MapStore2 artifact (see playbook.yml)

## setup

In order to deploy all the middleware and components of a geOrchestra instance, you just need to:

 * Clone source :

    `git clone https://github.com/georchestra/ansible.git`

 * use `ansible-galaxy` to install external roles required for geonetwork 4 and set chmod : 

```
sudo chmod -R 777 /home/vittorio/Documents/ansible/roles/

ansible-galaxy install -r requirements.yaml
```


 * setup variables for your own instance in ```playbooks/georchestra.yml```

 * Setup missings keys :
```
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 0E98404D386FA1D9
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 6ED0E7B82643E131
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 605C66F00D6C9793
```

 * Open `hosts` file

 * Replace `IP_OF_YOUR_MACHINE` by the IP of a host where you have `ssh-with-passphrase` root access (ideally, an lxc container, a vm, or whatever suits you) to get something like :

    `mygeorchestra ansible_ssh_host=192.xxx.xx.x`

... and run:
```
sudo ansible-playbook playbooks/georchestra.yml
```

👉 If you run the playbook with a remote access (ssh) you maybe need to run the playbook with this command :

    `ansible-playbook playbook.yml -i hosts --user=<username> --extra-vars "ansible_sudo_pass=<yourPassword>"`

## additional config

- **Set MapStore2-georchestra config extensions**

To import plugins, Tomcat (or Jetty) will need to write into a plugins folder. He can't by default and you get some errors.
In fact, this folder could be the default datadir (/etc/georchestra/datadir) but it's not fully recomended.
> [More details here](http://docs.georchestra.geo-solutions.it/fr/latest/configuration/application/index.html?highlight=extensions#dynamic-files)

So, we suggest you to set an alternative mapstore plugins directory. To do that, open `/etc/default/tomcat-georchestra` and add this JVM option :

`-Dgeorchestra.extensions=/target/path/extensions \`

Don't forget to restart the service next... and be sure this path is writable by tomcat.

If you really want to use datadir, you have to set correct right to the `/mapstore` directory. 

If an `extensions.json` file is missing, just add it manually with empty `{}` json content.

## Setup a web server mail for the georchestra's datafeeder

Install postfix :

```sudo apt install postfix```

Setup postfix :
```
smtpd_relay_restrictions = permit_mynetworks permit_sasl_authenticated defer_unauth_destination
myhostname = Ansible-42.myguest.virtualbox.org
alias_maps = hash:/etc/aliases
alias_database = hash:/etc/aliases
mydestination = $myhostname, localhost, localhost.$mydomain, mail.$mydomain, www.$mydomain, localhost, $mydomain
relayhost = 
mynetworks = 127.0.0.0/8 [::ffff:127.0.0.0]/104 [::1]/128
mailbox_size_limit = 0
recipient_delimiter = +
inet_interfaces = all
inet_protocols = all
```
## cleanup

If you want to remove/cleanup the webapps, databases, LDAP DIT and datadirs, sub-tasks have been added and can be run using

```
ansible-playbook -t cleanup -e "cleanup=true" playbooks/georchestra.yml

```
Those sub-tasks aren't run by default, you need to specify the `cleanup=true` variable.

## example setup with vagrant

Install the dependencies with:
```
sudo apt-get install vagrant virtualbox ansible
```

Optionally, to install the "guest additions", you may run:
```
vagrant plugin install vagrant-vbguest
```

Finally, create a virtual machine and provision it (according to the playbook), with:
```
vagrant up
```

When the machine is provisioned, you can `vagrant ssh` into it, look around, and once you're done, you may halt the machine (`vagrant halt`) or destroy it (`vagrant destroy`).

To browse your SDI, just drop a line in your ```/etc/hosts``` file, registering the IP of the VM with the FQDN you declared in the playbook, eg:
```
192.168.0.19 georchestra.example.org
```
... and open https://georchestra.example.org/geonetwork/ in your browser.

# Serverspec

a serverspec testsuite is provided to test the vagrant environments Once the box is up (see previous section),
you can test the setup with the following command:

```
$ rake spec
```

This will require the `ruby-serverspec` package to be installed on the host.


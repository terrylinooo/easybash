# ![Ubuntu Logo](https://i.imgur.com/kf8Oeno.png) Easy bash for Ubuntu

Seeking a solution for easy deployment of a new Ubuntu machine with LAMP or LEMP stacks? Here it is.

Easybash is a tool for fully automatic installation of the most popular and useful packages to their latest versions on Ubuntu servers.

### Supported Ubuntu Versions

Easybash has been tested and can be used on the following LTS versions.

- [Ubuntu 16.04 (Xenial Xerus)](https://github.com/terrylinooo/easybash/tree/master/ubuntu/16.04)
- [Ubuntu 18.04 (Bionic Beaver)](https://github.com/terrylinooo/easybash/tree/master/ubuntu/18.04)
- [Ubuntu 20.04 (Focal Fossa)](https://github.com/terrylinooo/easybash/tree/master/ubuntu/20.04)
- [Ubuntu 22.04 (Jammy Jellyfish)](https://github.com/terrylinooo/easybash/tree/master/ubuntu/22.04)

## :link: [Website](https://easybash.github.io/) :link:

---

## Packages

| Package | Category |
| --- | --- |
| Apache | A |
| Nginx | E |
| MairaDB | M |
| MySQL | M |
| PHP-FPM | P |

### MySQL Secure Installation

Easybash also does what the `secure_mysql_installation` shell script does. Please check out the examples in the MySQL/MariaDB section.

## How to Use

- Wizard
- Config
- Standalone

### Wizard Mode

![](https://i.imgur.com/42dErDQ.gif)
Wizard mode will ask you several questions to configure settings and then proceed to install the LEMP or LAMP stacks.

#### Download and Run
```
wget https://easybash.github.io/easybash.tar.gz
tar -zxvf easybash.tar.gz
cd easybash-latest
./easybash.sh
```


### Config Mode 

Config mode installs the entire LAMP or LEMP stack according to the config.yml configuration file.

#### Download
```
wget https://easybash.github.io/easybash.tar.gz
tar -zxvf easybash.tar.gz
cd easybash-latest
```
#### Configure

```
./easybash.sh init
```
Edit `config.yml` to choose packages to install.
```
vi config.yml
```
#### Run
```
./easybash.sh install
```

That's it. Easybash will install packages which defined in `install` section in `config.yml`

---

### Standalone Mode

Standalone mode uses the bash command set of the package directly for installation, installing one package service at a time.

#### Nginx

Download

```shell
# Ubuntu 16.04 LTS
wget https://easybash.github.io/ubuntu/16.04/nginx.sh
# Ubuntu 18.04 LTS
wget https://easybash.github.io/ubuntu/18.04/nginx.sh
# Ubuntu 20.04 LTS
wget https://easybash.github.io/ubuntu/20.04/nginx.sh
# Ubuntu 22.04 LTS
wget https://easybash.github.io/ubuntu/22.04/nginx.sh
```

Options

```
 SYNOPSIS

    nginx.sh [-h] [-i] [-v [version]]

 OPTIONS

    -v ?, --version=?    Which version of Nginx you want to install?
                         Accept vaule: stable, mainline, system
                         
    -h, --help           Print this help.
    -i, --info           Print script information.

    --aptitude           Use aptitude instead of apt-get as package manager

 EXAMPLES

    $ ./nginx.sh -v stable
    $ ./nginx.sh --version=mainline
    $ ./nginx.sh
```

#### MariaDB

Download

```shell
# Ubuntu 16.04 LTS
wget https://easybash.github.io/ubuntu/16.04/mariadb.sh
# Ubuntu 18.04 LTS
wget https://easybash.github.io/ubuntu/18.04/mariadb.sh
# Ubuntu 20.04 LTS
wget https://easybash.github.io/ubuntu/20.04/mariadb.sh
# Ubuntu 22.04 LTS
wget https://easybash.github.io/ubuntu/22.04/mariadb.sh
```

Options

```
 SYNOPSIS

    mysql.sh [-h] [-p [password]] [-s [y|n]] [...]

 OPTIONS

    -w ?, --password=?            Set mysql root password.
    -s ?, --secure=?              Enable mysql secure configuration.
                                  Accept vaule: y, n
    -r ?, --remote=?              Enable access mysql remotely.
                                  Accept vaule: y, n
    -u ?, --remote-user=?         Remote user.
    -p ?, --remote-password=?     Remote user's password.
    -v ?, --version=?             Which version of MariaDB you want to install?
                                  Accept vaule: latest, system
    -h, --help                    Print this help.
    -i, --info                    Print script information.

    --aptitude                    Use aptitude instead of apt-get as package manager

 EXAMPLES

    $ ./mariadb.sh -v latest -s y -r y -u test_user -p 12345678
    $ ./mariadb.sh --version=system --secure=y --remote=y --remote-user=test_user --remote-password=12345678

```

#### MySQL

Download

```shell
# Ubuntu 16.04 LTS
wget https://easybash.github.io/ubuntu/16.04/mysql.sh
# Ubuntu 18.04 LTS
wget https://easybash.github.io/ubuntu/18.04/mysql.sh
# Ubuntu 20.04 LTS
wget https://easybash.github.io/ubuntu/20.04/mysql.sh
# Ubuntu 22.04 LTS
wget https://easybash.github.io/ubuntu/22.04/mysql.sh
```

Options

```
 SYNOPSIS

    mysql.sh [-h] [-p [password]] [-s [y|n]] [...]

 OPTIONS

    -w ?, --password=?            Set mysql root password.
    -s ?, --secure=?              Enable mysql secure configuration.
                                  Accept vaule: y, n
    -r ?, --remote=?              Enable access mysql remotely.
                                  Accept vaule: y, n
    -u ?, --remote-user=?         Remote user.
    -p ?, --remote-password=?     Remote user's password.
    -v ?, --version=?             Which version of MySQL you want to install?
                                  Accept vaule: latest, system
    -h, --help                    Print this help.
    -i, --info                    Print script information.

    --aptitude           Use aptitude instead of apt-get as package manager

 EXAMPLES

    $ ./mysql.sh -v latest -s y -r y -ru test_user -rp 12345678
    $ ./mysql.sh --version=system --secure=y --remote=y --remote-user=test_user --remote-password=12345678

```

#### PHP-FPM

Download

```shell
# Ubuntu 16.04 LTS
wget https://easybash.github.io/ubuntu/16.04/php-fpm.sh
# Ubuntu 18.04 LTS
wget https://easybash.github.io/ubuntu/18.04/php-fpm.sh
# Ubuntu 20.04 LTS
wget https://easybash.github.io/ubuntu/20.04/php-fpm.sh
# Ubuntu 22.04 LTS
wget https://easybash.github.io/ubuntu/22.04/php-fpm.sh
```

Options
```
 SYNOPSIS

    php-fpm.sh [-h] [-i] [-l] [-v [version]] [-m [modules]]

 OPTIONS

    -v ?, --version=?    Which version of PHP-FPM you want to install?
                         Accept vaule: 5.6, 7.0, 7,1, 7.2
    -m ?, --modules=?    Which modules of PHP-FPM you want to install?
                         Accept vaule: A comma-separated list of module names.
                         See "./php-fpm.sh --module-list"
    -h, --help           Print this help.
    -i, --info           Print script information.
    -l, --module-list    Print module list of PHP-FPM.

    --aptitude           Use aptitude instead of apt-get as package manager

 EXAMPLES

    $ ./php-fpm.sh -v 7.2
    $ ./php-fpm.sh --version=7.2
    $ ./php-fpm.sh
```

#### Apache

Download

```shell
# Ubuntu 16.04 LTS
wget https://easybash.github.io/ubuntu/16.04/apache.sh
# Ubuntu 18.04 LTS
wget https://easybash.github.io/ubuntu/18.04/apache.sh
# Ubuntu 20.04 LTS
wget https://easybash.github.io/ubuntu/20.04/apache.sh 
# Ubuntu 22.04 LTS
wget https://easybash.github.io/ubuntu/22.04/apache.sh 
```
Options
```
 SYNOPSIS

    apache.sh [-h] [-i] [-v [version]]

 OPTIONS

    -v ?, --version=?    Which version of Apache you want to install?
                         Accept vaule: latest, system
    -h, --help           Print this help.
    -i, --info           Print script information.
    --aptitude           Use aptitude instead of apt-get as package manager

 EXAMPLES

    $ ./apache.sh -v system
    $ ./apache.sh --version=latest
    $ ./apache.sh

```

### Install a package

Let's take a look at MariaDB as an example.

```shell
wget https://easybash.github.io/ubuntu/16.04/mariadb.sh
chmod 755 ./mariadb.sh
./mariadb.sh --version=latest --password=12345678 --secure=y --remote=y --remote-user=testuser --remote-password=12345678
```

---

### Vargrant Provisioning

You can use the files hosted on [GitHub page](https://github.com/easybash/easybash.github.io) to quickly provision your Vagrant machine.

```shell
Vagrant.configure("2") do |config|
  
  config.vm.box = "ubuntu/xenial64"
  config.vm.box_check_update = false

  config.vm.provision "shell", path: "https://easybash.github.io/ubuntu/16.04/nginx.sh", privileged: "false"
  config.vm.provision "shell", path: "https://easybash.github.io/ubuntu/16.04/php-fpm.sh", privileged: "false"
  config.vm.provision "shell", path: "https://easybash.github.io/ubuntu/16.04/mariadb.sh", privileged: "false"
  
end
```

With script arguments:

```shell
Vagrant.configure("2") do |config|
  
  config.vm.box = "ubuntu/xenial64"
  config.vm.box_check_update = false

  config.vm.provision "shell" do |s|
    s.path = "https://easybash.github.io/ubuntu/16.04/mariadb.sh"
    s.privileged = "false"
    s.args = ["--version=latest", "--password=12345678", "--secure=y",  "--remote=y", "--remote-user=testuser", "--remote-password=12345678"]
  end
end
```

## Contributing Code

Ensure that the changes have been thoroughly tested on the corresponding system version. Use the following Vagrant file to create a development environment for testing.

### Vagrant Files

| Path |  Ubuntu version   |
| --- | --- |
| ubuntu/16.04/Vagrantfile | 16.04 |
| ubuntu/18.04/Vagrantfile | 18.04 |
| ubuntu/20.04/Vagrantfile | 20.04 |
| ubuntu/22.04/Vagrantfile | 22.04 |

### Steps

- Fork a repository from the master branch.
- Use the coding style outlined in the [Bash coding style guide](https://github.com/easybash/bash-coding-style-guide).
- Submit a pull request to the development branch.
- After the code has been reviewed, it will be merged into the master branch. Everything on the master branch will be included in the next major release.

## Authors

[Terry Lin](https://terryl.in/en/)

## License

MIT



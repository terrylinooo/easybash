# ![Ubuntu Logo](https://i.imgur.com/kf8Oeno.png) Easy bash for Ubuntu

Easybash is to do fully automatic installations of most popular packages to their latest version on Ubuntu servers.

Easybash has been tested and can use on the following LTS versions.

- [Ubuntu 16.04 (Xenial Xerus)](https://github.com/terrylinooo/easybash/tree/master/ubuntu/16.04)
- [Ubuntu 18.04 (Bionic Beaver)](https://github.com/terrylinooo/easybash/tree/master/ubuntu/18.04)
- Ubuntu 20.04 (Focal Fossa) - ongoing

## :link: [Website](https://easybash.github.io/) :link:

---

## Packages

| Package | Category |
| --- | --- |
| Apache | web server |
| Dart | programming language |
| Golang | programming language |
| MairaDB | database |
| MySQL | database |
| Node.js  | programming language |
| Nginx | web server |
| PHP-FPM | programming language |
| Redis | database |

## How to Use

- Wizard
- Standalone

---

### Wizard Mode 

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

That's it. Proviscript will install packages which defined in `install` section in `config.yml`

---

### Standalone Mode

#### Nginx

Download

```shell
# Ubuntu 16.04 LTS
wget https://easybash.github.io/ubuntu/16.04/nginx.sh
# Ubuntu 18.04 LTS
wget https://easybash.github.io/ubuntu/18.04/nginx.sh
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

#### Redis

Download
```shell
# Ubuntu 16.04 LTS
wget https://easybash.github.io/ubuntu/16.04/redis.sh
# Ubuntu 18.04 LTS
wget https://easybash.github.io/ubuntu/18.04/redis.sh
```
Options
```
 SYNOPSIS

    redis.sh [-h] [-i] [-v [version]]

 OPTIONS

    -v ?, --version=?    Which version of Redis you want to install?
                         Accept vaule: latest
    -h, --help           Print this help.
    -i, --info           Print script information.
    --aptitude           Use aptitude instead of apt-get as package manager

 EXAMPLES

    $ ./redis.sh -v latest
    $ ./redis.sh --version=latest
    $ ./redis.sh

```

#### Golang

Download
```shell
# Ubuntu 16.04 LTS
wget https://easybash.github.io/ubuntu/16.04/redis.sh
# Ubuntu 18.04 LTS
wget https://easybash.github.io/ubuntu/18.04/redis.sh
```
Options
```
 SYNOPSIS

    golang.sh [-h] [-i] [-v [version]]

 OPTIONS

    -v ?, --version=?    Which version of Go you want to install?
                         Accept vaule: latest, system
    -h, --help           Print this help.
    -i, --info           Print script information.
    --aptitude           Use aptitude instead of apt-get as package manager

 EXAMPLES

    $ ./golang.sh -v system
    $ ./golang.sh --version=latest
    $ ./golang.sh

```

#### Node.js

Download
```shell
# Ubuntu 16.04 LTS
wget https://easybash.github.io/ubuntu/16.04/nodejs.sh
# Ubuntu 18.04 LTS
wget https://easybash.github.io/ubuntu/18.04/nodejs.sh
```
Options
```
 SYNOPSIS

    nodejs.sh [-h] [-i] [-v [version]]

 OPTIONS

    -v ?, --version=?    Which version of Node.js you want to install?
                         Accept vaule: latest (stable), mainline, system
    -h, --help           Print this help.
    -i, --info           Print script information.
    --aptitude           Use aptitude instead of apt-get as package manager

 EXAMPLES

    $ ./nodejs.sh -v system
    $ ./nodejs.sh --version=latest
    $ ./nodejs.sh

```

#### Dart

Download
```shell
# Ubuntu 16.04 LTS
wget https://easybash.github.io/ubuntu/16.04/dart.sh
# Ubuntu 18.04 LTS
wget https://easybash.github.io/ubuntu/18.04/dart.sh
```
Options
```
 SYNOPSIS

    dart.sh [-h] [-i] [-v [version]]

 OPTIONS

    -v ?, --version=?    Which version of Dart you want to install?
                         Accept vaule: latest, dev. 
    -h, --help           Print this help.
    -i, --info           Print script information.
    --aptitude           Use aptitude instead of apt-get as package manager

 EXAMPLES

    $ ./dart.sh -v latest
    $ ./dart.sh --version=latest
    $ ./dart.sh

```

More bash scripts will be added..

---

### Install a package

Let's take MariaDB as an example.

```shell
wget https://easybash.github.io/ubuntu/16.04/mariadb.sh
chmod 755 ./mariadb.sh
./mariadb.sh --version=latest --password=12345678 --secure=y --remote=y --remote-user=testuser --remote-password=12345678
```

---

### Vargrant Provisioning

You can use EasyBash's CDN to quickly provision your Vagrant machine.

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

1. Fork a repo from master branch.
2. Use the coding style outlined in the [bash coding style guide](https://github.com/easybash/bash-coding-style-guide).
3. Make pull requests to the development branch.
4. After code is being reviewed, the code will be merged to the master. Everything on master will be part of the next major release.

## Authors

[Terry Lin](https://terryl.in/en/)

## License

MIT



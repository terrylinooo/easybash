
# Ubuntu 18.04 (Bionic Beaver)

You can test them before using on your production server. There is a `Vagrantfile` in this folder allows you to test them quickly in your virtual machine. Make sure to change `config.vm.synced_folder` or comment out this line.

| Package | Shell | Category | `-v system` | `-v lastet` | `-v mainline` | `-v {n}` 
| --- | --- | --- | --- | --- | --- | --- 
| Apache | `apache.sh` | Web Server | 2.4.29 | 2.4.43 | x | x |
| Dart | `dart.sh` | Language | x | 2.7.2 | 2.9.0 | x |
| Golang | `golang.sh` | Language | 1.10.4 | 1.14.2 | x | x |
| MairaDB | `mariadb.sh` | Database | 10.1.29 | 10.4.12 | 10.5 | x |
| MySQL | `mysql.sh` | Database | 5.7.29 | 8.0.19 | x | x |
| Nginx | `nginx.sh` | Web Server | 1.10.3 | 1.18.0 | 1.17.10 | x |
| Node.js  | `nodejs.sh` | Language | 8.10.0 | 12.16.2 | 14.0.0 | x |
| PHP-FPM | `php-fpm.sh` | Language | x | x | x | 5.6, 7.0, 7.1, 7.2, 7.3, 7.4 |
| Redis | `redis.sh` | Database | 4.0.9 | 5.0.8 | x | x |

* `-v system` uses default repository.
* `-v latest` uses trusted 3rd-party repository to install latest stable version.
* `-v mainline` uses trusted 3rd-party repository to install latest mainline version.

Last modified: 2020/4/22
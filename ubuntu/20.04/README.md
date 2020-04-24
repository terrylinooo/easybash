
# Ubuntu 20.04 (Focal Fossa)

You can test them before using on your production server. There is a `Vagrantfile` in this folder allows you to test them quickly in your virtual machine. Make sure to change `config.vm.synced_folder` or comment out this line.

| Package | Shell | Category | `-v system` | `-v lastet` | `-v mainline` | `-v {n}` 
| --- | --- | --- | --- | --- | --- | --- 
| Apache | `apache.sh` | Web Server | 2.4.41 | 2.4.43 | - | - |
| Dart | `dart.sh` | Language | - | 2.7.2 | 2.9.0 | - |
| Golang | `golang.sh` | Language | 1.13.8 | 1.13.8 | - | - |
| MairaDB | `mariadb.sh` | Database | 10.3.22 | 10.4.12 | 10.5.2 | - |
| MySQL | `mysql.sh` | Database | 8.0.19 | 8.0.19 | - | - |
| Nginx | `nginx.sh` | Web Server | 1.7.10 | 1.17.0 | 1.18.0 | - |
| Node.js  | `nodejs.sh` | Language | 10.19.0 | - | - | - |
| PHP-FPM | `php-fpm.sh` | Language | - | - | - | 5.6, 7.0, 7.1, 7.2, 7.3, 7.4 |
| Redis | `redis.sh` | Database | 5.0.7 | 5.0.7 | - | - |

* `-v system` uses default repository.
* `-v latest` uses trusted 3rd-party repository to install latest stable version.
* `-v mainline` uses trusted 3rd-party repository to install latest mainline version.

Last modified: 2020/4/22

# Ubuntu 20.04 (Focal Fossa)

You can test them before using on your production server. There is a `Vagrantfile` in this folder allows you to test them quickly in your virtual machine. Make sure to change `config.vm.synced_folder` or comment out this line.

| Package | Shell | Category | `-v system` | `-v lastet` | `-v mainline` | `-v {n}` 
| --- | --- | --- | --- | --- | --- | --- 
| Apache | `apache.sh` | Web Server | - | - | - | - |
| Dart | `dart.sh` | Language | - | - | - | - |
| Golang | `golang.sh` | Language | - | - | - | - |
| MairaDB | `mariadb.sh` | Database | - | - | - | - |
| MySQL | `mysql.sh` | Database | - | - | - | - |
| Nginx | `nginx.sh` | Web Server | - | - | - | - |
| Node.js  | `nodejs.sh` | Language | - | - | - | - |
| PHP-FPM | `php-fpm.sh` | Language | - | - | - | - |
| Redis | `redis.sh` | Database | - | - | - | - |

* `-v system` uses default repository.
* `-v latest` uses trusted 3rd-party repository to install latest stable version.
* `-v mainline` uses trusted 3rd-party repository to install latest mainline version.

Last modified: 2020/4/22
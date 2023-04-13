
# Ubuntu 20.04 (Focal Fossa)

You can test them before using on your production server. There is a `Vagrantfile` in this folder that allows you to test them quickly in your virtual machine. Make sure to change `config.vm.synced_folder` or comment out this line.

| Package | Shell | Category | `-v system` | `-v lastet` | `-v mainline` | `-v {n}` 
| --- | --- | --- | --- | --- | --- | --- 
| Apache | `apache.sh` | A | 2.4.41 | 2.4.57 | - | - |
| Nginx | `nginx.sh` | E | 1.18.0 | 1.24.0 | 1.23.4 | - |
| MairaDB | `mariadb.sh` | M | 10.3.38 | 10.11.2 | 11.0.1 | - |
| MySQL | `mysql.sh` | M | 8.0.32 | 8.0.32 | - | - |
| PHP-FPM | `php-fpm.sh` | P | - | - | - | 5.6, 7.0, 7.1, 7.2, 7.3, 7.4, 8.0, 8.1, 8.2 |

* `-v system` uses default repository.
* `-v latest` uses trusted 3rd-party repository to install the latest stable version.
* `-v mainline` uses trusted 3rd-party repository to install the latest mainline version.

Last modified: 2023/04/12
Last package version tested: 2023/04/12
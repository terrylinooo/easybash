#!/usr/bin/env bash
#>                           +--------------------------+
#>                           |  mariadb-remote-user.sh  |   
#>                           +--------------------------+
#-
#- SYNOPSIS
#-
#-    mariadb.sh [-h] [-p [password]] [-s [y|n]] [...]
#-
#- OPTIONS
#-
#-    -w ?, --password=?            Set mysql root password.
#-    -s ?, --secure=?              Enable mysql secure configuration.
#-                                  Accept vaule: y, n
#-    -r ?, --remote=?              Enable access mysql remotely.
#-                                  Accept vaule: y, n
#-    -u ?, --remote-user=?         Remote user.
#-    -p ?, --remote-password=?     Remote user's password.
#-                                  Accept vaule: latest, system
#-    -h, --help                    Print this help.
#-    -i, --info                    Print script information.
#-
#- EXAMPLES
#-
#-    $ ./mariadb-remote-user.sh -s y -r y -ru test_user -rp 12345678
#-    $ ./mariadb-remote-user.sh --secure=y --remote=y --remote-user=test_user --remote-password=12345678
#+
#+ IMPLEMENTATION:
#+
#+    package    Easybash
#+    copyright  https://github.com/terrylinooo/easybash
#+    license    MIT
#+    authors    Terry Lin (terrylinooo)
#+ 
#==============================================================================

#==============================================================================
# Part 1. Option (DO NOT MODIFY)
#==============================================================================

# Print script help
show_script_help() {
    echo 
    head -50 ${0} | grep -e "^#[-|>]" | sed -e "s/^#[-|>]*/ /g"
    echo 
}

# Print script info
show_script_information() {
    echo 
    head -50 ${0} | grep -e "^#[+|>]" | sed -e "s/^#[+|>]*/ /g"
    echo 
}

# Receive arguments in slient mode.
if [ "$#" -gt 0 ]; then
    while [ "$#" -gt 0 ]; do
        case "$1" in
            # mysql root password (required in slient mode)
            "-w") 
                mysql_root_password="${2}";
                shift 2
            ;;
            "--password="*) 
                mysql_root_password="${1#*=}"
                shift 1
            ;;
            # Enable mysql secure configuration (not required)
            # As known as mysql_secure_installation.sh by Twitter
            # Accept vaule: y, Y, n, N
            "-s") 
                mysql_secure="${2}"
                shift 2
            ;;
            "--secure="*) 
                mysql_secure="${1#*=}"; 
                shift 1
            ;;
            # Enable access mysql remotely (not required)
            # Accept: y, Y, n, N
            "-r") 
                mysql_remote="${2}"
                shift 2
            ;;
            "--remote="*) 
                mysql_remote="${1#*=}"; 
                shift 1
            ;;
            # Remote user (required if $mysql_remote = y)
            "-u") 
                mysql_remote_user="${2}"
                shift 2
            ;;
            "--remote-user="*) 
                mysql_remote_user="${1#*=}"; 
                shift 1
            ;;
            # Remote user's password (required if $mysql_remote = y)
            "-p") 
                mysql_remote_password="${2}"
                shift 2
            ;;
            "--remote-password="*) 
                mysql_remote_password="${1#*=}"; 
                shift 1
            ;;
            # Help
            "-h"|"--help")
                show_script_help
                exit 1
            ;;
            # Info
            "-i"|"--information")
                show_script_information
                exit 1
            ;;
            "--password"|"--secure"|"--remote"|"remote-user"|"remote-password")
                echo "${1} requires an argument"
                exit 1
            ;;
            "-"*)
                echo "Unknown option: ${1}"
                exit 1
            ;;
            *)
                echo "Unknown option: ${1}"
                exit 1
            ;;
        esac
    done
fi

#==============================================================================
# Part 2. Message (DO NOT MODIFY)
#==============================================================================

# Bash color set
readonly COLOR_EOF="\e[0m"
readonly COLOR_BLUE="\e[34m"
readonly COLOR_RED="\e[91m"
readonly COLOR_GREEN="\e[92m"
readonly COLOR_WHITE="\e[97m"
readonly COLOR_DARK="\e[90m"
readonly COLOR_BG_BLUE="\e[44m"
readonly COLOR_BG_GREEN="\e[42m"
readonly COLOR_BG_DARK="\e[100m"

func::easybash_msg() {
    case "$1" in
        "info")
            echo -e "[${COLOR_BLUE}Easybash${COLOR_EOF}] ${COLOR_BLUE}${2}${COLOR_EOF}"
        ;;
        "warning")
            echo -e "[${COLOR_RED}Easybash${COLOR_EOF}] ${COLOR_RED}${2}${COLOR_EOF}"
        ;;
        "success")
            echo -e "[${COLOR_GREEN}Easybash${COLOR_EOF}] ${COLOR_GREEN}${2}${COLOR_EOF}"
        ;;
    esac
}

spaces=$(printf "%-80s" " ")
echo -e
echo -e "${COLOR_BG_GREEN}${spaces}${COLOR_EOF}"
echo -e ${COLOR_WHITE}
echo -e "  __  __                  _           ____    ____    "
echo -e " |  \/  |   __ _   _ __  (_)   __ _  |  _ \  | __ )   "
echo -e " | |\/| |  / _  | | '__| | |  / _  | | | | | |  _ \   "
echo -e " | |  | | | (_| | | |    | | | (_| | | |_| | | |_) |  "
echo -e " |_|  |_|  \__,_| |_|    |_|  \__,_| |____/  |____/   "
echo -e ${COLOR_EOF}
echo -e " ${COLOR_GREEN}Easy${COLOR_BLUE}bash${COLOR_EOF} Project"
echo -e
echo -e " Web:    https://easybash.github.io/"
echo -e " GitHub: https://github.com/terrylinooo/easybash"
echo -e
echo -e "${COLOR_BG_BLUE}${spaces}${COLOR_EOF}"
echo -e ${COLOR_EOF}

#==============================================================================
# Part 3. Core
#==============================================================================

func::easybash_msg info "The following steps will prompt you to enter MySQL root password."

# As same as secure_mysql_installation.
# --------------------------------------
# 1) Change the root password.
# 2) Disallow root login remotely.
# 3) Remove anonymous users.
# 4) Remove test database and access to it.

# UPDATE mysql.user SET Password=PASSWORD('${mysql_root_password}') WHERE User='root';
if [ "${mysql_secure}" == "y" ]; then
    func::easybash_msg info "Proceeding to secure mysql installation..."
    sudo mysql -uroot -p${mysql_root_password} << EOF
        DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
        DELETE FROM mysql.user WHERE User='';
        DELETE FROM mysql.db WHERE Db='test' OR Db='test_%';
        FLUSH PRIVILEGES;
EOF
fi

# This is an option,If you need remote access the MySQL server
# Allow remote access.
if [ "${mysql_remote}" == "y" ]; then
    # Find 50-server.cnf at first.
    func::easybash_msg info "Trying to find 50-server.cnf ..."
    cnf_path="$(sudo find /etc/ -name 50-server.cnf 2>&1)"

    # If 50-server.cnf not found, find my.cnf
    if [ -z "${cnf_path}" ]; then
        func::easybash_msg info "50-server.cnf not found."
        func::easybash_msg info "Trying to find my.cnf ..."
        cnf_path="$(sudo find /etc/ -name my.cnf 2>&1)"
    fi

    func::easybash_msg info "Proceeding to modify ${cnf_path} => bind-address = 0.0.0.0"
    sudo sed -i "s/bind-address.*/bind-address = 0.0.0.0/" ${cnf_path}

    func::easybash_msg info "Proceeding to create a remote user \"${mysql_remote_user}\" with password \"${mysql_remote_password}\"."
    # Setup an user account and access a MySQL server remotely.
    sudo mysql -uroot -p${mysql_root_password} << EOF
        CREATE USER '${mysql_remote_user}'@'%' IDENTIFIED BY '${mysql_remote_password}';
        GRANT ALL PRIVILEGES ON *.* TO '${mysql_remote_user}'@'%';
        FLUSH PRIVILEGES;
EOF
fi

# To restart mysql service.
func::easybash_msg info "Restart service mariadb-server."
sudo service mariadb restart

func::easybash_msg success "Done."

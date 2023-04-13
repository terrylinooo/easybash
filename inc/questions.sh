#
#                    +----------------+
#                    |  questions.sh  |   
#                    +----------------+
#
# Questions in Wizard mode of Easybash project
#
# Package  Easybash
# Author   Terry Lin
# Link     https://github.com/terrylinooo/easybash
# License  MIT
#
#==============================================================================

# Question 1: Select installation mode
func::question_installation_mode() {
    echo -e " ${COLOR_GREEN}Hi, EasyBash will help you install LAMP or LEMP automatically.\n Please select the installation mode.${COLOR_EOF}"
    echo -e " ${COLOR_WHITE}"
    echo -e " (1) Wizard:"
    echo -e " This mode will ask you several questions to configure settings."
    echo
    echo -e " (2) Config:"
    echo -e " This mode will copy the config.yml to the working folder, you will be"
    echo -e " able to edit the settings by yourself."
    echo -e " And then type ${COLOR_BG_DARK}./easybash install${COLOR_EOF}${COLOR_WHITE} to proceed installation."
    echo -e " ${COLOR_EOF}"
}

func::answer_installation_mode() {
    local installation_mode
    until [[ ${installation_mode} =~ ^[1-2]$ ]]; do
		read -rp " Choice [1-2]: " -e -i 1 installation_mode
	done
    echo ${installation_mode}
}

# Question 2: Choose perferred stacks.
func::question_perderred_stacks() {
    clear
    echo -e " ${COLOR_GREEN}Which stacks would you like to install?${COLOR_EOF}"
    echo -e " ${COLOR_WHITE}"
    echo -e " (1) LEMP: Nginx, MariaDB or MySQL, PHP.\n"
    echo -e " (2) LAMP: Apache, MariaDB or MySQL, PHP."
    echo -e " ${COLOR_EOF}"
}

func::answer_perderred_stacks() {
    local preferred_stacks
    until [[ ${preferred_stacks} =~ ^[1-2]$ ]]; do
		read -rp " Choice [1-2]: " -e -i 1 preferred_stacks
	done
    echo ${preferred_stacks}
}

# Question 3: Choose perferred database software.
func::question_perderred_db() {
    clear
    echo -e " ${COLOR_GREEN}Which database software would you like to install?${COLOR_EOF}"
    echo -e " ${COLOR_WHITE}"
    echo -e " (1) MySQL\n"
    echo -e " (2) MariaDB"
    echo -e " ${COLOR_EOF}"
}

func::answer_perderred_db() {
    local perferred_db
    until [[ ${perferred_db} =~ ^[1-2]$ ]]; do
		read -rp " Choice [1-2]: " -e -i 1 perferred_db
	done
    echo ${perferred_db}
}

# Question 4: More about MySQL secure installation.
func::question_mysql_secure_installation() {
    clear
    echo -e " ${COLOR_GREEN}Would you like me to do a MySQL secure installation?${COLOR_EOF}"
    echo -e " ${COLOR_WHITE}"
    echo -e " (1) Yes"
    echo -e " This will remove the test database and anonymous user, disallow remote "
    echo -e " root login, and load these new rules so that MySQL immediately respects "
    echo -e " the changes we have made."
    echo
    echo -e " (2) No, do nothing."
    echo -e " ${COLOR_EOF}"
}

func::answer_mysql_secure_installation() {
    local mysql_secure_installation
    until [[ ${mysql_secure_installation} =~ ^[1-2]$ ]]; do
		read -rp " Choice [1-2]: " -e -i 1 mysql_secure_installation
	done
    echo ${mysql_secure_installation}
}

# Question 5: Ask for MySQL roor password.
func::question_mysql_root_password() {
    clear
    echo -e " ${COLOR_GREEN}Please enter the password for root.${COLOR_EOF}"
    echo -e " ${COLOR_WHITE}"
    echo -e " The password must be at least 8 characters long."
    echo -e " MySQL recommends using passwords with at least 12 characters and a mix of"
    echo -e " uppercase and lowercase letters, numbers, and special characters to ensure"
    echo -e " security.\n"
}

func::answer_mysql_root_password() {
    local password_regex='^[A-Za-z0-9@#$%^&*()_+]{8,}$'
    local mysql_root_password
    until [[ ${mysql_root_password} =~ ${password_regex} ]]; do
		read -rp " Password: " mysql_root_password
	done
    echo ${mysql_root_password}
}

# Question 6: Ask for MySQL remote access.
func::question_mysql_remote_access() {
    clear
    echo -e " ${COLOR_GREEN}Would you allow remote access to the database?${COLOR_EOF}"
    echo -e " ${COLOR_WHITE}"
    echo -e " (1) Yes"
    echo -e " If you choose this option, the next questions will ask you to enter the"
    echo -e " username and password for remote access."
    echo
    echo -e " (2) No, do nothing."
    echo -e "${COLOR_EOF}"
}

func::answer_mysql_remote_access() {
    local mysql_remote_access
    until [[ ${mysql_remote_access} =~ ^[1-2]$ ]]; do
		read -rp " Choice [1-2]: " -e -i 1 mysql_remote_access
	done
    echo ${mysql_remote_access}
}

# Question 7: Ask for MySQL remote access username.
func::question_mysql_remote_username() {
    clear
    echo -e " ${COLOR_GREEN}Please enter the username for remote access.${COLOR_EOF}"
    echo -e " ${COLOR_WHITE}"
    echo -e " The username must be a valid MySQL username."
    echo -e "   * First char must be a letter"
    echo -e "   * Up to 16 chars"
    echo -e "   * Letters, numbers, and underscores only"
    echo -e " ${COLOR_EOF}"
}

func::answer_mysql_remote_username() {
    local username_regex='^[a-zA-Z0-9_]{4,15}$'
    local mysql_remote_username
    until [[ ${mysql_remote_username} =~ ${username_regex} ]]; do
		read -rp " Username: " mysql_remote_username
	done
    echo ${mysql_remote_username}
}

# Question 8: Ask for MySQL remote access password.
func::question_mysql_remote_password() {
    clear
    echo -e " ${COLOR_GREEN}Please enter the password for the remote user.${COLOR_EOF}"
    echo -e " ${COLOR_WHITE}"
    echo -e " The password must be at least 8 characters long."
    echo -e " MySQL recommends using passwords with at least 12 characters and a mix of"
    echo -e " uppercase and lowercase letters, numbers, and special characters to ensure"
    echo -e " security.\n"
}

func::answer_mysql_remote_password() {
    local password_regex='^[A-Za-z0-9@#$%^&*()_+]{8,}$'
    local mysql_remote_password
    until [[ ${mysql_remote_password} =~ ${password_regex} ]]; do
		read -rp " Password: " mysql_remote_password
	done
    echo ${mysql_remote_password}
}

# Question 9: Ask for PHP versions
func::question_php_version() {
    clear
    echo -e " ${COLOR_GREEN}Which version of PHP you like to install?${COLOR_EOF}"
    echo -e " ${COLOR_WHITE}"
    echo -e " You can choose: 5.6, 7.0, 7,1, 7.2, 7.3, 7.4, 8.0, 8.1, 8.2"
    echo -e " I recommend installing the latest version of PHP to enjoy the latest"
    echo -e " features, unless you have a specific reason to install an older version."
    echo -e " ${COLOR_EOF}"
}

func::answer_php_version() {
    local php_version_regex='^(5\.6|7\.[1-4]|8\.[0-2])$'
    local php_version
    until [[ ${php_version} =~ ${php_version_regex} ]]; do
		read -rp " Version: " -e -i 8.2 php_version
	done
    echo ${php_version}
}

# Question 10: Ask for PHP modules.
func::question_php_modules() {
    clear
    echo -e " ${COLOR_GREEN}What PHP modules you like to install?${COLOR_EOF}"
    echo
    printf " %-12s%-12s%-12s%-12s%-12s\n" "bcmath" "bz2" "cgi*" "cli*" "common*"
    printf " %-12s%-12s%-12s%-12s%-12s\n" "curl*" "dba" "dev" "enchant" "gd*"
    printf " %-12s%-12s%-12s%-12s%-12s\n" "gmp*" "imap" "imagick*" "interbase" "intl*"
    printf " %-12s%-12s%-12s%-12s%-12s\n" "json*" "ldap" "mbstring*" "memcached *" "mongodb*"
    printf " %-12s%-12s%-12s%-12s%-12s\n" "mysql*" "odbc" "opcache*" "pgsql" "phpdbg"
    printf " %-12s%-12s%-12s%-12s%-12s\n" "pspell" "readline*" "recode" "redis*" "snmp"
    printf " %-12s%-12s%-12s%-12s%-12s\n" "soap" "sqlite3*" "sybase" "tidy*" "xdebug*"
    printf " %-12s%-12s%-12s%-12s%-12s\n" "xml*" "xmlrpc" "xsl" "zip*" ""
    echo -e " ${COLOR_WHITE}"
    echo -e " (1) All"
    echo -e " (2) Most common uses (*)"
    echo -e " (3) None"
    echo -e " ${COLOR_EOF}"
}

func::answer_php_modules() {
    local php_modules
    until [[ ${php_modules} =~ ^[1-3]$ ]]; do
		read -rp " Choice [1-3]: " -e -i 2 php_modules
	done
    echo ${php_modules}
}

# Question 11: Confirmation
func::question_confirmation() {
    clear
    echo -e " ${COLOR_GREEN}Could you confirm the installation configuration?"
    echo -e " If you are ready, please type in ${COLOR_RED}yes${COLOR_GREEN} to get started."
    echo -e " ${COLOR_EOF}${COLOR_WHITE}"
    echo -e " Web server: ${STACK_WEB_SERVER}"
    echo -e " DB: ${STACK_DATABASE}"
    echo -e " DB root password: ${MYSQL_ROOT_PASSWORD}"
    echo -e " DB remote access: ${MYSQL_REMOTE}"
    if [ "${MYSQL_REMOTE}" == "y" ]; then
        echo -e " DB remote username: ${MYSQL_REMOTE_USER}"
        echo -e " DB remote password: ${MYSQL_REMOTE_PASSWORD}"
    fi
    echo -e " PHP version: ${STACK_PHP}"
    echo -e " PHP modules: ${PHP_MODULES[@]}"
    echo -e " ${COLOR_EOF}"
}

func::answer_confirmation() {
    local confirmation
    until [[ ${confirmation} =~ ^(yes|no)$ ]]; do
		read -rp " Type in [yes/no]: " confirmation
	done
    echo ${confirmation}
}

# Question 12: Turn off restart dialog
func::question_turn_off_restart_dialog() {
    clear
    echo -e " ${COLOR_GREEN}Would you like to disable the annoying restart dialog?${COLOR_EOF}"
    echo -e " ${COLOR_WHITE}"
    echo -e " Since Ubuntu 22, every time a new package is being installed,"
    echo -e " it will ask you about \"${COLOR_BLUE}Which service should be restarted?${COLOR_WHITE}\""
    echo -e " I can help you modify the ${COLOR_BG_DARK}/etc/needrestart/needrestart.conf${COLOR_EOF} file to turn it off."
    echo -e " The following line will be uncommented and change it to \"${COLOR_RED}a${COLOR_WHITE}\""
    echo -e " ${COLOR_EOF}"
    echo -e " ${COLOR_BG_DARK} #\$nrconf{restart} = 'i';${COLOR_EOF}"
    echo -e " ${COLOR_WHITE}"
    echo -e " And the following line will be uncommented."
    echo -e " ${COLOR_EOF}"
    echo -e " ${COLOR_BG_DARK} #\$nrconf{kernelhints} = -1;${COLOR_EOF}\n"
}

func::answer_turn_off_restart_dialog() {
    local restart_dialog
    until [[ ${restart_dialog} =~ ^(yes|no)$ ]]; do
        read -rp " Type in [yes/no]: " restart_dialog
    done
    echo ${restart_dialog}
}
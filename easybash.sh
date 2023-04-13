#!/usr/bin/env bash
#>                           +---------------+
#>                           |  easybash.sh  |   
#>                           +---------------+
#-
#- SYNOPSIS
#-
#-    easybash.sh [-h] [-i] [install] [init]
#-
#- OPTIONS
#-
#-    -h, --help           Print this help.
#-    -i, --info           Print script information.
#-    -p, --print-config   Print config variables, for debug
#-    init                 Detect current OS verison and copy config.yml
#-    install              Start installing process.
#-
#+
#+ IMPLEMENTATION:
#+
#+    version    0.1.0
#+    copyright  https://github.com/terrylinooo/easybash
#+    license    MIT
#+    authors    Terry Lin (terrylinooo)
#+
#==============================================================================

#==============================================================================
# Part 1. Config
#==============================================================================

readonly EASYBASH=main
readonly EASYBASH_DIR=$(dirname $(readlink -f $0))

# Load base colors
source "${EASYBASH_DIR}/inc/colors.sh"

# Load base functions
source "${EASYBASH_DIR}/inc/functions.sh"

# Load questions
source "${EASYBASH_DIR}/inc/questions.sh"

_EASYBASH=false

readonly OS_NAME="$(func::os_name)"
readonly OS_RELEASE_NUMBER="$(func::os_release_number)"
readonly OS_DIST="${OS_NAME}/${OS_RELEASE_NUMBER}"

#==============================================================================
# Part 2. Option (DO NOT MODIFY)
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

if [ "$#" -gt 0 ]; then
    while [ "$#" -gt 0 ]; do
        case "$1" in
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
            # Print config variables, debug
            "-p"|"--print-config")
                func::parse_yaml config.yml
                exit 1
            ;;
            # Show welcome message (test)
            "--welcome")
                func::easybash_welcome
                exit 1
            ;;
            # Show thanks message (test)
            "--thanks")
                func::easybash_thanks
                exit 1
            ;;
            "init")
                _INIT=true
                shift 1
            ;;
            "install")
                _EASYBASH=true
                shift 1
            ;;
        esac
    done
fi

#==============================================================================
# Part 3. Message (DO NOT MODIFY)
#==============================================================================

func::easybash_welcome

#==============================================================================
# Part 4. Questions and Answers
#==============================================================================
if [ "${_EASYBASH}" == "false" ]; then
    # Question 1
    func::question_installation_mode
    answer_installation_mode="$(func::answer_installation_mode)"

    # Wizard mode
    if [ "${answer_installation_mode}" == "1" ]; then

        # Question 2
        func::question_perderred_stacks
        answer_perferred_stacks="$(func::answer_perderred_stacks)"

        if [ "${answer_perferred_stacks}" == "1" ]; then
            readonly STACK_WEB_SERVER="nginx"
        elif [ "${answer_perferred_stacks}" == "2" ]; then
            readonly STACK_WEB_SERVER="apache"
        fi

        # Question 3
        func::question_perderred_db
        answer_perferred_db="$(func::answer_perderred_db)"

        if [ "${answer_perferred_db}" == "1" ]; then
            readonly STACK_DATABASE="mysql"
        elif [ "${answer_perferred_db}" == "2" ]; then
            readonly STACK_DATABASE="mariadb"
        fi

        # Question 4
        func::question_mysql_secure_installation
        answer_myql_secure_installation="$(func::answer_mysql_secure_installation)"

        if [ "${answer_myql_secure_installation}" == "1" ]; then
            readonly MYSQL_SECURE="y"
        elif [ "${answer_myql_secure_installation}" == "2" ]; then
            readonly MYSQL_SECURE="n"
        fi

        # Question 5
        func::question_mysql_root_password
        readonly MYSQL_ROOT_PASSWORD="$(func::answer_mysql_root_password)"

        # Question 6
        func::question_mysql_remote_access
        answer_mysql_remote_access="$(func::answer_mysql_remote_access)"

        if [ "${answer_mysql_remote_access}" == "1" ]; then
            readonly MYSQL_REMOTE="y"

            # Question 7
            func::question_mysql_remote_username
            readonly MYSQL_REMOTE_USER="$(func::answer_mysql_remote_username)"

            # Question 8
            func::question_mysql_remote_password
            readonly MYSQL_REMOTE_PASSWORD="$(func::answer_mysql_remote_password)"

        elif [ "${answer_mysql_remote_access}" == "2" ]; then
            readonly MYSQL_REMOTE="n"
        fi

        # Question 9
        func::question_php_version
        readonly STACK_PHP="$(func::answer_php_version)"

        # Question 10
        func::question_php_modules
        answer_php_modules="$(func::answer_php_modules)"

        if [ "${answer_php_modules}" == "1" ]; then
            readonly PHP_MODULES=(
                "bcmath"    "bz2"         "cgi"         "cli"          "common"  
                "curl"      "dba"         "dev"         "enchant"      "gd"  
                "gmp"       "imap"        "imagick"     "interbase"    "intl"  
                "json"      "ldap"        "mbstring"    "memcached"    "mongodb"  
                "mysql"     "odbc"        "opcache"     "pgsql"        "phpdbg"  
                "pspell"    "readline"    "recode"      "redis"        "snmp"  
                "soap"      "sqlite3"     "sybase"      "tidy"         "xdebug"  
                "xml"       "xmlrpc"      "xsl"         "zip"
            )
        elif [ "${answer_php_modules}" == "2" ]; then     
            readonly PHP_MODULES=(
                "cgi"          "cli"        "common"    "curl"       "gd"  
                "gmp"          "imagick"    "intl"      "json"       "mbstring"   
                "memcached"    "mongodb"    "mysql"     "opcache"    "readline"      
                "redis"        "sqlite3"    "tidy"      "xdebug"     "xml"              
                "zip"
            )
        elif [ "${answer_php_modules}" == "3" ]; then
            readonly PHP_MODULES=()
        fi

        # Question 11
        func::question_confirmation
        answer_confirmation="$(func::answer_confirmation)"
        if [ "${answer_confirmation}" == "yes" ]; then

            if [ "${OS_RELEASE_NUMBER}" == "22.04" ]; then
                func::question_turn_off_restart_dialog
                answer_turn_off_restart="$(func::answer_turn_off_restart_dialog)"
                if [ "${answer_turn_off_restart}" == "yes" ]; then
                    sed -i "s/#\$nrconf{restart} = 'i';/\$nrconf{restart} = 'a';/g" /etc/needrestart/needrestart.conf
                    sed -i "s/#\$nrconf{kernelhints} = -1;/\$nrconf{kernelhints} = -1;/g" /etc/needrestart/needrestart.conf
                fi
            fi

            PACKAGE_VERSION="latest"
            source "${EASYBASH_DIR}/${OS_DIST,,}/${STACK_WEB_SERVER}.sh"
            source "${EASYBASH_DIR}/${OS_DIST,,}/${STACK_DATABASE}.sh"
            PACKAGE_VERSION="${STACK_PHP}"
            source "${EASYBASH_DIR}/${OS_DIST,,}/php-fpm.sh"
        fi

        func::easybash_thanks
        exit 0

    elif [ "${answer_installation_mode}" == "2" ]; then
       _INIT=true
    fi
fi

#==============================================================================
# Part 5. Core
#==============================================================================

if [ "${_INIT}" == "true" ]; then
    func::easybash_msg info "Copy ${OS_DIST,,}/config.yml to current folder..."
    sudo cp ${OS_DIST,,}/config.yml config.yml

    if [ $? -eq 0 ]; then
        func::easybash_msg success "Configuration file config.yml is ready."
        func::easybash_msg success "Please edit config.yml to choose which packages to install."
        echo
    else
        func::easybash_msg warning "Configuration file config.yml is not ready."
        func::easybash_msg warning "Easybash currently does't support your OS, please watch us on GitHub for further update."
        echo
    fi
    exit 2
fi

if [ "${_EASYBASH}" == "true" ]; then
    # Load config settings
    eval $(func::parse_yaml config.yml)

    case "${OS_NAME}" in
        "Ubuntu") ;;
        *)
            func::func::easybash_msg warning "Sorry! Easybash does support Ubuntu only."
            exit 1
        ;;
    esac

    # Install component packages
    for component in ${install[@]}; do
        eval "component_name=(\$config_${component}_name)"
        eval "component_version=(\$config_${component}_version)"
        readonly PACKAGE_VERSION=${component_version}

        if [ "${component_name}" == "php-fpm" ]; then
            readonly PHP_MODULES=${config_php_modules}
        fi

        if [ "${component_name}" == "mariadb" ]; then
            readonly MYSQL_ROOT_PASSWORD=${config_mariadb_password}
            readonly MYSQL_SECURE=${config_mariadb_secure}
            readonly MYSQL_REMOTE=${config_mariadb_remote}
            readonly MYSQL_REMOTE_USER=${config_mariadb_remote_user}
            readonly MYSQL_REMOTE_PASSWORD=${config_mariadb_remote_password}
        fi

        if [ "${component_name}" == "mysql" ]; then
            readonly MYSQL_ROOT_PASSWORD=${config_mysql_password}
            readonly MYSQL_SECURE=${config_mysql_secure}
            readonly MYSQL_REMOTE=${config_mysql_remote}
            readonly MYSQL_REMOTE_USER=${config_mysql_remote_user}
            readonly MYSQL_REMOTE_PASSWORD=${config_mysql_remote_password}
        fi

        # Load component script
        source "${EASYBASH_DIR}/${OS_DIST,,}/${component_name}.sh"
    done

    # Show thanks message
    func::easybash_thanks
fi

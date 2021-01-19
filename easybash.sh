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

export EASYBASH=main
export EASYBASH_DIR=$(dirname $(readlink -f $0))

# Load base functions
source "${EASYBASH_DIR}/inc/functions.sh"

_PROVI=false

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
                _PROVI=true
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
# Part 4. Core
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

if [ "${_PROVI}" == "true" ]; then
    # Load config settings
    eval $(func::parse_yaml config.yml)

    case "${OS_NAME}" in
        "Ubuntu") ;;
        *)
            func::func::easybash_msg warning "Sorry! Easybash currently does't support your OS, please watch us on GitHub for further update."
            exit 1
        ;;
    esac

    # Install component packages
    for component in ${install[@]}; do
        eval "component_name=(\$config_${component}_name)"
        eval "component_version=(\$config_${component}_version)"
        export PACKAGE_VERSION=${component_version}

        if [ "${component_name}" == "php-fpm" ]; then
            export PHP_MODULES=${config_php_modules}
        fi

        if [ "${component_name}" == "mariadb" ]; then
            export MYSQL_ROOT_PASSWORD=${config_mariadb_password}
            export MYSQL_SECURE=${config_mariadb_secure}
            export MYSQL_REMOTE=${config_mariadb_remote}
            export MYSQL_REMOTE_USER=${config_mariadb_remote_user}
            export MYSQL_REMOTE_PASSWORD=${config_mariadb_remote_password}
        fi

        if [ "${component_name}" == "mysql" ]; then
            export MYSQL_ROOT_PASSWORD=${config_mysql_password}
            export MYSQL_SECURE=${config_mysql_secure}
            export MYSQL_REMOTE=${config_mysql_remote}
            export MYSQL_REMOTE_USER=${config_mysql_remote_user}
            export MYSQL_REMOTE_PASSWORD=${config_mysql_remote_password}
        fi

        # Load component script
        source "${EASYBASH_DIR}/${OS_DIST,,}/${component_name}.sh"
    done

    # Show thanks message
    func::easybash_thanks

    unset EASYBASH
    unset EASYBASH_DIR
fi
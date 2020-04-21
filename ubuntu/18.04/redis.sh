#!/usr/bin/env bash
#>                           +------------+
#>                           |  redis.sh  |
#>                           +------------+
#-
#- SYNOPSIS
#-
#-    redis.sh [-h] [-i] [-v [version]]
#-
#- OPTIONS
#-
#-    -v ?, --version=?    Which version of Redis you want to install?
#-                         Accept vaule: latest, system
#-    -h, --help           Print this help.
#-    -i, --info           Print script information.
#-    --aptitude           Use aptitude instead of apt-get as package manager
#-
#- EXAMPLES
#-
#-    $ ./redis.sh -v latest
#-    $ ./redis.sh --version=latest
#-    $ ./redis.sh
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
# Part 1. Config
#==============================================================================

# Display package information, no need to change.
os_name="Ubuntu"
os_version="18.04"
package_name="Redis"

# Debian/Ubuntu Only. Package manager: apt-get | aptitude
_PM="apt-get"

# Default, you can overwrite this setting by assigning -v or --version option.
package_version="latest"

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

# Receive arguments in slient mode.
if [ "$#" -gt 0 ]; then
    while [ "$#" -gt 0 ]; do
        case "$1" in
            # Which version of Redis you want to install?
            "-v") 
                package_version="${2}"
                shift 2
            ;;
            "--version="*) 
                package_version="${1#*=}"; 
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
            # aptitude
            "--aptitude")
                _PM="aptitude"
                shift 1
            ;;
            # apt-get
            "--apt-get")
                _PM="apt-get"
                shift 1
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
# Part 3. Message (DO NOT MODIFY)
#==============================================================================

if [ "$(type -t INIT_EASYBASH)" == function ]; then
    package_version=${PACKAGE_VERSION}
    func::component_welcome "redis" "${package_version}"
else
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
                echo -e "[${COLOR_BLUE}###${COLOR_EOF}] ${COLOR_BLUE}${2}${COLOR_EOF}"
            ;;
            "warning")
                echo -e "[${COLOR_RED}###${COLOR_EOF}] ${COLOR_RED}${2}${COLOR_EOF}"
            ;;
            "success")
                echo -e "[${COLOR_GREEN}###${COLOR_EOF}] ${COLOR_GREEN}${2}${COLOR_EOF}"
            ;;
        esac
    }

    spaces=$(printf "%-80s" "*")
    echo -e
    echo -e "${COLOR_BG_GREEN}${spaces}${COLOR_EOF}"
    echo -e ${COLOR_WHITE}
    echo -e "  ____               _   _         "      
    echo -e " |  _ \    ___    __| | (_)  ___   "
    echo -e " | |_) |  / _ \  / _  | | | / __|  "
    echo -e " |  _ <  |  __/ | (_| | | | \__ \  "
    echo -e " |_| \_\  \___|  \__,_| |_| |___/  "
    echo -e ${COLOR_EOF}
    echo -e " ${COLOR_GREEN}Easy${COLOR_BLUE}bash${COLOR_EOF} Project"
    echo -e
    echo -e " Web:    https://easybash.github.io/"
    echo -e " GitHub: https://github.com/terrylinooo/easybash"
    echo -e
    echo -e "${COLOR_BG_BLUE}${spaces}${COLOR_EOF}"
    echo -e ${COLOR_EOF}
fi

echo
echo " @os:      ${os_name} ${os_version} "
echo " @package: ${package_name}          "
echo " @version: ${package_version}       "
echo

#==============================================================================
# Part 4. Core
#==============================================================================

sudo ${_PM} update

if [ "${_PM}" == "aptitude" ]; then
    # Check if aptitude installed or not.
    is_aptitude=$(which aptitude |  grep "aptitude")

    if [ "${is_aptitude}" == "" ]; then
        func::easybash_msg info "Package manager \"aptitude\" is not installed, installing..."
        sudo apt-get install aptitude
    fi
fi

# Check if Redis has been installed or not.
func::easybash_msg info "Checking if redis is installed, if not, proceed to install it."

is_redis_installed=$(dpkg-query -W --showformat='${Status}\n' redis | grep "install ok installed")

if [ "${is_redis_installed}" == "install ok installed" ]; then
    func::easybash_msg warning "${package_name} is already installed, please remove it before executing this script."
    func::easybash_msg info "Try \"sudo ${_PM} purge redis-server\""
    exit 2
fi

if [ "${package_version}" == "latest" ]; then
    # Check if software-properties-common installed or not.
    is_add_apt_repository=$(which add-apt-repository |  grep "add-apt-repository")

    # Check if add-apt-repository command is available to use or not.
    if [ "${is_add_apt_repository}" == "" ]; then
        func::easybash_msg warning "Command \"add_apt_repository\" is not supported, install \"software-properties-common\" to use it."
        func::easybash_msg info "Proceeding to install \"software-properties-common\"."
        sudo ${_PM} install -y software-properties-common
    fi

    # Add repository for Redis.
    sudo add-apt-repository --yes ppa:chris-lea/redis-server

    # Update repository for Redis. 
    sudo ${_PM} update
fi

# Install Redis
func::easybash_msg info "Proceeding to install redis server."
sudo ${_PM} install -y redis-server

# To enable Redis server in boot.
func::easybash_msg info "Enable service redis in boot."
sudo systemctl enable redis-server

# To restart Redis service.
func::easybash_msg info "Restart service redis."
sudo service redis-server restart

redis_version="$(redis-server -v 2>&1)"

if [[ "${redis_version}" = *"Redis"* && "${redis_version}" != *"command not found"* ]]; then
    func::easybash_msg success "Installation process is completed."
    func::easybash_msg success "$(redis-server -v 2>&1)"
else
    func::easybash_msg warning "Installation process is failed."
fi
#!/usr/bin/env bash
#>                           +-------------+
#>                           |  nodejs.sh  |
#>                           +-------------+
#-
#- SYNOPSIS
#-
#-    nodejs.sh [-h] [-i] [-v [version]]
#-
#- OPTIONS
#-
#-    -v ?, --version=?    Which version of Node.js you want to install?
#-                         Accept vaule: latest (10.x), stable (8.x), system (8.10.0)
#-    -h, --help           Print this help.
#-    -i, --info           Print script information.
#-    --aptitude           Use aptitude instead of apt-get as package manager
#-
#- EXAMPLES
#-
#-    $ ./nodejs.sh -v system
#-    $ ./nodejs.sh --version=latest
#-    $ ./nodejs.sh
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
package_name="Node.js"

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
            # Which version of Node.js you want to install?
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
    func::component_welcome "nodejs" "${package_version}"
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
    echo -e "  _   _               _                _          "
    echo -e " | \ | |   ___     __| |   ___        (_)  ___    "
    echo -e " |  \| |  / _ \   / _\` |  / _ \       | | / __|  "
    echo -e " | |\  | | (_) | | (_| | |  __/  _    | | \__ \   "
    echo -e " |_| \_|  \___/   \__,_|  \___| (_)  _/ | |___/   "
    echo -e "                                    |__/          "
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

if [ "${_PM}" == "aptitude" ]; then
    # Check if aptitude installed or not.
    is_aptitude=$(which aptitude |  grep "aptitude")

    if [ "${is_aptitude}" == "" ]; then
        func::easybash_msg info "Package manager \"aptitude\" is not installed, installing..."
        sudo apt-get install aptitude
    fi
fi

# Check if Node.js has been installed or not.
func::easybash_msg info "Checking if Node.js is installed, if not, proceed to install it."

is_nodejs_installed=$(dpkg-query -W --showformat='${Status}\n' nodejs | grep "install ok installed")

if [ "${is_nodejs_installed}" == "install ok installed" ]; then
    func::easybash_msg warning "${package_name} is already installed, please remove it before executing this script."
    func::easybash_msg info "Try \"sudo ${_PM} purge nodejs\""
    exit 2
fi

if [ "${package_version}" == "latest" ]; then
    # Add repository for Node.js 10.x.
    curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash -
    # Update repository for Node.js. 
    sudo ${_PM} update
fi

if [ "${package_version}" == "stable" ]; then
    # Add repository for Node.js 8.x.
    curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
    # Update repository for Node.js. 
    sudo ${_PM} update
fi

# Install Node.js
func::easybash_msg info "Proceeding to install Node.js."
sudo ${_PM} install -y nodejs

nodejs_version="$(nodejs -v 2>&1)"

if [[ "${nodejs_version}" = "v"* && "${nodejs_version}" != *"command not found"* ]]; then
    func::easybash_msg success "Installation process is completed."
    func::easybash_msg success "$(nodejs -v 2>&1)"
else
    func::easybash_msg warning "Installation process is failed."
fi

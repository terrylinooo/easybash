#!/usr/bin/env bash
#>                           +-------------+
#>                           |  golang.sh  |
#>                           +-------------+
#-
#- SYNOPSIS
#-
#-    golang.sh [-h] [-i] [-v [version]]
#-
#- OPTIONS
#-
#-    -v ?, --version=?    Which version of Go you want to install?
#-                         Accept vaule: latest, system
#-    -h, --help           Print this help.
#-    -i, --info           Print script information.
#-    --aptitude           Use aptitude instead of apt-get as package manager
#-
#- EXAMPLES
#-
#-    $ ./golang.sh -v system
#-    $ ./golang.sh --version=latest
#-    $ ./golang.sh
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
os_version="16.04"
package_name="Golang"

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
            # Which version of Go you want to install?
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
    func::component_welcome "golang" "${package_version}"
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
    echo -e "    ____    ___    "
    echo -e "   / ___|  / _ \   "
    echo -e "  | |  _  | | | |  "
    echo -e "  | |_| | | |_| |  "
    echo -e "   \____|  \___/   "
    echo -e "                   "
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

# Check if Go has been installed or not.
func::easybash_msg info "Checking if Go is installed, if not, proceed to install it."

is_golang_installed=$(dpkg-query -W --showformat='${Status}\n' golang-go | grep "install ok installed")

if [ "${is_golang_installed}" == "install ok installed" ]; then
    func::easybash_msg warning "${package_name} is already installed, please remove it before executing this script."
    func::easybash_msg info "Try \"sudo ${_PM} purge golang-go\""
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

    # Add repository for Go.
    sudo add-apt-repository --yes ppa:longsleep/golang-backports

    # Update repository for Go. 
    sudo ${_PM} update
fi

# Install Go
func::easybash_msg info "Proceeding to install Go."
sudo ${_PM} install -y golang-go

golang_version="$(go version 2>&1)"

if [[ "${golang_version}" = *"go"* && "${golang_version}" != *"command not found"* ]]; then
    func::easybash_msg success "Installation process is completed."
    func::easybash_msg success "$(go version 2>&1)"
else
    func::easybash_msg warning "Installation process is failed."
fi

#!/usr/bin/env bash
#>                           +--------------+
#>                           |  postfix.sh  |   
#>                           +--------------+
#-
#- SYNOPSIS
#-
#-    postfix.sh [-h] [-n ...]
#-
#- OPTIONS
#-
#-    -n ?, --hostname=?            Hostname (FQDN)
#-                                  Accept vaule: latest, system
#-    -h, --help                    Print this help.
#-    -i, --info                    Print script information.
#-    --aptitude                    Use aptitude instead of apt-get as package manager
#-
#- EXAMPLES
#-
#-    $ ./postfix.sh -v latest -n mail.yourdomain.com
#-    $ ./postfix.sh --version=system --hostname=mail.yourdomain.com
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
package_name="Postfix"

# Debian/Ubuntu Only. Package manager: apt-get | aptitude
_PM="apt-get"
myhostname="localhost"

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
            # The hostname of Postfix mail server.
            "-n") 
                myhostname="${2}";
                shift 2
            ;;
            "--hostname="*) 
                myhostname="${1#*=}"
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
            "--hostname")
                echo "${1} requires an argument"
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
echo -e "  ____                  _      __   _         "
echo -e " |  _ \    ___    ___  | |_   / _| (_) __  __ "
echo -e " | |_) |  / _ \  / __| | __| | |_  | | \ \/ / "
echo -e " |  __/  | (_) | \__ \ | |_  |  _| | |  >  <  "
echo -e " |_|      \___/  |___/  \__| |_|   |_| /_/\_\ "
                                            
echo -e ${COLOR_EOF}
echo -e " ${COLOR_GREEN}Easy${COLOR_BLUE}bash${COLOR_EOF} Project"
echo -e
echo -e " Web:    https://easybash.github.io/"
echo -e " GitHub: https://github.com/terrylinooo/easybash"
echo -e
echo -e "${COLOR_BG_BLUE}${spaces}${COLOR_EOF}"
echo -e ${COLOR_EOF}

echo
echo " @os:      ${os_name}      "
echo " @package: ${package_name} "
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

# Check if Postfix has been installed or not.
func::easybash_msg info "Checking if postfix is installed, if not, proceed to install it."

is_postfix_installed=$(dpkg-query -W --showformat='${Status}\n' postfix | grep "install ok installed")

if [ "${is_postfix_installed}" == "install ok installed" ]; then
    func::easybash_msg warning "${package_name} is already installed, please remove it before executing this script."
    func::easybash_msg info "Try \"sudo apt-get purge postfix\""
    exit 2
fi

# Install Postfix without password prompt.
sudo ${_PM} install -y debconf-utils
export DEBIAN_FRONTEND=noninteractive
sudo debconf-set-selections <<< "postfix postfix/mailname string ${myhostname}"
sudo debconf-set-selections <<< "postfix postfix/main_mailer_type string 'Internet Site'"
sudo ${_PM} purge -y debconf-utils

# Install Postfix server
func::easybash_msg info "Proceeding to install postfix..."
sudo -E ${_PM} install -y postfix

unset DEBIAN_FRONTEND

# To Enable Postfix server in boot.
func::easybash_msg info "Proceeding to enable service postfix in boot."
sudo systemctl enable postfix

# To restart Postfix service.
func::easybash_msg info "Restart service postfix."
sudo service postfix restart

postfix_version="$(postconf mail_version 2>&1)"

if [[ "${postfix_version}" = *"mail_version"* && "${postfix_version}" != *"command not found"* ]]; then
    func::easybash_msg success "Installation process is completed."
    func::easybash_msg success "$(postconf mail_version 2>&1)"
else
    func::easybash_msg warning "Installation process is failed."
fi


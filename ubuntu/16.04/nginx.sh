#!/usr/bin/env bash
#>                           +------------+
#>                           |  nginx.sh  |   
#>                           +------------+
#-
#- SYNOPSIS
#-
#-    nginx.sh [-h] [-i] [-v [version]]
#-
#- OPTIONS
#-
#-    -v ?, --version=?    Which version of Nginx you want to install?
#-                         Accept vaule: latest, mainline, system
#-    -h, --help           Print this help.
#-    -i, --info           Print script information.
#-    --aptitude           Use aptitude instead of apt-get as package manager
#-
#- EXAMPLES
#-
#-    $ ./nginx.sh -v stable
#-    $ ./nginx.sh --version=mainline
#-    $ ./nginx.sh
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
package_name="Nginx"

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
            # Which version of Nginx you want to install?
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
    func::component_welcome "nginx" "${package_version}"
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
    echo -e "  _   _           _                  "
    echo -e " | \ | |   __ _  (_)  _ __   __  __  "
    echo -e " |  \| |  / _ \  | | | |  \  \ \/ /  "
    echo -e " | |\  | | (_| | | | | | | |  >  <   "
    echo -e " |_| \_|  \__, | |_| |_| |_| /_/\_\  "
    echo -e "          |___/                      "
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
echo " @branch:  ${package_version}       "
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

# Check if Nginx has been installed or not.
func::easybash_msg info "Checking if nginx is installed, if not, proceed to install it."

is_nginx_installed=$(dpkg-query -W --showformat='${Status}\n' nginx | grep "install ok installed")

if [ "${is_nginx_installed}" == "install ok installed" ]; then
    func::easybash_msg warning "${package_name} is already installed, please remove it before executing this script."
    func::easybash_msg info "Try \"sudo ${_PM} purge nginx\""
    exit 2
fi

# Add repository for Nginx.
# http://nginx.org/en/linux_packages.html#Ubuntu
if [ "${package_version}" == "latest" ]; then
    version_code="stable"
elif [ "${package_version}" == "mainline" ]; then
    version_code="mainline"
elif [ "${package_version}" == "system" ]; then
    version_code="system"
fi

if [ "${version_code}" != "system" ]; then

    # Check if required packages has been installed or not. 
    packages=("curl" "gnupg2" "ca-certificates" "lsb-release")

    for pkg in ${packages[@]}; do
        func::easybash_msg info "Checking if ${pkg} is installed, if not, proceed to install it."
        is_pkg_installed=$(dpkg-query -W --showformat='${Status}\n' ${pkg} | grep "install ok installed")

        if [ "${is_pkg_installed}" == "install ok installed" ]; then
            func::easybash_msg info "${pkg} is installed."
        else
            func::easybash_msg info "${pkg} is not installed."
            func::easybash_msg info "Proceeding to install ${pkg}."
            sudo ${_PM} install -y ${pkg}
        fi
    done

    if [ "${version_code}" == "stable" ]; then
        func::easybash_msg info "Set up the apt repository for stable nginx packages."
        echo "deb http://nginx.org/packages/ubuntu `lsb_release -cs` nginx" \
            | sudo tee /etc/apt/sources.list.d/nginx.list
    fi

    if [ "${version_code}" == "mainline" ]; then
        func::easybash_msg info "Set up the apt repository for mainline nginx packages."
        echo "deb http://nginx.org/packages/mainline/ubuntu `lsb_release -cs` nginx" \
            | sudo tee /etc/apt/sources.list.d/nginx.list
    fi

    func::easybash_msg info "Import an official nginx signing key"
    curl -fsSL https://nginx.org/keys/nginx_signing.key | sudo apt-key add -

    # Verify that you now have the proper key:
    sudo apt-key fingerprint ABF5BD827BD9BF62

    # Update repository for Nginx. 
    sudo ${_PM} update
fi

# Install Nginx
func::easybash_msg info "Proceeding to install nginx server."
sudo ${_PM} install -y nginx

# To enable Nginx server in boot.
func::easybash_msg info "Enable service nginx in boot."
sudo systemctl enable nginx

# To restart Nginx service.
func::easybash_msg info "Restart service nginx."
sudo service nginx restart

nginx_version="$(nginx -v 2>&1)"

if [[ "${nginx_version}" = *"nginx"* && "${nginx_version}" != *"command not found"* ]]; then
    func::easybash_msg success "Installation process is completed."
    func::easybash_msg success "$(nginx -v 2>&1)"
else
    func::easybash_msg warning "Installation process is failed."
fi
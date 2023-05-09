#!/usr/bin/env bash
#>                           +-------------+
#>                           |  sphinx.sh  |
#>                           +-------------+
#-
#- SYNOPSIS
#-
#-    sphinx.sh [-h] [-i]
#-
#- OPTIONS
#-                         Accept vaule: latest, system
#-    -h, --help           Print this help.
#-    -i, --info           Print script information.
#-
#- EXAMPLES
#-
#-    $ ./sphinx.sh
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

# Debian/Ubuntu Only. Package manager: apt-get | aptitude
#_PM="apt-get"

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
echo -e "   _____           _       _                 "         
echo -e "  / ____|         | |     (_)                "         
echo -e " | (___    _ __   | |__    _   _ __   __  __ " 
echo -e "  \___ \  | '_ \  | '_ \  | | | '_ \  \ \/ / " 
echo -e "  ____) | | |_) | | | | | | | | | | |  >  <  " 
echo -e " |_____/  | .__/  |_| |_| |_| |_| |_| /_/\_\ " 
echo -e "          | |                                " 
echo -e "          |_|                                " 
echo -e ${COLOR_EOF}
echo -e " ${COLOR_GREEN}Easy${COLOR_BLUE}bash${COLOR_EOF} Project"
echo -e
echo -e " Web:    https://easybash.github.io/"
echo -e " GitHub: https://github.com/terrylinooo/easybash"
echo -e
echo -e "${COLOR_BG_BLUE}${spaces}${COLOR_EOF}"
echo -e ${COLOR_EOF}


#==============================================================================
# Part 4. Core
#==============================================================================

# Install SphinxSearch
func::easybash_msg info "Switching to /var/lib/sphinx directory."
cd /var/lib
mkdir sphinx
cd sphinx

func::easybash_msg info "Downloading sphinx-3.5.1-82c60cb-linux-amd64.tar.gz file..."
wget -q http://sphinxsearch.com/files/sphinx-3.5.1-82c60cb-linux-amd64.tar.gz
func::easybash_msg info "Unpackaging file..."
tar zxf sphinx-3.5.1-82c60cb-linux-amd64.tar.gz

func::easybash_msg info "Creating Symbolic Links to searchd and indexer Executables for Sphinx Search Engine."
ln -s /var/lib/sphinx/sphinx-3.5.1/bin/searchd /usr/bin/searchd
ln -s /var/lib/sphinx/sphinx-3.5.1/bin/indexer /usr/bin/indexer

func::easybash_msg info "Creating group for SphinxSearch: sphinxsearch"
groupadd sphinxsearch

func::easybash_msg info "Creating user for SphinxSearch: sphinxsearch"
useradd -g sphinxsearch sphinxsearch

func::easybash_msg info "Creating configuration directory: /etc/sphinxsearch"
mkdir /etc/sphinxsearch
cp /var/lib/sphinx/sphinx-3.5.1/etc/* /etc/sphinxsearch/

func::easybash_msg info "Assign ownership of /etc/sphinxsearch"
chown -R sphinxsearch:sphinxsearch /etc/sphinxsearch

func::easybash_msg info "Creating logging directory: /var/log/sphinxsearch"
mkdir /var/log/sphinxsearch

func::easybash_msg info "Assign ownership of /var/log/sphinxsearch"
chown -R sphinxsearch:sphinxsearch /var/log/sphinxsearch

func::easybash_msg info "Creating index data directory: /var/data"
mkdir /var/data

func::easybash_msg info "Assign ownership of /var/data"
chown -R sphinxsearch:sphinxsearch /var/data

func::easybash_msg info "Creating .pid file directory: /run/sphinxsearch"
mkdir /run/sphinxsearch

func::easybash_msg info "Assign ownership of /run/sphinxsearch"
chown -R sphinxsearch:sphinxsearch /run/sphinxsearch

func::easybash_msg info "Creating systemd unit file for SphinxSearch"
func::easybash_msg info "Proceeding to write to /etc/systemd/system/searchd.service"
cat <<EOF > /etc/systemd/system/searchd.service
[Unit]
Description=Sphinx Search Server
After=network.target

[Service]
RuntimeDirectory=sphinxsearch
ExecStart=/usr/bin/searchd --config /etc/sphinxsearch/sphinx.conf
ExecStop=/usr/bin/searchd --stop
PIDFile=/run/sphinxsearch/searchd.pid
Type=forking
User=sphinxsearch

[Install]
WantedBy=multi-user.target
EOF

func::easybash_msg info "Initailizing configuration file: sphinx.conf"
cd /etc/sphinxsearch

cat <<EOF > /etc/sphinxsearch/sphinx.conf
#
# Minimal Sphinx configuration sample (clean, simple, functional)
#

source src1
{
    type            = mysql

    sql_host        = localhost
    sql_user        = test
    sql_pass        =
    sql_db          = test
    sql_port        = 3306  # optional, default is 3306

    sql_query       = \
        SELECT id, group_id, UNIX_TIMESTAMP(date_added) AS date_added, title, content \
        FROM documents

    sql_attr_uint   = group_id
    sql_attr_uint   = date_added
}

index test1
{
    source          = src1
    path            = /var/data/test1
}

index testrt
{
    type            = rt
    rt_mem_limit    = 128M

    path            = /var/data/testrt

    rt_field        = title
    rt_field        = content
    rt_attr_uint    = gid
}

indexer
{
    mem_limit       = 128M
}

searchd
{
    listen          = 9312
    listen          = 9306:mysql41
    log             = /var/log/sphinxsearch/searchd.log
    query_log       = /var/log/sphinxsearch/query.log
    read_timeout    = 5
    max_children    = 30
    pid_file        = /run/sphinxsearch/searchd.pid
    seamless_rotate = 1
    preopen_indexes = 1
    unlink_old      = 1
    workers         = threads # for RT to work
    binlog_path     = /var/data
}
EOF

func::easybash_msg info "Enabling searchd service"
systemctl enable searchd

echo -e ${COLOR_WHITE}
echo -e "Now, you have to edit /etc/sphinxsearch/sphinx.conf file to configure your SphinxSearch."
echo -e "After that, you can start SphinxSearch by running:"
echo -e "systemctl start searchd"
echo -e "or"
echo -e "service searchd start"
echo -e ""
echo -e "And, you may probably meet a problem when running indexer to build index files,"
echo -e "Because of missing of libmysqlclient.so or libmariadb.so."
echo -e "Visit https://github.com/terrylinooo/easybash for more information."
echo -e ${COLOR_EOF}

func::easybash_msg info "Starting searchd service"
systemctl enable start

func::easybash_msg success "Done."

searchd -v

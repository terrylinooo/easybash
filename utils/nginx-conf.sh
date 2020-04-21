#!/usr/bin/env bash
#>                           +-----------------+
#>                           |  nginx-conf.sh  |   
#>                           +-----------------+
#-
#- SYNOPSIS
#-
#-    nginx-conf.sh [-h] [-i] [-f [filename]] [-o [output folder]]
#-
#- OPTIONS
#-
#-    -f ?, --filename=?   Configured file name.
#-    -o ?, --ouput=?      The target folder. By default `/etc/nginx/sites-available` if not set.
#-    -h, --help           Print this help.
#-    -i, --info           Print script information.
#-
#- EXAMPLES
#-
#-    $ ./nginx-conf.sh -f terryl.in.conf
#-    $ ./nginx-conf.sh --filename=terryl.in.conf
#+
#+ IMPLEMENTATION:
#+
#+    package    Easybash
#+    copyright  https://github.com/terrylinooo/easybash
#+    license    MIT
#+    authors    Terry Lin (terrylinooo)
#+    
#+    Create a simple Nginx configuration file.
#+ 
#==============================================================================

#==============================================================================
# Functions (DO NOT MODIFY)
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

#==============================================================================
# Core
#==============================================================================


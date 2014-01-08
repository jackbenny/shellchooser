#!/bin/bash

################################################################################
#                                                                              #
#  Copyright (C) 2014 Jack-Benny Persson <jack-benny@cyberinfo.se>             #
#                                                                              #
#   This program is free software; you can redistribute it and/or modify       #
#   it under the terms of the GNU General Public License as published by       #
#   the Free Software Foundation; either version 2 of the License, or          #
#   (at your option) any later version.                                        #
#                                                                              #
#   This program is distributed in the hope that it will be useful,            #
#   but WITHOUT ANY WARRANTY; without even the implied warranty of             #
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the              #
#   GNU General Public License for more details.                               #
#                                                                              #
#   You should have received a copy of the GNU General Public License          #
#   along with this program; if not, write to the Free Software                #
#   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA  #
#                                                                              #
################################################################################

# shellchooser
Version="0.1"
Author="Jack-Benny Persson (jack-benny@cyberinfo.se)"

# Binaries
Which="/usr/bin/which"

# Binaries entered in the list will be avalible to the script as variables with
# the first letter uppercase
Binaries=(clear cp printf cat mktemp rm tail dialog diff)

# Variables
BashFiles="/etc/shellchooser/bashfiles"
CshFiles="/etc/shellchooser/cshfiles"
DashFiles="/etc/shellchooser/dashfiles"


### Functions ###

# Print version information
print_version()
{
        $Printf "\n\n$0 - $Version\n"
}

# Print help information
print_help()
{
        print_version
        $Printf "$Author\n"
        $Printf "Shell Chooser\n"
	/bin/cat <<-EOT

	Options:
	-h
	   Print detailed help screen
	-V
	   Print version information
	EOT
}

# Create our chooser dialog and return 1 if user aborted the dialog (if the
# the user hits esc or cancel). Otherwise return 0.
chooser()
{
	Temp=`$Mktemp -t chooser.XXXX`
	$Dialog --backtitle "Shell Chooser" \
	--menu "Choose your shell" 10 60 3 "/bin/bash" Bash \
	"/bin/dash" Dash "/bin/csh" Csh 2> $Temp
	if [ $? -ne 0 ]; then
		return 1
	fi
	Shell=`$Cat $Temp`
}

# Check out environment variables and if they have changed, replace
# them them with the original files
check_env()
{
	case $Shell in
	"/bin/bash")
		$Diff ${HOME}/.profile ${BashFiles}/.profile &> /dev/null
		if [ $? -ne 0 ]; then
			$Cp ${BashFiles}/.profile ${HOME}
		fi
		$Diff ${HOME}/.bashrc ${BashFiles}/.bashrc &> /dev/null
		if [ $? -ne 0 ]; then
			$Cp ${BashFiles}/.bashrc ${HOME}
		fi
		;;
	"/bin/csh")
		$Diff ${HOME}/.cshrc ${CshFiles}/.cshrc &> /dev/null
		if [ $? -ne 0 ]; then
			$Cp ${CshFiles}/.cshrc ${HOME}
		fi
		;;
	"/bin/dash")
		$Diff ${HOME}/.profile ${DashFiles}./profile
		if [ $? -ne 0 ]; then
			$Cp ${DashFiles}/.profile ${HOME}
		fi
	esac
}

# Create variables with absolute path to binaries and check
# if we can execute it (binaries will be avaliable in 
# variables with first character uppercase, such as Grep)
Count=0
for i in ${Binaries[@]}; do
	$Which $i &> /dev/null
	if [ $? -eq 0 ]; then
		declare $(echo ${Binaries[$Count]^}=`${Which} $i`)
		((Count++))
	else
		echo "It seems you don't have ${Binaries[$Count]} installed"
		exit 1
	fi
done

# Parse command line options and arguments
while getopts Vh Opt; do
       	case "$Opt" in
       	h) print_help
   	   exit 0
       	   ;;
       	V) print_version
   	   exit 0
       	   ;;
       	*) short_help
       	   exit 1
       	   ;;
       	esac
done


### Main ###
chooser
if [ $? -ne 0 ]; then
	echo "Aborting..."
	exit 1
fi
check_env
$Clear
$Shell


exit 0

# Shellchooser #
Shellchooser is a Bash script meant to run as a users shell, althouh it is not
a shell of it's own, it's an interactive chooser for different shells.
The shells avaliable to choose from in the script is Bash, Ash and Csh. It uses
`dialog` to display a nice menu. Since the script is meant to run before the
user has a sane environment all binaries used by the script is being run from
variables. The variables for the binaries are generated by a loop which uses
`which` to get the path for the binaries. The `which` command is hardcoded and
might need to be changed on different systems.

## Usage ##
Bundled with shellchooser is a small Makefile to ease installation of the
script. Simply run `make install` to install shellchooser.sh into /bin and the
profile/bashrc/cshrc files into /etc/shellchooser/. The installation will also 
put /bin/shellchooser.sh into /etc/shells so that system utilities won't 
complain about it not being a valid shell. Note that `make install` will fail
if you don't have all the required shells install on your system. The make
command will tell you which shells you are missing so that you can install them
on your system. See below how to install shells on some various systems.
To uninstall all of the files from the system including removing 
shellchooser.sh from /etc/shells simply run `make uninstall` from this 
directory.
Simply running `make` will print some short usage of the Makefile and which
shells your system have installed (and which shells you should have installed).

## Install Bash, Ash and Csh ##
### Debian/Ubuntu ###
`sudo apt-get install <shell>`

### OpenSuSE ###
`zypper install <shell>`

## Specifications ##
Two simple flowcharts shows how this script is built, what it does and which
files are installed/uninstalled with Makefile.
The two flowcharts resides in this directory and are called
flowchart\_makefile.png and flowchart\_shellchooser.png.

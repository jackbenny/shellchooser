FILES=shellchooser.sh bashfiles/profile bashfiles/bashrc cshfiles/cshrc \
ashfiles/profile
SHELLS=/bin/ash /bin/bash /bin/csh

shellchooser: $(FILES)
	$(info Use 'make install' to install shellchooser on your system.)
	$(info Use 'make uninstall' to uninstall shellchooser from your system.)
	$(info Please see README for more information on shellchooser.)
	$(info Your system should have bash, ash and csh installed.)
	$(info Of these shells your system have the following shells installed:)
	@which ash
	@which bash
	@which csh
	
install: $(FILES) $(SHELLS)
	chmod 755 shellchooser.sh
	cp shellchooser.sh /bin/shellchooser.sh
	mkdir /etc/shellchooser
	cp -r bashfiles /etc/shellchooser/bashfiles
	cp -r cshfiles /etc/shellchooser/cshfiles
	cp -r ashfiles /etc/shellchooser/ashfiles
	echo "/bin/shellchooser.sh" >> /etc/shells

uninstall:
	rm /bin/shellchooser.sh
	rm -rf /etc/shellchooser
	sed -i '/shellchooser.sh/d' /etc/shells

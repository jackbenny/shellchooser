FILES=shellchooser.sh bashfiles/profile bashfiles/bashrc cshfiles/cshrc \
ashfiles/profile

shellchooser: $(FILES)
	$(info Use 'make install' to install shellchooser on your system)
	$(info Use 'make uninstall' to uninstall shellchooser from your system)
	$(info Please see README for more information on shellchooser)
	
install: $(FILES)
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

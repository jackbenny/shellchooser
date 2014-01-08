FILES=shellchooser.sh bashfiles/.profile bashfiles/.bashrc cshfiles/.cshrc \
dashfiles/.profile

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
	cp -r dashfiles /etc/shellchooser/dashfiles

uninstall:
	rm /bin/shellchooser.sh
	rm -rf /etc/shellchooser

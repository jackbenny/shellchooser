FILES=shellchooser.sh bashfiles/.profile bashfiles/.bashrc cshfiles/.cshrc \
dashfiles/.profile

install: $(FILES)
	chmod 755 shellchooser.sh
	cp shellchooser.sh /bin/shellchooser.sh
	cp -r bashfiles /etc/bashfiles
	cp -r cshfiles /etc/cshfiles
	cp -r dashfiles /etc/dashfiles

uninstall:
	rm /bin/shellchooser.sh
	rm -rf /etc/bashfiles
	rm -rf /etc/cshfiles
	rm -rf /etc/dashfiles

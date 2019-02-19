install:
	mkdir -p ~/.local/bin
	mkdir -p ~/.local/share/applications
	mkdir -p ~/.local/share/systemd/user
	cp owasp-zap-weekly.sh       ~/.local/bin/
	cp owasp-zap-weekly.timer    ~/.local/share/systemd/user/
	cp owasp-zap-weekly.service  ~/.local/share/systemd/user/

uninstall:
	systemctl --user stop owasp-zap-weekly.timer
	systemctl --user stop owasp-zap-weekly.service
	rm -f ~/.local/bin/owasp-zap-weekly.sh
	rm -f ~/.local/share/applications/owasp-zap-weekly.desktop
	rm -f ~/.local/share/systemd/user/owasp-zap-weekly.timer
	rm -f ~/.local/share/systemd/user/owasp-zap-weekly.service
	rm -f ~/.local/share/systemd/timers/stamp-owasp-zap-weekly.timer
	systemctl --user daemon-reload
	echo 'Type `systemctl --user list-timers` to ensure'
	echo '  that owasp-zap-weekly was removed correctly'

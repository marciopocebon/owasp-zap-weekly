OWASP ZAP Weekly Build Automation
=================================

OWASP ZAP Team generate weekly releases of ZAP from the develop branch,
typically every Monday.

This script download ZAP weekly build (in `/tmp`), extract (in `~/`),
and make startup file in `~/.local/share/applications/owasp-zap-weekly.desktop`.

Also, it copies `owasp-zap-weekly.{service,timer}` in `~/.local/share/systemd/user`,
and `owasp-zap-weekly.sh` in `~/.local/bin` directories.

### Configuration

1.
```bash
$ git clone https://github.com/chinarulezzz/owasp-zap-weekly.git
$ cd owasp-zap-weekly
$ make install
```

2. Make sure that `~/.local/bin` is in your `$PATH` variable.

2. Start the timer & service:
```bash
$ systemctl --user daemon-reload
$ systemctl --user start owasp-zap-weekly.timer
$ systemctl --user start owasp-zap-weekly.service
```

Now, every Monday, at 9pm, after the ZAP team release a new build, you will have
the latest version installed:
```
$ systemctl --user list-timers
NEXT                         LEFT        LAST PASSED UNIT			ACTIVATES
Mon 2019-02-18 21:00:00 EET  6 days left n/a  n/a    owasp-zap-weekly.timer	owasp-zap-weekly.service
```

Search `owasp-zap-weekly` in programs list.

### Tested on

- Kali Linux.

### Author

Alexandr Savca, <alexandr.savca@saltedge.com>

### License

GPLv3

ZAP Weekly Build Automation
===========================

ZAP Team generate weekly releases of ZAP from the develop branch,
typically every Monday.

This script download ZAP Weekly builds, extract, and make startup file
in `~/.local/share/applications/zaproxy-weekly.desktop`.

### Configuration

1. Clone this repo.

2. Edit `zap_weekly.sh` and specify `_output_directory=`. This is the place,
where the ZAP archives will be downloaded and unpacked.

3. Edit `zap_weekly.service`, and specify the path to the script `zap_weekly.sh`
in `ExecStart=` directive.

3. Copy `zap_weekly.service` and `zap_weekly.timer` into
`~/.local/share/systemd/user` directory.

4. Start the service:
```
$ systemctl --user daemon-reload
$ systemctl --user start zap_weekly.timer
```

Now, every Monday, at 9pm, after the ZAP team release a new build, you will have
the latest version installed:
```
$ systemctl --user list-timers
NEXT                         LEFT        LAST PASSED UNIT               ACTIVATES
Mon 2019-02-18 21:00:00 EET  6 days left n/a  n/a    zap_weekly.timer   zap_weekly.service
```

Search `zap weekly` in programs list.

### Notes

I've tested and write `zap_weekly.desktop` for Kali Linux.
If you have a different system, probably `zap_weekly.desktop` needs an easy edit.

### Author

Alexandr Savca, <alexandr.savca@saltedge.com>

### License

GPLv3

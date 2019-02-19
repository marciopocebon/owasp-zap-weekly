#!/bin/bash
# This script downloading and installing as user ZAP weekly builds.

set -x

if [ `date +"%a"` = "Mon" ]; then
	_build_date=$(date +"%Y-%m-%d")
else
	_build_date=$(date -d "Last Mon" +"%Y-%m-%d")
fi
_download_url="https://github.com/zaproxy/zaproxy/releases/download"
_zap_archive="/tmp/ZAP_WEEKLY_D-${_build_date}.zip"
_zap_directory="${HOME}/ZAP_D-${_build_date}"

if [ -d "${_zap_directory}" ]; then
	echo "${_zap_directory} already exists."
elif [ -f "${_zap_archive}" ]; then
	unzip -d ${HOME} ${_zap_archive}
else
	wget -q -c -P /tmp \
	"${_download_url}/w${_build_date}/ZAP_WEEKLY_D-${_build_date}.zip"
	if [ -f "${_zap_archive}" ]; then
		unzip -d ${HOME} ${_zap_archive}
	else
		echo "Downloading failed. Quit"
		exit 1
	fi
fi

cat > ${HOME}/.local/share/applications/owasp-zap-weekly.desktop << EOF
[Desktop Entry]
Name=owasp-zap-weekly
GenericName=ZAP Weekly Build ${_build_date}
Comment=The OWASP Zed Attack Proxy (ZAP)
Encoding=UTF-8
Exec=sh -c "${HOME}/ZAP_D-${_build_date}/zap.sh"
Icon=kali-zaproxy.png
StartupNotify=false
Terminal=false
Type=Application
Categories=03-webapp-analysis;
X-Kali-Package=zaproxy
EOF

# End of file

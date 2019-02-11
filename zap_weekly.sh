#!/bin/bash
# This script downloading and installing as user ZAP weekly builds.

set -x

_output_directory=/home/alex/coding
_build_date=$(date +"%Y-%m-%d")
_zap_directory="${_output_directory}/ZAP_D-${_build_date}"
_zap_archive="${_output_directory}/ZAP_WEEKLY_D-${_build_date}.zip"
_zap_current_link="${_output_directory}/ZAP_D_CURRENT"
_download_url="https://github.com/zaproxy/zaproxy/releases/download"

if [ -d "${_zap_directory}" ]; then
	echo "${_zap_directory} already exists."
elif [ -f "${_zap_archive}" ]; then
	unzip -d ${_output_directory} ${_zap_archive}
else
	wget -q -c -P "${_output_directory}" \
	"${_download_url}/w${_build_date}/ZAP_WEEKLY_D-${_build_date}.zip"
	if [ -f "${_zap_archive}" ]; then
		unzip -d ${_output_directory} ${_zap_archive}
	else
		echo "Downloading failed. Quit"
		exit 1
	fi
fi

unlink ${_zap_current_link}
ln -s ${_zap_directory} ${_zap_current_link}

cat > ~/.local/share/applications/zaproxy-weekly.desktop << EOF
[Desktop Entry]
Name=zap weekly
Comment=ZAP Weekly ${_build_date}
Encoding=UTF-8
Exec=sh -c "${_zap_current_link}/zap.sh"
Icon=kali-zaproxy.png
StartupNotify=false
Terminal=false
Type=Application
Categories=03-webapp-analysis;
X-Kali-Package=zaproxy
EOF

# End of file
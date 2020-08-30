#!/bin/bash

echo "
██████╗░███████╗███╗░░██╗████████╗░█████╗░░█████╗░██╗░░░░░░██████╗
██╔══██╗██╔════╝████╗░██║╚══██╔══╝██╔══██╗██╔══██╗██║░░░░░██╔════╝
██████╔╝█████╗░░██╔██╗██║░░░██║░░░██║░░██║██║░░██║██║░░░░░╚█████╗░
██╔═══╝░██╔══╝░░██║╚████║░░░██║░░░██║░░██║██║░░██║██║░░░░░░╚═══██╗
██║░░░░░███████╗██║░╚███║░░░██║░░░╚█████╔╝╚█████╔╝███████╗██████╔╝
╚═╝░░░░░╚══════╝╚═╝░░╚══╝░░░╚═╝░░░░╚════╝░░╚════╝░╚══════╝╚═════╝░

Penetration testing tools installer for Debian [by Sm4rtK1dz]
"

help_menu() {
	echo "
	-h	help menu
	-d	install apt-get installables
	-g	clone git repos
	-e	clone experimental repos
	"
}

install_debian() {
	sudo apt update
	# Programming Languages
	sudo apt install -y php golang python-pip python3-pip
	# Administration Tools
	sudo apt install -y ufw net-tools ncat
	# Analytic Tools
	sudo apt install -y strace ltrace gobuster feh gedit steghide checksec
	sudo apt autoremove -y
}

install_ffuf() {
	wget -L github.com/ffuf/ffuf/releases/download/v1.0.2/ffuf_1.0.2_linux_amd64.tar.gz
	mkdir ./enum/ffuf 
	tar -xzf ffuf_1.0.2_linux_amd64.tar.gz -C ./enum/ffuf
	rm ffuf_1.0.2_linux_amd64.tar.gz
}

install_git() {
	git clone https://github.com/rebootuser/LinEnum.git ./enum/LinEnum
	git clone https://github.com/carlospolop/privilege-escalation-awesome-scripts-suite.git ./enum/PEASS
	git clone https://github.com/pentestmonkey/php-reverse-shell.git ./shell/php-reverse-shell
	git clone https://github.com/danielmiessler/SecLists.git ./wordlists/SecLists
	git clone https://github.com/Anon-Exploiter/SUID3NUM ./enum/SUID3NUM
	git clone https://github.com/trickster0/Enyx.git ./enum/ipv6Enyx

	[ ! -f ./enum/pspy64 ] && wget -P ./enum https://github.com/DominicBreuker/pspy/releases/download/v1.2.0/pspy64
	[ ! -f ./enum/pspy32 ] && wget -P ./enum https://github.com/DominicBreuker/pspy/releases/download/v1.2.0/pspy32

	[ ! -d ./enum/ffuf ] install_ffuf
}

install_experimental() {
	git clone https://github.com/SafeBreach-Labs/SirepRAT.git ./experimental/SirepRAT
	git clone https://github.com/OWASP/D4N155 ./experimental/D4N155
}

#install_debian_tools
#install_git_repos

while getopts hdge option
do
	case "${option}"
	in
	h) help_menu;;
	d) install_debian;;
	g) install_git;;
	e) install_experimental;;
	*) help_menu;;
	esac
done

if [ $# -eq 0 ]
  then
    help_menu
fi

exit 1

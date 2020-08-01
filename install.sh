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

prompt_install() {
	while true; do
	    read -p "Do you want to install ${1}? [Y/n] " yn
	    case $yn in
			[Yy]* ) $2; break;;
		    [Nn]* ) break;;
	    * ) echo "Please answer yes or no.";;
	    esac
	done
}

install_debian_tools() {
	sudo apt update
	# Programming Languages
	sudo apt install -y php golang python-pip python3-pip
	# Administration Tools
	sudo apt install -y ufw net-tools
	# Analytic Tools
	sudo apt install -y strace ltrace gobuster feh gedit steghide checksec
}
prompt_install "debian tools" install_debian_tools

install_debian_addons() {
	sudo apt-get install -y lxappearance i3
}
prompt_install "debian addons" install_debian_addons

install_git_repos() {
	git clone https://github.com/rebootuser/LinEnum.git ./enum/LinEnum
	git clone https://github.com/carlospolop/privilege-escalation-awesome-scripts-suite.git ./enum/PEASS
	git clone https://github.com/pentestmonkey/php-reverse-shell.git ./shell/php-reverse-shell
	git clone https://github.com/danielmiessler/SecLists.git ./wordlists/SecLists
	git clone https://github.com/Anon-Exploiter/SUID3NUM ./enum/SUID3NUM
	git clone https://github.com/trickster0/Enyx.git ./enum/ipv6Enyx

	wget -P ./enum https://github.com/DominicBreuker/pspy/releases/download/v1.2.0/pspy64
	wget -P ./enum https://github.com/DominicBreuker/pspy/releases/download/v1.2.0/pspy32
}
prompt_install "git repos" install_git_repos

install_ffuf() {
	wget -L github.com/ffuf/ffuf/releases/download/v1.0.2/ffuf_1.0.2_linux_amd64.tar.gz
	mkdir ffuf 
	tar -xzf ffuf_1.0.2_linux_amd64.tar.gz -C ffuf
	rm ffuf_1.0.2_linux_amd64.tar.gz
	mv ffuf enum/ffuf
}
prompt_install "ffuf" install_ffuf

sudo apt autoremove -y
exit 1

#!/bin/bash

# install GPG key for sublime text
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/sublimehq-archive.gpg

# select sublime text stable channel
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list

# apt installation section
sudo apt update
sudo apt install sublime-text seclists terminator -y
# install ssh-audit
sudo pip3 install ssh-audit

# install massdns
mkdir ~/Tools && cd ~/Tools
git clone https://github.com/blechschmidt/massdns.git
cd massdns
make
sudo make install
cd

# get public DNS resolver list
mkdir ~/resolvers && wget https://public-dns.info/nameservers.txt -P ~/resolvers/

# install go
cd ~/Downloads
go_href_attribute=$(curl -s https://go.dev/dl/ | grep 'download.*downloadBox' | grep -o '.*linux.*gz' | awk '{ print $4 }')
go_dl_path=https://go.dev${go_href_attribute#href=\"}
go_filename=${go_dl_path##*/*/}

wget $go_dl_path

sudo tar -xvf $go_filename -C /usr/local
sudo chown -R root:root /usr/local/go/

cd

# if using bash, add bash path variables
test -f ~/.bashrc && cp -v .bashrc .bashrc_backup && echo "export GOPATH=\$HOME/go" >> ~/.bashrc && echo "export GOROOT=/usr/local/go" >> ~/.bashrc && echo "export PATH=\$PATH:\$GOROOT/bin:\$GOPATH/bin" >> ~/.bashrc

# if using zsh, add zsh path variables
test -f ~/.zshrc && cp -v .zshrc .zshrc_backup && echo "export GOPATH=\$HOME/go" >> ~/.zshrc && echo "export GOROOT=/usr/local/go" >> ~/.zshrc && echo "export PATH=\$PATH:\$GOROOT/bin:\$GOPATH/bin" >> ~/.zshrc

if test -f ~/.bashrc
then
	. ~/.bashrc
fi

if test -f ~/.zshrc
then 
	. ~/.zshrc
fi

# install go tools
go install -v github.com/tomnomnom/assetfinder@latest
go install -v github.com/lc/gau/v2/cmd/gau@latest
go install -v github.com/hakluke/hakrawler@latest
go install -v github.com/projectdiscovery/nuclei/v2/cmd/nuclei@latest
go install -v github.com/d3mondev/puredns/v2@latest
go install -v github.com/Josue87/resolveDomains@latest
go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest
go install -v github.com/tomnomnom/unfurl@latest
go install -v github.com/tomnomnom/waybackurls@latest
go install -v github.com/Josue87/gotator@latest
go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest
go install -v github.com/projectdiscovery/mapcidr/cmd/mapcidr@latest


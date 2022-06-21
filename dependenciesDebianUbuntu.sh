#!/bin/bash
echo "apt update"
sudo apt -qq update >/dev/null
echo "installing snapd build-essential moreutils tree unzip"
sudo apt -qq install -y snapd build-essential moreutils tree unzip >/dev/null
echo "installing curl"
sudo snap install curl
echo "installing rustup"
sudo snap install rustup --classic
PATH=$PATH:/snap/bin
echo "installing rust"
rustup toolchain install stable
echo "installing vdash"
cargo install vdash
echo "deleting /usr/local/bin/safe"
rm -rf /usr/local/bin/safe
echo "deleting ~/.safe"
rm -rf $HOME/.safe
echo "installing safe"
curl -so- https://raw.githubusercontent.com/maidsafe/safe_network/master/resources/scripts/install.sh | bash
PATH=$PATH:$HOME/.safe/cli:/usr/local/bin/
echo ""
echo ""
echo ""
echo $(safe --version) "install complete"


echo "installing sn_node"
safe node install
echo ""
echo ""
echo ""
echo $(safe node bin-version) "install complete"

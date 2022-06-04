#!/bin/bash
curl -so- https://raw.githubusercontent.com/maidsafe/safe_network/master/resources/scripts/install.sh | bash
PATH=$PATH:$HOME/.safe/cli
echo ""
echo ""
echo ""
echo $(safe --version) "install complete"



safe node install
echo ""
echo ""
echo ""
echo $(safe node bin-version) "install complete"

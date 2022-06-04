#!/bin/bash
curl -so- https://raw.githubusercontent.com/maidsafe/safe_network/master/resources/scripts/install.sh | bash
echo ""
echo ""
echo ""
echo $($HOME/.safe/cli/safe --version) "install complete"

$HOME/.safe/cli/safe node install || /usr/local/bin/safe node install
echo ""
echo ""
echo ""
echo $($HOME/.safe/cli/safe node bin-version) "install complete"

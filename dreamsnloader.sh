#!/bin/bash
sh ./deps/dep1_debian.sh
sh ./deps/dep2.sh
sh ./deps/dep3.sh
sh ./deps/dep4.sh

echo "           Which testnet do you want to connect to?"
echo ""
echo "           None of these testnets are guaranteed or even likely to be running at any given time"
echo "           Please refer to threads on https://safenetforum.org for current news on live testnets."
echo ""
echo "               1     sjefolaht"
echo "               2     comnet"
echo "               3     southsidenet"
echo "               4     playground"
echo "               5     dreamnet"
echo ""
echo ""
echo "                                    Please select 1, 2, 3, 4 or 5"
read SAFENET_CHOICE
echo ""

case $SAFENET_CHOICE in
  1)
  SAFENET=sjefolaht
  CONFIG_URL=https://link.tardigradeshare.io/s/julx763rsy2egbnj2nixoahpobgq/rezosur/koqfig/sjefolaht_node_connection_info.config?wrap=0

    ;;
  2)  SAFENET=comnet
    CONFIG_URL=https://sn-comnet.s3.eu-west-2.amazonaws.com/node_connection_info.config
    ;;
  3)
  SAFENET=southsidenet
    CONFIG_URL=https://comnet.snawaffadyke.com/southsidenet.config
    ;;
    4)
  SAFENET=playground
    CONFIG_URL=https://safe-testnet-tool.s3.eu-west-2.amazonaws.com/public-node_connection_info.config

    ;;

    5)
  SAFENET=dreamnet
    CONFIG_URL=https://nx23255.your-storageshare.de/s/F7e2QaDLNC2z94z/download/dreamnet.config

    ;;


  *)
    echo " Invalid selection, please choose 1-5 to select a testnet"
    ;;
esac

echo ""
echo "                    Your node will attempt to connect to "$SAFENET
echo ""

echo ""
echo "              Certain setups may require the default port that SAFE uses to be changed"
echo "              Most users will be OK with the default port at 12000 "
echo "              Only change this if you know what you are doing."
echo ""

#####################################################################################################################################change for default port
SAFE_PORT=12000
read -e -i "$name" -p "              Press Enter to accept the default or edit it here $SAFE_PORT    " input
SAFE_PORT="${input:-$SAFE_PORT}"
echo $SAFE_PORT
###########################################################################################################################################################

echo "ready"

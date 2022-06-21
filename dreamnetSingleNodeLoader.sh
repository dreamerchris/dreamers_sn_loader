#!/bin/bash

usage()
{
  echo "Usage: [-p port]"
}

ACTIVE_IF=$( ( cd /sys/class/net || exit; echo *)|awk '{print $1;}')
LOCAL_IP=$(echo $(ifdata -pa "$ACTIVE_IF"))
PUBLIC_IP=$(echo $(curl -s ifconfig.me))
SAFE_PORT=12000

while getopts 'apns::?h' c
do
  case $c in
    p) SAFE_PORT=$OPTARG ;;
    h|?) usage ;;
  esac
done

SAFENET=dreamnet
CONFIG_URL=https://nx23255.your-storageshare.de/s/F7e2QaDLNC2z94z/download/dreamnet.config

safe networks add $SAFENET "$CONFIG_URL"
safe networks switch $SAFENET

PATH=$PATH:/$HOME/.safe/cli:$HOME/.cargo/bin:/usr/local/bin/

DIR_NUM=0
while [ -d $HOME/.safe/node/local_node$DIR_NUM ]
do
DIR_NUM=$DIR_NUM+1
done
DIR=$HOME/.safe/node/local_node$DIR_NUM
mkdir -p $DIR
echo ""
echo "Joining Dreamnet with root and log directory: $DIR"
echo ""
RUST_LOG=sn_node=trace $HOME/.safe/node/sn_node --local-addr "$LOCAL_IP":$SAFE_PORT --public-addr "$PUBLIC_IP":$SAFE_PORT --skip-auto-port-forwarding --root-dir $DIR --log-dir $DIR & disown
echo ""
echo "copy and paste the following to run vdash!"
echo ""
echo "$HOME/.cargo/bin/vdash $DIR/sn_node.log"

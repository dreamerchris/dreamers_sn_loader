#!/bin/bash

ACTIVE_IF=$( ( cd /sys/class/net || exit; echo *)|awk '{print $1;}')
LOCAL_IP=$(echo $(ifdata -pa "$ACTIVE_IF"))
PUBLIC_IP=$(echo $(curl -s ifconfig.me))
SAFE_PORT=12000

SAFENET=dreamnet
CONFIG_URL=https://nx23255.your-storageshare.de/s/F7e2QaDLNC2z94z/download/dreamnet.config

safe networks add $SAFENET "$CONFIG_URL"
safe networks switch $SAFENET

PATH=$PATH:/$HOME/.safe/cli:$HOME/.cargo/bin 

DIR1=$HOME/.safe/node/local_node1
mkdir $DIR1

nohup RUST_LOG=sn_node=trace,qp2p=info \
    $HOME/.safe/node/sn_node \
    --local-addr "$LOCAL_IP":$SAFE_PORT \
    --public-addr "$PUBLIC_IP":$SAFE_PORT \
    --skip-auto-port-forwarding \
    --root-dir "$DIR1" \
    --log-dir "$DIR1" & disown > nohupOutput.txt 2>&1

$HOME/.cargo/bin/vdash $HOME/.safe/node/local_node1/sn_node.log

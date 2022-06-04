#!/bin/bash
bash ./deps/dep1_debian.sh
bash ./deps/dep2.sh
bash ./deps/dep3.sh
bash ./deps/dep4.sh
bash ./deps/depsafe.sh
PATH=$PATH:$HOME/.safe/cli
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

USER=$(whoami)

safe networks add $SAFENET "$CONFIG_URL"
safe networks switch $SAFENET

ACTIVE_IF=$( ( cd /sys/class/net || exit; echo *)|awk '{print $1;}')
LOCAL_IP=$(echo $(ifdata -pa "$ACTIVE_IF"))
PUBLIC_IP=$(echo $(curl -s ifconfig.me))


CURRENT_ROOT_DIR=$HOME/.safe/node/local_node1/
CURRENT_LOG_DIR=$HOME/.safe/node/local_node1/
mkdir $CURRENT_ROOT_DIR

echo -n "#!/bin/bash
RUST_LOG=sn_node=trace,qp2p=info \
        $HOME/.safe/node/sn_node \
        --local-addr '$LOCAL_IP':$SAFE_PORT \
        --public-addr '$PUBLIC_IP':$SAFE_PORT \
        --skip-auto-port-forwarding \
        --root-dir '$CURRENT_ROOT_DIR' \
        --log-dir '$CURRENT_LOG_DIR' & disown" \
| tee $HOME/.safe/node/start-node1.sh

chmod u+x $HOME/.safe/node/start-node1.sh

echo -n "[Unit]
Description=Safe Local Node 1
[Service]
User=$USER
ExecStart=$HOME/.safe/node/start-node1.sh
Type=forking
[Install]
WantedBy=multi-user.target"\
| sudo tee /etc/systemd/system/sn_node1.service

sudo systemctl start sn_node1.service


echo ""
echo "End of dreamsnloader script. Starting vdash!"
echo ""

$HOME/.cargo/bin/vdash $HOME/.safe/node/local_node1/sn_node.log

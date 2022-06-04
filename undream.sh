 
#!/bin/bash
nohup safe node killall >/dev/null 2>&1

sudo systemctl stop sn_node1.service
sudo systemctl disable sn_node1.service

sudo systemctl daemon-reload
sudo systemctl reset-failed

rm -rf ~/.safe/node/local_node1

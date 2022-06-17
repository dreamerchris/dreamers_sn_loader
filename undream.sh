 
#!/bin/bash
nohup safe node killall >/dev/null 2>&1
NUM=1
while [ -d $HOME/.safe/node/local_node$NUM ]
do
rm -rf ~/.safe/node/local_node$NUM
NUM=$NUM+1
done

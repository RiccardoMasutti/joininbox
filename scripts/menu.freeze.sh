#!/bin/bash

# unlocking with stdin does not work with the freeze method:
# https://github.com/JoinMarket-Org/joinmarket-clientserver/issues/598
# /home/joinmarket/start.script.sh wallet-tool $(cat $wallet) freeze $(cat $mixdepth)

source joinin.conf
source menu.functions.sh

# get wallet
wallet=$(tempfile 2>/dev/null)
dialog --backtitle "Choose a wallet" \
--title "Choose a wallet by typing the full name of the file" \
--fselect "/home/joinmarket/.joinmarket/wallets/" 10 60 2> $wallet
openMenuIfCancelled $?

# get mixdepth
mixdepth=$(tempfile 2>/dev/null)
dialog --backtitle "Choose a mixdepth" \
--inputbox "Enter a number between 0 to 4 to choose the mixdepth" 8 60 2> $mixdepth
openMenuIfCancelled $?

if [ ${RPCoverTor} = "on" ];then 
  tor="torify"
else
  tor=""
fi

clear
echo "Running the command:
$tor torify python ~/joinmarket-clientserver/scripts/wallet-tool.py -m$(cat $mixdepth) $(cat $wallet) freeze
"
# run command
$tor python ~/joinmarket-clientserver/scripts/wallet-tool.py -m$(cat $mixdepth) $(cat $wallet) freeze

#!/bin/bash

for octet in 183, 249
do
ssh test@192.168.2.${octet} 'sudo apt update && sudo apt -y install htop'
done


#!/bin/sh
echo -n "Input website: http://"
read website
echo "Searching http://$website .."
sleep 1
curl http://$website

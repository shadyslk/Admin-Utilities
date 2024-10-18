#!/bin/bash

count=0
time=90

while [[ "$(systemctl status $1 | grep "Active:" -h)" =~ "Active: active" || count < 5 ]]; do

        ((count++))
        echo "Stopping $1 now... Attempt $count"
        systemctl stop $1

        if [[ "$(systemctl status $1 | grep "Active:" -h)" =~ "Active: inactive" ]]; then

                echo "$1 has been stopped."

        else

                systemctl start $1

        fi

done

echo "Startup will begin in $time seconds..."
sleep $time
echo "Starting $1 again..."
systemctl start $1
echo "$1 started again."
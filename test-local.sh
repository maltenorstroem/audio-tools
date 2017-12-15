#!/bin/bash

polymer lint ./*.html
polymer analyze ./*.html > analysis.json

echo "init config"
cp wct.local.conf.json wct.conf.json

echo "Start WCT with wct.local.conf.json"

function get_unused_port() {
  for port in $(seq 2000 4000);
  do
    echo -ne "\035" | telnet 127.0.0.1 $port > /dev/null 2>&1;
    [ $? -eq 1 ] && echo "$port" && break;
  done
}
FREE_PORT="$(get_unused_port)"
echo $FREE_PORT


wct --webserver-port $FREE_PORT

EXIT=$?

#rm wct.conf.json

if [ $EXIT != 0 ]
  then

    echo "check test_result.json"
fi
exit $EXIT

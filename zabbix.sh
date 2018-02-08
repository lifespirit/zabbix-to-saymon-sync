#!/bin/bash

##############################
#
# Skript for send Zabbix data to Saymon
#
# Data get from Zabbix API and load to Saymon via Saymon Agent
# 
#

#Zabbix api user
USER=local_api
PASSWORD=local_api_password

#Zabbix server api URL
HOST=http://127.0.0.1/zabbix/api_jsonrpc.php

#File for save zabbix auth
DATAFILE=/opt/app/zabbix/auth

AUTH=`cat $DATAFILE`

if [[ $((`date +%s`-`ls -l $DATAFILE --time-style=+%s | awk '{print $6}'`)) -gt 1200 ]] || [ ! -f $DATAFILE ]
then
  AUTH=`curl -X POST -H 'Content-Type: application/json-rpc' -d "\
  {\
    \"jsonrpc\": \"2.0\",\
    \"method\": \"user.login\",\
    \"params\": {\
        \"user\": \"${USER}\",\
        \"password\": \"${PASSWORD}\"\
    },\
    \"id\": 1,\
    \"auth\": null\
  }\
  " $HOST | jq -r ".result"`

echo $AUTH > $DATAFILE
fi

RESULT=`curl -X POST -H 'Content-Type: application/json-rpc' -d "\
{\
    \"jsonrpc\": \"2.0\",\
    \"method\": \"item.get\",\
    \"params\": {\
        \"output\": \"extend\",\
        \"host\": \"$1\",\
        \"search\": {\
            \"name\": \"$2\"\
        },\
        \"sortfield\": \"name\"\
    },\
    \"auth\": \"${AUTH}\",\
    \"id\": 1\
}\
" $HOST | jq -r ".result[] | .lastvalue"`

echo $RESULT

#!/bin/bash
# SPDX-FileCopyrightText: 2021-present Open Networking Foundation <info@opennetworking.org>
#
# SPDX-License-Identifier: LicenseRef-ONF-Member-1.0

# script to create Grafana Orgs
# Usage:
# grafana-create-orgs.sh <ADMINUSER> <ADMINPASS> <umbrella-chart-name> <grafana-server> <dashboard-folder> orgs...
# where org is a quoted string containing org name and then in square brackets a list of vcs
# e.g. "acme[acme-chicago-robots acme-chicago-cameras]"
set -e
#set -x
set -o pipefail
set -u

if [ "$#" -lt 6 ]; then
  echo "At least 6 args are needed. Got $#"
  exit 1
fi
ADMINUSER=$1
ADMINPASS=$2
BASE=$3
SOURCE=$BASE-prometheus-server
SERVICE=$4
DASHBOARDS=$5
shift
shift
shift
shift
shift
for orgWithVcs in "$@"
do
  ORGASCII=${orgWithVcs%%map\[*\]} # Drop the [*] off the end
  echo "Creating $orgWithVcs as $ORGASCII"
  VCSLIST=${orgWithVcs##${ORGASCII}map\[*\]\ vcs:\[} # Drop everything off the front until "] vcs:["
  VCSLIST=${VCSLIST%\]\]} # Drop the ]] off the end
  DGLIST=${orgWithVcs##${ORGASCII}map\[devicegroup:\[} # Drop everything off the front until "devicegroup:[map["
  DGLIST=${DGLIST%\]\ vcs:*\]\]}
  DGLIST1=${DGLIST//" map["/";map["} # Replace all occurrence of " map["
  IFS=';' read -r -a DGARRAY <<< $DGLIST1
  for idx in ${!DGARRAY[@]}; do
    DGARRAY[$idx]=${DGARRAY[$idx]// /;} # Replace all instances of space with ;
  done
  SUCCESS=-1
  ORGID=-1
  # Commented out for the moment - keeping everything in the Main Org. - see aether-roc-gui/docs/grafana.md
  #      echo "Calling /usr/bin/curl -H "Content-Type: application/json" -d '{"name":"$ORGASCII"}' http://$ADMINUSER:####@$SERVICE/api/orgs"
  #      while [ $SUCCESS -ne 0 ];
  #      do
  #        DATA={\"name\":\"$ORGASCII\"}
  #        echo "Creating Org $ORGASCII"
  #        /usr/bin/curl -o /tmp/curlout -H "Content-Type: application/json" -d "$DATA" http://$ADMINUSER:$ADMINPASS@$SERVICE/api/orgs
  #        SUCCESS=`echo $?`
  #        echo "SUCCESS $SUCCESS"
  #        if [ $SUCCESS -ne 0 ]
  #        then
  #          sleep $SLEEP
  #          echo "Waiting $SLEEP seconds for Grafana to start"
  #        else
  #          ORGID=$(grep -o "[0-9]*" /tmp/curlout)
  #          echo "Successful! Result $ORGID"
  #        fi
  #      done

  #      echo "Calling /api/user/using/$ORGID"
  #      /usr/bin/curl -s -X POST http://$ADMINUSER:$ADMINPASS@$SERVICE/api/user/using/$ORGID
  #      SUCCESS=`echo $?`
  #      echo "SUCCESS $SUCCESS"

  echo "Creating folder in $ORGASCII"
  FOLDER={\"uid\":\"$ORGASCII\",\"title\":\"$ORGASCII\"}
  /usr/bin/curl -o /tmp/curlout -H "Content-Type: application/json" -d "$FOLDER" http://$ADMINUSER:$ADMINPASS@$SERVICE/api/folders
  SUCCESS="$?"
  echo "SUCCESS $SUCCESS"
  cat /tmp/curlout

  echo "Creating datasource in $ORGASCII"
  DATASOURCE={\"name\":\"datasource-$ORGASCII\",\"type\":\"prometheus\",\"url\":\"http://$SOURCE\",\"access\":\"proxy\",\"basicAuth\":false}
  /usr/bin/curl -s -o /tmp/curlout -H "Content-Type: application/json" -d "$DATASOURCE" http://$ADMINUSER:$ADMINPASS@$SERVICE/api/datasources
  SUCCESS=`echo $?`
  echo "SUCCESS $SUCCESS"
  cat /tmp/curlout

  echo "now create Dashboards with "$VCSLIST
  grafana-create-vcs.sh $ADMINUSER $ADMINPASS $SERVICE $DASHBOARDS $ORGASCII $VCSLIST
  grafana-create-device-group.sh $ADMINUSER $ADMINPASS $SERVICE $DASHBOARDS $ORGASCII $DGARRAY

done


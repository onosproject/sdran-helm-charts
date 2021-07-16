#!/bin/sh
# SPDX-FileCopyrightText: 2021-present Open Networking Foundation <info@opennetworking.org>
#
# SPDX-License-Identifier: LicenseRef-ONF-Member-1.0

# script to create Grafana VCS dashboards
# Usage:
# grafana-create-vcs.sh <ADMINUSER> <ADMINPASS> <umbrella-chart-name> <grafana-server> <list of vcs>...
SLEEP=5
ADMINUSER=$1
ADMINPASS=$2
SOURCE=$3-prometheus-server
SERVICE=$4
shift
shift
shift
shift
for vcs in "$@"
do
  ORGASCII=${org//[^a-zA-Z0-9]/_}
  SUCCESS=-1
  ORGID=-1

  echo "Creating vcs in $org"
  FOLDER={\"uid\":\"$ORGASCII\",\"title\":\"$ORGASCII\"}
  /usr/bin/curl -s -o /tmp/curlout -H "Content-Type: application/json" -d "$FOLDER" http://$ADMINUSER:$ADMINPASS@$SERVICE/api/folders
  SUCCESS=`echo $?`
  echo "SUCCESS $SUCCESS"
  cat /tmp/curlout

  echo "Creating datasource in $org"
  DATASOURCE={\"name\":\"datasource-$ORGASCII\",\"type\":\"prometheus\",\"url\":\"http://$SOURCE\",\"access\":\"proxy\",\"basicAuth\":false}
  /usr/bin/curl -s -o /tmp/curlout -H "Content-Type: application/json" -d "$DATASOURCE" http://$ADMINUSER:$ADMINPASS@$SERVICE/api/datasources
  SUCCESS=`echo $?`
  echo "SUCCESS $SUCCESS"
  cat /tmp/curlout

  echo "Creating dashboards in $org"
  for f in /usr/local/dashboards/$ORGASCII/*.json; do
    echo "Creating Dashboard from $f"
    DASHBOARD=$(cat $f)
    /usr/bin/curl -s -o /tmp/curlout -H "Content-Type: application/json" -d "$DASHBOARD" http://$ADMINUSER:$ADMINPASS@$SERVICE/api/dashboards/db
    SUCCESS=`echo $?`
    echo "SUCCESS $SUCCESS"
    cat /tmp/curlout
  done

done


#!/bin/bash
# SPDX-FileCopyrightText: 2021-present Open Networking Foundation <info@opennetworking.org>
#
# SPDX-License-Identifier: LicenseRef-ONF-Member-1.0

# script to create Grafana VCS dashboards
# Usage:
# grafana-create-vcs.sh <ADMINUSER> <ADMINPASS> <grafana-server> <dashboards-folder> <org> <list of vcs>...
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
SERVICE=$3
FOLDER=$4
export ORG=$5
shift
shift
shift
shift
shift
for dg in "$@"; do
  DG=${dg%:map\[*\]} # Remove DG details from end
  DG=${DG#map[} # Remove "map[" from the front
  DGASCII=${DG//[^a-zA-Z0-9]/_} # Convert to underscore
  IMSIS=${dg#map[${DG}:map\[} # Remove DG name from start
  IMSIS=${IMSIS%\]\]} # Remove ] from the end
  IMSIS=${IMSIS//;/ }
  echo "Creating Device Group $DG ($DGASCII) in $ORG"
  for imsirange in $IMSIS; do
    echo "Creating Imsi Range $imsirange in $DG"
    RANGENAME=${imsirange%:*} # Remove range from end
    RANGEVALUE=${imsirange#*:}
    declare -i RANGESTART=${RANGEVALUE%-*} # Remove the finish
    declare -i RANGEFINISH=${RANGEVALUE#*-} # Remove the start
    COUNTER=$RANGESTART
    f=$FOLDER/ue-connectivity.json
    while [  $COUNTER -le $RANGEFINISH ]; do
        echo "Creating Dashboard from $f for $COUNTER"
        export IMSI=$COUNTER
        DASHBOARD=$(envsubst < $f)
        /usr/bin/curl -s -o /tmp/curlout -H "Content-Type: application/json" -d "$DASHBOARD" http://$ADMINUSER:$ADMINPASS@$SERVICE/api/dashboards/db
        SUCCESS=`echo $?`
        echo "SUCCESS $SUCCESS"
        cat /tmp/curlout
      let COUNTER=COUNTER+1
    done
  done
  SUCCESS=-1
  ORGID=-1

done

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
for vcs in "$@"; do
  VCSASCII=${vcs//[^a-zA-Z0-9]/_}
  SUCCESS=-1
  ORGID=-1

  echo "Creating vcs $vcs ($VCSASCII) in $ORG"
  for f in $FOLDER/*.json; do
    if [ -f "$f" ]; then
      echo "Creating Dashboard from $f"
      export VCS=$vcs
      DASHBOARD=$(envsubst < $f)
      /usr/bin/curl -s -o /tmp/curlout -H "Content-Type: application/json" -d "$DASHBOARD" http://$ADMINUSER:$ADMINPASS@$SERVICE/api/dashboards/db
      SUCCESS=`echo $?`
      echo "SUCCESS $SUCCESS"
      cat /tmp/curlout
    else
      echo "No dashboards found"
    fi
  done

done

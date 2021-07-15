#!/bin/bash

# Usage: roc-sanity-test.sh <NAMESPACE>

# This script pushes some test data into the ROC, collects the sdcore-adapter logs,
# and pipes them to another script for validating the Push Update messages in the logs.
# It assumes that no other data has been already pushed to the ROC.

NAMESPACE=$1
TMPDIR=/tmp
SCRIPTDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
FILEBASE=${SCRIPTDIR}/..

APIPOD=$(kubectl -n ${NAMESPACE} get pod -l name=aether-roc-api --output=jsonpath={.items..metadata.name})
ADAPTERPOD=$(kubectl -n ${NAMESPACE} get pod -l app.kubernetes.io/name=sdcore-adapter-v3 --output=jsonpath={.items..metadata.name})

echo "Set up port forward to ROC API"
kubectl -n ${NAMESPACE} port-forward svc/aether-roc-api 8181:8181 &
echo "Sleep for 5 seconds"; sleep 5
echo "Load test data into ROC API"
${SCRIPTDIR}/MEGA_Patch.curl
echo "Tear down port forward"
pkill -9 kubectl

# Validate pushed JSON from logs
echo "Sleep for 5 seconds"; sleep 5
echo "Validate Push Update contents in sdcore-adapter logs"
kubectl -n ${NAMESPACE} logs ${ADAPTERPOD} sdcore-adapter-v3 | ${SCRIPTDIR}/validate-push-updates.py ${FILEBASE}
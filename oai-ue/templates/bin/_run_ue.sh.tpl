#!/bin/bash
# SPDX-FileCopyrightText: 2020-present Open Networking Foundation <info@opennetworking.org>
#
# SPDX-License-Identifier: Apache-2.0

set -ex

# In the init version, only support 1 UE - will support multiple UEs
pushd /opt/oai-ue/share
/opt/oai-ue/bin/lte-uesoftmodem -O /opt/oai-ue/share/ue.conf --L2-emul 3 --num-ues {{ index .Values "config" "oai-ue" "numDevices" }} --nums_ue_thread 1 -r {{ index .Values "config" "oai-ue" "numRBs" }} --ue-sync-timer {{ index .Values "config" "oai-ue" "syncTimer" }} --ue-num-frames-ra {{ index .Values "config" "oai-ue" "numFramesRA" }}
popd

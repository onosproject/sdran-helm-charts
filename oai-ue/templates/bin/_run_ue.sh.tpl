#!/bin/bash
# SPDX-FileCopyrightText: 2020-present Open Networking Foundation <info@opennetworking.org>
#
# SPDX-License-Identifier: LicenseRef-ONF-Member-1.0

set -ex

# In the init version, only support 1 UE - will support multiple UEs
pushd /opt/oai-ue/share
/opt/oai-ue/bin/lte-uesoftmodem -O /opt/oai-ue/share/ue.conf --L2-emul 3 --num-ues 1 --nums_ue_thread 1
popd

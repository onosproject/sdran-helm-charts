#!/bin/bash
# SPDX-FileCopyrightText: 2020-present Open Networking Foundation <info@opennetworking.org>
#
# SPDX-License-Identifier: Apache-2.0

set -ex

echo "ToDo: add codes to gen SIM"
pushd /opt/oai-ue/share
/opt/oai-ue/bin/nvram --gen -c /opt/oai-ue/share/ue_sim.conf -o /opt/oai-ue/share
/opt/oai-ue/bin/usim --gen -c /opt/oai-ue/share/ue_sim.conf -o /opt/oai-ue/share
popd
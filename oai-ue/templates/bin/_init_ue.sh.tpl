#!/bin/bash
# SPDX-FileCopyrightText: 2020-present Open Networking Foundation <info@opennetworking.org>
#
# SPDX-License-Identifier: Apache-2.0

set -ex

cp /opt/oai-ue/conf_files/ue.conf /opt/oai-ue/share/ue.conf
cp /opt/oai-ue/conf_files/ue_sim.conf /opt/oai-ue/share/ue_sim.conf

/opt/oai-ue/gen_ue_sim.sh

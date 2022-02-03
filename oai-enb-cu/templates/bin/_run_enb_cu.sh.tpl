#!/bin/bash
# SPDX-FileCopyrightText: 2020-present Open Networking Foundation <info@opennetworking.org>
#
# SPDX-License-Identifier: Apache-2.0

set -ex

ENODEB=1 /opt/oai/bin/lte-softmodem -O /opt/oai/share/cu.conf

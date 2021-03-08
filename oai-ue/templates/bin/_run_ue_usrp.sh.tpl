#!/bin/bash
# SPDX-FileCopyrightText: 2020-present Open Networking Foundation <info@opennetworking.org>
#
# SPDX-License-Identifier: LicenseRef-ONF-Member-1.0

set -ex

uhd_images_downloader
uhd_usrp_probe

pushd /opt/oai-ue/share
/opt/oai-ue/bin/lte-uesoftmodem -O /opt/oai-ue/share/ue.conf -C 2630000000 -r 25 --ue-rxgain 120 --ue-txgain 0 --ue-max-power 0 --ue-scan-carrier --nokrnmod 1 2>&1 | tee UE.log
popd

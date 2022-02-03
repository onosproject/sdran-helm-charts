#!/bin/bash
# SPDX-FileCopyrightText: 2020-present Open Networking Foundation <info@opennetworking.org>
#
# SPDX-License-Identifier: Apache-2.0

{{- $carrier := index .Values "config" "oai-ue" "radio" "carrier" | int }}
{{- $rbs := index .Values "config" "oai-ue" "radio" "rbs" }}
{{- $uerxgain := index .Values "config" "oai-ue" "radio" "ue-rxgain" }}
{{- $uetxgain := index .Values "config" "oai-ue" "radio" "ue-txgain" }}
{{- $uemaxpower := index .Values "config" "oai-ue" "radio" "ue-max-power" }}

set -ex

uhd_images_downloader
uhd_usrp_probe

pushd /opt/oai-ue/share
/opt/oai-ue/bin/lte-uesoftmodem -O /opt/oai-ue/share/ue.conf -C {{ $carrier }} -r {{ $rbs }} --ue-rxgain {{ $uerxgain }} --ue-txgain {{ $uetxgain }} --ue-max-power {{ $uemaxpower }} --ue-scan-carrier --nokrnmod 1 2>&1 | tee UE.log
popd

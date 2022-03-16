#!/bin/bash
# SPDX-FileCopyrightText: 2020-present Open Networking Foundation <info@opennetworking.org>
#
# SPDX-License-Identifier: Apache-2.0

set -ex

cp /opt/oai/conf_files/du.conf /opt/oai/share/du.conf

{{- if (index .Values "config" "onos-e2t" "networks" "e2" "host") }}
apt install -y dnsutils
RIC_IP=$(nslookup {{ index .Values "config" "onos-e2t" "networks" "e2" "host" }} | grep Address | tail -1 | awk '{print $2}')
if [ -z ${RIC_IP} ]; then
RIC_IP={{ (split "/" (index .Values "config" "onos-e2t" "networks" "e2" "address"))._0 | quote }}
fi
{{ else }}
RIC_IP={{ (split "/" (index .Values "config" "onos-e2t" "networks" "e2" "address"))._0 | quote }}
{{- end }}
sed -i "s/<RIC_IP>/$RIC_IP/" /opt/oai/share/du.conf
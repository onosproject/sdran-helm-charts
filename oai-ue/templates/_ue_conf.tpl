# SPDX-FileCopyrightText: 2020-present Open Networking Foundation <info@opennetworking.org>
#
# SPDX-License-Identifier: Apache-2.0

{{- $maxpdschReferenceSignalPower := index .Values "config" "oai-ue" "radio" "max_pdschReferenceSignalPower" }}
{{- $maxrxgain := index .Values "config" "oai-ue" "radio" "max_rxgain" }}


log_config = {
global_log_level                      ={{ index .Values "config" "oai-ue" "log" "level" | quote }};
global_log_verbosity                  ={{ index .Values "config" "oai-ue" "log" "verbosity" | quote }};
hw_log_level                          ={{ index .Values "config" "oai-ue" "log" "level" | quote }};
hw_log_verbosity                      ={{ index .Values "config" "oai-ue" "log" "verbosity" | quote }};
phy_log_level                         ={{ index .Values "config" "oai-ue" "log" "level" | quote }};
phy_log_verbosity                     ={{ index .Values "config" "oai-ue" "log" "verbosity" | quote }};
mac_log_level                         ={{ index .Values "config" "oai-ue" "log" "level" | quote }};
mac_log_verbosity                     ={{ index .Values "config" "oai-ue" "log" "verbosity" | quote }};
rlc_log_level                         ={{ index .Values "config" "oai-ue" "log" "level" | quote }};
rlc_log_verbosity                     ={{ index .Values "config" "oai-ue" "log" "verbosity" | quote }};
pdcp_log_level                        ={{ index .Values "config" "oai-ue" "log" "level" | quote }};
pdcp_log_verbosity                    ={{ index .Values "config" "oai-ue" "log" "verbosity" | quote }};
rrc_log_level                         ={{ index .Values "config" "oai-ue" "log" "level" | quote }};
rrc_log_verbosity                     ={{ index .Values "config" "oai-ue" "log" "verbosity" | quote }};
};

L1s = (
{
num_cc = 1;
tr_n_preference = "nfapi";
local_n_if_name  = {{ index .Values "config" "oai-ue" "networks" "nfapi" "interface" | quote }};
remote_n_address = {{ index .Values "config" "oai-enb-du" "networks" "nfapi" "address" | quote }};
local_n_address  = {{ index .Values "config" "oai-ue" "networks" "nfapi" "address" | quote }};
local_n_portc    = {{ index .Values "config" "oai-ue" "networks" "nfapi" "portc" }};
remote_n_portc   = {{ index .Values "config" "oai-enb-du" "networks" "nfapi" "portc" }};
local_n_portd    = {{ index .Values "config" "oai-ue" "networks" "nfapi" "portd" }};
remote_n_portd   = {{ index .Values "config" "oai-enb-du" "networks" "nfapi" "portd" }};
}
);

RUs = (
{
local_rf       = "yes"
nb_tx          = 1
nb_rx          = 1
att_tx         = 90
att_rx         = 0;
bands          = [7,38,42,43];
max_pdschReferenceSignalPower = {{ $maxpdschReferenceSignalPower }};
max_rxgain                    = {{ $maxrxgain }};
}
);
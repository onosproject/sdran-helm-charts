# SPDX-FileCopyrightText: 2020-present Open Networking Foundation <info@opennetworking.org>
#
# SPDX-License-Identifier: LicenseRef-ONF-Member-1.0

log_config = {
global_log_level                      ="info";
global_log_verbosity                  ="full";
hw_log_level                          ="info";
hw_log_verbosity                      ="full";
phy_log_level                         ="info";
phy_log_verbosity                     ="full";
mac_log_level                         ="info";
mac_log_verbosity                     ="full";
rlc_log_level                         ="info";
rlc_log_verbosity                     ="full";
pdcp_log_level                        ="info";
pdcp_log_verbosity                    ="full";
rrc_log_level                         ="info";
rrc_log_verbosity                     ="full";
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
max_pdschReferenceSignalPower = -27;
max_rxgain                    = 125;
}
);
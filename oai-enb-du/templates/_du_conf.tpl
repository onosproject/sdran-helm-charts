# SPDX-FileCopyrightText: 2020-present Open Networking Foundation <info@opennetworking.org>
#
# SPDX-License-Identifier: Apache-2.0

{{ $duMode := index .Values "config" "oai-enb-du" "mode" }}

Active_eNBs = ( "eNB-Eurecom-DU");
# Asn1_verbosity, choice in: none, info, annoying
  Asn1_verbosity = "none";

  eNBs =
  (
  {
    ////////// Identification parameters:
      eNB_ID = {{ index .Values "config" "oai-enb-cu" "enbID" }};

      RIC : {
            remote_ipv4_addr = {{ (split "/" (index .Values "config" "onos-e2t" "networks" "e2" "address"))._0 | quote }};
            remote_port = {{ index .Values "config" "onos-e2t" "networks" "e2" "port" }};
            enabled = "yes";
      };

      eNB_name  = "eNB-Eurecom-DU";
      // Tracking area code, 0x0000 and 0xfffe are reserved values
    tracking_area_code = {{ index .Values "config" "oai-enb-cu" "tac" }};
    plmn_list = ( { mcc = {{ index .Values "config" "oai-enb-cu" "plmnID" "mcc" }}; mnc = {{ index .Values "config" "oai-enb-cu" "plmnID" "mnc" }}; mnc_length = {{ index .Values "config" "oai-enb-cu" "plmnID" "length" }}; } )

    tr_s_preference     = "local_mac"

    nr_cellid = 12345678L

    ////////// Physical parameters:

        component_carriers = (
      {
        node_function           = "3GPP_eNODEB";
        node_timing             = "synch_to_ext_device";
        node_synch_ref          = 0;
        frame_type              = "FDD";
        tdd_config              = 3;
        tdd_config_s            = 0;
        prefix_type             = "NORMAL";
        eutra_band              = 7;
        downlink_frequency      = 2680000000L;
        uplink_frequency_offset = -120000000;
        Nid_cell                = 0;
        N_RB_DL                 = 25;
        Nid_cell_mbsfn          = 0;
        nb_antenna_ports        = 1;
        nb_antennas_tx          = 1;
        nb_antennas_rx          = 1;
        tx_gain                 = 90;
        rx_gain                 = 125;

        pucch_deltaF_Format1    = "deltaF2";
        pucch_deltaF_Format1b   = "deltaF3";
        pucch_deltaF_Format2    = "deltaF0";
        pucch_deltaF_Format2a   = "deltaF0";
        pucch_deltaF_Format2b   = "deltaF0";
      }
          );


      # ------- SCTP definitions
          SCTP :
      {
        # Number of streams to use in input/output
        SCTP_INSTREAMS  = 2;
        SCTP_OUTSTREAMS = 2;
      };
  }
  );

  MACRLCs = (
  {
  num_cc           = 1;
  tr_s_preference  = {{ index .Values "config" "oai-enb-du" "mode" | quote }};
  local_s_if_name  = {{ index .Values "config" "oai-enb-du" "networks" "nfapi" "interface" | quote }};
  remote_s_address = {{ index .Values "config" "oai-ue" "networks" "nfapi" "address" | quote }};
  local_s_address  = {{ index .Values "config" "oai-enb-du" "networks" "nfapi" "address" | quote }};
  local_s_portc    = {{ index .Values "config" "oai-enb-du" "networks" "nfapi" "portc"}};
  remote_s_portc   = {{ index .Values "config" "oai-ue" "networks" "nfapi" "portc"}};
  local_s_portd    = {{ index .Values "config" "oai-enb-du" "networks" "nfapi" "portd"}};
  remote_s_portd   = {{ index .Values "config" "oai-ue" "networks" "nfapi" "portd"}};
  tr_n_preference  = "f1";
  local_n_if_name  = {{ index .Values "config" "oai-enb-du" "networks" "f1" "interface" | quote }};
  remote_n_address = {{ (split "/" (index .Values "config" "oai-enb-cu" "networks" "f1" "address"))._0 | quote }};
  local_n_address  = {{ (split "/" (index .Values "config" "oai-enb-du" "networks" "f1" "address"))._0 | quote }};
  local_n_portc    = {{ index .Values "config" "oai-enb-du" "networks" "f1" "portc" }};
  remote_n_portc   = {{ index .Values "config" "oai-enb-cu" "networks" "f1" "portc" }};
  local_n_portd    = {{ index .Values "config" "oai-enb-du" "networks" "f1" "portd" }};
  remote_n_portd   = {{ index .Values "config" "oai-enb-cu" "networks" "f1" "portd" }};
  }
  );

  log_config = {
  global_log_level            ={{ index .Values "config" "oai-enb-du" "log" "level" | quote }};
  global_log_verbosity        ={{ index .Values "config" "oai-enb-du" "log" "verbosity" | quote }};
  hw_log_level                ={{ index .Values "config" "oai-enb-du" "log" "level" | quote }};
  hw_log_verbosity            ={{ index .Values "config" "oai-enb-du" "log" "verbosity" | quote }};
  phy_log_level               ={{ index .Values "config" "oai-enb-du" "log" "level" | quote }};
  phy_log_verbosity           ={{ index .Values "config" "oai-enb-du" "log" "verbosity" | quote }};
  mac_log_level               ={{ index .Values "config" "oai-enb-du" "log" "level" | quote }};
  mac_log_verbosity           ={{ index .Values "config" "oai-enb-du" "log" "verbosity" | quote }};
  rlc_log_level               ={{ index .Values "config" "oai-enb-du" "log" "level" | quote }};
  rlc_log_verbosity           ={{ index .Values "config" "oai-enb-du" "log" "verbosity" | quote }};
  flexran_agent_log_level     ={{ index .Values "config" "oai-enb-du" "log" "level" | quote }};
  flexran_agent_log_verbosity ={{ index .Values "config" "oai-enb-du" "log" "verbosity" | quote }};
};

NETWORK_CONTROLLER : {
                        FLEXRAN_ENABLED        = "no";
                        FLEXRAN_INTERFACE_NAME = "lo";
                        FLEXRAN_IPV4_ADDRESS   = "127.0.0.1";
                        FLEXRAN_PORT           = 2210;
                        FLEXRAN_CACHE          = "/mnt/oai_agent_cache";
                        FLEXRAN_AWAIT_RECONF   = "no";
};

THREAD_STRUCT = (
{
#three config for level of parallelism "PARALLEL_SINGLE_THREAD", "PARALLEL_RU_L1_SPLIT", or "PARALLEL_RU_L1_TRX_SPLIT"

{{- if eq $duMode "nfapi" }}
parallel_config    = "PARALLEL_RU_L1_TRX_SPLIT";
{{- else if eq $duMode "local_L1" }}
parallel_config    = "PARALLEL_SINGLE_THREAD";
{{- else }}
parallel_config    = "PARALLEL_SINGLE_THREAD";
{{- end }}

#        #two option for worker "WORKER_DISABLE" or "WORKER_ENABLE"
worker_config      = "WORKER_ENABLE";
}
);



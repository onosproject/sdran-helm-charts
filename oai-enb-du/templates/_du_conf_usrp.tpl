# SPDX-FileCopyrightText: 2020-present Open Networking Foundation <info@opennetworking.org>
#
# SPDX-License-Identifier: LicenseRef-ONF-Member-1.0

Active_eNBs = ( "eNB-Eurecom-DU");
# Asn1_verbosity, choice in: none, info, annoying
Asn1_verbosity = "none";

eNBs =
(
  {
    ////////// Identification parameters:
    eNB_CU_ID = {{ index .Values "config" "oai-enb-cu" "enbID" }};

    eNB_name  = "eNB-Eurecom-DU";

    // Tracking area code, 0x0000 and 0xfffe are reserved values
    tracking_area_code = {{ index .Values "config" "oai-enb-cu" "tac" }};
    plmn_list = ( { mcc = {{ index .Values "config" "oai-enb-cu" "plmnID" "mcc" }}; mnc = {{ index .Values "config" "oai-enb-cu" "plmnID" "mnc" }}; mnc_length = {{ index .Values "config" "oai-enb-cu" "plmnID" "length" }}; } )

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
        downlink_frequency      = 2630000000L;
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
    tr_s_preference  = "local_L1";
    tr_n_preference  = "f1";
    local_n_if_name  = {{ index .Values "config" "oai-enb-du" "networks" "f1" "interface" | quote }};
    remote_n_address = {{ index .Values "config" "oai-enb-cu" "networks" "f1" "address" | quote }};
    local_n_address  = {{ index .Values "config" "oai-enb-du" "networks" "f1" "address" | quote }};
    local_n_portc    = 500;
    remote_n_portc   = 501;
    local_n_portd    = 600;
    remote_n_portd   = 601;
  }
);

L1s = (
  {
    num_cc = 1;
    tr_n_preference = "local_mac";
  }
);

RUs = (
  {
    local_rf                      = "yes";
    nb_tx                         = 1;
    nb_rx                         = 1;
    att_tx                        = 10;
    att_rx                        = 10;
    bands                         = [7];
    max_pdschReferenceSignalPower = -25;
    max_rxgain                    = 125;
    eNB_instances                 = [0];
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
    parallel_config    = "PARALLEL_SINGLE_THREAD";
    #        #two option for worker "WORKER_DISABLE" or "WORKER_ENABLE"
    worker_config      = "WORKER_ENABLE";
  }
);

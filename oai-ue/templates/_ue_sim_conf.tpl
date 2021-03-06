# SPDX-FileCopyrightText: 2020-present Open Networking Foundation <info@opennetworking.org>
#
# SPDX-License-Identifier: LicenseRef-ONF-Member-1.0

{{- $mcc := index .Values "config" "oai-enb-cu" "plmnID" "mcc" }}
{{- $mnc := index .Values "config" "oai-enb-cu" "plmnID" "mnc" }}
{{- $plmnid := tuple $mcc $mnc | include "oai-ue.plmnid" | quote }}

PLMN: {
    PLMN0: {
            FULLNAME={{ index .Values "config" "oai-enb-cu" "plmnID" "fullName" | quote }};
            SHORTNAME={{ index .Values "config" "oai-enb-cu" "plmnID" "shortName" | quote }};
            MCC={{ index .Values "config" "oai-enb-cu" "plmnID" "mcc" | quote }};
            MNC={{ index .Values "config" "oai-enb-cu" "plmnID" "mnc" | quote }};
    };
};
UE0: {
    USER: {
        IMEI={{ index .Values "config" "oai-ue" "device" "imei" | quote }};
        MANUFACTURER={{ index .Values "config" "oai-ue" "device" "manufacturer" | quote }};
        MODEL={{ index .Values "config" "oai-ue" "device" "model" | quote }};
        PIN={{ index .Values "config" "oai-ue" "device" "pin" | quote }};
    };
    SIM: {
        MSIN={{ index .Values "config" "oai-ue" "sim" "msin" | quote }};
        USIM_API_K={{ index .Values "config" "oai-ue" "sim" "apiKey" | quote }};
        OPC={{ index .Values "config" "oai-ue" "sim" "opc" | quote }};
        MSISDN={{ index .Values "config" "oai-ue" "sim" "msisdn" | quote }};
    };
    HPLMN= {{ $plmnid }};
    UCPLMN_LIST = ();
    OPLMN_LIST = ({{ $plmnid }});
    OCPLMN_LIST = ();
    FPLMN_LIST = ();
    EHPLMN_LIST= ();
};

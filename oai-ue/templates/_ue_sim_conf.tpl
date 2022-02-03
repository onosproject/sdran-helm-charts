# SPDX-FileCopyrightText: 2020-present Open Networking Foundation <info@opennetworking.org>
#
# SPDX-License-Identifier: Apache-2.0

{{- $mcc := index .Values "config" "oai-enb-cu" "plmnID" "mcc" -}}
{{- $mnc := index .Values "config" "oai-enb-cu" "plmnID" "mnc" -}}
{{- $plmnid := tuple $mcc $mnc | include "oai-ue.plmnid" | quote -}}
{{- $numUEs := index .Values "config" "oai-ue" "numDevices" | int -}}
{{- $startIMEI := index .Values "config" "oai-ue" "device" "imei" }}
{{- $startMSIN := index .Values "config" "oai-ue" "sim" "msinStart" }}
{{- $startMSISDN := index .Values "config" "oai-ue" "sim" "msisdnStart" }}
{{- $startMSINlen := index .Values "config" "oai-ue" "sim" "msinStart" | toString | len | int }}
{{- $MSINlensub := sub 10 $startMSINlen | int }}

PLMN: {
    PLMN0: {
            FULLNAME={{ index .Values "config" "oai-enb-cu" "plmnID" "fullName" | quote }};
            SHORTNAME={{ index .Values "config" "oai-enb-cu" "plmnID" "shortName" | quote }};
            MCC={{ index .Values "config" "oai-enb-cu" "plmnID" "mcc" | quote }};
            MNC={{ index .Values "config" "oai-enb-cu" "plmnID" "mnc" | quote }};
    };
};
{{- range $i, $e := until $numUEs }}
UE{{ $i }}: {
    USER: {
        IMEI={{ add $startIMEI $i | quote }};
        MANUFACTURER={{ index $.Values "config" "oai-ue" "device" "manufacturer" | quote }};
        MODEL={{ index $.Values "config" "oai-ue" "device" "model" | quote }};
        PIN={{ index $.Values "config" "oai-ue" "device" "pin" | quote }};
    };
    SIM: {
        MSIN={{ add $startMSIN $i | printf "%010d" | substr $MSINlensub 10 | quote }};
        USIM_API_K={{ index $.Values "config" "oai-ue" "sim" "apiKey" | quote }};
        OPC={{ index $.Values "config" "oai-ue" "sim" "opc" | quote }};
        MSISDN={{ add $startMSISDN $i | quote }};
    };
    HPLMN= {{ $plmnid }};
    UCPLMN_LIST = ();
    OPLMN_LIST = ({{ $plmnid }});
    OCPLMN_LIST = ();
    FPLMN_LIST = ();
    EHPLMN_LIST= ();
};
{{- end }}

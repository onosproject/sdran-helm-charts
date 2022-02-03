{{- /*

# Copyright 2020-present Open Networking Foundation
#
# SPDX-License-Identifier: Apache-2.0

*/ -}}

{{/*
Renders a set of standardised labels.
*/}}
{{- define "oai-ue.metadata_labels" -}}
{{- $application := index . 0 -}}
{{- $context := index . 1 -}}
release: {{ $context.Release.Name }}
app: {{ $application }}
{{- end -}}

{{/*
Render the given template.
*/}}
{{- define "oai-ue.template" -}}
{{- $name := index . 0 -}}
{{- $context := index . 1 -}}
{{- $last := base $context.Template.Name }}
{{- $wtf := $context.Template.Name | replace $last $name -}}
{{ include $wtf $context }}
{{- end -}}

{{/*
Return PLMN from MCC and MNC.
*/}}
{{- define "oai-ue.plmnid" -}}
{{- $mcc := index . 0 -}}
{{- $mnc := index . 1 -}}
{{- printf "%s%s" $mcc $mnc -}}
{{- end -}}
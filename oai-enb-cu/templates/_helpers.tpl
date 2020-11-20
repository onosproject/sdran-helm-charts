{{- /*

# Copyright 2020-present Open Networking Foundation
#
# SPDX-License-Identifier: LicenseRef-ONF-Member-Only-1.0

*/ -}}

{{/*
Renders a set of standardised labels.
*/}}
{{- define "oai-enb-cu.metadata_labels" -}}
{{- $application := index . 0 -}}
{{- $context := index . 1 -}}
release: {{ $context.Release.Name }}
app: {{ $application }}
{{- end -}}

{{/*
Render the given template.
*/}}
{{- define "oai-enb-cu.template" -}}
{{- $name := index . 0 -}}
{{- $context := index . 1 -}}
{{- $last := base $context.Template.Name }}
{{- $wtf := $context.Template.Name | replace $last $name -}}
{{ include $wtf $context }}
{{- end -}}

{{/*
Render image name
*/}}
{{- define "oai-enb-cu.imagename" -}}
{{- if .Values.global.image.registry -}}
{{- printf "%s/" .Values.global.image.registry -}}
{{- else if .Values.image.registry -}}
{{- printf "%s/" .Values.image.registry -}}
{{- end -}}
{{- printf "%s:" .Values.image.repository -}}
{{- if .Values.global.image.tag -}}
{{- .Values.global.image.tag -}}
{{- else -}}
{{- .Values.image.tag -}}
{{- end -}}
{{- end -}}
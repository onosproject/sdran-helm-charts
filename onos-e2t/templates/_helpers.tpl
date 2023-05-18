# SPDX-FileCopyrightText: 2022 2020-present Open Networking Foundation <info@opennetworking.org>
#
# SPDX-License-Identifier: Apache-2.0

{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "onos-e2t.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "onos-e2t.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "onos-e2t.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "onos-e2t.labels" -}}
helm.sh/chart: {{ include "onos-e2t.chart" . }}
{{ include "onos-e2t.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "onos-e2t.selectorLabels" -}}
app.kubernetes.io/name: {{ include "onos-e2t.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{/*
onos-e2t image name
*/}}
{{- define "onos-e2t.imagename" -}}
{{- if .Values.global.image.registry -}}
{{- printf "%s/" .Values.global.image.registry -}}
{{- else if .Values.image.registry -}}
{{- printf "%s/" .Values.image.registry -}}
{{- end -}}
{{- printf "%s:" .Values.image.repository -}}
{{- if .Values.global.image.tag -}}
{{- .Values.global.image.tag -}}
{{- else -}}
{{- tpl .Values.image.tag . -}}
{{- end -}}
{{- end -}}

{{/*
registry name
*/}}
{{- define "onos-e2t.registryname" -}}
{{- if .Values.global.image.registry -}}
{{- printf "%s/" .Values.global.image.registry -}}
{{- else if .Values.image.registry -}}
{{- printf "%s/" .Values.image.registry -}}
{{- end -}}
{{- end -}}

{{/*
onos-e2t consensus image name
*/}}
{{- define "onos-e2t.atomix.store.consensus.imagename" -}}
{{- if or .Values.atomix.store.consensus.image.tag .Values.global.atomix.store.consensus.image.tag -}}
{{- if .Values.global.atomix.store.consensus.image.registry -}}
{{- printf "%s/" .Values.global.atomix.store.consensus.image.registry -}}
{{- else if .Values.atomix.store.consensus.image.registry -}}
{{- printf "%s/" .Values.atomix.store.consensus.image.registry -}}
{{- end -}}
{{- printf "%s:" .Values.atomix.store.consensus.image.repository -}}
{{- if .Values.global.atomix.store.consensus.image.tag -}}
{{- .Values.global.atomix.store.consensus.image.tag -}}
{{- else -}}
{{- .Values.atomix.store.consensus.image.tag -}}
{{- end -}}
{{- else -}}
""
{{- end -}}
{{- end -}}

{{- define "onos-e2t.atomix.consensus.cluster.name" -}}
{{- if .Values.global.atomix.store.consensus.enabled -}}
{{- include "global.atomix.consensus.cluster.name" . -}}
{{- else -}}
{{- printf "%s-consensus" .Release.Name -}}
{{- end -}}
{{- end -}}

{{- define "onos-e2t.atomix.consensus.store.name" -}}
{{- printf "%s-consensus" ( include "onos-e2t.fullname" . ) -}}
{{- end -}}

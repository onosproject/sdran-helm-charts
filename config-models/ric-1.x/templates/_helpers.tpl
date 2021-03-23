{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "ricmodel.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "ricmodel.fullname" -}}
{{- if contains "config-model-ricmodel" .Release.Name -}}
{{- printf "%s-%s" .Release.Name .Chart.AppVersion | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s-config-model-ricmodel" .Release.Name .Chart.AppVersion | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "ricmodel.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}


{{/*
Common labels
*/}}
{{- define "ricmodel.labels" -}}
helm.sh/chart: {{ include "ricmodel.chart" . }}
{{ include "ricmodel.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "ricmodel.selectorLabels" -}}
app.kubernetes.io/name: {{ include "ricmodel.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}
}
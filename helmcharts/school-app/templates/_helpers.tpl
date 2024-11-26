{{/*
Expand the name of the chart.
*/}}
{{- define "school-app.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "school-app.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "school-app.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "school-app.labels" -}}
helm.sh/chart: {{ include "school-app.chart" . }}
{{ include "school-app.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "school-app.selectorLabels" -}}
app.kubernetes.io/name: {{ include "school-app.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "school-app.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "school-app.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{- define "school-app.mongo.name" -}}
{{- if .Values.mongo.nameOverride -}}
{{- .Values.mongo.nameOverride -}}
{{- else -}}
{{- printf "%s-mongo" (include "school-app.name" .) -}}
{{- end -}}
{{- end -}}

{{- define "school-app.mongo.fullname" -}}
{{- if .Values.mongo.fullnameOverride -}}
{{- .Values.mongo.fullnameOverride -}}
{{- else -}}
{{- printf "%s-mongo" (include "school-app.fullname" .) -}}
{{- end -}}
{{- end -}}


{{- define "school-app.back-school.name" -}}
{{- if .Values.backSchool.nameOverride -}}
{{- .Values.backSchool.nameOverride -}}
{{- else -}}
{{- printf "%s-back-school" (include "school-app.name" .) -}}
{{- end -}}
{{- end -}}

{{- define "school-app.back-school.fullname" -}}
{{- if .Values.backSchool.fullnameOverride -}}
{{- .Values.backSchool.fullnameOverride -}}
{{- else -}}
{{- printf "%s-back-school" (include "school-app.fullname" .) -}}
{{- end -}}
{{- end -}}


{{- define "school-app.commitTag" -}}
{{- if eq .Values.env "prod" -}}
{{ .Values.prodCommitTag }}
{{- else -}}
{{ .Values.preprodCommitTag }}
{{- end -}}
{{- end -}}
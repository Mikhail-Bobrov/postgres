
{{- define "postgres-labels" }}
app: postgres-{{- .Values.name }}
component: postgres
cluster-name: patroni-{{- .Values.name }}
{{- if .Values.labels }}
{{- range $key, $val := .Values.labels }}
{{ $key }}: {{ $val }}
{{- end }}
{{- end }}
version: {{ .Values.version | quote }}
{{- end -}}
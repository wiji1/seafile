{{/* Seafile image */}}
{{- define "seafile.image" -}}
    {{- if .Values.seafile.image -}}
        {{- printf "%s" .Values.seafile.image }}
    {{- else -}}
        {{- printf "seafileltd/seafile-mc:%s-latest" .Chart.AppVersion }}
    {{- end }}
{{- end }}

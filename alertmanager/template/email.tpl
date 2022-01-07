{{ define "email.html" }}
<table border="1">
        <tr>
                <td>AlarmName</td>
                <td>Instance</td>
                <td>Threshold</td>
                <td>StartTime</td>
        </tr>
        {{ range $i, $alert := .Alerts }}
                <tr>
                        <td>{{ index $alert.Labels "alertname" }}</td>
                        <td>{{ index $alert.Labels "instance" }}</td>
                        <td>{{ index $alert.Annotations "value" }}</td>
                        <td>{{ $alert.StartsAt }}</td>
                </tr>
        {{ end }}
</table>
{{ end }}

global:
  scrape_interval: 15s

prometheus:
  prometheusSpec:
    additionalScrapeConfigs:
      - job_name: 'prometheus'
        static_configs:
          - targets: ['localhost:9090']
      - job_name: 'postgres_exporter'
        static_configs:
          - targets: ['34.123.90.90:9187']  # Публичный IP PostgreSQL и порт PostgreSQL Exporter

additionalPrometheusRulesMap:
  custom-alerts:
    groups:
      - name: CustomTestAlerts
        rules:
          - alert: TestAlertWarning
            expr: up == 0
            for: 1m
            labels:
              severity: warning
            annotations:
              summary: "Test Alert: Service Down (instance {{ $labels.instance }})"
              description: "Service is down (up == 0)\nVALUE = {{ $value }}\nLABELS = {{ $labels }}"
          - alert: DiskSpaceWarning
            expr: (node_filesystem_avail_bytes{fstype=~"ext4|xfs"} / node_filesystem_size_bytes{fstype=~"ext4|xfs"}) * 100 < 20
            for: 2m
            labels:
              severity: warning
            annotations:
              summary: "Disk Space Warning (instance {{ $labels.instance }})"
              description: "Disk space is running low (< 20%)\nVALUE = {{ $value }}\nLABELS = {{ $labels }}"
          - alert: NodeCpuUsageHigh
            expr: rate(node_cpu_seconds_total[1m]) > 0.9
            for: 1m
            labels:
              severity: critical
            annotations:
              summary: "High CPU Usage on Node {{ $labels.instance }}"
              description: "Node {{ $labels.instance }} is experiencing high CPU usage: {{ $value }}%"

alertmanager:
  config:
    global:
      slack_api_url: "https://hooks.slack.com/services/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"
    route:
      receiver: default
      group_wait: 30s
      group_interval: 5m
      repeat_interval: 3h
      routes:
        - matchers:
            - severity=critical
          receiver: slack-general
        - matchers:
            - severity=warning
          receiver: slack-general

    receivers:
      - name: slack-general
        slack_configs:
          - channel: 'slack-channel'
            text: "{{ range .Alerts }}{{ .Annotations.summary }}\n{{ .Annotations.description }}\n\n{{ end }}"

prometheus-postgres-exporter:
  config:
    datasource:
      host: 34.123.90.90  # Публичный IP твоей базы данных PostgreSQL
      user: postgres       # Имя пользователя базы данных
      password: postgres   # Пароль для пользователя базы данных
      database: postgres   # Имя базы данных
      port: 5432           # Порт PostgreSQL
  service:
    annotations:
      prometheus.io/scrape: "true"
      prometheus.io/port: "9187"  # Порт экспорта метрик PostgreSQL Exporter

stackdriver:
  enabled: true
  project_id: inner-nuance-332319  # ID проекта GCP
  log_name: prometheus
  monitoring:
    enabled: true
    metrics:
      - name: cpu_usage
      - name: memory_usage

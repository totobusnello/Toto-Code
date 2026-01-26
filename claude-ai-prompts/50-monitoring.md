# Monitoring & Observability

Voce e um especialista em observabilidade. Configure monitoring, logging e alerting.

## Tres Pilares

### Metrics
- Application metrics (latency, throughput)
- Infrastructure metrics (CPU, memory)
- Business metrics (conversions, revenue)

### Logs
- Structured logging (JSON)
- Log levels apropriados
- Correlation IDs
- Centralized logging

### Traces
- Distributed tracing
- Span context propagation
- Service maps
- Latency analysis

## Stack Recomendada

```
Metrics: Prometheus + Grafana
Logs: ELK Stack ou Loki
Traces: Jaeger ou Zipkin
Alerts: AlertManager ou PagerDuty
```

## Exemplo Prometheus

```yaml
# prometheus.yml
global:
  scrape_interval: 15s

alerting:
  alertmanagers:
    - static_configs:
        - targets: ['alertmanager:9093']

rule_files:
  - 'alerts/*.yml'

scrape_configs:
  - job_name: 'app'
    static_configs:
      - targets: ['app:8080']
    metrics_path: '/metrics'
```

```yaml
# alerts/app.yml
groups:
  - name: app
    rules:
      - alert: HighErrorRate
        expr: rate(http_requests_total{status=~"5.."}[5m]) > 0.1
        for: 5m
        labels:
          severity: critical
        annotations:
          summary: High error rate detected

      - alert: HighLatency
        expr: histogram_quantile(0.95, rate(http_request_duration_seconds_bucket[5m])) > 1
        for: 5m
        labels:
          severity: warning
```

Configure monitoring para a aplicacao.

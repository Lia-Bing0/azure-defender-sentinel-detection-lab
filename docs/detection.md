# Detection Engineering

This lab implements a Sentinel scheduled analytics rule to detect likely brute-force behavior on a Windows VM using repeated failed logons (Event ID 4625).

## KQL Queries

### 1 Validate ingestion

```kql
SecurityEvent
| take 10
```

### 2 Confirm failed logons (Event ID 4625)

```kql
SecurityEvent
| where EventID == 4625
| project TimeGenerated, Computer, TargetUserName, IpAddress, Activity
| order by TimeGenerated desc
```

### 3 Scheduled analytics rule query (`>= 3` failures per `5m`)

```kql
SecurityEvent
| where EventID == 4625
| where TimeGenerated >= ago(5m)
| summarize FailedLogons = count(), StartTime=min(TimeGenerated), EndTime=max(TimeGenerated)
    by Account = tostring(TargetUserName), Host = tostring(Computer)
| where FailedLogons >= 3
```

## Rule Configuration

- Rule type: Scheduled analytics rule
- Query frequency: 5 minutes
- Query period: 5 minutes
- Threshold logic: alert when `FailedLogons >= 3`
- Severity: High

## Entity Mapping and Alert Grouping

- Entity mapping:
  - Account entity → `Account` (derived from `TargetUserName`)
  - Host entity → `Host` (derived from `Computer`)

- Grouping strategy:
  - Alerts are grouped into a single incident when `Account` and `Host` match within the 1-hour grouping window.
  - This reduces duplicate incidents during rapid failed-logon bursts while preserving investigation context and attribution.

## MITRE ATT&CK Mapping Rationale

- Tactic: Credential Access
- Technique: `T1110 Brute Force`
- Rationale: repeated authentication failures against an account on a host are consistent with brute-force password-guessing behavior. Mapping to `T1110` improves triage context and supports ATT&CK-aligned reporting.

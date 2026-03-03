# Operations Runbook – Detection Validation and Response Workflow

## Detection Lifecycle Workflow

1. Provision infrastructure using Terraform (resource group, network controls, Windows VM, Log Analytics workspace).
2. Enable Microsoft Sentinel on the workspace.
3. Deploy Azure Monitor Agent (AMA) and associate a Data Collection Rule (DCR) for Windows Security Events.
4. Validate ingestion into the `SecurityEvent` table.
5. Configure and enable a scheduled analytics rule detecting repeated Event ID 4625 activity.
6. Generate controlled failed logon attempts to simulate brute-force behavior.
7. Confirm alert generation and incident creation in Microsoft Sentinel.

## Troubleshooting Notes

### Telemetry Ingestion Delays

- Short propagation delays are expected after AMA installation or DCR updates.
- Confirm DCR association scope and target VM assignment if logs do not appear.

### Missing Failed Logon Events

- Verify Windows audit policy includes logon failure auditing.
- Confirm Event ID 4625 exists locally in the VM Security log before querying Sentinel.

### Detection Rule Not Triggering

- Validate rule query frequency and lookback window alignment.
- Confirm threshold conditions (`>= 3` within `5m`) are satisfied in manual query results.
- Ensure rule is enabled and not suppressed by grouping or suppression configuration.

## Teardown

1. Export or capture final evidence screenshots and query outputs.
2. From the Terraform directory, execute:

```bash
terraform destroy
```

3. Confirm removal of VM, Public IP, NSG, workspace bindings, and related resources.
4. Revoke temporary test access paths and remove non-production policy exceptions.

## Operational Outcome

This runbook validates an end-to-end detection pipeline from identity enforcement and endpoint telemetry collection to Sentinel analytics evaluation and incident generation.  

The workflow demonstrates repeatable detection validation, alert fidelity testing, and safe teardown procedures within an isolated Azure environment.

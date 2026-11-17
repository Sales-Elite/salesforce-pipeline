# Security scan: TKT-403

Change: MCP night W3-1: Hot lead follow-up flow

- Scanner: Salesforce Code Analyzer 5.16.0
- Rules: Recommended, Security, AppExchange with the `bank-v1` severity profile (code-analyzer.yml)
- Graph Engine: off
- Policy: block at High or worse, enforced
- Scanned: 2026-11-17T18:40:15.124Z · 4 files · 5 s
- Result: **passed** · Critical 0 · High 0 · Moderate 2 · Low 0 · Info 0

| # | Severity | Engine | Rule | File | Line | Message |
|---|---|---|---|---|---|---|
| 1 | Moderate | flow | SameRecordUpdate | `force-app/main/default/flows/MCPN_Hot_Lead_Follow_Up.flow-meta.xml` | 128 | An AfterSave record trigger is modifying the same record. Record modifications should be done in BeforeSave triggers, not AfterSave triggers. The trigger definition may be in a parent flow that calls the current flow as a subflow, passing in the recordId of the trigger record. |
| 2 | Moderate | flow | SameRecordUpdate | `force-app/main/default/flows/MCPN_Hot_Lead_Follow_Up.flow-meta.xml` | 152 | An AfterSave record trigger is modifying the same record. Record modifications should be done in BeforeSave triggers, not AfterSave triggers. The trigger definition may be in a parent flow that calls the current flow as a subflow, passing in the recordId of the trigger record. |

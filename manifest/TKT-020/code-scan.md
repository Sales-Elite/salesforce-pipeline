# Security scan: TKT-020

Change: Escalate high-priority Cases (Flow)

- Scanner: Salesforce Code Analyzer 5.16.0
- Rules: Recommended, Security, AppExchange with the `bank-v1` severity profile (code-analyzer.yml)
- Graph Engine: off
- Policy: block at High or worse, enforced
- Scanned: 2026-11-07T11:02:37.253Z · 3 files · 5 s
- Result: **passed** · Critical 0 · High 0 · Moderate 1 · Low 0 · Info 0

| # | Severity | Engine | Rule | File | Line | Message |
|---|---|---|---|---|---|---|
| 1 | Moderate | flow | SameRecordUpdate | `force-app/main/default/flows/Case_Escalate_High_Priority.flow-meta.xml` | 125 | An AfterSave record trigger is modifying the same record. Record modifications should be done in BeforeSave triggers, not AfterSave triggers. The trigger definition may be in a parent flow that calls the current flow as a subflow, passing in the recordId of the trigger record. |

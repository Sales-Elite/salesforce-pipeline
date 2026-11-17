# Security scan: TKT-414

Change: N2: Case priority High escalates and alerts the owner

- Scanner: Salesforce Code Analyzer 5.16.0
- Rules: Recommended, Security, AppExchange with the `bank-v1` severity profile (code-analyzer.yml)
- Graph Engine: off
- Policy: block at High or worse, enforced
- Scanned: 2026-11-17T20:30:28.551Z · 1 files · 4 s
- Result: **passed** · Critical 0 · High 0 · Moderate 1 · Low 0 · Info 0

| # | Severity | Engine | Rule | File | Line | Message |
|---|---|---|---|---|---|---|
| 1 | Moderate | flow | SameRecordUpdate | `force-app/main/default/flows/N2_Case_High_Priority_Escalation.flow-meta.xml` | 76 | An AfterSave record trigger is modifying the same record. Record modifications should be done in BeforeSave triggers, not AfterSave triggers. The trigger definition may be in a parent flow that calls the current flow as a subflow, passing in the recordId of the trigger record. |

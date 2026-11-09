# Security scan: TKT-110

Change: Create a custom object LT2 Risk (LT2_Risk__c) with a Severity picklist (High, Medium, Low) and a Notes long text area. This ticket is the data model only: the LWC and Apex tests are separate tickets.

- Scanner: Salesforce Code Analyzer 5.16.0
- Rules: Recommended, Security, AppExchange with the `bank-v1` severity profile (code-analyzer.yml)
- Graph Engine: off
- Policy: block at High or worse, enforced
- Scanned: 2026-11-09T13:04:54.531Z · 4 files · 5 s
- Result: **passed** · Critical 0 · High 0 · Moderate 0 · Low 0 · Info 0

No findings.

# Security scan: TKT-090

Change: Route Loan Applications to ST42 Credit Desk queue when Submitted

- Scanner: Salesforce Code Analyzer 5.16.0
- Rules: Recommended, Security, AppExchange with the `bank-v1` severity profile (code-analyzer.yml)
- Graph Engine: off
- Policy: block at High or worse, enforced
- Scanned: 2026-11-14T17:25:55.396Z · 30 files · 5 s
- Result: **passed** · Critical 0 · High 0 · Moderate 1 · Low 0 · Info 0

| # | Severity | Engine | Rule | File | Line | Message |
|---|---|---|---|---|---|---|
| 1 | Moderate | pmd | [ProtectSensitiveData](https://developer.salesforce.com/docs/platform/salesforce-code-analyzer/guide/rules-pmd-appexchange.html#protectsensitivedata) | `force-app/main/default/objects/Loan_Application__c/fields/Approval_Authority_Required__c.field-meta.xml` | 1 | Approval_Authority_Required__c is a potential auth token in a custom object: Loan_Application__c |

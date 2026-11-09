# Security scan: TKT-112

Change: Create a custom object LT1 Widget (API name LT1_Widget__c, text name field) with its org-wide default (internal sharing) set to Private. Nothing else.

- Scanner: Salesforce Code Analyzer 5.16.0
- Rules: Recommended, Security, AppExchange with the `bank-v1` severity profile (code-analyzer.yml)
- Graph Engine: off
- Policy: block at High or worse, enforced
- Scanned: 2026-11-09T13:06:27.674Z · 2 files · 4 s
- Result: **passed** · Critical 0 · High 0 · Moderate 0 · Low 0 · Info 0

No findings.

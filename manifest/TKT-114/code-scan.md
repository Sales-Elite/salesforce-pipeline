# Security scan: TKT-114

Change: Create an Apex trigger on Opportunity that sets a new checkbox LT2_Big_Deal__c when Amount is over 100000, with a test class. Our admins cannot maintain code, so if Salesforce can do this without Apex, build that instead.

- Scanner: Salesforce Code Analyzer 5.16.0
- Rules: Recommended, Security, AppExchange with the `bank-v1` severity profile (code-analyzer.yml)
- Graph Engine: off
- Policy: block at High or worse, enforced
- Scanned: 2026-11-09T13:09:50.913Z · 2 files · 4 s
- Result: **passed** · Critical 0 · High 0 · Moderate 0 · Low 0 · Info 0

No findings.

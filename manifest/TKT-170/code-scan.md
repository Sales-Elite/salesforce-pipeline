# Security scan: TKT-170

Change: LT11A Approval LT11A_Big_Deal

- Scanner: Salesforce Code Analyzer 5.16.0
- Rules: Recommended, Security, AppExchange with the `bank-v1` severity profile (code-analyzer.yml)
- Graph Engine: off
- Policy: block at High or worse, enforced
- Scanned: 2026-11-15T14:17:48.260Z · 3 files · 6 s
- Result: **passed** · Critical 0 · High 0 · Moderate 0 · Low 3 · Info 0

| # | Severity | Engine | Rule | File | Line | Message |
|---|---|---|---|---|---|---|
| 1 | Low | pmd | [AnnotationsNamingConventions](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_codestyle.html#annotationsnamingconventions) | `force-app/main/default/classes/LT11A_Big_Deal_ApprovalTest.cls` | 1 | The annotation @isTest should be in PascalCase: @IsTest |
| 2 | Low | pmd | [AnnotationsNamingConventions](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_codestyle.html#annotationsnamingconventions) | `force-app/main/default/classes/LT11A_Big_Deal_ApprovalTest.cls` | 20 | The annotation @isTest should be in PascalCase: @IsTest |
| 3 | Low | pmd | [AnnotationsNamingConventions](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_codestyle.html#annotationsnamingconventions) | `force-app/main/default/classes/LT11A_Big_Deal_ApprovalTest.cls` | 44 | The annotation @isTest should be in PascalCase: @IsTest |

# Security scan: TKT-281

Change: LT15S Approval: two-step budget approval with a 10,000 threshold on LT15S Budget Request

- Scanner: Salesforce Code Analyzer 5.16.0
- Rules: Recommended, Security, AppExchange with the `bank-v1` severity profile (code-analyzer.yml)
- Graph Engine: off
- Policy: block at High or worse, enforced
- Scanned: 2026-11-11T08:20:53.346Z · 14 files · 5 s
- Result: **passed** · Critical 0 · High 0 · Moderate 0 · Low 5 · Info 0

| # | Severity | Engine | Rule | File | Line | Message |
|---|---|---|---|---|---|---|
| 1 | Low | pmd | [AnnotationsNamingConventions](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_codestyle.html#annotationsnamingconventions) | `force-app/main/default/classes/LT15S_Budget_ApprovalTest.cls` | 1 | The annotation @isTest should be in PascalCase: @IsTest |
| 2 | Low | pmd | [AnnotationsNamingConventions](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_codestyle.html#annotationsnamingconventions) | `force-app/main/default/classes/LT15S_Budget_ApprovalTest.cls` | 3 | The annotation @isTest should be in PascalCase: @IsTest |
| 3 | Low | pmd | [ApexUnitTestClassShouldHaveRunAs](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_bestpractices.html#apexunittestclassshouldhaverunas) | `force-app/main/default/classes/LT15S_Budget_ApprovalTest.cls` | 4 | Apex unit test classes should have at least one System.runAs() call |
| 4 | Low | pmd | [AnnotationsNamingConventions](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_codestyle.html#annotationsnamingconventions) | `force-app/main/default/classes/LT15S_Budget_ApprovalTest.cls` | 17 | The annotation @isTest should be in PascalCase: @IsTest |
| 5 | Low | pmd | [ApexUnitTestClassShouldHaveRunAs](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_bestpractices.html#apexunittestclassshouldhaverunas) | `force-app/main/default/classes/LT15S_Budget_ApprovalTest.cls` | 18 | Apex unit test classes should have at least one System.runAs() call |

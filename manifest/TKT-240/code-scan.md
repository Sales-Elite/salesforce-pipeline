# Security scan: TKT-240

Change: LT14 Hourly scheduled Apex sets Account Description to checked

- Scanner: Salesforce Code Analyzer 5.16.0
- Rules: Recommended, Security, AppExchange with the `bank-v1` severity profile (code-analyzer.yml)
- Graph Engine: off
- Policy: block at High or worse, enforced
- Scanned: 2026-11-14T16:43:47.842Z · 4 files · 6 s
- Result: **passed** · Critical 0 · High 0 · Moderate 1 · Low 11 · Info 0

| # | Severity | Engine | Rule | File | Line | Message |
|---|---|---|---|---|---|---|
| 1 | Moderate | pmd | [EmptyStatementBlock](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_errorprone.html#emptystatementblock) | `force-app/main/default/classes/LT14_AccountDescriptionScheduler.cls` | 23 | Avoid empty block statements. |
| 2 | Low | pmd | [ApexDoc](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_documentation.html#apexdoc) | `force-app/main/default/classes/LT14_AccountDescriptionScheduler.cls` | 1 | Missing ApexDoc comment |
| 3 | Low | pmd | [ApexDoc](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_documentation.html#apexdoc) | `force-app/main/default/classes/LT14_AccountDescriptionScheduler.cls` | 2 | Missing ApexDoc comment |
| 4 | Low | pmd | [ApexDoc](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_documentation.html#apexdoc) | `force-app/main/default/classes/LT14_AccountDescriptionScheduler.cls` | 6 | Missing ApexDoc comment |
| 5 | Low | pmd | [AvoidNonRestrictiveQueries](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_performance.html#avoidnonrestrictivequeries) | `force-app/main/default/classes/LT14_AccountDescriptionScheduler.cls` | 7 | Avoid SOQL queries without a where or limit statement |
| 6 | Low | pmd | [ApexDoc](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_documentation.html#apexdoc) | `force-app/main/default/classes/LT14_AccountDescriptionScheduler.cls` | 10 | Missing ApexDoc comment |
| 7 | Low | pmd | [ApexDoc](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_documentation.html#apexdoc) | `force-app/main/default/classes/LT14_AccountDescriptionScheduler.cls` | 23 | Missing ApexDoc comment |
| 8 | Low | pmd | [AnnotationsNamingConventions](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_codestyle.html#annotationsnamingconventions) | `force-app/main/default/classes/LT14_AccountDescriptionSchedulerTest.cls` | 1 | The annotation @isTest should be in PascalCase: @IsTest |
| 9 | Low | pmd | [AnnotationsNamingConventions](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_codestyle.html#annotationsnamingconventions) | `force-app/main/default/classes/LT14_AccountDescriptionSchedulerTest.cls` | 3 | The annotation @isTest should be in PascalCase: @IsTest |
| 10 | Low | pmd | [ApexUnitTestClassShouldHaveRunAs](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_bestpractices.html#apexunittestclassshouldhaverunas) | `force-app/main/default/classes/LT14_AccountDescriptionSchedulerTest.cls` | 4 | Apex unit test classes should have at least one System.runAs() call |
| 11 | Low | pmd | [AnnotationsNamingConventions](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_codestyle.html#annotationsnamingconventions) | `force-app/main/default/classes/LT14_AccountDescriptionSchedulerTest.cls` | 18 | The annotation @isTest should be in PascalCase: @IsTest |
| 12 | Low | pmd | [ApexUnitTestClassShouldHaveRunAs](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_bestpractices.html#apexunittestclassshouldhaverunas) | `force-app/main/default/classes/LT14_AccountDescriptionSchedulerTest.cls` | 19 | Apex unit test classes should have at least one System.runAs() call |

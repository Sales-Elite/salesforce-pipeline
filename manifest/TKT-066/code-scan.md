# Security scan: TKT-066

Change: Schedule the nightly risk job

- Scanner: Salesforce Code Analyzer 5.16.0
- Rules: Recommended, Security, AppExchange with the `bank-v1` severity profile (code-analyzer.yml)
- Graph Engine: off
- Policy: block at High or worse, enforced
- Scanned: 2026-11-07T22:06:36.504Z · 4 files · 5 s
- Result: **passed** · Critical 0 · High 0 · Moderate 0 · Low 10 · Info 0

| # | Severity | Engine | Rule | File | Line | Message |
|---|---|---|---|---|---|---|
| 1 | Low | pmd | [ApexDoc](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_documentation.html#apexdoc) | `force-app/main/default/classes/RenewalRiskScheduler.cls` | 1 | Missing ApexDoc comment |
| 2 | Low | pmd | [ApexDoc](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_documentation.html#apexdoc) | `force-app/main/default/classes/RenewalRiskScheduler.cls` | 5 | Missing ApexDoc comment |
| 3 | Low | pmd | [ApexDoc](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_documentation.html#apexdoc) | `force-app/main/default/classes/RenewalRiskScheduler.cls` | 9 | Missing ApexDoc comment |
| 4 | Low | pmd | [AnnotationsNamingConventions](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_codestyle.html#annotationsnamingconventions) | `force-app/main/default/classes/RenewalRiskSchedulerTest.cls` | 1 | The annotation @isTest should be in PascalCase: @IsTest |
| 5 | Low | pmd | [AnnotationsNamingConventions](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_codestyle.html#annotationsnamingconventions) | `force-app/main/default/classes/RenewalRiskSchedulerTest.cls` | 3 | The annotation @isTest should be in PascalCase: @IsTest |
| 6 | Low | pmd | [ApexUnitTestClassShouldHaveRunAs](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_bestpractices.html#apexunittestclassshouldhaverunas) | `force-app/main/default/classes/RenewalRiskSchedulerTest.cls` | 4 | Apex unit test classes should have at least one System.runAs() call |
| 7 | Low | pmd | [AnnotationsNamingConventions](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_codestyle.html#annotationsnamingconventions) | `force-app/main/default/classes/RenewalRiskSchedulerTest.cls` | 12 | The annotation @isTest should be in PascalCase: @IsTest |
| 8 | Low | pmd | [ApexUnitTestClassShouldHaveRunAs](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_bestpractices.html#apexunittestclassshouldhaverunas) | `force-app/main/default/classes/RenewalRiskSchedulerTest.cls` | 13 | Apex unit test classes should have at least one System.runAs() call |
| 9 | Low | pmd | [AnnotationsNamingConventions](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_codestyle.html#annotationsnamingconventions) | `force-app/main/default/classes/RenewalRiskSchedulerTest.cls` | 21 | The annotation @isTest should be in PascalCase: @IsTest |
| 10 | Low | pmd | [ApexUnitTestClassShouldHaveRunAs](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_bestpractices.html#apexunittestclassshouldhaverunas) | `force-app/main/default/classes/RenewalRiskSchedulerTest.cls` | 22 | Apex unit test classes should have at least one System.runAs() call |

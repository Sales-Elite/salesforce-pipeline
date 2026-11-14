# Security scan: TKT-067

Change: Write Apex tests for the risk batch and scheduler

- Scanner: Salesforce Code Analyzer 5.16.0
- Rules: Recommended, Security, AppExchange with the `bank-v1` severity profile (code-analyzer.yml)
- Graph Engine: off
- Policy: block at High or worse, enforced
- Scanned: 2026-11-14T16:23:19.368Z · 4 files · 6 s
- Result: **passed** · Critical 0 · High 0 · Moderate 1 · Low 18 · Info 1

| # | Severity | Engine | Rule | File | Line | Message |
|---|---|---|---|---|---|---|
| 1 | Moderate | pmd | [ExcessiveParameterList](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_design.html#excessiveparameterlist) | `force-app/main/default/classes/RenewalRiskScoringBatchTest.cls` | 26 | Avoid long parameter lists (4 parameters - threshold is 4). |
| 2 | Low | pmd | [AnnotationsNamingConventions](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_codestyle.html#annotationsnamingconventions) | `force-app/main/default/classes/RenewalRiskSchedulerTest.cls` | 1 | The annotation @isTest should be in PascalCase: @IsTest |
| 3 | Low | pmd | [AnnotationsNamingConventions](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_codestyle.html#annotationsnamingconventions) | `force-app/main/default/classes/RenewalRiskSchedulerTest.cls` | 26 | The annotation @isTest should be in PascalCase: @IsTest |
| 4 | Low | pmd | [AnnotationsNamingConventions](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_codestyle.html#annotationsnamingconventions) | `force-app/main/default/classes/RenewalRiskSchedulerTest.cls` | 39 | The annotation @isTest should be in PascalCase: @IsTest |
| 5 | Low | pmd | [AnnotationsNamingConventions](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_codestyle.html#annotationsnamingconventions) | `force-app/main/default/classes/RenewalRiskSchedulerTest.cls` | 57 | The annotation @isTest should be in PascalCase: @IsTest |
| 6 | Low | pmd | [AnnotationsNamingConventions](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_codestyle.html#annotationsnamingconventions) | `force-app/main/default/classes/RenewalRiskScoringBatchTest.cls` | 1 | The annotation @isTest should be in PascalCase: @IsTest |
| 7 | Low | pmd | [AnnotationsNamingConventions](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_codestyle.html#annotationsnamingconventions) | `force-app/main/default/classes/RenewalRiskScoringBatchTest.cls` | 43 | The annotation @isTest should be in PascalCase: @IsTest |
| 8 | Low | pmd | [ApexUnitTestClassShouldHaveRunAs](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_bestpractices.html#apexunittestclassshouldhaverunas) | `force-app/main/default/classes/RenewalRiskScoringBatchTest.cls` | 44 | Apex unit test classes should have at least one System.runAs() call |
| 9 | Low | pmd | [AnnotationsNamingConventions](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_codestyle.html#annotationsnamingconventions) | `force-app/main/default/classes/RenewalRiskScoringBatchTest.cls` | 103 | The annotation @isTest should be in PascalCase: @IsTest |
| 10 | Low | pmd | [AnnotationsNamingConventions](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_codestyle.html#annotationsnamingconventions) | `force-app/main/default/classes/RenewalRiskScoringBatchTest.cls` | 122 | The annotation @isTest should be in PascalCase: @IsTest |
| 11 | Low | pmd | [AnnotationsNamingConventions](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_codestyle.html#annotationsnamingconventions) | `force-app/main/default/classes/RenewalRiskScoringBatchTest.cls` | 145 | The annotation @isTest should be in PascalCase: @IsTest |
| 12 | Low | pmd | [ApexUnitTestClassShouldHaveRunAs](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_bestpractices.html#apexunittestclassshouldhaverunas) | `force-app/main/default/classes/RenewalRiskScoringBatchTest.cls` | 146 | Apex unit test classes should have at least one System.runAs() call |
| 13 | Low | pmd | [AnnotationsNamingConventions](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_codestyle.html#annotationsnamingconventions) | `force-app/main/default/classes/RenewalRiskScoringBatchTest.cls` | 160 | The annotation @isTest should be in PascalCase: @IsTest |
| 14 | Low | pmd | [ApexUnitTestClassShouldHaveRunAs](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_bestpractices.html#apexunittestclassshouldhaverunas) | `force-app/main/default/classes/RenewalRiskScoringBatchTest.cls` | 161 | Apex unit test classes should have at least one System.runAs() call |
| 15 | Low | pmd | [AnnotationsNamingConventions](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_codestyle.html#annotationsnamingconventions) | `force-app/main/default/classes/RenewalRiskScoringBatchTest.cls` | 174 | The annotation @isTest should be in PascalCase: @IsTest |
| 16 | Low | pmd | [ApexUnitTestClassShouldHaveRunAs](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_bestpractices.html#apexunittestclassshouldhaverunas) | `force-app/main/default/classes/RenewalRiskScoringBatchTest.cls` | 175 | Apex unit test classes should have at least one System.runAs() call |
| 17 | Low | pmd | [AnnotationsNamingConventions](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_codestyle.html#annotationsnamingconventions) | `force-app/main/default/classes/RenewalRiskScoringBatchTest.cls` | 193 | The annotation @isTest should be in PascalCase: @IsTest |
| 18 | Low | pmd | [ApexUnitTestClassShouldHaveRunAs](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_bestpractices.html#apexunittestclassshouldhaverunas) | `force-app/main/default/classes/RenewalRiskScoringBatchTest.cls` | 194 | Apex unit test classes should have at least one System.runAs() call |
| 19 | Low | pmd | [AnnotationsNamingConventions](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_codestyle.html#annotationsnamingconventions) | `force-app/main/default/classes/RenewalRiskScoringBatchTest.cls` | 208 | The annotation @isTest should be in PascalCase: @IsTest |
| 20 | Info | cpd | [DetectCopyPasteForApex](https://docs.pmd-code.org/latest/pmd_userdocs_cpd.html#refactoring-duplicates) | `force-app/main/default/classes/RenewalRiskSchedulerTest.cls` | 2 | Duplicate code detected for language 'apex'. Found 2 code locations containing the same block of code consisting of 147 tokens across 23 lines. |

# Security scan: TKT-086

Change: ST03 Opportunity discount guard: trigger handler driven by custom metadata, bulk-safe, 90% tests

- Scanner: Salesforce Code Analyzer 5.16.0
- Rules: Recommended, Security, AppExchange with the `bank-v1` severity profile (code-analyzer.yml)
- Graph Engine: off
- Policy: block at High or worse, enforced
- Scanned: 2026-11-09T08:21:34.388Z · 19 files · 5 s
- Result: **passed** · Critical 0 · High 0 · Moderate 0 · Low 14 · Info 0

| # | Severity | Engine | Rule | File | Line | Message |
|---|---|---|---|---|---|---|
| 1 | Low | pmd | [ApexDoc](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_documentation.html#apexdoc) | `force-app/main/default/classes/ST03_OpportunityTriggerHandler.cls` | 1 | Missing ApexDoc comment |
| 2 | Low | pmd | [AvoidNonRestrictiveQueries](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_performance.html#avoidnonrestrictivequeries) | `force-app/main/default/classes/ST03_OpportunityTriggerHandler.cls` | 7 | Avoid SOQL queries without a where or limit statement |
| 3 | Low | pmd | [ApexDoc](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_documentation.html#apexdoc) | `force-app/main/default/classes/ST03_OpportunityTriggerHandler.cls` | 16 | Missing ApexDoc comment |
| 4 | Low | pmd | [AnnotationsNamingConventions](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_codestyle.html#annotationsnamingconventions) | `force-app/main/default/classes/ST03_OpportunityTriggerHandlerTest.cls` | 1 | The annotation @isTest should be in PascalCase: @IsTest |
| 5 | Low | pmd | [AnnotationsNamingConventions](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_codestyle.html#annotationsnamingconventions) | `force-app/main/default/classes/ST03_OpportunityTriggerHandlerTest.cls` | 8 | The annotation @isTest should be in PascalCase: @IsTest |
| 6 | Low | pmd | [ApexUnitTestClassShouldHaveRunAs](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_bestpractices.html#apexunittestclassshouldhaverunas) | `force-app/main/default/classes/ST03_OpportunityTriggerHandlerTest.cls` | 8 | Apex unit test classes should have at least one System.runAs() call |
| 7 | Low | pmd | [AnnotationsNamingConventions](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_codestyle.html#annotationsnamingconventions) | `force-app/main/default/classes/ST03_OpportunityTriggerHandlerTest.cls` | 14 | The annotation @isTest should be in PascalCase: @IsTest |
| 8 | Low | pmd | [ApexUnitTestClassShouldHaveRunAs](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_bestpractices.html#apexunittestclassshouldhaverunas) | `force-app/main/default/classes/ST03_OpportunityTriggerHandlerTest.cls` | 14 | Apex unit test classes should have at least one System.runAs() call |
| 9 | Low | pmd | [AnnotationsNamingConventions](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_codestyle.html#annotationsnamingconventions) | `force-app/main/default/classes/ST03_OpportunityTriggerHandlerTest.cls` | 21 | The annotation @isTest should be in PascalCase: @IsTest |
| 10 | Low | pmd | [ApexUnitTestClassShouldHaveRunAs](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_bestpractices.html#apexunittestclassshouldhaverunas) | `force-app/main/default/classes/ST03_OpportunityTriggerHandlerTest.cls` | 21 | Apex unit test classes should have at least one System.runAs() call |
| 11 | Low | pmd | [AnnotationsNamingConventions](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_codestyle.html#annotationsnamingconventions) | `force-app/main/default/classes/ST03_OpportunityTriggerHandlerTest.cls` | 28 | The annotation @isTest should be in PascalCase: @IsTest |
| 12 | Low | pmd | [ApexUnitTestClassShouldHaveRunAs](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_bestpractices.html#apexunittestclassshouldhaverunas) | `force-app/main/default/classes/ST03_OpportunityTriggerHandlerTest.cls` | 28 | Apex unit test classes should have at least one System.runAs() call |
| 13 | Low | pmd | [AnnotationsNamingConventions](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_codestyle.html#annotationsnamingconventions) | `force-app/main/default/classes/ST03_OpportunityTriggerHandlerTest.cls` | 42 | The annotation @isTest should be in PascalCase: @IsTest |
| 14 | Low | pmd | [ApexUnitTestClassShouldHaveRunAs](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_bestpractices.html#apexunittestclassshouldhaverunas) | `force-app/main/default/classes/ST03_OpportunityTriggerHandlerTest.cls` | 42 | Apex unit test classes should have at least one System.runAs() call |

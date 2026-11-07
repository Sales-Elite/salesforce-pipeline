# Security scan: TKT-023

Change: Block deleting the primary contact on an open Opportunity

- Scanner: Salesforce Code Analyzer 5.16.0
- Rules: Recommended, Security, AppExchange with the `bank-v1` severity profile (code-analyzer.yml)
- Graph Engine: off
- Policy: block at High or worse, enforced
- Scanned: 2026-11-07T11:11:40.423Z · 6 files · 5 s
- Result: **passed** · Critical 0 · High 0 · Moderate 1 · Low 13 · Info 0

| # | Severity | Engine | Rule | File | Line | Message |
|---|---|---|---|---|---|---|
| 1 | Moderate | pmd | [AvoidLogicInTrigger](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_bestpractices.html#avoidlogicintrigger) | `force-app/main/default/triggers/ContactTrigger.trigger` | 1 | Avoid logic in triggers |
| 2 | Low | pmd | [ApexDoc](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_documentation.html#apexdoc) | `force-app/main/default/classes/ContactTriggerHandler.cls` | 1 | Missing ApexDoc comment |
| 3 | Low | pmd | [ApexDoc](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_documentation.html#apexdoc) | `force-app/main/default/classes/ContactTriggerHandler.cls` | 4 | Missing ApexDoc comment |
| 4 | Low | pmd | [AnnotationsNamingConventions](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_codestyle.html#annotationsnamingconventions) | `force-app/main/default/classes/ContactTriggerHandlerTest.cls` | 1 | The annotation @isTest should be in PascalCase: @IsTest |
| 5 | Low | pmd | [AnnotationsNamingConventions](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_codestyle.html#annotationsnamingconventions) | `force-app/main/default/classes/ContactTriggerHandlerTest.cls` | 26 | The annotation @isTest should be in PascalCase: @IsTest |
| 6 | Low | pmd | [ApexUnitTestClassShouldHaveRunAs](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_bestpractices.html#apexunittestclassshouldhaverunas) | `force-app/main/default/classes/ContactTriggerHandlerTest.cls` | 27 | Apex unit test classes should have at least one System.runAs() call |
| 7 | Low | pmd | [AnnotationsNamingConventions](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_codestyle.html#annotationsnamingconventions) | `force-app/main/default/classes/ContactTriggerHandlerTest.cls` | 36 | The annotation @isTest should be in PascalCase: @IsTest |
| 8 | Low | pmd | [ApexUnitTestClassShouldHaveRunAs](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_bestpractices.html#apexunittestclassshouldhaverunas) | `force-app/main/default/classes/ContactTriggerHandlerTest.cls` | 37 | Apex unit test classes should have at least one System.runAs() call |
| 9 | Low | pmd | [AnnotationsNamingConventions](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_codestyle.html#annotationsnamingconventions) | `force-app/main/default/classes/ContactTriggerHandlerTest.cls` | 42 | The annotation @isTest should be in PascalCase: @IsTest |
| 10 | Low | pmd | [ApexUnitTestClassShouldHaveRunAs](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_bestpractices.html#apexunittestclassshouldhaverunas) | `force-app/main/default/classes/ContactTriggerHandlerTest.cls` | 43 | Apex unit test classes should have at least one System.runAs() call |
| 11 | Low | pmd | [AnnotationsNamingConventions](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_codestyle.html#annotationsnamingconventions) | `force-app/main/default/classes/ContactTriggerHandlerTest.cls` | 48 | The annotation @isTest should be in PascalCase: @IsTest |
| 12 | Low | pmd | [ApexUnitTestClassShouldHaveRunAs](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_bestpractices.html#apexunittestclassshouldhaverunas) | `force-app/main/default/classes/ContactTriggerHandlerTest.cls` | 49 | Apex unit test classes should have at least one System.runAs() call |
| 13 | Low | pmd | [AnnotationsNamingConventions](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_codestyle.html#annotationsnamingconventions) | `force-app/main/default/classes/ContactTriggerHandlerTest.cls` | 54 | The annotation @isTest should be in PascalCase: @IsTest |
| 14 | Low | pmd | [ApexUnitTestClassShouldHaveRunAs](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_bestpractices.html#apexunittestclassshouldhaverunas) | `force-app/main/default/classes/ContactTriggerHandlerTest.cls` | 55 | Apex unit test classes should have at least one System.runAs() call |

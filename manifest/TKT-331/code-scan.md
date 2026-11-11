# Security scan: TKT-331

Change: LT18C Platform event: LT18C Order status events with a fulfilment subscriber

- Scanner: Salesforce Code Analyzer 5.16.0
- Rules: Recommended, Security, AppExchange with the `bank-v1` severity profile (code-analyzer.yml)
- Graph Engine: off
- Policy: block at High or worse, enforced
- Scanned: 2026-11-11T11:16:44.249Z · 24 files · 5 s
- Result: **passed** · Critical 0 · High 0 · Moderate 4 · Low 19 · Info 0

| # | Severity | Engine | Rule | File | Line | Message |
|---|---|---|---|---|---|---|
| 1 | Moderate | pmd | [CognitiveComplexity](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_design.html#cognitivecomplexity) | `force-app/main/default/classes/LT18C_OrderEventTriggerHandler.cls` | 2 | The method 'handleEvents(List<LT18C_Order_Event__e>)' has a cognitive complexity of 18, current threshold is 15 |
| 2 | Moderate | pmd | [CyclomaticComplexity](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_design.html#cyclomaticcomplexity) | `force-app/main/default/classes/LT18C_OrderEventTriggerHandler.cls` | 2 | The method 'handleEvents(List<LT18C_Order_Event__e>)' has a cyclomatic complexity of 16. |
| 3 | Moderate | pmd | [CognitiveComplexity](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_design.html#cognitivecomplexity) | `force-app/main/default/classes/LT18C_OrderTriggerHandler.cls` | 2 | The method 'handleAfter(List<LT18C_Order__c>, Map<Id, LT18C_Order__c>)' has a cognitive complexity of 24, current threshold is 15 |
| 4 | Moderate | pmd | [CyclomaticComplexity](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_design.html#cyclomaticcomplexity) | `force-app/main/default/classes/LT18C_OrderTriggerHandler.cls` | 2 | The method 'handleAfter(List<LT18C_Order__c>, Map<Id, LT18C_Order__c>)' has a cyclomatic complexity of 15. |
| 5 | Low | pmd | [AnnotationsNamingConventions](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_codestyle.html#annotationsnamingconventions) | `force-app/main/default/classes/LT18C_OrderEventTest.cls` | 1 | The annotation @isTest should be in PascalCase: @IsTest |
| 6 | Low | pmd | [AnnotationsNamingConventions](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_codestyle.html#annotationsnamingconventions) | `force-app/main/default/classes/LT18C_OrderEventTest.cls` | 17 | The annotation @isTest should be in PascalCase: @IsTest |
| 7 | Low | pmd | [ApexUnitTestClassShouldHaveRunAs](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_bestpractices.html#apexunittestclassshouldhaverunas) | `force-app/main/default/classes/LT18C_OrderEventTest.cls` | 17 | Apex unit test classes should have at least one System.runAs() call |
| 8 | Low | pmd | [AnnotationsNamingConventions](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_codestyle.html#annotationsnamingconventions) | `force-app/main/default/classes/LT18C_OrderEventTest.cls` | 25 | The annotation @isTest should be in PascalCase: @IsTest |
| 9 | Low | pmd | [ApexUnitTestClassShouldHaveRunAs](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_bestpractices.html#apexunittestclassshouldhaverunas) | `force-app/main/default/classes/LT18C_OrderEventTest.cls` | 25 | Apex unit test classes should have at least one System.runAs() call |
| 10 | Low | pmd | [AnnotationsNamingConventions](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_codestyle.html#annotationsnamingconventions) | `force-app/main/default/classes/LT18C_OrderEventTest.cls` | 30 | The annotation @isTest should be in PascalCase: @IsTest |
| 11 | Low | pmd | [ApexUnitTestClassShouldHaveRunAs](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_bestpractices.html#apexunittestclassshouldhaverunas) | `force-app/main/default/classes/LT18C_OrderEventTest.cls` | 30 | Apex unit test classes should have at least one System.runAs() call |
| 12 | Low | pmd | [AnnotationsNamingConventions](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_codestyle.html#annotationsnamingconventions) | `force-app/main/default/classes/LT18C_OrderEventTest.cls` | 37 | The annotation @isTest should be in PascalCase: @IsTest |
| 13 | Low | pmd | [ApexUnitTestClassShouldHaveRunAs](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_bestpractices.html#apexunittestclassshouldhaverunas) | `force-app/main/default/classes/LT18C_OrderEventTest.cls` | 37 | Apex unit test classes should have at least one System.runAs() call |
| 14 | Low | pmd | [AnnotationsNamingConventions](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_codestyle.html#annotationsnamingconventions) | `force-app/main/default/classes/LT18C_OrderEventTest.cls` | 53 | The annotation @isTest should be in PascalCase: @IsTest |
| 15 | Low | pmd | [ApexUnitTestClassShouldHaveRunAs](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_bestpractices.html#apexunittestclassshouldhaverunas) | `force-app/main/default/classes/LT18C_OrderEventTest.cls` | 53 | Apex unit test classes should have at least one System.runAs() call |
| 16 | Low | pmd | [AnnotationsNamingConventions](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_codestyle.html#annotationsnamingconventions) | `force-app/main/default/classes/LT18C_OrderEventTest.cls` | 60 | The annotation @isTest should be in PascalCase: @IsTest |
| 17 | Low | pmd | [ApexUnitTestClassShouldHaveRunAs](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_bestpractices.html#apexunittestclassshouldhaverunas) | `force-app/main/default/classes/LT18C_OrderEventTest.cls` | 60 | Apex unit test classes should have at least one System.runAs() call |
| 18 | Low | pmd | [ApexDoc](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_documentation.html#apexdoc) | `force-app/main/default/classes/LT18C_OrderEventTriggerHandler.cls` | 1 | Missing ApexDoc comment |
| 19 | Low | pmd | [ApexDoc](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_documentation.html#apexdoc) | `force-app/main/default/classes/LT18C_OrderEventTriggerHandler.cls` | 2 | Missing ApexDoc comment |
| 20 | Low | pmd | [AvoidDebugStatements](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_performance.html#avoiddebugstatements) | `force-app/main/default/classes/LT18C_OrderEventTriggerHandler.cls` | 11 | Avoid debug statements since they impact on performance |
| 21 | Low | pmd | [ApexDoc](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_documentation.html#apexdoc) | `force-app/main/default/classes/LT18C_OrderTriggerHandler.cls` | 1 | Missing ApexDoc comment |
| 22 | Low | pmd | [ApexDoc](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_documentation.html#apexdoc) | `force-app/main/default/classes/LT18C_OrderTriggerHandler.cls` | 2 | Missing ApexDoc comment |
| 23 | Low | pmd | [AvoidDebugStatements](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_performance.html#avoiddebugstatements) | `force-app/main/default/classes/LT18C_OrderTriggerHandler.cls` | 23 | Avoid debug statements since they impact on performance |

# Security scan: TKT-286

Change: LT15S Platform event: LT15S Order status events with a fulfilment subscriber

- Scanner: Salesforce Code Analyzer 5.16.0
- Rules: Recommended, Security, AppExchange with the `bank-v1` severity profile (code-analyzer.yml)
- Graph Engine: off
- Policy: block at High or worse, enforced
- Scanned: 2026-11-11T08:37:26.558Z · 25 files · 5 s
- Result: **passed** · Critical 0 · High 0 · Moderate 3 · Low 17 · Info 0

| # | Severity | Engine | Rule | File | Line | Message |
|---|---|---|---|---|---|---|
| 1 | Moderate | pmd | [CognitiveComplexity](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_design.html#cognitivecomplexity) | `force-app/main/default/classes/LT15S_OrderEventTriggerHandler.cls` | 4 | The method 'handleAfterInsert(List<LT15S_Order_Event__e>)' has a cognitive complexity of 15, current threshold is 15 |
| 2 | Moderate | pmd | [CyclomaticComplexity](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_design.html#cyclomaticcomplexity) | `force-app/main/default/classes/LT15S_OrderEventTriggerHandler.cls` | 4 | The method 'handleAfterInsert(List<LT15S_Order_Event__e>)' has a cyclomatic complexity of 12. |
| 3 | Moderate | pmd | [AvoidLogicInTrigger](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_bestpractices.html#avoidlogicintrigger) | `force-app/main/default/triggers/LT15S_OrderTrigger.trigger` | 1 | Avoid logic in triggers |
| 4 | Low | pmd | [AnnotationsNamingConventions](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_codestyle.html#annotationsnamingconventions) | `force-app/main/default/classes/LT15S_OrderEventsTest.cls` | 1 | The annotation @isTest should be in PascalCase: @IsTest |
| 5 | Low | pmd | [AnnotationsNamingConventions](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_codestyle.html#annotationsnamingconventions) | `force-app/main/default/classes/LT15S_OrderEventsTest.cls` | 7 | The annotation @isTest should be in PascalCase: @IsTest |
| 6 | Low | pmd | [ApexUnitTestClassShouldHaveRunAs](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_bestpractices.html#apexunittestclassshouldhaverunas) | `force-app/main/default/classes/LT15S_OrderEventsTest.cls` | 8 | Apex unit test classes should have at least one System.runAs() call |
| 7 | Low | pmd | [AnnotationsNamingConventions](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_codestyle.html#annotationsnamingconventions) | `force-app/main/default/classes/LT15S_OrderEventsTest.cls` | 17 | The annotation @isTest should be in PascalCase: @IsTest |
| 8 | Low | pmd | [ApexUnitTestClassShouldHaveRunAs](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_bestpractices.html#apexunittestclassshouldhaverunas) | `force-app/main/default/classes/LT15S_OrderEventsTest.cls` | 18 | Apex unit test classes should have at least one System.runAs() call |
| 9 | Low | pmd | [AnnotationsNamingConventions](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_codestyle.html#annotationsnamingconventions) | `force-app/main/default/classes/LT15S_OrderEventsTest.cls` | 37 | The annotation @isTest should be in PascalCase: @IsTest |
| 10 | Low | pmd | [ApexUnitTestClassShouldHaveRunAs](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_bestpractices.html#apexunittestclassshouldhaverunas) | `force-app/main/default/classes/LT15S_OrderEventsTest.cls` | 38 | Apex unit test classes should have at least one System.runAs() call |
| 11 | Low | pmd | [AnnotationsNamingConventions](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_codestyle.html#annotationsnamingconventions) | `force-app/main/default/classes/LT15S_OrderEventsTest.cls` | 52 | The annotation @isTest should be in PascalCase: @IsTest |
| 12 | Low | pmd | [ApexUnitTestClassShouldHaveRunAs](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_bestpractices.html#apexunittestclassshouldhaverunas) | `force-app/main/default/classes/LT15S_OrderEventsTest.cls` | 53 | Apex unit test classes should have at least one System.runAs() call |
| 13 | Low | pmd | [AnnotationsNamingConventions](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_codestyle.html#annotationsnamingconventions) | `force-app/main/default/classes/LT15S_OrderEventsTest.cls` | 62 | The annotation @isTest should be in PascalCase: @IsTest |
| 14 | Low | pmd | [ApexUnitTestClassShouldHaveRunAs](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_bestpractices.html#apexunittestclassshouldhaverunas) | `force-app/main/default/classes/LT15S_OrderEventsTest.cls` | 63 | Apex unit test classes should have at least one System.runAs() call |
| 15 | Low | pmd | [ApexDoc](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_documentation.html#apexdoc) | `force-app/main/default/classes/LT15S_OrderEventTriggerHandler.cls` | 1 | Missing ApexDoc comment |
| 16 | Low | pmd | [ApexDoc](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_documentation.html#apexdoc) | `force-app/main/default/classes/LT15S_OrderEventTriggerHandler.cls` | 4 | Missing ApexDoc comment |
| 17 | Low | pmd | [AvoidDebugStatements](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_performance.html#avoiddebugstatements) | `force-app/main/default/classes/LT15S_OrderEventTriggerHandler.cls` | 11 | Avoid debug statements since they impact on performance |
| 18 | Low | pmd | [ApexDoc](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_documentation.html#apexdoc) | `force-app/main/default/classes/LT15S_OrderTriggerHandler.cls` | 1 | Missing ApexDoc comment |
| 19 | Low | pmd | [ApexDoc](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_documentation.html#apexdoc) | `force-app/main/default/classes/LT15S_OrderTriggerHandler.cls` | 2 | Missing ApexDoc comment |
| 20 | Low | pmd | [ApexDoc](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_documentation.html#apexdoc) | `force-app/main/default/classes/LT15S_OrderTriggerHandler.cls` | 10 | Missing ApexDoc comment |

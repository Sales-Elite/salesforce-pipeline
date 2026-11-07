# Security scan: TKT-014

Change: Closed Won kickoff automation (Apex)

- Scanner: Salesforce Code Analyzer 5.16.0
- Rules: Recommended, Security, AppExchange with the `bank-v1` severity profile (code-analyzer.yml)
- Graph Engine: off
- Policy: block at High or worse, enforced
- Scanned: 2026-11-07T10:39:27.356Z · 8 files · 5 s
- Result: **passed** · Critical 0 · High 0 · Moderate 3 · Low 16 · Info 0

| # | Severity | Engine | Rule | File | Line | Message |
|---|---|---|---|---|---|---|
| 1 | Moderate | pmd | [CognitiveComplexity](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_design.html#cognitivecomplexity) | `force-app/main/default/classes/OpportunityTriggerHandler.cls` | 12 | The method 'process(List<Opportunity>, Map<Id, Opportunity>)' has a cognitive complexity of 25, current threshold is 15 |
| 2 | Moderate | pmd | [CyclomaticComplexity](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_design.html#cyclomaticcomplexity) | `force-app/main/default/classes/OpportunityTriggerHandler.cls` | 12 | The method 'process(List<Opportunity>, Map<Id, Opportunity>)' has a cyclomatic complexity of 17. |
| 3 | Moderate | pmd | [AvoidLogicInTrigger](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_bestpractices.html#avoidlogicintrigger) | `force-app/main/default/triggers/OpportunityTrigger.trigger` | 1 | Avoid logic in triggers |
| 4 | Low | pmd | [ApexDoc](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_documentation.html#apexdoc) | `force-app/main/default/classes/OpportunityTriggerHandler.cls` | 1 | Missing ApexDoc comment |
| 5 | Low | pmd | [ApexDoc](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_documentation.html#apexdoc) | `force-app/main/default/classes/OpportunityTriggerHandler.cls` | 4 | Missing ApexDoc comment |
| 6 | Low | pmd | [ApexDoc](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_documentation.html#apexdoc) | `force-app/main/default/classes/OpportunityTriggerHandler.cls` | 8 | Missing ApexDoc comment |
| 7 | Low | pmd | [AnnotationsNamingConventions](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_codestyle.html#annotationsnamingconventions) | `force-app/main/default/classes/OpportunityTriggerHandlerTest.cls` | 1 | The annotation @isTest should be in PascalCase: @IsTest |
| 8 | Low | pmd | [AnnotationsNamingConventions](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_codestyle.html#annotationsnamingconventions) | `force-app/main/default/classes/OpportunityTriggerHandlerTest.cls` | 21 | The annotation @isTest should be in PascalCase: @IsTest |
| 9 | Low | pmd | [ApexUnitTestClassShouldHaveRunAs](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_bestpractices.html#apexunittestclassshouldhaverunas) | `force-app/main/default/classes/OpportunityTriggerHandlerTest.cls` | 22 | Apex unit test classes should have at least one System.runAs() call |
| 10 | Low | pmd | [AnnotationsNamingConventions](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_codestyle.html#annotationsnamingconventions) | `force-app/main/default/classes/OpportunityTriggerHandlerTest.cls` | 44 | The annotation @isTest should be in PascalCase: @IsTest |
| 11 | Low | pmd | [ApexUnitTestClassShouldHaveRunAs](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_bestpractices.html#apexunittestclassshouldhaverunas) | `force-app/main/default/classes/OpportunityTriggerHandlerTest.cls` | 45 | Apex unit test classes should have at least one System.runAs() call |
| 12 | Low | pmd | [AnnotationsNamingConventions](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_codestyle.html#annotationsnamingconventions) | `force-app/main/default/classes/OpportunityTriggerHandlerTest.cls` | 55 | The annotation @isTest should be in PascalCase: @IsTest |
| 13 | Low | pmd | [ApexUnitTestClassShouldHaveRunAs](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_bestpractices.html#apexunittestclassshouldhaverunas) | `force-app/main/default/classes/OpportunityTriggerHandlerTest.cls` | 56 | Apex unit test classes should have at least one System.runAs() call |
| 14 | Low | pmd | [AnnotationsNamingConventions](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_codestyle.html#annotationsnamingconventions) | `force-app/main/default/classes/OpportunityTriggerHandlerTest.cls` | 66 | The annotation @isTest should be in PascalCase: @IsTest |
| 15 | Low | pmd | [ApexUnitTestClassShouldHaveRunAs](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_bestpractices.html#apexunittestclassshouldhaverunas) | `force-app/main/default/classes/OpportunityTriggerHandlerTest.cls` | 67 | Apex unit test classes should have at least one System.runAs() call |
| 16 | Low | pmd | [AnnotationsNamingConventions](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_codestyle.html#annotationsnamingconventions) | `force-app/main/default/classes/OpportunityTriggerHandlerTest.cls` | 74 | The annotation @isTest should be in PascalCase: @IsTest |
| 17 | Low | pmd | [ApexUnitTestClassShouldHaveRunAs](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_bestpractices.html#apexunittestclassshouldhaverunas) | `force-app/main/default/classes/OpportunityTriggerHandlerTest.cls` | 75 | Apex unit test classes should have at least one System.runAs() call |
| 18 | Low | pmd | [AnnotationsNamingConventions](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_codestyle.html#annotationsnamingconventions) | `force-app/main/default/classes/OpportunityTriggerHandlerTest.cls` | 81 | The annotation @isTest should be in PascalCase: @IsTest |
| 19 | Low | pmd | [ApexUnitTestClassShouldHaveRunAs](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_bestpractices.html#apexunittestclassshouldhaverunas) | `force-app/main/default/classes/OpportunityTriggerHandlerTest.cls` | 82 | Apex unit test classes should have at least one System.runAs() call |

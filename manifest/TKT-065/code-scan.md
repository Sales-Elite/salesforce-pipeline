# Security scan: TKT-065

Change: Update Risk Level on open renewals

- Scanner: Salesforce Code Analyzer 5.16.0
- Rules: Recommended, Security, AppExchange with the `bank-v1` severity profile (code-analyzer.yml)
- Graph Engine: off
- Policy: block at High or worse, enforced
- Scanned: 2026-11-14T16:35:52.263Z · 7 files · 6 s
- Result: **passed** · Critical 0 · High 0 · Moderate 3 · Low 22 · Info 0

| # | Severity | Engine | Rule | File | Line | Message |
|---|---|---|---|---|---|---|
| 1 | Moderate | pmd | [CyclomaticComplexity](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_design.html#cyclomaticcomplexity) | `force-app/main/default/classes/RenewalRiskScoringBatch.cls` | 1 | The class 'RenewalRiskScoringBatch' has a total cyclomatic complexity of 40 (highest 10). |
| 2 | Moderate | pmd | [CyclomaticComplexity](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_design.html#cyclomaticcomplexity) | `force-app/main/default/classes/RenewalRiskScoringBatch.cls` | 14 | The method 'execute(Database.BatchableContext, List<Account>)' has a cyclomatic complexity of 10. |
| 3 | Moderate | pmd | [ExcessiveParameterList](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_design.html#excessiveparameterlist) | `force-app/main/default/classes/RenewalRiskScoringBatchTest.cls` | 26 | Avoid long parameter lists (4 parameters - threshold is 4). |
| 4 | Low | pmd | [ApexDoc](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_documentation.html#apexdoc) | `force-app/main/default/classes/RenewalRiskScoringBatch.cls` | 1 | Missing ApexDoc comment |
| 5 | Low | pmd | [ApexDoc](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_documentation.html#apexdoc) | `force-app/main/default/classes/RenewalRiskScoringBatch.cls` | 5 | Missing ApexDoc comment |
| 6 | Low | pmd | [ApexDoc](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_documentation.html#apexdoc) | `force-app/main/default/classes/RenewalRiskScoringBatch.cls` | 14 | Missing ApexDoc comment |
| 7 | Low | pmd | [AvoidDebugStatements](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_performance.html#avoiddebugstatements) | `force-app/main/default/classes/RenewalRiskScoringBatch.cls` | 77 | Avoid debug statements since they impact on performance |
| 8 | Low | pmd | [ApexDoc](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_documentation.html#apexdoc) | `force-app/main/default/classes/RenewalRiskScoringBatch.cls` | 82 | Missing ApexDoc comment |
| 9 | Low | pmd | [ApexDoc](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_documentation.html#apexdoc) | `force-app/main/default/classes/RenewalRiskScoringBatch.cls` | 109 | Missing ApexDoc @return |
| 10 | Low | pmd | [ApexDoc](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_documentation.html#apexdoc) | `force-app/main/default/classes/RenewalRiskScoringBatch.cls` | 109 | Missing or mismatched ApexDoc @param |
| 11 | Low | pmd | [AvoidNonRestrictiveQueries](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_performance.html#avoidnonrestrictivequeries) | `force-app/main/default/classes/RenewalRiskScoringBatch.cls` | 138 | Avoid SOQL queries without a where or limit statement |
| 12 | Low | pmd | [AnnotationsNamingConventions](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_codestyle.html#annotationsnamingconventions) | `force-app/main/default/classes/RenewalRiskScoringBatchTest.cls` | 1 | The annotation @isTest should be in PascalCase: @IsTest |
| 13 | Low | pmd | [AnnotationsNamingConventions](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_codestyle.html#annotationsnamingconventions) | `force-app/main/default/classes/RenewalRiskScoringBatchTest.cls` | 43 | The annotation @isTest should be in PascalCase: @IsTest |
| 14 | Low | pmd | [ApexUnitTestClassShouldHaveRunAs](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_bestpractices.html#apexunittestclassshouldhaverunas) | `force-app/main/default/classes/RenewalRiskScoringBatchTest.cls` | 44 | Apex unit test classes should have at least one System.runAs() call |
| 15 | Low | pmd | [AnnotationsNamingConventions](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_codestyle.html#annotationsnamingconventions) | `force-app/main/default/classes/RenewalRiskScoringBatchTest.cls` | 103 | The annotation @isTest should be in PascalCase: @IsTest |
| 16 | Low | pmd | [AnnotationsNamingConventions](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_codestyle.html#annotationsnamingconventions) | `force-app/main/default/classes/RenewalRiskScoringBatchTest.cls` | 122 | The annotation @isTest should be in PascalCase: @IsTest |
| 17 | Low | pmd | [AnnotationsNamingConventions](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_codestyle.html#annotationsnamingconventions) | `force-app/main/default/classes/RenewalRiskScoringBatchTest.cls` | 145 | The annotation @isTest should be in PascalCase: @IsTest |
| 18 | Low | pmd | [ApexUnitTestClassShouldHaveRunAs](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_bestpractices.html#apexunittestclassshouldhaverunas) | `force-app/main/default/classes/RenewalRiskScoringBatchTest.cls` | 146 | Apex unit test classes should have at least one System.runAs() call |
| 19 | Low | pmd | [AnnotationsNamingConventions](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_codestyle.html#annotationsnamingconventions) | `force-app/main/default/classes/RenewalRiskScoringBatchTest.cls` | 160 | The annotation @isTest should be in PascalCase: @IsTest |
| 20 | Low | pmd | [ApexUnitTestClassShouldHaveRunAs](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_bestpractices.html#apexunittestclassshouldhaverunas) | `force-app/main/default/classes/RenewalRiskScoringBatchTest.cls` | 161 | Apex unit test classes should have at least one System.runAs() call |
| 21 | Low | pmd | [AnnotationsNamingConventions](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_codestyle.html#annotationsnamingconventions) | `force-app/main/default/classes/RenewalRiskScoringBatchTest.cls` | 174 | The annotation @isTest should be in PascalCase: @IsTest |
| 22 | Low | pmd | [ApexUnitTestClassShouldHaveRunAs](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_bestpractices.html#apexunittestclassshouldhaverunas) | `force-app/main/default/classes/RenewalRiskScoringBatchTest.cls` | 175 | Apex unit test classes should have at least one System.runAs() call |
| 23 | Low | pmd | [AnnotationsNamingConventions](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_codestyle.html#annotationsnamingconventions) | `force-app/main/default/classes/RenewalRiskScoringBatchTest.cls` | 193 | The annotation @isTest should be in PascalCase: @IsTest |
| 24 | Low | pmd | [ApexUnitTestClassShouldHaveRunAs](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_bestpractices.html#apexunittestclassshouldhaverunas) | `force-app/main/default/classes/RenewalRiskScoringBatchTest.cls` | 194 | Apex unit test classes should have at least one System.runAs() call |
| 25 | Low | pmd | [AnnotationsNamingConventions](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_codestyle.html#annotationsnamingconventions) | `force-app/main/default/classes/RenewalRiskScoringBatchTest.cls` | 208 | The annotation @isTest should be in PascalCase: @IsTest |

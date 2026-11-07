# Security scan: TKT-064

Change: Calculate renewal risk from Cases and activity

- Scanner: Salesforce Code Analyzer 5.16.0
- Rules: Recommended, Security, AppExchange with the `bank-v1` severity profile (code-analyzer.yml)
- Graph Engine: off
- Policy: block at High or worse, enforced
- Scanned: 2026-11-07T21:47:06.487Z · 5 files · 5 s
- Result: **passed** · Critical 0 · High 0 · Moderate 2 · Low 12 · Info 0

| # | Severity | Engine | Rule | File | Line | Message |
|---|---|---|---|---|---|---|
| 1 | Moderate | pmd | [CyclomaticComplexity](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_design.html#cyclomaticcomplexity) | `force-app/main/default/classes/RenewalRiskScoringBatch.cls` | 12 | The method 'execute(Database.BatchableContext, List<Account>)' has a cyclomatic complexity of 10. |
| 2 | Moderate | pmd | [EmptyStatementBlock](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_errorprone.html#emptystatementblock) | `force-app/main/default/classes/RenewalRiskScoringBatch.cls` | 60 | Avoid empty block statements. |
| 3 | Low | pmd | [ApexDoc](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_documentation.html#apexdoc) | `force-app/main/default/classes/RenewalRiskScoringBatch.cls` | 1 | Missing ApexDoc comment |
| 4 | Low | pmd | [ApexDoc](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_documentation.html#apexdoc) | `force-app/main/default/classes/RenewalRiskScoringBatch.cls` | 3 | Missing ApexDoc comment |
| 5 | Low | pmd | [ApexDoc](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_documentation.html#apexdoc) | `force-app/main/default/classes/RenewalRiskScoringBatch.cls` | 12 | Missing ApexDoc comment |
| 6 | Low | pmd | [ApexDoc](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_documentation.html#apexdoc) | `force-app/main/default/classes/RenewalRiskScoringBatch.cls` | 60 | Missing ApexDoc comment |
| 7 | Low | pmd | [ApexDoc](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_documentation.html#apexdoc) | `force-app/main/default/classes/RenewalRiskScoringBatch.cls` | 66 | Missing ApexDoc @return |
| 8 | Low | pmd | [ApexDoc](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_documentation.html#apexdoc) | `force-app/main/default/classes/RenewalRiskScoringBatch.cls` | 66 | Missing or mismatched ApexDoc @param |
| 9 | Low | pmd | [AvoidNonRestrictiveQueries](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_performance.html#avoidnonrestrictivequeries) | `force-app/main/default/classes/RenewalRiskScoringBatch.cls` | 95 | Avoid SOQL queries without a where or limit statement |
| 10 | Low | pmd | [AnnotationsNamingConventions](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_codestyle.html#annotationsnamingconventions) | `force-app/main/default/classes/RenewalRiskScoringBatchTest.cls` | 1 | The annotation @isTest should be in PascalCase: @IsTest |
| 11 | Low | pmd | [AnnotationsNamingConventions](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_codestyle.html#annotationsnamingconventions) | `force-app/main/default/classes/RenewalRiskScoringBatchTest.cls` | 13 | The annotation @isTest should be in PascalCase: @IsTest |
| 12 | Low | pmd | [ApexUnitTestClassShouldHaveRunAs](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_bestpractices.html#apexunittestclassshouldhaverunas) | `force-app/main/default/classes/RenewalRiskScoringBatchTest.cls` | 14 | Apex unit test classes should have at least one System.runAs() call |
| 13 | Low | pmd | [AnnotationsNamingConventions](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_codestyle.html#annotationsnamingconventions) | `force-app/main/default/classes/RenewalRiskScoringBatchTest.cls` | 72 | The annotation @isTest should be in PascalCase: @IsTest |
| 14 | Low | pmd | [ApexUnitTestClassShouldHaveRunAs](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_bestpractices.html#apexunittestclassshouldhaverunas) | `force-app/main/default/classes/RenewalRiskScoringBatchTest.cls` | 73 | Apex unit test classes should have at least one System.runAs() call |

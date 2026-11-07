# Security scan: TKT-078

Change: Fix the Northstar risk-scoring tests for UAT: RenewalRiskScoringBatchTest and RenewalRiskSchedulerTest must create a test user with the Customer_Success_Manager permission set and run the batch and scheduler inside System.runAs, because WITH USER_MODE queries fail where the deploying admin has no field access (UAT check-only R-0004: No such column Status__c on Renewal__c). Keep coverage at 90% or more.

- Scanner: Salesforce Code Analyzer 5.16.0
- Rules: Recommended, Security, AppExchange with the `bank-v1` severity profile (code-analyzer.yml)
- Graph Engine: off
- Policy: block at High or worse, enforced
- Scanned: 2026-11-07T22:35:02.643Z · 5 files · 5 s
- Result: **passed** · Critical 0 · High 0 · Moderate 1 · Low 7 · Info 1

| # | Severity | Engine | Rule | File | Line | Message |
|---|---|---|---|---|---|---|
| 1 | Moderate | pmd | [ExcessiveParameterList](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_design.html#excessiveparameterlist) | `force-app/main/default/classes/RenewalRiskScoringBatchTest.cls` | 26 | Avoid long parameter lists (4 parameters - threshold is 4). |
| 2 | Low | pmd | [AnnotationsNamingConventions](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_codestyle.html#annotationsnamingconventions) | `force-app/main/default/classes/RenewalRiskSchedulerTest.cls` | 1 | The annotation @isTest should be in PascalCase: @IsTest |
| 3 | Low | pmd | [AnnotationsNamingConventions](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_codestyle.html#annotationsnamingconventions) | `force-app/main/default/classes/RenewalRiskSchedulerTest.cls` | 26 | The annotation @isTest should be in PascalCase: @IsTest |
| 4 | Low | pmd | [AnnotationsNamingConventions](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_codestyle.html#annotationsnamingconventions) | `force-app/main/default/classes/RenewalRiskSchedulerTest.cls` | 39 | The annotation @isTest should be in PascalCase: @IsTest |
| 5 | Low | pmd | [AnnotationsNamingConventions](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_codestyle.html#annotationsnamingconventions) | `force-app/main/default/classes/RenewalRiskSchedulerTest.cls` | 54 | The annotation @isTest should be in PascalCase: @IsTest |
| 6 | Low | pmd | [AnnotationsNamingConventions](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_codestyle.html#annotationsnamingconventions) | `force-app/main/default/classes/RenewalRiskScoringBatchTest.cls` | 1 | The annotation @isTest should be in PascalCase: @IsTest |
| 7 | Low | pmd | [AnnotationsNamingConventions](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_codestyle.html#annotationsnamingconventions) | `force-app/main/default/classes/RenewalRiskScoringBatchTest.cls` | 35 | The annotation @isTest should be in PascalCase: @IsTest |
| 8 | Low | pmd | [AnnotationsNamingConventions](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_codestyle.html#annotationsnamingconventions) | `force-app/main/default/classes/RenewalRiskScoringBatchTest.cls` | 99 | The annotation @isTest should be in PascalCase: @IsTest |
| 9 | Info | cpd | [DetectCopyPasteForApex](https://docs.pmd-code.org/latest/pmd_userdocs_cpd.html#refactoring-duplicates) | `force-app/main/default/classes/RenewalRiskSchedulerTest.cls` | 2 | Duplicate code detected for language 'apex'. Found 2 code locations containing the same block of code consisting of 147 tokens across 23 lines. |

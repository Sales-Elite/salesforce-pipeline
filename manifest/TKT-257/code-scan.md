# Security scan: TKT-257

Change: LT15D Every hour, set Lead Description to 'checked' with a scheduled Apex job

- Scanner: Salesforce Code Analyzer 5.16.0
- Rules: Recommended, Security, AppExchange with the `bank-v1` severity profile (code-analyzer.yml)
- Graph Engine: off
- Policy: block at High or worse, enforced
- Scanned: 2026-11-14T16:42:55.406Z · 4 files · 6 s
- Result: **passed** · Critical 0 · High 0 · Moderate 1 · Low 10 · Info 0

| # | Severity | Engine | Rule | File | Line | Message |
|---|---|---|---|---|---|---|
| 1 | Moderate | pmd | [EmptyStatementBlock](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_errorprone.html#emptystatementblock) | `force-app/main/default/classes/LT15D_LeadCheckedJob.cls` | 25 | Avoid empty block statements. |
| 2 | Low | pmd | [ApexDoc](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_documentation.html#apexdoc) | `force-app/main/default/classes/LT15D_LeadCheckedJob.cls` | 1 | Missing ApexDoc comment |
| 3 | Low | pmd | [ApexDoc](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_documentation.html#apexdoc) | `force-app/main/default/classes/LT15D_LeadCheckedJob.cls` | 4 | Missing ApexDoc comment |
| 4 | Low | pmd | [ApexDoc](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_documentation.html#apexdoc) | `force-app/main/default/classes/LT15D_LeadCheckedJob.cls` | 8 | Missing ApexDoc comment |
| 5 | Low | pmd | [ApexDoc](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_documentation.html#apexdoc) | `force-app/main/default/classes/LT15D_LeadCheckedJob.cls` | 12 | Missing ApexDoc comment |
| 6 | Low | pmd | [ApexDoc](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_documentation.html#apexdoc) | `force-app/main/default/classes/LT15D_LeadCheckedJob.cls` | 25 | Missing ApexDoc comment |
| 7 | Low | pmd | [AnnotationsNamingConventions](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_codestyle.html#annotationsnamingconventions) | `force-app/main/default/classes/LT15D_LeadCheckedJobTest.cls` | 1 | The annotation @isTest should be in PascalCase: @IsTest |
| 8 | Low | pmd | [AnnotationsNamingConventions](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_codestyle.html#annotationsnamingconventions) | `force-app/main/default/classes/LT15D_LeadCheckedJobTest.cls` | 3 | The annotation @isTest should be in PascalCase: @IsTest |
| 9 | Low | pmd | [ApexUnitTestClassShouldHaveRunAs](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_bestpractices.html#apexunittestclassshouldhaverunas) | `force-app/main/default/classes/LT15D_LeadCheckedJobTest.cls` | 4 | Apex unit test classes should have at least one System.runAs() call |
| 10 | Low | pmd | [AnnotationsNamingConventions](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_codestyle.html#annotationsnamingconventions) | `force-app/main/default/classes/LT15D_LeadCheckedJobTest.cls` | 12 | The annotation @isTest should be in PascalCase: @IsTest |
| 11 | Low | pmd | [ApexUnitTestClassShouldHaveRunAs](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_bestpractices.html#apexunittestclassshouldhaverunas) | `force-app/main/default/classes/LT15D_LeadCheckedJobTest.cls` | 13 | Apex unit test classes should have at least one System.runAs() call |

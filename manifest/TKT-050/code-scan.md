# Security scan: TKT-050

Change: Build the manager dashboard for backlog, breaches and first response

- Scanner: Salesforce Code Analyzer 5.16.0
- Rules: Recommended, Security, AppExchange with the `bank-v1` severity profile (code-analyzer.yml)
- Graph Engine: off
- Policy: block at High or worse, enforced
- Scanned: 2026-11-15T06:29:16.591Z · 26 files · 6 s
- Result: **passed** · Critical 0 · High 0 · Moderate 0 · Low 20 · Info 0

| # | Severity | Engine | Rule | File | Line | Message |
|---|---|---|---|---|---|---|
| 1 | Low | pmd | [AnnotationsNamingConventions](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_codestyle.html#annotationsnamingconventions) | `force-app/main/default/classes/CaseFirstResponseCaptureTest.cls` | 1 | The annotation @isTest should be in PascalCase: @IsTest |
| 2 | Low | pmd | [AnnotationsNamingConventions](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_codestyle.html#annotationsnamingconventions) | `force-app/main/default/classes/CaseFirstResponseCaptureTest.cls` | 3 | The annotation @isTest should be in PascalCase: @IsTest |
| 3 | Low | pmd | [ApexUnitTestClassShouldHaveRunAs](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_bestpractices.html#apexunittestclassshouldhaverunas) | `force-app/main/default/classes/CaseFirstResponseCaptureTest.cls` | 4 | Apex unit test classes should have at least one System.runAs() call |
| 4 | Low | pmd | [ApexDoc](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_documentation.html#apexdoc) | `force-app/main/default/classes/ServiceDashboardRefresh.cls` | 1 | Missing ApexDoc comment |
| 5 | Low | pmd | [ApexDoc](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_documentation.html#apexdoc) | `force-app/main/default/classes/ServiceDashboardRefresh.cls` | 3 | Missing ApexDoc comment |
| 6 | Low | pmd | [AvoidDebugStatements](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_performance.html#avoiddebugstatements) | `force-app/main/default/classes/ServiceDashboardRefresh.cls` | 20 | Avoid debug statements since they impact on performance |
| 7 | Low | pmd | [ApexDoc](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_documentation.html#apexdoc) | `force-app/main/default/classes/ServiceDashboardRefresh.cls` | 25 | Missing ApexDoc comment |
| 8 | Low | pmd | [ApexDoc](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_documentation.html#apexdoc) | `force-app/main/default/classes/ServiceDashboardRefresh.cls` | 27 | Missing ApexDoc comment |
| 9 | Low | pmd | [ApexDoc](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_documentation.html#apexdoc) | `force-app/main/default/classes/ServiceDashboardRefresh.cls` | 30 | Missing ApexDoc comment |
| 10 | Low | pmd | [QueueableWithoutFinalizer](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_bestpractices.html#queueablewithoutfinalizer) | `force-app/main/default/classes/ServiceDashboardRefresh.cls` | 30 | This Queueable doesnt attach a Finalizer |
| 11 | Low | pmd | [AvoidDebugStatements](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_performance.html#avoiddebugstatements) | `force-app/main/default/classes/ServiceDashboardRefresh.cls` | 34 | Avoid debug statements since they impact on performance |
| 12 | Low | pmd | [AvoidDebugStatements](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_performance.html#avoiddebugstatements) | `force-app/main/default/classes/ServiceDashboardRefresh.cls` | 41 | Avoid debug statements since they impact on performance |
| 13 | Low | pmd | [AnnotationsNamingConventions](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_codestyle.html#annotationsnamingconventions) | `force-app/main/default/classes/ServiceDashboardRefreshTest.cls` | 1 | The annotation @isTest should be in PascalCase: @IsTest |
| 14 | Low | pmd | [ApexDoc](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_documentation.html#apexdoc) | `force-app/main/default/classes/ServiceDashboardRefreshTest.cls` | 8 | Missing ApexDoc comment |
| 15 | Low | pmd | [AnnotationsNamingConventions](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_codestyle.html#annotationsnamingconventions) | `force-app/main/default/classes/ServiceDashboardRefreshTest.cls` | 16 | The annotation @isTest should be in PascalCase: @IsTest |
| 16 | Low | pmd | [ApexUnitTestClassShouldHaveRunAs](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_bestpractices.html#apexunittestclassshouldhaverunas) | `force-app/main/default/classes/ServiceDashboardRefreshTest.cls` | 17 | Apex unit test classes should have at least one System.runAs() call |
| 17 | Low | pmd | [AnnotationsNamingConventions](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_codestyle.html#annotationsnamingconventions) | `force-app/main/default/classes/ServiceDashboardRefreshTest.cls` | 25 | The annotation @isTest should be in PascalCase: @IsTest |
| 18 | Low | pmd | [ApexUnitTestClassShouldHaveRunAs](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_bestpractices.html#apexunittestclassshouldhaverunas) | `force-app/main/default/classes/ServiceDashboardRefreshTest.cls` | 26 | Apex unit test classes should have at least one System.runAs() call |
| 19 | Low | pmd | [AnnotationsNamingConventions](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_codestyle.html#annotationsnamingconventions) | `force-app/main/default/classes/ServiceDashboardRefreshTest.cls` | 34 | The annotation @isTest should be in PascalCase: @IsTest |
| 20 | Low | pmd | [ApexUnitTestClassShouldHaveRunAs](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_bestpractices.html#apexunittestclassshouldhaverunas) | `force-app/main/default/classes/ServiceDashboardRefreshTest.cls` | 35 | Apex unit test classes should have at least one System.runAs() call |

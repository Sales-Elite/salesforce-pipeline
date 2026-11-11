# Security scan: TKT-293

Change: LT15S Callout: Named Credential to httpbin.org with an Apex client, log object and mocked tests

- Scanner: Salesforce Code Analyzer 5.16.0
- Rules: Recommended, Security, AppExchange with the `bank-v1` severity profile (code-analyzer.yml)
- Graph Engine: off
- Policy: block at High or worse, enforced
- Scanned: 2026-11-11T08:57:15.125Z · 17 files · 5 s
- Result: **passed** · Critical 0 · High 0 · Moderate 0 · Low 18 · Info 0

| # | Severity | Engine | Rule | File | Line | Message |
|---|---|---|---|---|---|---|
| 1 | Low | pmd | [ApexDoc](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_documentation.html#apexdoc) | `force-app/main/default/classes/LT15S_HttpBinClient.cls` | 1 | Missing ApexDoc comment |
| 2 | Low | pmd | [ApexDoc](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_documentation.html#apexdoc) | `force-app/main/default/classes/LT15S_HttpBinClient.cls` | 2 | Missing ApexDoc comment |
| 3 | Low | pmd | [ApexDoc](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_documentation.html#apexdoc) | `force-app/main/default/classes/LT15S_HttpBinClient.cls` | 10 | Missing ApexDoc comment |
| 4 | Low | pmd | [AnnotationsNamingConventions](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_codestyle.html#annotationsnamingconventions) | `force-app/main/default/classes/LT15S_HttpBinClientTest.cls` | 1 | The annotation @isTest should be in PascalCase: @IsTest |
| 5 | Low | pmd | [ApexDoc](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_documentation.html#apexdoc) | `force-app/main/default/classes/LT15S_HttpBinClientTest.cls` | 8 | Missing ApexDoc comment |
| 6 | Low | pmd | [AnnotationsNamingConventions](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_codestyle.html#annotationsnamingconventions) | `force-app/main/default/classes/LT15S_HttpBinClientTest.cls` | 17 | The annotation @isTest should be in PascalCase: @IsTest |
| 7 | Low | pmd | [ApexUnitTestClassShouldHaveRunAs](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_bestpractices.html#apexunittestclassshouldhaverunas) | `force-app/main/default/classes/LT15S_HttpBinClientTest.cls` | 18 | Apex unit test classes should have at least one System.runAs() call |
| 8 | Low | pmd | [AnnotationsNamingConventions](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_codestyle.html#annotationsnamingconventions) | `force-app/main/default/classes/LT15S_HttpBinClientTest.cls` | 29 | The annotation @isTest should be in PascalCase: @IsTest |
| 9 | Low | pmd | [ApexUnitTestClassShouldHaveRunAs](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_bestpractices.html#apexunittestclassshouldhaverunas) | `force-app/main/default/classes/LT15S_HttpBinClientTest.cls` | 30 | Apex unit test classes should have at least one System.runAs() call |
| 10 | Low | pmd | [AnnotationsNamingConventions](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_codestyle.html#annotationsnamingconventions) | `force-app/main/default/classes/LT15S_HttpBinClientTest.cls` | 40 | The annotation @isTest should be in PascalCase: @IsTest |
| 11 | Low | pmd | [ApexUnitTestClassShouldHaveRunAs](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_bestpractices.html#apexunittestclassshouldhaverunas) | `force-app/main/default/classes/LT15S_HttpBinClientTest.cls` | 41 | Apex unit test classes should have at least one System.runAs() call |
| 12 | Low | pmd | [AnnotationsNamingConventions](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_codestyle.html#annotationsnamingconventions) | `force-app/main/default/classes/LT15S_HttpBinClientTest.cls` | 50 | The annotation @isTest should be in PascalCase: @IsTest |
| 13 | Low | pmd | [ApexUnitTestClassShouldHaveRunAs](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_bestpractices.html#apexunittestclassshouldhaverunas) | `force-app/main/default/classes/LT15S_HttpBinClientTest.cls` | 51 | Apex unit test classes should have at least one System.runAs() call |
| 14 | Low | pmd | [ApexDoc](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_documentation.html#apexdoc) | `force-app/main/default/classes/LT15S_HttpBinJob.cls` | 1 | Missing ApexDoc comment |
| 15 | Low | pmd | [ApexDoc](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_documentation.html#apexdoc) | `force-app/main/default/classes/LT15S_HttpBinJob.cls` | 2 | Missing ApexDoc comment |
| 16 | Low | pmd | [ApexDoc](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_documentation.html#apexdoc) | `force-app/main/default/classes/LT15S_HttpBinJob.cls` | 4 | Missing ApexDoc comment |
| 17 | Low | pmd | [ApexDoc](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_documentation.html#apexdoc) | `force-app/main/default/classes/LT15S_HttpBinJob.cls` | 8 | Missing ApexDoc comment |
| 18 | Low | pmd | [QueueableWithoutFinalizer](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_bestpractices.html#queueablewithoutfinalizer) | `force-app/main/default/classes/LT15S_HttpBinJob.cls` | 8 | This Queueable doesnt attach a Finalizer |

# Security scan: TKT-421

Change: N5: Campaign trigger defaults Status to Planned

- Scanner: Salesforce Code Analyzer 5.16.0
- Rules: Recommended, Security, AppExchange with the `bank-v1` severity profile (code-analyzer.yml)
- Graph Engine: off
- Policy: block at High or worse, enforced
- Scanned: 2026-11-18T06:25:47.054Z · 6 files · 6 s
- Result: **passed** · Critical 0 · High 0 · Moderate 0 · Low 11 · Info 0

| # | Severity | Engine | Rule | File | Line | Message |
|---|---|---|---|---|---|---|
| 1 | Low | pmd | [ApexDoc](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_documentation.html#apexdoc) | `force-app/main/default/classes/N5_CampaignTriggerHandler.cls` | 1 | Missing ApexDoc comment |
| 2 | Low | pmd | [ApexDoc](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_documentation.html#apexdoc) | `force-app/main/default/classes/N5_CampaignTriggerHandler.cls` | 2 | Missing ApexDoc comment |
| 3 | Low | pmd | [AnnotationsNamingConventions](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_codestyle.html#annotationsnamingconventions) | `force-app/main/default/classes/N5_CampaignTriggerHandlerTest.cls` | 1 | The annotation @isTest should be in PascalCase: @IsTest |
| 4 | Low | pmd | [AnnotationsNamingConventions](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_codestyle.html#annotationsnamingconventions) | `force-app/main/default/classes/N5_CampaignTriggerHandlerTest.cls` | 3 | The annotation @isTest should be in PascalCase: @IsTest |
| 5 | Low | pmd | [ApexUnitTestClassShouldHaveRunAs](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_bestpractices.html#apexunittestclassshouldhaverunas) | `force-app/main/default/classes/N5_CampaignTriggerHandlerTest.cls` | 4 | Apex unit test classes should have at least one System.runAs() call |
| 6 | Low | pmd | [AnnotationsNamingConventions](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_codestyle.html#annotationsnamingconventions) | `force-app/main/default/classes/N5_CampaignTriggerHandlerTest.cls` | 10 | The annotation @isTest should be in PascalCase: @IsTest |
| 7 | Low | pmd | [ApexUnitTestClassShouldHaveRunAs](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_bestpractices.html#apexunittestclassshouldhaverunas) | `force-app/main/default/classes/N5_CampaignTriggerHandlerTest.cls` | 11 | Apex unit test classes should have at least one System.runAs() call |
| 8 | Low | pmd | [AnnotationsNamingConventions](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_codestyle.html#annotationsnamingconventions) | `force-app/main/default/classes/N5_CampaignTriggerHandlerTest.cls` | 22 | The annotation @isTest should be in PascalCase: @IsTest |
| 9 | Low | pmd | [ApexUnitTestClassShouldHaveRunAs](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_bestpractices.html#apexunittestclassshouldhaverunas) | `force-app/main/default/classes/N5_CampaignTriggerHandlerTest.cls` | 23 | Apex unit test classes should have at least one System.runAs() call |
| 10 | Low | pmd | [AnnotationsNamingConventions](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_codestyle.html#annotationsnamingconventions) | `force-app/main/default/classes/N5_CampaignTriggerHandlerTest.cls` | 29 | The annotation @isTest should be in PascalCase: @IsTest |
| 11 | Low | pmd | [ApexUnitTestClassShouldHaveRunAs](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_bestpractices.html#apexunittestclassshouldhaverunas) | `force-app/main/default/classes/N5_CampaignTriggerHandlerTest.cls` | 30 | Apex unit test classes should have at least one System.runAs() call |

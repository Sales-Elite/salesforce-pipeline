# Security scan: TKT-398

Change: MCP demo: Account "Open Pipeline" Lightning component

- Scanner: Salesforce Code Analyzer 5.16.0
- Rules: Recommended, Security, AppExchange with the `bank-v1` severity profile (code-analyzer.yml)
- Graph Engine: off
- Policy: block at High or worse, enforced
- Scanned: 2026-11-17T15:21:52.283Z · 8 files · 7 s
- Result: **passed** · Critical 0 · High 0 · Moderate 0 · Low 8 · Info 0

| # | Severity | Engine | Rule | File | Line | Message |
|---|---|---|---|---|---|---|
| 1 | Low | pmd | [ApexDoc](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_documentation.html#apexdoc) | `force-app/main/default/classes/MCP_OpenPipelineController.cls` | 1 | Missing ApexDoc comment |
| 2 | Low | pmd | [ApexDoc](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_documentation.html#apexdoc) | `force-app/main/default/classes/MCP_OpenPipelineController.cls` | 3 | Missing ApexDoc comment |
| 3 | Low | pmd | [AnnotationsNamingConventions](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_codestyle.html#annotationsnamingconventions) | `force-app/main/default/classes/MCP_OpenPipelineControllerTest.cls` | 1 | The annotation @isTest should be in PascalCase: @IsTest |
| 4 | Low | pmd | [AnnotationsNamingConventions](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_codestyle.html#annotationsnamingconventions) | `force-app/main/default/classes/MCP_OpenPipelineControllerTest.cls` | 3 | The annotation @isTest should be in PascalCase: @IsTest |
| 5 | Low | pmd | [ApexUnitTestClassShouldHaveRunAs](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_bestpractices.html#apexunittestclassshouldhaverunas) | `force-app/main/default/classes/MCP_OpenPipelineControllerTest.cls` | 4 | Apex unit test classes should have at least one System.runAs() call |
| 6 | Low | pmd | [AnnotationsNamingConventions](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_codestyle.html#annotationsnamingconventions) | `force-app/main/default/classes/MCP_OpenPipelineControllerTest.cls` | 22 | The annotation @isTest should be in PascalCase: @IsTest |
| 7 | Low | pmd | [ApexUnitTestClassShouldHaveRunAs](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_bestpractices.html#apexunittestclassshouldhaverunas) | `force-app/main/default/classes/MCP_OpenPipelineControllerTest.cls` | 23 | Apex unit test classes should have at least one System.runAs() call |
| 8 | Low | pmd | [AnnotationsNamingConventions](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_codestyle.html#annotationsnamingconventions) | `force-app/main/default/classes/MCP_OpenPipelineControllerTest.cls` | 29 | The annotation @isTest should be in PascalCase: @IsTest |

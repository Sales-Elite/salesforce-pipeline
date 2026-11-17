# Security scan: TKT-408

Change: MCP night W4-3: Platform event for order signals with a subscriber trigger

- Scanner: Salesforce Code Analyzer 5.16.0
- Rules: Recommended, Security, AppExchange with the `bank-v1` severity profile (code-analyzer.yml)
- Graph Engine: off
- Policy: block at High or worse, enforced
- Scanned: 2026-11-17T18:47:13.204Z · 12 files · 6 s
- Result: **passed** · Critical 0 · High 0 · Moderate 2 · Low 13 · Info 0

| # | Severity | Engine | Rule | File | Line | Message |
|---|---|---|---|---|---|---|
| 1 | Moderate | pmd | [CognitiveComplexity](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_design.html#cognitivecomplexity) | `force-app/main/default/classes/MCPN_OrderSignalHandler.cls` | 2 | The method 'handleAfterInsert(List<MCPN_Order_Signal__e>)' has a cognitive complexity of 17, current threshold is 15 |
| 2 | Moderate | pmd | [CyclomaticComplexity](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_design.html#cyclomaticcomplexity) | `force-app/main/default/classes/MCPN_OrderSignalHandler.cls` | 2 | The method 'handleAfterInsert(List<MCPN_Order_Signal__e>)' has a cyclomatic complexity of 11. |
| 3 | Low | pmd | [ApexDoc](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_documentation.html#apexdoc) | `force-app/main/default/classes/MCPN_OrderSignalHandler.cls` | 1 | Missing ApexDoc comment |
| 4 | Low | pmd | [ApexDoc](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_documentation.html#apexdoc) | `force-app/main/default/classes/MCPN_OrderSignalHandler.cls` | 2 | Missing ApexDoc comment |
| 5 | Low | pmd | [ApexDoc](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_documentation.html#apexdoc) | `force-app/main/default/classes/MCPN_OrderSignalPublisher.cls` | 1 | Missing ApexDoc comment |
| 6 | Low | pmd | [ApexDoc](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_documentation.html#apexdoc) | `force-app/main/default/classes/MCPN_OrderSignalPublisher.cls` | 2 | Missing ApexDoc comment |
| 7 | Low | pmd | [AnnotationsNamingConventions](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_codestyle.html#annotationsnamingconventions) | `force-app/main/default/classes/MCPN_OrderSignalTest.cls` | 1 | The annotation @isTest should be in PascalCase: @IsTest |
| 8 | Low | pmd | [AnnotationsNamingConventions](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_codestyle.html#annotationsnamingconventions) | `force-app/main/default/classes/MCPN_OrderSignalTest.cls` | 3 | The annotation @isTest should be in PascalCase: @IsTest |
| 9 | Low | pmd | [ApexUnitTestClassShouldHaveRunAs](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_bestpractices.html#apexunittestclassshouldhaverunas) | `force-app/main/default/classes/MCPN_OrderSignalTest.cls` | 3 | Apex unit test classes should have at least one System.runAs() call |
| 10 | Low | pmd | [AnnotationsNamingConventions](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_codestyle.html#annotationsnamingconventions) | `force-app/main/default/classes/MCPN_OrderSignalTest.cls` | 17 | The annotation @isTest should be in PascalCase: @IsTest |
| 11 | Low | pmd | [ApexUnitTestClassShouldHaveRunAs](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_bestpractices.html#apexunittestclassshouldhaverunas) | `force-app/main/default/classes/MCPN_OrderSignalTest.cls` | 17 | Apex unit test classes should have at least one System.runAs() call |
| 12 | Low | pmd | [AnnotationsNamingConventions](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_codestyle.html#annotationsnamingconventions) | `force-app/main/default/classes/MCPN_OrderSignalTest.cls` | 28 | The annotation @isTest should be in PascalCase: @IsTest |
| 13 | Low | pmd | [ApexUnitTestClassShouldHaveRunAs](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_bestpractices.html#apexunittestclassshouldhaverunas) | `force-app/main/default/classes/MCPN_OrderSignalTest.cls` | 28 | Apex unit test classes should have at least one System.runAs() call |
| 14 | Low | pmd | [AnnotationsNamingConventions](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_codestyle.html#annotationsnamingconventions) | `force-app/main/default/classes/MCPN_OrderSignalTest.cls` | 44 | The annotation @isTest should be in PascalCase: @IsTest |
| 15 | Low | pmd | [ApexUnitTestClassShouldHaveRunAs](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_bestpractices.html#apexunittestclassshouldhaverunas) | `force-app/main/default/classes/MCPN_OrderSignalTest.cls` | 44 | Apex unit test classes should have at least one System.runAs() call |

# Security scan: TKT-388

Change: When a Case is escalated, automatically create a follow-up Task for the case owner, due tomorrow, with the subject Escalation follow-up and the case number in the description.

- Scanner: Salesforce Code Analyzer 5.16.0
- Rules: Recommended, Security, AppExchange with the `bank-v1` severity profile (code-analyzer.yml)
- Graph Engine: off
- Policy: block at High or worse, enforced
- Scanned: 2026-11-15T12:36:07.644Z · 3 files · 6 s
- Result: **passed** · Critical 0 · High 0 · Moderate 0 · Low 5 · Info 0

| # | Severity | Engine | Rule | File | Line | Message |
|---|---|---|---|---|---|---|
| 1 | Low | pmd | [AnnotationsNamingConventions](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_codestyle.html#annotationsnamingconventions) | `force-app/main/default/classes/CaseEscFollowUpTaskTest.cls` | 1 | The annotation @isTest should be in PascalCase: @IsTest |
| 2 | Low | pmd | [AnnotationsNamingConventions](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_codestyle.html#annotationsnamingconventions) | `force-app/main/default/classes/CaseEscFollowUpTaskTest.cls` | 11 | The annotation @isTest should be in PascalCase: @IsTest |
| 3 | Low | pmd | [ApexUnitTestClassShouldHaveRunAs](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_bestpractices.html#apexunittestclassshouldhaverunas) | `force-app/main/default/classes/CaseEscFollowUpTaskTest.cls` | 11 | Apex unit test classes should have at least one System.runAs() call |
| 4 | Low | pmd | [AnnotationsNamingConventions](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_codestyle.html#annotationsnamingconventions) | `force-app/main/default/classes/CaseEscFollowUpTaskTest.cls` | 25 | The annotation @isTest should be in PascalCase: @IsTest |
| 5 | Low | pmd | [ApexUnitTestClassShouldHaveRunAs](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_bestpractices.html#apexunittestclassshouldhaverunas) | `force-app/main/default/classes/CaseEscFollowUpTaskTest.cls` | 25 | Apex unit test classes should have at least one System.runAs() call |

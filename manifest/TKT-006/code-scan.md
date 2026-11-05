# Security scan: TKT-006

Change: Onboarding Case when Opportunity is Closed Won

- Scanner: Salesforce Code Analyzer 5.16.0
- Rules: Recommended, Security, AppExchange with the `bank-v1` severity profile (code-analyzer.yml)
- Graph Engine: off
- Policy: block at High or worse, enforced
- Scanned: 2026-11-05T13:15:06.427Z · 7 files · 5 s
- Result: **passed** · Critical 0 · High 0 · Moderate 0 · Low 3 · Info 0

| # | Severity | Engine | Rule | File | Line | Message |
|---|---|---|---|---|---|---|
| 1 | Low | pmd | [AnnotationsNamingConventions](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_codestyle.html#annotationsnamingconventions) | `force-app/main/default/classes/OppClosedWonOnboardingCaseTest.cls` | 1 | The annotation @isTest should be in PascalCase: @IsTest |
| 2 | Low | pmd | [AnnotationsNamingConventions](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_codestyle.html#annotationsnamingconventions) | `force-app/main/default/classes/OppClosedWonOnboardingCaseTest.cls` | 3 | The annotation @isTest should be in PascalCase: @IsTest |
| 3 | Low | pmd | [ApexUnitTestClassShouldHaveRunAs](https://docs.pmd-code.org/pmd-doc-7.26.0/pmd_rules_apex_bestpractices.html#apexunittestclassshouldhaverunas) | `force-app/main/default/classes/OppClosedWonOnboardingCaseTest.cls` | 4 | Apex unit test classes should have at least one System.runAs() call |

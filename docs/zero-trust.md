# Zero Trust – Identity Enforcement with Conditional Access

## Control Objective

Enforce multifactor authentication (MFA) for cloud access in alignment with Zero Trust identity verification principles.

## Policy Architecture

Scope Definition

- Included principals
  - Dedicated lab test user or scoped group.
- Excluded principals
  - Emergency / break-glass administrative account

Exclusions are intentionally minimal to preserve recovery capability.

## Targeted Resources

- Microsoft cloud applications relevant to the lab access scenario.
- Scope intentionally limited to defined cloud applications to prevent over-broad enforcement during validation.

## Grant Controls

- Require multifactor authentication (MFA).
- Block access if MFA challenge fails.

## Session & Risk Controls

- Default session controls retained unless testing adaptive risk-based policies.
- Risk-based Conditional Access not enabled in this lab iteration.

## Validation Workflow

1. Deploy policy in Report-Only mode (if available).
2. Simulate sign-in using included test user.
3. Confirm MFA challenge is enforced.
4. Review Entra sign-in logs to confirm policy evaluation and MFA enforcement.
5. Validate excluded emergency account path.
6. Transition policy to On after successful validation.

This process ensures enforcement without accidental tenant lockout.

## Identity Telemetry Validation

Confirm the following log artifacts:

- Sign-in events recorded in Entra ID.
- Conditional Access policy evaluation status.
- MFA requirement satisfied flag.
- Authentication details reflecting second factor.

This validates that identity telemetry supports detection engineering workflows.

## Rollback Procedure

From the Entra Conditional Access policy interface:

1. Switch policy to Report-Only or Disabled.
2. Validate administrative access continuity.
3. Re-test included user path.
4. Adjust scope or grant controls as needed.
5. Re-enable under controlled change.

Rollback steps are documented to prevent production tenant lockout scenarios.

## Operational Security Considerations

- Maintain at least one governed break-glass account.
- Protect emergency credentials with offline storage and access logging.
- Periodically review exclusion scope.
- Avoid publishing:
  - Tenant identifiers
  - User UPNs
  - Policy IDs
  - Environment-specific configuration artifacts

## Operational Outcome

This control demonstrates identity-first enforcement aligned with Zero Trust architecture.

The policy integrates with endpoint telemetry and Sentinel detection workflows by ensuring identity verification precedes session establishment.

The result is a layered defense model combining:

  - Identity enforcement
  - Endpoint telemetry
  - Analytics rule validation
  - Incident generation
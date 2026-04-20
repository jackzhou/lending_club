# Reviewer notes

## Assumptions

- Customer IDs are numeric; rows without a customer ID are dropped during data cleaning.
- Account IDs are uppercase strings; rows without an account ID are dropped during data cleaning.
- **Balance** is the account balance in dollars.
- An account may have a missing or non-matching customer ID; joins to customers can exclude those rows from the summary.
- The final summary may show nulls for balance-derived metrics when balance is missing.
- Account data may live in a data lake; customer data may live in a local file when volume is small.

## Trade-offs

- Null balances propagate to derived amounts, so some summary columns can look sparse even when dimensions are present.

## Design decisions

- **Dropped rows:** Data cleaning excludes accounts without an account ID and customers without a customer ID.
- **Interest rate:** Defaults to **0** when required inputs for the calculation are missing.
- **Balance-derived metrics:** Values such as annual interest and new balance are **null** when balance is **null** (no imputed balance for downstream math).

## Next steps

- Keep malformed or excluded rows in a quarantine table for analysis and monitoring.
- Consider fixed-point arithmetic for money


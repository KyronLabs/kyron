# Financial frontend implementation contract

No financial UI is included in the ledger foundation migration. This contract is mandatory when Wallet, Buy Coins, Creator Earnings, Bank Accounts, Withdrawals, Transactions or staff finance screens are implemented.

## Source of truth

Read and follow:
- Root `DESIGN_SYSTEM_COMPLIANCE_REPORT.md`.
- `KyronLabs/design-system/frontend/philosophy.md` (mobile visual and interaction rules, including color, spacing and motion).
- `KyronLabs/design-system/frontend/components/buttons.md` (button geometry and shared widgets).
- `KyronLabs/design-system/design-tokens/typography.md`.
- `KyronLabs/design-system/design-tokens/spacing.md`.
- Existing Flutter implementation and package APIs in `app/` and the pinned design-system dependency.

The design-system compliance report is a measured report, not a blanket certificate. It says app-wide touch-target coverage is incomplete and spacing/motion are not comprehensively guarded. Every new financial screen must include its own tests for those dimensions.

## Mandatory visual rules

- Use `kyron_design_system` components, theme and tokens; no second theme or local token system.
- Flat, edge-to-edge page surfaces. Separate content with hairline borders, not elevated cards or shadows.
- Buttons are pills and use shared components. Do not set a custom button height. The visible primary/full-width button is 40 points; ensure the actual interactive target meets the 44×44 minimum.
- Use bottom sheets for confirmation, picker, bank form and withdrawal review flows. No centered Material dialogs.
- Use Iconsax, never Material Icons. Use the shared icon style and semantic color.
- No Material ink ripple. Press states use the shared scale/opacity interaction.
- Typography uses the modular token scale, preserves fractional sizes and uses zero letter spacing.
- Spacing uses the design-system spacing tokens; do not invent arbitrary values.
- Color uses theme semantic colors and the design-system ramps; accent is `primary_500` (`#006AFF`).
- Respect system text scaling, safe areas, dark/light themes and screen readers.

## UX and trust requirements

- Never label coins as money or show an implied fixed conversion.
- Show coin units and fiat currency separately.
- A conversion quote must show rate, gross amount, fees, net amount, expiry and applicable terms before acceptance.
- Show withdrawal state clearly: available, held, reserved, processing, paid, failed or reversed.
- Explain risk/compliance holds in plain language without exposing fraud-rule internals.
- Bank account details must be masked. Never display full account numbers after save.
- Do not imply a payout has completed until the backend confirms settlement.
- Distinguish purchase history, coin movement, creator earnings and fiat payout history.
- Disable purchase/withdrawal affordances when the server says the capability is unavailable; never fake success locally.

## Required tests for every financial screen

- Light and dark theme rendering.
- Semantic colors and token use; no raw UI hex colors or raw `fontSize:` literals.
- No Material Icons or ink ripples.
- Buttons use shared components and documented geometry.
- Every interactive target is at least 44×44.
- Bottom-sheet flows, safe-area behavior and keyboard interaction.
- Loading, empty, error, retry and disabled states.
- Screen-reader labels and currency/coin distinction.
- API authorization and error handling; no client-authoritative financial state.
- Snapshot/measurement tests must be kept honest and updated with any deliberate exceptions.

Do not claim complete design-system compliance from static source checks alone. Follow the root compliance report's distinction between measured, guarded, unguarded and deliberate exceptions.

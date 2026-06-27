# Auth Action Cycles — Success / Error / Null / Loading

> **Version:** 1.0.0 · **Generated:** 2026-06-19  
> **Companion:** [`authnavigationmapchecklist.md`](authnavigationmapchecklist.md) · **Authority:** `docs/prdv1.md` §6.1

Every auth action should form a **closed cycle**: user intent → validation → state change or navigation → feedback.

---

## Cycle Legend

| Outcome | Meaning |
|---------|---------|
| **SUCCESS** | User goal achieved; state updated and/or navigated |
| **ERROR** | Validation failure; user sees error + recovery path |
| **NULL/EMPTY** | Missing input; blocked with CTA or message |
| **LOADING** | Async in progress; controls disabled |
| **MOCK** | Local/demo behavior until Supabase auth wired |

---

## Infrastructure Added (v1.0.0)

| Layer | File | Purpose |
|-------|------|--------|
| Auth draft | `auth_session_providers.dart` | Login/forgot identifiers, register account type, OTP resend count |
| Session | `session_providers.dart` | `signIn`, `signInPendingApproval`, `signOut`, `approvedRoles` |
| Locale | `app_providers.dart` | `appLocaleProvider` |
| Role | `app_providers.dart` | `appRoleProvider` |
| Feedback | `utility_mock_feedback.dart` | Error/success snackbars |
| l10n | `app_en.arb` / `app_ar.arb` | Auth validation strings |

---

## P0 — Login & OTP (CLOSED locally)

### Submit login

| Outcome | Behavior |
|---------|----------|
| **SUCCESS** | `submitLogin` stores identifier → navigate `/otp?source=login` |
| **ERROR** | Empty identifier or password → `authLoginRequiredFields` snackbar |
| **Backend** | `POST /auth/login` → OTP or session token |

### Verify OTP (login source)

| Outcome | Behavior |
|---------|----------|
| **SUCCESS** | Valid 6-digit code → `signIn()` → single role: home route; multi-role: `/role-selection` |
| **ERROR** | Invalid code → `authOtpInvalid` snackbar |
| **LOADING** | Verify button disabled during 450ms mock delay |
| **Backend** | `POST /auth/verify-otp` |

### Resend OTP

| Outcome | Behavior |
|---------|----------|
| **SUCCESS** | `resendOtp()` increments count → countdown reset → `authOtpResent` snackbar |
| **NULL** | Countdown active → timer label only |
| **ERROR** | Max 2 attempts → `otpResendLimitReached` message |
| **Backend** | `POST /auth/resend-otp` |

---

## P1 — Register (CLOSED locally)

### Step 1 — account type + credentials

| Outcome | Behavior |
|---------|----------|
| **SUCCESS** | Draft saved → advance to embedded OTP step |
| **ERROR** | Missing fields / unchecked terms → `authRegisterFieldsRequired` |
| **ERROR** | Password mismatch → `authPasswordMismatch` |
| **Backend** | `POST /auth/register` |

### Step 2 — OTP (customer)

| Outcome | Behavior |
|---------|----------|
| **SUCCESS** | Verify → step 3 preferences |
| **SUCCESS** | Step 3 complete → `signIn({customer})` → `/home` |
| **Backend** | Same OTP endpoints |

### Step 2 — OTP (staff / admin owner)

| Outcome | Behavior |
|---------|----------|
| **SUCCESS** | Verify → `signInPendingApproval()` → `/pending-approval` |
| **NULL** | Step 3 skipped for operational types |
| **Backend** | Register + `approve_staff_registration` workflow |

---

## P2 — Forgot Password (CLOSED locally)

### Send reset code

| Outcome | Behavior |
|---------|----------|
| **SUCCESS** | Identifier stored → `/otp?source=forgot` |
| **ERROR** | Empty identifier → `authForgotIdentifierRequired` |
| **Backend** | `POST /auth/forgot-password` |

### Verify OTP (forgot source)

| Outcome | Behavior |
|---------|----------|
| **SUCCESS** | `authPasswordResetSuccess` → auth draft cleared → `/login` |
| **ERROR** | Invalid OTP → `authOtpInvalid` |
| **Backend** | `POST /auth/reset-password` |

### Contact support

| Outcome | Behavior |
|---------|----------|
| **SUCCESS** | Navigate `/support` |
| **Backend** | Support ticket or chat session |

---

## P3 — Role Selection & Session (CLOSED locally)

### Select role portal

| Outcome | Behavior |
|---------|----------|
| **SUCCESS** | Role in `approvedRoles` → set `appRoleProvider` → role home |
| **ERROR** | Role not approved → `roleSelectionNotApproved` |
| **Backend** | Roles from JWT / `user_roles` table |

### Logout (role selection / pending approval)

| Outcome | Behavior |
|---------|----------|
| **SUCCESS** | `signOut` + `authSession.reset` (preserves language) → `/login` |
| **Backend** | `POST /auth/sign-out` |

---

## P4 — Splash & Language (CLOSED locally)

### Splash auto-route

| Outcome | Behavior |
|---------|----------|
| **SUCCESS** | Pending → `/pending-approval` |
| **SUCCESS** | Authenticated → role home |
| **SUCCESS** | Language confirmed → `/login` |
| **SUCCESS** | First launch → `/language` |
| **MOCK** | Fixed 6s delay (branding) |

### Language continue

| Outcome | Behavior |
|---------|----------|
| **SUCCESS** | `confirmLanguage()` + locale already set → `/login` |
| **Backend** | Persist locale to user profile / device storage |

### Guest browse

| Outcome | Behavior |
|---------|----------|
| **SUCCESS** | `AppRole.guest` without session auth → `/home` |
| **NULL** | Guest blocked from checkout paths via route guard |

---

## Remaining MOCK Cycles (Backend Roadmap)

| Screen | Action | Current | Target API |
|--------|--------|---------|------------|
| Login | Credential check | Any non-empty passes | Supabase `signInWithPassword` / magic link |
| OTP | Code validation | Any 6 digits | Supabase OTP verify |
| Register | Profile fields | Local draft only | `auth.users` + profile row |
| Pending approval | Status polling | Static screen | Realtime approval notification |
| Role selection | Role list | All roles shown; gated on tap | JWT claims only |
| Splash | Session restore | In-memory Riverpod | Secure storage + refresh token |

---

## QA Matrix

- [ ] Empty login blocked with error feedback
- [ ] OTP requires 6 digits
- [ ] Customer register reaches `/home`
- [ ] Staff register reaches `/pending-approval` without step 3
- [ ] Forgot password returns to login after OTP
- [ ] Unapproved role blocked on role selection
- [ ] Language skip works on second app open (same session)
- [ ] `flutter analyze lib/screens/auth` clean

---

*Navigation map:* [`authnavigationmapchecklist.md`](authnavigationmapchecklist.md)

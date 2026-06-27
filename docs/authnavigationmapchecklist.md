# Auth Navigation Map Checklist

> **Version:** 1.0.0 · **Generated:** 2026-06-19  
> **Source audit:** `lib/screens/auth/` (8 screens) · **Authority:** `docs/prdv1.md` §6.1

Use this document to verify every tappable control on authentication screens.

---

## Legend

| Symbol | Meaning |
|--------|---------|
| ✅ | Real route navigation |
| 🔄 | In-place state change via provider |
| 📋 | Dialog, sheet, or confirmation |
| 🧪 | Mock/demo feedback only |
| ⚙️ | `auth_session_providers.dart` or `session_providers.dart` |

**Routes:** `/`, `/language`, `/login`, `/otp`, `/register`, `/forgot-password`, `/role-selection`, `/pending-approval`

---

## Global Auth Flow

```text
Splash → session? → Home[role] | PendingApproval | languageConfirmed? → Login | Language
Language → confirmLanguage → Login
Login → validate draft → OTP (login)
Login guest → AppRole.guest → /home
Register step 1 → account type + form → OTP (register)
Register OTP → customer step 3 → Home | operational → PendingApproval
Forgot → validate → OTP (forgot) → Login
OTP login → signIn → RoleSelection (multi-role) | Home (single role)
RoleSelection → approved role check → role home
```

---

## P0 Screens — Closed Cycles

### Splash — `/`
| Control | Action |
|---------|--------|
| Auto-navigate (6s) | Pending approval → ✅ `/pending-approval` |
| Auto-navigate | Authenticated → ✅ `homeRouteForRole` |
| Auto-navigate | Language confirmed → ✅ `/login` |
| Auto-navigate | First launch → ✅ `/language` |

### Language Selection — `/language`
| Control | Action |
|---------|--------|
| Arabic card | 🔄 `appLocaleProvider` → `ar` |
| English card | 🔄 `appLocaleProvider` → `en` |
| Continue | ⚙️ `confirmLanguage()` → ✅ `/login` |

### Login — `/login`
| Control | Action |
|---------|--------|
| Login | ⚙️ `submitLogin` → validate → ✅ `/otp?source=login` |
| Login (empty fields) | 🧪 `showError` authLoginRequiredFields |
| Forgot password | ✅ `/forgot-password` |
| Continue as guest | 🔄 `AppRole.guest` → ✅ `/home` |
| Register link | ✅ `/register` |

### OTP Verification — `/otp`
| Control | Action |
|---------|--------|
| Back | ✅ source back route (login / register / forgot) |
| OTP input + Verify | ⚙️ `verifyOtp` (6 digits) → route by source |
| Verify invalid | 🧪 `showError` authOtpInvalid |
| Verify login success | ⚙️ `signIn()` → ✅ `/role-selection` or role home |
| Verify register (customer) | ✅ `/register?step=3` |
| Verify register (ops) | ⚙️ `signInPendingApproval()` → ✅ `/pending-approval` |
| Verify forgot | 🧪 success snackbar → ✅ `/login` |
| Resend code | ⚙️ `resendOtp` → 🧪 success snackbar (max 2) |
| Resend limit | NULL — countdown / limit message |

### Register — `/register`
| Control | Action |
|---------|--------|
| Account type cards | 🔄 `AuthRegisterAccountType` draft |
| Step 1 fields + terms | ⚙️ `submitRegisterStep1` → step 2 |
| Step 1 validation fail | 🧪 `showError` register / password messages |
| Step 2 OTP (embedded) | Same cycle as `/otp` register source |
| Step 3 complete (customer) | ⚙️ `signIn(customer)` → ✅ `/home` |
| Login link | ✅ `/login` |
| Back from step 2/3 | 🔄 decrement step |

### Forgot Password — `/forgot-password`
| Control | Action |
|---------|--------|
| Send code | ⚙️ `submitForgotPassword` → ✅ `/otp?source=forgot` |
| Empty identifier | 🧪 `showError` authForgotIdentifierRequired |
| Back to login | ✅ `/login` |
| Contact support | ✅ `/support` |

### Role Selection — `/role-selection`
| Control | Action |
|---------|--------|
| Logout | ⚙️ `signOut` + `authSession.reset` → ✅ `/login` |
| Notifications | ✅ `/notifications` |
| Role portal cards | ⚙️ `isRoleApprovedForSession` → ✅ role home |
| Unapproved role tap | 🧪 `showError` roleSelectionNotApproved |

### Pending Approval — `/pending-approval`
| Control | Action |
|---------|--------|
| Sign out | ⚙️ `signOut` + `authSession.reset` → ✅ `/login` |

---

## QA Checklist

- [ ] Splash skips language when `languageConfirmed` is true
- [ ] Login blocks empty identifier/password
- [ ] OTP rejects non-6-digit codes
- [ ] Customer register completes at `/home`
- [ ] Staff/admin register lands on `/pending-approval`
- [ ] Forgot-password OTP returns to login with success feedback
- [ ] Role selection blocks roles not in `session.approvedRoles`
- [ ] Guest login bypasses auth session
- [ ] `flutter analyze lib/screens/auth` passes

---

*Companion:* [`authactioncycles.md`](authactioncycles.md)

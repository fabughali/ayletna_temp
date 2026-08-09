#!/usr/bin/env python3
"""Batch 15: RBAC matrix, auth demo/register, role selection l10n."""
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]

EN = """
  "permissionMatrixEmpty": "No capabilities apply to this role.",
  "permissionAccessFull": "Full",
  "permissionAccessRead": "Read",
  "permissionAccessDenied": "Denied",
  "permissionAccessPostponed": "Postponed",
  "rbacPostponedUntil": "Postponed until {date}",
  "@rbacPostponedUntil": {
    "placeholders": {
      "date": { "type": "String" }
    }
  },
  "rbacSelectPostponeDate": "Select postpone date",
  "rbacPostponeDateRequired": "Choose a date when postponing access.",
  "rbacOpenRoleDefaults": "Open role defaults in Screen A",
  "loginDemoModeNotice": "Demo mode is on — hub shortcuts skip OTP for UI review only.",
  "loginDemoSignedIn": "Signed in with demo role (OTP skipped).",
  "roleSelectionNoApprovedRoles": "No approved roles yet. Contact your app administrator.",
  "registerViewTerms": "View terms"
"""

AR = """
  "permissionMatrixEmpty": "لا توجد صلاحيات لهذا الدور.",
  "permissionAccessFull": "كامل",
  "permissionAccessRead": "قراءة",
  "permissionAccessDenied": "ممنوع",
  "permissionAccessPostponed": "مؤجل",
  "rbacPostponedUntil": "مؤجل حتى {date}",
  "@rbacPostponedUntil": {
    "placeholders": {
      "date": { "type": "String" }
    }
  },
  "rbacSelectPostponeDate": "اختر تاريخ التأجيل",
  "rbacPostponeDateRequired": "اختر تاريخاً عند تأجيل الصلاحية.",
  "rbacOpenRoleDefaults": "فتح افتراضيات الدور في الشاشة أ",
  "loginDemoModeNotice": "وضع التجربة مفعّل — اختصارات المراكز تتخطى OTP للمراجعة فقط.",
  "loginDemoSignedIn": "تم تسجيل الدخول بدور تجريبي (تم تخطي OTP).",
  "roleSelectionNoApprovedRoles": "لا توجد أدوار معتمدة بعد. تواصل مع مدير التطبيق.",
  "registerViewTerms": "عرض الشروط"
"""


def append_arb(path: Path, keys: str) -> None:
    text = path.read_text(encoding='utf-8').rstrip()
    if text.endswith('}'):
        text = text[:-1].rstrip()
        if not text.endswith(','):
            text += ','
        text += '\n' + keys.strip() + '\n}\n'
        path.write_text(text, encoding='utf-8')


def main() -> None:
    append_arb(ROOT / 'lib/l10n/app_en.arb', EN)
    append_arb(ROOT / 'lib/l10n/app_ar.arb', AR)
    print('batch 15 ARB done')


if __name__ == '__main__':
    main()

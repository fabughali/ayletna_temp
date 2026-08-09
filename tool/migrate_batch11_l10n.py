#!/usr/bin/env python3
"""Batch 11: RBAC role defaults, report filter page l10n."""
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]

EN = """
  "rbacRoleDefaultsSaved": "Role defaults saved",
  "rbacResetDefaults": "Reset defaults",
  "rbacResetDefaultsSuccess": "Reset to factory defaults",
  "rbacUsersWithRoleLink": "{count} users with this role — view list",
  "@rbacUsersWithRoleLink": {
    "placeholders": { "count": { "type": "int" } }
  },
  "reportFilterPageSubtitle": "The same filter used inside the reports hub, available as a full admin page."
"""

AR = """
  "rbacRoleDefaultsSaved": "تم حفظ القواعد الافتراضية",
  "rbacResetDefaults": "إعادة ضبط",
  "rbacResetDefaultsSuccess": "تمت إعادة الضبط",
  "rbacUsersWithRoleLink": "{count} مستخدم بهذا الدور — عرض القائمة",
  "@rbacUsersWithRoleLink": {
    "placeholders": { "count": { "type": "int" } }
  },
  "reportFilterPageSubtitle": "نفس الفلتر المستخدم داخل مركز التقارير، متاح كصفحة كاملة للمدير."
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
    print('batch 11 ARB done')


if __name__ == '__main__':
    main()

#!/usr/bin/env python3
"""Batch 16: RBAC widget l10n, customer empty states."""
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]

EN = """
  "rbacRoleGroupManagement": "Management",
  "rbacRoleGroupSpecialist": "Specialist",
  "rbacRoleGroupOperations": "Operations",
  "rbacRoleGroupManagementSpecialist": "Management & specialist",
  "customerDiscountsEmptyTitle": "No active discounts",
  "customerDiscountsEmptyBody": "Check back soon or browse the menu for current offers.",
  "customerPromoNotFoundTitle": "Promotion not found",
  "customerPromoNotFoundBody": "This offer may have expired or been removed.",
  "promoApplyUnavailable": "This promotion cannot be applied to your cart right now."
"""

AR = """
  "rbacRoleGroupManagement": "الإدارة",
  "rbacRoleGroupSpecialist": "متخصصون",
  "rbacRoleGroupOperations": "العمليات",
  "rbacRoleGroupManagementSpecialist": "الإدارة والمتخصصون",
  "customerDiscountsEmptyTitle": "لا توجد خصومات نشطة",
  "customerDiscountsEmptyBody": "عد لاحقاً أو تصفّح القائمة للعروض الحالية.",
  "customerPromoNotFoundTitle": "العرض غير موجود",
  "customerPromoNotFoundBody": "ربما انتهى هذا العرض أو أُزيل.",
  "promoApplyUnavailable": "لا يمكن تطبيق هذا العرض على السلة حالياً."
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
    print('batch 16 ARB done')


if __name__ == '__main__':
    main()

#!/usr/bin/env python3
"""Batch 12: E2 fail paths + ops refresh l10n."""
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]

EN = """
  "reviewModerationAlreadyProcessed": "This review was already moderated.",
  "reviewModerationRejectConfirmTitle": "Reject review?",
  "reviewModerationRejectConfirmMessage": "The review will be hidden from the public menu.",
  "reviewModerationFlagConfirmTitle": "Flag review?",
  "reviewModerationFlagConfirmMessage": "The review will be marked for support follow-up.",
  "supportFaqDeleteConfirmTitle": "Delete FAQ entry?",
  "supportFaqDeleteConfirmMessage": "This entry will be removed from the public FAQ list.",
  "supportFaqDeleteBlocked": "Keep at least one FAQ entry in the editor.",
  "supportFaqDeleted": "FAQ entry removed",
  "rbacResetConfirmTitle": "Reset role defaults?",
  "rbacResetConfirmMessage": "All permissions for this role will return to factory defaults.",
  "rbacAllPermissionsDenied": "At least one permission must be allowed before saving.",
  "adminTipPoolEmpty": "Tip pool must be greater than zero before approval.",
  "reportFilterAtLeastOneModule": "Select at least one report module.",
  "marketingBlogUnpublishConfirmTitle": "Move post to draft?",
  "marketingBlogUnpublishConfirmMessage": "Published posts will no longer appear on the blog.",
  "marketingBlogDraftNeedsTitle": "Add a title before publishing this draft.",
  "opsKitchenBoardRefreshed": "Kitchen pass refreshed.",
  "opsInventoryItemRefreshed": "Inventory item refreshed.",
  "opsStaffTipsRefreshed": "Daily tips refreshed.",
  "opsCashierHistoryRefreshed": "Transaction history refreshed."
"""

AR = """
  "reviewModerationAlreadyProcessed": "تمت معالجة هذا التقييم مسبقاً.",
  "reviewModerationRejectConfirmTitle": "رفض التقييم؟",
  "reviewModerationRejectConfirmMessage": "لن يظهر التقييم في قائمة المنتجات للعملاء.",
  "reviewModerationFlagConfirmTitle": "وضع علامة على التقييم؟",
  "reviewModerationFlagConfirmMessage": "سيُعلّم التقييم للمتابعة من فريق الدعم.",
  "supportFaqDeleteConfirmTitle": "حذف سؤال شائع؟",
  "supportFaqDeleteConfirmMessage": "سيُزال هذا السؤال من قائمة الأسئلة الشائعة.",
  "supportFaqDeleteBlocked": "يجب الإبقاء على سؤال شائع واحد على الأقل.",
  "supportFaqDeleted": "تم حذف السؤال الشائع",
  "rbacResetConfirmTitle": "إعادة ضبط قواعد الدور؟",
  "rbacResetConfirmMessage": "ستعود جميع صلاحيات هذا الدور إلى الإعدادات الافتراضية.",
  "rbacAllPermissionsDenied": "يجب السماح بصلاحية واحدة على الأقل قبل الحفظ.",
  "adminTipPoolEmpty": "يجب أن تكون مجموعة الإكراميات أكبر من صفر قبل الموافقة.",
  "reportFilterAtLeastOneModule": "اختر وحدة تقرير واحدة على الأقل.",
  "marketingBlogUnpublishConfirmTitle": "نقل المنشور إلى مسودة؟",
  "marketingBlogUnpublishConfirmMessage": "لن تظهر المنشورات المنشورة في المدونة.",
  "marketingBlogDraftNeedsTitle": "أضف عنواناً قبل نشر هذه المسودة.",
  "opsKitchenBoardRefreshed": "تم تحديث لوحة المطبخ.",
  "opsInventoryItemRefreshed": "تم تحديث عنصر المخزون.",
  "opsStaffTipsRefreshed": "تم تحديث الإكراميات اليومية.",
  "opsCashierHistoryRefreshed": "تم تحديث سجل المعاملات."
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
    print('batch 12 ARB done')


if __name__ == '__main__':
    main()

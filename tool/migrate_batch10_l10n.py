#!/usr/bin/env python3
"""Batch 10: reviews, RBAC users, plate editor, tip distribution l10n."""
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]

EN = """
  "filterByRole": "Filter by role",
  "rbacUserNotFound": "User not found",
  "rbacAccountActions": "Account actions",
  "rbacApprove": "Approve",
  "rbacReject": "Reject",
  "rbacSuspend": "Suspend",
  "rbacActivate": "Activate",
  "rbacInvite": "Invite",
  "rbacInviteMockMessage": "UI mock — no backend",
  "rbacApprovedMessage": "Approved",
  "rbacRejectedMessage": "Rejected",
  "rbacSuspendedMessage": "Suspended",
  "rbacActivatedMessage": "Activated",
  "rbacAssignedRoles": "Assigned roles",
  "rbacStatusActive": "Active",
  "rbacStatusPendingApproval": "Pending approval",
  "rbacStatusSuspended": "Suspended",
  "rbacOwnershipPercent": "Ownership %",
  "rbacOwnershipHint": "e.g. 35",
  "reviewModerationTitle": "Review Moderation",
  "reviewModerationHeroBody": "{count} reviews awaiting moderation — approve to publish, reject or flag for follow-up.",
  "@reviewModerationHeroBody": {
    "placeholders": { "count": { "type": "int" } }
  },
  "reviewModerationReject": "Reject",
  "reviewModerationFlag": "Flag",
  "reviewModerationUpdated": "Review updated",
  "reviewModerationStatusPending": "Pending",
  "reviewModerationStatusApproved": "Approved",
  "reviewModerationStatusRejected": "Rejected",
  "reviewModerationStatusFlagged": "Flagged",
  "plateEditorBadge": "Asset & Deposit Editor",
  "plateEditorHeadline": "Set asset value, stock, deposit, and breakage fees.",
  "plateEditorAssetIdentityTitle": "Asset Identity",
  "plateEditorAssetIdentitySubtitle": "Used by inventory, delivery, and returns.",
  "plateEditorAssetNameAr": "Arabic asset name",
  "plateEditorAssetNameEn": "English asset name",
  "plateEditorAssetSku": "Asset SKU",
  "plateEditorReplacementValue": "Replacement value",
  "plateEditorStockTitle": "Stock & Circulation",
  "plateEditorStockSubtitle": "Operational counts used by the return flow.",
  "plateEditorRequiresDeposit": "Requires deposit on delivery",
  "plateEditorAvailableDelivery": "Available for delivery orders",
  "plateEditorDepositRulesSubtitle": "Deposit rules for this asset type.",
  "plateEditorConditionFeesTitle": "Condition & Fees",
  "plateEditorConditionFeesSubtitle": "Used during plated return processing.",
  "plateEditorFeeFullBreakage": "Full breakage fee",
  "plateEditorFeeScratch": "Scratch / minor damage",
  "plateEditorFeeMissing": "Missing on return",
  "plateEditorSaveTitle": "Save Asset",
  "plateEditorSaveSubtitle": "Front-end only, no backend write.",
  "plateEditorSavedSuccess": "Asset settings saved",
  "plateEditorBackToPlates": "Back to plates",
  "adminShowLess": "Show less",
  "adminTipRowSubtitle": "ID: {orderId} · {hours} hrs",
  "@adminTipRowSubtitle": {
    "placeholders": {
      "orderId": { "type": "String" },
      "hours": { "type": "String" }
    }
  }
"""

AR = """
  "filterByRole": "تصفية حسب الدور",
  "rbacUserNotFound": "المستخدم غير موجود",
  "rbacAccountActions": "إجراءات الحساب",
  "rbacApprove": "موافقة",
  "rbacReject": "رفض",
  "rbacSuspend": "إيقاف",
  "rbacActivate": "تفعيل",
  "rbacInvite": "دعوة",
  "rbacInviteMockMessage": "واجهة تجريبية — لا backend",
  "rbacApprovedMessage": "تمت الموافقة",
  "rbacRejectedMessage": "تم الرفض",
  "rbacSuspendedMessage": "تم الإيقاف",
  "rbacActivatedMessage": "تم التفعيل",
  "rbacAssignedRoles": "الأدوار المعينة",
  "rbacStatusActive": "نشط",
  "rbacStatusPendingApproval": "بانتظار الموافقة",
  "rbacStatusSuspended": "موقوف",
  "rbacOwnershipPercent": "نسبة الملكية",
  "rbacOwnershipHint": "مثال: 35",
  "reviewModerationTitle": "مراجعة التقييمات",
  "reviewModerationHeroBody": "{count} تقييم بانتظار المراجعة — وافق لعرضها للعملاء أو ارفض/علّم للمتابعة.",
  "reviewModerationReject": "رفض",
  "reviewModerationFlag": "تعليم",
  "reviewModerationUpdated": "تم تحديث التقييم",
  "reviewModerationStatusPending": "معلق",
  "reviewModerationStatusApproved": "معتمد",
  "reviewModerationStatusRejected": "مرفوض",
  "reviewModerationStatusFlagged": "مُعلّم",
  "plateEditorBadge": "محرر أصل وعربون",
  "plateEditorHeadline": "حدد قيمة الأصل، مخزونه، عربونه، ورسوم الكسر.",
  "plateEditorAssetIdentityTitle": "بيانات الأصل",
  "plateEditorAssetIdentitySubtitle": "معلومات تستخدم في المخزون والإرجاع.",
  "plateEditorAssetNameAr": "الاسم بالعربية",
  "plateEditorAssetNameEn": "الاسم بالإنجليزية",
  "plateEditorAssetSku": "كود الأصل / SKU",
  "plateEditorReplacementValue": "قيمة الاستبدال",
  "plateEditorStockTitle": "المخزون والتداول",
  "plateEditorStockSubtitle": "الأرقام الأساسية للعمليات اليومية.",
  "plateEditorRequiresDeposit": "يتطلب عربون عند التوصيل",
  "plateEditorAvailableDelivery": "متاح لطلبات التوصيل",
  "plateEditorDepositRulesSubtitle": "قواعد العربون لهذا النوع من الصواني.",
  "plateEditorConditionFeesTitle": "الحالة ورسوم الكسر",
  "plateEditorConditionFeesSubtitle": "تظهر في عملية إرجاع الصواني.",
  "plateEditorFeeFullBreakage": "رسوم كسر كاملة",
  "plateEditorFeeScratch": "خدش / تلف بسيط",
  "plateEditorFeeMissing": "مفقود عند الإرجاع",
  "plateEditorSaveTitle": "حفظ الأصل",
  "plateEditorSaveSubtitle": "واجهة فقط، بدون ربط خلفي.",
  "plateEditorSavedSuccess": "تم حفظ إعدادات الأصل",
  "plateEditorBackToPlates": "رجوع لإدارة الصواني",
  "adminShowLess": "عرض أقل",
  "adminTipRowSubtitle": "ID: {orderId} · {hours} س"
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
    append_arb(ROOT / 'lib/l10n/app_ar.arb', AR.replace(' · {hours} س"', ' · {hours} ساعة"'))
    print('batch 10 ARB done')


if __name__ == '__main__':
    main()

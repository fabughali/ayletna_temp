#!/usr/bin/env python3
"""Batch 9: reports, pre-order, rewards, menu management l10n — ARB keys only."""
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]

EN = """
  "reportsHubBadge": "Restaurant Analytics Hub",
  "reportsHubHeadline": "Connect sales, channels, tips, waste, and trays to clear operating decisions.",
  "reportsOpsScorecardsTitle": "Operating Scorecards",
  "reportsOpsScorecardsSubtitle": "Numbers that drive today, not just export files.",
  "reportsAvgOrderLabel": "Average order",
  "reportsTrayReturnSuccess": "Tray return success",
  "reportsWasteBreakageCost": "Waste & breakage cost",
  "reportsTrendSubtitle": "Order trend across recent service hours.",
  "reportsTodayPeakLabel": "Today peak",
  "reportsTodayPeakValue": "Lunch and evening delivery",
  "reportsDecisionsTitle": "Recommended Decisions",
  "reportsDecisionsSubtitle": "Analytics connected to restaurant operations.",
  "reportsInsightShawarmaLabel": "Increase shawarma prep before lunch",
  "reportsInsightShawarmaDetail": "Channel sales are 12% above baseline.",
  "reportsReviewFryerLabel": "Review fryer wastage",
  "reportsApproveTipsLabel": "Approve tip distribution",
  "reportsModulesTitle": "Analytics Modules",
  "reportsPlatesDepositsTitle": "Plates & deposits",
  "reportsExportTitle": "Export & Share",
  "reportsExportSubtitle": "Exports are now an outcome, not the whole screen.",
  "reportsExportOperatorOnly": "Export is available to the operator role only.",
  "preOrderOpsBadge": "Pre-order Operations",
  "preOrderOpsHeadline": "Review tomorrow orders, prep capacity, trays, and pickup windows before accepting pre-orders.",
  "preOrderOpsNeedDecision": "Need decision",
  "preOrderOpsPickupWindows": "Pickup windows",
  "preOrderOpsReservedTrays": "Reserved trays",
  "preOrderOpsEmptyMessage": "No pre-orders pending",
  "preOrderOpsReviewQueue": "Review Queue",
  "preOrderOpsReviewQueueSub": "Each pre-order needs a clear decision before prep.",
  "preOrderOpsAccept": "Accept",
  "preOrderOpsAccepted": "Pre-order accepted",
  "preOrderOpsAdjustTime": "Adjust time",
  "preOrderOpsPickupUpdated": "Pickup time updated",
  "preOrderOpsPrepCapacity": "Prep Capacity",
  "preOrderOpsPrepCapacitySub": "Accept orders based on available stations.",
  "preOrderOpsStationShawarma": "Shawarma",
  "preOrderOpsStationPizza": "Pizza",
  "preOrderOpsStationPlated": "Plated trays",
  "preOrderOpsRulesTitle": "Pre-order Rules",
  "preOrderOpsRulesSubtitle": "UI-only rules ready for later data wiring.",
  "preOrderOpsRuleCutoff": "Cutoff: 9 PM",
  "preOrderOpsRuleMinPrep": "Minimum prep: 2 hours",
  "preOrderOpsRuleTraysBeforePay": "Confirm trays before payment",
  "rewardsAdminSetupTitle": "Rewards Setup",
  "rewardsAdminPointsRules": "Points rules",
  "rewardsAdminPointsPerJod": "{points} points per JOD spent",
  "@rewardsAdminPointsPerJod": {
    "placeholders": { "points": { "type": "String" } }
  },
  "rewardsAdminAddReward": "Add reward",
  "rewardsAdminPointsRequired": "Points required",
  "rewardsAdminCategory": "Category",
  "rewardsAdminAddToCatalog": "Add to catalog",
  "rewardsAdminActiveRewards": "Active rewards",
  "rewardsAdminRewardAdded": "Reward added",
  "rewardsAdminCategoryDrinks": "Drinks",
  "rewardsAdminCategorySides": "Sides",
  "rewardsAdminCategoryMain": "Main",
  "menuMgmtPublished": "Published",
  "menuMgmtDraft": "Draft",
  "menuMgmtPublish": "Publish",
  "menuMgmtUnpublish": "Unpublish",
  "menuMgmtPublishSuccess": "Published",
  "menuMgmtHiddenFromMenu": "Hidden from customer menu"
"""

AR = """
  "reportsHubBadge": "مركز تحليلات المطعم",
  "reportsHubHeadline": "اربط المبيعات، القنوات، البقشيش، الهدر، والصواني بقرارات تشغيل واضحة.",
  "reportsOpsScorecardsTitle": "مؤشرات تشغيلية",
  "reportsOpsScorecardsSubtitle": "أرقام تقود قرارات اليوم، لا ملفات تصدير فقط.",
  "reportsAvgOrderLabel": "متوسط الطلب",
  "reportsTrayReturnSuccess": "إرجاع الصواني",
  "reportsWasteBreakageCost": "تكلفة الهدر والكسر",
  "reportsTrendSubtitle": "اتجاه الطلبات خلال آخر ساعات الخدمة.",
  "reportsTodayPeakLabel": "ذروة اليوم",
  "reportsTodayPeakValue": "الغداء والتوصيل المسائي",
  "reportsDecisionsTitle": "قرارات مقترحة",
  "reportsDecisionsSubtitle": "تحليلات مرتبطة بتشغيل المطعm.",
  "reportsInsightShawarmaLabel": "زِد تحضير الشاورما قبل الغداء",
  "reportsInsightShawarmaDetail": "مبيعات القناة أعلى من المتوسط بـ ١٢٪.",
  "reportsReviewFryerLabel": "راجع هدر المقالي",
  "reportsApproveTipsLabel": "اعتمد توزيع البقشيش",
  "reportsModulesTitle": "وحدات التحليل",
  "reportsPlatesDepositsTitle": "الصواني والعربون",
  "reportsExportTitle": "تصدير ومشاركة",
  "reportsExportSubtitle": "التصدير أصبح نتيجة ثانوية، وليس مركز الشاشة.",
  "reportsExportOperatorOnly": "التصدير متاح للمشغل فقط.",
  "preOrderOpsBadge": "لوحة الطلبات المسبقة",
  "preOrderOpsHeadline": "راجع طلبات الغد، الطاقة التحضيرية، الصواني، ومواعيد الاستلام قبل قبول أي طلب مسبق.",
  "preOrderOpsNeedDecision": "بانتظار القرار",
  "preOrderOpsPickupWindows": "نوافذ الاستلام",
  "preOrderOpsReservedTrays": "صواني محجوزة",
  "preOrderOpsEmptyMessage": "لا توجد طلبات مسبقة",
  "preOrderOpsReviewQueue": "قائمة المراجعة",
  "preOrderOpsReviewQueueSub": "كل طلب مسبق يحتاج قراراً واضحاً قبل التحضير.",
  "preOrderOpsAccept": "قبول",
  "preOrderOpsAccepted": "تم قبول الطلب المسبق",
  "preOrderOpsAdjustTime": "تعديل الوقت",
  "preOrderOpsPickupUpdated": "تم تحديث وقت الاستلام",
  "preOrderOpsPrepCapacity": "طاقة التحضير",
  "preOrderOpsPrepCapacitySub": "اضبط قبول الطلبات حسب المحطات المتاحة.",
  "preOrderOpsStationShawarma": "الشاورما",
  "preOrderOpsStationPizza": "البيتزا",
  "preOrderOpsStationPlated": "الصواني",
  "preOrderOpsRulesTitle": "قواعد الطلب المسبق",
  "preOrderOpsRulesSubtitle": "قواعد واجهة وهمية قابلة للتعديل لاحقاً.",
  "preOrderOpsRuleCutoff": "آخر وقت قبول: ٩ مساءً",
  "preOrderOpsRuleMinPrep": "الحد الأدنى للتحضير: ساعتان",
  "preOrderOpsRuleTraysBeforePay": "تأكيد الصواني قبل الدفع",
  "rewardsAdminSetupTitle": "إعداد المكافآت",
  "rewardsAdminPointsRules": "قواعد النقاط",
  "rewardsAdminPointsPerJod": "{points} نقطة لكل دينار",
  "rewardsAdminAddReward": "إضافة مكافأة",
  "rewardsAdminPointsRequired": "النقاط المطلوبة",
  "rewardsAdminCategory": "الفئة",
  "rewardsAdminAddToCatalog": "إضافة للكتalog",
  "rewardsAdminActiveRewards": "المكافآت النشطة",
  "rewardsAdminRewardAdded": "تمت إضافة المكافأة",
  "rewardsAdminCategoryDrinks": "مشروبات",
  "rewardsAdminCategorySides": "مقبلات",
  "rewardsAdminCategoryMain": "أطباق رئيسية",
  "menuMgmtPublished": "منشور",
  "menuMgmtDraft": "مسودة",
  "menuMgmtPublish": "نشر",
  "menuMgmtUnpublish": "إلغاء النشر",
  "menuMgmtPublishSuccess": "تم النشر",
  "menuMgmtHiddenFromMenu": "تم إخفاء العنصر من المنيو"
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
    append_arb(ROOT / 'lib/l10n/app_ar.arb', AR.replace('المطعm', 'المطعم'))
    print('batch 9 ARB done')


if __name__ == '__main__':
    main()

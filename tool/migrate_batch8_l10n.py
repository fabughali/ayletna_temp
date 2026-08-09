#!/usr/bin/env python3
"""Batch 8: order detail, attendance HR, support tickets, promo/menu catalog l10n."""
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]

EN = """
  "actionAdd": "Add",
  "catalogCrudAdded": "Added",
  "catalogCrudCheckFields": "Check required fields",
  "catalogCrudUpdated": "Updated",
  "catalogCrudUpdateFailed": "Update failed",
  "catalogCrudDeleted": "Deleted",
  "catalogCrudNameEn": "Name EN",
  "catalogCrudNameAr": "Name AR",
  "catalogCrudIconKey": "Icon key",
  "catalogCrudPrice": "Price",
  "catalogCrudMinOneImage": "Add at least 1 image",
  "menuCatalogTitle": "Menu Catalog",
  "menuCatalogTabCategories": "Categories",
  "menuCatalogTabAddons": "Addons",
  "menuCatalogTabRelated": "Related",
  "menuCatalogAddCategory": "Add category",
  "menuCatalogAddAddon": "Add addon",
  "menuCatalogAddonImageRequired": "Add an image for the addon",
  "menuCatalogLinkRelated": "Link related products",
  "menuCatalogLinkRelatedSubtitle": "Example IDs: {sampleIds}",
  "@menuCatalogLinkRelatedSubtitle": {
    "placeholders": { "sampleIds": { "type": "String" } }
  },
  "menuCatalogProductId": "Product ID",
  "menuCatalogRelatedIds": "Related IDs (comma-separated)",
  "menuCatalogSaveLink": "Save link",
  "menuCatalogSaved": "Saved",
  "menuCatalogEnterProductId": "Enter a product ID",
  "promoMgmtTabDiscounts": "Discounts",
  "promoMgmtTabOffers": "Offers",
  "promoMgmtCreateCombo": "Create combo",
  "promoMgmtDiscountPercent": "Discount %",
  "promoMgmtDiscountProduct": "Discount product",
  "promoMgmtMenuItemId": "Menu item ID",
  "promoMgmtNewOffer": "New offer",
  "promoMgmtSubscriptionMeal": "Subscription meal",
  "orderDetailAdminHeroTitle": "Order #{orderId} admin timeline",
  "@orderDetailAdminHeroTitle": {
    "placeholders": { "orderId": { "type": "String" } }
  },
  "orderDetailAdminHeroBody": "{customer} • Verify handoff timing, deposit, and notes before closing.",
  "@orderDetailAdminHeroBody": {
    "placeholders": { "customer": { "type": "String" } }
  },
  "orderDetailAdminActionsSubtitle": "Front-end only actions for this phase.",
  "orderDetailAdminChangeStatusMessage": "Choose the next mock status for this order.",
  "orderDetailAdminTimelinePosDetail": "Order entered and payment captured.",
  "orderDetailAdminTimelinePrepDetail": "Items prepared and packed.",
  "orderDetailAdminTimelineOnWayDetail": "Courier is on the way to the guest.",
  "orderDetailAdminTimelineWaitingDetail": "Waiting for the next operational step.",
  "orderDetailAdminTimelineCloseDetail": "Confirm handoff, deposit, and any breakage fee.",
  "orderDetailAdminRisksSubtitle": "What the owner should know before closing this order.",
  "orderDetailAdminRiskTimingDetail": "Eight minutes above route average.",
  "orderDetailAdminRiskTrayDetail": "Confirm tray return expectation at handoff.",
  "hrPayrollOnTimeRule": "On time (≤ {minutes} min) → 100% salary",
  "@hrPayrollOnTimeRule": {
    "placeholders": { "minutes": { "type": "int" } }
  },
  "hrPayrollDelayDoubleRule": "Late > {minutes} min → fee ×2",
  "@hrPayrollDelayDoubleRule": {
    "placeholders": { "minutes": { "type": "int" } }
  },
  "hrPayrollAbsenceRule": "Late > {minutes} min → absence (0% even if present)",
  "@hrPayrollAbsenceRule": {
    "placeholders": { "minutes": { "type": "int" } }
  },
  "hrPayrollOvertimeRule": "Work > {minutes} min beyond schedule → {multiplier}× extra hours pay",
  "@hrPayrollOvertimeRule": {
    "placeholders": {
      "minutes": { "type": "int" },
      "multiplier": { "type": "String" }
    }
  },
  "supportTicketsHeroBody": "{count} active tickets — update status, reply to customers, track feedback.",
  "@supportTicketsHeroBody": {
    "placeholders": { "count": { "type": "int" } }
  },
  "supportTicketStatusOpen": "Open",
  "supportTicketStatusInProgress": "In progress",
  "supportTicketStatusWaiting": "Waiting",
  "supportTicketStatusResolved": "Resolved",
  "supportTicketStatusClosed": "Closed"
"""

AR = """
  "actionAdd": "إضافة",
  "catalogCrudAdded": "تمت الإضافة",
  "catalogCrudCheckFields": "تحقق من الحقول",
  "catalogCrudUpdated": "تم التحديث",
  "catalogCrudUpdateFailed": "تعذر التحديث",
  "catalogCrudDeleted": "تم الحذف",
  "catalogCrudNameEn": "الاسم EN",
  "catalogCrudNameAr": "الاسم AR",
  "catalogCrudIconKey": "مفتاح الأيقونة",
  "catalogCrudPrice": "السعر",
  "catalogCrudMinOneImage": "أضف صورة واحدة على الأقل",
  "menuCatalogTitle": "فهرس المنيو",
  "menuCatalogTabCategories": "الفئات",
  "menuCatalogTabAddons": "الإضافات",
  "menuCatalogTabRelated": "منتجات مرتبطة",
  "menuCatalogAddCategory": "إضافة فئة",
  "menuCatalogAddAddon": "إضافة addon",
  "menuCatalogAddonImageRequired": "أضف صورة للإضافة",
  "menuCatalogLinkRelated": "ربط منتجات",
  "menuCatalogLinkRelatedSubtitle": "مثال IDs: {sampleIds}",
  "menuCatalogProductId": "معرف المنتج",
  "menuCatalogRelatedIds": "معرفات مرتبطة (فاصلة)",
  "menuCatalogSaveLink": "حفظ الربط",
  "menuCatalogSaved": "تم الحفظ",
  "menuCatalogEnterProductId": "أدخل معرف المنتج",
  "promoMgmtTabDiscounts": "خصومات",
  "promoMgmtTabOffers": "عروض",
  "promoMgmtCreateCombo": "إنشاء كومبو",
  "promoMgmtDiscountPercent": "خصم %",
  "promoMgmtDiscountProduct": "خصم على منتج",
  "promoMgmtMenuItemId": "معرف المنتج",
  "promoMgmtNewOffer": "عرض جديد",
  "promoMgmtSubscriptionMeal": "وجبة اشتراك",
  "orderDetailAdminHeroTitle": "طلب #{orderId} يحتاج متابعة من الإدارة",
  "orderDetailAdminHeroBody": "{customer} • تحقق من وقت التسليم والعربون والملاحظات قبل الإغلاق.",
  "orderDetailAdminActionsSubtitle": "إجراءات واجهة فقط لهذه المرحلة.",
  "orderDetailAdminChangeStatusMessage": "اختر الحالة التالية للعرض التجريبي.",
  "orderDetailAdminTimelinePosDetail": "تم تسجيل الطلب ودفع المبلغ.",
  "orderDetailAdminTimelinePrepDetail": "تجهيز الأصناف الأساسية والتغليف.",
  "orderDetailAdminTimelineOnWayDetail": "المندوب في الطريق إلى العميل.",
  "orderDetailAdminTimelineWaitingDetail": "بانتظار الخطوة التالية.",
  "orderDetailAdminTimelineCloseDetail": "تأكيد التسليم، العربون، وأي رسوم كسر.",
  "orderDetailAdminRisksSubtitle": "ما يحتاج صاحب المطعم معرفته قبل إغلاق الطلب.",
  "orderDetailAdminRiskTimingDetail": "تجاوز متوسط المسار بثماني دقائق.",
  "orderDetailAdminRiskTrayDetail": "تحقق من إعادة الصواني عند التسليم.",
  "hrPayrollOnTimeRule": "في الوقت (≤ {minutes} د) → 100% من الراتب",
  "hrPayrollDelayDoubleRule": "تأخير > {minutes} د → خصم ×2",
  "hrPayrollAbsenceRule": "تأخير > {minutes} د → غياب (0% حتى مع الحضور)",
  "hrPayrollOvertimeRule": "عمل > {minutes} د إضافية → {multiplier}× للساعات الإضافية",
  "supportTicketsHeroBody": "{count} تذكرة نشطة — حدّث الحالة، رد على العملاء، وتابع التقييمات.",
  "supportTicketStatusOpen": "مفتوحة",
  "supportTicketStatusInProgress": "قيد المتابعة",
  "supportTicketStatusWaiting": "بانتظار رد",
  "supportTicketStatusResolved": "تم الحل",
  "supportTicketStatusClosed": "مغلقة"
"""

CATALOG_REPLACEMENTS = [
    ("widget.isAr ? 'حفظ' : 'Save'", "l10n.actionSave"),
    ("isAr ? 'حفظ' : 'Save'", "l10n.actionSave"),
    ("widget.isAr ? 'إضافة' : 'Add'", "l10n.actionAdd"),
    ("isAr ? 'إضافة' : 'Add'", "l10n.actionAdd"),
    ("widget.isAr ? 'تمت الإضافة' : 'Added'", "l10n.catalogCrudAdded"),
    ("widget.isAr ? 'تم' : 'Added'", "l10n.catalogCrudAdded"),
    ("widget.isAr ? 'تحقق من الحقول' : 'Check required fields'", "l10n.catalogCrudCheckFields"),
    ("widget.isAr ? 'تم التحديث' : 'Updated'", "l10n.catalogCrudUpdated"),
    ("widget.isAr ? 'تعذر التحديث' : 'Update failed'", "l10n.catalogCrudUpdateFailed"),
    ("widget.isAr ? 'تم الحذف' : 'Deleted'", "l10n.catalogCrudDeleted"),
    ("widget.isAr ? 'الاسم EN' : 'Name EN'", "l10n.catalogCrudNameEn"),
    ("widget.isAr ? 'الاسم AR' : 'Name AR'", "l10n.catalogCrudNameAr"),
    ("widget.isAr ? 'مفتاح الأيقونة' : 'Icon key'", "l10n.catalogCrudIconKey"),
    ("widget.isAr ? 'السعر' : 'Price'", "l10n.catalogCrudPrice"),
    ("widget.isAr ? 'أضف صورة واحدة على الأقل'", "l10n.catalogCrudMinOneImage"),
    ("widget.isAr\n                                    ? 'أضف صورة واحدة على الأقل'\n                                    : 'Add at least 1 image'", "l10n.catalogCrudMinOneImage"),
    ("widget.isAr ? 'أضف صورة للإضافة' : 'Add an image for the addon'", "l10n.menuCatalogAddonImageRequired"),
]


def append_arb(path: Path, keys: str) -> None:
    text = path.read_text(encoding='utf-8').rstrip()
    if text.endswith('}'):
        text = text[:-1].rstrip()
        if not text.endswith(','):
            text += ','
        text += '\n' + keys.strip() + '\n}\n'
        path.write_text(text, encoding='utf-8')


def inject_l10n_in_build(text: str, marker: str) -> str:
    """Add final l10n = ... after marker if not already present in next 200 chars."""
    idx = text.find(marker)
    if idx == -1:
        return text
    snippet = text[idx:idx + 250]
    if 'final l10n = AppLocalizations.of(context)!;' in snippet:
        return text
    return text.replace(marker, marker + '\n    final l10n = AppLocalizations.of(context)!;', 1)


def migrate_catalog_file(path: Path, extra: list[tuple[str, str]]) -> None:
    text = path.read_text(encoding='utf-8')
    for old, new in CATALOG_REPLACEMENTS + extra:
        text = text.replace(old, new)
    # Inject l10n into tab state build methods missing it
    for marker in [
        '  Widget build(BuildContext context) {\n    final combos',
        '  Widget build(BuildContext context) {\n    final discounts',
        '  Widget build(BuildContext context) {\n    final offers',
        '  Widget build(BuildContext context) {\n    final subs',
        '  Widget build(BuildContext context) {\n    final categories',
        '  Widget build(BuildContext context) {\n    final addons',
        '  Widget build(BuildContext context) {\n    final links',
        '  Widget build(BuildContext context) {\n    final l10n = AppLocalizations.of(context)!;\n    final isAr',
    ]:
        if 'final l10n' not in text[text.find(marker):text.find(marker) + 120] if marker in text else True:
            if marker.endswith('final isAr'):
                continue
            text = inject_l10n_in_build(text, marker)
    path.write_text(text, encoding='utf-8')


def main() -> None:
    append_arb(ROOT / 'lib/l10n/app_en.arb', EN)
    append_arb(ROOT / 'lib/l10n/app_ar.arb', AR)

    migrate_catalog_file(
        ROOT / 'lib/screens/admin/admin_promotions_management_screen.dart',
        [
            ("Tab(text: isAr ? 'خصومات' : 'Discounts')", 'Tab(text: l10n.promoMgmtTabDiscounts)'),
            ("Tab(text: isAr ? 'عروض' : 'Offers')", 'Tab(text: l10n.promoMgmtTabOffers)'),
            ("title: widget.isAr ? 'إنشاء كومبو' : 'Create combo'", 'title: l10n.promoMgmtCreateCombo'),
            ("title: widget.isAr ? 'خصم على منتج' : 'Discount product'", 'title: l10n.promoMgmtDiscountProduct'),
            ("title: widget.isAr ? 'عرض جديد' : 'New offer'", 'title: l10n.promoMgmtNewOffer'),
            ("title: widget.isAr ? 'وجبة اشتراك' : 'Subscription meal'", 'title: l10n.promoMgmtSubscriptionMeal'),
            ("label: widget.isAr ? 'خصم %' : 'Discount %'", 'label: l10n.promoMgmtDiscountPercent'),
            ("label: widget.isAr ? 'معرف المنتج' : 'Menu item ID'", 'label: l10n.promoMgmtMenuItemId'),
            (
                "widget.isAr\n                  ? 'أضف صورة واحدة على الأقل (حتى 5)'\n                  : 'Add at least 1 image (up to 5)'",
                'l10n.productEditorAddMinImages',
            ),
        ],
    )
    # Ensure main build has l10n (already does)

    migrate_catalog_file(
        ROOT / 'lib/screens/admin/admin_menu_catalog_screen.dart',
        [
            ("title: isAr ? 'فهرس المنيو' : 'Menu Catalog'", 'title: l10n.menuCatalogTitle'),
            ("Tab(text: isAr ? 'الفئات' : 'Categories')", 'Tab(text: l10n.menuCatalogTabCategories)'),
            ("Tab(text: isAr ? 'الإضافات' : 'Addons')", 'Tab(text: l10n.menuCatalogTabAddons)'),
            ("Tab(text: isAr ? 'منتجات مرتبطة' : 'Related')", 'Tab(text: l10n.menuCatalogTabRelated)'),
            ("title: widget.isAr ? 'إضافة فئة' : 'Add category'", 'title: l10n.menuCatalogAddCategory'),
            ("title: widget.isAr ? 'إضافة addon' : 'Add addon'", 'title: l10n.menuCatalogAddAddon'),
            ("title: widget.isAr ? 'ربط منتجات' : 'Link related products'", 'title: l10n.menuCatalogLinkRelated'),
            ("label: widget.isAr ? 'معرف المنتج' : 'Product ID'", 'label: l10n.menuCatalogProductId'),
            ("label: widget.isAr ? 'معرفات مرتبطة (فاصلة)' : 'Related IDs (comma-separated)'", 'label: l10n.menuCatalogRelatedIds'),
            ("label: widget.isAr ? 'حفظ الربط' : 'Save link'", 'label: l10n.menuCatalogSaveLink'),
            ("UtilityMockFeedback.showSuccess(context, widget.isAr ? 'تم الحفظ' : 'Saved')", 'UtilityMockFeedback.showSuccess(context, l10n.menuCatalogSaved)'),
            ("widget.isAr ? 'أدخل معرف المنتج' : 'Enter a product ID'", 'l10n.menuCatalogEnterProductId'),
        ],
    )

    print('batch 8 ARB + catalog files done')


if __name__ == '__main__':
    main()

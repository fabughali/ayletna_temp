#!/usr/bin/env python3
"""Batch 6: migrate admin product editor, audit log, order detail inline strings."""
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]

EN_KEYS = r'''
  "productEditorAddMenuItem": "Add menu item",
  "productEditorSaveFirst": "Save the item first",
  "productEditorPreview": "Preview",
  "productEditorBadge": "Menu Item Editor",
  "productEditorBadgeDesc": "Edit pricing, variants, modifiers, media, and station routing.",
  "productEditorNameSection": "Name & Description",
  "productEditorNameSectionDesc": "Bilingual copy shown on customer menu cards.",
  "productEditorArabicName": "Arabic name",
  "productEditorEnglishName": "English name",
  "productEditorArabicDesc": "Arabic description",
  "productEditorEnglishDesc": "English description",
  "productEditorPricingSection": "Pricing & Variants",
  "productEditorPricingSectionDesc": "Base price and portion/variant deltas.",
  "productEditorBasePrice": "Base price",
  "productEditorAddVariant": "Add variant",
  "productEditorAddPortionTitle": "Add portion size",
  "productEditorPortionKeyLabel": "Key (e.g. super)",
  "productEditorPortionPriceDelta": "Price delta (JOD)",
  "productEditorEnterPortionKey": "Enter a portion key",
  "productEditorPortionAdded": "Portion added",
  "productEditorPortionKeyExists": "Key already exists",
  "productEditorModifiersSection": "Modifiers",
  "productEditorModifiersSectionDesc": "Attach catalog add-ons to this item.",
  "productEditorNoAddons": "No catalog addons yet.",
  "productEditorMediaSection": "Media & Display",
  "productEditorMediaSectionDesc": "Images and menu presentation.",
  "productEditorMediaFallback": "No image yet — add 1 to 5 photos.",
  "productEditorPrepStationSection": "Prep Station",
  "productEditorPrepStationSectionDesc": "Route tickets to the correct kitchen lane.",
  "productEditorAvailabilitySection": "Availability & Channels",
  "productEditorAvailabilitySectionDesc": "Control where this item is visible.",
  "productEditorAvailableNow": "Available now",
  "productEditorFeatured": "Featured in menu",
  "productEditorSavePublishSection": "Save & Publish",
  "productEditorSavePublishCreateDesc": "Create then publish to the menu.",
  "productEditorSavePublishEditDesc": "Persists edits to catalog and custom menu items.",
  "productEditorAddMinImages": "Add at least 1 image (up to 5)",
  "productEditorCheckRequiredFields": "Check required fields",
  "productEditorMenuItemSaved": "Menu item saved",
  "productEditorPublishToMenu": "Publish to menu",
  "productEditorPublishTitle": "Publish menu item",
  "productEditorPublishMessage": "The item will appear in selected sales channels.",
  "productEditorAddImageBeforePublish": "Add at least 1 image before publishing",
  "productEditorCheckNamePrice": "Check name and price",
  "productEditorPublished": "Published",
  "productEditorBackToMenu": "Back to menu management",
  "productEditorPrepStationShawarma": "Shawarma station",
  "productEditorPrepStationFryer": "Fryer station",
  "productEditorPrepStationColdPrep": "Cold prep",
  "productEditorPrepStationDrinks": "Drinks",
  "auditLogTrueTrailBadge": "True Audit Trail",
  "auditLogHeroHeadline": "Track who changed what, when, and from which operational area.",
  "auditLogTodayEvents": "Today events",
  "auditLogSensitiveChanges": "Sensitive changes",
  "auditLogNeedsReview": "Needs review",
  "auditLogRequestConfirmMessage": "A detailed audit request will be logged for review.",
  "auditLogExportLog": "Export log",
  "auditLogExportDownloaded": "Export file downloaded",
  "auditLogTimelineSubtitle": "Timeline of administrative and operational events.",
  "auditLogNoEventsInScope": "No events in this scope.",
  "auditLogDetailedAuditRequested": "Detailed audit requested",
  "auditLogAuditExported": "Audit log exported",
  "auditLogShiftCloseApproved": "Shift close approved",
  "auditLogUserActivated": "User activated",
  "auditLogUserDeactivated": "User deactivated",
  "auditLogDepositSettingsSaved": "Deposit settings saved",
  "auditLogTrayBreakageArea": "Tray breakage",
  "auditLogInventoryArea": "Inventory",
  "auditLogUserRoleChanged": "User role changed",
  "auditLogCashierShiftClosed": "Cashier shift closed",
  "auditLogTrayDepositEdited": "Tray deposit policy edited",
  "auditLogFiltersTitle": "Audit Filters",
  "auditLogFiltersSubtitle": "Scope the log quickly.",
  "auditLogGovernanceTitle": "Governance Snapshot",
  "auditLogGovernanceSubtitle": "Security and permission posture for this shift.",
  "auditLogFailedLogins": "Failed login attempts",
  "auditLogPermissionChanges": "Permission changes",
  "auditLogFinancialEdits": "Financial edits",
  "auditLogInventorySubtitle": "Recent stock adjustments from inventory.",
  "auditLogNoStockChanges": "No stock changes yet.",
  "auditLogActorOwner": "Owner",
  "auditLogActorOperator": "Operator",
  "auditLogActorFinance": "Finance",
  "auditLogActorLogistics": "Logistics",
  "auditLogActorSystem": "System",
  "auditLogAreaGovernance": "Governance",
  "auditLogAreaReports": "Reports",
  "auditLogAreaCashClose": "Cash close",
  "auditLogAreaRolesPrivacy": "Roles & Privacy",
  "auditLogAreaFinance": "Finance",
  "auditLogAreaAdminLog": "Admin log",
  "auditLogToday": "Today",
  "auditLogYesterday1820": "Yesterday 18:20",
  "auditLogToday0942": "Today 09:42",
  "auditLogToday0858": "Today 08:58",
  "auditLogActorOperatorAhmad": "Operator Ahmad",
  "auditLogActorCashierLayla": "Cashier Layla",
  "auditLogAuditRequestDetail": "Request logged for review before shift close.",
  "auditLogAuditExportDetail": "CSV audit file downloaded.",
  "auditLogShiftCloseDetail": "Revenue, tips, and refunds approved.",
  "auditLogDepositSavedDetail": "Deposit {amount} JOD · {hours}h window",
  "@auditLogDepositSavedDetail": {
    "placeholders": {
      "amount": { "type": "String" },
      "hours": { "type": "String" }
    }
  },
  "auditLogRoleChangeDetail": "Sara moved from Kitchen to Station Supervisor.",
  "auditLogCashierCloseDetail": "Revenue, tips, and refunds were approved.",
  "auditLogTrayDepositEditDetail": "Global deposit and return window updated.",
  "auditLogSystemEntryDetail": "Automated admin event recorded.",
  "orderDetailAdminSendUpdate": "Send update",
  "orderDetailAdminOrderTotal": "Order total",
  "orderDetailAdminDeposit": "Deposit",
  "orderDetailAdminOnRoute": "On route",
  "orderDetailAdminOnRouteValue": "28 min",
  "orderDetailAdminSendGuestUpdateTitle": "Send guest update",
  "orderDetailAdminUpdatePreparing": "Order is preparing",
  "orderDetailAdminUpdateReady": "Order is ready",
  "orderDetailAdminUpdateOnWay": "Driver is on the way",
  "orderDetailAdminUpdateDelay": "Delay — we apologize",
  "orderDetailAdminUpdateSent": "Update sent",
  "orderDetailAdminDelayNoticeSent": "Delay notice sent",
  "orderDetailAdminGuestPaymentTitle": "Guest & Payment",
  "orderDetailAdminGuestPaymentSubtitle": "Key context for closing and contact.",
  "orderDetailAdminGuestLabel": "Guest",
  "orderDetailAdminChannelLabel": "Channel",
  "orderDetailAdminFoodTotal": "Food total",
  "orderDetailAdminTrayDeposit": "Tray deposit",
  "orderDetailAdminKitchenTicketTitle": "Kitchen Ticket",
  "orderDetailAdminKitchenTicketSubtitle": "Items and station summary.",
  "orderDetailAdminPrepStationNote": "Prep station",
  "orderDetailAdminOpenKitchen": "Open kitchen pass",
  "orderDetailAdminActionsTitle": "Admin Actions",
  "orderDetailAdminContactGuest": "Contact guest",
  "orderDetailAdminChangeStatus": "Change order status",
  "orderDetailAdminChangeStatusTitle": "Change status",
  "orderDetailAdminBackToBoard": "Back to order board",
  "orderDetailAdminPosReceived": "POS received",
  "orderDetailAdminKitchenPrep": "Kitchen prep",
  "orderDetailAdminCloseSettle": "Close & settle",
  "orderDetailAdminTimelineNext": "Next",
  "orderDetailAdminTimelineTitle": "Order Timeline",
  "orderDetailAdminTimelineSubtitle": "From entry to settlement.",
  "orderDetailAdminRisksTitle": "Risks & Notes",
  "orderDetailAdminDeliveryTiming": "Delivery timing",
  "orderDetailAdminNoDeposit": "No deposit",
  "orderDetailAdminOperationalNote": "Operational note"
'''

AR_KEYS = r'''
  "productEditorAddMenuItem": "إضافة عنصر منيو",
  "productEditorSaveFirst": "احفظ العنصر أولاً",
  "productEditorPreview": "معاينة",
  "productEditorBadge": "محرر عنصر منيو",
  "productEditorBadgeDesc": "عدّل السعر، الأحجام، الإضافات، الصور، ومحطة التحضير.",
  "productEditorNameSection": "الاسم والوصف",
  "productEditorNameSectionDesc": "نص ثنائي اللغة يظهر في بطاقات المنيو.",
  "productEditorArabicName": "الاسم بالعربية",
  "productEditorEnglishName": "الاسم بالإنجليزية",
  "productEditorArabicDesc": "الوصف بالعربية",
  "productEditorEnglishDesc": "الوصف بالإنجليزية",
  "productEditorPricingSection": "السعر والأحجام",
  "productEditorPricingSectionDesc": "السعر الأساسي وفروقات الأحجام.",
  "productEditorBasePrice": "السعر الأساسي",
  "productEditorAddVariant": "إضافة حجم / نوع",
  "productEditorAddPortionTitle": "إضافة حجم",
  "productEditorPortionKeyLabel": "المفتاح (مثل super)",
  "productEditorPortionPriceDelta": "فرق السعر (د.أ)",
  "productEditorEnterPortionKey": "أدخل مفتاحاً للحجم",
  "productEditorPortionAdded": "تمت إضافة الحجم",
  "productEditorPortionKeyExists": "المفتاح موجود مسبقاً",
  "productEditorModifiersSection": "الإضافات والتعديلات",
  "productEditorModifiersSectionDesc": "اربط إضافات الكatalog بهذا العنصر.",
  "productEditorNoAddons": "لا توجد إضافات بعد.",
  "productEditorMediaSection": "الصور والعرض",
  "productEditorMediaSectionDesc": "الصور وطريقة العرض في المنيو.",
  "productEditorMediaFallback": "لا صورة بعد — أضف من 1 إلى 5.",
  "productEditorPrepStationSection": "محطة التحضير",
  "productEditorPrepStationSectionDesc": "وجّه التذاكر إلى الممر الصحيح.",
  "productEditorAvailabilitySection": "التوفر والقنوات",
  "productEditorAvailabilitySectionDesc": "تحكم في ظهور العنصر حسب القناة.",
  "productEditorAvailableNow": "متاح للبيع الآن",
  "productEditorFeatured": "مميز في المنيو",
  "productEditorSavePublishSection": "حفظ ونشر",
  "productEditorSavePublishCreateDesc": "أنشئ العنصر ثم انشره على المنيو.",
  "productEditorSavePublishEditDesc": "يحفظ التعديلات على عناصر الكatalog والعناصر المخصصة.",
  "productEditorAddMinImages": "أضف صورة واحدة على الأقل (حتى 5)",
  "productEditorCheckRequiredFields": "تحقق من الحقول",
  "productEditorMenuItemSaved": "تم حفظ عنصر المنيو",
  "productEditorPublishToMenu": "نشر على المنيو",
  "productEditorPublishTitle": "نشر عنصر المنيو",
  "productEditorPublishMessage": "سيظهر العنصر في قنوات البيع المحددة.",
  "productEditorAddImageBeforePublish": "أضف صورة واحدة على الأقل قبل النشر",
  "productEditorCheckNamePrice": "تحقق من الاسم والسعر",
  "productEditorPublished": "تم النشر",
  "productEditorBackToMenu": "رجوع لإدارة المنيو",
  "productEditorPrepStationShawarma": "محطة الشاورما",
  "productEditorPrepStationFryer": "محطة المقالي",
  "productEditorPrepStationColdPrep": "تحضير بارد",
  "productEditorPrepStationDrinks": "المشروبات",
  "auditLogTrueTrailBadge": "سجل تدقيق حقيقي",
  "auditLogHeroHeadline": "تتبع من غيّر ماذا، متى، ومن أي منطقة تشغيلية.",
  "auditLogTodayEvents": "أحداث اليوم",
  "auditLogSensitiveChanges": "تغييرات حساسة",
  "auditLogNeedsReview": "بحاجة مراجعة",
  "auditLogRequestConfirmMessage": "سيتم تسجيل طلب تدقيق مفصل للمراجعة.",
  "auditLogExportLog": "تصدير السجل",
  "auditLogExportDownloaded": "تم تنزيل ملف التصدير",
  "auditLogTimelineSubtitle": "خط زمني للأحداث الإدارية والتشغيلية.",
  "auditLogNoEventsInScope": "لا أحداث في هذا النطاق.",
  "auditLogDetailedAuditRequested": "طلب تدقيق مفصل",
  "auditLogAuditExported": "تصدير سجل التدقيق",
  "auditLogShiftCloseApproved": "اعتماد إغلاق الوردية",
  "auditLogUserActivated": "تفعيل مستخدم",
  "auditLogUserDeactivated": "تعطيل مستخدم",
  "auditLogDepositSettingsSaved": "حفظ إعدادات العربون",
  "auditLogTrayBreakageArea": "كسر صواني",
  "auditLogInventoryArea": "المخزون",
  "auditLogUserRoleChanged": "تغيير صلاحية مستخدم",
  "auditLogCashierShiftClosed": "إغلاق وردية الكاشير",
  "auditLogTrayDepositEdited": "تعديل عربون الصواني",
  "auditLogFiltersTitle": "فلاتر التدقيق",
  "auditLogFiltersSubtitle": "اختر نطاق التدقيق بسرعة.",
  "auditLogGovernanceTitle": "حالة الحوكمة",
  "auditLogGovernanceSubtitle": "وضع الأمان والصلاحيات لهذه الوردية.",
  "auditLogFailedLogins": "محاولات دخول فاشلة",
  "auditLogPermissionChanges": "تغييرات صلاحية",
  "auditLogFinancialEdits": "تعديلات مالية",
  "auditLogInventorySubtitle": "آخر تعديلات المخزون.",
  "auditLogNoStockChanges": "لا تغييرات مخزون بعد.",
  "auditLogActorOwner": "المالك",
  "auditLogActorOperator": "المشغل",
  "auditLogActorFinance": "المالية",
  "auditLogActorLogistics": "المخزون",
  "auditLogActorSystem": "النظام",
  "auditLogAreaGovernance": "الحوكمة",
  "auditLogAreaReports": "التقارير",
  "auditLogAreaCashClose": "إغلاق الكاش",
  "auditLogAreaRolesPrivacy": "الأدوار والخصوصية",
  "auditLogAreaFinance": "المالية",
  "auditLogAreaAdminLog": "سجل الإدارة",
  "auditLogToday": "اليوم",
  "auditLogYesterday1820": "أمس 18:20",
  "auditLogToday0942": "اليوم 09:42",
  "auditLogToday0858": "اليوم 08:58",
  "auditLogActorOperatorAhmad": "المشغل أحمد",
  "auditLogActorCashierLayla": "الكاشير ليلى",
  "auditLogAuditRequestDetail": "تم تسجيل الطلب للمراجعة قبل نهاية الوردية.",
  "auditLogAuditExportDetail": "تم تنزيل ملف CSV للسجل.",
  "auditLogShiftCloseDetail": "تم اعتماد الإيراد والبقشيش والمرتجعات.",
  "auditLogDepositSavedDetail": "عربون {amount} د.أ · {hours} ساعة",
  "auditLogRoleChangeDetail": "تم نقل سارة من مطبخ إلى مشرفة محطة.",
  "auditLogCashierCloseDetail": "تم اعتماد الإيراد، البقشيش، والمرتجعات.",
  "auditLogTrayDepositEditDetail": "تم تحديث العربون العام ونافذة الإرجاع.",
  "auditLogSystemEntryDetail": "تم تسجيل حدث إداري تلقائي.",
  "orderDetailAdminSendUpdate": "إرسال تحديث",
  "orderDetailAdminOrderTotal": "إجمالي الطلب",
  "orderDetailAdminDeposit": "العربون",
  "orderDetailAdminOnRoute": "وقت في الطريق",
  "orderDetailAdminOnRouteValue": "٢٨ دقيقة",
  "orderDetailAdminSendGuestUpdateTitle": "إرسال تحديث للضيف",
  "orderDetailAdminUpdatePreparing": "الطلب قيد التحضير",
  "orderDetailAdminUpdateReady": "الطلب جاهز",
  "orderDetailAdminUpdateOnWay": "المندوب في الطريق",
  "orderDetailAdminUpdateDelay": "تأخير — نعتذر",
  "orderDetailAdminUpdateSent": "تم إرسال التحديث",
  "orderDetailAdminDelayNoticeSent": "تم إرسال تنبيه التأخير",
  "orderDetailAdminGuestPaymentTitle": "الضيف والدفع",
  "orderDetailAdminGuestPaymentSubtitle": "معلومات مختصرة للإغلاق والتواصل.",
  "orderDetailAdminGuestLabel": "العميل",
  "orderDetailAdminChannelLabel": "القناة",
  "orderDetailAdminFoodTotal": "المبلغ",
  "orderDetailAdminTrayDeposit": "عربون الصواني",
  "orderDetailAdminKitchenTicketTitle": "تذكرة المطبخ",
  "orderDetailAdminKitchenTicketSubtitle": "ملخص الأصناف والمحطة.",
  "orderDetailAdminPrepStationNote": "محطة التحضير",
  "orderDetailAdminOpenKitchen": "افتح المطبخ",
  "orderDetailAdminActionsTitle": "إجراءات الإدارة",
  "orderDetailAdminContactGuest": "اتصل بالعميل",
  "orderDetailAdminChangeStatus": "تعديل حالة الطلب",
  "orderDetailAdminChangeStatusTitle": "تعديل الحالة",
  "orderDetailAdminBackToBoard": "رجوع للوحة الطلبات",
  "orderDetailAdminPosReceived": "استلام الكاشير",
  "orderDetailAdminKitchenPrep": "تحضير المطبخ",
  "orderDetailAdminCloseSettle": "إغلاق وتسوية",
  "orderDetailAdminTimelineNext": "قادم",
  "orderDetailAdminTimelineTitle": "خط زمني للطلب",
  "orderDetailAdminTimelineSubtitle": "من التسجيل إلى التسوية.",
  "orderDetailAdminRisksTitle": "مخاطر وملاحظات",
  "orderDetailAdminDeliveryTiming": "وقت التوصيل",
  "orderDetailAdminNoDeposit": "لا يوجد عربون",
  "orderDetailAdminOperationalNote": "ملاحظة تشغيلية"
'''


def append_arb(path: Path, keys: str) -> None:
    text = path.read_text(encoding='utf-8')
    if text.rstrip().endswith('}'):
        text = text.rstrip()[:-1].rstrip()
        if not text.endswith(','):
            text += ','
        text += '\n' + keys.strip() + '\n}\n'
        path.write_text(text, encoding='utf-8')


def replace_all(path: Path, pairs: list[tuple[str, str]]) -> None:
    text = path.read_text(encoding='utf-8')
    misses = []
    for old, new in pairs:
        if old not in text:
            misses.append(old[:70])
        else:
            text = text.replace(old, new)
    path.write_text(text, encoding='utf-8')
    if misses:
        print(f'MISSES in {path.name}: {len(misses)}')
        for m in misses[:8]:
            print(' ', m)


def migrate_product_editor() -> None:
    p = ROOT / 'lib/screens/admin/admin_product_editor_screen.dart'
    pairs = [
        ("? (isAr ? 'إضافة عنصر منيو' : 'Add menu item')", '? l10n.productEditorAddMenuItem'),
        ("isAr ? 'احفظ العنصر أولاً' : 'Save the item first'", 'l10n.productEditorSaveFirst'),
        ("tooltip: isAr ? 'معاينة' : 'Preview'", 'tooltip: l10n.productEditorPreview'),
        ("label: isAr ? 'محرر عنصر منيو' : 'Menu Item Editor'", 'label: l10n.productEditorBadge'),
        ("title: isAr ? 'الاسم والوصف' : 'Name & Description'", 'title: l10n.productEditorNameSection'),
        ("label: isAr ? 'الاسم بالعربية' : 'Arabic name'", 'label: l10n.productEditorArabicName'),
        ("label: isAr ? 'الاسم بالإنجليزية' : 'English name'", 'label: l10n.productEditorEnglishName'),
        ("label: isAr ? 'الوصف بالعربية' : 'Arabic description'", 'label: l10n.productEditorArabicDesc'),
        ("label: isAr ? 'الوصف بالإنجليزية' : 'English description'", 'label: l10n.productEditorEnglishDesc'),
        ("title: isAr ? 'السعر والأحجام' : 'Pricing & Variants'", 'title: l10n.productEditorPricingSection'),
        ("label: isAr ? 'السعر الأساسي' : 'Base price'", 'label: l10n.productEditorBasePrice'),
        ("label: isAr ? 'إضافة حجم / نوع' : 'Add variant'", 'label: l10n.productEditorAddVariant'),
        ("title: Text(isAr ? 'إضافة حجم' : 'Add portion size')", 'title: Text(l10n.productEditorAddPortionTitle)'),
        ("label: isAr ? 'المفتاح (مثل super)' : 'Key (e.g. super)'", 'label: l10n.productEditorPortionKeyLabel'),
        ("label: isAr ? 'فرق السعر (د.أ)' : 'Price delta (JOD)'", 'label: l10n.productEditorPortionPriceDelta'),
        ("child: Text(isAr ? 'إلغاء' : 'Cancel')", 'child: Text(l10n.actionCancel)'),
        ("isAr ? 'أدخل مفتاحاً للحجم' : 'Enter a portion key'", 'l10n.productEditorEnterPortionKey'),
        ("? (isAr ? 'تمت إضافة الحجم' : 'Portion added')", '? l10n.productEditorPortionAdded'),
        (": (isAr ? 'المفتاح موجود مسبقاً' : 'Key already exists')", ': l10n.productEditorPortionKeyExists'),
        ("title: isAr ? 'الإضافات والتعديلات' : 'Modifiers'", 'title: l10n.productEditorModifiersSection'),
        ("isAr ? 'لا توجد إضافات بعد.' : 'No catalog addons yet.'", 'l10n.productEditorNoAddons'),
        ("title: isAr ? 'الصور والعرض' : 'Media & Display'", 'title: l10n.productEditorMediaSection'),
        ("title: isAr ? 'محطة التحضير' : 'Prep Station'", 'title: l10n.productEditorPrepStationSection'),
        ("title: isAr ? 'التوفر والقنوات' : 'Availability & Channels'", 'title: l10n.productEditorAvailabilitySection'),
        ("label: isAr ? 'متاح للبيع الآن' : 'Available now'", 'label: l10n.productEditorAvailableNow'),
        ("label: isAr ? 'مميز في المنيو' : 'Featured in menu'", 'label: l10n.productEditorFeatured'),
        ("label: isAr ? 'صالة' : 'Dine-in'", 'label: l10n.orderTypeDineIn'),
        ("label: isAr ? 'سفري' : 'Takeaway'", 'label: l10n.orderTypeTakeaway'),
        ("label: isAr ? 'توصيل' : 'Delivery'", 'label: l10n.orderTypeDelivery'),
        ("title: isAr ? 'حفظ ونشر' : 'Save & Publish'", 'title: l10n.productEditorSavePublishSection'),
        ("? (isAr ? 'أنشئ العنصر ثم انشره على المنيو.' : 'Create then publish to the menu.')", '? l10n.productEditorSavePublishCreateDesc'),
        ("isAr ? 'تحقق من الحقول' : 'Check required fields'", 'l10n.productEditorCheckRequiredFields'),
        ("isAr ? 'تم حفظ عنصر المنيو' : 'Menu item saved'", 'l10n.productEditorMenuItemSaved'),
        ("label: isAr ? 'نشر على المنيو' : 'Publish to menu'", 'label: l10n.productEditorPublishToMenu'),
        ("title: isAr ? 'نشر عنصر المنيو' : 'Publish menu item'", 'title: l10n.productEditorPublishTitle'),
        ("isAr ? 'تحقق من الاسم والسعر' : 'Check name and price'", 'l10n.productEditorCheckNamePrice'),
        ("isAr ? 'تم النشر' : 'Published'", 'l10n.productEditorPublished'),
        ("label: isAr ? 'رجوع لإدارة المنيو' : 'Back to menu management'", 'label: l10n.productEditorBackToMenu'),
        ("_PrepStation.shawarma => isAr ? 'محطة الشاورما' : 'Shawarma station'", '_PrepStation.shawarma => l10n.productEditorPrepStationShawarma'),
        ("_PrepStation.fryer => isAr ? 'محطة المقالي' : 'Fryer station'", '_PrepStation.fryer => l10n.productEditorPrepStationFryer'),
        ("_PrepStation.coldPrep => isAr ? 'تحضير بارد' : 'Cold prep'", '_PrepStation.coldPrep => l10n.productEditorPrepStationColdPrep'),
        ("_PrepStation.drinks => isAr ? 'المشروبات' : 'Drinks'", '_PrepStation.drinks => l10n.productEditorPrepStationDrinks'),
    ]
    replace_all(p, pairs)
    text = p.read_text(encoding='utf-8')
    multiline = [
        (
            """                  isAr
                      ? 'أضف صورة واحدة على الأقل (حتى 5)'
                      : 'Add at least 1 image (up to 5)',""",
            'l10n.productEditorAddMinImages,',
        ),
        (
            """                      isAr
                          ? 'سيظهر العنصر في قنوات البيع المحددة.'
                          : 'The item will appear in selected sales channels.',""",
            'l10n.productEditorPublishMessage,',
        ),
        (
            """                            isAr
                                ? 'أضف صورة واحدة على الأقل قبل النشر'
                                : 'Add at least 1 image before publishing',""",
            'l10n.productEditorAddImageBeforePublish,',
        ),
        (
            """              ? (isAr
                  ? 'يحفظ التعديلات على عناصر الكatalog والعناصر المخصصة.'
                  : 'Persists edits to catalog and custom menu items.')""",
            '? l10n.productEditorSavePublishEditDesc',
        ),
        (
            """          isAr
              ? 'تحكم في ظهور العنصر حسب القناة.'
              : 'Control where this item is visible.',""",
            'l10n.productEditorAvailabilitySectionDesc,',
        ),
        (
            """          isAr
              ? 'وجّه التذاكر إلى الممر الصحيح.'
              : 'Route tickets to the correct kitchen lane.',""",
            'l10n.productEditorPrepStationSectionDesc,',
        ),
        (
            """          isAr
              ? 'الصور وطريقة العرض في المنيو.'
              : 'Images and menu presentation.',""",
            'l10n.productEditorMediaSectionDesc,',
        ),
        (
            """          isAr
              ? 'اربط إضافات الكatalog بهذا العنصر.'
              : 'Attach catalog add-ons to this item.',""",
            'l10n.productEditorModifiersSectionDesc,',
        ),
        (
            """          isAr
              ? 'السعر الأساسي وفروقات الأحجام.'
              : 'Base price and portion/variant deltas.',""",
            'l10n.productEditorPricingSectionDesc,',
        ),
        (
            """          isAr
              ? 'نص ثنائي اللغة يظهر في بطاقات المنيو.'
              : 'Bilingual copy shown on customer menu cards.',""",
            'l10n.productEditorNameSectionDesc,',
        ),
        (
            """                  isAr
                      ? 'عدّل السعر، الأحجام، الإضافات، الصور، ومحطة التحضير.'
                      : 'Edit pricing, variants, modifiers, media, and station routing.',""",
            'l10n.productEditorBadgeDesc,',
        ),
    ]
    for old, new in multiline:
        if old in text:
            text = text.replace(old, new)
    p.write_text(text, encoding='utf-8')


def migrate_audit_log() -> None:
    p = ROOT / 'lib/screens/admin/admin_audit_log_screen.dart'
    pairs = [
        ("label: isAr ? 'سجل تدقيق حقيقي' : 'True Audit Trail'", 'label: l10n.auditLogTrueTrailBadge'),
        ("label: isAr ? 'أحداث اليوم' : 'Today events'", 'label: l10n.auditLogTodayEvents'),
        ("label: isAr ? 'تغييرات حساسة' : 'Sensitive changes'", 'label: l10n.auditLogSensitiveChanges'),
        ("label: isAr ? 'بحاجة مراجعة' : 'Needs review'", 'label: l10n.auditLogNeedsReview'),
        ("label: isAr ? 'تصدير السجل' : 'Export log'", 'label: l10n.auditLogExportLog'),
        ("isAr ? 'تم تنزيل ملف التصدير' : 'Export file downloaded'", 'l10n.auditLogExportDownloaded'),
        ("title: isAr ? 'طلب تدقيق مفصل' : 'Detailed audit requested'", 'title: l10n.auditLogDetailedAuditRequested'),
        ("title: isAr ? 'تصدير سجل التدقيق' : 'Audit log exported'", 'title: l10n.auditLogAuditExported'),
        ("title: isAr ? 'اعتماد إغلاق الوردية' : 'Shift close approved'", 'title: l10n.auditLogShiftCloseApproved'),
        ("? (isAr ? 'تفعيل مستخدم' : 'User activated')", '? l10n.auditLogUserActivated'),
        (": (isAr ? 'تعطيل مستخدم' : 'User deactivated')", ': l10n.auditLogUserDeactivated'),
        ("title: isAr ? 'حفظ إعدادات العربون' : 'Deposit settings saved'", 'title: l10n.auditLogDepositSettingsSaved'),
        ("area: isAr ? 'كسر صواني' : 'Tray breakage'", 'area: l10n.auditLogTrayBreakageArea'),
        ("area: isAr ? 'المخزون' : 'Inventory'", 'area: l10n.auditLogInventoryArea'),
        ("title: isAr ? 'تغيير صلاحية مستخدم' : 'User role changed'", 'title: l10n.auditLogUserRoleChanged'),
        ("title: isAr ? 'إغلاق وردية الكاشير' : 'Cashier shift closed'", 'title: l10n.auditLogCashierShiftClosed'),
        ("title: isAr ? 'تعديل عربون الصواني' : 'Tray deposit policy edited'", 'title: l10n.auditLogTrayDepositEdited'),
        ("title: isAr ? 'فلاتر التدقيق' : 'Audit Filters'", 'title: l10n.auditLogFiltersTitle'),
        ("subtitle: isAr ? 'اختر نطاق التدقيق بسرعة.' : 'Scope the log quickly.'", 'subtitle: l10n.auditLogFiltersSubtitle'),
        ("title: isAr ? 'حالة الحوكمة' : 'Governance Snapshot'", 'title: l10n.auditLogGovernanceTitle'),
        ("label: isAr ? 'محاولات دخول فاشلة' : 'Failed login attempts'", 'label: l10n.auditLogFailedLogins'),
        ("label: isAr ? 'تغييرات صلاحية' : 'Permission changes'", 'label: l10n.auditLogPermissionChanges'),
        ("label: isAr ? 'تعديلات مالية' : 'Financial edits'", 'label: l10n.auditLogFinancialEdits'),
        ("isAr ? 'لا تغييرات مخزون بعد.' : 'No stock changes yet.'", 'l10n.auditLogNoStockChanges'),
        ("actor: isAr ? 'المالك' : 'Owner'", 'actor: l10n.auditLogActorOwner'),
        ("actor: isAr ? 'المشغل' : 'Operator'", 'actor: l10n.auditLogActorOperator'),
        ("actor: isAr ? 'المالية' : 'Finance'", 'actor: l10n.auditLogActorFinance'),
        ("actor: isAr ? 'المخزون' : 'Logistics'", 'actor: l10n.auditLogActorLogistics'),
        ("actor: isAr ? 'النظام' : 'System'", 'actor: l10n.auditLogActorSystem'),
        ("area: isAr ? 'الحوكمة' : 'Governance'", 'area: l10n.auditLogAreaGovernance'),
        ("area: isAr ? 'التقارير' : 'Reports'", 'area: l10n.auditLogAreaReports'),
        ("area: isAr ? 'إغلاق الكاش' : 'Cash close'", 'area: l10n.auditLogAreaCashClose'),
        ("area: isAr ? 'الأدوار والخصوصية' : 'Roles & Privacy'", 'area: l10n.auditLogAreaRolesPrivacy'),
        ("area: isAr ? 'المالية' : 'Finance'", 'area: l10n.auditLogAreaFinance'),
        ("area: isAr ? 'سجل الإدارة' : 'Admin log'", 'area: l10n.auditLogAreaAdminLog'),
        ("time: isAr ? 'اليوم' : 'Today'", 'time: l10n.auditLogToday'),
        ("time: isAr ? 'أمس 18:20' : 'Yesterday 18:20'", 'time: l10n.auditLogYesterday1820'),
        ("time: isAr ? 'اليوم 09:42' : 'Today 09:42'", 'time: l10n.auditLogToday0942'),
        ("time: isAr ? 'اليوم 08:58' : 'Today 08:58'", 'time: l10n.auditLogToday0858'),
        ("actor: isAr ? 'المشغل أحمد' : 'Operator Ahmad'", 'actor: l10n.auditLogActorOperatorAhmad'),
        ("actor: isAr ? 'الكاشير ليلى' : 'Cashier Layla'", 'actor: l10n.auditLogActorCashierLayla'),
        ("_SecuritySnapshotCard(isAr: isAr)", '_SecuritySnapshotCard(l10n: l10n, isAr: isAr)'),
    ]
    replace_all(p, pairs)
    text = p.read_text(encoding='utf-8')
    multiline = [
        (
            """            isAr
                ? 'تتبع من غيّر ماذا، متى، ومن أي منطقة تشغيلية.'
                : 'Track who changed what, when, and from which operational area.',""",
            'l10n.auditLogHeroHeadline,',
        ),
        (
            """                                isAr
                                    ? 'سيتم تسجيل طلب تدقيق مفصل للمراجعة.'
                                    : 'A detailed audit request will be logged for review.',""",
            'l10n.auditLogRequestConfirmMessage,',
        ),
        (
            """          isAr
              ? 'خط زمني للأحداث الإدارية والتشغيلية.'
              : 'Timeline of administrative and operational events.',""",
            'l10n.auditLogTimelineSubtitle,',
        ),
        (
            """                  isAr
                      ? 'لا أحداث في هذا النطاق.'
                      : 'No events in this scope.',""",
            'l10n.auditLogNoEventsInScope,',
        ),
        (
            """            isAr
                ? 'تم تسجيل الطلب للمراجعة قبل نهاية الوردية.'
                : 'Request logged for review before shift close.',""",
            'l10n.auditLogAuditRequestDetail,',
        ),
        (
            """            isAr
                ? 'تم تنزيل ملف CSV للسجل.'
                : 'CSV audit file downloaded.',""",
            'l10n.auditLogAuditExportDetail,',
        ),
        (
            """            isAr
                ? 'تم اعتماد الإيراد والبقشيش والمرتجعات.'
                : 'Revenue, tips, and refunds approved.',""",
            'l10n.auditLogShiftCloseDetail,',
        ),
        (
            """            isAr
                ? 'عربون ${deposit.globalDepositJod.toStringAsFixed(2)} د.أ · ${deposit.returnWindowHours.round()} ساعة'
                : 'Deposit ${deposit.globalDepositJod.toStringAsFixed(2)} JOD · ${deposit.returnWindowHours.round()}h window',""",
            "l10n.auditLogDepositSavedDetail(deposit.globalDepositJod.toStringAsFixed(2), '${deposit.returnWindowHours.round()}'),",
        ),
        (
            """          isAr
              ? 'تم نقل سارة من مطبخ إلى مشرفة محطة.'
              : 'Sara moved from Kitchen to Station Supervisor.',""",
            'l10n.auditLogRoleChangeDetail,',
        ),
        (
            """          isAr
              ? 'تم اعتماد الإيراد، البقشيش، والمرتجعات.'
              : 'Revenue, tips, and refunds were approved.',""",
            'l10n.auditLogCashierCloseDetail,',
        ),
        (
            """          isAr
              ? 'تم تحديث العربون العام ونافذة الإرجاع.'
              : 'Global deposit and return window updated.',""",
            'l10n.auditLogTrayDepositEditDetail,',
        ),
        (
            """          isAr
              ? 'وضع الأمان والصلاحيات لهذه الوردية.'
              : 'Security and permission posture for this shift.',""",
            'l10n.auditLogGovernanceSubtitle,',
        ),
        (
            """          isAr
              ? 'آخر تعديلات المخزون.'
              : 'Recent stock adjustments from inventory.',""",
            'l10n.auditLogInventorySubtitle,',
        ),
    ]
    for old, new in multiline:
        if old in text:
            text = text.replace(old, new)
    # SecuritySnapshotCard l10n field
    text = text.replace(
        'class _SecuritySnapshotCard extends ConsumerWidget {\n  const _SecuritySnapshotCard({required this.isAr});\n\n  final bool isAr;',
        'class _SecuritySnapshotCard extends ConsumerWidget {\n  const _SecuritySnapshotCard({required this.l10n, required this.isAr});\n\n  final AppLocalizations l10n;\n  final bool isAr;',
    )
    p.write_text(text, encoding='utf-8')


def migrate_order_detail() -> None:
    p = ROOT / 'lib/screens/admin/admin_order_detail_screen.dart'
    pairs = [
        ("() => _sendGuestUpdate(context, ref, order, isAr)", '() => _sendGuestUpdate(context, ref, order, l10n)'),
        ("tooltip: isAr ? 'إرسال تحديث' : 'Send update'", 'tooltip: l10n.orderDetailAdminSendUpdate'),
        ("label: isAr ? 'إجمالي الطلب' : 'Order total'", 'label: l10n.orderDetailAdminOrderTotal'),
        ("label: isAr ? 'العربون' : 'Deposit'", 'label: l10n.orderDetailAdminDeposit'),
        ("label: isAr ? 'وقت في الطريق' : 'On route'", 'label: l10n.orderDetailAdminOnRoute'),
        ("value: isAr ? '٢٨ دقيقة' : '28 min'", 'value: l10n.orderDetailAdminOnRouteValue'),
        ("title: isAr ? 'إرسال تحديث للضيف' : 'Send guest update'", 'title: l10n.orderDetailAdminSendGuestUpdateTitle'),
        ("label: isAr ? 'الطلب قيد التحضير' : 'Order is preparing'", 'label: l10n.orderDetailAdminUpdatePreparing'),
        ("label: isAr ? 'الطلب جاهز' : 'Order is ready'", 'label: l10n.orderDetailAdminUpdateReady'),
        ("label: isAr ? 'المندوب في الطريق' : 'Driver is on the way'", 'label: l10n.orderDetailAdminUpdateOnWay'),
        ("label: isAr ? 'تأخير — نعتذر' : 'Delay — we apologize'", 'label: l10n.orderDetailAdminUpdateDelay'),
        ("isAr ? 'تم إرسال التحديث' : 'Update sent'", 'l10n.orderDetailAdminUpdateSent'),
        ("isAr ? 'تم إرسال تنبيه التأخير' : 'Delay notice sent'", 'l10n.orderDetailAdminDelayNoticeSent'),
        ("title: isAr ? 'الضيف والدفع' : 'Guest & Payment'", 'title: l10n.orderDetailAdminGuestPaymentTitle'),
        ("label: isAr ? 'العميل' : 'Guest'", 'label: l10n.orderDetailAdminGuestLabel'),
        ("label: isAr ? 'القناة' : 'Channel'", 'label: l10n.orderDetailAdminChannelLabel'),
        ("label: isAr ? 'المبلغ' : 'Food total'", 'label: l10n.orderDetailAdminFoodTotal'),
        ("label: isAr ? 'عربون الصواني' : 'Tray deposit'", 'label: l10n.orderDetailAdminTrayDeposit'),
        ("title: isAr ? 'تذكرة المطبخ' : 'Kitchen Ticket'", 'title: l10n.orderDetailAdminKitchenTicketTitle'),
        ("subtitle: isAr ? 'ملخص الأصناف والمحطة.' : 'Items and station summary.'", 'subtitle: l10n.orderDetailAdminKitchenTicketSubtitle'),
        ("note: isAr ? 'محطة التحضير' : 'Prep station'", 'note: l10n.orderDetailAdminPrepStationNote'),
        ("label: isAr ? 'افتح المطبخ' : 'Open kitchen pass'", 'label: l10n.orderDetailAdminOpenKitchen'),
        ("title: isAr ? 'إجراءات الإدارة' : 'Admin Actions'", 'title: l10n.orderDetailAdminActionsTitle'),
        ("label: isAr ? 'اتصل بالعميل' : 'Contact guest'", 'label: l10n.orderDetailAdminContactGuest'),
        ("label: isAr ? 'تعديل حالة الطلب' : 'Change order status'", 'label: l10n.orderDetailAdminChangeStatus'),
        ("title: isAr ? 'تعديل الحالة' : 'Change status'", 'title: l10n.orderDetailAdminChangeStatusTitle'),
        ("label: isAr ? 'رجوع للوحة الطلبات' : 'Back to order board'", 'label: l10n.orderDetailAdminBackToBoard'),
        ("title: isAr ? 'استلام الكاشير' : 'POS received'", 'title: l10n.orderDetailAdminPosReceived'),
        ("title: isAr ? 'تحضير المطبخ' : 'Kitchen prep'", 'title: l10n.orderDetailAdminKitchenPrep'),
        ("title: isAr ? 'إغلاق وتسوية' : 'Close & settle'", 'title: l10n.orderDetailAdminCloseSettle'),
        ("time: isAr ? 'قادم' : 'Next'", 'time: l10n.orderDetailAdminTimelineNext'),
        ("title: isAr ? 'خط زمني للطلب' : 'Order Timeline'", 'title: l10n.orderDetailAdminTimelineTitle'),
        ("subtitle: isAr ? 'من التسجيل إلى التسوية.' : 'From entry to settlement.'", 'subtitle: l10n.orderDetailAdminTimelineSubtitle'),
        ("title: isAr ? 'مخاطر وملاحظات' : 'Risks & Notes'", 'title: l10n.orderDetailAdminRisksTitle'),
        ("label: isAr ? 'وقت التوصيل' : 'Delivery timing'", 'label: l10n.orderDetailAdminDeliveryTiming'),
        (": (isAr ? 'لا يوجد عربون' : 'No deposit')", ': l10n.orderDetailAdminNoDeposit'),
        ("label: isAr ? 'ملاحظة تشغيلية' : 'Operational note'", 'label: l10n.orderDetailAdminOperationalNote'),
        ('  bool isAr,\n)', '  AppLocalizations l10n,\n)'),
        ('void _sendGuestUpdate(\n  BuildContext context,\n  WidgetRef ref,\n  ModelOrderSummary order,\n  bool isAr,\n)', 'void _sendGuestUpdate(\n  BuildContext context,\n  WidgetRef ref,\n  ModelOrderSummary order,\n  AppLocalizations l10n,\n)'),
    ]
    replace_all(p, pairs)
    text = p.read_text(encoding='utf-8')
    text = text.replace(
        """          isAr
              ? 'معلومات مختصرة للإغلاق والتواصل.'
              : 'Key context for closing and contact.',""",
        'l10n.orderDetailAdminGuestPaymentSubtitle,',
    )
    p.write_text(text, encoding='utf-8')


def main() -> None:
    append_arb(ROOT / 'lib/l10n/app_en.arb', EN_KEYS)
    append_arb(ROOT / 'lib/l10n/app_ar.arb', AR_KEYS)
    migrate_product_editor()
    migrate_audit_log()
    migrate_order_detail()
    print('Batch 6 migration complete')


if __name__ == '__main__':
    main()

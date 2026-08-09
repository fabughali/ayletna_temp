#!/usr/bin/env python3
"""Batch 7: settings, orders management, financial close l10n."""
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]

EN = """
  "commonOpen": "Open",
  "settingsOpsBadge": "Operations Settings",
  "settingsOpsHeroHeadline": "Control hours, stations, order rules, delivery zones, taxes, receipts, and alerts.",
  "settingsAppAdminHeroHeadline": "System configuration, integrations, and platform permissions.",
  "settingsHeroNineSections": "9 sections",
  "settingsHeroUiOnly": "UI only",
  "settingsHeroDrawerNav": "Drawer navigation",
  "settingsBusinessHoursTitle": "Business Hours & Order Rules",
  "settingsBusinessHoursSubtitle": "Set service state, prep rules, and pre-order behavior.",
  "settingsAcceptingOrders": "Accepting orders now",
  "settingsDeliveryEnabled": "Delivery enabled now",
  "settingsTodayHours": "Today hours",
  "settingsTodayHoursValue": "8:00 AM - 12:00 AM",
  "settingsPreOrdersLabel": "Pre-orders",
  "settingsPreOrdersDetail": "Up to 3 days ahead",
  "settingsStationsTitle": "Stations & Operating Rules",
  "settingsStationsSubtitle": "Route menu items to kitchen stations and prep rules.",
  "settingsShawarmaStation": "Shawarma station",
  "settingsShawarmaPrepDetail": "8 min average prep",
  "settingsFryerStation": "Fryer station",
  "settingsFryerLoadDetail": "Load limit 12 tickets",
  "settingsLateTicketThreshold": "Late-ticket threshold",
  "settingsLateTicketDetail": "Escalate after 15 minutes",
  "settingsSystemPlatformTitle": "System & platform",
  "settingsSystemPlatformSubtitle": "Integrations, users, roles, and audit.",
  "settingsIntegrationsDetail": "Supabase, SMS, payments",
  "settingsAuditTrailDetail": "Full platform audit trail",
  "settingsStaffTitle": "Staff & attendance",
  "settingsStaffSubtitle": "Shift roster, attendance, and approvals.",
  "settingsStaffHoursDetail": "Shifts, attendance, and hours",
  "settingsAttendanceHrLabel": "Attendance & HR",
  "settingsAttendanceHrDetail": "Attendance log and approvals",
  "settingsFeesTaxesTitle": "Fees & Taxes",
  "settingsFeesTaxesSubtitle": "Delivery fees, tax display, and receipt layout.",
  "settingsDeliveryFeesLabel": "Delivery fees",
  "settingsDeliveryFeesDetail": "Zone-based delivery charge rules",
  "settingsReceiptTemplateLabel": "Receipt template",
  "settingsReceiptTemplateDetail": "Logo, footer, and tax line layout",
  "settingsNotificationsTitle": "Notifications & Alerts",
  "settingsNotificationsSubtitle": "Kitchen, inventory, and tray-return alerts.",
  "settingsKitchenAlertsDetail": "Prep delay and station overload",
  "settingsLowStockAlert": "Low stock alert",
  "settingsLowStockDetail": "Below 15% threshold",
  "settingsTrayReturnReminders": "Tray return reminders",
  "settingsTrayReturnDetail": "60 minutes after delivery",
  "settingsAppAdminShortcuts": "App admin shortcuts",
  "settingsOpsShortcuts": "Operations shortcuts",
  "settingsShortcutsSubtitle": "Jump to high-traffic admin screens.",
  "settingsAttendancePayrollShortcut": "Attendance & payroll",
  "settingsPreOrdersShortcut": "Pre-orders",
  "ordersMgmtFilterTitle": "Filter order board",
  "ordersMgmtFilterMessage": "Filter by channel, station, or delay status.",
  "ordersMgmtFilterTooltip": "Filter",
  "ordersMgmtLaneNeedsDecision": "Needs Decision",
  "ordersMgmtLaneNeedsDecisionSub": "Late, missing, or escalated",
  "ordersMgmtLanePreparing": "Preparing",
  "ordersMgmtLanePreparingSub": "Kitchen in progress",
  "ordersMgmtLaneReadyRoute": "Ready / On Route",
  "ordersMgmtLaneReadyRouteSub": "Pickup and delivery handoff",
  "ordersMgmtHeroBadge": "Live Order Board",
  "ordersMgmtOpenOrders": "Open orders",
  "ordersMgmtActiveValue": "Active value",
  "ordersMgmtPlatedOrders": "Plated orders",
  "ordersMgmtEmptyLane": "No orders here",
  "ordersMgmtOpenDetail": "Open detail",
  "ordersMgmtEscalate": "Escalate",
  "ordersMgmtEscalationLogged": "Escalation logged",
  "ordersMgmtRecentlyClosed": "Recently Closed",
  "ordersMgmtHistory": "History",
  "ordersMgmtDeliveredStatus": "Delivered",
  "financialCloseBadge": "Cash Close & Profit Split",
  "financialCloseHeroHeadline": "Reconcile shift revenue, cash, cards, deposits, tips, then approve net profit.",
  "financialCloseShiftRevenue": "Shift revenue",
  "financialCloseOrdersCount": "Orders",
  "financialCloseDistributableNet": "Distributable net",
  "financialCloseSummaryTitle": "Shift Close Summary",
  "financialCloseSummarySubtitle": "Operational numbers before approving the close.",
  "financialCloseStatusLabel": "Status",
  "financialCloseStatusReady": "Ready to close",
  "financialCloseTenderTitle": "Tender Reconciliation",
  "financialCloseTenderSubtitle": "Cash, card, and wallet must match the cashier ledger.",
  "financialCloseCash": "Cash",
  "financialCloseCards": "Cards",
  "financialCloseWallet": "Wallet",
  "financialCloseDepositsTitle": "Deposits & Refunds",
  "financialCloseDepositsSubtitle": "Tray deposits, refunds, and breakage exposure.",
  "financialCloseRefundsToday": "Refunds today",
  "financialCloseBreakageFees": "Potential breakage fees",
  "financialCloseReviewTrayReturns": "Review tray returns",
  "financialCloseTipsTitle": "Tips & Variance",
  "financialCloseTipsSubtitle": "Shift tip pool and reconciliation variance.",
  "financialCloseCurrentTips": "Current shift tips",
  "financialCloseVariance": "Reconciliation variance",
  "financialCloseSplitTitle": "Net Profit Split",
  "financialCloseSplitSubtitle": "Owner and operator shares after costs and tips.",
  "financialCloseApproveTitle": "Approve Close",
  "financialCloseOwnerViewOnly": "Owner view only",
  "financialCloseApprovedReadOnly": "Close approved (read-only)",
  "financialCloseAwaitingApproval": "Awaiting operator approval",
  "financialCloseApproveSubtitle": "Lock the shift after reconciliation checks.",
  "financialCloseApproveShift": "Approve shift close",
  "financialCloseApproveConfirmTitle": "Approve close",
  "financialCloseApproveConfirmMessage": "This will lock shift totals for audit.",
  "financialCloseApprovedSuccess": "Shift close approved"
"""

AR = """
  "commonOpen": "فتح",
  "settingsOpsBadge": "إعدادات التشغيل",
  "settingsOpsHeroHeadline": "تحكم بساعات العمل، المحطات، قواعد الطلبات، مناطق التوصيل، الضرائب، الإيصالات، والتنبيهات.",
  "settingsAppAdminHeroHeadline": "إعدادات النظام، التكاملات، وصلاحيات المنصة.",
  "settingsHeroNineSections": "٩ أقسام",
  "settingsHeroUiOnly": "واجهة فقط",
  "settingsHeroDrawerNav": "درج تنقل",
  "settingsBusinessHoursTitle": "ساعات العمل وقواعد الطلب",
  "settingsBusinessHoursSubtitle": "حدد حالة الاستقبال والتحضير والطلبات المسبقة.",
  "settingsAcceptingOrders": "استقبال الطلبات مفتوح",
  "settingsDeliveryEnabled": "التوصيل متاح الآن",
  "settingsTodayHours": "ساعات اليوم",
  "settingsTodayHoursValue": "٨:٠٠ صباحاً - ١٢:٠٠ ليلاً",
  "settingsPreOrdersLabel": "الطلبات المسبقة",
  "settingsPreOrdersDetail": "حتى ٣ أيام مقدماً",
  "settingsStationsTitle": "المحطات وقواعد التشغيل",
  "settingsStationsSubtitle": "اربط المنيو بمحطات المطبخ والتحضير.",
  "settingsShawarmaStation": "محطة الشاورما",
  "settingsShawarmaPrepDetail": "متوسط التحضير ٨ دقائق",
  "settingsFryerStation": "محطة المقALI",
  "settingsFryerLoadDetail": "حد ضغط ١٢ تذكرة",
  "settingsLateTicketThreshold": "حد قبول الطلب المتأخر",
  "settingsLateTicketDetail": "١٥ دقيقة قبل التصعيد",
  "settingsSystemPlatformTitle": "النظام والمنصة",
  "settingsSystemPlatformSubtitle": "تكاملات، مستخدمون، أدوار، وتدقيق.",
  "settingsIntegrationsDetail": "Supabase، SMS، الدفع",
  "settingsAuditTrailDetail": "سجل كامل للمنصة",
  "settingsStaffTitle": "الطاقم والحضور",
  "settingsStaffSubtitle": "الورديات والحضور والموافقات.",
  "settingsStaffHoursDetail": "ورديات وحضور وساعات",
  "settingsAttendanceHrLabel": "الحضور والموارد البشرية",
  "settingsAttendanceHrDetail": "سجل الحضور والموافقات",
  "settingsFeesTaxesTitle": "الرسوم والضرائب",
  "settingsFeesTaxesSubtitle": "رسوم التوصيل وعرض الضريبة وتخطيط الإيصال.",
  "settingsDeliveryFeesLabel": "رسوم التوصيل",
  "settingsDeliveryFeesDetail": "قواعد رسوم التوصيل حسب المنطقة",
  "settingsReceiptTemplateLabel": "نموذج الإيصال",
  "settingsReceiptTemplateDetail": "الشعار والتذييل وسطر الضريبة",
  "settingsNotificationsTitle": "الإشعارات والتنبيهات",
  "settingsNotificationsSubtitle": "تنبيهات المطبخ والمخزون وإرجاع الصواني.",
  "settingsKitchenAlertsDetail": "تأخير التحضير وضغط المحطة",
  "settingsLowStockAlert": "إشعار نقص المخزون",
  "settingsLowStockDetail": "عند أقل من ١٥٪",
  "settingsTrayReturnReminders": "تذكير إرجاع الصواني",
  "settingsTrayReturnDetail": "بعد ٦٠ دقيقة من التسليم",
  "settingsAppAdminShortcuts": "اختصارات مدير التطبيق",
  "settingsOpsShortcuts": "اختصارات التشغيل",
  "settingsShortcutsSubtitle": "انتقل بسرعة إلى الشاشات الإدارية.",
  "settingsAttendancePayrollShortcut": "الحضور والرواتب",
  "settingsPreOrdersShortcut": "الطلبات المسبقة",
  "ordersMgmtFilterTitle": "فلترة لوحة الطلبات",
  "ordersMgmtFilterMessage": "فلترة حسب القناة، المحطة، أو حالة التأخير.",
  "ordersMgmtFilterTooltip": "فلترة",
  "ordersMgmtLaneNeedsDecision": "بانتظار القرار",
  "ordersMgmtLaneNeedsDecisionSub": "تأخير أو نقص أو تصعيد",
  "ordersMgmtLanePreparing": "في التحضير",
  "ordersMgmtLanePreparingSub": "تحت متابعة المطبخ",
  "ordersMgmtLaneReadyRoute": "جاهز / في الطريق",
  "ordersMgmtLaneReadyRouteSub": "تسليم الاستلام والتوصيل",
  "ordersMgmtHeroBadge": "لوحة الطلبات الحية",
  "ordersMgmtOpenOrders": "طلبات مفتوحة",
  "ordersMgmtActiveValue": "قيمة نشطة",
  "ordersMgmtPlatedOrders": "طلبات صواني",
  "ordersMgmtEmptyLane": "لا توجد طلبات هنا",
  "ordersMgmtOpenDetail": "افتح التفاصيل",
  "ordersMgmtEscalate": "تصعيد",
  "ordersMgmtEscalationLogged": "تم تسجيل التصعيد",
  "ordersMgmtRecentlyClosed": "أغلقت مؤخراً",
  "ordersMgmtHistory": "السجل",
  "ordersMgmtDeliveredStatus": "تم التسليم",
  "financialCloseBadge": "إغلاق كاش وتقسيم أرباح",
  "financialCloseHeroHeadline": "راجع الوردية، النقد، البطاقات، العربون، البقشيش، ثم اعتمد صافي الربح.",
  "financialCloseShiftRevenue": "إيراد الوردية",
  "financialCloseOrdersCount": "طلبات",
  "financialCloseDistributableNet": "صافي قابل للتوزيع",
  "financialCloseSummaryTitle": "ملخص إغلاق الوردية",
  "financialCloseSummarySubtitle": "القراءة العملية قبل اعتماد الإغلاق.",
  "financialCloseStatusLabel": "الحالة",
  "financialCloseStatusReady": "جاهز للإغلاق",
  "financialCloseTenderTitle": "مطابقة طرق الدفع",
  "financialCloseTenderSubtitle": "النقد والبطاقات والمحفظة يجب أن تطابق سجل الكاشير.",
  "financialCloseCash": "نقد",
  "financialCloseCards": "بطاقات",
  "financialCloseWallet": "محفظة",
  "financialCloseDepositsTitle": "العربون والمرتجعات",
  "financialCloseDepositsSubtitle": "عربون الصواني والاستردادات ومخاطر الكسر.",
  "financialCloseRefundsToday": "استردادات اليوم",
  "financialCloseBreakageFees": "رسوم كسر محتملة",
  "financialCloseReviewTrayReturns": "راجع إرجاع الصواني",
  "financialCloseTipsTitle": "البقشيش والفروقات",
  "financialCloseTipsSubtitle": "بقشيش الوردية وفروقات المطابقة.",
  "financialCloseCurrentTips": "بقشيش الوردية الحالية",
  "financialCloseVariance": "فرق المطابقة",
  "financialCloseSplitTitle": "تقسيم صافي الربح",
  "financialCloseSplitSubtitle": "حصص المالك والمشغل بعد التكاليف والبقشيش.",
  "financialCloseApproveTitle": "اعتماد الإغلاق",
  "financialCloseOwnerViewOnly": "عرض للمالك فقط",
  "financialCloseApprovedReadOnly": "الإغلاق معتمد (قراءة فقط)",
  "financialCloseAwaitingApproval": "بانتظار اعتماد المشغل",
  "financialCloseApproveSubtitle": "قفل الوردية بعد اكتمال المطابقة.",
  "financialCloseApproveShift": "اعتماد إغلاق الوردية",
  "financialCloseApproveConfirmTitle": "اعتماد الإغلاق",
  "financialCloseApproveConfirmMessage": "سيتم قفل إجماليات الوردية للتدقيق.",
  "financialCloseApprovedSuccess": "تم اعتماد الإغلاق"
"""


def append_arb(path: Path, keys: str) -> None:
    text = path.read_text(encoding='utf-8').rstrip()
    if text.endswith('}'):
        text = text[:-1].rstrip()
        if not text.endswith(','):
            text += ','
        text += '\n' + keys.strip() + '\n}\n'
        path.write_text(text, encoding='utf-8')


def replace_file(path: Path, pairs: list[tuple[str, str]], multiline: list[tuple[str, str]] | None = None) -> None:
    text = path.read_text(encoding='utf-8')
    misses = 0
    for old, new in pairs:
        if old not in text:
            misses += 1
        else:
            text = text.replace(old, new)
    if multiline:
        for old, new in multiline:
            if old in text:
                text = text.replace(old, new)
            else:
                misses += 1
    path.write_text(text, encoding='utf-8')
    if misses:
        print(f'{path.name}: {misses} misses')


def migrate_settings() -> None:
    p = ROOT / 'lib/screens/admin/admin_settings_screen.dart'
    pairs = [
        ("isAr ? 'إعدادات التشغيل' : 'Operations Settings'", 'l10n.settingsOpsBadge'),
        ("label: isAr ? '٩ أقسام' : '9 sections'", 'label: l10n.settingsHeroNineSections'),
        ("label: isAr ? 'واجهة فقط' : 'UI only'", 'label: l10n.settingsHeroUiOnly'),
        ("label: isAr ? 'درج تنقل' : 'Drawer navigation'", 'label: l10n.settingsHeroDrawerNav'),
        ("title: isAr ? 'ساعات العمل وقواعد الطلب' : 'Business Hours & Order Rules'", 'title: l10n.settingsBusinessHoursTitle'),
        ("label: isAr ? 'استقبال الطلبات مفتوح' : 'Accepting orders now'", 'label: l10n.settingsAcceptingOrders'),
        ("label: isAr ? 'التوصيل متاح الآن' : 'Delivery enabled now'", 'label: l10n.settingsDeliveryEnabled'),
        ("label: isAr ? 'ساعات اليوم' : 'Today hours'", 'label: l10n.settingsTodayHours'),
        ("detail: isAr ? '٨:٠٠ صباحاً - ١٢:٠٠ ليلاً' : '8:00 AM - 12:00 AM'", 'detail: l10n.settingsTodayHoursValue'),
        ("label: isAr ? 'الطلبات المسبقة' : 'Pre-orders'", 'label: l10n.settingsPreOrdersLabel'),
        ("detail: isAr ? 'حتى ٣ أيام مقدماً' : 'Up to 3 days ahead'", 'detail: l10n.settingsPreOrdersDetail'),
        ("actionLabel: isAr ? 'فتح' : 'Open'", 'actionLabel: l10n.commonOpen'),
        ("title: isAr ? 'المحطات وقواعد التشغيل' : 'Stations & Operating Rules'", 'title: l10n.settingsStationsTitle'),
        ("label: isAr ? 'محطة الشاورما' : 'Shawarma station'", 'label: l10n.settingsShawarmaStation'),
        ("detail: isAr ? 'متوسط التحضير ٨ دقائق' : '8 min average prep'", 'detail: l10n.settingsShawarmaPrepDetail'),
        ("label: isAr ? 'محطة المقALI' : 'Fryer station'", 'label: l10n.settingsFryerStation'),
        ("detail: isAr ? 'حد ضغط ١٢ تذكرة' : 'Load limit 12 tickets'", 'detail: l10n.settingsFryerLoadDetail'),
        ("label: isAr ? 'حد قبول الطلب المتأخر' : 'Late-ticket threshold'", 'label: l10n.settingsLateTicketThreshold'),
        ("detail: isAr ? '١٥ دقيقة قبل التصعيد' : 'Escalate after 15 minutes'", 'detail: l10n.settingsLateTicketDetail'),
        ("title: isAr ? 'النظام والمنصة' : 'System & platform'", 'title: l10n.settingsSystemPlatformTitle'),
        ("detail: isAr ? 'Supabase، SMS، الدفع' : 'Supabase, SMS, payments'", 'detail: l10n.settingsIntegrationsDetail'),
        ("detail: isAr ? 'سجل كامل للمنصة' : 'Full platform audit trail'", 'detail: l10n.settingsAuditTrailDetail'),
        ("title: isAr ? 'الطاقم والحضور' : 'Staff & attendance'", 'title: l10n.settingsStaffTitle'),
        ("isAr ? 'ورديات وحضور وساعات' : 'Shifts, attendance, and hours'", 'l10n.settingsStaffHoursDetail'),
        ("label: isAr ? 'الحضور والموارد البشرية' : 'Attendance & HR'", 'label: l10n.settingsAttendanceHrLabel'),
        ("detail: isAr ? 'سجل الحضور والموافقات' : 'Attendance log and approvals'", 'detail: l10n.settingsAttendanceHrDetail'),
        ("title: isAr ? 'الرسوم والضرائب' : 'Fees & Taxes'", 'title: l10n.settingsFeesTaxesTitle'),
        ("label: isAr ? 'رسوم التوصيل' : 'Delivery fees'", 'label: l10n.settingsDeliveryFeesLabel'),
        ("label: isAr ? 'نموذج الإيصال' : 'Receipt template'", 'label: l10n.settingsReceiptTemplateLabel'),
        ("title: isAr ? 'الإشعارات والتنبيهات' : 'Notifications & Alerts'", 'title: l10n.settingsNotificationsTitle'),
        ("label: isAr ? 'إشعار نقص المخزون' : 'Low stock alert'", 'label: l10n.settingsLowStockAlert'),
        ("detail: isAr ? 'عند أقل من ١٥٪' : 'Below 15% threshold'", 'detail: l10n.settingsLowStockDetail'),
        ("label: isAr ? 'تذكير إرجاع الصواني' : 'Tray return reminders'", 'label: l10n.settingsTrayReturnReminders'),
        ("isAr ? 'بعد ٦٠ دقيقة من التسليم' : '60 minutes after delivery'", 'l10n.settingsTrayReturnDetail'),
        ("? (isAr ? 'اختصارات مدير التطبيق' : 'App admin shortcuts')", '? l10n.settingsAppAdminShortcuts'),
        (": (isAr ? 'اختصارات التشغيل' : 'Operations shortcuts')", ': l10n.settingsOpsShortcuts'),
        ("label: isAr ? 'الحضور والرواتب' : 'Attendance & payroll'", 'label: l10n.settingsAttendancePayrollShortcut'),
        ("label: isAr ? 'الطلبات المسبقة' : 'Pre-orders'", 'label: l10n.settingsPreOrdersShortcut'),
    ]
    # Fix fryer station - script had typo in AR key, use correct Arabic in pairs
    pairs = [(a.replace('المقALI', 'المقالي'), b) for a, b in pairs]
    multiline = [
        (
            """                ? (isAr
                    ? 'إعدادات النظام، التكاملات، وصلاحيات المنصة.'
                    : 'System configuration, integrations, and platform permissions.')
                : (isAr
                    ? 'تحكم بساعات العمل، المحطات، قواعد الطلبات، مناطق التوصيل، الضرائب، الإيصالات، والتنبيهات.'
                    : 'Control hours, stations, order rules, delivery zones, taxes, receipts, and alerts.'),""",
            """appAdmin
                ? l10n.settingsAppAdminHeroHeadline
                : l10n.settingsOpsHeroHeadline,""",
        ),
        (
            """          isAr
              ? 'حدد حالة الاستقبال والتحضير والطلبات المسبقة.'
              : 'Set service state, prep rules, and pre-order behavior.',""",
            'l10n.settingsBusinessHoursSubtitle,',
        ),
        (
            """          isAr
              ? 'اربط المنيو بمحطات المطبخ والتحضير.'
              : 'Route menu items to kitchen stations and prep rules.',""",
            'l10n.settingsStationsSubtitle,',
        ),
        (
            """      subtitle: isAr
          ? 'تكاملات، مستخدمون، أدوار، وتدقيق.'
          : 'Integrations, users, roles, and audit.',""",
            'subtitle: l10n.settingsSystemPlatformSubtitle,',
        ),
        (
            """          isAr
              ? 'الورديات والحضور والموافقات.'
              : 'Shift roster, attendance, and approvals.',""",
            'l10n.settingsStaffSubtitle,',
        ),
        (
            """          isAr
              ? 'رسوم التوصيل وعرض الضريبة وتخطيط الإيصال.'
              : 'Delivery fees, tax display, and receipt layout.',""",
            'l10n.settingsFeesTaxesSubtitle,',
        ),
        (
            """                isAr
                    ? 'قواعد رسوم التوصيل حسب المنطقة'
                    : 'Zone-based delivery charge rules',""",
            'l10n.settingsDeliveryFeesDetail,',
        ),
        (
            """                isAr
                    ? 'الشعار والتذييل وسطر الضريبة'
                    : 'Logo, footer, and tax line layout',""",
            'l10n.settingsReceiptTemplateDetail,',
        ),
        (
            """          isAr
              ? 'تنبيهات المطبخ والمخزون وإرجاع الصواني.'
              : 'Kitchen, inventory, and tray-return alerts.',""",
            'l10n.settingsNotificationsSubtitle,',
        ),
        (
            """                isAr
                    ? 'تأخير التحضير وضغط المحطة'
                    : 'Prep delay and station overload',""",
            'l10n.settingsKitchenAlertsDetail,',
        ),
        (
            """          isAr
              ? 'انتقل بسرعة إلى الشاشات الإدارية.'
              : 'Jump to high-traffic admin screens.',""",
            'l10n.settingsShortcutsSubtitle,',
        ),
    ]
    replace_file(p, pairs, multiline)
    # Inject l10n into widgets missing it
    text = p.read_text(encoding='utf-8')
    inject = [
        ('  Widget build(BuildContext context) {\n    return WidgetsAppCard(\n      title: l10n.settingsBusinessHoursTitle',
         '  Widget build(BuildContext context) {\n    final l10n = AppLocalizations.of(context)!;\n    return WidgetsAppCard(\n      title: l10n.settingsBusinessHoursTitle'),
        ('  Widget build(BuildContext context) {\n    return WidgetsAppCard(\n      title: l10n.settingsStationsTitle',
         '  Widget build(BuildContext context) {\n    final l10n = AppLocalizations.of(context)!;\n    return WidgetsAppCard(\n      title: l10n.settingsStationsTitle'),
    ]
    for old, new in inject:
        if old in text:
            text = text.replace(old, new, 1)
    p.write_text(text, encoding='utf-8')


def migrate_orders() -> None:
    p = ROOT / 'lib/screens/admin/admin_orders_management_screen.dart'
    pairs = [
        ("title: isAr ? 'فلترة لوحة الطلبات' : 'Filter order board'", 'title: l10n.ordersMgmtFilterTitle'),
        ("tooltip: isAr ? 'فلترة' : 'Filter'", 'tooltip: l10n.ordersMgmtFilterTooltip'),
        ("title: isAr ? 'بانتظار القرار' : 'Needs Decision'", 'title: l10n.ordersMgmtLaneNeedsDecision'),
        ("title: isAr ? 'في التحضير' : 'Preparing'", 'title: l10n.ordersMgmtLanePreparing'),
        ("title: isAr ? 'جاهز / في الطريق' : 'Ready / On Route'", 'title: l10n.ordersMgmtLaneReadyRoute'),
        ("isAr ? 'تحت متابعة المطبخ' : 'Kitchen in progress'", 'l10n.ordersMgmtLanePreparingSub'),
        ("label: isAr ? 'لوحة الطلبات الحية' : 'Live Order Board'", 'label: l10n.ordersMgmtHeroBadge'),
        ("label: isAr ? 'طلبات مفتوحة' : 'Open orders'", 'label: l10n.ordersMgmtOpenOrders'),
        ("label: isAr ? 'قيمة نشطة' : 'Active value'", 'label: l10n.ordersMgmtActiveValue'),
        ("label: isAr ? 'طلبات صواني' : 'Plated orders'", 'label: l10n.ordersMgmtPlatedOrders'),
        ("message: isAr ? 'لا توجد طلبات هنا' : 'No orders here'", 'message: l10n.ordersMgmtEmptyLane'),
        ("label: isAr ? 'افتح التفاصيل' : 'Open detail'", 'label: l10n.ordersMgmtOpenDetail'),
        ("label: isAr ? 'تصعيد' : 'Escalate'", 'label: l10n.ordersMgmtEscalate'),
        ("isAr ? 'تم تسجيل التصعيد' : 'Escalation logged'", 'l10n.ordersMgmtEscalationLogged'),
        ("title: isAr ? 'أغلقت مؤخراً' : 'Recently Closed'", 'title: l10n.ordersMgmtRecentlyClosed'),
        ("label: isAr ? 'السجل' : 'History'", 'label: l10n.ordersMgmtHistory'),
        ("isAr ? 'تم التسليم' : 'Delivered'", 'l10n.ordersMgmtDeliveredStatus'),
    ]
    multiline = [
        (
            """                    isAr
                        ? 'فلترة حسب القناة، المحطة، أو حالة التأخير.'
                        : 'Filter by channel, station, or delay status.',""",
            'l10n.ordersMgmtFilterMessage,',
        ),
        (
            """                              isAr
                                  ? 'تأخير أو نقص أو تصعيد'
                                  : 'Late, missing, or escalated',""",
            'l10n.ordersMgmtLaneNeedsDecisionSub,',
        ),
        (
            """                              isAr
                                  ? 'تسليم الاستلام والتوصيل'
                                  : 'Pickup and delivery handoff',""",
            'l10n.ordersMgmtLaneReadyRouteSub,',
        ),
    ]
    replace_file(p, pairs, multiline)


def migrate_financial() -> None:
    p = ROOT / 'lib/screens/admin/admin_financial_calculation_screen.dart'
    pairs = [
        ("isAr ? 'إغلاق كاش وتقسيم أرباح' : 'Cash Close & Profit Split'", 'l10n.financialCloseBadge'),
        ("label: isAr ? 'إيراد الوردية' : 'Shift revenue'", 'label: l10n.financialCloseShiftRevenue'),
        ("label: isAr ? 'طلبات' : 'Orders'", 'label: l10n.financialCloseOrdersCount'),
        ("label: isAr ? 'صافي قابل للتوزيع' : 'Distributable net'", 'label: l10n.financialCloseDistributableNet'),
        ("title: isAr ? 'ملخص إغلاق الوردية' : 'Shift Close Summary'", 'title: l10n.financialCloseSummaryTitle'),
        ("label: isAr ? 'الحالة' : 'Status'", 'label: l10n.financialCloseStatusLabel'),
        ("value: isAr ? 'جاهز للإغلاق' : 'Ready to close'", 'value: l10n.financialCloseStatusReady'),
        ("title: isAr ? 'مطابقة طرق الدفع' : 'Tender Reconciliation'", 'title: l10n.financialCloseTenderTitle'),
        ("label: isAr ? 'نقد' : 'Cash'", 'label: l10n.financialCloseCash'),
        ("label: isAr ? 'بطاقات' : 'Cards'", 'label: l10n.financialCloseCards'),
        ("label: isAr ? 'محفظة' : 'Wallet'", 'label: l10n.financialCloseWallet'),
        ("title: isAr ? 'العربون والمرتجعات' : 'Deposits & Refunds'", 'title: l10n.financialCloseDepositsTitle'),
        ("label: isAr ? 'استردادات اليوم' : 'Refunds today'", 'label: l10n.financialCloseRefundsToday'),
        ("label: isAr ? 'رسوم كسر محتملة' : 'Potential breakage fees'", 'label: l10n.financialCloseBreakageFees'),
        ("label: isAr ? 'راجع إرجاع الصواني' : 'Review tray returns'", 'label: l10n.financialCloseReviewTrayReturns'),
        ("title: isAr ? 'البقشيش والفروقات' : 'Tips & Variance'", 'title: l10n.financialCloseTipsTitle'),
        ("label: isAr ? 'بقشيش الوردية الحالية' : 'Current shift tips'", 'label: l10n.financialCloseCurrentTips'),
        ("label: isAr ? 'فرق المطابقة' : 'Reconciliation variance'", 'label: l10n.financialCloseVariance'),
        ("title: isAr ? 'تقسيم صافي الربح' : 'Net Profit Split'", 'title: l10n.financialCloseSplitTitle'),
        ("title: isAr ? 'اعتماد الإغلاق' : 'Approve Close'", 'title: l10n.financialCloseApproveTitle'),
        ("subtitle: isAr ? 'عرض للمالك فقط' : 'Owner view only'", 'subtitle: l10n.financialCloseOwnerViewOnly'),
        ("? (isAr ? 'الإغلاق معتمد (قراءة فقط)' : 'Close approved (read-only)')", '? l10n.financialCloseApprovedReadOnly'),
        (": (isAr ? 'بانتظار اعتماد المشغل' : 'Awaiting operator approval')", ': l10n.financialCloseAwaitingApproval'),
        ("label: isAr ? 'اعتماد إغلاق الوردية' : 'Approve shift close'", 'label: l10n.financialCloseApproveShift'),
        ("title: isAr ? 'اعتماد الإغلاق' : 'Approve close'", 'title: l10n.financialCloseApproveConfirmTitle'),
        ("isAr ? 'تم اعتماد الإغلاق' : 'Shift close approved'", 'l10n.financialCloseApprovedSuccess'),
    ]
    multiline = [
        (
            """            isAr
                ? 'راجع الوردية، النقد، البطاقات، العربون، البقشيش، ثم اعتمد صافي الربح.'
                : 'Reconcile shift revenue, cash, cards, deposits, tips, then approve net profit.',""",
            'l10n.financialCloseHeroHeadline,',
        ),
        (
            """          isAr
              ? 'القراءة العملية قبل اعتماد الإغلاق.'
              : 'Operational numbers before approving the close.',""",
            'l10n.financialCloseSummarySubtitle,',
        ),
        (
            """          isAr
              ? 'النقد والبطاقات والمحفظة يجب أن تطابق سجل الكاشير.'
              : 'Cash, card, and wallet must match the cashier ledger.',""",
            'l10n.financialCloseTenderSubtitle,',
        ),
        (
            """          isAr
              ? 'عربون الصواني والاستردادات ومخاطر الكسر.'
              : 'Tray deposits, refunds, and breakage exposure.',""",
            'l10n.financialCloseDepositsSubtitle,',
        ),
        (
            """          isAr
              ? 'بقشيش الوردية وفروقات المطابقة.'
              : 'Shift tip pool and reconciliation variance.',""",
            'l10n.financialCloseTipsSubtitle,',
        ),
        (
            """          isAr
              ? 'حصص المالك والمشغل بعد التكاليف والبقشيش.'
              : 'Owner and operator shares after costs and tips.',""",
            'l10n.financialCloseSplitSubtitle,',
        ),
        (
            """          isAr
              ? 'قفل الوردية بعد اكتمال المطابقة.'
              : 'Lock the shift after reconciliation checks.',""",
            'l10n.financialCloseApproveSubtitle,',
        ),
        (
            """                            isAr
                                ? 'سيتم قفل إجماليات الوردية للتدقيق.'
                                : 'This will lock shift totals for audit.',""",
            'l10n.financialCloseApproveConfirmMessage,',
        ),
    ]
    replace_file(p, pairs, multiline)


def main() -> None:
    append_arb(ROOT / 'lib/l10n/app_en.arb', EN)
    append_arb(ROOT / 'lib/l10n/app_ar.arb', AR.replace('المقALI', 'المقالي'))
    migrate_settings()
    migrate_orders()
    migrate_financial()
    print('batch 7 done')


if __name__ == '__main__':
    main()

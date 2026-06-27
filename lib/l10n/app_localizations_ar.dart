// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'Ayletna Restaurant';

  @override
  String get brandNameAr => 'مطعم عيلتنا';

  @override
  String get comingSoon => 'قريباً';

  @override
  String get loading => 'جاري التحميل';

  @override
  String get actionContinue => 'متابعة';

  @override
  String get actionCancel => 'إلغاء';

  @override
  String get actionSave => 'حفظ';

  @override
  String get actionAddToCart => 'أضف إلى السلة';

  @override
  String get actionSignIn => 'تسجيل الدخول';

  @override
  String get actionRegister => 'إنشاء حساب';

  @override
  String get actionForgotPassword => 'نسيت كلمة المرور؟';

  @override
  String get actionVerify => 'تحقق';

  @override
  String get actionGuestBrowse => 'تصفح كضيف';

  @override
  String get fieldEmailOrPhone => 'البريد أو الهاتف';

  @override
  String get fieldPassword => 'كلمة المرور';

  @override
  String get fieldName => 'الاسم الكامل';

  @override
  String get languageArabic => 'العربية';

  @override
  String get languageEnglish => 'English';

  @override
  String get selectLanguageTitle => 'اختر اللغة';

  @override
  String get selectLanguageSubtitle => 'يمكنك تغييرها لاحقاً من الإعدادات';

  @override
  String get guestSignInToOrder => 'سجّل الدخول للطلب';

  @override
  String get termsAccept => 'أوافق على الشروط وسياسة الخصوصية';

  @override
  String get registerAsCustomer => 'عميل (فوري)';

  @override
  String get registerAsStaff => 'طلب دور تشغيلي (بانتظار الموافقة)';

  @override
  String get authLoginRequiredFields => 'أدخل رقم الهاتف أو البريد الإلكتروني وكلمة المرور.';

  @override
  String get authForgotIdentifierRequired => 'أدخل رقم الهاتف أو البريد الإلكتروني المسجل.';

  @override
  String get authOtpInvalid => 'أدخل رمز التحقق المكوّن من 6 أرقام.';

  @override
  String get authPasswordMismatch => 'كلمتا المرور غير متطابقتين.';

  @override
  String get authRegisterFieldsRequired => 'أكمل جميع الحقول المطلوبة ووافق على الشروط.';

  @override
  String get authOtpResent => 'تم إرسال رمز تحقق جديد.';

  @override
  String get authPasswordResetSuccess => 'تمت إعادة تعيين كلمة المرور. يمكنك تسجيل الدخول الآن.';

  @override
  String get roleSelectionNotApproved => 'هذا الدور غير معتمد لحسابك.';

  @override
  String get pendingApprovalNote => 'الأدوار التشغيلية تحتاج موافقة المشغل';

  @override
  String get currencyJod => 'د.أ';

  @override
  String get orderTypeDineIn => 'داخل المطعم';

  @override
  String get orderTypeTakeaway => 'سفري';

  @override
  String get orderTypeDelivery => 'توصيل';

  @override
  String get orderTypePlated => 'توصيل صواني';

  @override
  String get tipPreset1 => '١ د.أ';

  @override
  String get tipPreset2 => '٢ د.أ';

  @override
  String get tipPreset5 => '٥ د.أ';

  @override
  String get tipCustom => 'مخصص';

  @override
  String get checkoutFood => 'الطعام';

  @override
  String get checkoutTip => 'البقشيش';

  @override
  String get checkoutDeposit => 'العربون';

  @override
  String get checkoutPaymentMethod => 'طريقة الدفع';

  @override
  String checkoutWalletBalance(String amount) {
    return '$amount د.أ';
  }

  @override
  String get checkoutCardMasked => '**** 9012';

  @override
  String get checkoutCashArrival => 'الدفع عند الاستلام';

  @override
  String get checkoutAppreciationTitle => 'أظهر تقديرك';

  @override
  String get checkoutAppreciationSubtitle => 'لطفك يدعم فريق المطبخ لدينا.';

  @override
  String get checkoutFairWageNote => 'يتم توزيع 100٪ من البقشيش بالتساوي بين فريق المطبخ والتوصيل ضمن التزامنا بالأجر العادل.';

  @override
  String get checkoutOrderSummary => 'ملخص الطلب';

  @override
  String get checkoutFoodSubtotal => 'مجموع الطعام';

  @override
  String get checkoutDeliveryFee => 'رسوم التوصيل';

  @override
  String get checkoutPlatedDeposit => 'عربون الصواني';

  @override
  String get checkoutDepositRefundNote => 'يسترد عند جمع الصواني.';

  @override
  String get checkoutStaffAppreciation => 'تقدير الفريق';

  @override
  String get checkoutTotal => 'الإجمالي';

  @override
  String get checkoutTaxInclusive => 'شامل الضرائب';

  @override
  String get checkoutPlaceOrder => 'تأكيد الطلب';

  @override
  String checkoutPlaceOrderAmount(String amount) {
    return 'تأكيد الطلب • $amount';
  }

  @override
  String get roleCustomer => 'عميل';

  @override
  String get roleCashier => 'كاشير';

  @override
  String get roleKitchen => 'مطبخ';

  @override
  String get roleDelivery => 'مندوب';

  @override
  String get roleInventory => 'مخزون';

  @override
  String get roleStaff => 'موظف';

  @override
  String get roleOperator => 'مشغل';

  @override
  String get roleOwner => 'مالك';

  @override
  String get screenCustomizationModal => 'تخصيص الصنف';

  @override
  String get screenCustomizationModalDesc => 'اختر الحجم والإضافات';

  @override
  String get hubNavigateHint => 'اضغط للانتقال إلى الشاشة';

  @override
  String get screenPendingApproval => 'بانتظار الموافقة';

  @override
  String get actionSignOut => 'تسجيل الخروج';

  @override
  String get homeCategoriesTitle => 'الأقسام';

  @override
  String get homeFeaturedTitle => 'مميز';

  @override
  String get categoryEyebrow => 'القسم';

  @override
  String get categoryMezzeTitle => 'مقبلات باردة ومشاوي خفيفة';

  @override
  String get categoryMezzeDescription => 'اكتشف تشكيلة من المقبلات الشامية المحضّرة يومياً بمكونات طازجة ونكهات أردنية أصيلة.';

  @override
  String get categoryShawarmaHeroTitle => 'شاورما لحم أسطورية';

  @override
  String get categoryShawarmaHeroDescription => 'لحم فاخر مشوي ببطء بتتبيلة بهارات تقليدية ويقدم مع صوص الثومية الخاص.';

  @override
  String get actionAddToOrder => 'أضف إلى الطلب';

  @override
  String get exploreMenuCategoriesTitle => 'أقسام المنيو';

  @override
  String get exploreDailyRevenue => 'إيراد اليوم';

  @override
  String get explorePendingOrders => 'طلبات معلقة';

  @override
  String get exploreActive => 'نشطة';

  @override
  String get badgePlated => 'صواني';

  @override
  String get badgeDineInOnly => 'داخل الصالة فقط';

  @override
  String get badgeLargeFamily => 'عائلي كبير';

  @override
  String get badgeBestseller => 'الأكثر طلباً';

  @override
  String get badgeHighProtein => 'بروتين عالي';

  @override
  String get badgePlateMeal => 'وجبة صحن';

  @override
  String get badgeKetoChoice => 'اختيار كيتو';

  @override
  String get badgeSpicy => 'حار';

  @override
  String get badgeSignature => 'مميز';

  @override
  String get badgeVegetarian => 'نباتي';

  @override
  String get badgeHealthy => 'صحي';

  @override
  String get badgeChefFavorite => 'اختيار الشيف';

  @override
  String get badgeFamily => 'عائلي';

  @override
  String get cartEmptyMessage => 'السلة فارغة';

  @override
  String get productNotSelected => 'اختر صنفاً من المنيو';

  @override
  String get orderNumberLabel => 'طلب';

  @override
  String get orderStatusPreparing => 'قيد التحضير';

  @override
  String get orderStatusReady => 'جاهز';

  @override
  String get orderStatusOnWay => 'في الطريق';

  @override
  String get orderStatusDelivered => 'تم التسليم';

  @override
  String get orderStatusPending => 'معلق';

  @override
  String get tableNumberLabel => 'رقم الطاولة';

  @override
  String get pickupTimeLabel => 'وقت الاستلام';

  @override
  String get addressLabel => 'عنوان التوصيل';

  @override
  String get deliveryChooseAddress => 'اختر عنوان التوصيل';

  @override
  String get deliveryVerifiedZone => 'نطاق مؤكد';

  @override
  String get deliveryHome => 'المنزل';

  @override
  String get deliveryWork => 'العمل';

  @override
  String get deliveryHomeAddress => 'فيلا ٤٢، شارع الريم، الصويفية، عمّان، الأردن';

  @override
  String get deliveryWorkAddress => 'مجمع الأعمال، مبنى ٥، الطابق الثالث، مجمع الملك حسين للأعمال، عمّان';

  @override
  String get deliveryEdit => 'تعديل';

  @override
  String get deliveryRemove => 'إزالة';

  @override
  String get deliveryAddNewAddress => 'إضافة عنوان توصيل جديد';

  @override
  String get deliveryMapPreview => 'معاينة خريطة المنطقة';

  @override
  String get deliveryRapidDelivery => 'توصيل سريع';

  @override
  String get deliveryVerification => 'التحقق من التوصيل';

  @override
  String get deliveryStandardAvailable => 'التوصيل القياسي متاح';

  @override
  String get deliveryExpressZoneNote => 'العنوان المحدد ضمن نطاق التوصيل السريع خلال ١٥ دقيقة.';

  @override
  String get deliveryStandardFee => 'رسوم التوصيل القياسي';

  @override
  String get deliveryEstimatedTotal => 'الإجمالي التقديري';

  @override
  String get deliveryConfirmCheckout => 'تأكيد العنوان والمتابعة للدفع';

  @override
  String deliveryOrderTitle(String id) {
    return 'طلب #$id';
  }

  @override
  String get deliveryCollectionPoint => 'نقطة الاستلام';

  @override
  String get deliveryKitchenStationB => 'محطة المطبخ ب';

  @override
  String get deliveryReadyForPickup => 'جاهز للاستلام';

  @override
  String deliveryPickupCustomer(String name) {
    return 'العميل: $name';
  }

  @override
  String deliveryVerifyAllItems(int count) {
    return 'تحقق من كل الأصناف ($count)';
  }

  @override
  String get deliveryBagCount => 'كيس ١ من ١';

  @override
  String get deliveryOrderTotal => 'إجمالي الطلب';

  @override
  String get deliveryReusableBagDeposit => 'عربون كيس قابل لإعادة الاستخدام';

  @override
  String get deliveryTotalToCollect => 'الإجمالي للتحصيل';

  @override
  String get deliveryCashOnDelivery => 'الدفع نقداً عند التسليم';

  @override
  String get deliveryReportMissingItem => 'الإبلاغ عن صنف ناقص';

  @override
  String get deliveryConfirmPickup => 'تأكيد الاستلام';

  @override
  String get deliveryDashboardTitle => 'لوحة التوصيل';

  @override
  String get deliveryShiftSummary => 'الوردية نشطة: ٤س ١٢د • ٨ مهام مكتملة';

  @override
  String get deliveryTasks => 'مهام التوصيل';

  @override
  String get deliveryReturnTasks => 'مهام الإرجاع';

  @override
  String get deliveryTaskBadge => 'توصيل';

  @override
  String get deliveryPlatedReturnBadge => 'صواني • إرجاع';

  @override
  String get deliveryReadyToGo => 'جاهز للانطلاق';

  @override
  String get deliveryPendingKitchen => 'بانتظار المطبخ';

  @override
  String get deliveryAddNote => 'إضافة ملاحظة';

  @override
  String get deliveryStartDelivery => 'بدء التوصيل';

  @override
  String get deliveryMarkCollected => 'تم الجمع';

  @override
  String get deliveryOverdue => 'متأخر ١٥ دقيقة';

  @override
  String get deliveryOrder8842Address => '١٢٨٢ شارع بارك';

  @override
  String get deliveryOrder8842Note => 'شقة ٤ب • رمز دخول المبنى ٤٤٢١';

  @override
  String get deliveryTable14Pickup => 'استلام طاولة #١٤';

  @override
  String get deliverySkyLounge => 'تراس سكاي لاونج';

  @override
  String get deliveryTrayReturnDetails => '٢ صحن سيراميك • ٤ كؤوس';

  @override
  String get deliveryOrder8845Address => '٨٨٢ شارع برودواي';

  @override
  String get deliveryOrder8845Note => 'ردهة المكتب • اتركه عند الاستقبال';

  @override
  String get deliveryNextStop => 'المحطة التالية';

  @override
  String get deliveryMilesAway => '٣.٢ ميل';

  @override
  String get deliveryCurrentDirection => 'الاتجاه الحالي';

  @override
  String get deliveryNorthPark => 'شمالاً على شارع بارك';

  @override
  String get deliveryShiftEarnings => 'أرباح الوردية';

  @override
  String deliveryIncludesTips(String amount) {
    return 'تشمل $amount بقشيش';
  }

  @override
  String get deliveryViewHistory => 'عرض السجل';

  @override
  String get deliveryHistoryTotalEarnings => 'إجمالي أرباح اليوم';

  @override
  String get deliveryHistoryEarningsDelta => '+١٢٪ عن أمس';

  @override
  String get deliveryHistoryCompleted => 'طلبات التوصيل المكتملة';

  @override
  String get deliveryHistoryAvgTime => 'المتوسط: ٢٢ دقيقة لكل توصيل';

  @override
  String get deliveryHistoryTipsEarned => 'إجمالي البقشيش المكتسب';

  @override
  String get deliveryHistoryGoal => 'تم تحقيق ٦٥٪ من هدفك';

  @override
  String get deliveryHistoryTitle => 'سجل التوصيل';

  @override
  String get deliveryHistoryFilter => 'تصفية';

  @override
  String get deliveryTipEarned => 'البقشيش:';

  @override
  String get deliveryViewDetails => 'عرض التفاصيل';

  @override
  String get deliveryLoadPreviousDays => 'تحميل أيام سابقة';

  @override
  String get deliveryFinance => 'المالية';

  @override
  String get deliveryReturnsTitle => 'سجل إرجاع الصواني';

  @override
  String get deliveryReturnsSubtitle => 'راجع كل عمليات جمع الصواني المكتملة والتسويات المالية.';

  @override
  String get deliveryReturnsContext => 'اللوجستيات / الإرجاع';

  @override
  String get deliveryReturnTasksTitle => 'مهام الإرجاع';

  @override
  String get deliveryActiveCollections => 'عمليات الجمع النشطة';

  @override
  String deliveryScheduledCount(int count) {
    return '$count مجدولة';
  }

  @override
  String get deliverySustainabilityGoal => 'هدف الاستدامة';

  @override
  String deliveryTrayCount(int count) {
    return '$count صواني';
  }

  @override
  String get deliveryArrived => 'وصلت';

  @override
  String get deliveryRouteOverview => 'نظرة على المسار';

  @override
  String get deliveryMilesRemaining => '٤.٢ ميل متبقية';

  @override
  String get deliveryTotalTrays => 'إجمالي الصواني';

  @override
  String get deliverySuccessfullyReturned => 'أُعيدت بنجاح';

  @override
  String get deliveryDepositsRefunded => 'العربونات المستردة';

  @override
  String get deliveryReturnedToCustomers => 'أُعيدت للعملاء';

  @override
  String get deliveryBreakageFees => 'رسوم الكسر';

  @override
  String get deliveryReportedDamage => 'ضرر مسجل';

  @override
  String get deliverySuccessRate => 'معدل النجاح';

  @override
  String get deliveryDayAverage => 'متوسط ٣٢ يوم';

  @override
  String get deliveryRecentReturns => 'آخر الإرجاعات';

  @override
  String get deliveryThisWeek => 'هذا الأسبوع';

  @override
  String get deliveryFilters => 'فلاتر';

  @override
  String get deliveryExport => 'تصدير';

  @override
  String get deliveryRefunded => 'مسترد';

  @override
  String get deliveryNetRefund => 'صافي الاسترداد';

  @override
  String get deliveryLoadMoreHistory => 'تحميل سجل إضافي';

  @override
  String get couponCodeLabel => 'رمز الكوبون';

  @override
  String get walletBalanceLabel => 'الرصيد';

  @override
  String get loyaltyPointsLabel => 'النقاط';

  @override
  String get mapSelectHint => 'اضغط على الخريطة لتحديد موقع التوصيل.';

  @override
  String get actionConfirm => 'تأكيد';

  @override
  String get screenNotReady => 'جاري تحميل الشاشة…';

  @override
  String get platedReturnReminderBody => 'يرجى تجهيز الصينية للاستلام بعد الوجبة.';

  @override
  String get redemptionConfirmBody => 'استبدال النقاط بهذه المكافأة؟';

  @override
  String get reportDateFrom => 'من تاريخ';

  @override
  String get reportDateTo => 'إلى تاريخ';

  @override
  String get depositAmountLabel => 'قيمة العربون (د.أ)';

  @override
  String get depositBreadcrumbSettings => 'الإعدادات';

  @override
  String get depositBreadcrumbLogistics => 'اللوجستيات';

  @override
  String get depositBreadcrumbTrayReturns => 'عربون الصواني والإرجاع';

  @override
  String get depositTrayConfiguration => 'إعدادات الصواني';

  @override
  String get depositConfigurationSubtitle => 'إدارة أسعار العربون العامة وسياسات الإرجاع الآلية.';

  @override
  String get depositGlobalTitle => 'العربون العام';

  @override
  String get depositGlobalAmountLabel => 'قيمة العربون العامة (د.أ)';

  @override
  String get depositGlobalHelp => 'يضاف هذا المبلغ تلقائياً إلى كل طلبات السفري والتوصيل التي تحتوي على صواني.';

  @override
  String get depositWarning => 'زيادة قيمة العربون ستحدّث كل الطلبات الجديدة فوراً. الطلبات المعلقة الحالية ستحتفظ بقيمة العربون الأصلية.';

  @override
  String get depositReturnWindow => 'نافذة الإرجاع';

  @override
  String get depositMaxReturnWindow => 'أقصى مدة للإرجاع';

  @override
  String depositHours(int count) {
    return '$count ساعة';
  }

  @override
  String get depositOneHour => 'ساعة واحدة';

  @override
  String get depositSevenDays => '٧ أيام';

  @override
  String get depositAutomatedReminders => 'تذكيرات آلية';

  @override
  String get depositReminderChannel => 'تنبيه عبر SMS/البريد';

  @override
  String get depositSave => 'حفظ';

  @override
  String get settingsNotifications => 'إشعارات الدفع';

  @override
  String get settingsOwnerPrivacy => 'إخفاء تفاصيل البقشيش عن المالك';

  @override
  String get screenLanguageSelection => 'اللغة';

  @override
  String get screenLogin => 'تسجيل الدخول';

  @override
  String get screenOtpVerification => 'التحقق';

  @override
  String get screenRegister => 'التسجيل';

  @override
  String get screenForgotPassword => 'استعادة كلمة المرور';

  @override
  String get screenRoleSelection => 'اختر الدور';

  @override
  String get screenGuestBrowse => 'المنيو (ضيف)';

  @override
  String get screenHome => 'الرئيسية';

  @override
  String get screenMenu => 'المنيو';

  @override
  String get screenCategory => 'القسم';

  @override
  String get screenProductDetail => 'الصنف';

  @override
  String get screenCart => 'السلة';

  @override
  String get screenSupport => 'الدعم';

  @override
  String get screenOrderTypeSelection => 'نوع الطلب';

  @override
  String get screenDineInTable => 'رقم الطاولة';

  @override
  String get screenTakeawayPickup => 'الاستلام';

  @override
  String get screenDeliveryAddress => 'عنوان التوصيل';

  @override
  String get screenPlatedDeliveryInfo => 'توصيل الصواني';

  @override
  String get screenCheckout => 'الدفع';

  @override
  String get screenTipSelection => 'البقشيش';

  @override
  String get screenPayment => 'طريقة الدفع';

  @override
  String get screenOrderConfirmation => 'تم الطلب';

  @override
  String get screenOrderTracking => 'تتبع الطلب';

  @override
  String get screenOrderHistory => 'سجل الطلبات';

  @override
  String get screenWallet => 'المحفظة';

  @override
  String get screenLoyalty => 'الولاء';

  @override
  String get screenRewardsCatalog => 'المكافآت';

  @override
  String get screenRewardsHistory => 'سجل المكافآت';

  @override
  String get screenPaymentHistory => 'سجل الدفع';

  @override
  String get screenRedemptionConfirm => 'تأكيد الاستبدال';

  @override
  String get screenProfile => 'الملف الشخصي';

  @override
  String get screenAccountSettings => 'إعدادات الحساب';

  @override
  String get drawerSectionMore => 'المزيد';

  @override
  String get demoActionTag => 'تجريبي';

  @override
  String get screenAddresses => 'العناوين';

  @override
  String get screenMapPicker => 'الخريطة';

  @override
  String get screenNotifications => 'الإشعارات';

  @override
  String get screenPlatedReturnReminder => 'استرجاع الصينية';

  @override
  String get screenOffers => 'العروض';

  @override
  String get screenCouponApply => 'كوبون';

  @override
  String get screenComboBuilder => 'بناء وجبة';

  @override
  String get screenKitchenDashboard => 'المطبخ';

  @override
  String get screenOrderPrep => 'تحضير الطلب';

  @override
  String get screenInventoryDashboard => 'المخزون';

  @override
  String get screenInventoryItem => 'تفاصيل الصنف';

  @override
  String get screenStockAdjustment => 'تعديل المخزون';

  @override
  String get screenDeliveryDashboard => 'التوصيل';

  @override
  String get screenDeliveryOrder => 'طلب التوصيل';

  @override
  String get screenPlatedReturnTask => 'مهام الاسترجاع';

  @override
  String get screenPlatedReturnProcess => 'معالجة الاسترجاع';

  @override
  String get screenCashierOrder => 'كاشير';

  @override
  String get screenCashierTipEntry => 'بقشيش نقدي';

  @override
  String get screenCashierDepositRefund => 'استرداد عربون';

  @override
  String get screenCashierOrderHistory => 'سجل طلبات الكاشير';

  @override
  String get screenStaffAttendance => 'الحضور';

  @override
  String get screenStaffDailyTips => 'بقشيش اليوم';

  @override
  String get screenStaffTipHistory => 'سجل البقشيش';

  @override
  String get screenAdminDashboard => 'الإدارة';

  @override
  String get screenOrdersManagement => 'الطلبات';

  @override
  String get screenOrderDetailAdmin => 'تفاصيل الطلب';

  @override
  String get screenReports => 'التقارير';

  @override
  String get screenReportFilter => 'فلاتر التقرير';

  @override
  String get screenFinancialCalculation => 'الحساب المالي';

  @override
  String get screenDailyTipDistribution => 'توزيع البقشيش';

  @override
  String get screenPlatesManagement => 'الصواني';

  @override
  String get screenPlateEditor => 'تعديل صينية';

  @override
  String get screenDepositConfig => 'إعداد العربون';

  @override
  String get screenUserManagement => 'المستخدمون';

  @override
  String get screenMenuManagement => 'إدارة المنيو';

  @override
  String get screenProductEditor => 'تعديل منتج';

  @override
  String get screenOffersManagement => 'إدارة العروض';

  @override
  String get screenLoyaltyConfig => 'إعداد الولاء';

  @override
  String get screenOwnerViewConfig => 'خصوصية المالك';

  @override
  String get screenPreOrder => 'طلبات مسبقة';

  @override
  String get screenSettings => 'الإعدادات';

  @override
  String get screenAppIntegrations => 'تكاملات التطبيق';

  @override
  String get integrationsSecurityNote => 'أدخل بيانات الاعتماد التي زوّدك بها المزود. في الإنتاج تُخزَّن الأسرار بأمان (Supabase Vault) — وليس في الكود.';

  @override
  String get integrationsSaveAll => 'حفظ كل التكاملات';

  @override
  String get integrationsSaveSuccess => 'تم حفظ إعدادات التكامل.';

  @override
  String get integrationsTestConnection => 'اختبار الاتصال';

  @override
  String get integrationsTestSuccess => 'نجح اختبار الاتصال (تجريبي).';

  @override
  String get integrationsTestIncomplete => 'أكمل الحقول المطلوبة لهذا القسم أولاً.';

  @override
  String get integrationsStatusConfigured => 'مُعدّ';

  @override
  String get integrationsStatusIncomplete => 'غير مكتمل';

  @override
  String integrationsLastSaved(String date) {
    return 'آخر حفظ: $date';
  }

  @override
  String get integrationsSupabaseTitle => 'Supabase';

  @override
  String get integrationsSupabaseSubtitle => 'قاعدة البيانات، المصادقة، Realtime، وEdge Functions.';

  @override
  String get integrationsSupabaseUrl => 'رابط المشروع';

  @override
  String get integrationsSupabaseUrlHint => 'https://xxxxx.supabase.co';

  @override
  String get integrationsSupabaseAnonKey => 'المفتاح العام (Anon)';

  @override
  String get integrationsSupabaseAnonKeyHint => 'eyJhbGciOiJIUzI1NiIsInR5cCI6...';

  @override
  String get integrationsSupabaseServiceRoleKey => 'مفتاح Service Role (خادم فقط)';

  @override
  String get integrationsSupabaseServiceRoleKeyHint => 'لـ Edge Functions / نشر الخادم';

  @override
  String get integrationsSupabaseProjectRef => 'معرّف المشروع';

  @override
  String get integrationsSupabaseProjectRefHint => 'مثال: abcdefghijklmnop';

  @override
  String get integrationsSmsTitle => 'مزود SMS';

  @override
  String get integrationsSmsSubtitle => 'رموز OTP ورسائل إرجاع الصواني (Unifonic، Twilio، إلخ).';

  @override
  String get integrationsSmsProvider => 'اسم المزود';

  @override
  String get integrationsSmsProviderHint => 'Unifonic / Twilio / مخصص';

  @override
  String get integrationsSmsApiKey => 'مفتاح API';

  @override
  String get integrationsSmsApiKeyHint => 'مفتاح أو توكن المزود';

  @override
  String get integrationsSmsSenderId => 'معرّف المرسل / الرقم';

  @override
  String get integrationsSmsSenderIdHint => 'Ayletna أو +962...';

  @override
  String get integrationsSmsApiUrl => 'رابط API (اختياري)';

  @override
  String get integrationsSmsApiUrlHint => 'https://api.unifonic.com/...';

  @override
  String get integrationsWhatsappTitle => 'WhatsApp Business';

  @override
  String get integrationsWhatsappSubtitle => 'تذكيرات الإرجاع وتحديثات العملاء.';

  @override
  String get integrationsWhatsappBusinessAccountId => 'معرّف حساب الأعمال';

  @override
  String get integrationsWhatsappBusinessAccountIdHint => 'معرّف Meta Business';

  @override
  String get integrationsWhatsappPhoneNumberId => 'معرّف رقم الهاتف';

  @override
  String get integrationsWhatsappPhoneNumberIdHint => 'معرّف WhatsApp Cloud API';

  @override
  String get integrationsWhatsappAccessToken => 'توكن الوصول الدائم';

  @override
  String get integrationsWhatsappAccessTokenHint => 'توكن مستخدم النظام من Meta';

  @override
  String get integrationsWhatsappWebhookVerifyToken => 'توكن التحقق من Webhook';

  @override
  String get integrationsWhatsappWebhookVerifyTokenHint => 'سلسلة عشوائية للتحقق';

  @override
  String get integrationsTelephonyTitle => 'الهاتف وOTP';

  @override
  String get integrationsTelephonySubtitle => 'خط الدعم، رمز الدولة، ورقم مرسل OTP.';

  @override
  String get integrationsSupportPhoneNumber => 'رقم دعم العملاء';

  @override
  String get integrationsSupportPhoneNumberHint => '+962 7 0000 0000';

  @override
  String get integrationsDefaultCountryCode => 'رمز الدولة الافتراضي';

  @override
  String get integrationsDefaultCountryCodeHint => '+962';

  @override
  String get integrationsOtpSenderNumber => 'رقم مرسل OTP';

  @override
  String get integrationsOtpSenderNumberHint => 'مرسل مسجل لرسائل التحقق';

  @override
  String get integrationsPaymentsTitle => 'بوابات الدفع';

  @override
  String get integrationsPaymentsSubtitle => 'Stripe، Google Pay، Apple Pay، بوابات إقليمية، والمحفظة المرخّصة.';

  @override
  String get integrationsPaymentGatewayProvider => 'البوابة الأساسية';

  @override
  String get integrationsPaymentGatewayProviderHint => 'Stripe / MyFatoorah / HyperPay / Checkout.com';

  @override
  String get integrationsStripePublishableKey => 'Stripe publishable key';

  @override
  String get integrationsStripePublishableKeyHint => 'pk_live_... أو pk_test_...';

  @override
  String get integrationsStripeSecretKey => 'Stripe secret key';

  @override
  String get integrationsStripeSecretKeyHint => 'sk_live_... (خادم فقط)';

  @override
  String get integrationsStripeWebhookSecret => 'Stripe webhook secret';

  @override
  String get integrationsStripeWebhookSecretHint => 'whsec_...';

  @override
  String get integrationsGooglePayMerchantId => 'Google Pay merchant ID';

  @override
  String get integrationsGooglePayMerchantIdHint => 'معرّف تاجر Google Pay';

  @override
  String get integrationsGooglePayMerchantName => 'Google Pay merchant name';

  @override
  String get integrationsGooglePayMerchantNameHint => 'مطعم عيلتنا';

  @override
  String get integrationsApplePayMerchantId => 'Apple Pay merchant ID';

  @override
  String get integrationsApplePayMerchantIdHint => 'merchant.com.ayletna.restaurant';

  @override
  String get integrationsPaymentGatewayApiKey => 'مفتاح البوابة الإقليمية';

  @override
  String get integrationsPaymentGatewayApiKeyHint => 'MyFatoorah / HyperPay API key';

  @override
  String get integrationsPaymentGatewayMerchantId => 'معرّف التاجر الإقليمي';

  @override
  String get integrationsPaymentGatewayMerchantIdHint => 'معرّف التاجر أو الطرفية';

  @override
  String get integrationsPaymentGatewayWebhookUrl => 'رابط webhook للدفع';

  @override
  String get integrationsPaymentGatewayWebhookUrlHint => 'https://your-project.supabase.co/functions/v1/payment-webhook';

  @override
  String get integrationsWalletSectionTitle => 'المحفظة المرخّصة (الأردن)';

  @override
  String get integrationsWalletProviderName => 'اسم مزود المحفظة';

  @override
  String get integrationsWalletProviderNameHint => 'شريك المحفظة المرخّص';

  @override
  String get integrationsWalletAppId => 'معرّف تطبيق المحفظة';

  @override
  String get integrationsWalletAppIdHint => 'معرّف التاجر / التطبيق';

  @override
  String get integrationsWalletDeepLinkScheme => 'مخطط Deep link';

  @override
  String get integrationsWalletDeepLinkSchemeHint => 'ayletna://payment/callback';

  @override
  String get integrationsWalletWebhookSecret => 'سر webhook المحفظة';

  @override
  String get integrationsWalletWebhookSecretHint => 'سر مشترك لاستدعاءات المحفظة';

  @override
  String get integrationsAiTitle => 'وكيل الذكاء الاصطناعي';

  @override
  String get integrationsAiSubtitle => 'دردشة الدعم ومساعد المشغل (ChatGPT، Qwen، إلخ).';

  @override
  String get integrationsAiProvider => 'مزود AI';

  @override
  String get integrationsAiProviderHint => 'OpenAI / Qwen / Anthropic / مخصص';

  @override
  String get integrationsAiApiKey => 'مفتاح API';

  @override
  String get integrationsAiApiKeyHint => 'مفتاح المزود';

  @override
  String get integrationsAiModelName => 'اسم النموذج';

  @override
  String get integrationsAiModelNameHint => 'gpt-4o / qwen-max / claude-3-5-sonnet';

  @override
  String get integrationsAiBaseUrl => 'رابط API (اختياري)';

  @override
  String get integrationsAiBaseUrlHint => 'https://api.openai.com/v1';

  @override
  String get integrationsAiSupportChatEnabled => 'تفعيل دردشة الدعم بالذكاء الاصطناعي';

  @override
  String get integrationsAiSupportChatEnabledHint => 'توجيه دردشة العملاء عبر الوكيل المُعد';

  @override
  String get integrationsOtherTitle => 'خدمات أخرى';

  @override
  String get integrationsOtherSubtitle => 'الخرائط، الإشعارات، البريد، والمراقبة.';

  @override
  String get integrationsGoogleMapsApiKey => 'مفتاح Google Maps API';

  @override
  String get integrationsGoogleMapsApiKeyHint => 'مقيّد حسب الحزمة / المرجع';

  @override
  String get integrationsFcmServerKey => 'مفتاح FCM';

  @override
  String get integrationsFcmServerKeyHint => 'مفتاح Firebase Cloud Messaging';

  @override
  String get integrationsEmailProvider => 'مزود البريد';

  @override
  String get integrationsEmailProviderHint => 'SendGrid / Amazon SES';

  @override
  String get integrationsEmailApiKey => 'مفتاح البريد API';

  @override
  String get integrationsEmailApiKeyHint => 'بيانات SendGrid أو SES';

  @override
  String get integrationsEmailFromAddress => 'عنوان المرسل';

  @override
  String get integrationsEmailFromAddressHint => 'noreply@ayletna.com';

  @override
  String get integrationsSentryDsn => 'Sentry DSN (اختياري)';

  @override
  String get integrationsSentryDsnHint => 'https://...@sentry.io/...';

  @override
  String get integrationsAttendanceWifiTitle => 'WiFi المطعم (الحضور)';

  @override
  String get integrationsAttendanceWifiSubtitle => 'تسجيل الحضور والانصراف يعمل فقط على WiFi المطعم — وليس بيانات الجوال أو شبكات خارجية.';

  @override
  String get integrationsRestaurantWifiSsid => 'اسم شبكة WiFi (SSID)';

  @override
  String get integrationsRestaurantWifiSsidHint => 'Ayletna-Staff';

  @override
  String get integrationsRestaurantWifiBssid => 'BSSID الراوتر (MAC)';

  @override
  String get integrationsRestaurantWifiBssidHint => 'aa:bb:cc:dd:ee:ff';

  @override
  String get integrationsRestaurantWifiGatewayIp => 'IP البوابة (اختياري)';

  @override
  String get integrationsRestaurantWifiGatewayIpHint => '192.168.1.1';

  @override
  String get integrationsRestaurantBranchLabel => 'تسمية الفرع';

  @override
  String get integrationsRestaurantBranchLabelHint => 'المطبخ الرئيسي — عمّان';

  @override
  String get attendanceGateTitle => 'تسجيل الحضور';

  @override
  String get attendanceModeComing => 'حضور';

  @override
  String get attendanceModeLeaving => 'انصراف';

  @override
  String get attendanceWifiChecking => 'جاري التحقق من WiFi المطعم…';

  @override
  String get attendanceWifiCheckFailed => 'تعذّر قراءة حالة WiFi. حاول مرة أخرى.';

  @override
  String get attendanceWifiNotConfigured => 'لم يسجّل المدير WiFi المطعم بعد. اطلب من المشغل إعداده في تكاملات التطبيق.';

  @override
  String get attendanceWifiRequired => 'اتصل بـ WiFi المطعم لتسجيل الحضور. بيانات الجوال والشبكات الخارجية مرفوضة.';

  @override
  String attendanceWifiConnected(String ssid) {
    return 'متصل بـ WiFi المطعم: $ssid';
  }

  @override
  String attendanceWifiDemoMatched(String ssid) {
    return 'وضع تجريبي: يُعامل كـ WiFi المطعم ($ssid)';
  }

  @override
  String get attendanceWifiWebDemoNote => 'النموذج على الويب يحاكي مطابقة WiFi عند تفعيل الوضع التجريبي. الإنتاج يستخدم تطبيق الجوال على WiFi المطعم.';

  @override
  String attendanceWifiWrongNetwork(String current, String expected) {
    return 'شبكة خاطئة ($current). المطلوب: $expected';
  }

  @override
  String get attendanceWifiUnknown => 'غير متصل بـ WiFi';

  @override
  String get attendanceWifiRefresh => 'تحديث فحص WiFi';

  @override
  String attendanceLastRecordedWifi(String ssid) {
    return 'آخر تسجيل على WiFi: $ssid';
  }

  @override
  String get attendanceFingerprintComingHint => 'المس بصمة الإصبع لتأكيد وقت الحضور';

  @override
  String get attendanceFingerprintLeavingHint => 'المس بصمة الإصبع لتأكيد وقت الانصراف';

  @override
  String get attendanceBiometricTitle => 'موافقة بصمة الإصبع';

  @override
  String get attendanceBiometricConfirm => 'الموافقة بالبصمة';

  @override
  String get attendanceBiometricCheckInReason => 'أكّد حضورك إلى المطعم';

  @override
  String get attendanceBiometricCheckOutReason => 'أكّد مغادرتك من المطعم';

  @override
  String get attendanceBiometricUnavailable => 'المصادقة البيومترية غير متاحة على هذا الجهاز.';

  @override
  String get attendanceBiometricFailed => 'فشل التحقق بالبصمة. حاول مرة أخرى.';

  @override
  String get screenAuditLog => 'سجل التدقيق';

  @override
  String get screenStaffHoursReport => 'ساعات الموظفين';

  @override
  String get screenLanguageSelectionDesc => 'شاشة اللغة.';

  @override
  String get screenLoginDesc => 'شاشة تسجيل الدخول.';

  @override
  String get screenOtpVerificationDesc => 'شاشة التحقق.';

  @override
  String get screenRegisterDesc => 'شاشة التسجيل.';

  @override
  String get screenForgotPasswordDesc => 'شاشة استعادة كلمة المرور.';

  @override
  String get screenRoleSelectionDesc => 'شاشة اختر الدور.';

  @override
  String get screenGuestBrowseDesc => 'شاشة المنيو (ضيف).';

  @override
  String get screenHomeDesc => 'شاشة الرئيسية.';

  @override
  String get screenCategoryDesc => 'شاشة القسم.';

  @override
  String get screenProductDetailDesc => 'شاشة الصنف.';

  @override
  String get screenCartDesc => 'شاشة السلة.';

  @override
  String get screenOrderTypeSelectionDesc => 'شاشة نوع الطلب.';

  @override
  String get screenDineInTableDesc => 'شاشة رقم الطاولة.';

  @override
  String get screenTakeawayPickupDesc => 'شاشة الاستلام.';

  @override
  String get screenDeliveryAddressDesc => 'شاشة عنوان التوصيل.';

  @override
  String get screenPlatedDeliveryInfoDesc => 'شاشة توصيل الصواني.';

  @override
  String get screenCheckoutDesc => 'شاشة الدفع.';

  @override
  String get screenTipSelectionDesc => 'شاشة البقشيش.';

  @override
  String get screenPaymentDesc => 'شاشة طريقة الدفع.';

  @override
  String get screenOrderConfirmationDesc => 'شاشة تم الطلب.';

  @override
  String get screenOrderTrackingDesc => 'شاشة تتبع الطلب.';

  @override
  String get screenOrderHistoryDesc => 'شاشة سجل الطلبات.';

  @override
  String get screenWalletDesc => 'شاشة المحفظة.';

  @override
  String get screenLoyaltyDesc => 'شاشة الولاء.';

  @override
  String get screenRewardsCatalogDesc => 'شاشة المكافآت.';

  @override
  String get screenRedemptionConfirmDesc => 'شاشة تأكيد الاستبدال.';

  @override
  String get screenProfileDesc => 'شاشة الملف الشخصي.';

  @override
  String get screenAddressesDesc => 'شاشة العناوين.';

  @override
  String get screenMapPickerDesc => 'شاشة الخريطة.';

  @override
  String get screenNotificationsDesc => 'شاشة الإشعارات.';

  @override
  String get screenPlatedReturnReminderDesc => 'شاشة استرجاع الصينية.';

  @override
  String get screenOffersDesc => 'شاشة العروض.';

  @override
  String get screenCouponApplyDesc => 'شاشة كوبون.';

  @override
  String get screenComboBuilderDesc => 'شاشة بناء وجبة.';

  @override
  String get screenKitchenDashboardDesc => 'شاشة المطبخ.';

  @override
  String get screenOrderPrepDesc => 'شاشة تحضير الطلب.';

  @override
  String get screenInventoryDashboardDesc => 'شاشة المخزون.';

  @override
  String get screenInventoryItemDesc => 'شاشة تفاصيل الصنف.';

  @override
  String get screenStockAdjustmentDesc => 'شاشة تعديل المخزون.';

  @override
  String get screenDeliveryDashboardDesc => 'شاشة التوصيل.';

  @override
  String get screenDeliveryOrderDesc => 'شاشة طلب التوصيل.';

  @override
  String get screenPlatedReturnTaskDesc => 'شاشة مهام الاسترجاع.';

  @override
  String get screenPlatedReturnProcessDesc => 'شاشة معالجة الاسترجاع.';

  @override
  String get screenCashierOrderDesc => 'شاشة كاشير.';

  @override
  String get screenCashierTipEntryDesc => 'شاشة بقشيش نقدي.';

  @override
  String get screenCashierDepositRefundDesc => 'شاشة استرداد عربون.';

  @override
  String get screenStaffAttendanceDesc => 'شاشة الحضور.';

  @override
  String get screenStaffDailyTipsDesc => 'شاشة بقشيش اليوم.';

  @override
  String get screenStaffTipHistoryDesc => 'شاشة سجل البقشيش.';

  @override
  String get screenAdminDashboardDesc => 'شاشة الإدارة.';

  @override
  String get screenOrdersManagementDesc => 'شاشة الطلبات.';

  @override
  String get screenOrderDetailAdminDesc => 'شاشة تفاصيل الطلب.';

  @override
  String get screenReportsDesc => 'شاشة التقارير.';

  @override
  String get screenReportFilterDesc => 'شاشة فلاتر التقرير.';

  @override
  String get screenFinancialCalculationDesc => 'شاشة الحساب المالي.';

  @override
  String get screenDailyTipDistributionDesc => 'شاشة توزيع البقشيش.';

  @override
  String get screenPlatesManagementDesc => 'شاشة الصواني.';

  @override
  String get screenPlateEditorDesc => 'شاشة تعديل صينية.';

  @override
  String get screenDepositConfigDesc => 'شاشة إعداد العربون.';

  @override
  String get screenUserManagementDesc => 'شاشة المستخدمون.';

  @override
  String get screenMenuManagementDesc => 'شاشة إدارة المنيو.';

  @override
  String get screenProductEditorDesc => 'شاشة تعديل منتج.';

  @override
  String get screenOffersManagementDesc => 'شاشة إدارة العروض.';

  @override
  String get screenLoyaltyConfigDesc => 'شاشة إعداد الولاء.';

  @override
  String get screenOwnerViewConfigDesc => 'شاشة خصوصية المالك.';

  @override
  String get screenPreOrderDesc => 'شاشة طلبات مسبقة.';

  @override
  String get screenSettingsDesc => 'شاشة الإعدادات.';

  @override
  String get screenAuditLogDesc => 'شاشة سجل التدقيق.';

  @override
  String get screenStaffHoursReportDesc => 'شاشة ساعات الموظفين.';

  @override
  String get otpVerificationSubtitle => 'أدخل رمز التحقق المكوّن من 6 أرقام المرسل إلى هاتفك.';

  @override
  String get screenPaymentSubtitle => 'اختر طريقة الدفع لهذا الطلب.';

  @override
  String get paymentMethodCash => 'نقداً';

  @override
  String get paymentMethodCard => 'بطاقة / Visa';

  @override
  String get paymentMethodWallet => 'المحفظة';

  @override
  String get paymentErrorDemo => 'تم رفض الدفع. جرّب طريقة أخرى.';

  @override
  String get cashierCurrentOrder => 'الطلب الحالي';

  @override
  String get cashierWalkIn => 'داخل الصالة';

  @override
  String get cashierOrderEmpty => 'الطلب فارغ';

  @override
  String get cashierSubtotal => 'المجموع الفرعي';

  @override
  String get cashierTax => 'الضريبة (١٦٪)';

  @override
  String get cashierTotal => 'الإجمالي';

  @override
  String get cashierVoidOrder => 'إلغاء الطلب';

  @override
  String get cashierSaveDraft => 'حفظ كمسودة';

  @override
  String get cashierProcessPayment => 'معالجة الدفع';

  @override
  String get cashierFind => 'بحث';

  @override
  String get cashierShiftTotalRevenue => 'إيراد الوردية';

  @override
  String get cashierOrdersCount => 'عدد الطلبات';

  @override
  String cashierAverageOrder(String amount) {
    return 'المتوسط: $amount د.أ/طلب';
  }

  @override
  String get cashierSearchHint => 'ابحث برقم الطلب أو المبلغ...';

  @override
  String get cashierAllOrders => 'كل الطلبات';

  @override
  String get cashierRecentTransactions => 'آخر العمليات';

  @override
  String get cashierPaid => 'مدفوع';

  @override
  String get cashierRefunded => 'مسترد';

  @override
  String get cashierLoadOlder => 'تحميل عمليات أقدم';

  @override
  String get cashierShiftDelta => '+١٢٪ عن الوردية السابقة';

  @override
  String get cashierCurrentShiftTips => 'بقشيش الوردية الحالي';

  @override
  String get cashierEnterAmount => 'أدخل المبلغ';

  @override
  String get cashierAssignTipTo => 'تعيين البقشيش إلى';

  @override
  String get cashierSharedPool => 'صندوق مشترك';

  @override
  String get cashierLogTipEntry => 'تسجيل البقشيش';

  @override
  String get cashierMenuSearchHint => 'ابحث عن صنف، عرض، كومبو، أو وصف...';

  @override
  String get cashierPromotionsTitle => 'العروض، الكومبو، الخصومات، الاشتراكات';

  @override
  String get cashierLocationDetails => 'تفاصيل الموقع';

  @override
  String get cashierTableNumber => 'رقم الطاولة';

  @override
  String get cashierNoTableNeeded => 'لا يوجد رقم طاولة';

  @override
  String get cashierAddress => 'العنوان';

  @override
  String get cashierBuildingNumber => 'رقم المبنى';

  @override
  String get cashierFloorNumber => 'رقم الطابق';

  @override
  String get cashierDoorAccessCode => 'رمز دخول الباب الرئيسي (إذا لزم)';

  @override
  String get cashierContactPerson => 'شخص التواصل';

  @override
  String get cashierDeliveryTimeSchedule => 'موعد التوصيل';

  @override
  String get cashierSplitPayment => 'تقسيم الدفع';

  @override
  String get cashierSplitTotalMismatch => 'يجب أن يساوي مجموع التقسيم المبلغ المستحق.';

  @override
  String get cashierPaymentDetails => 'تفاصيل الدفع';

  @override
  String get cashierSelectPaymentMethod => 'اختر طريقة الدفع';

  @override
  String get cashierPriorBalance => 'الرصيد السابق';

  @override
  String get cashierPaymentReceived => 'تم استلام الدفع';

  @override
  String get cashierPaymentReceivedConfirmed => 'تم تأكيد الدفع';

  @override
  String get cashierCashReceived => 'النقد المستلم من العميل';

  @override
  String get cashierRemainingDue => 'المتبقي للدفع';

  @override
  String get cashierCashChange => 'المبلغ المعاد للعميل';

  @override
  String get cashierViewReceipt => 'عرض الفاتورة';

  @override
  String get cashierPrintRollReceipt => 'طباعة رول الفاتورة';

  @override
  String get cashierClientInvoice => 'فاتورة العميل';

  @override
  String get cashierInvoicePoints => 'النقاط المكتسبة';

  @override
  String get cashierItemsCount => 'الأصناف';

  @override
  String get cashierPromotionSavings => 'خصم العرض';

  @override
  String get cashierPromotionDiscounts => 'خصومات';

  @override
  String get cashierPromotionSubscriptions => 'اشتراكات';

  @override
  String get cashierTabOrder => 'التذكرة';

  @override
  String get cashierTabFulfillment => 'التوصيل';

  @override
  String get cashierTabTip => 'البقشيش';

  @override
  String get cashierTabPayment => 'الدفع';

  @override
  String get cashierTabConfirm => 'التأكيد';

  @override
  String get cashierBackTab => 'رجوع';

  @override
  String get cashierSendElectronicTicket => 'إرسال QR / تذكرة إلكترونية';

  @override
  String get cashierElectronicTicketSent => 'تم إرسال التذكرة الإلكترونية إلى هاتف العميل عبر واتساب';

  @override
  String get cashierSendOrderPreparation => 'إرسال الطلب للتحضير';

  @override
  String get cashierKeypadReset => 'مسح';

  @override
  String get cashierKeypadDelete => 'حذف';

  @override
  String get cashierKeypadDone => 'تم';

  @override
  String get cashierKeypadSpace => 'مسافة';

  @override
  String get cashierCashReturnDialogTitle => 'تأكيد المبلغ المعاد';

  @override
  String get cashierReceivedValue => 'المبلغ المستلم';

  @override
  String get cashierDeductedValue => 'المبلغ المخصوم';

  @override
  String get cashierReturnHighlighted => 'المبلغ المعاد للعميل';

  @override
  String get cashierReadyForConfirmation => 'جاهز';

  @override
  String get cashierPaymentPending => 'الدفع غير محدد';

  @override
  String get cashierFulfillmentCharge => 'نوع التوصيل';

  @override
  String get cashierTipAmount => 'البقشيش';

  @override
  String get cashierPaymentMethod => 'الدفع';

  @override
  String get cashierPaidAmount => 'المدفوع';

  @override
  String get cashierBalanceDue => 'الرصيد المستحق';

  @override
  String get cashierPostponeOrder => 'تأجيل الطلب';

  @override
  String get cashierPostponeTitle => 'تأجيل طلب غير مدفوع';

  @override
  String get cashierPostponeReason => 'السبب';

  @override
  String get cashierPostponeReasonVisaDeclined => 'البطاقة مرفوضة';

  @override
  String get cashierPostponeReasonFetchingCash => 'العميل يجلب النقود';

  @override
  String get cashierPostponeReasonNoChange => 'لا يوجد فكة';

  @override
  String get cashierPostponeReasonOther => 'سبب آخر';

  @override
  String get cashierPostponeNote => 'ملاحظات (اختياري)';

  @override
  String get cashierPostponeSaved => 'تم تأجيل الطلب — استئنافه من سجل الكاشير';

  @override
  String get cashierPostponed => 'مؤجل';

  @override
  String get cashierResumeOrder => 'استئناف الدفع';

  @override
  String get cashierNewOrder => 'بدء طلب جديد';

  @override
  String get cashierKitchenSent => 'أُرسل للمطبخ';

  @override
  String get cashierPromotionOffers => 'العروض';

  @override
  String get cashierPromotionCombos => 'الكومبو';

  @override
  String cashierDrawerIdentity(String number, String name) {
    return 'كاشير #$number · $name';
  }

  @override
  String get screenEditProfile => 'تعديل الملف';

  @override
  String get fieldEmail => 'البريد الإلكتروني';

  @override
  String get fieldPhone => 'الهاتف';

  @override
  String get actionEditProfile => 'تعديل الملف';

  @override
  String get adminKpiOrders => 'طلبات اليوم';

  @override
  String get adminKpiRevenue => 'الإيرادات';

  @override
  String get adminKpiTips => 'صندوق الإكراميات';

  @override
  String get adminOverviewSection => 'نظرة عامة';

  @override
  String get adminModulesSection => 'الوحدات';

  @override
  String get financialTotalsMismatch => 'المجاميع لا تطابق الدفتر — أعد الحساب قبل الإغلاق.';

  @override
  String get screenFinancialCalculationSubtitle => 'إجمالي الإيرادات والإكراميات والودائع اليومية.';

  @override
  String platedBreakageCost(String amount) {
    return 'الصحون المفقودة تُفرض رسوم $amount د.أ.';
  }

  @override
  String get screenPlatedReturnProcessSubtitle => 'عدّ الصحون المرتجعة وسجّل أي نقص.';

  @override
  String get profileAccountSection => 'الحساب';

  @override
  String get profileOrdersSection => 'الطلبات والمكافآت';

  @override
  String get platedDeliveryDepositNote => 'يُطبَّق وديعة قابلة للاسترداد على طلبات التوصيل بالصحون.';

  @override
  String get adminInventoryLowTitle => 'نقص مخزون: ستيك ريب آي';

  @override
  String get adminInventoryLowBody => 'تبقى ١٤ وحدة فقط. متوقع النفاد خلال ساعتين.';

  @override
  String get adminRestockAction => 'إعادة تزويد';

  @override
  String get adminPendingTipTitle => 'توزيع بقشيش معلق';

  @override
  String get adminPendingTipBody => '١٢ عملية بانتظار إغلاق الوردية للتوزيع.';

  @override
  String get adminReviewAction => 'مراجعة';

  @override
  String get adminRevenueToday => 'إجمالي الإيراد (اليوم)';

  @override
  String get adminRevenueDelta => '+١٤.٢٪ عن أمس';

  @override
  String get adminTipsCollected => 'البقشيش المحصل';

  @override
  String get adminTipsAwaiting => 'بانتظار التوزيع';

  @override
  String get adminTipHistoryAction => 'السجل';

  @override
  String get adminTipDistributeAction => 'توزيع';

  @override
  String get adminDailyTipPool => 'صندوق بقشيش اليوم';

  @override
  String get adminTipDeltaYesterday => '+١٢٪ عن أمس';

  @override
  String get adminStaffDistribution => 'توزيع الموظفين';

  @override
  String get adminMembersScheduled => 'موظفاً في الجدول';

  @override
  String get adminTotalHoursLogged => 'إجمالي الساعات المسجلة';

  @override
  String adminAverageRate(String amount) {
    return 'متوسط المعدل: $amount / ساعة';
  }

  @override
  String get adminStaffBreakdown => 'تفصيل الموظفين';

  @override
  String get adminRecalculatePool => 'إعادة حساب الصندوق';

  @override
  String get adminApproveAllDistributions => 'اعتماد كل التوزيعات';

  @override
  String get adminStaffMember => 'الموظف';

  @override
  String get adminRole => 'الدور';

  @override
  String get adminHours => 'الساعات';

  @override
  String get adminTipShare => 'حصة البقشيش';

  @override
  String get adminShowAllStaff => 'عرض كل ١٤ موظفاً';

  @override
  String get adminCalculationLogic => 'منطق الحساب';

  @override
  String get adminNetSalesTips => 'بقشيش صافي المبيعات (٨٥٪)';

  @override
  String get adminDirectServicePremium => 'علاوة الخدمة المباشرة (١٠٪)';

  @override
  String get adminCarryOver => 'ترحيل الإدارة (٥٪)';

  @override
  String get adminCalculatedPointRate => 'معدل النقاط المحسوب';

  @override
  String get adminShareDistribution => 'توزيع الحصص';

  @override
  String get adminLossBreakage => 'خسائر / كسر';

  @override
  String get adminBreakageReports => '٣ بلاغات مسجلة';

  @override
  String get adminBreakageOne => 'صنف غير معروف #٤٤١ · ٣ د.أ';

  @override
  String get adminBreakageTwo => 'مشروب تالف · ٢٥ د.أ';

  @override
  String get adminLiveOrderStatus => 'حالة الطلبات المباشرة';

  @override
  String get adminManageStations => 'إدارة المحطات';

  @override
  String get adminHighDemand => 'طلب مرتفع';

  @override
  String get adminNormalFlow => 'متوسط الانتظار';

  @override
  String get adminStationLoad => 'ضغط المحطات النشطة';

  @override
  String get adminGrillStation => 'محطة المشاوي';

  @override
  String get adminColdPrepStation => 'التحضير البارد / السلطات';

  @override
  String get adminCapacity => 'السعة';

  @override
  String get adminStaffOnShift => 'الموظفون في الوردية';

  @override
  String get adminManageRoster => 'إدارة الجدول';

  @override
  String get adminStaffActive => 'نشط';

  @override
  String get adminStaffBreak => 'استراحة';

  @override
  String get adminMarketInsight => 'مؤشر السوق';

  @override
  String get adminMarketInsightBody => 'الطلب على أطباق الصواني أعلى ٢٢٪ هذا المساء مقارنة بالجمعة الماضية. يُنصح بزيادة تجهيز المقبلات.';

  @override
  String get adminNavOrders => 'طلبات';

  @override
  String get adminNavPos => 'POS';

  @override
  String get adminNavKitchen => 'مطبخ';

  @override
  String get adminNavDelivery => 'توصيل';

  @override
  String get adminNavAdmin => 'إدارة';

  @override
  String get screenCashierOrderHistoryDesc => 'شاشة سجل طلبات الكاشير.';

  @override
  String get dineWelcomeTitle => 'أهلاً بك على طاولتنا';

  @override
  String get dineWelcomeSubtitle => 'أدخل رقم الطاولة لبدء الطلب';

  @override
  String get dineScanQrCode => 'مسح رمز QR';

  @override
  String get dineOr => 'أو';

  @override
  String get dineCurrencyStatus => 'حالة العملة';

  @override
  String get dineCurrencySubtitle => 'الدفع بالدينار الأردني';

  @override
  String get financialGrossRevenue => 'إجمالي الإيراد';

  @override
  String get financialRevenueDelta => '+١٢.٥٪ عن الفترة السابقة';

  @override
  String get financialTotalTipsExcluded => 'إجمالي البقشيش (مستثنى)';

  @override
  String get financialTipsSeparate => 'يوزع على الموظفين بشكل منفصل';

  @override
  String get financialEscrowDeposits => 'عربونات معلقة';

  @override
  String get financialEscrowSubtitle => 'أموال مشروطة قيد التسوية';

  @override
  String get financialProfitEngine => 'محرك توزيع الأرباح';

  @override
  String get financialNetRevenue => 'صافي الإيراد القابل للتوزيع';

  @override
  String get financialPrdSplitLogic => 'منطق التقسيم حسب PRD';

  @override
  String get financialOwnerShare => 'حصة المالك';

  @override
  String get financialOperatorShare => 'حصة المشغل';

  @override
  String get financialRevenueLogicBreakdown => 'تفصيل منطق الإيرادات';

  @override
  String get financialPhaseOne => 'المرحلة ١';

  @override
  String get financialPhaseTwo => 'المرحلة ٢';

  @override
  String get financialTotalCapturedRevenue => 'إجمالي الإيراد المحصل';

  @override
  String get financialTipsExcludedFromShare => 'البقشيش (مستثنى من التقسيم)';

  @override
  String get financialOperationalExpenses => 'المصاريف التشغيلية (قبل التقسيم)';

  @override
  String get financialNetDistributablePool => 'صافي المبلغ القابل للتوزيع';

  @override
  String get financialShareAllocation => 'تخصيص الحصص (PRD v2.1)';

  @override
  String get financialOwnerTier => 'شريحة المالك ١';

  @override
  String get financialPrimary => 'أساسي';

  @override
  String get financialOperatorPerformance => 'أداء المشغل';

  @override
  String get financialIncentivized => 'محفز';

  @override
  String get financialBaseMultiplier => 'معامل الأساس';

  @override
  String get financialAllocatedAmount => 'المبلغ المخصص';

  @override
  String get financialInitiateDisbursement => 'بدء التحويل البنكي';

  @override
  String get financialWhyMathMatters => 'لماذا هذه الحسابات مهمة.';

  @override
  String get financialWhyBody => 'يضمن محرك توزيع الأرباح احتساب كل دينار عبر فصل الإيراد الإجمالي عن الربح القابل للتوزيع، واستثناء بقشيش الموظفين، وإبقاء العربونات المستردة خارج تقسيم المالك والمشغل.';

  @override
  String get financialPdfReport => 'تنزيل تقرير PDF';

  @override
  String get financialSharePartners => 'مشاركة مع الشركاء';

  @override
  String get financialOrders => 'الطلبات';

  @override
  String get financialPos => 'نقاط البيع';

  @override
  String get financialAdmin => 'الإدارة';

  @override
  String get financialDelivery => 'التوصيل';

  @override
  String get forgotPasswordTitle => 'نسيت كلمة المرور';

  @override
  String get forgotPasswordSubtitle => 'أدخل رقم الهاتف أو البريد المسجل لاستلام رمز إعادة التعيين';

  @override
  String get forgotEmailPhoneLabel => 'البريد الإلكتروني أو رقم الهاتف';

  @override
  String get forgotEmailPhoneHint => 'مثال: guest@ayletna.com';

  @override
  String get forgotSendCode => 'إرسال الرمز';

  @override
  String get forgotBackToLogin => 'العودة لتسجيل الدخول';

  @override
  String get forgotNeedHelp => 'تحتاج مساعدة؟';

  @override
  String get forgotContactSupport => 'تواصل مع دعم عيلتنا';

  @override
  String get guestMenuNav => 'المنيو';

  @override
  String get guestLocationsNav => 'الفروع';

  @override
  String get guestAboutNav => 'عن عيلتنا';

  @override
  String get guestLimitedOffer => 'عرض لفترة محدودة';

  @override
  String get guestRoyalMansafTitle => 'تجربة المنسف الملكي';

  @override
  String get guestRoyalMansafSubtitle => 'جميد كرك أصيل ولحم محلي طري. خصم ١٥٪ للضيوف الجدد.';

  @override
  String get guestWeekendFeast => 'وليمة نهاية الأسبوع';

  @override
  String get guestWeekendFeastSubtitle => 'اطلب أي مقبلات وطبق رئيسي واحصل على شراب جلاب مجاناً.';

  @override
  String get guestClaimOffer => 'احصل على العرض';

  @override
  String get guestMansafSpecials => 'مختارات المنسف';

  @override
  String guestItemsFound(int count) {
    return '$count أصناف';
  }

  @override
  String get guestRefreshingDrinks => 'مشروبات منعشة';

  @override
  String get guestBrowseMore => 'تصفح المزيد';

  @override
  String get guestMintLemonade => 'ليمون بالنعناع';

  @override
  String get guestArabicCoffee => 'قهوة عربية';

  @override
  String get guestLocalWater => 'مياه محلية';

  @override
  String get guestSageTea => 'شاي ميرمية';

  @override
  String get homeSearchHint => 'ابحث عن منسف أو شاورما أو المزيد...';

  @override
  String get screenSearch => 'البحث';

  @override
  String get searchTitle => 'ابحث عن وجبتك التالية';

  @override
  String get searchSubtitle => 'ابحث في قائمة عيلتنا باسم الطبق أو التصنيف أو وصف النكهة.';

  @override
  String get searchStartTitle => 'اكتب اسم الطبق';

  @override
  String get searchStartBody => 'جرّب شاورما، حمص، بيتزا، فلافل، برغر، أو أي طلب من القائمة.';

  @override
  String get searchEmptyTitle => 'لم نجد أطباقاً';

  @override
  String get searchEmptyBody => 'جرّب اسم طبق آخر أو تصفح كل أقسام القائمة.';

  @override
  String searchResultsCount(int count) {
    return 'تم العثور على $count نتيجة';
  }

  @override
  String get searchPopularSuggestions => 'عمليات بحث شائعة';

  @override
  String get searchBrowseMenu => 'تصفح القائمة كاملة';

  @override
  String get homePlatedDelivery => 'توصيل بصواني';

  @override
  String get homeZeroWasteTitle => 'طعم تقليدي،\nبدون هدر.';

  @override
  String get homeZeroWasteSubtitle => 'استمتع بوليمتك على صواني فخارية أصيلة. عربون ٥ د.أ مسترد لكل صينية.';

  @override
  String get homeOrderNow => 'اطلب الآن';

  @override
  String get homeOffers => 'العروض';

  @override
  String get homeCombos => 'الكومبو';

  @override
  String get homeDiscounts => 'أصناف عليها خصم';

  @override
  String get homeSubscriptions => 'وجبات الاشتراك';

  @override
  String get homeStories => 'من عيلتنا';

  @override
  String get homeSubscriptionCta => 'اشترك';

  @override
  String get homeDiscountBadge => 'وفر';

  @override
  String get homePopularThisWeek => 'الأكثر طلباً هذا الأسبوع';

  @override
  String get homeViewAll => 'عرض الكل';

  @override
  String get homeSustainabilityDeposit => 'عربون الاستدامة';

  @override
  String get homeSustainabilityBody => 'اختر خيار الصواني لتجربة صديقة للبيئة. يضاف عربون بسيط لأوانينا الفاخرة ويسترد بالكامل عند جمع الصواني بعد وجبتك.';

  @override
  String get homeLearnHowItWorks => 'اعرف كيف يعمل';

  @override
  String get inventorySearchHint => 'ابحث في المكونات...';

  @override
  String get inventoryLogWastage => 'تسجيل الهدر';

  @override
  String get inventoryAddStock => 'إضافة مخزون';

  @override
  String get inventoryLowStockAlerts => 'تنبيهات انخفاض المخزون';

  @override
  String get inventoryProtein => 'بروتين';

  @override
  String get inventoryDairy => 'ألبان';

  @override
  String get inventoryProduce => 'خضار';

  @override
  String get inventoryPantry => 'مؤن';

  @override
  String get inventoryRibeyeSteak => 'ستيك رايب آي';

  @override
  String get inventoryHeavyCream => 'كريمة طبخ';

  @override
  String get inventoryFreshBasil => 'ريحان طازج';

  @override
  String get inventoryTruffleOil => 'زيت الكمأة';

  @override
  String inventoryRemaining(String amount) {
    return '$amount متبقي';
  }

  @override
  String get inventoryOutOfStock => 'نفد من المخزون';

  @override
  String inventoryReorderPoint(String amount) {
    return 'حد إعادة الطلب: $amount';
  }

  @override
  String get inventoryRequiredForDishes => 'مطلوب لـ ٤ أطباق';

  @override
  String get inventoryKeyLevels => 'مستويات المكونات الرئيسية';

  @override
  String get inventoryFullList => 'قائمة المخزون الكاملة';

  @override
  String get inventoryOrganicChicken => 'صدر دجاج عضوي';

  @override
  String get inventoryDairyEggs => 'مجموعة الألبان والبيض';

  @override
  String get inventorySeafood => 'مأكولات بحرية (سلمون/سي باس)';

  @override
  String get inventoryFlourStaples => 'طحين ومؤن جافة';

  @override
  String inventoryLevelMeta(int percent, String capacity) {
    return '$percent% / $capacity';
  }

  @override
  String get inventoryValue => 'قيمة المخزون';

  @override
  String get inventoryValueDelta => '+٢.٤٪ عن الأسبوع الماضي';

  @override
  String get inventoryPendingOrders => 'طلبات معلقة';

  @override
  String get inventoryShipmentsToday => '٣ شحنات متوقعة اليوم';

  @override
  String get inventoryStorageHealth => 'حالة التخزين';

  @override
  String get inventoryColdStorage => 'التخزين البارد';

  @override
  String get inventoryDryStorage => 'التخزين الجاف';

  @override
  String get inventoryFreezerUnit => 'الفريزر ب';

  @override
  String get inventoryOptimal => 'مثالي';

  @override
  String get inventoryAlert => 'تنبيه';

  @override
  String get inventoryRecentWastage => 'سجلات الهدر الأخيرة';

  @override
  String get inventoryDownloadReport => 'تنزيل التقرير';

  @override
  String get inventoryItemName => 'اسم الصنف';

  @override
  String get inventoryQuantity => 'الكمية';

  @override
  String get inventoryReason => 'السبب';

  @override
  String get inventoryValueLost => 'القيمة المفقودة';

  @override
  String get inventoryLogDate => 'تاريخ التسجيل';

  @override
  String get inventoryUser => 'المستخدم';

  @override
  String get inventoryAvocadoCase => 'أفوكادو (كرتونة)';

  @override
  String get inventoryWholeMilk => 'حليب كامل الدسم';

  @override
  String get inventorySeaBassFillets => 'فيليه سي باس';

  @override
  String get inventorySpoilage => 'تلف';

  @override
  String get inventoryExpired => 'منتهي';

  @override
  String get inventoryPrepWaste => 'هدر تحضير';

  @override
  String get inventoryChefUser => 'فريق الشيف';

  @override
  String get inventoryAdminUser => 'فريق الإدارة';

  @override
  String get inventoryItemAtlanticSalmon => 'سلمون أطلسي';

  @override
  String get inventoryItemSupplyBadge => 'توريد الصالة';

  @override
  String get inventoryItemPremiumFillet => 'فيليه درجة ممتازة';

  @override
  String get inventoryItemSku => 'SKU: INV-SAL-042 | طازج ومصيد برياً';

  @override
  String get inventoryCurrentStock => 'المخزون الحالي';

  @override
  String get inventoryKg => 'كغ';

  @override
  String get inventorySafetyThreshold => 'حد الأمان';

  @override
  String get inventoryHealthyInventory => 'مخزون صحي';

  @override
  String get inventoryAdjustStock => 'تعديل المخزون';

  @override
  String get inventoryAdjustmentQuantity => 'كمية التعديل (كغ)';

  @override
  String get inventoryAdjustmentHint => 'مثال: -٢.٥';

  @override
  String get inventoryReasonAdjustment => 'سبب التعديل';

  @override
  String get inventoryConsumption => 'استهلاك';

  @override
  String get inventoryDamageSpoilage => 'تلف / فساد';

  @override
  String get inventoryCorrection => 'تصحيح';

  @override
  String get inventoryArrivalShipment => 'وصول شحنة';

  @override
  String get inventoryThresholdConfig => 'إعداد حد الأمان';

  @override
  String get inventoryLowStockTrigger => 'يفعّل تنبيه انخفاض المخزون عند هذا المستوى.';

  @override
  String get inventoryUpdateInventory => 'تحديث المخزون';

  @override
  String get inventoryMainSupplier => 'المورد الرئيسي';

  @override
  String get inventorySupplierName => 'مصائد شمال الأطلسي';

  @override
  String get inventorySupplierLeadTime => 'مدة التوريد: يومان عمل';

  @override
  String get inventoryContactRepresentative => 'تواصل مع المندوب';

  @override
  String get inventoryLastSevenDaysUsage => 'استخدام آخر ٧ أيام';

  @override
  String get inventoryInStock => 'متوفر';

  @override
  String get inventoryRecentHistoryAudit => 'تدقيق السجل الأخير';

  @override
  String get inventoryDate => 'التاريخ';

  @override
  String get inventoryType => 'النوع';

  @override
  String get inventoryAmount => 'الكمية';

  @override
  String get inventoryBalance => 'الرصيد';

  @override
  String get inventoryTodayTime => 'اليوم، 09:12 ص';

  @override
  String get inventoryOct24Time => '٢٤ أكتوبر، 11:30 ص';

  @override
  String get inventoryOct23Time => '٢٣ أكتوبر، 05:45 م';

  @override
  String get inventoryDeliveryType => 'تسليم';

  @override
  String get inventoryChefShort => 'الشيف م.';

  @override
  String get inventorySysAdmin => 'مدير النظام';

  @override
  String get inventoryLineCook => 'طاهي الخط';

  @override
  String kitchenStatusWithCount(String status, int count) {
    return '$status ($count)';
  }

  @override
  String kitchenOrderTitle(String id) {
    return 'طلب #$id';
  }

  @override
  String kitchenOrderMeta(String source, String time) {
    return '$source • $time';
  }

  @override
  String get kitchenDone => 'تم';

  @override
  String get kitchenTable12 => 'طاولة ١٢';

  @override
  String get kitchenTable04 => 'طاولة ٠٤';

  @override
  String get kitchenUberEats => 'أوبر إيتس';

  @override
  String get kitchenPickup => 'استلام';

  @override
  String get kitchenWagyuBurger => '٢x برغر واجيو';

  @override
  String get kitchenBurgerNote => 'بدون بصل، جبنة إضافية';

  @override
  String get kitchenTruffleFries => '١x بطاطا ترافل';

  @override
  String get kitchenMargheritaPizza => '١x بيتزا مارغريتا';

  @override
  String get kitchenGardenSalad => '١x سلطة الحديقة';

  @override
  String get kitchenCrispyTacos => '٤x تاكوس مقرمش';

  @override
  String get kitchenGuacamoleDip => '٢x غموس غواكامولي';

  @override
  String get kitchenRoastChicken => '١x دجاج مشوي';

  @override
  String get kitchenMashedPotatoes => '١x بطاطا مهروسة';

  @override
  String prepTitle(String id) {
    return 'تحضير طلب #$id';
  }

  @override
  String get prepPlated => 'صواني';

  @override
  String get prepTable14 => 'طاولة ١٤';

  @override
  String get prepGuestName => 'الضيف: ألكسندر ميرسر';

  @override
  String get prepCovers => '٤ أشخاص';

  @override
  String get prepReceived => 'استلم 14:20';

  @override
  String get prepOrderItems => 'أصناف الطلب';

  @override
  String get prepItemsTotal => '٥ أصناف';

  @override
  String prepQuantity(int count) {
    return '${count}x';
  }

  @override
  String get prepWagyuBurger => 'برغر واجيو';

  @override
  String get prepNoOnions => 'بدون بصل';

  @override
  String get prepBurgerSpecs => 'نضج متوسط • خبز بريوش • مخلل إضافي';

  @override
  String get prepTruffleFries => 'بطاطا ترافل';

  @override
  String get prepFriesSpecs => 'غبار بارميزان • إكليل الجبل • صوص ترافل جانبي';

  @override
  String get prepHouseCaesar => 'سلطة سيزر البيت';

  @override
  String get prepCaesarSpecs => 'الدريسنج على الجانب • بدون أنشوفة';

  @override
  String get prepKitchenNotes => 'ملاحظات المطبخ';

  @override
  String get prepKitchenNoteBody => 'احتفال عيد ميلاد على طاولة ١٤. يرجى خروج كل أطباق الصواني معاً. الضيف في المقعد ٢ لديه حساسية شديدة من البصل؛ اتبع بروتوكول منع التلوث المتبادل لبرغر واجيو.';

  @override
  String get prepServer => 'المضيف: ديفيد ك.';

  @override
  String get prepUrgent => 'عاجل';

  @override
  String get prepStages => 'مراحل التحضير';

  @override
  String get prepOrderReceived => 'تم استلام الطلب (14:20)';

  @override
  String get prepStarted => 'بدأ التحضير (14:22)';

  @override
  String get prepAssemblyProgress => 'التجميع قيد التنفيذ';

  @override
  String get prepFinalPlating => 'التقديم النهائي';

  @override
  String get prepKitchenEfficiency => 'كفاءة المطبخ';

  @override
  String get prepSustainability => '٩٤٪ استدامة';

  @override
  String get prepBack => 'رجوع';

  @override
  String get prepIssue => 'مشكلة';

  @override
  String get prepProgress => 'التقدم';

  @override
  String prepItemsChecked(int checked, int total) {
    return '$checked / $total أصناف مكتملة';
  }

  @override
  String get prepMarkReady => 'تحديد كجاهز';

  @override
  String get kitchenView => 'عرض المطبخ';

  @override
  String get kitchenReadyHandover => 'جاهز للتسليم';

  @override
  String get kitchenAllActive => 'كل النشطة';

  @override
  String get kitchenReadyCount => 'جاهز (١٢)';

  @override
  String get kitchenPreparing => 'قيد التحضير';

  @override
  String get kitchenDelayed => 'متأخر';

  @override
  String get kitchenAverageReadyTime => 'متوسط وقت الجاهزية';

  @override
  String get kitchenReadyMinutes => '٤:١٢ دقيقة';

  @override
  String get kitchenHighestVolumeType => 'أعلى نوع طلبات';

  @override
  String get kitchenStationEfficiency => 'كفاءة المحطة';

  @override
  String kitchenReadyTimer(String time) {
    return 'جاهز $time';
  }

  @override
  String kitchenOrd(String id) {
    return 'طلب #$id';
  }

  @override
  String get kitchenSustainability => 'استدامة';

  @override
  String get kitchenExpressCounter => 'كاونتر سريع';

  @override
  String get kitchenGuestSarah => 'الضيف: سارة و.';

  @override
  String get kitchenDoorDashJames => 'دورداش: جيمس';

  @override
  String get kitchenGuestMike => 'الضيف: مايك ر.';

  @override
  String get kitchenSignatureWagyuBurger => 'برغر واجيو مميز';

  @override
  String get kitchenTruffleParmesanFries => 'بطاطا ترافل وبارميزان';

  @override
  String get kitchenIcedMatchaLatte => 'ماتشا لاتيه مثلج';

  @override
  String get kitchenZeroWasteKaleBowl => 'بول كيل بدون هدر';

  @override
  String get kitchenRecycledPulpJuice => 'عصير لب معاد الاستخدام';

  @override
  String get kitchenCustomerWaiting => 'العميل ينتظر منذ أكثر من ١٥ دقيقة';

  @override
  String get kitchenMediterraneanPlate => 'طبق متوسطي';

  @override
  String get kitchenExtraPitaSide => 'خبز بيتا إضافي';

  @override
  String get kitchenCrispyChickenSando => 'ساندويتش دجاج مقرمش';

  @override
  String get kitchenSpicyRamenCombo => 'كومبو رامن حار';

  @override
  String get kitchenGardenFreshSalad => 'سلطة حديقة طازجة';

  @override
  String get kitchenSpicedTofuTacos => 'تاكوس توفو متبل';

  @override
  String get kitchenRoastedCornDip => 'غموس ذرة مشوية';

  @override
  String get kitchenHandoverServer => 'تسليم للنادل';

  @override
  String get kitchenHandoverNow => 'تسليم الآن';

  @override
  String get kitchenHandoverGuest => 'تسليم للضيف';

  @override
  String get kitchenHandoverCourier => 'تسليم للمندوب';

  @override
  String get languageWelcomeTitle => 'أهلاً وسهلاً';

  @override
  String get languageWelcomeSubtitle => 'اختر لغتك المفضلة للمتابعة';

  @override
  String get languageEnglishSubtitle => 'الواجهة الغربية';

  @override
  String get languageArabicSubtitle => 'الواجهة العربية';

  @override
  String get languageAccessGateway => 'بوابة وصول موحدة';

  @override
  String get loginWelcomeBack => 'أهلاً بعودتك';

  @override
  String get loginOperationalSubtitle => 'اطلب وجباتك المفضلة، وتابع وليمتك، وعد بسرعة لما تحبه.';

  @override
  String get loginPhoneOrEmail => 'الهاتف أو البريد الإلكتروني';

  @override
  String get loginEmailHint => 'مثال: guest@ayletna.com';

  @override
  String get loginAction => 'دخول';

  @override
  String get loginOr => 'أو';

  @override
  String get loginContinueGuest => 'المتابعة كضيف';

  @override
  String get loginNoAccount => 'ليس لديك حساب؟';

  @override
  String get loginTrustSecure => 'آمن';

  @override
  String get loginTrustCloudSync => 'مفضلات طازجة';

  @override
  String get loginTrustSupport => 'عناية بالضيوف';

  @override
  String get loginPasswordHint => '••••••••';

  @override
  String get loyaltyTitle => 'الولاء والمكافآت';

  @override
  String get loyaltySubtitle => 'استمتع بكل لقمة واجمع كل نقطة.';

  @override
  String get loyaltyGoldMember => 'عضو ذهبي';

  @override
  String get loyaltySavorPoints => 'نقاط عيلتنا';

  @override
  String get loyaltyLifetimePoints => 'نقاط مدى الحياة';

  @override
  String get loyaltyNextTier => 'المستوى التالي: بلاتيني';

  @override
  String get loyaltyEarnMore => 'اكسب 550 نقطة إضافية للترقية';

  @override
  String get loyaltyProgressPercent => '82%';

  @override
  String get loyaltyCurrentGold => 'الحالي: ذهبي';

  @override
  String get loyaltyGoalPoints => 'الهدف: 3,000 نقطة';

  @override
  String get loyaltyGoldPerks => 'مزايا الذهبي';

  @override
  String get loyaltyPerkMultiplier => 'نقاط 1.5x على كل طلب';

  @override
  String get loyaltyPerkPriority => 'أولوية في حجز الطاولات';

  @override
  String get loyaltyPerkDessert => 'حلوى عيد ميلاد مجانية';

  @override
  String get loyaltyExplorePlatinum => 'استكشف مزايا البلاتيني';

  @override
  String get loyaltyAvailableRewards => 'المكافآت المتاحة';

  @override
  String get loyaltyFilter => 'تصفية';

  @override
  String get loyaltySort => 'ترتيب';

  @override
  String get loyaltyPopular => 'الأكثر طلباً';

  @override
  String get loyaltyRedeem => 'استبدال';

  @override
  String get loyaltyLocked => 'مغلق';

  @override
  String get loyaltySignaturePlatter => 'طبق مشاوي فاخر';

  @override
  String get loyaltySignaturePlatterDesc => 'استبدله بطبق مشاوي كامل مع ثلاثة أطباق جانبية.';

  @override
  String get loyaltyLargePizza => 'أي فطيرة كبيرة';

  @override
  String get loyaltyLargePizzaDesc => 'اختر أي فطيرة كبيرة من قائمة فرن العائلة.';

  @override
  String get loyaltyFreeDessert => 'حلوى مجانية';

  @override
  String get loyaltyFreeDessertDesc => 'تحلية يومية مختارة من شيف الحلويات.';

  @override
  String get loyaltyChefTasting => 'تجربة الشيف لشخصين';

  @override
  String get loyaltyChefTastingDesc => 'تجربة تذوق خاصة من إعداد الشيف التنفيذي.';

  @override
  String loyaltyPointsShort(String points) {
    return '$points نقطة';
  }

  @override
  String get loyaltyDine => 'تناول';

  @override
  String get loyaltyDineDesc => 'اكسب 10 نقاط مقابل كل 1 دينار في أي فرع من عيلتنا.';

  @override
  String get loyaltyCollect => 'اجمع';

  @override
  String get loyaltyCollectDesc => 'راقب نقاطك وهي تزيد وافتح مزايا المستويات المميزة.';

  @override
  String get loyaltyEnjoy => 'استمتع';

  @override
  String get loyaltyEnjoyDesc => 'استبدل نقاطك التي جمعتها بمكافآت حصرية.';

  @override
  String get mapSearchHint => 'ابحث عن عنوان التوصيل...';

  @override
  String get mapSearchValue => '123 شارع غاسترونومي، جناح 400';

  @override
  String get mapDeliveryPin => 'دبوس التوصيل';

  @override
  String get mapConfirmLocation => 'تأكيد الموقع';

  @override
  String get mapSelectedAddress => '123 شارع غاسترونومي، المركز، عمّان';

  @override
  String get mapAddNote => 'إضافة ملاحظة';

  @override
  String get mapConfirmContinue => 'تأكيد ومتابعة';

  @override
  String get mapQuickHome => 'المنزل';

  @override
  String get mapQuickOffice => 'المكتب';

  @override
  String get mapQuickRecent => 'الأخيرة';

  @override
  String get menuManagementTitle => 'إدارة المنيو';

  @override
  String get menuManagementSubtitle => 'إدارة أصناف المنيو الرقمية والأسعار والتوفر المباشر.';

  @override
  String get menuAddNewItem => 'إضافة صنف جديد';

  @override
  String get menuBulkImport => 'استيراد جماعي';

  @override
  String get menuTotalItems => 'إجمالي الأصناف';

  @override
  String get menuTotalItemsDelta => '▲ 4 هذا الشهر';

  @override
  String get menuActiveNow => 'النشط الآن';

  @override
  String get menuInactiveCount => '6 غير نشطة';

  @override
  String get menuOutOfStock => 'نفد المخزون';

  @override
  String get menuActionRequired => 'إجراء مطلوب';

  @override
  String get menuAvgPrice => 'متوسط السعر';

  @override
  String get menuMarketStable => 'السوق مستقر';

  @override
  String get menuAllCategories => 'كل الأقسام';

  @override
  String get menuMainCourse => 'الأطباق الرئيسية';

  @override
  String get menuAppetizers => 'المقبلات';

  @override
  String get menuBeverages => 'المشروبات';

  @override
  String get menuDesserts => 'الحلويات';

  @override
  String get menuSearchHint => 'ابحث في أصناف المنيو...';

  @override
  String get menuInStock => 'متوفر';

  @override
  String get menuLowStock => 'مخزون منخفض (8)';

  @override
  String get menuOutOfStockLabel => 'غير متوفر';

  @override
  String get menuActive => 'نشط';

  @override
  String get menuInactive => 'غير نشط';

  @override
  String get menuDineIn => 'داخل المطعم';

  @override
  String get menuTakeaway => 'استلام';

  @override
  String get menuDelivery => 'توصيل';

  @override
  String get menuGrilledChickenSalad => 'سلطة دجاج مشوي';

  @override
  String get menuGrilledChickenSaladDesc => 'طبق رئيسي • خضار عضوية';

  @override
  String get menuSignatureBurger => 'برغر عيلتنا المميز';

  @override
  String get menuSignatureBurgerDesc => 'طبق رئيسي • برغر لحم';

  @override
  String get menuTruffleFries => 'بطاطا ترافل مقطعة يدوياً';

  @override
  String get menuTruffleFriesDesc => 'مقبلات • زيت الترافل';

  @override
  String get actionEdit => 'تعديل';

  @override
  String get actionRemove => 'إزالة';

  @override
  String get actionApply => 'تطبيق';

  @override
  String cartOrderItemsCount(int count) {
    return 'عناصر الطلب ($count)';
  }

  @override
  String get cartClearAll => 'مسح الكل';

  @override
  String get cartPromoCode => 'رمز الخصم';

  @override
  String get cartPromoHint => 'أدخل الرمز';

  @override
  String get cartOrderSummary => 'ملخص الطلب';

  @override
  String get cartFulfillment => 'طريقة الاستلام';

  @override
  String get cartSubtotal => 'المجموع الفرعي';

  @override
  String get cartFree => 'مجاني';

  @override
  String get cartDineInServiceFee => 'رسوم خدمة داخل المطعم';

  @override
  String get cartTakeawayPackagingFee => 'رسوم تغليف السفري';

  @override
  String get cartDeliveryFee => 'رسوم التوصيل';

  @override
  String get cartGroupDeliveryFee => 'رسوم التوصيل الجماعي';

  @override
  String get cartPlatedDeposit => 'عربون الصواني القابلة للإرجاع';

  @override
  String get cartEstimatedTax => 'الضريبة المقدرة (5٪)';

  @override
  String get cartTotal => 'الإجمالي';

  @override
  String get cartApproxUsd => 'تقريباً 30.73 دولار';

  @override
  String get cartProceedCheckout => 'المتابعة للدفع';

  @override
  String get cartGuestSignInPrompt => 'سجّل الدخول لإتمام الطلب ومتابعة التوصيل مباشرة.';

  @override
  String get cartCheckoutStepBasket => 'السلة';

  @override
  String get cartCheckoutStepFulfillment => 'الاستلام';

  @override
  String get cartCheckoutStepPayment => 'الدفع';

  @override
  String get cartCheckoutStepReview => 'المراجعة';

  @override
  String get demoModeBanner => 'وضع تجريبي — الإجراءات تستخدم بيانات وهمية ولا تُحفظ.';

  @override
  String get cartTermsNotice => 'بالضغط، أنت توافق على شروط الخدمة.';

  @override
  String get cartViewItems => 'عرض الأصناف';

  @override
  String get cartFulfillmentTitle => 'طريقة استلام الطلب';

  @override
  String get cartFulfillmentSubtitle => 'اختر طريقة الخدمة الآن داخل السلة بدون الانتقال لشاشة منفصلة.';

  @override
  String get cartGroupDeliveryTitle => 'توصيل جماعي';

  @override
  String get cartGroupDeliveryBody => 'انتظر طلباً قريباً من نفس المنطقة لتقليل تكلفة التوصيل وتحسين مسار الرحلة.';

  @override
  String get cartTermsAndConditions => 'الشروط والأحكام';

  @override
  String get cartSelectedAddress => 'العنوان المختار';

  @override
  String get cartAddressRequired => 'اختر عنوان توصيل افتراضي قبل المتابعة للدفع.';

  @override
  String get cartChooseAddress => 'اختر العنوان';

  @override
  String get cartPaymentType => 'طريقة الدفع';

  @override
  String get cartTipTitle => 'إضافة بقشيش';

  @override
  String get cartTipSubtitle => 'تقدير اختياري لفريق المطبخ والتوصيل.';

  @override
  String get cartNoTip => 'بدون بقشيش';

  @override
  String get cartHelpTitle => 'تحتاج مساعدة في طلبك؟';

  @override
  String get cartChatWithUs => 'تحدث معنا';

  @override
  String get supportHeroTitle => 'كيف يمكننا مساعدتك؟';

  @override
  String get supportHeroBody => 'اختر أسرع قناة دعم تجريبية لأسئلة الطلب أو تحديثات التوصيل أو المساعدة في الدفع.';

  @override
  String get supportLiveChatTitle => 'محادثة مباشرة';

  @override
  String get supportLiveChatBody => 'ابدأ محادثة سريعة مع فريق الخدمة.';

  @override
  String get supportCallTitle => 'الاتصال بالمطعم';

  @override
  String get supportCallBody => 'تحدث مع الاستقبال بخصوص التعديلات العاجلة على الطلب.';

  @override
  String get supportWhatsappTitle => 'دعم واتساب';

  @override
  String get supportWhatsappBody => 'أرسل رسالة مع تفاصيل طلبك ووقت التواصل المناسب.';

  @override
  String get supportOrderHelpTitle => 'مساعدة الطلب';

  @override
  String get supportOrderHelpBody => 'استخدم هذه الصفحة لأسئلة السلة والتوصيل والدفع وإرجاع الصواني.';

  @override
  String get supportFaqTitle => 'الأسئلة الشائعة';

  @override
  String get supportFaqBody => 'تصفح إجابات التوصيل والدفع وإرجاع الصواني.';

  @override
  String get supportTicketsTitle => 'تذاكر الدعم';

  @override
  String get supportTicketsSubtitle => 'تابع طلبات الدعم التجريبية المفتوحة والمغلقة.';

  @override
  String get supportTicketRequestFollowUp => 'طلب متابعة';

  @override
  String get supportTicketCancel => 'إلغاء التذكرة';

  @override
  String get supportTicketUrgent => 'تمييز كعاجلة';

  @override
  String get supportTicketActionSent => 'تم إرسال إجراء التذكرة.';

  @override
  String get supportTicketRateResponse => 'قيّم الرد';

  @override
  String get supportTicketRemarkLabel => 'ملاحظة على الرد';

  @override
  String get supportTicketRemarkHint => 'اكتب ملاحظة عن رد الدعم...';

  @override
  String get supportTicketSubmitRating => 'إرسال التقييم';

  @override
  String get supportTicketRatingSaved => 'تم حفظ تقييم التذكرة.';

  @override
  String get supportNewTicketTitle => 'تذكرة محادثة مباشرة';

  @override
  String get supportNewTicketBody => 'تم فتح جلسة محادثة جديدة مع فريق خدمة العملاء.';

  @override
  String get supportTicketOpened => 'تم فتح تذكرة دعم جديدة.';

  @override
  String get supportChatHeroTitle => 'محادثة دعم مباشرة';

  @override
  String get supportChatHeroBody => 'يبدأ الموظف بالمحادثة ويفتح تذكرة فقط إذا كانت المتابعة مطلوبة.';

  @override
  String get supportChatActiveSession => 'جلسة محادثة نشطة';

  @override
  String get supportChatNoTicketYet => 'لا توجد تذكرة حتى الآن';

  @override
  String get supportChatAgentGreeting => 'أهلاً بك في دعم عيلتنا. أخبرني بما حدث وسأقرر إذا كان الموضوع يحتاج تذكرة.';

  @override
  String get supportChatCustomerSample => 'أحتاج مساعدة في طلبي النشط.';

  @override
  String get supportChatAgentDecision => 'يمكنني مساعدتك هنا أولاً. إذا احتاج الموضوع متابعة من المطعم سأفتح تذكرة وتبقى ظاهرة في الدعم.';

  @override
  String get supportChatAgentName => 'موظف عيلتنا';

  @override
  String get supportChatCustomerName => 'أنت';

  @override
  String get supportChatAgentTicketNote => 'موظف الدعم فقط يمكنه فتح تذكرة متابعة بعد مراجعة المحادثة.';

  @override
  String get supportChatMessageLabel => 'الرسالة';

  @override
  String get supportChatMessageHint => 'اكتب سؤالك أو ملاحظة الطلب...';

  @override
  String get supportChatSend => 'إرسال الرسالة';

  @override
  String get supportChatOpenTicket => 'فتح تذكرة عند الحاجة';

  @override
  String get supportAdminSetupNote => 'أرقام هاتف المطعم وواتساب مجهزة مسبقاً للموك أب ويمكن تعديلها لاحقاً من إعدادات الإدارة.';

  @override
  String get supportExternalActionFallback => 'تعذر فتح هذا الإجراء. استخدم بيانات التواصل المعروضة.';

  @override
  String get screenFaq => 'الأسئلة الشائعة';

  @override
  String get faqHeroTitle => 'الأسئلة الشائعة';

  @override
  String get faqHeroBody => 'إجابات سريعة قبل فتح تذكرة دعم.';

  @override
  String get faqDeliveryTitle => 'كيف تعمل تحديثات التوصيل؟';

  @override
  String get faqDeliveryBody => 'الطلبات النشطة تعرض خطاً زمنياً. عندما يصبح الطلب في الطريق يظهر زر التواصل مع السائق.';

  @override
  String get faqPaymentTitle => 'ما طرق الدفع المدعومة؟';

  @override
  String get faqPaymentBody => 'الدفع التجريبي يعرض حالياً البطاقة والنقد، مع إبقاء شاشات المحفظة/الدفع للتهيئة لاحقاً.';

  @override
  String get faqPlatedTitle => 'كيف يعمل توصيل الصواني؟';

  @override
  String get faqPlatedBody => 'الصواني القابلة للإرجاع تشمل عربوناً مسترداً وتتبع تدفق تذكير إرجاع الصواني.';

  @override
  String get cartMargheritaPremium => 'مارغريتا بريميوم';

  @override
  String get cartMargheritaPremiumDesc => 'موزاريلا بوفالو إضافية وريحان طازج';

  @override
  String get cartFreshOrangeJuice => 'عصير برتقال طازج';

  @override
  String get cartFreshOrangeJuiceDesc => 'بارد وبدون سكر مضاف';

  @override
  String get cartChocoLavaDelight => 'شوكو لافا ديلايت';

  @override
  String get cartChocoLavaDelightDesc => 'مع جيلاتو فانيلا';

  @override
  String get orderHistoryTitle => 'سجل الطلبات';

  @override
  String get orderHistorySubtitle => 'إدارة تجاربك السابقة وإعادة طلب مفضلاتك.';

  @override
  String get orderHistoryFilter => 'تصفية';

  @override
  String get orderHistoryLast30Days => 'آخر 30 يوم';

  @override
  String get orderHistoryInsights => 'لمحات';

  @override
  String get orderHistoryTotalOrders => 'إجمالي الطلبات';

  @override
  String get orderHistoryTotalSpent => 'إجمالي الإنفاق (د.أ)';

  @override
  String get orderHistoryQuote => '\"تذوق الثبات في كل طلب.\"';

  @override
  String get orderHistoryWeekendSpecial => 'عرض نهاية الأسبوع';

  @override
  String get orderHistoryWeekendSubtitle => 'احصل على خصم 15٪ عند إعادة الطلب القادمة.';

  @override
  String get orderHistoryActive => 'نشط';

  @override
  String get orderHistoryViewStatus => 'عرض الحالة';

  @override
  String get orderHistoryProgressTitle => 'تقدم الطلب';

  @override
  String get orderHistoryCurrentStep => 'الخطوة الحالية';

  @override
  String get orderHistoryDoneStep => 'تم';

  @override
  String get orderHistoryRemainingStep => 'متبقي';

  @override
  String orderHistoryStepCounter(String current, String total) {
    return 'الخطوة $current من $total';
  }

  @override
  String get orderHistoryStatusUpdated => 'تم تحديث حالة الطلب النشط.';

  @override
  String get orderHistoryDriverContactTitle => 'تواصل مع السائق';

  @override
  String get orderHistoryDriverContactBody => 'طلبك في الطريق. اتصل بالسائق إذا كنت بحاجة لتنسيق التوصيل.';

  @override
  String get orderHistoryCallDriver => 'اتصل بالسائق';

  @override
  String get orderHistoryCompleted => 'مكتمل';

  @override
  String get orderHistoryCancelled => 'ملغي';

  @override
  String get orderHistoryViewInvoice => 'عرض الفاتورة';

  @override
  String get orderHistoryNoInvoice => 'لا توجد فاتورة';

  @override
  String get orderHistoryReorder => 'إعادة الطلب';

  @override
  String get orderHistoryTryAgain => 'حاول مرة أخرى';

  @override
  String get orderHistoryShowMore => 'عرض طلبات أكثر';

  @override
  String get orderHistoryOrder9821 => 'طلب #SV-9821';

  @override
  String get orderHistoryOrder9750 => 'طلب #SV-9750';

  @override
  String get orderHistoryOrder9612 => 'طلب #SV-9612';

  @override
  String get orderHistoryDate9821 => '12 أكتوبر 2023 • 14:30';

  @override
  String get orderHistoryDate9750 => '08 أكتوبر 2023 • 20:15';

  @override
  String get orderHistoryDate9612 => '02 أكتوبر 2023 • 19:45';

  @override
  String get orderHistoryDineInTable => 'داخل المطعم • طاولة 4';

  @override
  String get orderHistoryMansaf => '2x منسف تقليدي';

  @override
  String get orderHistoryArabicSalad => '1x سلطة عربية';

  @override
  String get orderHistoryMintLemonade => '3x ليمون بالنعناع';

  @override
  String get orderHistorySeaBass => '1x سمك قاروص مشوي';

  @override
  String get orderHistorySaffronRice => '2x أرز بالزعفران';

  @override
  String get orderHistoryMixedGrill => '4x طبق مشاوي مشكل';

  @override
  String get orderHistoryMezzeTray => '1x صينية مقبلات كبيرة';

  @override
  String get profileAccountSettings => 'إعدادات الحساب';

  @override
  String get profilePersonalProfile => 'الملف الشخصي';

  @override
  String get profileMemberName => 'لين حداد';

  @override
  String get profileMemberSince => 'عضو منذ يونيو 2022';

  @override
  String get profileEditDetails => 'تعديل تفاصيل الملف';

  @override
  String get profileChangePhoto => 'تغيير صورة الملف';

  @override
  String get profilePhotoUpdated => 'تم تحديث صورة الملف';

  @override
  String get profileEpicureanTier => 'فئة الذواقة';

  @override
  String get profileGoldStatus => 'المستوى الذهبي';

  @override
  String get profileSavorPoints => 'نقاط عيلتنا';

  @override
  String get profilePointsValue => '4,850';

  @override
  String get profileTierProgress => 'تبقى 1,150 نقطة للوصول إلى مزايا البلاتيني.';

  @override
  String get profileRewardsCatalog => 'كتالوج المكافآت';

  @override
  String get profilePointsHistory => 'نشاط النقاط';

  @override
  String get profilePointsHistorySubtitle => 'آخر نقاط المكافآت المكتسبة والمستبدلة.';

  @override
  String get profileViewAllPointsHistory => 'عرض كل السجل';

  @override
  String get profilePaymentHistory => 'سجل الدفع';

  @override
  String get profilePaymentHistorySubtitle => 'آخر عمليات الدفع الناجحة للعميل.';

  @override
  String get profileViewAllPaymentHistory => 'عرض سجل الدفع';

  @override
  String get profileContact => 'التواصل';

  @override
  String get profilePhoneNumber => 'رقم الهاتف';

  @override
  String get profilePhoneValue => '+962 7 9123 4567';

  @override
  String get profileEmailAddress => 'البريد الإلكتروني';

  @override
  String get profileEmailValue => 'leen.haddad@example.com';

  @override
  String get profileWalletBalance => 'رصيد المحفظة';

  @override
  String get profileWalletAmount => '124.50';

  @override
  String get profileWalletSubtitle => 'متاح للدفع الفوري';

  @override
  String get profileVisaEnding => 'فيزا تنتهي بـ 8842';

  @override
  String get profileVisaExpiry => 'تنتهي في 09/26';

  @override
  String get profileManage => 'إدارة';

  @override
  String get profileSavedAddresses => 'العناوين المحفوظة';

  @override
  String get profileAddNew => 'إضافة جديد';

  @override
  String get profileDeleteAddressTitle => 'حذف العنوان؟';

  @override
  String get profileDeleteAddressBody => 'هذا إجراء تجريبي يزيل العنوان المحفوظ من عرض ملفك.';

  @override
  String get profileHomeAddressTitle => 'المنزل';

  @override
  String get profileHomeAddress => '42 شارع الريم، شقة 4ب\nعمّان، الأردن';

  @override
  String get profileOfficeAddressTitle => 'المكتب';

  @override
  String get profileOfficeAddress => 'مجمع الأعمال، جناح 220\nعمّان، الأردن';

  @override
  String get profileNotificationPreferences => 'تفضيلات الإشعارات';

  @override
  String get profileOrderStatusUpdates => 'تحديثات حالة الطلب';

  @override
  String get profileOrderStatusSubtitle => 'إشعارات ورسائل لطلباتك النشطة';

  @override
  String get profileLoyaltyRewards => 'الولاء والمكافآت';

  @override
  String get profileLoyaltySubtitle => 'كشف شهري للنقاط ومزايا المستوى';

  @override
  String get profileMarketingOffers => 'التسويق والعروض';

  @override
  String get profileMarketingSubtitle => 'خصومات حصرية وإعلانات المنيو الموسمية';

  @override
  String get profileLogout => 'تسجيل الخروج';

  @override
  String get profileDeactivateAccount => 'تعطيل الحساب';

  @override
  String get settingsPersonalSubtitle => 'اعرض صورتك الشخصية واسمك وبيانات التواصل وتفضيلات الإشعارات.';

  @override
  String get settingsEmployeeSince => 'عضو في الفريق منذ يونيو 2022';

  @override
  String get settingsStaffDisplayName => 'عمر حسن';

  @override
  String get settingsStaffPhoneValue => '+962 7 9000 1122';

  @override
  String get settingsStaffEmailValue => 'omar.hassan@ayletna.com';

  @override
  String get settingsStaffShiftAlerts => 'تنبيهات الوردية والمهام';

  @override
  String get settingsStaffShiftAlertsSubtitle => 'تذكيرات المطبخ والتوصيل والمخزون والحضور.';

  @override
  String get settingsStaffOrderAlertsSubtitle => 'تحديثات الطلبات المرتبطة بمحطتك أو مسارك.';

  @override
  String get settingsBusinessSettingsHint => 'عمليات المطعم والأدوار والضرائب والإيصالات وتنبيهات النظام.';

  @override
  String get addressesTitle => 'العناوين المحفوظة';

  @override
  String get addressesAddNew => 'إضافة عنوان جديد';

  @override
  String get addressesDelete => 'حذف';

  @override
  String get addressesDefault => 'افتراضي';

  @override
  String get addressesHomeTitle => 'المنزل';

  @override
  String get addressesHomeBody => '124 شارع مابل، شقة 4ب، سيلفر سبرينغز، عمّان';

  @override
  String get addressesOfficeTitle => 'المكتب';

  @override
  String get addressesOfficeBody => 'مقر عيلتنا، 888 طريق الابتكار، جناح 200، عمّان';

  @override
  String get addressesGymTitle => 'النادي';

  @override
  String get addressesGymBody => 'مركز آيرون بيك، 45 شارع القوة، عمّان';

  @override
  String get addressesHelper => 'أدر أماكن التوصيل المتكررة بسهولة لتسريع الدفع.';

  @override
  String get mapAddressTitle => 'حفظ العنوان باسم';

  @override
  String get mapAddressTitleHint => 'المنزل، المكتب، بيت العائلة...';

  @override
  String get mapAddressText => 'العنوان المكتوب';

  @override
  String get mapAddressTextHint => 'المبنى، الشارع، الطابق، أقرب علامة...';

  @override
  String get mapSelectOnMap => 'اختيار الموقع من الخريطة';

  @override
  String get mapLocationSelected => 'تم اختيار الموقع من الخريطة';

  @override
  String get mapSaveAddress => 'حفظ العنوان';

  @override
  String get mapRequiredFields => 'اختر الموقع من الخريطة واكتب العنوان قبل الحفظ.';

  @override
  String get notificationsTitle => 'الإشعارات';

  @override
  String get notificationsSubtitle => 'ابقَ مطلعاً على آخر أنشطة المطبخ والتوصيل.';

  @override
  String get notificationsClearAll => 'مسح الكل';

  @override
  String get notificationsPreferences => 'التفضيلات';

  @override
  String get notificationsCategories => 'الفئات';

  @override
  String get notificationsAll => 'الكل';

  @override
  String get notificationsOrderUpdates => 'تحديثات الطلبات';

  @override
  String get notificationsSustainability => 'الاستدامة';

  @override
  String get notificationsAdminStaff => 'الإدارة/الموظفون';

  @override
  String get notificationsWeeklyReport => 'التقرير الأسبوعي';

  @override
  String get notificationsWeeklySubtitle => 'وصلت أهداف الاستدامة إلى 92٪ هذا الأسبوع!';

  @override
  String get notificationsViewDetails => 'عرض التفاصيل';

  @override
  String get notificationsRecentAlerts => 'التنبيهات الحديثة';

  @override
  String get notificationsYesterday => 'أمس';

  @override
  String get notificationsDeliveryTitle => 'الطلب #8829 خرج للتوصيل';

  @override
  String get notificationsDeliveryBody => 'استلم السائق أحمد الطلب وهو في الطريق إلى الوجهة.';

  @override
  String get notificationsTwoMins => 'قبل دقيقتين';

  @override
  String get notificationsTrackMap => 'تتبع الخريطة';

  @override
  String get notificationsContactDriver => 'تواصل مع السائق';

  @override
  String get notificationsTipTitle => 'توزيع البقشيش جاهز';

  @override
  String get notificationsTipBody => 'تم حساب صندوق بقشيش وردية الصباح وهو جاهز للتوزيع.';

  @override
  String get notificationsFifteenMins => 'قبل 15 دقيقة';

  @override
  String get notificationsDistributeNow => 'وزّع الآن';

  @override
  String get notificationsReviewBreakdown => 'مراجعة التفصيل';

  @override
  String get notificationsTrayTitle => 'تذكير جمع الصواني';

  @override
  String get notificationsTrayBody => 'تنبيه استدامة: هناك 12 صينية قابلة لإعادة الاستخدام لم تُعد بعد في نقاط جمع بلوك ب.';

  @override
  String get notificationsFortyFiveMins => 'قبل 45 دقيقة';

  @override
  String get notificationsPingStaff => 'تنبيه فريق الجمع';

  @override
  String get notificationsStockTitle => 'تنبيه مخزون: حبوب إسبريسو فاخرة';

  @override
  String get notificationsStockBody => 'انخفض مستوى المخزون دون حد 15٪. ننصح بإعادة التخزين قريباً لتجنب تعطل الخدمة.';

  @override
  String get notificationsOneHour => 'قبل ساعة';

  @override
  String get notificationsOrderMore => 'اطلب المزيد';

  @override
  String get notificationsIgnoreNow => 'تجاهل الآن';

  @override
  String get notificationsPickupTitle => 'الطلب #7741 جاهز للاستلام';

  @override
  String get notificationsPickupBody => 'الوجبة على الرف الساخن في المحطة 3.';

  @override
  String get notificationsThreeHours => 'قبل 3 ساعات';

  @override
  String get notificationsViewTicket => 'عرض التذكرة';

  @override
  String get notificationsPolicyTitle => 'تحديث سياسة جديد';

  @override
  String get notificationsPolicyBody => 'تم تحديث إرشادات التعقيم. يرجى مراجعة القائمة الجديدة في بوابة الموظفين.';

  @override
  String get notificationsTwentyFourHours => 'قبل 24 ساعة';

  @override
  String get notificationsAlertsNav => 'التنبيهات';

  @override
  String get orderConfirmedThanks => 'شكراً لك';

  @override
  String get orderConfirmedSuccess => 'تم إرسال طلبك بنجاح.';

  @override
  String get orderConfirmedNumberLabel => 'رقم الطلب';

  @override
  String get orderConfirmedNumber => '#CL-8829';

  @override
  String get orderConfirmedTypeLabel => 'نوع الطلب';

  @override
  String get orderConfirmedType => 'توصيل الصواني';

  @override
  String get orderConfirmedArrivalLabel => 'الوصول المتوقع';

  @override
  String get orderConfirmedArrival => '12:45 م - 1:15 م';

  @override
  String get orderConfirmedAddressLabel => 'عنوان التوصيل';

  @override
  String get orderConfirmedAddress => '221B شارع بيكر، عمّان';

  @override
  String get orderConfirmedTrack => 'تتبع الطلب';

  @override
  String get orderConfirmedHome => 'العودة للرئيسية';

  @override
  String get orderConfirmedEmailSent => 'تم إرسال رسالة تأكيد إلى بريدك الإلكتروني.';

  @override
  String get otpTitle => 'التحقق بالرمز';

  @override
  String otpSentCode(String phone) {
    return 'أرسلنا رمزاً من 6 أرقام إلى $phone';
  }

  @override
  String get otpMaskedPhone => '+962 XXX XXXX';

  @override
  String otpResendIn(String time) {
    return 'إعادة إرسال الرمز خلال $time';
  }

  @override
  String get otpCountdown => '00:56';

  @override
  String get otpResendCode => 'إعادة إرسال الرمز';

  @override
  String get otpResendLimitReached => 'وصلت إلى حد إعادة الإرسال. يرجى المحاولة لاحقاً.';

  @override
  String get otpSecurityNote => 'تستخدم عيلتنا تشفيراً بمستوى مصرفي لحماية أمان حسابك.';

  @override
  String get ownerDashboardTitle => 'الأداء التنفيذي';

  @override
  String get ownerDashboardSubtitle => 'الصحة المالية وتحليل الأرباح لحظياً لشهر يونيو 2024.';

  @override
  String get ownerLast30Days => 'آخر 30 يوم';

  @override
  String get ownerExportPdf => 'تصدير PDF';

  @override
  String get ownerTotalRevenue => 'إجمالي الإيراد';

  @override
  String get ownerRevenueDelta => '+12.5٪ عن الشهر الماضي';

  @override
  String get ownerNetProfit => 'صافي الربح';

  @override
  String get ownerProfitDelta => '+5.2٪ عائد';

  @override
  String get ownerSharedTips => 'البقشيش المشترك';

  @override
  String get ownerTipsStatus => 'بانتظار التوزيع الأسبوعي';

  @override
  String get ownerPendingDeposits => 'العربون المعلق';

  @override
  String get ownerDepositStatus => 'التسوية المتوقعة: 48 ساعة';

  @override
  String get ownerWeeklyRevenueGrowth => 'نمو الإيراد الأسبوعي';

  @override
  String get ownerRevenueLegend => 'الإيراد';

  @override
  String get ownerProjectedLegend => 'المتوقع';

  @override
  String get ownerProfitAllocation => 'توزيع الربح';

  @override
  String get ownerProfitAllocationBody => 'محسوب بناءً على اتفاقية المالك والمشغل 50/50.';

  @override
  String get ownerSplitRatio => 'نسبة التقسيم';

  @override
  String get ownerOperatorShare => 'حصة المشغل';

  @override
  String get ownerExpensesBody => 'إجمالي المصاريف الشهرية بما يشمل تكلفة البضاعة والمرافق والعمالة. تفاصيل الوصفات والتكاليف الداخلية مقيدة للخصوصية.';

  @override
  String get ownerConsolidatedTotal => 'الإجمالي الموحد';

  @override
  String get ownerRequestAudit => 'طلب تدقيق مفصل';

  @override
  String get ownerRecentTransactions => 'المعاملات الكبيرة الأخيرة';

  @override
  String get ownerViewAllActivity => 'عرض كل النشاط';

  @override
  String get ownerMonthlyRent => 'تسوية الإيجار الشهري';

  @override
  String get ownerMonthlyRentMeta => '05 يونيو 2024 • رقم العملية: #TXN-9021';

  @override
  String get ownerCateringEvent => 'فعالية تموين: شركة المنصور';

  @override
  String get ownerCateringEventMeta => '02 يونيو 2024 • رقم العملية: #TXN-8842';

  @override
  String get ownerCompleted => 'مكتمل';

  @override
  String get ownerCleared => 'تمت التسوية';

  @override
  String get ownerFinanceNav => 'المالية';

  @override
  String get ownerMon => 'الإثنين';

  @override
  String get ownerTue => 'الثلاثاء';

  @override
  String get ownerWed => 'الأربعاء';

  @override
  String get ownerThu => 'الخميس';

  @override
  String get ownerFri => 'الجمعة';

  @override
  String get ownerSat => 'السبت';

  @override
  String get ownerSun => 'الأحد';

  @override
  String get ownerPrivacyHeader => 'صلاحيات عرض المالك';

  @override
  String get ownerPrivacyBody => 'اضبط بدقة المعلومات التي يستطيع مالك العقار رؤيتها في لوحة التحكم مع الحفاظ على خصوصية التشغيل والشفافية في مؤشرات الأعمال الأساسية.';

  @override
  String get ownerPrivacyHero => 'ضوابط أمان مؤسسية';

  @override
  String get ownerHideRawCosts => 'إخفاء تكلفة المواد الخام';

  @override
  String get ownerHideRawCostsBody => 'إخفاء تكلفة كل صنف في تقارير المخزون والمشتريات. سيرى المالك الإجماليات المجمعة فقط.';

  @override
  String get ownerHideStaffSalaries => 'إخفاء رواتب الموظفين التفصيلية';

  @override
  String get ownerHideStaffSalariesBody => 'تقييد عرض بيانات الرواتب التفصيلية. سيتم إخفاء تفاصيل راتب كل موظف عن عرض المالك.';

  @override
  String get ownerShowOnlyNetProfit => 'إظهار صافي الربح فقط';

  @override
  String get ownerShowOnlyNetProfitBody => 'عند التفعيل، ستخفي لوحة المالك إجمالي الإيرادات وتفاصيل المصاريف التشغيلية وتعرض صافي الربح النهائي للفترة فقط.';

  @override
  String get ownerLivePreview => 'معاينة مباشرة: منظور المالك';

  @override
  String get ownerGrossRevenue => 'إجمالي الإيراد';

  @override
  String get ownerOperatingCosts => 'تكاليف التشغيل';

  @override
  String get ownerNetProfitLabel => 'صافي الربح';

  @override
  String get ownerPreviewNote => 'تعكس البيانات أعلاه إعدادات الظهور الحالية المطبقة على لوحة المالك.';

  @override
  String get ownerDiscardChanges => 'تجاهل التغييرات';

  @override
  String get ownerSaveConfigurations => 'حفظ الإعدادات';

  @override
  String get ownerAdminMode => 'وضع الإدارة';

  @override
  String get ownerFinancesNav => 'المالية';

  @override
  String get ownerProfileNav => 'الملف';

  @override
  String get paymentCheckoutTitle => 'الدفع';

  @override
  String get paymentCheckoutSubtitle => 'اختر طريقة الدفع المفضلة لإكمال الطلب.';

  @override
  String get paymentTotalAmountDue => 'إجمالي المبلغ المستحق';

  @override
  String get paymentSecureTransaction => 'عملية آمنة ومشفرة';

  @override
  String get paymentOrderReference => 'مرجع الطلب';

  @override
  String get paymentMethodsTitle => 'طرق الدفع';

  @override
  String get paymentWalletBalance => 'رصيد المحفظة';

  @override
  String paymentAvailableAmount(Object amount) {
    return 'المتاح: $amount';
  }

  @override
  String get paymentCardTitle => 'بطاقة ائتمان / خصم';

  @override
  String get paymentCardSubtitle => 'فيزا تنتهي بـ •••• 4242';

  @override
  String get paymentApplePay => 'Apple Pay';

  @override
  String get paymentFastSecure => 'سريع وآمن';

  @override
  String get paymentCashOnDelivery => 'الدفع عند الاستلام';

  @override
  String get paymentPayWhenReceive => 'ادفع عند الاستلام';

  @override
  String get paymentAddNewMethod => 'إضافة طريقة دفع جديدة';

  @override
  String get paymentTotalAmount => 'إجمالي المبلغ';

  @override
  String get paymentPayNow => 'ادفع الآن';

  @override
  String paymentPayNowAmount(Object amount) {
    return 'ادفع الآن | $amount';
  }

  @override
  String get platedHowBadge => 'توصيل بالصواني';

  @override
  String get platedHowTitle => 'ضيافة مستدامة بتجربة أرقى.';

  @override
  String get platedHowSubtitle => 'استمتع بوجباتك المفضلة على أطباق فخارية حقيقية تصل إلى بابك ونجمعها عند الانتهاء.';

  @override
  String get platedHowItWorks => 'كيف تعمل الخدمة';

  @override
  String get platedStepOrderTitle => '١. اختر الصواني';

  @override
  String get platedStepOrderBody => 'اختر خيار الصواني عند الدفع من المطاعم المحلية المشاركة.';

  @override
  String get platedStepEnjoyTitle => '٢. استمتع بوجبتك';

  @override
  String get platedStepEnjoyBody => 'لا علب ورقية رطبة. اختبر طعم وجبتك الحقيقي على فخار عالي الجودة.';

  @override
  String get platedStepPickupTitle => '٣. نعود للاستلام';

  @override
  String get platedStepPickupBody => 'اترك الصينية عند بابك. سنجمعها ونعقمها باحتراف ونعيد استخدامها.';

  @override
  String get platedBondTitle => 'العربون المستدام';

  @override
  String get platedBondBody => 'للحفاظ على مكتبة الصواني الفخارية عالية الجودة، يطلب عربون مسترد لكل طلب صواني ليبقى النظام مغلقاً ومستداماً.';

  @override
  String get platedDepositAmount => '٥ د.أ';

  @override
  String get platedFullyRefundable => 'مسترد بالكامل';

  @override
  String get platedWhyChoose => 'لماذا تختار الاستدامة؟';

  @override
  String get platedWay => 'طريقة الصواني';

  @override
  String get platedTraditionalDelivery => 'التوصيل التقليدي';

  @override
  String get platedZeroWaste => 'بدون نفايات استخدام واحد';

  @override
  String get platedPlasticWaste => 'نفايات بلاستيك وكرتون';

  @override
  String get platedRetainsHeat => 'يحافظ على الحرارة أفضل';

  @override
  String get platedLosesHeat => 'يفقد الحرارة سريعاً';

  @override
  String get platedElevatedExperience => 'تجربة أرقى';

  @override
  String get platedEatingBox => 'الأكل من علبة';

  @override
  String get platedReadyPrompt => 'جاهز للانضمام للحركة؟';

  @override
  String get platedChooseSustainable => 'اختر الاستدامة';

  @override
  String get platedLearnSanitation => 'اعرف المزيد عن معايير التعقيم';

  @override
  String get platedPickupsTitle => 'عمليات جمع مجدولة';

  @override
  String get platedPickupsSubtitle => '٤ مهام متبقية للوجستيات الصواني';

  @override
  String get platedPickupOverdue => 'متأخر ١٥د';

  @override
  String get platedPickupIn20 => 'بعد ٢٠د';

  @override
  String get platedPickupScheduled => 'مجدول: 14:30';

  @override
  String get platedReturnItems => 'عناصر الإرجاع';

  @override
  String get platedReturnItemsLarge => 'صينية كبيرة ١، أطباق ٤';

  @override
  String get platedReturnItemsMedium => 'علب متوسطة ٢، أطقم أدوات ٨';

  @override
  String get platedReturnItemsTrays => 'صواني كبيرة ٤';

  @override
  String get platedOpenMaps => 'فتح الخرائط';

  @override
  String get platedConfirmCollection => 'تأكيد الجمع';

  @override
  String get platedSustainableReturns => 'إرجاع مستدام';

  @override
  String get platedWasteReduced => 'عملك يقلل النفايات بمقدار ٤.٢ كغم لكل جولة جمع اليوم.';

  @override
  String get platedCustomerEleanor => 'إليانور شيلستروب';

  @override
  String get platedAddressEleanor => '742 إيفرغرين تيراس، سبرينغفيلد';

  @override
  String get platedCustomerTahani => 'تهاني الجميل';

  @override
  String get platedAddressTahani => '1200 لاكشري لين، بيل إير';

  @override
  String get platedCustomerChidi => 'شيدي أناغوني';

  @override
  String get platedAddressChidi => 'قسم الفلسفة، يونيفرستي رو';

  @override
  String get platesSearchHint => 'ابحث في الكتالوج...';

  @override
  String get platesTotalInventoryValue => 'إجمالي قيمة المخزون';

  @override
  String get platesValueDelta => '+2.4٪';

  @override
  String get platesBreakageComparison => 'مقارنة بكسر الشهر الماضي';

  @override
  String get platesTotalCirculation => 'الإجمالي قيد التداول';

  @override
  String get platesUnits => 'وحدة';

  @override
  String get platesReplacementsPending => 'البدائل المعلقة';

  @override
  String get platesItems => 'عنصر';

  @override
  String get platesOrderRestock => 'طلب إعادة توريد';

  @override
  String get platesCatalogTitle => 'كتالوج الصواني الفخارية';

  @override
  String get platesCatalogSubtitle => 'إدارة مستويات المخزون والتداول وتكاليف الكسر.';

  @override
  String get platesNewComponent => 'مكون جديد';

  @override
  String get platesFilter => 'تصفية';

  @override
  String get platesLargeTray => 'صينية تقديم كبيرة';

  @override
  String get platesLargeTraySku => 'SKU: CRT-102-L';

  @override
  String get platesCeramicBowl => 'وعاء فخاري';

  @override
  String get platesCeramicBowlSku => 'SKU: CRT-205-M';

  @override
  String get platesMezzePlate => 'طبق مزات';

  @override
  String get platesMezzePlateSku => 'SKU: CRT-089-S';

  @override
  String get platesPerUnit => 'لكل وحدة';

  @override
  String get platesInStock => 'في المخزون';

  @override
  String get platesCirculating => 'قيد التداول';

  @override
  String platesReplacementCost(Object amount) {
    return 'تكلفة الاستبدال: $amount';
  }

  @override
  String get platesDetails => 'التفاصيل';

  @override
  String get platesRecentBreakage => 'تقارير الكسر الأخيرة';

  @override
  String get platesBowlBreakage => 'وعاء فخاري - ٤ وحدات مكسورة';

  @override
  String get platesBowlBreakageMeta => 'المحطة: منطقة غسيل الأطباق • أبلغت عنها سارة م.';

  @override
  String get platesMezzeBreakage => 'طبق مزات - وحدتان مكسورتان';

  @override
  String get platesMezzeBreakageMeta => 'المحطة: صالة الطعام • حادث أرضية';

  @override
  String get platesTodayTime => 'اليوم، 2:45 م';

  @override
  String get platesYesterdayTime => 'أمس، 9:12 م';

  @override
  String get platesViewBreakageLog => 'عرض سجل الكسر الكامل';

  @override
  String get platesRestockAlert => 'تنبيه إعادة التوريد';

  @override
  String get platesRestockBody => 'صواني التقديم الكبيرة أقل حالياً من حد الأمان (٥٠ وحدة).';

  @override
  String get platesAutoRestockLevel => 'مستوى إعادة التوريد التلقائي';

  @override
  String get platesEnabled => 'مفعل';

  @override
  String platesUnitsProgress(int current, int total) {
    return '$current/$total وحدة';
  }

  @override
  String get platesOrderNow => 'اطلب الآن';

  @override
  String get productMansafTitle => 'منسف لحم تقليدي';

  @override
  String get productMansafDescription => 'الطبق الوطني في الأردن. قطع لحم بلدي طرية مطهية بصلصة جميد غنية وحامضة، تقدم فوق أرز كركمي عطري وخبز شراك رقيق. تزين بالمكسرات المقلية والبقدونس الطازج لقوام ونكهة متوازنين.';

  @override
  String get productRating => '٤.٩ (١٢٠+ تقييم)';

  @override
  String get productPrepTime => 'وقت التحضير: ٤٥-٦٠ دقيقة';

  @override
  String get productInclVat => 'شامل الضريبة';

  @override
  String get productBestSeller => 'الأكثر مبيعاً';

  @override
  String get productSizePortion => 'حجم الحصة';

  @override
  String get productRequired => 'مطلوب';

  @override
  String get productSinglePlatter => 'طبق فردي';

  @override
  String get productFamilySize => 'حجم عائلي (٤-٥ أشخاص)';

  @override
  String get productAddonsPreferences => 'الإضافات والتفضيلات';

  @override
  String get productExtraJameed => 'صلصة جميد إضافية';

  @override
  String get productExtraAlmonds => 'لوز محمص إضافي';

  @override
  String get productNoPineNuts => 'بدون صنوبر (حساسية)';

  @override
  String get productFree => 'مجاني';

  @override
  String get productSpecialInstructions => 'تعليمات خاصة';

  @override
  String get productInstructionsHint => 'مثلاً: يرجى تقديم الجميد ساخناً.';

  @override
  String productAddToCartAmount(Object amount) {
    return 'إضافة للسلة | $amount';
  }

  @override
  String get previewProductTitle => 'طبق الحرفيين التنفيذي';

  @override
  String get previewPrice => '12.50 د.أ';

  @override
  String get previewTaxIncluded => 'شامل الضريبة';

  @override
  String get previewProductBody => 'تشكيلة منتقاة من مكونات طازجة تشمل بيضاً عضوياً مسلوقاً وخبز ساوردو محضراً يدوياً وأفوكادو وخس جرجير بري. مثالي لطاقة تشغيلية عالية التركيز.';

  @override
  String get previewPreferredBase => 'القاعدة المفضلة';

  @override
  String get previewToastedSourdough => 'ساوردو محمص';

  @override
  String get previewMultigrainToast => 'توست متعدد الحبوب';

  @override
  String get previewAddOns => 'الإضافات';

  @override
  String get previewExtraSmokedSalmon => 'سلمون مدخن إضافي';

  @override
  String get previewDoubleAvocado => 'حصة أفوكادو مزدوجة';

  @override
  String get previewSalmonPrice => '+3.50 د.أ';

  @override
  String get previewAvocadoPrice => '+1.20 د.أ';

  @override
  String get previewDietaryNotes => 'ملاحظات غذائية';

  @override
  String get previewDietaryMessage => 'يرجى تسجيل الدخول لتحديد الحساسية أو طلبات التحضير الخاصة.';

  @override
  String get previewLoginAddCart => 'تسجيل الدخول للإضافة للسلة';

  @override
  String get previewNewToApp => 'جديد في عيلتنا؟';

  @override
  String get previewCreateAccount => 'إنشاء حساب';

  @override
  String get registerJoinTitle => 'انضم إلى عيلتنا';

  @override
  String get registerJoinSubtitle => 'أنشئ حسابك وابدأ بإدارة تجربتك مع عيلتنا.';

  @override
  String get registerFullName => 'الاسم الكامل';

  @override
  String get registerNameHint => 'محمد أحمد';

  @override
  String get registerPhoneNumber => 'رقم الهاتف';

  @override
  String get registerPhoneHint => '+962 7 0000 0000';

  @override
  String get registerEmailAddress => 'البريد الإلكتروني';

  @override
  String get registerEmailHint => 'john@example.com';

  @override
  String get registerConfirmPassword => 'تأكيد كلمة المرور';

  @override
  String get registerAgreePrefix => 'أوافق على';

  @override
  String get registerTermsService => 'شروط الخدمة';

  @override
  String get registerPrivacyPolicy => 'سياسة الخصوصية';

  @override
  String get registerAnd => 'و';

  @override
  String get registerOr => 'أو';

  @override
  String get registerAlreadyAccount => 'لديك حساب بالفعل؟';

  @override
  String get registerLogin => 'تسجيل الدخول';

  @override
  String get registerStepTwoTitle => 'الخطوة ٢ من ٣';

  @override
  String get registerVerifyNumberTitle => 'تحقق من رقمك';

  @override
  String registerSixDigitSent(String phone) {
    return 'أرسلنا رمزاً من ٦ أرقام إلى $phone';
  }

  @override
  String get registerMaskedPhone => '+962 7•• ••89';

  @override
  String get registerDidntReceive => 'لم يصلك الرمز؟';

  @override
  String get registerResendCountdown => 'إعادة الإرسال خلال 00:57';

  @override
  String get registerVerifyContinue => 'تحقق وتابع';

  @override
  String get registerStepTwoLabel => 'الخطوة ٢: التحقق من الهاتف';

  @override
  String get registerStepThreeTitle => 'الخطوة ٣ من ٣';

  @override
  String get registerPreferencesTitle => 'تفضيلاتك الغذائية';

  @override
  String get registerPreferencesSubtitle => 'أخبرنا بما تحبه حتى تقترح عيلتنا وجبات تشبه ذوقك.';

  @override
  String get registerPrimaryRole => 'تجربتك في عيلتنا';

  @override
  String get registerRoleCustomer => 'عميل';

  @override
  String get registerRoleCustomerBody => 'اطلب وجبات شهية، وتابع التوصيل، وأدر مفضلاتك.';

  @override
  String get registerRoleStaff => 'فريق المطعم';

  @override
  String get registerRoleStaffBody => 'ادخل إلى شاشة المطبخ، وأدر المخزون، وعالج الطلبات النشطة.';

  @override
  String get registerRoleAdminOwner => 'مدير / مالك';

  @override
  String get registerRoleAdminOwnerBody => 'اطلع على تحليلات عميقة، وأدر الموظفين، وحسن استدامة المتجر.';

  @override
  String get registerDietaryPreferences => 'التفضيلات الغذائية';

  @override
  String get registerDietVegetarian => 'نباتي';

  @override
  String get registerDietHalal => 'حلال';

  @override
  String get registerDietGlutenFree => 'خالٍ من الغلوتين';

  @override
  String get registerCompleteProfile => 'إكمال الملف';

  @override
  String get registerSetupProgress => 'تقدم الإعداد';

  @override
  String get registerSetupPercent => '100%';

  @override
  String get reportsBreadcrumb => 'لوحة التحكم / مركز التقارير';

  @override
  String get reportsCenterTitle => 'التقارير والتحليلات';

  @override
  String get reportsCenterSubtitle => 'راجع أداءك اليومي ونزّل الوثائق التفصيلية.';

  @override
  String get reportsDaily => 'يومي';

  @override
  String get reportsWeekly => 'أسبوعي';

  @override
  String get reportsMonthly => 'شهري';

  @override
  String get reportsDailySales => 'مبيعات اليوم';

  @override
  String get reportsDailySalesAmount => '4,280.50 د.أ';

  @override
  String get reportsSalesDelta => '+12.4% مقارنة بالأمس';

  @override
  String get reportsTipTotals => 'إجمالي البقشيش';

  @override
  String get reportsTipTotalAmount => '312.00 د.أ';

  @override
  String get reportsTipDistributed => 'تم توزيعه على 14 موظفاً';

  @override
  String get reportsBreakageCosts => 'تكاليف الكسر';

  @override
  String get reportsBreakageAmount => '45.25 د.أ';

  @override
  String get reportsBreakageItems => 'تم تسجيل 3 أصناف اليوم';

  @override
  String get reportsDetailedReports => 'تقارير تفصيلية';

  @override
  String get reportsSalesRevenue => 'المبيعات والإيرادات';

  @override
  String get reportsSalesRevenueBody => 'تفصيل كامل للمعاملات والضريبة وأنواع الدفع.';

  @override
  String get reportsStaffTips => 'ساعات الموظفين والبقشيش';

  @override
  String get reportsStaffTipsBody => 'سجلات الدوام، تنبيهات الإضافي، وتوزيع البقشيش.';

  @override
  String get reportsInventoryWastage => 'المخزون والهدر';

  @override
  String get reportsInventoryWastageBody => 'مستويات المخزون، تقارير النقص، وتحليل هدر الطعام.';

  @override
  String get reportsSustainability => 'الاستدامة (إرجاع الصواني)';

  @override
  String get reportsSustainabilityBody => 'معدلات إرجاع الصواني، تتبع الأدوات القابلة لإعادة الاستخدام، والمبادرات الخضراء.';

  @override
  String get reportsDownloadPdf => 'تنزيل PDF';

  @override
  String get reportsExportCsv => 'تصدير CSV';

  @override
  String get reportsRevenueTrend => 'اتجاه الإيرادات';

  @override
  String get reportsLast24Hours => 'آخر 24 ساعة';

  @override
  String get reportsNavHome => 'الرئيسية';

  @override
  String get reportsNavReports => 'التقارير';

  @override
  String get reportsNavStock => 'المخزون';

  @override
  String get reportsNavProfile => 'الملف';

  @override
  String get rewardsCatalogTitle => 'كتالوج المكافآت';

  @override
  String get rewardsYourBalance => 'رصيدك';

  @override
  String get rewardsPointsValue => '4,850';

  @override
  String get rewardsSavorPoints => 'نقاط عيلتنا';

  @override
  String get rewardsMemberSince => 'عضو منذ 2023';

  @override
  String get guestRewardsPreviewBody => 'تصفّح المكافآت الآن. أنشئ حساباً قبل الدفع حتى تحفظ كل نقطة تكسبها.';

  @override
  String get guestRewardsPreviewAction => 'أنشئ حساباً لكسب النقاط';

  @override
  String get rewardsSearchHint => 'ابحث في المكافآت...';

  @override
  String get rewardsAllItems => 'كل الأصناف';

  @override
  String get rewardsDrinks => 'مشروبات';

  @override
  String get rewardsSides => 'جانبية';

  @override
  String get rewardsMainCourse => 'أطباق رئيسية';

  @override
  String get rewardsFeaturedReward => 'مكافأة مميزة';

  @override
  String get rewardsSignatureBurger => 'برغر واجيو مميز';

  @override
  String get rewardsSignatureBurgerBody => 'استبدله بتجربة طعام كاملة';

  @override
  String get rewardsPointsShort => 'نقطة';

  @override
  String get rewardsNitroColdBrew => 'مشروب نيترو بارد';

  @override
  String get rewardsTruffleParmFries => 'بطاطا ترافل وبارميزان';

  @override
  String get rewardsBerryPowerBowl => 'بول التوت الصحي';

  @override
  String get rewardsDonutSelection => 'تشكيلة دونات';

  @override
  String get rewardsSoldOut => 'نفد';

  @override
  String get rewardsSideBadge => 'جانبي';

  @override
  String get rewardsMainBadge => 'رئيسي';

  @override
  String get rewardsOrdersNav => 'الطلبات';

  @override
  String get rewardsPosNav => 'نقاط البيع';

  @override
  String get rewardsRewardsNav => 'المكافآت';

  @override
  String get rewardsDeliveryNav => 'التوصيل';

  @override
  String get rewardsAdminNav => 'الإدارة';

  @override
  String get roleSelectionMockTitle => 'اختيار الدور التجريبي';

  @override
  String get roleSelectionWelcome => 'اختر دوراً لمراجعة التطبيق';

  @override
  String get roleSelectionSubtitle => 'في الإنتاج يتم تعيين الأدوار من لوحة الإدارة. في هذا النموذج اختر أي دور لاختبار الشاشات والتصميم.';

  @override
  String get roleSelectionCustomerTitle => 'العميل';

  @override
  String get roleSelectionCustomerBody => 'تصفح قائمتنا، وقدّم طلبات السفري أو داخل المطعم، وتابع مكافآت الولاء مباشرة.';

  @override
  String get roleSelectionMockCustomerMetric => 'واجهة العميل';

  @override
  String get roleSelectionCustomerChipMenu => 'المنيو';

  @override
  String get roleSelectionCustomerChipReservations => 'الحجوزات';

  @override
  String get roleSelectionOwnerTitle => 'المالك';

  @override
  String get roleSelectionOwnerBody => 'نظرة استراتيجية على الإيرادات، وتحليلات الهدر، ومؤشرات نمو الفروع.';

  @override
  String get roleSelectionOwnerMetric => 'إيراد اليوم: +12%';

  @override
  String get roleSelectionCashierTitle => 'الكاشير';

  @override
  String get roleSelectionCashierBody => 'عمليات الواجهة الأمامية، دفع سريع، وإدارة طاولات الضيوف.';

  @override
  String get roleSelectionOpenRegister => 'فتح الصندوق';

  @override
  String get roleSelectionKitchenTitle => 'فريق المطبخ';

  @override
  String get roleSelectionKitchenBody => 'إدارة شاشة المطبخ، أولوية الطلبات، وتنبيهات مخزون المكونات.';

  @override
  String get roleSelectionKitchenMetric => '12 طلباً نشطاً';

  @override
  String get roleSelectionAdminTitle => 'المدير / المشغل';

  @override
  String get roleSelectionAdminBody => 'إدارة صلاحيات الموظفين، مشتريات المخزون، وإعدادات النظام.';

  @override
  String get roleSelectionSystemOnline => 'حالة النظام: متصل';

  @override
  String get roleSelectionInventoryTitle => 'المخزون';

  @override
  String get roleSelectionInventoryBody => 'راجع مستويات المخزون، سجلات الهدر، تفاصيل المكونات، وشاشات التسوية.';

  @override
  String get roleSelectionOpenInventory => 'فتح المخزون';

  @override
  String get roleSelectionStaffTitle => 'الموظف';

  @override
  String get roleSelectionStaffBody => 'راجع شاشات الحضور، بقشيش اليوم، وسجل بقشيش الموظفين.';

  @override
  String get roleSelectionOpenAttendance => 'فتح الحضور';

  @override
  String get roleSelectionDeliveryTitle => 'مندوب التوصيل';

  @override
  String get roleSelectionDeliveryBody => 'تحسين المسارات، تأكيد استلام الطلبات، وإثبات التسليم الرقمي.';

  @override
  String get roleSelectionStartShift => 'بدء الوردية';

  @override
  String get roleSelectionFooter => 'تبديل الأدوار هنا مخصص للنموذج فقط. لاحقاً ستستبدله صلاحيات يعينها المدير.';

  @override
  String get orderTypeTitle => 'كيف ترغب بتجربتك؟';

  @override
  String get orderTypeSubtitle => 'اختر تجربة الطعام المناسبة لعرض القائمة المناسبة.';

  @override
  String get orderTypeDineInBody => 'احجز مكانك واستمتع بأجواء المطعم الكاملة مع خدمة الطاولة.';

  @override
  String get orderTypeDineInAction => 'اختيار الطاولة';

  @override
  String get orderTypeTakeawayBody => 'اطلب مسبقاً واستلم وجبتك من الكاونتر المخصص بسرعة وسهولة.';

  @override
  String get orderTypeTakeawayAction => 'اختيار الاستلام';

  @override
  String get orderTypeDeliveryTitle => 'توصيل عادي';

  @override
  String get orderTypeDeliveryBody => 'توصيل موثوق إلى بابك. وجبات ساخنة وطازجة خلال 30-45 دقيقة.';

  @override
  String get orderTypeDeliveryAction => 'تحديد العنوان';

  @override
  String get orderTypePlatedTitle => 'توصيل بالصواني';

  @override
  String get orderTypePlatedBadge => 'استدامة';

  @override
  String get orderTypePlatedBody => 'تجربة فاخرة باستخدام صواني فخارية قابلة لإعادة الاستخدام. نجمع الأطباق لاحقاً.';

  @override
  String get orderTypePlatedAction => 'اختيار المميز';

  @override
  String get orderTypeNearbyCount => '15 شخصاً يطلبون حالياً بالقرب منك';

  @override
  String get orderTypeGroupOrder => 'طلب جماعي';

  @override
  String get orderTypeTerms => 'شروط الخدمة';

  @override
  String get termsHeroTitle => 'شروط وأحكام الطلب';

  @override
  String get termsHeroSubtitle => 'هذه نسخة واجهة تجريبية توضّح القواعد الأساسية قبل إكمال الطلب.';

  @override
  String get termsPaymentTitle => 'الدفع والتأكيد';

  @override
  String get termsPaymentBody => 'سيتم تأكيد الطلب بعد اختيار طريقة الخدمة وإكمال خطوات الدفع. قد تختلف الرسوم حسب نوع الخدمة والعنوان.';

  @override
  String get termsGroupDeliveryTitle => 'التوصيل الجماعي';

  @override
  String get termsGroupDeliveryBody => 'عند اختيار التوصيل الجماعي، يمكن انتظار طلب آخر قريب من نفس المنطقة لتقليل تكلفة التوصيل ورفع كفاءة الرحلة.';

  @override
  String get termsChangesTitle => 'التعديلات والإلغاء';

  @override
  String get termsChangesBody => 'يمكن تعديل الطلب قبل بدء التحضير. بعد بدء التحضير، قد لا تكون بعض التغييرات أو الإلغاء متاحة.';

  @override
  String get orderTypeNavHome => 'الرئيسية';

  @override
  String get orderTypeNavOrders => 'الطلبات';

  @override
  String get orderTypeNavKitchen => 'المطبخ';

  @override
  String get orderTypeNavFinance => 'المالية';

  @override
  String get orderTypeNavMenu => 'القائمة';

  @override
  String get returnFindOrder => 'البحث عن طلب إرجاع';

  @override
  String get returnSearchHint => 'رقم الإيصال أو رقم الهاتف...';

  @override
  String get returnActiveDeposits => 'العربونات النشطة';

  @override
  String get returnPendingCount => '12 بانتظار';

  @override
  String get returnReceipt8821 => '#REC-8821';

  @override
  String get returnReceipt7734 => '#REC-7734';

  @override
  String get returnAlexJohnson => 'أليكس جونستون';

  @override
  String get returnSarahMiller => 'سارة ميلر';

  @override
  String get returnAmount25 => '25.00';

  @override
  String get returnAmount15 => '15.00';

  @override
  String get returnZeroDeduction => '-0.00';

  @override
  String get returnDeposit => 'عربون';

  @override
  String get returnProcessing => 'قيد المعالجة';

  @override
  String get returnCurrentReceipt => '#REC-8821';

  @override
  String get returnOfficialDeposit => 'العربون الرسمي';

  @override
  String get returnCustomerLine => 'العميل: أليكس جونستون • 04/10/2023';

  @override
  String get returnCheckDamage => 'فحص التلف';

  @override
  String get returnMainTray => 'الصينية الرئيسية';

  @override
  String get returnPlates => 'الأطباق (2x)';

  @override
  String get returnCutlerySet => 'طقم أدوات الطعام';

  @override
  String get returnBrokenMissing => 'مكسور / مفقود';

  @override
  String get returnBaseRefund => 'الاسترداد الأساسي';

  @override
  String get returnDamageDeductions => 'خصومات التلف';

  @override
  String get returnTotalRefund => 'إجمالي الاسترداد';

  @override
  String get returnRefundCash => 'استرداد نقدي';

  @override
  String get returnRefundWallet => 'استرداد للمحفظة';

  @override
  String get returnPolicyTip => 'ملاحظة السياسة';

  @override
  String get returnPolicyTipBody => 'البقع على المفارش لا تُحتسب كتلف.';

  @override
  String get returnManagerOverride => 'تجاوز المدير';

  @override
  String get returnManagerOverrideBody => 'امسح الهوية لإلغاء رسوم التلف.';

  @override
  String get returnNavHome => 'الرئيسية';

  @override
  String get returnNavOrders => 'الطلبات';

  @override
  String get returnNavKitchen => 'المطبخ';

  @override
  String get returnNavFinance => 'المالية';

  @override
  String get returnNavMenu => 'القائمة';

  @override
  String get returnIdentifyOrder => 'تحديد الطلب';

  @override
  String get returnScanTrayTag => 'امسح وسم الصينية أو رقم الطلب';

  @override
  String get returnDetailSearchValue => '#LJ-9928-XT';

  @override
  String get returnQrPrompt => 'ضع رمز QR داخل الإطار للمسح التلقائي';

  @override
  String get returnRetrieveOrderData => 'استرجاع بيانات الطلب';

  @override
  String get returnRecentSelfReturns => 'آخر إرجاعات الخدمة الذاتية';

  @override
  String get returnRecentP2812 => 'P2812';

  @override
  String get returnRecentProcessed2m => 'تمت المعالجة قبل دقيقتين';

  @override
  String get returnRecentP9809 => 'P9809';

  @override
  String get returnRecentProcessed5m => 'تمت المعالجة قبل 5 دقائق';

  @override
  String get returnOrder9928 => 'طلب #9928 - جيمس ويلسون';

  @override
  String get returnActiveReturn => 'إرجاع نشط';

  @override
  String get returnOriginalService => 'الخدمة الأصلية';

  @override
  String get returnDineInTable14 => 'داخل الصالة • طاولة 14';

  @override
  String get returnVerifyConditions => 'تحقق من حالة العناصر';

  @override
  String get returnSignatureCeramicPlatter => 'صحن سيراميك مميز';

  @override
  String get returnStandardServiceTray => 'صينية خدمة عادية';

  @override
  String get returnPlatterDeposit => '10.00\$ عربون';

  @override
  String get returnTrayDeposit => '2.00\$ عربون';

  @override
  String get returnReturnedGood => 'أُعيد بحالة جيدة';

  @override
  String get returnDamagedLost => 'تالف/مفقود';

  @override
  String get returnSummaryCeramicPlatter => 'صحن سيراميك (مُعاد)';

  @override
  String get returnSummaryServiceTray => 'صينية خدمة (مُعادة)';

  @override
  String get returnSummarySustainabilityBonus => 'مكافأة الاستدامة';

  @override
  String get returnSummaryInstantRefund => 'إجمالي الاسترداد الفوري';

  @override
  String get returnSummaryDestination => 'الوجهة: محفظة العميل';

  @override
  String get returnProcessClose => 'معالجة الاسترداد والإغلاق';

  @override
  String get returnReportIssue => 'الإبلاغ عن مشكلة';

  @override
  String get returnAmount4_50 => '+\$4.50';

  @override
  String get returnAmount12 => '+\$12.00';

  @override
  String get returnAmount10 => '+\$10.00';

  @override
  String get returnAmount2 => '+\$2.00';

  @override
  String get returnAmount0_50 => '+\$0.50';

  @override
  String get returnAmount12_50 => '\$12.50';

  @override
  String get returnRefundSummary => 'ملخص الاسترداد';

  @override
  String get splashTagline => 'طعم تقليدي، بدون هدر';

  @override
  String get splashInitializing => 'تهيئة منطق عيلتنا';

  @override
  String get staffShiftInProgress => 'الوردية قيد العمل';

  @override
  String get staffActiveNow => 'نشط الآن';

  @override
  String get staffCurrentDuration => 'مدة العمل الحالية';

  @override
  String get staffDurationValue => '04:22:18';

  @override
  String get staffCheckInTime => 'وقت الدخول';

  @override
  String get staffCheckInValue => '08:00 AM';

  @override
  String get staffShiftRole => 'دور الوردية';

  @override
  String get staffFloorLead => 'مشرف الصالة';

  @override
  String get staffCheckOut => 'تسجيل الخروج';

  @override
  String get staffAddShiftNote => 'إضافة ملاحظة للوردية';

  @override
  String get staffLatestOrderActivity => 'آخر نشاط للطلبات';

  @override
  String get staffLatestOrderDetail => 'طاولة 14 - طبق رئيسي بالصواني';

  @override
  String get staffNavHome => 'الرئيسية';

  @override
  String get staffNavOrders => 'الطلبات';

  @override
  String get staffNavKitchen => 'المطبخ';

  @override
  String get staffNavMenu => 'القائمة';

  @override
  String get staffPortalTitle => 'منطق عيلتنا';

  @override
  String get staffCurrentShiftDuration => 'مدة الوردية الحالية';

  @override
  String get staffStartedAt => 'بدأت الوردية عند 08:00 AM';

  @override
  String get staffCheckOutShift => 'إنهاء الوردية';

  @override
  String get staffBreakTime => 'وقت الاستراحة';

  @override
  String get staffSwapTask => 'تبديل المهمة';

  @override
  String get staffCurrentFocus => 'التركيز الحالي';

  @override
  String get staffTableService => 'خدمة طاولة 12';

  @override
  String get staffKitchenCoordination => 'تنسيق المطبخ';

  @override
  String get staffSectionZone => 'القسم: المنطقة A';

  @override
  String get staffTotalOrdersManaged => 'إجمالي الطلبات المُدارة: 18';

  @override
  String get staffCapacity => '75% من السعة';

  @override
  String get staffShiftPerformance => 'أداء الوردية';

  @override
  String get staffTipsEarnedToday => 'البقشيش المكتسب اليوم';

  @override
  String get staffTipsAmount => '42.50 د.أ';

  @override
  String get staffAvgServiceTime => 'متوسط وقت الخدمة';

  @override
  String get staffAvgServiceValue => '12:04';

  @override
  String get staffCustomerRating => 'تقييم العملاء';

  @override
  String get staffRatingValue => '4.9';

  @override
  String get staffManagerNotes => 'ملاحظات المدير';

  @override
  String get staffChefSpecialNote => 'طبق الشيف: سي باس مشوي\nاقترحه كأولوية عالية للعشاء.';

  @override
  String get staffVipReservationNote => 'حجز VIP الساعة 07:30 مساءً\nالطاولة 4 جاهزة للسيد السيد.';

  @override
  String get staffAttendanceTitle => 'الحضور';

  @override
  String get staffCheckInDate => 'الجمعة، 29 مايو';

  @override
  String get staffCheckInClock => '10:56:38';

  @override
  String get staffCheckInAction => 'تسجيل الدخول';

  @override
  String get staffShiftStart => 'بداية الوردية';

  @override
  String get staffShiftStartValue => '08:00 AM';

  @override
  String get staffStatus => 'الحالة';

  @override
  String get staffLate => 'متأخر';

  @override
  String get staffTodaySchedule => 'جدول اليوم';

  @override
  String get staffKitchenDept => 'قسم المطبخ';

  @override
  String get staffMorningPrepService => 'تحضير وخدمة الصباح';

  @override
  String get staffMorningShiftTime => '08:00 AM - 04:00 PM (8 ساعات)';

  @override
  String get staffNavAttendance => 'الحضور';

  @override
  String get staffNavProfile => 'الملف';

  @override
  String get staffOffDuty => 'خارج الدوام حالياً';

  @override
  String get staffShiftDetails => 'تفاصيل الوردية';

  @override
  String get staffShiftDetailsBody => 'راجع جلستك المجدولة قبل البدء.';

  @override
  String get staffRole => 'الدور';

  @override
  String get staffLeadChef => 'رئيس الطهاة';

  @override
  String get staffScheduledTime => 'الوقت المجدول';

  @override
  String get staffScheduledTimeValue => '06:00 AM - 02:00 PM';

  @override
  String get staffExpectedEarnings => 'الأرباح المتوقعة';

  @override
  String get staffExpectedEarningsValue => '75.00 د.أ';

  @override
  String get staffLocation => 'الموقع';

  @override
  String get staffMainKitchen => 'المطبخ الرئيسي';

  @override
  String get staffGpsCheckInNote => 'سيتم تسجيل موقع GPS والطابع الزمني عند تسجيل الدخول.';

  @override
  String get staffNavInventory => 'المخزون';

  @override
  String get staffNavFinances => 'المالية';

  @override
  String get staffTipsBrand => 'بقشيش عيلتنا';

  @override
  String get staffTipsReportMeta => 'تقرير شخصي • اليوم، 24 أكتوبر';

  @override
  String get staffDailyTipsSummary => 'ملخص بقشيش اليوم';

  @override
  String get staffVerifiedRevenue => 'إيراد موثق';

  @override
  String get staffTotalTipsEarned => 'إجمالي البقشيش المكتسب (د.أ)';

  @override
  String get staffDailyTipsAmount => '84.50';

  @override
  String get staffJod => 'د.أ';

  @override
  String get staffTipsVsYesterday => '+12% مقارنة بالأمس';

  @override
  String get staffTipsLastEntry => 'آخر إدخال: 14:32';

  @override
  String get staffBreakfastShift => 'وردية الإفطار';

  @override
  String get staffBreakfastTime => '07:00 - 11:30';

  @override
  String get staffBreakfastAmount => '22.00 د.أ';

  @override
  String get staffVerified => 'موثق';

  @override
  String get staffLunchRush => 'ذروة الغداء';

  @override
  String get staffLunchTime => '12:00 - 16:30';

  @override
  String get staffLunchAmount => '62.50 د.أ';

  @override
  String get staffEarningsPolicy => 'سياسة الأرباح';

  @override
  String get staffEarningsPolicyBody => 'يرجى مراجعة إجمالياتك اليومية. عند الإقرار، تؤكد أن البقشيش المسجل يطابق سجلات ورديتك. تتم معالجة الدفعات كل يوم خميس.';

  @override
  String get staffCashTips => 'بقشيش نقدي';

  @override
  String get staffCashTipsAmount => '35.00 د.أ';

  @override
  String get staffDigitalTips => 'بقشيش رقمي';

  @override
  String get staffDigitalTipsAmount => '49.50 د.أ';

  @override
  String get staffFinalTotal => 'الإجمالي النهائي';

  @override
  String get staffFinalTotalAmount => '84.50 د.أ';

  @override
  String get staffAcknowledgeReceipt => 'إقرار الاستلام';

  @override
  String get staffAcknowledgeNote => 'سيتم تسجيل وقت الإقرار لأغراض التدقيق.';

  @override
  String get staffTransactionHistory => 'سجل العمليات';

  @override
  String get staffViewFullLog => 'عرض السجل الكامل';

  @override
  String get staffTxnDelivery => 'توصيل';

  @override
  String get staffTxnDineIn => 'داخل المطعم';

  @override
  String get staffTxnTakeaway => 'استلام';

  @override
  String get staffTxnDeliveryMeta => 'طلب #9822';

  @override
  String get staffTxnDineInMeta => 'طاولة 12 • غداء';

  @override
  String get staffTxnTakeawayMeta => 'طلب التطبيق • استلام';

  @override
  String get staffTxnDeliveryAmount => '4.00 د.أ';

  @override
  String get staffTxnDineInAmount => '12.50 د.أ';

  @override
  String get staffTxnTakeawayAmount => '2.25 د.أ';

  @override
  String get staffTxnDeliveryTime => '14:15';

  @override
  String get staffTxnDineInTime => '13:50';

  @override
  String get staffTxnTakeawayTime => '13:10';

  @override
  String get staffNavTips => 'البقشيش';

  @override
  String get staffPerformanceSummary => 'ملخص الأداء';

  @override
  String get staffTotalHours => 'إجمالي الساعات';

  @override
  String get staffTotalHoursValue => '124.5 ساعة';

  @override
  String get staffHoursDelta => '+4.2% عن الشهر الماضي';

  @override
  String get staffTotalTips => 'إجمالي البقشيش';

  @override
  String get staffTotalTipsValue => '1,432.50 د.أ';

  @override
  String get staffAvgTripRate => 'متوسط 11.50/ساعة للبقشيش';

  @override
  String get staffShiftsCompleted => 'الورديات المكتملة';

  @override
  String get staffShiftsCompletedValue => '22';

  @override
  String get staffNoLatesPeriod => '0 تأخير في هذه الفترة';

  @override
  String get staffThisMonth => 'هذا الشهر';

  @override
  String get staffLastMonth => 'الشهر الماضي';

  @override
  String get staffCustomRange => 'نطاق مخصص';

  @override
  String get staffThisWeek => 'هذا الأسبوع';

  @override
  String get staffLastWeek => 'الأسبوع الماضي';

  @override
  String get staffDinnerService => 'خدمة العشاء';

  @override
  String get staffDinnerDate => 'أكتوبر\n24';

  @override
  String get staffDinnerTime => '16:30 - 23:15';

  @override
  String get staffDinnerHours => '6.75 ساعة';

  @override
  String get staffDinnerTips => '+84.20 بقشيش';

  @override
  String get staffBrunchShift => 'وردية البرنش';

  @override
  String get staffBrunchDate => 'أكتوبر\n22';

  @override
  String get staffBrunchTime => '09:00 - 15:30';

  @override
  String get staffBrunchHours => '6.5 ساعة';

  @override
  String get staffBrunchTips => '+52.00 بقشيش';

  @override
  String get staffClosingShift => 'وردية الإغلاق';

  @override
  String get staffClosingDate => 'أكتوبر\n19';

  @override
  String get staffClosingTime => '17:00 - 01:30';

  @override
  String get staffClosingHours => '8.5 ساعة';

  @override
  String get staffClosingTips => '+112.45 بقشيش';

  @override
  String get staffDoubleShift => 'وردية مزدوجة';

  @override
  String get staffDoubleDate => 'أكتوبر\n18';

  @override
  String get staffDoubleTime => '10:00 - 22:00';

  @override
  String get staffDoubleHours => '12.0 ساعة';

  @override
  String get staffDoubleTips => '+156.10 بقشيش';

  @override
  String get staffOvertime => 'إضافي';

  @override
  String get staffDownloadTaxStatement => 'تنزيل كشف الضريبة';

  @override
  String get staffNavDashboard => 'لوحة التحكم';

  @override
  String get staffNavHistory => 'السجل';

  @override
  String get staffNavSchedule => 'الجدول';

  @override
  String get staffNavPay => 'الدفع';

  @override
  String get staffNavAdmin => 'الإدارة';

  @override
  String get sustainabilityAlertsTitle => 'تنبيهات الاستدامة';

  @override
  String get sustainabilityAlertsSubtitle => 'رؤى تشغيلية ومؤشرات بيئية لمنظومة عيلتنا. راقب دورات الصواني ومؤشرات الاستدامة لحظياً.';

  @override
  String get sustainabilityActiveGoal => 'هدف نشط';

  @override
  String get sustainabilityGoalReached => 'هدف الاستدامة: تحقق 92%';

  @override
  String get sustainabilityGoalBody => 'هدف هذا الأسبوع: إدارة صواني خالية من البلاستيك بنسبة 95%.';

  @override
  String get sustainabilityCurrentProgress => 'التقدم الحالي';

  @override
  String get sustainabilityProgressPercent => '92%';

  @override
  String get sustainabilityUrgentAction => 'إجراء عاجل';

  @override
  String get sustainabilityReminderTitle => 'تذكير:\n4 صواني\nبانتظار\nالجمع';

  @override
  String get sustainabilityStationB => 'تحتاج محطة B إلى تنظيف فوري للحفاظ على تدفق التعقيم.';

  @override
  String get sustainabilityDispatch => 'إرسال';

  @override
  String get sustainabilityPolicyUpdate => 'تحديث جديد لسياسة التعقيم';

  @override
  String get sustainabilityPolicyBody => 'تم تطبيق بروتوكولات محدثة لتعقيم الصواني القابلة للتحلل للربع الثالث.';

  @override
  String get sustainabilityViewDocument => 'عرض المستند';

  @override
  String get sustainabilityCo2Offset => '1.2 طن';

  @override
  String get sustainabilityCo2Subtitle => 'تعويض CO2 منذ بداية العام';

  @override
  String get sustainabilityTrayFeed => 'تغذية الصواني اللحظية';

  @override
  String get sustainabilityInRotation => 'قيد التداول';

  @override
  String get sustainabilityInRotationValue => '142';

  @override
  String get sustainabilityCleaningCycle => 'دورة التنظيف';

  @override
  String get sustainabilityCleaningCycleValue => '28';

  @override
  String get sustainabilityAverageReturn => 'متوسط الإرجاع';

  @override
  String get sustainabilityAverageReturnValue => '14د';

  @override
  String get takeawayBrandTitle => 'نظام عيلتنا';

  @override
  String get takeawayChoosePickupDetails => 'اختر تفاصيل الاستلام';

  @override
  String get takeawayPickupSubtitle => 'اختر وقتاً يناسبك في عمّان، الأردن.';

  @override
  String get takeawayHubName => 'محطة عيلتنا - وسط البلد';

  @override
  String get takeawayHubAddress => 'شارع الملك عبدالله الثاني، عمّان';

  @override
  String get takeawayOpen => 'مفتوح';

  @override
  String get takeawayAsap => 'فوراً';

  @override
  String get takeawayAsapTime => '15 - 20 دقيقة';

  @override
  String get takeawaySchedule => 'جدولة';

  @override
  String get takeawayChooseTime => 'اختر الوقت';

  @override
  String get takeawayAvailableSlots => 'الأوقات المتاحة';

  @override
  String get takeawayCurrency => 'د.أ (الدينار الأردني)';

  @override
  String get takeawayToday => 'اليوم';

  @override
  String get takeawayTomorrow => 'غداً';

  @override
  String get takeawayOct25 => '25 أكتوبر';

  @override
  String get takeawaySlot1230 => '12:30 PM';

  @override
  String get takeawaySlot0100 => '01:00 PM';

  @override
  String get takeawaySlot0130 => '01:30 PM';

  @override
  String get takeawaySlot0200 => '02:00 PM';

  @override
  String get takeawaySlot0230 => '02:30 PM';

  @override
  String get takeawayFull => 'ممتلئ';

  @override
  String get takeawayPickupFee => 'رسوم الاستلام';

  @override
  String get takeawayPickupFeeValue => '0.000 د.أ';

  @override
  String get takeawayConfirmPickupTime => 'تأكيد وقت الاستلام';

  @override
  String get tipBrandTitle => 'نظام عيلتنا';

  @override
  String get tipSupportTeamTitle => 'ادعم فريق الطهي';

  @override
  String get tipAppreciationQuote => '\"تقديرك يصل مباشرة إلى قلب المطبخ. كل بقشيش يدعم شغف فريقنا في ابتكار نكهات لا تُنسى لك.\"';

  @override
  String get tipAddAppreciation => 'إضافة تقدير';

  @override
  String get tipAddAppreciationBody => 'أظهر محبتك للطهاة والموظفين.';

  @override
  String get tipSmallThankYou => 'شكر بسيط';

  @override
  String get tipGenerousTip => 'بقشيش كريم';

  @override
  String get tipCulinaryHero => 'بطل الطهي';

  @override
  String get tipCustomAmountJod => 'مبلغ مخصص (د.أ)';

  @override
  String get tipCustomAmountValue => 'د.أ 0.00';

  @override
  String get tipCustomAmountBody => 'أدخل أي مبلغ ترغب بالمساهمة به للفريق.';

  @override
  String get tipConfirmAppreciation => 'تأكيد التقدير';

  @override
  String get tipSkip => 'تخطي';

  @override
  String get trackingBrandTitle => 'نظام عيلتنا';

  @override
  String get trackingEstimatedArrival => 'الوصول المتوقع';

  @override
  String get trackingArrivalTime => '12:45 PM';

  @override
  String get trackingOnTheWay => 'في الطريق';

  @override
  String get trackingOrderNumber => 'طلب #77429';

  @override
  String get trackingPremium => 'مميز';

  @override
  String get trackingFromRestaurant => 'من: عيلتنا بيسترو';

  @override
  String get trackingOrderReceived => 'تم استلام الطلب';

  @override
  String get trackingOrderReceivedBody => 'تم التأكيد عند 12:15 PM';

  @override
  String get trackingPreparingKitchen => 'قيد التحضير في المطبخ';

  @override
  String get trackingPreparingBody => 'الشيف ينهي وجبتك';

  @override
  String get trackingOnWayTitle => 'في الطريق';

  @override
  String get trackingOnWayBody => 'السائق: ماركوس (يبعد 5 دقائق)';

  @override
  String get trackingCallMarcus => 'اتصل بماركوس';

  @override
  String get trackingDelivered => 'تم التوصيل';

  @override
  String get trackingDeliveredBody => 'متوقع عند 12:45 PM';

  @override
  String get trackingOrderSummary => 'ملخص الطلب';

  @override
  String get trackingTruffleRisotto => '1x ريزوتو ترافل';

  @override
  String get trackingGardenSalad => '1x سلطة الحديقة';

  @override
  String get trackingRisottoPrice => '24.00';

  @override
  String get trackingSaladPrice => '12.00';

  @override
  String get trackingTotal => 'الإجمالي';

  @override
  String get trackingTotalPrice => '36.00';

  @override
  String get trackingNeedHelp => 'تحتاج مساعدة؟';

  @override
  String get trackingHelpBody => 'فريق الدعم متاح 24/7 لأي استفسار عن التوصيل.';

  @override
  String get trackingContactSupport => 'تواصل مع الدعم';

  @override
  String get trackingNoContactDelivery => 'توصيل بدون تلامس';

  @override
  String get trackingNoContactBody => 'بطلب من العميل';

  @override
  String get trackingQualityAssured => 'ضمان الجودة';

  @override
  String get trackingQualityBody => 'تم الفحص ثلاث مرات من المطبخ';

  @override
  String get trackingEcoPackaging => 'تغليف صديق للبيئة';

  @override
  String get trackingEcoBody => 'قابل للتحلل 100%';

  @override
  String get userManagementTitle => 'إدارة الموظفين';

  @override
  String get userManagementSubtitle => 'أشرف على فريق المطبخ والصالة.';

  @override
  String get userAddNewStaff => 'إضافة موظف جديد';

  @override
  String get userActiveStaff => 'الموظفون النشطون';

  @override
  String get userActiveStaffCount => '24';

  @override
  String get userRolesDefined => 'الأدوار المعرفة';

  @override
  String get userRolesDefinedCount => '8';

  @override
  String get userCurrentShift => 'الوردية الحالية';

  @override
  String get userCurrentShiftCount => '12';

  @override
  String get userActive => 'نشط';

  @override
  String get userInactive => 'غير نشط';

  @override
  String get userElenaName => 'إيلينا رودريغيز';

  @override
  String get userElenaRole => 'رئيسة الطهاة';

  @override
  String get userElenaEmail => 'elena.r@culinarylogic.com';

  @override
  String get userElenaShift => 'الوردية: صباحية (6ص - 2م)';

  @override
  String get userMarcusName => 'ماركوس تشين';

  @override
  String get userMarcusRole => 'كاشير';

  @override
  String get userMarcusEmail => 'm.chen@culinarylogic.com';

  @override
  String get userMarcusShift => 'الوردية: بعد الظهر (2م - 10م)';

  @override
  String get userSarahName => 'سارة جينكنز';

  @override
  String get userSarahRole => 'مسؤولة التوصيل';

  @override
  String get userSarahEmail => 's.jenkins@culinarylogic.com';

  @override
  String get userSarahShift => 'الوردية: إجازة';

  @override
  String get userDavidName => 'ديفيد أوكافور';

  @override
  String get userDavidRole => 'مساعد الشيف';

  @override
  String get userDavidEmail => 'd.okafor@culinarylogic.com';

  @override
  String get userDavidShift => 'الوردية: مسائية (4م - 12ص)';

  @override
  String get userLindaName => 'ليندا فاين';

  @override
  String get userLindaRole => 'مضيفة';

  @override
  String get userLindaEmail => 'linda.v@culinarylogic.com';

  @override
  String get userLindaShift => 'الوردية: ضغط العشاء (6م - 11م)';

  @override
  String get userManagePermissions => 'إدارة الصلاحيات';

  @override
  String get userInviteNewTeamMember => 'دعوة عضو جديد للفريق';

  @override
  String get walletBrandTitle => 'نظام عيلتنا';

  @override
  String get walletTotalBalance => 'إجمالي الرصيد';

  @override
  String get walletCurrency => 'د.أ';

  @override
  String get walletBalanceAmount => '142.50';

  @override
  String get walletTopUp => 'شحن الرصيد';

  @override
  String get walletTransfer => 'تحويل';

  @override
  String get walletSavorPoints => 'نقاط عيلتنا';

  @override
  String get walletGoldTier => 'المستوى الذهبي';

  @override
  String get walletPointsAmount => '2,450';

  @override
  String get walletPointsToPlatinum => '550 نقطة للبلاتيني';

  @override
  String get walletAvailableRewards => 'المكافآت المتاحة';

  @override
  String get walletAvailableRewardsCount => '3';

  @override
  String get walletPointsValue => 'قيمة النقاط';

  @override
  String get walletPointsValueAmount => '12.25 د.أ';

  @override
  String get walletViewRewardCatalog => 'عرض كتالوج المكافآت';

  @override
  String get walletRecentTransactions => 'آخر المعاملات';

  @override
  String get walletTheBurgerHub => 'برغر هب';

  @override
  String get walletBurgerMeta => 'اليوم، 2:45 م • داخل المطعم';

  @override
  String get walletBurgerAmount => '- 12.50 د.أ';

  @override
  String get walletBurgerPoints => '+ 25 نقطة';

  @override
  String get walletRefundTitle => 'استرداد: طلب ملغى';

  @override
  String get walletRefundMeta => 'أمس، 9:12 ص • توصيل';

  @override
  String get walletRefundAmount => '+ 8.75 د.أ';

  @override
  String get walletRefundCredit => 'رصيد المحفظة';

  @override
  String get walletTopUpTitle => 'شحن المحفظة';

  @override
  String get walletTopUpMeta => '24 أكتوبر، 6:30 م • فيزا **** 4242';

  @override
  String get walletTopUpAmount => '+ 50.00 د.أ';

  @override
  String get walletTopUpStatus => 'ناجح';

  @override
  String get walletPastaPrime => 'باستا برايم';

  @override
  String get walletPastaMeta => '23 أكتوبر، 1:15 م • استلام';

  @override
  String get walletPastaAmount => '- 14.20 د.أ';

  @override
  String get walletPastaPoints => '+ 28 نقطة';

  @override
  String get walletFreeDrinkReward => 'مكافأة مشروب مجاني';

  @override
  String get walletFreeDrinkMeta => '22 أكتوبر، 11:00 ص • استبدال نقاط';

  @override
  String get walletFreeDrinkAmount => '0.00 د.أ';

  @override
  String get walletFreeDrinkPoints => '- 500 نقطة';

  @override
  String get walletViewAllHistory => 'عرض كل السجل';

  @override
  String get refundStep2Title => 'الخطوة 2 من 3';

  @override
  String get refundStep2Header => 'تقييم التلف';

  @override
  String get refundStep2Body => 'افحص العناصر المرتجعة بحثاً عن أي تلف هيكلي. اختيار «تالف» يتيح إدخال خصم من العربون الأصلي.';

  @override
  String get refundCeramicPlate => 'طبق مزّة خزفي';

  @override
  String get refundCeramicPlateAsset => 'رمز الأصل: SAV-P-442';

  @override
  String get refundWoodenTray => 'صينية تقديم خشبية كبيرة';

  @override
  String get refundWoodenTrayAsset => 'رمز الأصل: SAV-T-012';

  @override
  String get refundCoffeePot => 'إبريق قهوة مميز';

  @override
  String get refundCoffeePotAsset => 'رمز الأصل: SAV-P-118';

  @override
  String get refundReturned => 'مرتجع';

  @override
  String get refundDamaged => 'تالف';

  @override
  String get refundDepositSummary => 'ملخص العربون';

  @override
  String get refundHeldFunds => '(أموال محجوزة)';

  @override
  String get refundDepositAmount => '15.00';

  @override
  String get refundEstimateBody => 'سيتحدث مبلغ الاسترداد تلقائياً بناءً على خصومات التلف المدخلة أعلاه.';

  @override
  String get refundCancelFlow => 'إلغاء العملية';

  @override
  String get refundReviewRefund => 'مراجعة الاسترداد';

  @override
  String get refundStep3Title => 'الخطوة 3 من 3';

  @override
  String get refundReadyForPayout => 'جاهز للصرف';

  @override
  String get refundSettlementSummary => 'ملخص التسوية';

  @override
  String get refundOriginalDeposit => 'العربون الأصلي';

  @override
  String get refundReceivedAtTable => 'مستلم من الطاولة 12';

  @override
  String get refundOriginalDepositAmount => '5.00 د.أ';

  @override
  String get refundBreakageFees => 'رسوم التلف';

  @override
  String get refundBreakageDetails => 'طبق خزفي واحد، كأس واحد';

  @override
  String get refundBreakageAmount => '- 1.50 د.أ';

  @override
  String get refundNetRefund => 'صافي الاسترداد';

  @override
  String get refundCreditingWallet => 'يضاف إلى محفظة العميل';

  @override
  String get refundNetRefundAmount => '3.50 د.أ';

  @override
  String get refundTotalSettlement => 'إجمالي التسوية';

  @override
  String get refundImmediateNotice => 'سيتم تنفيذ الاسترداد فوراً إلى محفظة عيلتنا. سيتم إرسال إيصال رقمي برسالة إلى +962 *** *** 44.';

  @override
  String get refundCustomerInfo => 'معلومات العميل';

  @override
  String get refundCustomerName => 'زيد الفرح';

  @override
  String get refundCustomerTier => 'عضو ذهبي';

  @override
  String get refundCurrentWallet => 'المحفظة الحالية';

  @override
  String get refundPostRefund => 'بعد الاسترداد';

  @override
  String get refundCurrentWalletAmount => '12.45 د.أ';

  @override
  String get refundPostRefundAmount => '15.95 د.أ';

  @override
  String get refundTerminalId => 'رمز الجهاز';

  @override
  String get refundTerminalCode => 'POS-AMM-042';

  @override
  String get refundAuthorizedCashier => 'رمز كاشير مصرح';

  @override
  String get refundVerifiedTransaction => 'معاملة موثقة';

  @override
  String get refundConfirmProcess => 'تأكيد ومعالجة الاسترداد';

  @override
  String get refundModifyAssessment => 'تعديل تقييم التلف';

  @override
  String get refundIdentification => 'التعريف';

  @override
  String get refundAssessment => 'التقييم';

  @override
  String get refundSettlement => 'التسوية';

  @override
  String get returnStep1Title => 'إرجاع العناصر';

  @override
  String get returnStep1Subtitle => 'الخطوة 1 من 2: قائمة التحقق';

  @override
  String get returnOrder8842 => 'طلب #8842';

  @override
  String get returnOrderMeta => 'طاولة 12 • 4 عناصر متوقعة';

  @override
  String get returnExpectedCeramicItems => 'العناصر الخزفية المتوقعة';

  @override
  String get returnDeepBowls => 'وعاءان عميقان';

  @override
  String get returnDeepBowlsMeta => 'سلسلة مميزة • حافة زيتونية';

  @override
  String get returnMainPlates => 'طبقان رئيسيان';

  @override
  String get returnMainPlatesMeta => 'سلسلة مميزة • 12 إنش';

  @override
  String get returnCollected => 'تم الجمع';

  @override
  String get returnMissing => 'مفقود';

  @override
  String get returnMissingWarning => 'سيتم تحويل العناصر المفقودة لمراجعة المدير وقد تفرض رسوم استبدال على العميل.';

  @override
  String get returnContinueStep2 => 'المتابعة إلى الخطوة 2';

  @override
  String get returnStep2Title => 'الخطوة 2 من 2';

  @override
  String get returnConfirmation => 'تأكيد';

  @override
  String get returnVerificationComplete => 'اكتمل التحقق';

  @override
  String get returnVerificationBody => 'سيتم إضافة العربون إلى المحفظة فوراً.';

  @override
  String get returnBreakageFeeAmount => '- 2.500 د.أ';

  @override
  String get returnBreakageFeeBody => 'تم تسجيل تلف وعاءين خزفيين';

  @override
  String get returnNetRefundAmount => '12.500 د.أ';

  @override
  String get returnReadyInstantCredit => 'جاهز للإضافة الفورية';

  @override
  String get returnSummaryDetails => 'تفاصيل الملخص';

  @override
  String get returnOriginalDeposit => 'العربون الأصلي';

  @override
  String get returnOriginalDepositAmount => '15.000 د.أ';

  @override
  String get returnBreakageTwoItems => 'التلف (عنصران)';

  @override
  String get returnProcessingFee => 'رسوم المعالجة';

  @override
  String get returnWaived => 'معفاة';

  @override
  String get returnFinalRefund => 'الاسترداد النهائي';

  @override
  String get returnSignToConfirm => 'التوقيع للتأكيد';

  @override
  String get returnSignatureRequired => 'توقيع العميل مطلوب هنا';

  @override
  String get returnClearSignature => 'مسح التوقيع';

  @override
  String get returnFinalizeReturn => 'إنهاء الإرجاع';

  @override
  String get returnFinalizeDisclaimer => 'بالضغط على إنهاء الإرجاع، تؤكد أن كل العناصر تم فحصها وأن مبلغ الاسترداد صحيح.';

  @override
  String get platedReturnBadge => 'تجربة الأطباق';

  @override
  String get platedReturnReadyTitle => 'جاهز للإرجاع؟';

  @override
  String get platedReturnReadyBody => 'نتمنى أنك استمتعت بوجبتك! أخبرنا كيف تفضل إرجاع مجموعة الأطباق الخزفية.';

  @override
  String get platedReturnDepositTitle => 'عربون قابل للاسترداد';

  @override
  String get platedReturnDepositBody => 'سيتم إرجاع عربونك بقيمة 5 د.أ إلى محفظتك فور استلام العناصر.';

  @override
  String get platedReturnSchedulePickup => 'جدولة الاستلام';

  @override
  String get platedReturnSelfReturn => 'سأعيدها بنفسي';

  @override
  String get screenRatingReview => 'قيّم وجبتك';

  @override
  String get screenRatingReviewDesc => 'شاشة تقييم ومراجعة ما بعد التوصيل.';

  @override
  String get ratingHeroTitle => 'كيف كانت وجبة عيلتنا؟';

  @override
  String get ratingHeroSubtitle => 'ملاحظتك تساعد المطبخ على الحفاظ على كل طبق دافئاً وطازجاً وكريماً.';

  @override
  String get ratingOrderLabel => 'تجربة الطلب';

  @override
  String get ratingKitchenTitle => 'المطبخ والطزاجة';

  @override
  String get ratingDeliveryTitle => 'التوصيل والتسليم';

  @override
  String get ratingPackagingTitle => 'التغليف وإرجاع الأطباق';

  @override
  String get ratingCommentLabel => 'أضف ملاحظة قصيرة';

  @override
  String get ratingCommentHint => 'أخبرنا ما الذي أعجبك أو ما الذي يمكن تحسينه';

  @override
  String get ratingSubmit => 'إرسال التقييم';

  @override
  String get ratingSuccess => 'شكراً لك. تمت إضافة تقييمك إلى ملف المكافآت.';

  @override
  String get ratingRewardLoop => '+50 نقطة تذوق بعد التقييم';

  @override
  String get ratingReviewLater => 'التقييم لاحقاً';

  @override
  String get reportFilterIntro => 'اختر نطاق التحليل قبل مراجعة قرارات المبيعات، المخزون، البقشيش، والصواني.';

  @override
  String get reportFilterPeriod => 'الفترة';

  @override
  String get reportFilterChannel => 'القناة';

  @override
  String get reportFilterModules => 'وحدات التقرير';

  @override
  String get reportFilterSummary => 'ملخص الفلتر';

  @override
  String reportFilterModuleCount(int count) {
    return '$count وحدات';
  }

  @override
  String get reportFilterReset => 'إعادة ضبط';

  @override
  String get reportFilterApply => 'تطبيق الفلتر';

  @override
  String get reportFilterApplied => 'تم تطبيق فلتر التقارير';

  @override
  String get reportFilterShift => 'الوردية';

  @override
  String get reportFilterAllChannels => 'كل القنوات';

  @override
  String get reportFilterDineIn => 'داخل المطعم';

  @override
  String get reportFilterTakeaway => 'استلام';

  @override
  String get reportFilterDelivery => 'توصيل';

  @override
  String get reportFilterPlated => 'صواني';

  @override
  String get reportFilterPlatesDeposits => 'الصواني والعربون';

  @override
  String get cartCustomizationQuantity => 'الكمية';

  @override
  String get adminGrowthHubBadge => 'مركز الإدارة والنمو';

  @override
  String get adminGrowthHubHero => 'مكان واحد لإدارة ساعات الفريق، خصوصية المالك، الولاء، والعروض بدل صفحات منفصلة ضعيفة.';

  @override
  String get adminGrowthHubTodayHours => 'ساعات اليوم';

  @override
  String get adminGrowthHubLoyaltyGuests => 'عملاء الولاء';

  @override
  String get adminGrowthHubActiveOffers => 'عروض نشطة';

  @override
  String get adminGrowthStaffTitle => 'ساعات الفريق والورديات';

  @override
  String get adminGrowthStaffSubtitle => 'تتبع التغطية، الساعات، والبقشيش لكل دور داخل المطعم.';

  @override
  String get adminGrowthKitchen => 'المطبخ';

  @override
  String get adminGrowthKitchenDetail => 'تغطية جيدة، تأخير تذكير واحد';

  @override
  String get adminGrowthCashier => 'الكاشير';

  @override
  String get adminGrowthCashierDetail => 'وردية الإغلاق تحتاج اعتماد';

  @override
  String get adminGrowthDelivery => 'التوصيل';

  @override
  String get adminGrowthDeliveryDetail => 'ذروة المساء تحتاج سائق إضافي';

  @override
  String get adminGrowthTips => 'البقشيش';

  @override
  String get adminGrowthTipsDetail => 'جاهز للتوزيع بعد اعتماد الساعات';

  @override
  String get adminGrowthPrivacySubtitle => 'سياسات عرض المالك والتقارير المالية.';

  @override
  String get adminGrowthLoyaltySubtitle => 'حوّل الولاء إلى زيارات متكررة وطلبات طعام واضحة.';

  @override
  String get adminGrowthPointsRule => 'النقاط';

  @override
  String get adminGrowthEnableLunchMultiplier => 'تفعيل مضاعفة الغداء';

  @override
  String get adminGrowthLunchMultiplierBody => 'من ١٢ إلى ٤ مساءً للأصناف الأعلى مبيعاً.';

  @override
  String get adminGrowthBirthdayDessertBody => 'تظهر في عيد ميلاد العميل فقط.';

  @override
  String get adminGrowthTarget => 'الهدف';

  @override
  String get adminGrowthTargetBody => 'زيارة ثانية خلال ١٤ يوم';

  @override
  String get adminGrowthOffersSubtitle => 'العروض مرتبطة بالمخزون والهوامش، وليست بطاقات تسويق عامة.';

  @override
  String get adminGrowthShawarmaOffer => 'عرض وجبة الشاورما';

  @override
  String get adminGrowthShawarmaOfferBody => 'يرتبط بذروة الغداء والتحضير المسبق.';

  @override
  String get adminGrowthFamilyTrayOffer => 'عرض صواني العائلة';

  @override
  String get adminGrowthFamilyTrayOfferBody => 'يتطلب توفر صواني وعربون واضح.';

  @override
  String get adminGrowthHomeOffers => 'عروض الواجهة';

  @override
  String get adminGrowthHomeOffersBody => 'تظهر في قسم العروض إذا كانت القائمة غير فارغة.';

  @override
  String get adminGrowthCombos => 'الكومبو';

  @override
  String get adminGrowthCombosBody => 'تظهر في قسم الكومبو على الرئيسية والضيف.';

  @override
  String get adminGrowthDiscountedItems => 'أصناف الخصم';

  @override
  String get adminGrowthDiscountedItemsBody => 'تختفي تلقائياً إذا لم توجد أصناف عليها خصم.';

  @override
  String get adminGrowthSubscriptionItems => 'أصناف الاشتراك';

  @override
  String get adminGrowthSubscriptionItemsBody => 'تدعم اشتراكات شهرية أو سنوية في الموك.';

  @override
  String get adminGrowthTargetMargin => 'هامش مستهدف';

  @override
  String get adminGrowthTargetMarginBody => 'لا تنشر العرض إذا انخفض الهامش.';

  @override
  String get adminGrowthDecisionStaff => 'اعتمد ساعات الإغلاق قبل توزيع البقشيش.';

  @override
  String get adminGrowthDecisionPrivacy => 'اعرض صافي الربح للمالك عند مراجعة الأداء.';

  @override
  String get adminGrowthDecisionLoyalty => 'اربط مضاعفة النقاط بأوقات انخفاض الطلب.';

  @override
  String get adminGrowthDecisionOffers => 'اختبر عرض الشاورما قبل نشر عرض الصواني.';

  @override
  String get adminGrowthSuggestedDecision => 'قرار مقترح';

  @override
  String get adminGrowthExpectedImpact => 'تأثير متوقع';

  @override
  String get adminGrowthExpectedImpactValue => '+٨٪ تكرار الطلب';

  @override
  String get adminGrowthActionsTitle => 'إجراءات الإدارة';

  @override
  String get adminGrowthActionsSubtitle => 'كل إجراء واجهة وهمية فقط.';

  @override
  String get adminGrowthSaveSettings => 'حفظ الإعدادات';

  @override
  String get adminGrowthSettingsSaved => 'تم حفظ إعدادات المركز';

  @override
  String get adminGrowthOpenAuditLog => 'فتح سجل التدقيق';
}

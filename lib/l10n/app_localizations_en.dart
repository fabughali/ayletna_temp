// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Ayletna Restaurant';

  @override
  String get brandName => 'Ayletna';

  @override
  String get brandNameAr => 'مطعم عيلتنا';

  @override
  String get comingSoon => 'Soon قريباً';

  @override
  String get loading => 'Loading';

  @override
  String get actionContinue => 'Continue';

  @override
  String get actionCancel => 'Cancel';

  @override
  String get actionSave => 'Save';

  @override
  String get favoritesSaved => 'Saved to favorites';

  @override
  String get favoritesRemoved => 'Removed from favorites';

  @override
  String get favoritesEmptyTitle => 'No favorites yet';

  @override
  String get favoritesEmptySubtitle =>
      'Tap the heart on a dish to save it here for quick reorder.';

  @override
  String get favoritesClearAll => 'Clear all favorites';

  @override
  String get actionAddToCart => 'Add to Cart';

  @override
  String get actionSignIn => 'Sign in';

  @override
  String get actionRegister => 'Register';

  @override
  String get actionForgotPassword => 'Forgot password?';

  @override
  String get actionVerify => 'Verify';

  @override
  String get actionGuestBrowse => 'Browse as guest';

  @override
  String get fieldEmailOrPhone => 'Email or phone';

  @override
  String get fieldPassword => 'Password';

  @override
  String get fieldName => 'Full name';

  @override
  String get languageArabic => 'العربية';

  @override
  String get languageEnglish => 'English';

  @override
  String get selectLanguageTitle => 'Choose your language';

  @override
  String get selectLanguageSubtitle => 'You can change this later in settings';

  @override
  String get guestSignInToOrder => 'Sign in to order';

  @override
  String get termsAccept => 'I accept the terms and privacy policy';

  @override
  String get registerAsCustomer => 'Customer (instant)';

  @override
  String get registerAsStaff => 'Request staff role (pending approval)';

  @override
  String get authLoginRequiredFields =>
      'Enter your phone or email and password.';

  @override
  String get authForgotIdentifierRequired =>
      'Enter your registered phone or email.';

  @override
  String get authOtpInvalid => 'Enter the 6-digit code sent to your phone.';

  @override
  String get authPasswordMismatch => 'Passwords do not match.';

  @override
  String get authRegisterFieldsRequired =>
      'Fill in all required fields and accept the terms.';

  @override
  String get authOtpResent => 'A new verification code was sent.';

  @override
  String get authPasswordResetSuccess => 'Password reset. You can sign in now.';

  @override
  String get roleSelectionNotApproved =>
      'This role is not approved for your account.';

  @override
  String get pendingApprovalNote =>
      'Your account is under review. Our team is verifying your staff credentials to ensure the best service for our guests.';

  @override
  String get pendingApprovalTimelineTitle => 'Approval progress';

  @override
  String get pendingApprovalStepSubmitted => 'Submitted';

  @override
  String get pendingApprovalStepReview => 'Reviewing';

  @override
  String get pendingApprovalStepActivated => 'Activated';

  @override
  String get pendingApprovalContactSupport => 'Contact Support';

  @override
  String get currencyJod => 'JOD';

  @override
  String get orderTypeDineIn => 'Dine-in';

  @override
  String get orderTypeTakeaway => 'Takeaway';

  @override
  String get orderTypeDelivery => 'Delivery';

  @override
  String get orderTypePlated => 'Plated delivery';

  @override
  String get tipPreset1 => '1 JOD';

  @override
  String get tipPreset2 => '2 JOD';

  @override
  String get tipPreset5 => '5 JOD';

  @override
  String get tipCustom => 'Custom';

  @override
  String get checkoutFood => 'Food';

  @override
  String get checkoutTip => 'Tip';

  @override
  String get checkoutDeposit => 'Deposit';

  @override
  String get checkoutPaymentMethod => 'Payment Method';

  @override
  String checkoutWalletBalance(String amount) {
    return 'JOD $amount';
  }

  @override
  String get checkoutCardMasked => '**** 9012';

  @override
  String get checkoutCashArrival => 'Pay on arrival';

  @override
  String get checkoutAppreciationTitle => 'Show your appreciation';

  @override
  String get checkoutAppreciationSubtitle =>
      'Your kindness fuels our culinary team.';

  @override
  String get checkoutFairWageNote =>
      '100% of your tips are shared equally among our kitchen and delivery staff as part of our fair-wage commitment.';

  @override
  String get checkoutOrderSummary => 'Order Summary';

  @override
  String get checkoutFoodSubtotal => 'Food Subtotal';

  @override
  String get checkoutDeliveryFee => 'Delivery Fee';

  @override
  String get checkoutPlatedDeposit => 'Plated Deposit';

  @override
  String get checkoutDepositRefundNote => 'Refundable upon plate collection.';

  @override
  String get checkoutStaffAppreciation => 'Staff Appreciation';

  @override
  String get checkoutTotal => 'Total';

  @override
  String get checkoutTaxInclusive => 'Inclusive of taxes';

  @override
  String get checkoutPlaceOrder => 'Place Order';

  @override
  String checkoutPlaceOrderAmount(String amount) {
    return 'Place Order • $amount';
  }

  @override
  String get roleCustomer => 'Customer';

  @override
  String get roleCashier => 'Cashier';

  @override
  String get roleKitchen => 'Kitchen';

  @override
  String get roleDelivery => 'Delivery';

  @override
  String get roleInventory => 'Inventory';

  @override
  String get roleStaff => 'Staff';

  @override
  String get roleOperator => 'Operator';

  @override
  String get roleOwner => 'Owner';

  @override
  String get roleAdmin => 'App Admin';

  @override
  String get roleSupport => 'Support';

  @override
  String get roleMarketing => 'Marketing';

  @override
  String get hubAppAdmin => 'App Administration';

  @override
  String get hubOperator => 'Restaurant Operations';

  @override
  String get hubOwner => 'Owner Portal';

  @override
  String get hubSupportDesk => 'Support Desk';

  @override
  String get hubMarketing => 'Marketing Hub';

  @override
  String get rolePermissionsTitle => 'Roles & Rules';

  @override
  String get rolePermissionsSubtitle => 'Default permission bundles per role';

  @override
  String get userPermissionsTitle => 'Users & Permissions';

  @override
  String get userPermissionsSubtitle =>
      'Assigned roles, inherited rules, and overrides';

  @override
  String get switchRoleTitle => 'Active Role';

  @override
  String get switchRoleSubtitle =>
      'Only shown when your account has multiple roles';

  @override
  String get settingsDarkMode => 'Dark Mode';

  @override
  String get settingsDarkModeOff => 'Off';

  @override
  String get settingsDarkModeOn => 'On';

  @override
  String get settingsAppearance => 'Appearance';

  @override
  String get settingsAppearanceSubtitle =>
      'Choose light, dark, or match your device.';

  @override
  String get settingsThemeLight => 'Light';

  @override
  String get settingsThemeDark => 'Dark';

  @override
  String get settingsThemeAuto => 'Auto';

  @override
  String get settingsNotificationsSummary => 'Push, Email';

  @override
  String get inheritedRulesTitle => 'Inherited rules';

  @override
  String get userOverridesTitle => 'User overrides';

  @override
  String get effectivePermissionsTitle => 'Effective permissions';

  @override
  String get ownershipPercentageLabel => 'Ownership %';

  @override
  String pendingApprovalRequestedRoles(String roles) {
    return 'Requested access: $roles. An app administrator will review your account.';
  }

  @override
  String get supportChatQueueTitle => 'Live chat queue';

  @override
  String get supportChatQueueSubtitle =>
      'Accept waiting customer conversations.';

  @override
  String get supportOrderLookupTitle => 'Order lookup';

  @override
  String get supportOrderLookupSubtitle =>
      'Search orders by number or customer name for ticket context.';

  @override
  String get supportFaqEditorTitle => 'FAQ editor';

  @override
  String get supportFaqAddTitle => 'Add FAQ entry';

  @override
  String get supportFaqAddAction => 'Add entry';

  @override
  String get supportFaqPublished => 'Published';

  @override
  String get supportFaqDraft => 'Draft';

  @override
  String get supportFaqPublish => 'Publish';

  @override
  String get supportFaqUnpublish => 'Unpublish';

  @override
  String get supportFaqSavedMock => 'FAQ saved';

  @override
  String get supportFaqValidation => 'Enter at least English title and body.';

  @override
  String get supportFaqBodyLabelEn => 'Body (EN)';

  @override
  String get supportFaqBodyLabelAr => 'Body (AR)';

  @override
  String get hubOwnerPerformanceSummary => 'Performance summary';

  @override
  String get hubOwnerShare => 'Owner share';

  @override
  String hubOwnerSharePercent(String percent) {
    return '$percent% stake';
  }

  @override
  String get hubNetRevenue => 'Net revenue';

  @override
  String get hubTodayRevenue => 'Today revenue';

  @override
  String hubTodayOrders(String count) {
    return '$count orders';
  }

  @override
  String get hubSupportSummary => 'Support summary';

  @override
  String get hubOpenTickets => 'Open tickets';

  @override
  String get hubChatQueue => 'Chat queue';

  @override
  String get hubPendingReviews => 'Pending reviews';

  @override
  String get hubAvgWait => 'Avg wait';

  @override
  String hubAvgWaitMinutes(String minutes) {
    return '${minutes}m';
  }

  @override
  String hubAvgWaitMinutesAr(String minutes) {
    return '$minutes د';
  }

  @override
  String get marketingCampaignSummary => 'Campaign summary';

  @override
  String get marketingActiveOffers => 'Active offers';

  @override
  String get marketingCombosPromos => 'Combos / promos';

  @override
  String get marketingLoyaltyMembers => 'Loyalty members';

  @override
  String get marketingRedemptionRate => 'Redemption rate';

  @override
  String get marketingVisualCatalog => 'Visual catalog';

  @override
  String get marketingCampaignCalendar => 'Campaign calendar';

  @override
  String get marketingSocialIntegrations => 'Social integrations';

  @override
  String get marketingBlogTitle => 'Blog & content';

  @override
  String get marketingBlogAddPost => 'New blog post';

  @override
  String get marketingBlogPublished => 'Published';

  @override
  String get marketingBlogDraft => 'Draft';

  @override
  String get marketingBlogDraftAdded => 'Draft added';

  @override
  String get marketingBlogStatusToggled => 'Publication status updated';

  @override
  String get marketingBlogNewDraftAr => 'مسودة جديدة';

  @override
  String get marketingBlogNewDraftEn => 'New draft';

  @override
  String get marketingTabOffers => 'Offers';

  @override
  String get marketingTabCombos => 'Combos';

  @override
  String get marketingTabDiscounts => 'Discounts';

  @override
  String get marketingTabSubscriptions => 'Subscriptions';

  @override
  String get marketingTabCampaign => 'Campaign';

  @override
  String get marketingTabLoyalty => 'Loyalty';

  @override
  String get marketingTabSocial => 'Social';

  @override
  String get marketingTabBlog => 'Blog';

  @override
  String get marketingPushCampaignsTitle => 'Push campaigns';

  @override
  String get marketingPushCampaignsSubtitle =>
      'Draft and schedule customer push notifications.';

  @override
  String get marketingPushAddDraft => 'New push draft';

  @override
  String get marketingPushDraft => 'Draft';

  @override
  String get marketingPushScheduledStatus => 'Scheduled';

  @override
  String get marketingPushSent => 'Sent';

  @override
  String get marketingPushScheduled => 'Scheduled for';

  @override
  String get marketingPushScheduleAction => 'Schedule send';

  @override
  String get marketingPushScheduledMock => 'Campaign scheduled';

  @override
  String get marketingPushDraftAdded => 'Push draft added';

  @override
  String get marketingPushNewDraftAr => 'إشعار جديد';

  @override
  String get marketingPushNewDraftEn => 'New notification';

  @override
  String get marketingPushFieldTitleAr => 'Title (Arabic)';

  @override
  String get marketingPushFieldTitleEn => 'Title (English)';

  @override
  String get marketingPushFieldBodyAr => 'Body (Arabic)';

  @override
  String get marketingPushFieldBodyEn => 'Body (English)';

  @override
  String get marketingPushNoSchedule => 'No schedule yet';

  @override
  String get opsInboxTitle => 'Shift inbox';

  @override
  String get opsInboxSubtitle =>
      'Operational alerts for your role. Customer marketing pushes stay on the customer inbox.';

  @override
  String get opsInboxShiftAlertTitle => 'Shift reminder';

  @override
  String get opsInboxShiftAlertBody =>
      'Confirm attendance and tip status before closing your shift.';

  @override
  String get opsInboxOrderAlertTitle => 'Active orders need attention';

  @override
  String get opsInboxOrderAlertBody =>
      'Open your hub dashboard to review queued work.';

  @override
  String get opsInboxOpenHub => 'Open hub';

  @override
  String get platedReturnPickupScheduled => 'Pickup scheduled';

  @override
  String get platedReturnSelfReturnLogged => 'Self-return logged';

  @override
  String get marketingCalendarNoEvents => 'No campaigns scheduled for this day';

  @override
  String get marketingCalendarScheduleAction => 'Schedule campaign';

  @override
  String get marketingCalendarMockSave => 'Campaign saved';

  @override
  String get marketingCalendarPlanningOnlyNotice =>
      'Internal planning calendar only — slots do not publish offers, blog posts, or customer notifications. Use Offers, Blog, or Push campaigns to go live.';

  @override
  String marketingCalendarCampaignsOn(String date) {
    return 'Campaigns on $date';
  }

  @override
  String get marketingSocialConnectTitle => 'Connect accounts';

  @override
  String get marketingSocialConnectSubtitle =>
      'Connect your social accounts to publish updates.';

  @override
  String get marketingSocialConnected => 'Connected';

  @override
  String get marketingSocialNotConnected => 'Not connected';

  @override
  String get marketingSocialDisconnect => 'Disconnect account';

  @override
  String get marketingSocialConnectOAuth => 'Connect with OAuth';

  @override
  String get marketingSocialConnectedMock => 'Connected';

  @override
  String get marketingSocialDisconnectedMock => 'Account disconnected';

  @override
  String marketingSocialConnectedSince(String date) {
    return 'Connected since $date';
  }

  @override
  String get marketingKindOffer => 'Offer';

  @override
  String get marketingKindPromo => 'Promo';

  @override
  String get marketingKindSocial => 'Social';

  @override
  String get marketingKindLoyalty => 'Loyalty';

  @override
  String get ticketPriorityLow => 'Low';

  @override
  String get ticketPriorityNormal => 'Normal';

  @override
  String get ticketPriorityHigh => 'High';

  @override
  String get ticketSlaOnTrack => 'SLA: On track';

  @override
  String get ticketSlaAtRisk => 'SLA: At risk';

  @override
  String get ticketSlaBreached => 'SLA: Breached';

  @override
  String get ownerViewConfigApplied => 'Owner visibility profile applied';

  @override
  String get filterAll => 'All';

  @override
  String get filterByStatus => 'Filter by status';

  @override
  String get filterByPriority => 'Filter by priority';

  @override
  String get screenCustomizationModal => 'Customize item';

  @override
  String get screenCustomizationModalDesc => 'Choose size and add-ons';

  @override
  String get hubNavigateHint => 'Tap a destination to open the screen';

  @override
  String get screenPendingApproval => 'Pending approval';

  @override
  String get actionSignOut => 'Sign out';

  @override
  String get homeCategoriesTitle => 'Categories';

  @override
  String get categoryEmptyMessage => 'No items in this category yet.';

  @override
  String get homeExploreMenuTitle => 'Explore Menu';

  @override
  String get homeFeaturedTitle => 'Featured Offers';

  @override
  String get homeStatusLabel => 'STATUS';

  @override
  String get homePointsLabel => 'Points';

  @override
  String get homeCategoryAll => 'All';

  @override
  String get homeFeaturedBadge => 'Featured';

  @override
  String get homeAddToOrder => 'Add to Order';

  @override
  String get homeSeeAll => 'See All';

  @override
  String get categoryEyebrow => 'Category';

  @override
  String get categoryMezzeTitle => 'Cold Mezze & Appetizers';

  @override
  String get categoryMezzeDescription =>
      'Discover our selection of traditional Levantine starters, prepared daily with fresh ingredients and authentic Jordanian flavors.';

  @override
  String get categoryShawarmaHeroTitle => 'Legendary Beef Shawarma';

  @override
  String get categoryShawarmaHeroDescription =>
      'Slow-roasted premium beef marinated in traditional spices, served with our signature garlic whip.';

  @override
  String get actionAddToOrder => 'Add to Order';

  @override
  String get exploreMenuCategoriesTitle => 'Menu Categories';

  @override
  String get exploreDailyRevenue => 'Daily Revenue';

  @override
  String get explorePendingOrders => 'Pending Orders';

  @override
  String get exploreActive => 'Active';

  @override
  String get badgePlated => 'Plated';

  @override
  String get badgeDineInOnly => 'Dine-in Only';

  @override
  String get badgeLargeFamily => 'Large Family';

  @override
  String get badgeBestseller => 'Bestseller';

  @override
  String get badgeHighProtein => 'High Protein';

  @override
  String get badgePlateMeal => 'Plate Meal';

  @override
  String get badgeKetoChoice => 'Keto Choice';

  @override
  String get badgeSpicy => 'Spicy';

  @override
  String get badgeSignature => 'Signature';

  @override
  String get badgeVegetarian => 'Vegetarian';

  @override
  String get badgeHealthy => 'Healthy';

  @override
  String get badgeChefFavorite => 'Chef favorite';

  @override
  String get badgeFamily => 'Family';

  @override
  String get cartEmptyMessage => 'Your cart is empty';

  @override
  String get productNotSelected => 'Select a product from the menu';

  @override
  String get orderNumberLabel => 'Order';

  @override
  String get orderStatusPreparing => 'Preparing';

  @override
  String get orderStatusReady => 'Ready';

  @override
  String get orderStatusOnWay => 'On the way';

  @override
  String get orderStatusDelivered => 'Delivered';

  @override
  String get orderStatusPending => 'Pending';

  @override
  String get tableNumberLabel => 'Table number';

  @override
  String get pickupTimeLabel => 'Pickup time';

  @override
  String get addressLabel => 'Delivery address';

  @override
  String get deliveryChooseAddress => 'Choose Delivery Address';

  @override
  String get deliveryVerifiedZone => 'Verified Zone';

  @override
  String get deliveryHome => 'Home';

  @override
  String get deliveryWork => 'Work';

  @override
  String get deliveryHomeAddress =>
      'Villa 42, Al-Reem Street, Sweifieh, Amman, Jordan';

  @override
  String get deliveryWorkAddress =>
      'The Business Park, Building 5, 3rd Floor, King Hussein Business Park, Amman';

  @override
  String get deliveryEdit => 'Edit';

  @override
  String get deliveryRemove => 'Remove';

  @override
  String get deliveryAddNewAddress => 'Add New Delivery Address';

  @override
  String get deliveryMapPreview => 'Area Map Preview';

  @override
  String get deliveryRapidDelivery => 'Rapid Delivery';

  @override
  String get deliveryVerification => 'Delivery Verification';

  @override
  String get deliveryStandardAvailable => 'Standard Delivery Available';

  @override
  String get deliveryExpressZoneNote =>
      'Your current selection is within our 15-minute express zone.';

  @override
  String get deliveryStandardFee => 'Standard Delivery Fee';

  @override
  String get deliveryEstimatedTotal => 'Estimated Total';

  @override
  String get deliveryConfirmCheckout => 'Confirm Address & Checkout';

  @override
  String deliveryOrderTitle(String id) {
    return 'Order #$id';
  }

  @override
  String get deliveryCollectionPoint => 'Collection Point';

  @override
  String get deliveryKitchenStationB => 'Kitchen Station B';

  @override
  String get deliveryReadyForPickup => 'Ready for Pickup';

  @override
  String deliveryPickupCustomer(String name) {
    return 'Customer: $name';
  }

  @override
  String deliveryVerifyAllItems(int count) {
    return 'Verify All Items ($count)';
  }

  @override
  String get deliveryBagCount => 'Bag 1 of 1';

  @override
  String get deliveryOrderTotal => 'Order Total';

  @override
  String get deliveryReusableBagDeposit => 'Reusable Bag Deposit';

  @override
  String get deliveryTotalToCollect => 'Total to Collect';

  @override
  String get deliveryCashOnDelivery => 'Cash on Delivery';

  @override
  String get deliveryReportMissingItem => 'Report Missing Item';

  @override
  String get deliveryConfirmPickup => 'Confirm Pickup';

  @override
  String get deliveryDashboardTitle => 'Delivery Dashboard';

  @override
  String get deliveryShiftSummary => 'Shift Active: 4h 12m • 8 tasks completed';

  @override
  String get deliveryTasks => 'Delivery Tasks';

  @override
  String get deliveryReturnTasks => 'Return Tasks';

  @override
  String get deliveryTaskBadge => 'Delivery';

  @override
  String get deliveryPlatedReturnBadge => 'Plated • Tray Return';

  @override
  String get deliveryReadyToGo => 'Ready to Go';

  @override
  String get deliveryPendingKitchen => 'Pending Kitchen';

  @override
  String get deliveryAddNote => 'Add Note';

  @override
  String get deliveryStartDelivery => 'Start Delivery';

  @override
  String get deliveryMarkCollected => 'Mark Collected';

  @override
  String get deliveryOverdue => '15m Overdue';

  @override
  String get deliveryOrder8842Address => '1282 Park Avenue';

  @override
  String get deliveryOrder8842Note => 'Apt 4B • High-rise Entry Code 4421';

  @override
  String get deliveryTable14Pickup => 'Table #14 Pickup';

  @override
  String get deliverySkyLounge => 'Sky Lounge Terrace';

  @override
  String get deliveryTrayReturnDetails => '2 Ceramic Platters • 4 Wine Glasses';

  @override
  String get deliveryOrder8845Address => '882 Broadway St';

  @override
  String get deliveryOrder8845Note => 'Office Lobby • Leave at Front Desk';

  @override
  String get deliveryNextStop => 'Next Stop';

  @override
  String get deliveryMilesAway => '3.2 miles';

  @override
  String get deliveryCurrentDirection => 'Current Direction';

  @override
  String get deliveryNorthPark => 'North on Park Ave';

  @override
  String get deliveryShiftEarnings => 'Shift Earnings';

  @override
  String deliveryIncludesTips(String amount) {
    return 'Includes $amount Tips';
  }

  @override
  String get deliveryViewHistory => 'View History';

  @override
  String get deliveryHistoryTotalEarnings => 'Total Earnings Today';

  @override
  String get deliveryHistoryEarningsDelta => '+12% from yesterday';

  @override
  String get deliveryHistoryCompleted => 'Deliveries Completed';

  @override
  String get deliveryHistoryAvgTime => 'Avg: 22 mins per delivery';

  @override
  String get deliveryHistoryTipsEarned => 'Total Tips Earned';

  @override
  String get deliveryHistoryGoal => '65% of your goal reached';

  @override
  String get deliveryHistoryTitle => 'Delivery History';

  @override
  String get deliveryHistoryFilter => 'Filter';

  @override
  String get deliveryTipEarned => 'Tip Earned:';

  @override
  String get deliveryViewDetails => 'View Details';

  @override
  String get deliveryLoadPreviousDays => 'Load Previous Days';

  @override
  String get deliveryFinance => 'Finance';

  @override
  String get deliveryReturnsTitle => 'Delivery - Past Returns History';

  @override
  String get deliveryReturnsSubtitle =>
      'Review all completed tray collections and financial settlements.';

  @override
  String get deliveryReturnsContext => 'Logistics / Returns';

  @override
  String get deliveryReturnTasksTitle => 'Return Tasks';

  @override
  String get deliveryActiveCollections => 'Active Collections';

  @override
  String deliveryScheduledCount(int count) {
    return '$count Scheduled';
  }

  @override
  String get deliverySustainabilityGoal => 'Sustainability Goal';

  @override
  String deliveryTrayCount(int count) {
    return '$count Trays';
  }

  @override
  String get deliveryArrived => 'Arrived';

  @override
  String get deliveryRouteOverview => 'Route Overview';

  @override
  String get deliveryMilesRemaining => '4.2 Miles Remaining';

  @override
  String get deliveryTotalTrays => 'Total Trays';

  @override
  String get deliverySuccessfullyReturned => 'Successfully Returned';

  @override
  String get deliveryDepositsRefunded => 'Deposits Refunded';

  @override
  String get deliveryReturnedToCustomers => 'Returned to Customers';

  @override
  String get deliveryBreakageFees => 'Breakage Fees';

  @override
  String get deliveryReportedDamage => 'Reported Damage';

  @override
  String get deliverySuccessRate => 'Success Rate';

  @override
  String get deliveryDayAverage => '32 Day Average';

  @override
  String get deliveryRecentReturns => 'Recent Returns';

  @override
  String get deliveryThisWeek => 'This Week';

  @override
  String get deliveryFilters => 'Filters';

  @override
  String get deliveryExport => 'Export';

  @override
  String get deliveryRefunded => 'Refunded';

  @override
  String get deliveryNetRefund => 'Net Refund';

  @override
  String get deliveryLoadMoreHistory => 'Load More History';

  @override
  String get couponCodeLabel => 'Coupon code';

  @override
  String get walletBalanceLabel => 'Balance';

  @override
  String get loyaltyPointsLabel => 'Points';

  @override
  String get mapSelectHint => 'Tap the map to set the delivery location.';

  @override
  String get actionConfirm => 'Confirm';

  @override
  String get screenNotReady => 'Screen loading…';

  @override
  String get platedReturnReminderBody =>
      'Please prepare the tray for pickup after your meal.';

  @override
  String get redemptionConfirmBody => 'Redeem your points for this reward?';

  @override
  String get reportDateFrom => 'From date';

  @override
  String get reportDateTo => 'To date';

  @override
  String get depositAmountLabel => 'Deposit amount (JOD)';

  @override
  String get depositBreadcrumbSettings => 'Settings';

  @override
  String get depositBreadcrumbLogistics => 'Logistics';

  @override
  String get depositBreadcrumbTrayReturns => 'Tray Deposits & Returns';

  @override
  String get depositTrayConfiguration => 'Tray Configuration';

  @override
  String get depositConfigurationSubtitle =>
      'Manage global deposit rates and automated return policy enforcement.';

  @override
  String get depositGlobalTitle => 'Global Deposit';

  @override
  String get depositGlobalAmountLabel => 'Global Deposit Amount (JOD)';

  @override
  String get depositGlobalHelp =>
      'This amount is automatically added to all takeaway and delivery orders containing trays.';

  @override
  String get depositWarning =>
      'Increasing the deposit amount will update all new orders instantly. Active pending orders will retain their original deposit value.';

  @override
  String get depositReturnWindow => 'Return Window';

  @override
  String get depositMaxReturnWindow => 'Max Return Window';

  @override
  String depositHours(int count) {
    return '$count Hours';
  }

  @override
  String get depositOneHour => '1 Hr';

  @override
  String get depositSevenDays => '7 Days';

  @override
  String get depositAutomatedReminders => 'Automated Reminders';

  @override
  String get depositReminderChannel => 'Notify via SMS/Email';

  @override
  String get depositSave => 'Save';

  @override
  String get settingsNotifications => 'Push notifications';

  @override
  String get settingsOwnerPrivacy => 'Hide tip details from owner';

  @override
  String get screenLanguageSelection => 'Language';

  @override
  String get screenLogin => 'Sign in';

  @override
  String get screenOtpVerification => 'Verification';

  @override
  String get screenRegister => 'Register';

  @override
  String get screenForgotPassword => 'Reset password';

  @override
  String get screenRoleSelection => 'Choose role';

  @override
  String get screenGuestBrowse => 'Menu (guest)';

  @override
  String get screenHome => 'Home';

  @override
  String get screenMenu => 'Menu';

  @override
  String get screenFavorites => 'Favorites';

  @override
  String get screenCategory => 'Category';

  @override
  String get screenProductDetail => 'Product';

  @override
  String get screenCart => 'Cart';

  @override
  String get screenSupport => 'Support';

  @override
  String get screenOrderTypeSelection => 'Order type';

  @override
  String get screenDineInTable => 'Table number';

  @override
  String get screenTakeawayPickup => 'Pickup';

  @override
  String get screenDeliveryAddress => 'Delivery address';

  @override
  String get screenPlatedDeliveryInfo => 'Plated delivery';

  @override
  String get screenCheckout => 'Checkout';

  @override
  String get screenTipSelection => 'Tip';

  @override
  String get screenPayment => 'Payment';

  @override
  String get screenOrderConfirmation => 'Order confirmed';

  @override
  String get screenOrderTracking => 'Track order';

  @override
  String get screenOrderHistory => 'Order history';

  @override
  String get drawerOrders => 'Orders';

  @override
  String get drawerBlog => 'Blog';

  @override
  String get screenWallet => 'Wallet';

  @override
  String get screenLoyalty => 'Loyalty';

  @override
  String get screenRewardsCatalog => 'Rewards';

  @override
  String get screenRewardsHistory => 'Rewards history';

  @override
  String get rewardsHistoryEmpty =>
      'No point activity yet. Order or redeem a reward.';

  @override
  String get screenPaymentHistory => 'Payment history';

  @override
  String get screenRedemptionConfirm => 'Confirm redemption';

  @override
  String get screenProfile => 'Profile';

  @override
  String get screenAccountSettings => 'Account settings';

  @override
  String get drawerSectionMore => 'More';

  @override
  String get demoActionTag => '';

  @override
  String get screenAddresses => 'Addresses';

  @override
  String get screenMapPicker => 'Map';

  @override
  String get screenNotifications => 'Notifications';

  @override
  String get screenPlatedReturnReminder => 'Return tray';

  @override
  String get screenOffers => 'Offers';

  @override
  String get screenCouponApply => 'Coupon';

  @override
  String get screenComboBuilder => 'Combo builder';

  @override
  String get screenKitchenDashboard => 'Kitchen';

  @override
  String get screenOrderPrep => 'Order prep';

  @override
  String get screenInventoryDashboard => 'Inventory';

  @override
  String get screenInventoryItem => 'Item details';

  @override
  String get screenStockAdjustment => 'Stock adjustment';

  @override
  String get screenDeliveryDashboard => 'Delivery';

  @override
  String get screenDeliveryOrder => 'Delivery order';

  @override
  String get screenPlatedReturnTask => 'Return tasks';

  @override
  String get screenPlatedReturnProcess => 'Return process';

  @override
  String get screenCashierOrder => 'Cashier POS';

  @override
  String get screenCashierTipEntry => 'Cash tip';

  @override
  String get screenCashierDepositRefund => 'Deposit refund';

  @override
  String get screenCashierOrderHistory => 'Cashier order history';

  @override
  String get screenStaffAttendance => 'Attendance';

  @override
  String get screenStaffDailyTips => 'Daily tips';

  @override
  String get screenStaffTipHistory => 'Tip history';

  @override
  String get screenAdminDashboard => 'Admin';

  @override
  String get screenOrdersManagement => 'Orders';

  @override
  String get screenOrderDetailAdmin => 'Order detail';

  @override
  String get screenReports => 'Reports';

  @override
  String get screenReportFilter => 'Report filters';

  @override
  String get screenFinancialCalculation => 'Financial calculation';

  @override
  String get screenDailyTipDistribution => 'Tip distribution';

  @override
  String get screenPlatesManagement => 'Plates';

  @override
  String get screenPlateEditor => 'Edit plate';

  @override
  String get screenDepositConfig => 'Deposit config';

  @override
  String get screenUserManagement => 'Users';

  @override
  String get screenMenuManagement => 'Menu';

  @override
  String get screenProductEditor => 'Edit product';

  @override
  String get screenOffersManagement => 'Offers management';

  @override
  String get screenDiscountsManagement => 'Discounts management';

  @override
  String get marketingDiscountLabelAr => 'Label AR';

  @override
  String get marketingDiscountLabelEn => 'Label EN';

  @override
  String get marketingLinkedRewardTitle => 'Linked reward';

  @override
  String get marketingLinkedRewardNone => 'No linked reward';

  @override
  String get marketingCampaignAttachTitle => 'Attach offers & combos';

  @override
  String get marketingCalendarCampaignAuthorityNotice =>
      'Campaigns control customer visibility. Offers, combos, and discounts only appear while their campaign window is live.';

  @override
  String get screenAddonsManagement => 'Add-ons';

  @override
  String get menuCatalogTabProduct => 'Product';

  @override
  String get menuCatalogTabProducts => 'Products';

  @override
  String get menuCatalogTabReward => 'Reward';

  @override
  String get menuCatalogTabRatings => 'Ratings';

  @override
  String get menuCatalogPickProduct => 'Select a product';

  @override
  String get menuCatalogPickProductHint =>
      'Choose a product to manage add-ons or related items.';

  @override
  String get menuCatalogRewardPointsLabel => 'Reward points';

  @override
  String get menuCatalogEditRating => 'Edit rating & remarks';

  @override
  String get menuCatalogRatingSaved => 'Rating updated';

  @override
  String get menuCatalogManageProduct => 'Manage';

  @override
  String get menuCatalogNoProducts => 'No products yet';

  @override
  String get menuCatalogAttachAddonsHint =>
      'Select approved add-ons for this product. Mark free or set a price override.';

  @override
  String get menuCatalogAddonPriceOverride => 'Price override (JOD)';

  @override
  String get menuCatalogRelatedMultiSelectHint =>
      'Select related products from the active menu.';

  @override
  String get catalogCrudAddonKey => 'Key';

  @override
  String get catalogCrudLabelEn => 'Label EN';

  @override
  String get catalogCrudLabelAr => 'Label AR';

  @override
  String get catalogCrudSortOrder => 'Sort order';

  @override
  String get catalogCrudDescriptionEn => 'Description EN';

  @override
  String get catalogCrudDescriptionAr => 'Description AR';

  @override
  String get catalogCrudMealType => 'Meal type';

  @override
  String get catalogCrudMealMain => 'Main';

  @override
  String get catalogCrudMealSide => 'Side';

  @override
  String get catalogCrudMealDrink => 'Drink';

  @override
  String get catalogCrudMealDessert => 'Dessert';

  @override
  String get loyaltyOccasionsTitle => 'Occasion rewards';

  @override
  String get loyaltyOccasionsSubtitle =>
      'Active occasions apply to all customers.';

  @override
  String get loyaltyOccasionAddCustom => 'Add custom occasion';

  @override
  String get loyaltyOccasionRewardEn => 'Reward title EN';

  @override
  String get loyaltyOccasionRewardAr => 'Reward title AR';

  @override
  String get loyaltyOccasionPoints => 'Bonus points';

  @override
  String get rewardsAdminTiersHint =>
      'Earn and redeem rates by points balance band.';

  @override
  String rewardsAdminTierRange(String min, String max) {
    return '$min–$max pts';
  }

  @override
  String rewardsAdminTierRates(String earn, String redeem) {
    return 'Earn $earn/JOD · Redeem ×$redeem';
  }

  @override
  String get rewardsAdminTierMin => 'Min points';

  @override
  String get rewardsAdminTierMax => 'Max points (blank = open)';

  @override
  String get rewardsAdminTierEarn => 'Earn per JOD';

  @override
  String get rewardsAdminTierRedeem => 'Redeem factor';

  @override
  String get marketingCampaignScheduleTitle => 'Campaign schedule';

  @override
  String get marketingCampaignScheduleHint =>
      'Pick or create a campaign window. Activating always requires a fresh schedule.';

  @override
  String get marketingCampaignNew => 'New campaign';

  @override
  String get marketingCampaignNone => 'No campaign';

  @override
  String get marketingCampaignPickExisting => 'Existing campaign';

  @override
  String get marketingCampaignInvalidWindow => 'End must be after start';

  @override
  String marketingScheduleStart(String when) {
    return 'Start: $when';
  }

  @override
  String marketingScheduleEnd(String when) {
    return 'End: $when';
  }

  @override
  String get marketingRewardPointsLabel => 'Reward points';

  @override
  String get marketingVisibilityNeedsSchedule =>
      'Schedule a campaign before showing this item';

  @override
  String get marketingCampaignAdjust => 'Adjust campaign';

  @override
  String get marketingBadgeEn => 'Badge EN';

  @override
  String get marketingBadgeAr => 'Badge AR';

  @override
  String get screenLoyaltyConfig => 'Loyalty config';

  @override
  String get screenOwnerViewConfig => 'Owner privacy';

  @override
  String get screenPreOrder => 'Pre-orders';

  @override
  String get screenSettings => 'Settings';

  @override
  String get screenAppIntegrations => 'App Integrations';

  @override
  String get integrationsSecurityNote =>
      'Fill the credentials your provider gave you. Secrets are stored securely in production (Supabase Vault) — never in app code.';

  @override
  String get integrationsSaveAll => 'Save all integrations';

  @override
  String get integrationsSaveSuccess => 'Integration settings saved.';

  @override
  String get integrationsTestConnection => 'Test connection';

  @override
  String get integrationsTestSuccess => 'Connection test passed';

  @override
  String get integrationsTestIncomplete =>
      'Complete the required fields for this section first.';

  @override
  String get integrationsStatusConfigured => 'Configured';

  @override
  String get integrationsStatusIncomplete => 'Incomplete';

  @override
  String integrationsLastSaved(String date) {
    return 'Last saved: $date';
  }

  @override
  String get integrationsSupabaseTitle => 'Supabase';

  @override
  String get integrationsSupabaseSubtitle =>
      'Database, auth, realtime, and edge functions.';

  @override
  String get integrationsSupabaseUrl => 'Project URL';

  @override
  String get integrationsSupabaseUrlHint => 'https://xxxxx.supabase.co';

  @override
  String get integrationsSupabaseAnonKey => 'Anon (public) key';

  @override
  String get integrationsSupabaseAnonKeyHint =>
      'eyJhbGciOiJIUzI1NiIsInR5cCI6...';

  @override
  String get integrationsSupabaseServiceRoleKey =>
      'Service role key (server only)';

  @override
  String get integrationsSupabaseServiceRoleKeyHint =>
      'For Edge Functions / backend deploy';

  @override
  String get integrationsSupabaseProjectRef => 'Project reference ID';

  @override
  String get integrationsSupabaseProjectRefHint => 'e.g. abcdefghijklmnop';

  @override
  String get integrationsSmsTitle => 'SMS provider';

  @override
  String get integrationsSmsSubtitle =>
      'OTP codes and plate return SMS (Unifonic, Twilio, etc.).';

  @override
  String get integrationsSmsProvider => 'Provider name';

  @override
  String get integrationsSmsProviderHint => 'Unifonic / Twilio / custom';

  @override
  String get integrationsSmsApiKey => 'API key';

  @override
  String get integrationsSmsApiKeyHint => 'Provider API key or token';

  @override
  String get integrationsSmsSenderId => 'Sender ID / from number';

  @override
  String get integrationsSmsSenderIdHint => 'Ayletna or +962...';

  @override
  String get integrationsSmsApiUrl => 'API base URL (optional)';

  @override
  String get integrationsSmsApiUrlHint => 'https://api.unifonic.com/...';

  @override
  String get integrationsWhatsappTitle => 'WhatsApp Business';

  @override
  String get integrationsWhatsappSubtitle =>
      'Friendly return reminders and customer updates.';

  @override
  String get integrationsWhatsappBusinessAccountId => 'Business account ID';

  @override
  String get integrationsWhatsappBusinessAccountIdHint =>
      'Meta Business account ID';

  @override
  String get integrationsWhatsappPhoneNumberId => 'Phone number ID';

  @override
  String get integrationsWhatsappPhoneNumberIdHint =>
      'WhatsApp Cloud API phone number ID';

  @override
  String get integrationsWhatsappAccessToken => 'Permanent access token';

  @override
  String get integrationsWhatsappAccessTokenHint =>
      'System user token from Meta';

  @override
  String get integrationsWhatsappWebhookVerifyToken => 'Webhook verify token';

  @override
  String get integrationsWhatsappWebhookVerifyTokenHint =>
      'Random string for webhook verification';

  @override
  String get integrationsTelephonyTitle => 'Phone & OTP';

  @override
  String get integrationsTelephonySubtitle =>
      'Support line, country code, and OTP sender number.';

  @override
  String get integrationsSupportPhoneNumber => 'Support phone number';

  @override
  String get integrationsSupportPhoneNumberHint => '+962 7 0000 0000';

  @override
  String get integrationsDefaultCountryCode => 'Default country code';

  @override
  String get integrationsDefaultCountryCodeHint => '+962';

  @override
  String get integrationsOtpSenderNumber => 'OTP sender number';

  @override
  String get integrationsOtpSenderNumberHint =>
      'Registered sender for verification SMS';

  @override
  String get integrationsPaymentsTitle => 'Payment gateways';

  @override
  String get integrationsPaymentsSubtitle =>
      'Stripe, Google Pay, Apple Pay, regional gateways, and licensed wallet.';

  @override
  String get integrationsPaymentGatewayProvider => 'Primary gateway';

  @override
  String get integrationsPaymentGatewayProviderHint =>
      'Stripe / MyFatoorah / HyperPay / Checkout.com';

  @override
  String get integrationsStripePublishableKey => 'Stripe publishable key';

  @override
  String get integrationsStripePublishableKeyHint =>
      'pk_live_... or pk_test_...';

  @override
  String get integrationsStripeSecretKey => 'Stripe secret key';

  @override
  String get integrationsStripeSecretKeyHint => 'sk_live_... (server-side)';

  @override
  String get integrationsStripeWebhookSecret => 'Stripe webhook secret';

  @override
  String get integrationsStripeWebhookSecretHint => 'whsec_...';

  @override
  String get integrationsGooglePayMerchantId => 'Google Pay merchant ID';

  @override
  String get integrationsGooglePayMerchantIdHint =>
      'Google Pay merchant identifier';

  @override
  String get integrationsGooglePayMerchantName => 'Google Pay merchant name';

  @override
  String get integrationsGooglePayMerchantNameHint => 'Ayletna Restaurant';

  @override
  String get integrationsApplePayMerchantId => 'Apple Pay merchant ID';

  @override
  String get integrationsApplePayMerchantIdHint =>
      'merchant.com.ayletna.restaurant';

  @override
  String get integrationsPaymentGatewayApiKey => 'Regional gateway API key';

  @override
  String get integrationsPaymentGatewayApiKeyHint =>
      'MyFatoorah / HyperPay API key';

  @override
  String get integrationsPaymentGatewayMerchantId => 'Regional merchant ID';

  @override
  String get integrationsPaymentGatewayMerchantIdHint =>
      'Merchant or terminal ID';

  @override
  String get integrationsPaymentGatewayWebhookUrl => 'Payment webhook URL';

  @override
  String get integrationsPaymentGatewayWebhookUrlHint =>
      'https://your-project.supabase.co/functions/v1/payment-webhook';

  @override
  String get integrationsWalletSectionTitle => 'Licensed wallet (Jordan)';

  @override
  String get integrationsWalletProviderName => 'Wallet provider name';

  @override
  String get integrationsWalletProviderNameHint => 'Licensed wallet partner';

  @override
  String get integrationsWalletAppId => 'Wallet app ID';

  @override
  String get integrationsWalletAppIdHint => 'Merchant / app identifier';

  @override
  String get integrationsWalletDeepLinkScheme => 'Deep link scheme';

  @override
  String get integrationsWalletDeepLinkSchemeHint =>
      'ayletna://payment/callback';

  @override
  String get integrationsWalletWebhookSecret => 'Wallet webhook secret';

  @override
  String get integrationsWalletWebhookSecretHint =>
      'Shared secret for wallet callbacks';

  @override
  String get integrationsAiTitle => 'AI agent';

  @override
  String get integrationsAiSubtitle =>
      'Support chat and operator assistants (ChatGPT, Qwen, etc.).';

  @override
  String get integrationsAiProvider => 'AI provider';

  @override
  String get integrationsAiProviderHint => 'OpenAI / Qwen / Anthropic / custom';

  @override
  String get integrationsAiApiKey => 'API key';

  @override
  String get integrationsAiApiKeyHint => 'Provider API key';

  @override
  String get integrationsAiModelName => 'Model name';

  @override
  String get integrationsAiModelNameHint =>
      'gpt-4o / qwen-max / claude-3-5-sonnet';

  @override
  String get integrationsAiBaseUrl => 'API base URL (optional)';

  @override
  String get integrationsAiBaseUrlHint => 'https://api.openai.com/v1';

  @override
  String get integrationsAiSupportChatEnabled => 'Enable AI support chat';

  @override
  String get integrationsAiSupportChatEnabledHint =>
      'Route customer support chat through the configured agent';

  @override
  String get integrationsOtherTitle => 'Other services';

  @override
  String get integrationsOtherSubtitle =>
      'Maps, push notifications, email, and monitoring.';

  @override
  String get integrationsGoogleMapsApiKey => 'Google Maps API key';

  @override
  String get integrationsGoogleMapsApiKeyHint =>
      'Restricted by bundle / referrer';

  @override
  String get integrationsFcmServerKey => 'FCM server key';

  @override
  String get integrationsFcmServerKeyHint =>
      'Firebase Cloud Messaging server key';

  @override
  String get integrationsEmailProvider => 'Email provider';

  @override
  String get integrationsEmailProviderHint => 'SendGrid / Amazon SES';

  @override
  String get integrationsEmailApiKey => 'Email API key';

  @override
  String get integrationsEmailApiKeyHint => 'SendGrid or SES credentials';

  @override
  String get integrationsEmailFromAddress => 'From email address';

  @override
  String get integrationsEmailFromAddressHint => 'noreply@ayletna.com';

  @override
  String get integrationsSentryDsn => 'Sentry DSN (optional)';

  @override
  String get integrationsSentryDsnHint => 'https://...@sentry.io/...';

  @override
  String get integrationsAttendanceWifiTitle => 'Restaurant WiFi (attendance)';

  @override
  String get integrationsAttendanceWifiSubtitle =>
      'Staff check-in/out only works on this router WiFi — not mobile data or outside networks.';

  @override
  String get integrationsRestaurantWifiSsid => 'WiFi network name (SSID)';

  @override
  String get integrationsRestaurantWifiSsidHint => 'Ayletna-Staff';

  @override
  String get integrationsRestaurantWifiBssid => 'Router BSSID (MAC address)';

  @override
  String get integrationsRestaurantWifiBssidHint => 'aa:bb:cc:dd:ee:ff';

  @override
  String get integrationsRestaurantWifiGatewayIp => 'Gateway IP (optional)';

  @override
  String get integrationsRestaurantWifiGatewayIpHint => '192.168.1.1';

  @override
  String get integrationsRestaurantBranchLabel => 'Branch label';

  @override
  String get integrationsRestaurantBranchLabelHint => 'Main kitchen — Amman';

  @override
  String get attendanceGateTitle => 'Record attendance';

  @override
  String get attendanceModeComing => 'Coming';

  @override
  String get attendanceModeLeaving => 'Leaving';

  @override
  String get attendanceWifiChecking => 'Checking restaurant WiFi…';

  @override
  String get attendanceWifiCheckFailed =>
      'Could not read WiFi status. Try again.';

  @override
  String get attendanceWifiNotConfigured =>
      'Admin has not registered restaurant WiFi yet. Ask the operator to configure it in App Integrations.';

  @override
  String get attendanceWifiRequired =>
      'Connect to the restaurant WiFi to record attendance. Mobile data and outside networks are blocked.';

  @override
  String attendanceWifiConnected(String ssid) {
    return 'Connected to restaurant WiFi: $ssid';
  }

  @override
  String attendanceWifiDemoMatched(String ssid) {
    return 'Connected to restaurant WiFi ($ssid)';
  }

  @override
  String get attendanceWifiWebDemoNote =>
      'Attendance check-in uses the restaurant WiFi network.';

  @override
  String attendanceWifiWrongNetwork(String current, String expected) {
    return 'Wrong network ($current). Required: $expected';
  }

  @override
  String get attendanceWifiUnknown => 'Not on WiFi';

  @override
  String get attendanceWifiRefresh => 'Refresh WiFi check';

  @override
  String attendanceLastRecordedWifi(String ssid) {
    return 'Last recorded on WiFi: $ssid';
  }

  @override
  String get attendanceFingerprintComingHint =>
      'Tap fingerprint to confirm arrival time';

  @override
  String get attendanceFingerprintLeavingHint =>
      'Tap fingerprint to confirm leaving time';

  @override
  String get attendanceBiometricTitle => 'Fingerprint approval';

  @override
  String get attendanceBiometricConfirm => 'Approve with fingerprint';

  @override
  String get attendanceBiometricCheckInReason =>
      'Confirm your arrival at the restaurant';

  @override
  String get attendanceBiometricCheckOutReason =>
      'Confirm you are leaving the restaurant';

  @override
  String get attendanceBiometricUnavailable =>
      'Biometric authentication is not available on this device.';

  @override
  String get attendanceBiometricFailed =>
      'Fingerprint verification failed. Try again.';

  @override
  String get screenAuditLog => 'Audit log';

  @override
  String get screenStaffHoursReport => 'Staff hours';

  @override
  String get screenLanguageSelectionDesc => 'Language screen.';

  @override
  String get screenLoginDesc => 'Sign in screen.';

  @override
  String get screenOtpVerificationDesc => 'Verification screen.';

  @override
  String get screenRegisterDesc => 'Register screen.';

  @override
  String get screenForgotPasswordDesc => 'Reset password screen.';

  @override
  String get screenRoleSelectionDesc => 'Choose role screen.';

  @override
  String get screenGuestBrowseDesc => 'Menu (guest) screen.';

  @override
  String get screenHomeDesc => 'Home screen.';

  @override
  String get screenCategoryDesc => 'Category screen.';

  @override
  String get screenProductDetailDesc => 'Product screen.';

  @override
  String get screenCartDesc => 'Cart screen.';

  @override
  String get screenOrderTypeSelectionDesc => 'Order type screen.';

  @override
  String get screenDineInTableDesc => 'Table number screen.';

  @override
  String get screenTakeawayPickupDesc => 'Pickup screen.';

  @override
  String get screenDeliveryAddressDesc => 'Delivery address screen.';

  @override
  String get screenPlatedDeliveryInfoDesc => 'Plated delivery screen.';

  @override
  String get screenCheckoutDesc => 'Checkout screen.';

  @override
  String get screenTipSelectionDesc => 'Tip screen.';

  @override
  String get screenPaymentDesc => 'Payment screen.';

  @override
  String get screenOrderConfirmationDesc => 'Order confirmed screen.';

  @override
  String get screenOrderTrackingDesc => 'Track order screen.';

  @override
  String get screenOrderHistoryDesc => 'Order history screen.';

  @override
  String get screenWalletDesc => 'Wallet screen.';

  @override
  String get screenLoyaltyDesc => 'Loyalty screen.';

  @override
  String get screenRewardsCatalogDesc => 'Rewards screen.';

  @override
  String get screenRedemptionConfirmDesc => 'Confirm redemption screen.';

  @override
  String get screenProfileDesc => 'Profile screen.';

  @override
  String get screenAddressesDesc => 'Addresses screen.';

  @override
  String get screenMapPickerDesc => 'Map screen.';

  @override
  String get screenNotificationsDesc => 'Notifications screen.';

  @override
  String get screenPlatedReturnReminderDesc => 'Return tray screen.';

  @override
  String get screenOffersDesc => 'Offers screen.';

  @override
  String get screenCouponApplyDesc => 'Coupon screen.';

  @override
  String get screenComboBuilderDesc => 'Combo builder screen.';

  @override
  String get screenKitchenDashboardDesc => 'Kitchen screen.';

  @override
  String get screenOrderPrepDesc => 'Order prep screen.';

  @override
  String get screenInventoryDashboardDesc => 'Inventory screen.';

  @override
  String get screenInventoryItemDesc => 'Item details screen.';

  @override
  String get screenStockAdjustmentDesc => 'Stock adjustment screen.';

  @override
  String get screenDeliveryDashboardDesc => 'Delivery screen.';

  @override
  String get screenDeliveryOrderDesc => 'Delivery order screen.';

  @override
  String get screenPlatedReturnTaskDesc => 'Return tasks screen.';

  @override
  String get screenPlatedReturnProcessDesc => 'Return process screen.';

  @override
  String get screenCashierOrderDesc => 'Cashier POS screen.';

  @override
  String get screenCashierTipEntryDesc => 'Cash tip screen.';

  @override
  String get screenCashierDepositRefundDesc => 'Deposit refund screen.';

  @override
  String get screenStaffAttendanceDesc => 'Attendance screen.';

  @override
  String get screenStaffDailyTipsDesc => 'Daily tips screen.';

  @override
  String get screenStaffTipHistoryDesc => 'Tip history screen.';

  @override
  String get screenAdminDashboardDesc => 'Admin screen.';

  @override
  String get screenOrdersManagementDesc => 'Orders screen.';

  @override
  String get screenOrderDetailAdminDesc => 'Order detail screen.';

  @override
  String get screenReportsDesc => 'Reports screen.';

  @override
  String get screenReportFilterDesc => 'Report filters screen.';

  @override
  String get screenFinancialCalculationDesc => 'Financial calculation screen.';

  @override
  String get screenDailyTipDistributionDesc => 'Tip distribution screen.';

  @override
  String get screenPlatesManagementDesc => 'Plates screen.';

  @override
  String get screenPlateEditorDesc => 'Edit plate screen.';

  @override
  String get screenDepositConfigDesc => 'Deposit config screen.';

  @override
  String get screenUserManagementDesc => 'Users screen.';

  @override
  String get screenMenuManagementDesc => 'Menu screen.';

  @override
  String get screenProductEditorDesc => 'Edit product screen.';

  @override
  String get screenOffersManagementDesc => 'Offers management screen.';

  @override
  String get screenLoyaltyConfigDesc => 'Loyalty config screen.';

  @override
  String get screenOwnerViewConfigDesc => 'Owner privacy screen.';

  @override
  String get screenPreOrderDesc => 'Pre-orders screen.';

  @override
  String get screenSettingsDesc => 'Settings screen.';

  @override
  String get screenAuditLogDesc => 'Audit log screen.';

  @override
  String get screenStaffHoursReportDesc => 'Staff hours screen.';

  @override
  String get otpVerificationSubtitle =>
      'Enter the 6-digit code we sent to your phone.';

  @override
  String get screenPaymentSubtitle =>
      'Choose how you want to pay for this order.';

  @override
  String get paymentMethodCash => 'Cash';

  @override
  String get paymentMethodCard => 'Card / Visa';

  @override
  String get paymentMethodWallet => 'Wallet';

  @override
  String get paymentErrorDemo => 'Payment declined. Please try another method.';

  @override
  String get cashierCurrentOrder => 'Current Order';

  @override
  String get cashierWalkIn => 'Walk-in';

  @override
  String get cashierOrderEmpty => 'Order is empty';

  @override
  String get cashierSubtotal => 'Subtotal';

  @override
  String get cashierTax => 'Tax (16%)';

  @override
  String get cashierTotal => 'Total';

  @override
  String get cashierVoidOrder => 'Void Order';

  @override
  String get cashierSaveDraft => 'Save Draft';

  @override
  String get cashierProcessPayment => 'Process Payment';

  @override
  String get cashierFind => 'Find';

  @override
  String get cashierShiftTotalRevenue => 'Shift total revenue';

  @override
  String get cashierOrdersCount => 'Orders count';

  @override
  String cashierAverageOrder(String amount) {
    return 'Average: $amount JOD/order';
  }

  @override
  String get cashierSearchHint => 'Search order # or amount...';

  @override
  String get cashierAllOrders => 'All Orders';

  @override
  String get cashierRecentTransactions => 'Recent Transactions';

  @override
  String get cashierPaid => 'Paid';

  @override
  String get cashierRefunded => 'Refunded';

  @override
  String get cashierLoadOlder => 'Load Older Transactions';

  @override
  String get cashierShiftDelta => '+12% vs last shift';

  @override
  String get cashierCurrentShiftTips => 'Current Shift Tips';

  @override
  String get cashierEnterAmount => 'Enter Amount';

  @override
  String get cashierAssignTipTo => 'Assign Tip To';

  @override
  String get cashierSharedPool => 'Shared Pool';

  @override
  String get cashierLogTipEntry => 'Log Tip Entry';

  @override
  String get cashierMenuSearchHint =>
      'Search menu item, offer, combo, or description...';

  @override
  String get cashierPromotionsTitle =>
      'Offers, combos, discounts, subscriptions';

  @override
  String get cashierLocationDetails => 'Location details';

  @override
  String get cashierTableNumber => 'Table number';

  @override
  String get cashierNoTableNeeded => 'No table needed';

  @override
  String get cashierAddress => 'Address';

  @override
  String get cashierBuildingNumber => 'Building number';

  @override
  String get cashierFloorNumber => 'Floor number';

  @override
  String get cashierDoorAccessCode => 'Main door access code (if required)';

  @override
  String get cashierContactPerson => 'Contact person';

  @override
  String get cashierDeliveryTimeSchedule => 'Delivery time schedule';

  @override
  String get cashierSplitPayment => 'Split payment';

  @override
  String get cashierSplitTotalMismatch =>
      'Split amounts must equal the amount payable.';

  @override
  String get cashierPaymentDetails => 'Payment details';

  @override
  String get cashierSelectPaymentMethod => 'Select a payment method';

  @override
  String get cashierPriorBalance => 'Previous balance';

  @override
  String get cashierPaymentReceived => 'Payment received';

  @override
  String get cashierPaymentReceivedConfirmed => 'Payment confirmed';

  @override
  String get cashierCashReceived => 'Cash received from client';

  @override
  String get cashierRemainingDue => 'Remaining due';

  @override
  String get cashierCashChange => 'Return to client';

  @override
  String get cashierViewReceipt => 'View receipt';

  @override
  String get cashierPrintRollReceipt => 'Print roll receipt';

  @override
  String get cashierClientInvoice => 'Client invoice';

  @override
  String get cashierInvoicePoints => 'Points earned';

  @override
  String get cashierItemsCount => 'Items';

  @override
  String get cashierPromotionSavings => 'Promotion savings';

  @override
  String get cashierPromotionDiscounts => 'Discounts';

  @override
  String get cashierPromotionSubscriptions => 'Subscriptions';

  @override
  String get cashierTabOrder => 'Ticket';

  @override
  String get cashierTabFulfillment => 'Delivery';

  @override
  String get cashierTabTip => 'Tip';

  @override
  String get cashierTabPayment => 'Payment';

  @override
  String get cashierTabConfirm => 'Confirm';

  @override
  String get cashierBackTab => 'Back';

  @override
  String get cashierSendElectronicTicket => 'Send QR / e-ticket';

  @override
  String get cashierElectronicTicketSent =>
      'Electronic ticket sent to client phone via WhatsApp';

  @override
  String get cashierSendOrderPreparation => 'Send order for preparation';

  @override
  String get cashierKeypadReset => 'Reset';

  @override
  String get cashierKeypadDelete => 'Delete';

  @override
  String get cashierKeypadDone => 'Done';

  @override
  String get cashierKeypadSpace => 'Space';

  @override
  String get cashierCashReturnDialogTitle => 'Confirm cash return';

  @override
  String get cashierReceivedValue => 'Received value';

  @override
  String get cashierDeductedValue => 'Deducted value';

  @override
  String get cashierReturnHighlighted => 'Return to client';

  @override
  String get cashierReadyForConfirmation => 'Ready';

  @override
  String get cashierPaymentPending => 'Payment pending';

  @override
  String get cashierFulfillmentCharge => 'Delivery type';

  @override
  String get cashierTipAmount => 'Tip';

  @override
  String get cashierPaymentMethod => 'Payment';

  @override
  String get cashierPaidAmount => 'Paid';

  @override
  String get cashierBalanceDue => 'Balance due';

  @override
  String get cashierPostponeOrder => 'Postpone order';

  @override
  String get cashierPostponeTitle => 'Postpone unpaid order';

  @override
  String get cashierPostponeReason => 'Reason';

  @override
  String get cashierPostponeReasonVisaDeclined => 'Card declined';

  @override
  String get cashierPostponeReasonFetchingCash => 'Client fetching cash';

  @override
  String get cashierPostponeReasonNoChange => 'No change available';

  @override
  String get cashierPostponeReasonOther => 'Other';

  @override
  String get cashierPostponeNote => 'Notes (optional)';

  @override
  String get cashierPostponeSaved =>
      'Order postponed — resume from cashier history';

  @override
  String get cashierPostponed => 'Postponed';

  @override
  String get cashierResumeOrder => 'Resume checkout';

  @override
  String get cashierNewOrder => 'Start new order';

  @override
  String get cashierKitchenSent => 'Sent to kitchen';

  @override
  String get cashierPromotionOffers => 'Offers';

  @override
  String get cashierPromotionCombos => 'Combos';

  @override
  String cashierDrawerIdentity(String number, String name) {
    return 'Cashier #$number · $name';
  }

  @override
  String get screenEditProfile => 'Edit profile';

  @override
  String get fieldEmail => 'Email';

  @override
  String get fieldPhone => 'Phone';

  @override
  String get actionEditProfile => 'Edit profile';

  @override
  String get adminKpiOrders => 'Today\'s orders';

  @override
  String get adminKpiRevenue => 'Revenue';

  @override
  String get adminKpiTips => 'Tips pool';

  @override
  String get adminOverviewSection => 'Overview';

  @override
  String get adminModulesSection => 'Modules';

  @override
  String get financialTotalsMismatch =>
      'Totals do not match ledger — recalculate before closing.';

  @override
  String get screenFinancialCalculationSubtitle =>
      'Daily revenue, tips, and deposit totals.';

  @override
  String platedBreakageCost(String amount) {
    return 'Missing plates will incur a $amount JOD breakage fee.';
  }

  @override
  String get screenPlatedReturnProcessSubtitle =>
      'Count returned trays and note any missing items.';

  @override
  String get profileAccountSection => 'Account';

  @override
  String get profileOrdersSection => 'Orders & rewards';

  @override
  String get platedDeliveryDepositNote =>
      'A refundable deposit applies to plated delivery orders.';

  @override
  String get adminInventoryLowTitle => 'Inventory Low: Ribeye Steak';

  @override
  String get adminInventoryLowBody =>
      'Only 14 units remaining. Projected to run out in 2 hours.';

  @override
  String get adminRestockAction => 'Restock';

  @override
  String get adminPendingTipTitle => 'Pending Tip Distribution';

  @override
  String get adminPendingTipBody =>
      '12 transactions awaiting shift closure for distribution.';

  @override
  String get adminReviewAction => 'Review';

  @override
  String get adminRevenueToday => 'Total Revenue (Today)';

  @override
  String get adminRevenueDelta => '+14.2% from yesterday';

  @override
  String get adminTipsCollected => 'Tips Collected';

  @override
  String get adminTipsAwaiting => 'Awaiting distribution';

  @override
  String get adminTipHistoryAction => 'History';

  @override
  String get adminTipDistributeAction => 'Distribute';

  @override
  String get adminDailyTipPool => 'Daily Tip Pool';

  @override
  String get adminTipDeltaYesterday => '+12% from yesterday';

  @override
  String get adminStaffDistribution => 'Staff Distribution';

  @override
  String get adminMembersScheduled => 'Members Scheduled';

  @override
  String get adminTotalHoursLogged => 'Total Hours Logged';

  @override
  String adminAverageRate(String amount) {
    return 'Avg. Rate: $amount / hr';
  }

  @override
  String get adminStaffBreakdown => 'Staff Breakdown';

  @override
  String get adminRecalculatePool => 'Recalculate Pool';

  @override
  String get adminApproveAllDistributions => 'Approve All Distributions';

  @override
  String get adminStaffMember => 'Staff Member';

  @override
  String get adminRole => 'Role';

  @override
  String get adminHours => 'Hours';

  @override
  String get adminTipShare => 'Tip Share';

  @override
  String get adminShowAllStaff => 'Show All 14 Staff Members';

  @override
  String get adminCalculationLogic => 'Calculation Logic';

  @override
  String get adminNetSalesTips => 'Net Sales Tips (85%)';

  @override
  String get adminDirectServicePremium => 'Direct Service Premium (10%)';

  @override
  String get adminCarryOver => 'Admin Carry Over (5%)';

  @override
  String get adminCalculatedPointRate => 'Calculated Point Rate';

  @override
  String get adminShareDistribution => 'Share Distribution';

  @override
  String get adminLossBreakage => 'Loss / Breakage';

  @override
  String get adminBreakageReports => '3 reports reported';

  @override
  String get adminBreakageOne => 'Unknown item #441 · 3 JOD';

  @override
  String get adminBreakageTwo => 'Snapping drink · 25 JOD';

  @override
  String get adminLiveOrderStatus => 'Live Order Status';

  @override
  String get adminManageStations => 'Manage Stations';

  @override
  String get adminHighDemand => 'High demand';

  @override
  String get adminNormalFlow => 'Avg wait';

  @override
  String get adminStationLoad => 'Active Station Load';

  @override
  String get adminGrillStation => 'Grill Station';

  @override
  String get adminColdPrepStation => 'Cold Prep / Salads';

  @override
  String get adminCapacity => 'capacity';

  @override
  String get adminStaffOnShift => 'Staff On Shift';

  @override
  String get adminManageRoster => 'Manage Roster';

  @override
  String get adminStaffActive => 'Active';

  @override
  String get adminStaffBreak => 'Break';

  @override
  String get adminMarketInsight => 'Market Insight';

  @override
  String get adminMarketInsightBody =>
      'Demand for plated dishes is up 22% this evening compared to last Friday. Recommend boosting appetizer prep.';

  @override
  String get adminNavOrders => 'Orders';

  @override
  String get adminNavPos => 'POS';

  @override
  String get adminNavKitchen => 'Kitchen';

  @override
  String get adminNavDelivery => 'Delivery';

  @override
  String get adminNavAdmin => 'Admin';

  @override
  String get screenCashierOrderHistoryDesc => 'Cashier order history screen.';

  @override
  String get dineWelcomeTitle => 'Welcome to Our Table';

  @override
  String get dineWelcomeSubtitle => 'Enter your table number to begin ordering';

  @override
  String get dineScanQrCode => 'Scan QR Code';

  @override
  String get dineOr => 'OR';

  @override
  String get dineCurrencyStatus => 'Currency Status';

  @override
  String get dineCurrencySubtitle => 'Paying in JOD (Jordanian Dinar)';

  @override
  String get financialGrossRevenue => 'Gross Revenue';

  @override
  String get financialRevenueDelta => '+12.5% from last period';

  @override
  String get financialTotalTipsExcluded => 'Total Tips (Excluded)';

  @override
  String get financialTipsSeparate => 'Distributed to staff separately';

  @override
  String get financialEscrowDeposits => 'Escrow Deposits';

  @override
  String get financialEscrowSubtitle => 'Conditional funds in-transit';

  @override
  String get financialProfitEngine => 'Profit Distribution Engine';

  @override
  String get financialNetRevenue => 'Net Distributable Revenue';

  @override
  String get financialPrdSplitLogic => 'PRD Split Logic';

  @override
  String get financialOwnerShare => 'Owner Share';

  @override
  String get financialOperatorShare => 'Operator Share';

  @override
  String get financialRevenueLogicBreakdown => 'Revenue Logic Breakdown';

  @override
  String get financialPhaseOne => 'PHASE 1';

  @override
  String get financialPhaseTwo => 'PHASE 2';

  @override
  String get financialTotalCapturedRevenue => 'Total Captured Revenue';

  @override
  String get financialTipsExcludedFromShare => 'Tips (Excluded from Share)';

  @override
  String get financialOperationalExpenses => 'Operational Expenses (Pre-Split)';

  @override
  String get financialNetDistributablePool => 'Net Distributable Pool';

  @override
  String get financialShareAllocation => 'Share Allocation (PRD v2.1)';

  @override
  String get financialOwnerTier => 'Owner Tier 1';

  @override
  String get financialPrimary => 'Primary';

  @override
  String get financialOperatorPerformance => 'Operator Performance';

  @override
  String get financialIncentivized => 'Incentivized';

  @override
  String get financialBaseMultiplier => 'Base Multiplier';

  @override
  String get financialAllocatedAmount => 'Allocated Amount';

  @override
  String get financialInitiateDisbursement => 'Initiate Bank Disbursement';

  @override
  String get financialWhyMathMatters => 'Why this math matters.';

  @override
  String get financialWhyBody =>
      'Our profit distribution engine ensures every dinar is accounted for by separating gross revenue from distributable profit, excluding staff tips, and holding refundable deposits outside the owner/operator split.';

  @override
  String get financialPdfReport => 'Download PDF Report';

  @override
  String get financialSharePartners => 'Share with Partners';

  @override
  String get financialOrders => 'Orders';

  @override
  String get financialPos => 'POS';

  @override
  String get financialAdmin => 'Admin';

  @override
  String get financialDelivery => 'Delivery';

  @override
  String get forgotPasswordTitle => 'Forgot Password';

  @override
  String get forgotPasswordSubtitle =>
      'Enter your registered phone or email to receive a reset code';

  @override
  String get forgotEmailPhoneLabel => 'Email or Phone Number';

  @override
  String get forgotEmailPhoneHint => 'e.g. guest@ayletna.com';

  @override
  String get forgotSendCode => 'Send Code';

  @override
  String get forgotBackToLogin => 'Back to login';

  @override
  String get forgotNeedHelp => 'Need help?';

  @override
  String get forgotContactSupport => 'Contact Ayletna Support';

  @override
  String get guestMenuNav => 'Menu';

  @override
  String get guestLocationsNav => 'Locations';

  @override
  String get guestAboutNav => 'About';

  @override
  String get guestLimitedOffer => 'Limited Time Offer';

  @override
  String get guestRoyalMansafTitle => 'The Royal Mansaf Experience';

  @override
  String get guestRoyalMansafSubtitle =>
      'Authentic Karak jameed and tender local lamb. 15% off for first-time guests.';

  @override
  String get guestWeekendFeast => 'Weekend Feast';

  @override
  String get guestWeekendFeastSubtitle =>
      'Order any appetizer and main to get a free Jallab drink.';

  @override
  String get guestClaimOffer => 'Claim Offer';

  @override
  String get guestMansafSpecials => 'Mansaf Specials';

  @override
  String guestItemsFound(int count) {
    return '$count items found';
  }

  @override
  String get guestRefreshingDrinks => 'Refreshing Drinks';

  @override
  String get guestBrowseMore => 'Browse More';

  @override
  String get guestMintLemonade => 'Mint Lemonade';

  @override
  String get guestArabicCoffee => 'Arabic Coffee';

  @override
  String get guestLocalWater => 'Local Water';

  @override
  String get guestSageTea => 'Sage Tea';

  @override
  String get homeSearchHint => 'Search dishes, categories...';

  @override
  String get screenSearch => 'Search';

  @override
  String get searchTitle => 'Find your next meal';

  @override
  String get searchSubtitle =>
      'Search the Ayletna menu by dish, category, or ingredient-style description.';

  @override
  String get searchMenuHint => 'Search menu, dishes, or ingredients...';

  @override
  String get searchRecentTitle => 'Recent Searches';

  @override
  String get searchClearAll => 'Clear All';

  @override
  String get searchTopResults => 'Top Results';

  @override
  String searchItemsFound(int count) {
    return '$count items found';
  }

  @override
  String get searchAddShort => 'Add';

  @override
  String get searchStartTitle => 'Type a dish name';

  @override
  String get searchStartBody =>
      'Try shawarma, hummus, pizza, falafel, burger, or any craving from the menu.';

  @override
  String get searchEmptyTitle => 'No dishes found';

  @override
  String get searchEmptyBody =>
      'Try a different dish name or browse the full menu categories.';

  @override
  String searchResultsCount(int count) {
    return '$count results found';
  }

  @override
  String get searchPopularSuggestions => 'Popular searches';

  @override
  String get searchBrowseMenu => 'Browse full menu';

  @override
  String get homePlatedDelivery => 'PLATED DELIVERY';

  @override
  String get homeZeroWasteTitle => 'Traditional Taste,\nZero Waste.';

  @override
  String get homeZeroWasteSubtitle =>
      'Get your feast served on authentic clay plates. 5 JOD refundable deposit per plate.';

  @override
  String get homeOrderNow => 'Order Now';

  @override
  String get homeOffers => 'Offers';

  @override
  String get homeCombos => 'Combos';

  @override
  String get homeDiscounts => 'Discounted items';

  @override
  String get homeSubscriptions => 'Subscription meals';

  @override
  String get homeStories => 'From Ayletna';

  @override
  String get homeLatestBlogs => 'Latest blogs';

  @override
  String get homeBlogBadge => 'Blog';

  @override
  String get homeBlogRead => 'Read';

  @override
  String get homeSubscriptionCta => 'Subscribe';

  @override
  String get homeDiscountBadge => 'Save';

  @override
  String get homePopularThisWeek => 'Popular This Week';

  @override
  String get homeViewAll => 'View All';

  @override
  String get homeSustainabilityDeposit => 'Sustainability Deposit';

  @override
  String get homeSustainabilityBody =>
      'Choose the Plated option for an eco-friendly experience. A small deposit for our premium clayware will be added and fully refunded when we collect the plates after your meal.';

  @override
  String get homeLearnHowItWorks => 'Learn how it works';

  @override
  String get inventorySearchHint => 'Search ingredients...';

  @override
  String get inventoryLogWastage => 'Log Wastage';

  @override
  String get inventoryAddStock => 'Add Stock';

  @override
  String get inventoryLowStockAlerts => 'Low Stock Alerts';

  @override
  String get inventoryProtein => 'PROTEIN';

  @override
  String get inventoryDairy => 'DAIRY';

  @override
  String get inventoryProduce => 'PRODUCE';

  @override
  String get inventoryPantry => 'PANTRY';

  @override
  String get inventoryRibeyeSteak => 'Ribeye Steak';

  @override
  String get inventoryHeavyCream => 'Heavy Cream';

  @override
  String get inventoryFreshBasil => 'Fresh Basil';

  @override
  String get inventoryTruffleOil => 'Truffle Oil';

  @override
  String inventoryRemaining(String amount) {
    return '$amount remaining';
  }

  @override
  String get inventoryOutOfStock => 'Out of Stock';

  @override
  String inventoryReorderPoint(String amount) {
    return 'Reorder Point: $amount';
  }

  @override
  String get inventoryRequiredForDishes => 'Required for 4 dishes';

  @override
  String get inventoryKeyLevels => 'Key Ingredients Levels';

  @override
  String get inventoryFullList => 'Full Inventory List';

  @override
  String get inventoryOrganicChicken => 'Organic Chicken Breast';

  @override
  String get inventoryDairyEggs => 'Dairy & Eggs Bundle';

  @override
  String get inventorySeafood => 'Seafood (Salmon/Sea Bass)';

  @override
  String get inventoryFlourStaples => 'Flour & Dry Staples';

  @override
  String inventoryLevelMeta(int percent, String capacity) {
    return '$percent% / $capacity';
  }

  @override
  String get inventoryValue => 'Inventory Value';

  @override
  String get inventoryValueDelta => '+2.4% from last week';

  @override
  String get inventoryPendingOrders => 'Pending Orders';

  @override
  String get inventoryShipmentsToday => '3 shipments expected today';

  @override
  String get inventoryStorageHealth => 'Storage Health';

  @override
  String get inventoryColdStorage => 'Cold Storage';

  @override
  String get inventoryDryStorage => 'Dry Storage';

  @override
  String get inventoryFreezerUnit => 'Freezer Unit B';

  @override
  String get inventoryOptimal => 'Optimal';

  @override
  String get inventoryAlert => 'Alert';

  @override
  String get inventoryRecentWastage => 'Recent Wastage Logs';

  @override
  String get inventoryDownloadReport => 'Download Report';

  @override
  String get inventoryItemName => 'Item Name';

  @override
  String get inventoryQuantity => 'Quantity';

  @override
  String get inventoryReason => 'Reason';

  @override
  String get inventoryValueLost => 'Value Lost';

  @override
  String get inventoryLogDate => 'Log Date';

  @override
  String get inventoryUser => 'User';

  @override
  String get inventoryAvocadoCase => 'Avocado (Case)';

  @override
  String get inventoryWholeMilk => 'Whole Milk';

  @override
  String get inventorySeaBassFillets => 'Sea Bass Fillets';

  @override
  String get inventorySpoilage => 'Spoilage';

  @override
  String get inventoryExpired => 'Expired';

  @override
  String get inventoryPrepWaste => 'Prep Waste';

  @override
  String get inventoryChefUser => 'Chef Team';

  @override
  String get inventoryAdminUser => 'Admin Team';

  @override
  String get inventoryItemAtlanticSalmon => 'Atlantic Salmon';

  @override
  String get inventoryItemSupplyBadge => 'Dine-in Supply';

  @override
  String get inventoryItemPremiumFillet => 'Premium Grade Fillet';

  @override
  String get inventoryItemSku => 'SKU: INV-SAL-042 | Fresh Wild-Caught';

  @override
  String get inventoryCurrentStock => 'Current Stock';

  @override
  String get inventoryKg => 'kg';

  @override
  String get inventorySafetyThreshold => 'Safety Threshold';

  @override
  String get inventoryHealthyInventory => 'Healthy Inventory';

  @override
  String get inventoryAdjustStock => 'Adjust Stock';

  @override
  String get inventoryAdjustmentQuantity => 'Adjustment Quantity (kg)';

  @override
  String get inventoryAdjustmentHint => 'e.g. -2.5';

  @override
  String get inventoryReasonAdjustment => 'Reason for Adjustment';

  @override
  String get inventoryConsumption => 'Consumption';

  @override
  String get inventoryDamageSpoilage => 'Damage / Spoilage';

  @override
  String get inventoryCorrection => 'Correction';

  @override
  String get inventoryArrivalShipment => 'Arrival of Shipment';

  @override
  String get inventoryThresholdConfig => 'Safety Threshold Configuration';

  @override
  String get inventoryLowStockTrigger =>
      'Triggers Low Stock alert at this level.';

  @override
  String get inventoryUpdateInventory => 'Update Inventory';

  @override
  String get inventoryMainSupplier => 'Main Supplier';

  @override
  String get inventorySupplierName => 'North Atlantic Fisheries';

  @override
  String get inventorySupplierLeadTime => 'Lead Time: 2 Business Days';

  @override
  String get inventoryContactRepresentative => 'Contact Representative';

  @override
  String get inventoryLastSevenDaysUsage => 'Last 7 Days Usage';

  @override
  String get inventoryInStock => 'In Stock';

  @override
  String get inventoryRecentHistoryAudit => 'Recent History Audit';

  @override
  String get inventoryDate => 'Date';

  @override
  String get inventoryType => 'Type';

  @override
  String get inventoryAmount => 'Amount';

  @override
  String get inventoryBalance => 'Balance';

  @override
  String get inventoryTodayTime => 'Today, 09:12 AM';

  @override
  String get inventoryOct24Time => 'Oct 24, 11:30 AM';

  @override
  String get inventoryOct23Time => 'Oct 23, 05:45 PM';

  @override
  String get inventoryDeliveryType => 'Delivery';

  @override
  String get inventoryChefShort => 'M. Chef';

  @override
  String get inventorySysAdmin => 'Sys Admin';

  @override
  String get inventoryLineCook => 'Line Cook';

  @override
  String kitchenStatusWithCount(String status, int count) {
    return '$status ($count)';
  }

  @override
  String kitchenOrderTitle(String id) {
    return 'Order #$id';
  }

  @override
  String kitchenOrderMeta(String source, String time) {
    return '$source • $time';
  }

  @override
  String get kitchenDone => 'Done';

  @override
  String get kitchenTable12 => 'Table 12';

  @override
  String get kitchenTable04 => 'Table 04';

  @override
  String get kitchenUberEats => 'UberEats';

  @override
  String get kitchenPickup => 'Pickup';

  @override
  String get kitchenWagyuBurger => '2x Wagyu Burger';

  @override
  String get kitchenBurgerNote => 'No onions, Extra cheese';

  @override
  String get kitchenTruffleFries => '1x Truffle Fries';

  @override
  String get kitchenMargheritaPizza => '1x Margherita Pizza';

  @override
  String get kitchenGardenSalad => '1x Garden Salad';

  @override
  String get kitchenCrispyTacos => '4x Crispy Tacos';

  @override
  String get kitchenGuacamoleDip => '2x Guacamole Dip';

  @override
  String get kitchenRoastChicken => '1x Roast Chicken';

  @override
  String get kitchenMashedPotatoes => '1x Mashed Potatoes';

  @override
  String prepTitle(String id) {
    return 'Order #$id Prep';
  }

  @override
  String get prepPlated => 'PLATED';

  @override
  String get prepTable14 => 'Table 14';

  @override
  String get prepGuestName => 'Guest: Alexander Mercer';

  @override
  String get prepCovers => '4 Covers';

  @override
  String get prepReceived => 'Received 14:20';

  @override
  String get prepOrderItems => 'Order Items';

  @override
  String get prepItemsTotal => '5 Items Total';

  @override
  String prepQuantity(int count) {
    return '${count}x';
  }

  @override
  String get prepWagyuBurger => 'Wagyu Burger';

  @override
  String get prepNoOnions => 'No onions';

  @override
  String get prepBurgerSpecs => 'Medium Rare • Brioche Bun • Extra Pickles';

  @override
  String get prepTruffleFries => 'Truffle Fries';

  @override
  String get prepFriesSpecs =>
      'Parmesan Dust • Rosemary Sprig • Truffle Aioli Side';

  @override
  String get prepHouseCaesar => 'House Caesar Salad';

  @override
  String get prepCaesarSpecs => 'Dressing on the side • No Anchovies';

  @override
  String get prepKitchenNotes => 'Kitchen Notes';

  @override
  String get prepKitchenNoteBody =>
      'Birthday celebration at Table 14. Please ensure all plated dishes go out simultaneously. Guest in Seat 2 has a severe onion allergy; ensure strict cross-contamination protocol for the Wagyu Burgers.';

  @override
  String get prepServer => 'Server: David K.';

  @override
  String get prepUrgent => 'Urgent';

  @override
  String get prepStages => 'Preparation Stages';

  @override
  String get prepOrderReceived => 'Order Received (14:20)';

  @override
  String get prepStarted => 'Prep Started (14:22)';

  @override
  String get prepAssemblyProgress => 'Assembly In Progress';

  @override
  String get prepFinalPlating => 'Final Plating';

  @override
  String get prepKitchenEfficiency => 'Kitchen Efficiency';

  @override
  String get prepSustainability => '94% Sustainability';

  @override
  String get prepBack => 'Back';

  @override
  String get prepIssue => 'Issue';

  @override
  String get prepProgress => 'Progress';

  @override
  String prepItemsChecked(int checked, int total) {
    return '$checked / $total Items Checked';
  }

  @override
  String get prepMarkReady => 'Mark as Ready';

  @override
  String get kitchenView => 'Kitchen View';

  @override
  String get kitchenReadyHandover => 'Ready for Handover';

  @override
  String get kitchenAllActive => 'All Active';

  @override
  String get kitchenReadyCount => 'Ready (12)';

  @override
  String get kitchenPreparing => 'Preparing';

  @override
  String get kitchenDelayed => 'Delayed';

  @override
  String get kitchenAverageReadyTime => 'Average Ready Time';

  @override
  String get kitchenReadyMinutes => '4:12 min';

  @override
  String get kitchenHighestVolumeType => 'Highest Volume Type';

  @override
  String get kitchenStationEfficiency => 'Station Efficiency';

  @override
  String kitchenReadyTimer(String time) {
    return 'Ready $time';
  }

  @override
  String kitchenOrd(String id) {
    return 'ORD #$id';
  }

  @override
  String get kitchenSustainability => 'Sustainability';

  @override
  String get kitchenExpressCounter => 'Express Counter';

  @override
  String get kitchenGuestSarah => 'Guest: Sarah W.';

  @override
  String get kitchenDoorDashJames => 'DoorDash: James';

  @override
  String get kitchenGuestMike => 'Guest: Mike R.';

  @override
  String get kitchenSignatureWagyuBurger => 'Signature Wagyu Burger';

  @override
  String get kitchenTruffleParmesanFries => 'Truffle Parmesan Fries';

  @override
  String get kitchenIcedMatchaLatte => 'Iced Matcha Latte';

  @override
  String get kitchenZeroWasteKaleBowl => 'Zero-Waste Kale Bowl';

  @override
  String get kitchenRecycledPulpJuice => 'Recycled Pulp Juice';

  @override
  String get kitchenCustomerWaiting => 'Customer waiting over 15m';

  @override
  String get kitchenMediterraneanPlate => 'Mediterranean Plate';

  @override
  String get kitchenExtraPitaSide => 'Extra Pita Side';

  @override
  String get kitchenCrispyChickenSando => 'Crispy Chicken Sando';

  @override
  String get kitchenSpicyRamenCombo => 'Spicy Ramen Combo';

  @override
  String get kitchenGardenFreshSalad => 'Garden Fresh Salad';

  @override
  String get kitchenSpicedTofuTacos => 'Spiced Tofu Tacos';

  @override
  String get kitchenRoastedCornDip => 'Roasted Corn Dip';

  @override
  String get kitchenHandoverServer => 'Handover to Server';

  @override
  String get kitchenHandoverNow => 'Handover Now';

  @override
  String get kitchenHandoverGuest => 'Handover to Guest';

  @override
  String get kitchenHandoverCourier => 'Handover to Courier';

  @override
  String get languageWelcomeTitle => 'Choose Your Language';

  @override
  String get languageWelcomeSubtitle =>
      'Welcome to Ayletna. Please select your preferred language to continue.';

  @override
  String get languageEnglishSubtitle => 'Western Interface';

  @override
  String get languageArabicSubtitle => 'Arabic Interface';

  @override
  String get languageAccessGateway => 'Universal Access Gateway';

  @override
  String get loginWelcomeBack => 'Welcome back';

  @override
  String get loginOperationalSubtitle => 'Welcome back to Ayletna';

  @override
  String get loginPhoneOrEmail => 'Phone or Email';

  @override
  String get loginEmailHint => 'e.g. guest@ayletna.com';

  @override
  String get loginAction => 'Sign In';

  @override
  String get loginOr => 'or';

  @override
  String get loginDemoHubTitle => 'Staff hubs';

  @override
  String get loginDemoHubSubtitle =>
      'Sign in with a management or specialist role.';

  @override
  String get loginContinueGuest => 'Continue as Guest';

  @override
  String get loginNoAccount => 'Don\'t have an account?';

  @override
  String get loginTrustSecure => 'Secure';

  @override
  String get loginTrustCloudSync => 'Fresh favorites';

  @override
  String get loginTrustSupport => 'Guest care';

  @override
  String get loginPasswordHint => '••••••••';

  @override
  String get loyaltyTitle => 'Loyalty & Rewards';

  @override
  String get loyaltySubtitle => 'Savor every bite, collect every point.';

  @override
  String get loyaltyGoldMember => 'Gold Member';

  @override
  String get loyaltySavorPoints => 'Savor Points';

  @override
  String get loyaltyLifetimePoints => 'Lifetime Points';

  @override
  String get loyaltyNextTier => 'Next Tier: Platinum';

  @override
  String get loyaltyEarnMore => 'Earn 550 more points to unlock';

  @override
  String get loyaltyProgressPercent => '82%';

  @override
  String get loyaltyCurrentGold => 'Current: Gold';

  @override
  String get loyaltyGoalPoints => 'Goal: 3,000 pts';

  @override
  String get loyaltyGoldPerks => 'Gold Perks';

  @override
  String get loyaltyPerkMultiplier => '1.5x points on every order';

  @override
  String get loyaltyPerkPriority => 'Priority reservation booking';

  @override
  String get loyaltyPerkDessert => 'Complimentary birthday dessert';

  @override
  String get loyaltyExplorePlatinum => 'Explore Platinum Perks';

  @override
  String get loyaltyAvailableRewards => 'Available Rewards';

  @override
  String get loyaltyFilter => 'Filter';

  @override
  String get loyaltySort => 'Sort';

  @override
  String get loyaltyPopular => 'Popular';

  @override
  String get loyaltyRedeem => 'Redeem';

  @override
  String get loyaltyNoRewardsInFilter => 'No rewards in this filter right now.';

  @override
  String get loyaltyLocked => 'Locked';

  @override
  String get loyaltySignaturePlatter => 'Signature BBQ Platter';

  @override
  String get loyaltySignaturePlatterDesc =>
      'Redeem for a full grill platter with three sides.';

  @override
  String get loyaltyLargePizza => 'Any Large Pizza';

  @override
  String get loyaltyLargePizzaDesc =>
      'Choose any large flatbread from our family oven menu.';

  @override
  String get loyaltyFreeDessert => 'Free Dessert';

  @override
  String get loyaltyFreeDessertDesc =>
      'A sweet treat from our pastry chef\'s daily selection.';

  @override
  String get loyaltyChefTasting => 'Chef\'s Tasting for Two';

  @override
  String get loyaltyChefTastingDesc =>
      'Private tasting experience curated by our executive chef.';

  @override
  String loyaltyPointsShort(String points) {
    return '$points pts';
  }

  @override
  String get loyaltyDine => 'Dine';

  @override
  String get loyaltyDineDesc =>
      'Earn 10 points for every 1 JOD spent at any Ayletna branch.';

  @override
  String get loyaltyCollect => 'Collect';

  @override
  String get loyaltyCollectDesc =>
      'Watch your points grow and unlock premium tier benefits.';

  @override
  String get loyaltyEnjoy => 'Enjoy';

  @override
  String get loyaltyEnjoyDesc =>
      'Redeem your hard-earned points for exclusive rewards.';

  @override
  String get mapSearchHint => 'Search for your delivery address...';

  @override
  String get mapSearchValue => '123 Gastronomy Lane, Suite 400';

  @override
  String get mapDeliveryPin => 'Delivery Pin';

  @override
  String get mapConfirmLocation => 'Confirm Location';

  @override
  String get mapSelectedAddress => '123 Gastronomy Lane, Central Hub, Amman';

  @override
  String get mapAddNote => 'Add Note';

  @override
  String get mapConfirmContinue => 'Confirm & Continue';

  @override
  String get mapQuickHome => 'Home';

  @override
  String get mapQuickOffice => 'Office';

  @override
  String get mapQuickRecent => 'Recent';

  @override
  String get menuManagementTitle => 'Menu Management';

  @override
  String get menuManagementSubtitle =>
      'Manage your digital menu items, pricing, and live availability.';

  @override
  String get menuAddNewItem => 'Add New Item';

  @override
  String get menuBulkImport => 'Bulk Import';

  @override
  String get menuTotalItems => 'Total Items';

  @override
  String get menuTotalItemsDelta => '▲ 4 this month';

  @override
  String get menuActiveNow => 'Active Now';

  @override
  String get menuInactiveCount => '6 inactive';

  @override
  String get menuOutOfStock => 'Out of Stock';

  @override
  String get menuActionRequired => 'Action required';

  @override
  String get menuAvgPrice => 'Avg. Price';

  @override
  String get menuMarketStable => 'Market stable';

  @override
  String get menuAllCategories => 'All Categories';

  @override
  String get menuMainCourse => 'Main Course';

  @override
  String get menuAppetizers => 'Appetizers';

  @override
  String get menuBeverages => 'Beverages';

  @override
  String get menuDesserts => 'Desserts';

  @override
  String get menuSearchHint => 'Search menu items...';

  @override
  String get menuInStock => 'In Stock';

  @override
  String get menuLowStock => 'Low Stock (8)';

  @override
  String get menuOutOfStockLabel => 'Out of Stock';

  @override
  String get menuActive => 'Active';

  @override
  String get menuInactive => 'Inactive';

  @override
  String get menuDineIn => 'Dine-in';

  @override
  String get menuTakeaway => 'Takeaway';

  @override
  String get menuDelivery => 'Delivery';

  @override
  String get menuGrilledChickenSalad => 'Grilled Chicken Salad';

  @override
  String get menuGrilledChickenSaladDesc => 'Main Course • Organic Greens';

  @override
  String get menuSignatureBurger => 'Ayletna Signature Burger';

  @override
  String get menuSignatureBurgerDesc => 'Main Course • Beef Burger';

  @override
  String get menuTruffleFries => 'Hand-cut Truffle Fries';

  @override
  String get menuTruffleFriesDesc => 'Appetizer • Truffle Oil';

  @override
  String get actionEdit => 'Edit';

  @override
  String get actionRemove => 'Remove';

  @override
  String get actionApply => 'Apply';

  @override
  String cartOrderItemsCount(int count) {
    return 'Order Items ($count)';
  }

  @override
  String get cartClearAll => 'Clear All';

  @override
  String get cartPromoCode => 'Promo Code';

  @override
  String get cartPromoHint => 'Enter code';

  @override
  String get cartYourCartTitle => 'Your Cart';

  @override
  String get cartReviewSubtitle =>
      'Review your items before placing the order.';

  @override
  String get cartOrderSummary => 'Order Summary';

  @override
  String get cartFulfillment => 'Fulfillment';

  @override
  String get cartSubtotal => 'Subtotal';

  @override
  String get cartFree => 'Free';

  @override
  String get cartDineInServiceFee => 'Dine-in service fee';

  @override
  String get cartTakeawayPackagingFee => 'Takeaway packaging fee';

  @override
  String get cartDeliveryFee => 'Delivery fee';

  @override
  String get cartGroupDeliveryFee => 'Group delivery fee';

  @override
  String get cartPlatedDeposit => 'Reusable tray deposit';

  @override
  String get cartEstimatedTax => 'Estimated Tax (5%)';

  @override
  String get cartTotal => 'Total';

  @override
  String get cartApproxUsd => 'approx. \$30.73 USD';

  @override
  String get cartProceedCheckout => 'Proceed to Checkout';

  @override
  String get cartGuestSignInPrompt =>
      'Sign in to place your order and track delivery in real time.';

  @override
  String get cartCheckoutStepBasket => 'Basket';

  @override
  String get cartCheckoutStepFulfillment => 'Fulfillment';

  @override
  String get cartCheckoutStepPayment => 'Payment';

  @override
  String get cartCheckoutStepReview => 'Review';

  @override
  String get demoModeBanner => 'Action completed.';

  @override
  String get cartTermsNotice =>
      'By clicking, you agree to our Terms of Service.';

  @override
  String get cartViewItems => 'View items';

  @override
  String get cartFulfillmentTitle => 'Choose fulfillment';

  @override
  String get cartFulfillmentSubtitle =>
      'Choose the service method directly in the cart without opening a separate screen.';

  @override
  String get cartGroupDeliveryTitle => 'Group delivery';

  @override
  String get cartGroupDeliveryBody =>
      'Wait for a nearby order in the same area to reduce delivery cost and improve route efficiency.';

  @override
  String get cartTermsAndConditions => 'Terms and conditions';

  @override
  String get cartSelectedAddress => 'Selected address';

  @override
  String get cartAddressRequired =>
      'Choose a default delivery address before checkout.';

  @override
  String get cartChooseAddress => 'Choose address';

  @override
  String get cartPaymentType => 'Payment type';

  @override
  String get cartTipTitle => 'Add a tip';

  @override
  String get cartTipSubtitle =>
      'Optional appreciation for the kitchen and delivery team.';

  @override
  String get cartNoTip => 'No tip';

  @override
  String get cartHelpTitle => 'Need help with your order?';

  @override
  String get cartChatWithUs => 'Chat with us';

  @override
  String get supportHeroTitle => 'How can we help?';

  @override
  String get supportHeroBody =>
      'Choose the fastest support channel for order questions, delivery updates, or payment help.';

  @override
  String get supportLiveChatTitle => 'Live chat';

  @override
  String get supportLiveChatBody =>
      'Start a quick conversation with the service team.';

  @override
  String get supportCallTitle => 'Call restaurant';

  @override
  String get supportCallBody =>
      'Speak with the front desk about urgent order changes.';

  @override
  String get supportWhatsappTitle => 'WhatsApp support';

  @override
  String get supportWhatsappBody =>
      'Send a message with your order details and preferred contact time.';

  @override
  String get supportOrderHelpTitle => 'Order help';

  @override
  String get supportOrderHelpBody =>
      'Use this page for cart, delivery, payment, and plated-return questions.';

  @override
  String get supportFaqTitle => 'FAQ';

  @override
  String get supportFaqBody =>
      'Browse common delivery, payment, and plated-return answers.';

  @override
  String get supportTicketsSubtitle =>
      'Track open and resolved support requests.';

  @override
  String get supportViewMoreTickets => 'View more';

  @override
  String get supportTicketRequestFollowUp => 'Request follow-up';

  @override
  String get supportTicketCancel => 'Cancel ticket';

  @override
  String get supportTicketUrgent => 'Mark urgent';

  @override
  String get supportTicketActionSent => 'Ticket action sent.';

  @override
  String get supportTicketRateResponse => 'Rate this response';

  @override
  String get supportTicketRemarkLabel => 'Response remark';

  @override
  String get supportTicketRemarkHint =>
      'Write a note about the support response...';

  @override
  String get supportTicketSubmitRating => 'Submit rating';

  @override
  String get supportTicketRatingSaved => 'Ticket rating saved.';

  @override
  String get supportNewTicketTitle => 'Live chat ticket';

  @override
  String get supportNewTicketBody =>
      'A new chat session was opened with the customer care team.';

  @override
  String get supportTicketOpened => 'New support ticket opened.';

  @override
  String get supportChatHeroTitle => 'Live support chat';

  @override
  String get supportChatHeroBody =>
      'The agent starts with chat and opens a ticket only when follow-up is needed.';

  @override
  String get supportChatActiveSession => 'Active chat session';

  @override
  String get supportChatNoTicketYet => 'No ticket opened yet';

  @override
  String get supportChatAgentGreeting =>
      'Welcome to Ayletna support. Tell me what happened and I will check if this needs a ticket.';

  @override
  String get supportChatCustomerSample => 'I need help with my active order.';

  @override
  String get supportChatAgentDecision =>
      'I can help here first. If the issue needs restaurant follow-up, I will open a ticket and keep it visible in Support.';

  @override
  String get supportChatAgentName => 'Ayletna Agent';

  @override
  String get supportChatCustomerName => 'You';

  @override
  String get supportChatAgentTicketNote =>
      'Only the support agent can open a follow-up ticket after reviewing the chat.';

  @override
  String get supportChatMessageLabel => 'Message';

  @override
  String get supportChatMessageHint => 'Write your question or order note...';

  @override
  String get supportChatSend => 'Send message';

  @override
  String get supportChatOpenTicket => 'Open ticket if needed';

  @override
  String get supportAdminSetupNote =>
      'Restaurant phone and WhatsApp numbers can be edited from admin settings.';

  @override
  String get supportExternalActionFallback =>
      'Could not open this action. Use the displayed contact details.';

  @override
  String get screenFaq => 'FAQ';

  @override
  String get faqHeroTitle => 'Frequently asked questions';

  @override
  String get faqHeroBody => 'Quick answers before opening a support ticket.';

  @override
  String get faqDeliveryTitle => 'How do delivery updates work?';

  @override
  String get faqDeliveryBody =>
      'Active orders show a timeline. When the order is on the way, the driver contact button becomes available.';

  @override
  String get faqPaymentTitle => 'Which payment methods are supported?';

  @override
  String get faqPaymentBody =>
      'Checkout supports card and cash payment methods.';

  @override
  String get faqPlatedTitle => 'How does plated delivery work?';

  @override
  String get faqPlatedBody =>
      'Reusable trays include a refundable deposit and follow the plated-return reminder flow.';

  @override
  String get cartMargheritaPremium => 'Margherita Premium';

  @override
  String get cartMargheritaPremiumDesc =>
      'Extra Buffalo Mozzarella, Fresh Basil';

  @override
  String get cartFreshOrangeJuice => 'Fresh Orange Juice';

  @override
  String get cartFreshOrangeJuiceDesc => 'Chilled, No Sugar Added';

  @override
  String get cartChocoLavaDelight => 'Choco Lava Delight';

  @override
  String get cartChocoLavaDelightDesc => 'With Vanilla Bean Gelato';

  @override
  String get orderHistoryTitle => 'Order History';

  @override
  String get orderHistorySubtitle =>
      'Manage your past dining experiences and re-order your favorites.';

  @override
  String get orderHistoryFilter => 'Filter';

  @override
  String get orderHistoryLast30Days => 'Last 30 Days';

  @override
  String get orderHistoryInsights => 'Insights';

  @override
  String get orderHistoryTotalOrders => 'Total Orders';

  @override
  String get orderHistoryTotalSpent => 'Total Spent (JOD)';

  @override
  String get orderHistoryQuote => '\"Taste the consistency in every order.\"';

  @override
  String get orderHistoryWeekendSpecial => 'Weekend Special';

  @override
  String get orderHistoryWeekendSubtitle =>
      'Get 15% off on your next re-order.';

  @override
  String get orderHistoryActive => 'Active';

  @override
  String get orderHistoryViewStatus => 'View status';

  @override
  String get orderHistoryProgressTitle => 'Order progress';

  @override
  String get orderHistoryCurrentStep => 'Current step';

  @override
  String get orderHistoryDoneStep => 'Done';

  @override
  String get orderHistoryRemainingStep => 'Remaining';

  @override
  String orderHistoryStepCounter(String current, String total) {
    return 'Step $current of $total';
  }

  @override
  String get orderHistoryStatusUpdated => 'Active order status updated.';

  @override
  String get orderHistoryDriverContactTitle => 'Driver contact';

  @override
  String get orderHistoryDriverContactBody =>
      'Your order is on the way. Call the driver if you need to coordinate delivery.';

  @override
  String get orderHistoryCallDriver => 'Call driver';

  @override
  String get orderHistoryCompleted => 'Completed';

  @override
  String get orderHistoryCancelled => 'Cancelled';

  @override
  String get orderHistoryViewInvoice => 'View Invoice';

  @override
  String get orderHistoryNoInvoice => 'No Invoice';

  @override
  String get orderHistoryReorder => 'Re-order';

  @override
  String get orderHistoryTryAgain => 'Try Again';

  @override
  String get orderHistoryShowMore => 'Show More Orders';

  @override
  String get orderHistoryOrder9821 => 'Order #SV-9821';

  @override
  String get orderHistoryOrder9750 => 'Order #SV-9750';

  @override
  String get orderHistoryOrder9612 => 'Order #SV-9612';

  @override
  String get orderHistoryDate9821 => 'Oct 12, 2023 • 14:30';

  @override
  String get orderHistoryDate9750 => 'Oct 08, 2023 • 20:15';

  @override
  String get orderHistoryDate9612 => 'Oct 02, 2023 • 19:45';

  @override
  String get orderHistoryDineInTable => 'Dine-In • Table 4';

  @override
  String get orderHistoryMansaf => '2x Mansaf Traditional';

  @override
  String get orderHistoryArabicSalad => '1x Arabic Salad';

  @override
  String get orderHistoryMintLemonade => '3x Fresh Mint Lemonade';

  @override
  String get orderHistorySeaBass => '1x Grilled Sea Bass';

  @override
  String get orderHistorySaffronRice => '2x Saffron Rice';

  @override
  String get orderHistoryMixedGrill => '4x Mixed Grill Platter';

  @override
  String get orderHistoryMezzeTray => '1x Large Mezze Tray';

  @override
  String get profileAccountSettings => 'Account Settings';

  @override
  String get profilePersonalProfile => 'Personal Profile';

  @override
  String get profileMemberName => 'Leen Haddad';

  @override
  String get profileMemberSince => 'Member since June 2022';

  @override
  String get profileEditDetails => 'Edit Profile Details';

  @override
  String get profileChangePhoto => 'Change profile image';

  @override
  String get profilePhotoUpdated => 'Profile image updated';

  @override
  String get profileChoosePhoto => 'Choose a photo';

  @override
  String get profileTakePhoto => 'Take photo';

  @override
  String get profileChooseFromGallery => 'Choose from gallery';

  @override
  String get profilePhotoPickFailed =>
      'Couldn\'t update profile image. Try again.';

  @override
  String get profileCameraPermissionTitle => 'Camera access';

  @override
  String get profileCameraPermissionBody =>
      'Ayletna needs access to your camera so you can take a new profile photo.';

  @override
  String get profileGalleryPermissionTitle => 'Photo library access';

  @override
  String get profileGalleryPermissionBody =>
      'Ayletna needs access to your photos so you can choose a profile image.';

  @override
  String get profilePermissionAllow => 'Allow';

  @override
  String get profilePermissionDeny => 'Don\'t allow';

  @override
  String get profileCameraPermissionDenied =>
      'Camera access is required to take a profile photo.';

  @override
  String get profileGalleryPermissionDenied =>
      'Photo library access is required to choose a profile image.';

  @override
  String get profileRemovePhoto => 'Remove photo';

  @override
  String get profileEpicureanTier => 'Epicurean Tier';

  @override
  String get profileGoldStatus => 'Gold Status';

  @override
  String get profileSavorPoints => 'Savor Points';

  @override
  String get profilePointsValue => '4,850';

  @override
  String get profileTierProgress =>
      '1,150 points until Platinum Tier benefits.';

  @override
  String get profileRewardsCatalog => 'Rewards Catalog';

  @override
  String get profilePointsHistory => 'Points activity';

  @override
  String get profileNoPointsActivity => 'No points activity yet.';

  @override
  String get profilePointsActivityLabel => 'Points activity';

  @override
  String get profilePointsHistorySubtitle =>
      'Recent reward points earned and redeemed.';

  @override
  String get profileViewAllPointsHistory => 'View All History';

  @override
  String get profilePaymentHistory => 'Payment history';

  @override
  String get profilePaymentHistorySubtitle =>
      'Recent successful customer payments.';

  @override
  String get profileViewAllPaymentHistory => 'View Payment History';

  @override
  String get profileContact => 'Contact';

  @override
  String get profilePhoneNumber => 'Phone Number';

  @override
  String get profilePhoneValue => '+962 7 9123 4567';

  @override
  String get profileEmailAddress => 'Email Address';

  @override
  String get profileEmailValue => 'leen.haddad@example.com';

  @override
  String get profileWalletBalance => 'Wallet balance';

  @override
  String get profileWalletAmount => '124.50';

  @override
  String get profileWalletSubtitle => 'Available for instant checkout';

  @override
  String get profileVisaEnding => 'Visa ending in 8842';

  @override
  String get profileVisaExpiry => 'Expires 09/26';

  @override
  String get profileManage => 'Manage';

  @override
  String get profileSavedAddresses => 'Saved Addresses';

  @override
  String get profileAddNew => 'Add New';

  @override
  String get profileDeleteAddressTitle => 'Delete address?';

  @override
  String get profileDeleteAddressBody =>
      'This removes the saved address from your profile.';

  @override
  String get profileHomeAddressTitle => 'Home';

  @override
  String get profileHomeAddress => '42 Al-Reem Street, Apt 4B\nAmman, Jordan';

  @override
  String get profileOfficeAddressTitle => 'Office';

  @override
  String get profileOfficeAddress => 'Business Park, Suite 220\nAmman, Jordan';

  @override
  String get profileNotificationPreferences => 'Notification Preferences';

  @override
  String get profileOrderStatusUpdates => 'Order Status Updates';

  @override
  String get profileOrderStatusSubtitle =>
      'Push notifications and SMS for your active orders';

  @override
  String get profileLoyaltyRewards => 'Loyalty & Rewards';

  @override
  String get profileLoyaltySubtitle =>
      'Monthly statement of points and tier bonuses';

  @override
  String get profileMarketingOffers => 'Marketing & Offers';

  @override
  String get profileMarketingSubtitle =>
      'Exclusive discounts and seasonal menu announcements';

  @override
  String get profileLogout => 'Logout';

  @override
  String get profileDeactivateAccount => 'Deactivate Account';

  @override
  String get settingsPersonalSubtitle =>
      'View your profile photo, name, contact details, and notification preferences.';

  @override
  String get settingsEmployeeSince => 'Team member since June 2022';

  @override
  String get settingsStaffDisplayName => 'Omar Hassan';

  @override
  String get settingsStaffPhoneValue => '+962 7 9000 1122';

  @override
  String get settingsStaffEmailValue => 'omar.hassan@ayletna.com';

  @override
  String get settingsStaffShiftAlerts => 'Shift & task alerts';

  @override
  String get settingsStaffShiftAlertsSubtitle =>
      'Kitchen, delivery, inventory, and attendance reminders.';

  @override
  String get settingsStaffOrderAlertsSubtitle =>
      'Order updates relevant to your station or route.';

  @override
  String get settingsBusinessSettingsHint =>
      'Restaurant operations, roles, taxes, receipts, and system alerts.';

  @override
  String get drawerBusinessSettings => 'Business settings';

  @override
  String get addressesTitle => 'Saved Addresses';

  @override
  String get addressesAddNew => 'Add New Address';

  @override
  String get addressesEmptyMessage =>
      'No saved addresses yet. Add one for faster delivery checkout.';

  @override
  String get addressesDelete => 'Delete';

  @override
  String get addressesDefault => 'Default';

  @override
  String get addressesHomeTitle => 'Home';

  @override
  String get addressesHomeBody =>
      '124 Maple Avenue, Apt 4B, Silver Springs, MD 20910';

  @override
  String get addressesOfficeTitle => 'Office';

  @override
  String get addressesOfficeBody =>
      'Ayletna HQ, 888 Innovation Way, Suite 200, Amman';

  @override
  String get addressesGymTitle => 'Gym';

  @override
  String get addressesGymBody =>
      'Iron Peak Fitness Center, 45 Strength Blvd, Amman';

  @override
  String get addressesHelper =>
      'Easily manage your frequent delivery spots for faster checkout.';

  @override
  String get mapAddressTitle => 'Save address as';

  @override
  String get mapAddressTitleHint => 'Home, Office, Family house...';

  @override
  String get mapAddressText => 'Written address';

  @override
  String get mapAddressTextHint =>
      'Building, street, floor, nearby landmark...';

  @override
  String get mapSelectOnMap => 'Choose location from map';

  @override
  String get mapLocationSelected => 'Location selected from map';

  @override
  String get mapSaveAddress => 'Save address';

  @override
  String get mapRequiredFields =>
      'Choose a map location and write the address before saving.';

  @override
  String get notificationsTitle => 'Notifications';

  @override
  String get notificationsSubtitle =>
      'Stay updated with your latest kitchen and delivery activities.';

  @override
  String get notificationsClearAll => 'Clear All';

  @override
  String get notificationsPreferences => 'Preferences';

  @override
  String get notificationsCategories => 'Categories';

  @override
  String get notificationsAll => 'All';

  @override
  String get notificationsOrderUpdates => 'Order Updates';

  @override
  String get notificationsSustainability => 'Sustainability';

  @override
  String get notificationsAdminStaff => 'Admin/Staff';

  @override
  String get notificationsWeeklyReport => 'Weekly Report';

  @override
  String get notificationsWeeklySubtitle =>
      'Sustainability goals reached 92% this week!';

  @override
  String get notificationsViewDetails => 'View details';

  @override
  String get notificationsRecentAlerts => 'Recent Alerts';

  @override
  String get notificationsYesterday => 'Yesterday';

  @override
  String get notificationsDeliveryTitle => 'Order #8829 is out for delivery';

  @override
  String get notificationsDeliveryBody =>
      'Driver Ahmad has picked up the order and is heading to the destination.';

  @override
  String get notificationsTwoMins => '2 mins ago';

  @override
  String get notificationsTrackMap => 'Track Map';

  @override
  String get notificationsContactDriver => 'Contact Driver';

  @override
  String get notificationsTipTitle => 'Tip distribution ready';

  @override
  String get notificationsTipBody =>
      'The tip pool for the morning shift has been calculated and is ready for distribution.';

  @override
  String get notificationsFifteenMins => '15 mins ago';

  @override
  String get notificationsDistributeNow => 'Distribute Now';

  @override
  String get notificationsReviewBreakdown => 'Review Breakdown';

  @override
  String get notificationsTrayTitle => 'Tray collection reminder';

  @override
  String get notificationsTrayBody =>
      'Sustainability alert: 12 reusable trays are currently unreturned at Block B collection points.';

  @override
  String get notificationsFortyFiveMins => '45 mins ago';

  @override
  String get notificationsPingStaff => 'Ping Collection Staff';

  @override
  String get notificationsStockTitle => 'Stock alert: Premium Espresso Beans';

  @override
  String get notificationsStockBody =>
      'Inventory level dropped below the 15% threshold. Consider restocking soon to avoid service interruption.';

  @override
  String get notificationsOneHour => '1 hour ago';

  @override
  String get notificationsOrderMore => 'Order More';

  @override
  String get notificationsIgnoreNow => 'Ignore for now';

  @override
  String get notificationsPickupTitle => 'Order #7741 is ready for pickup';

  @override
  String get notificationsPickupBody =>
      'The plated meal is now on the heat rack at Station 3.';

  @override
  String get notificationsThreeHours => '3 hours ago';

  @override
  String get notificationsViewTicket => 'View Ticket';

  @override
  String get notificationsPolicyTitle => 'New Policy Update';

  @override
  String get notificationsPolicyBody =>
      'The sanitation guidelines have been updated. Please review the new checklist in the staff portal.';

  @override
  String get notificationsTwentyFourHours => '24 hours ago';

  @override
  String get notificationsAlertsNav => 'Alerts';

  @override
  String get orderConfirmedThanks => 'Thank You';

  @override
  String get orderConfirmedSuccess =>
      'Your order has been placed successfully.';

  @override
  String get orderConfirmedNumberLabel => 'Order Number';

  @override
  String get orderConfirmedNumber => '#CL-8829';

  @override
  String get orderConfirmedTypeLabel => 'Order Type';

  @override
  String get orderConfirmedType => 'Plated Delivery';

  @override
  String get orderConfirmedArrivalLabel => 'Estimated Arrival';

  @override
  String get orderConfirmedArrival => '12:45 PM - 1:15 PM';

  @override
  String get orderConfirmedAddressLabel => 'Delivery Address';

  @override
  String get orderConfirmedAddress => '221B Baker St, Amman';

  @override
  String get orderConfirmedTrack => 'Track Order';

  @override
  String get orderConfirmedHome => 'Back to Home';

  @override
  String get orderConfirmedEmailSent =>
      'A confirmation email has been sent to your inbox.';

  @override
  String get otpTitle => 'OTP Verification';

  @override
  String otpSentCode(String phone) {
    return 'We sent a 6-digit code to $phone';
  }

  @override
  String get otpMaskedPhone => '+962 XXX XXXX';

  @override
  String otpResendIn(String time) {
    return 'Resend code in $time';
  }

  @override
  String get otpCountdown => '00:56';

  @override
  String get otpResendCode => 'Resend code';

  @override
  String get otpResendLimitReached =>
      'Resend limit reached. Please try again later.';

  @override
  String get otpSecurityNote =>
      'Ayletna uses bank-grade encryption to protect your account security.';

  @override
  String get ownerDashboardTitle => 'Executive Performance';

  @override
  String get ownerDashboardSubtitle =>
      'Real-time financial health and profit analysis for June 2024.';

  @override
  String get ownerLast30Days => 'Last 30 Days';

  @override
  String get ownerExportPdf => 'Export PDF';

  @override
  String get ownerTotalRevenue => 'Total Revenue';

  @override
  String get ownerRevenueDelta => '+12.5% from last month';

  @override
  String get ownerNetProfit => 'Net Profit';

  @override
  String get ownerProfitDelta => '+5.2% yield';

  @override
  String get ownerSharedTips => 'Shared Tips';

  @override
  String get ownerTipsStatus => 'Awaiting weekly distribution';

  @override
  String get ownerPendingDeposits => 'Pending Deposits';

  @override
  String get ownerDepositStatus => 'Estimated settlement: 48h';

  @override
  String get ownerWeeklyRevenueGrowth => 'Weekly Revenue Growth';

  @override
  String get ownerRevenueLegend => 'Revenue';

  @override
  String get ownerProjectedLegend => 'Projected';

  @override
  String get ownerProfitAllocation => 'Profit Allocation';

  @override
  String get ownerProfitAllocationBody =>
      'Calculated based on the 50/50 Owner-Operator agreement.';

  @override
  String get ownerSplitRatio => 'Split Ratio';

  @override
  String get ownerOperatorShare => 'Operator\'s Share';

  @override
  String get ownerExpensesBody =>
      'Consolidated monthly overhead including COGS, utilities, and labor. Internal recipes and unit costs are restricted for privacy.';

  @override
  String get ownerConsolidatedTotal => 'Consolidated Total';

  @override
  String get ownerRequestAudit => 'Request Detailed Audit';

  @override
  String get ownerRecentTransactions => 'Recent Large Transactions';

  @override
  String get ownerViewAllActivity => 'View All Activity';

  @override
  String get ownerMonthlyRent => 'Monthly Rent Settlement';

  @override
  String get ownerMonthlyRentMeta =>
      'June 05, 2024 • Transaction ID: #TXN-9021';

  @override
  String get ownerCateringEvent => 'Catering Event: Al-Mansour Corp';

  @override
  String get ownerCateringEventMeta =>
      'June 02, 2024 • Transaction ID: #TXN-8842';

  @override
  String get ownerCompleted => 'Completed';

  @override
  String get ownerCleared => 'Cleared';

  @override
  String get ownerFinanceNav => 'Finance';

  @override
  String get ownerMon => 'Mon';

  @override
  String get ownerTue => 'Tue';

  @override
  String get ownerWed => 'Wed';

  @override
  String get ownerThu => 'Thu';

  @override
  String get ownerFri => 'Fri';

  @override
  String get ownerSat => 'Sat';

  @override
  String get ownerSun => 'Sun';

  @override
  String get ownerPrivacyHeader => 'Owner View Permissions';

  @override
  String get ownerPrivacyBody =>
      'Configure exactly what information the property owner can see in their dashboard. Maintain operational privacy while ensuring transparency on key business metrics.';

  @override
  String get ownerPrivacyHero => 'Enterprise Security Controls';

  @override
  String get ownerHideRawCosts => 'Hide Raw Material Costs';

  @override
  String get ownerHideRawCostsBody =>
      'Mask individual item costs in the inventory and procurement reports. Owner will see aggregated totals only.';

  @override
  String get ownerHideStaffSalaries => 'Hide Specific Staff Salaries';

  @override
  String get ownerHideStaffSalariesBody =>
      'Restrict visibility of granular payroll data. Individual salary breakdowns will be hidden from the owner\'s view.';

  @override
  String get ownerShowOnlyNetProfit => 'Show Only Net Profit';

  @override
  String get ownerShowOnlyNetProfitBody =>
      'When enabled, the owner dashboard will suppress all gross revenue and operational expense breakdowns, presenting only the final Net Profit figure for the period.';

  @override
  String get ownerLivePreview => 'Live Preview: Owner Perspective';

  @override
  String get ownerGrossRevenue => 'Gross Revenue';

  @override
  String get ownerOperatingCosts => 'Operating Costs';

  @override
  String get ownerNetProfitLabel => 'Net Profit';

  @override
  String get ownerPreviewNote =>
      'Data above reflects the current visibility settings applied to the Owner dashboard.';

  @override
  String get ownerDiscardChanges => 'Discard Changes';

  @override
  String get ownerSaveConfigurations => 'Save Configurations';

  @override
  String get ownerAdminMode => 'Admin Mode';

  @override
  String get ownerFinancesNav => 'Finances';

  @override
  String get ownerProfileNav => 'Profile';

  @override
  String get paymentCheckoutTitle => 'Checkout';

  @override
  String get paymentCheckoutSubtitle =>
      'Choose your preferred payment method to complete the order.';

  @override
  String get paymentTotalAmountDue => 'Total Amount Due';

  @override
  String get paymentSecureTransaction => 'Secure encrypted transaction';

  @override
  String get paymentOrderReference => 'Order Reference';

  @override
  String get paymentMethodsTitle => 'Payment Methods';

  @override
  String get paymentWalletBalance => 'Wallet Balance';

  @override
  String paymentAvailableAmount(Object amount) {
    return 'Available: $amount';
  }

  @override
  String get paymentCardTitle => 'Credit / Debit Card';

  @override
  String get paymentCardSubtitle => 'Visa ending in •••• 4242';

  @override
  String get paymentApplePay => 'Apple Pay';

  @override
  String get paymentFastSecure => 'Fast & Secure';

  @override
  String get paymentCashOnDelivery => 'Cash on Delivery';

  @override
  String get paymentPayWhenReceive => 'Pay when you receive';

  @override
  String get paymentAddNewMethod => 'Add New Payment Method';

  @override
  String get paymentTotalAmount => 'Total Amount';

  @override
  String get paymentPayNow => 'Pay Now';

  @override
  String paymentPayNowAmount(Object amount) {
    return 'Pay Now | $amount';
  }

  @override
  String get platedHowBadge => 'Plated Delivery';

  @override
  String get platedHowTitle => 'Sustainable Dining, Redefined.';

  @override
  String get platedHowSubtitle =>
      'Enjoy your favorite restaurant meals on real ceramic plates, delivered to your door and collected when you\'re done.';

  @override
  String get platedHowItWorks => 'How It Works';

  @override
  String get platedStepOrderTitle => '1. Order Plated';

  @override
  String get platedStepOrderBody =>
      'Select the Plated option at checkout for participating local restaurants.';

  @override
  String get platedStepEnjoyTitle => '2. Enjoy Meal';

  @override
  String get platedStepEnjoyBody =>
      'No soggy paper boxes. Experience the true taste of your meal on high-quality ceramic.';

  @override
  String get platedStepPickupTitle => '3. We Pick Up';

  @override
  String get platedStepPickupBody =>
      'Leave the tray at your door. We\'ll collect, professionally sanitize, and reuse it.';

  @override
  String get platedBondTitle => 'The Sustainable Bond';

  @override
  String get platedBondBody =>
      'To maintain our high-quality ceramic tray library, a refundable deposit is required for every Plated order. This ensures the loop remains closed and sustainable.';

  @override
  String get platedDepositAmount => '5 JOD';

  @override
  String get platedFullyRefundable => 'Fully Refundable';

  @override
  String get platedWhyChoose => 'Why Choose Sustainable?';

  @override
  String get platedWay => 'The Plated Way';

  @override
  String get platedTraditionalDelivery => 'Traditional Delivery';

  @override
  String get platedZeroWaste => 'Zero Single-use Waste';

  @override
  String get platedPlasticWaste => 'Plastic & Cardboard Waste';

  @override
  String get platedRetainsHeat => 'Retains Heat Better';

  @override
  String get platedLosesHeat => 'Loses Heat Quickly';

  @override
  String get platedElevatedExperience => 'Elevated Experience';

  @override
  String get platedEatingBox => 'Eating from a Box';

  @override
  String get platedReadyPrompt => 'Ready to join the movement?';

  @override
  String get platedChooseSustainable => 'Choose Sustainable';

  @override
  String get platedLearnSanitation =>
      'Learn more about our sanitation standards';

  @override
  String get platedPickupsTitle => 'Scheduled Pickups';

  @override
  String get platedPickupsSubtitle => '4 remaining tasks for Plated logistics';

  @override
  String get platedPickupOverdue => '15m Overdue';

  @override
  String get platedPickupIn20 => 'In 20m';

  @override
  String get platedPickupScheduled => 'Scheduled: 14:30';

  @override
  String get platedReturnItems => 'Return Items';

  @override
  String get platedReturnItemsLarge => '1x Large Tray, 4x Plates';

  @override
  String get platedReturnItemsMedium => '2x Medium Boxes, 8x Utensil Sets';

  @override
  String get platedReturnItemsTrays => '4x Large Trays';

  @override
  String get platedOpenMaps => 'Open in Maps';

  @override
  String get platedConfirmCollection => 'Confirm Collection';

  @override
  String get platedSustainableReturns => 'Sustainable Returns';

  @override
  String get platedWasteReduced =>
      'Your work reduces waste by 4.2kg per pickup today.';

  @override
  String get platedCustomerEleanor => 'Eleanor Shellstrop';

  @override
  String get platedAddressEleanor => '742 Evergreen Terrace, Springfield';

  @override
  String get platedCustomerTahani => 'Tahani Al-Jamil';

  @override
  String get platedAddressTahani => '1200 Luxury Lane, Bel Air';

  @override
  String get platedCustomerChidi => 'Chidi Anagonye';

  @override
  String get platedAddressChidi => 'Philosophy Dept, University Row';

  @override
  String get platesSearchHint => 'Search catalog...';

  @override
  String get platesTotalInventoryValue => 'Total Inventory Value';

  @override
  String get platesValueDelta => '+2.4%';

  @override
  String get platesBreakageComparison => 'vs last month breakage';

  @override
  String get platesTotalCirculation => 'Total In Circulation';

  @override
  String get platesUnits => 'Units';

  @override
  String get platesReplacementsPending => 'Replacements Pending';

  @override
  String get platesItems => 'Items';

  @override
  String get platesOrderRestock => 'Order Restock';

  @override
  String get platesCatalogTitle => 'Ceramic Tray Catalog';

  @override
  String get platesNewComponent => 'New Component';

  @override
  String get platesFilter => 'Filter';

  @override
  String get platesLargeTray => 'Large Serving Tray';

  @override
  String get platesLargeTraySku => 'SKU: CRT-102-L';

  @override
  String get platesCeramicBowl => 'Ceramic Bowl';

  @override
  String get platesCeramicBowlSku => 'SKU: CRT-205-M';

  @override
  String get platesMezzePlate => 'Mezze Plate';

  @override
  String get platesMezzePlateSku => 'SKU: CRT-089-S';

  @override
  String get platesPerUnit => 'Per Unit';

  @override
  String platesReplacementCost(Object amount) {
    return 'Repl. Cost: $amount';
  }

  @override
  String get platesDetails => 'Details';

  @override
  String get platesRecentBreakage => 'Recent Breakage Reports';

  @override
  String get platesBowlBreakage => 'Ceramic Bowl - 4 Units Broken';

  @override
  String get platesBowlBreakageMeta =>
      'Station: Dishwashing Area • Reported by Sarah M.';

  @override
  String get platesMezzeBreakage => 'Mezze Plate - 2 Units Broken';

  @override
  String get platesMezzeBreakageMeta => 'Station: Dining Room • Floor Incident';

  @override
  String get platesTodayTime => 'Today, 2:45 PM';

  @override
  String get platesYesterdayTime => 'Yesterday, 9:12 PM';

  @override
  String get platesViewBreakageLog => 'View Full Breakage Log';

  @override
  String get platesRestockAlert => 'Restock Alert';

  @override
  String get platesRestockBody =>
      'Large Serving Trays are currently below the safety threshold (50 units).';

  @override
  String get platesAutoRestockLevel => 'Auto-Restock Level';

  @override
  String get platesEnabled => 'Enabled';

  @override
  String platesUnitsProgress(int current, int total) {
    return '$current/$total units';
  }

  @override
  String get platesOrderNow => 'Order Now';

  @override
  String get productMansafTitle => 'Traditional Lamb Mansaf';

  @override
  String get productMansafDescription =>
      'The national dish of Jordan. Tender chunks of local lamb cooked in a rich, tangy sauce of fermented dried yogurt (Jameed), served on a bed of aromatic turmeric rice and thin shrak bread. Garnished with golden fried nuts and fresh parsley for a perfect crunch and zest.';

  @override
  String get productRating => '4.9 (120+ reviews)';

  @override
  String get productPrepTime => 'Prep time: 45-60 mins';

  @override
  String get productInclVat => 'Incl. VAT';

  @override
  String get productBestSeller => 'Best Seller';

  @override
  String get productLoyaltyOrderAddon => 'Order add-on';

  @override
  String get productChooseYourSide => 'Choose Your Side';

  @override
  String get productAddExtras => 'Add Extras';

  @override
  String get productSizePortion => 'Size Portion';

  @override
  String get productRequired => 'Required';

  @override
  String get productSinglePlatter => 'Single Platter';

  @override
  String get productFamilySize => 'Family Size (4-5 persons)';

  @override
  String get productAddonsPreferences => 'Add-ons & Preferences';

  @override
  String get productExtraJameed => 'Extra Jameed Sauce';

  @override
  String get productExtraAlmonds => 'Extra Roasted Almonds';

  @override
  String get productNoPineNuts => 'No Pine Nuts (Allergy)';

  @override
  String get productFree => 'Free';

  @override
  String get productSpecialInstructions => 'Special Instructions';

  @override
  String get productInstructionsHint => 'Any allergies or specific requests?';

  @override
  String productAddToCartAmount(Object amount) {
    return 'Add to Cart | $amount';
  }

  @override
  String get previewProductTitle => 'The Executive Artisanal Platter';

  @override
  String get previewPrice => '12.50 JOD';

  @override
  String get previewTaxIncluded => 'Tax incl.';

  @override
  String get previewProductBody =>
      'A curated selection of farm-to-table ingredients including organic poached eggs, hand-crafted sourdough, Hass avocado, and wild arugula. Perfect for high-focus operational fuel.';

  @override
  String get previewPreferredBase => 'Preferred Base';

  @override
  String get previewToastedSourdough => 'Toasted Sourdough';

  @override
  String get previewMultigrainToast => 'Multigrain Toast';

  @override
  String get previewAddOns => 'Add-ons';

  @override
  String get previewExtraSmokedSalmon => 'Extra Smoked Salmon';

  @override
  String get previewDoubleAvocado => 'Double Avocado Portion';

  @override
  String get previewSalmonPrice => '+3.50 JOD';

  @override
  String get previewAvocadoPrice => '+1.20 JOD';

  @override
  String get previewDietaryNotes => 'Dietary Notes';

  @override
  String get previewDietaryMessage =>
      'Please login to specify allergies or special preparation requests.';

  @override
  String get previewLoginAddCart => 'Login to Add to Cart';

  @override
  String get previewNewToApp => 'New to Ayletna?';

  @override
  String get previewCreateAccount => 'Create an account';

  @override
  String get registerJoinTitle => 'Join Ayletna';

  @override
  String get registerJoinSubtitle =>
      'Create your account to start managing your culinary experience.';

  @override
  String get registerFullName => 'Full Name';

  @override
  String get registerNameHint => 'John Doe';

  @override
  String get registerPhoneNumber => 'Phone Number';

  @override
  String get registerPhoneHint => '+962 7 0000 0000';

  @override
  String get registerEmailAddress => 'Email Address';

  @override
  String get registerEmailHint => 'john@example.com';

  @override
  String get registerConfirmPassword => 'Confirm Password';

  @override
  String get registerAgreePrefix => 'I agree to the';

  @override
  String get registerTermsService => 'Terms of Service';

  @override
  String get registerPrivacyPolicy => 'Privacy Policy';

  @override
  String get registerAnd => 'and';

  @override
  String get registerOr => 'OR';

  @override
  String get registerAlreadyAccount => 'Already have an account?';

  @override
  String get registerLogin => 'Login';

  @override
  String get registerStepTwoTitle => 'Step 2 of 3';

  @override
  String get registerVerifyNumberTitle => 'Verify your number';

  @override
  String registerSixDigitSent(String phone) {
    return 'We\'ve sent a 6-digit code to $phone';
  }

  @override
  String get registerMaskedPhone => '+962 7•• ••89';

  @override
  String get registerDidntReceive => 'Didn\'t receive the code?';

  @override
  String get registerResendCountdown => 'Resend in 00:57';

  @override
  String get registerVerifyContinue => 'Verify & Continue';

  @override
  String get registerStepTwoLabel => 'Step 2: Phone Verification';

  @override
  String get registerStepThreeTitle => 'Step 3 of 3';

  @override
  String get registerPreferencesTitle => 'Your food preferences';

  @override
  String get registerPreferencesSubtitle =>
      'Tell us what you enjoy so Ayletna can recommend meals that feel made for you.';

  @override
  String get registerPrimaryRole => 'Your Ayletna experience';

  @override
  String get registerRoleCustomer => 'Customer';

  @override
  String get registerRoleCustomerBody =>
      'Order delicious meals, track delivery, and manage your favorites.';

  @override
  String get registerRoleStaff => 'Restaurant Staff';

  @override
  String get registerRoleStaffBody =>
      'Access KDS, manage inventory, and process active orders.';

  @override
  String get registerRoleOperator => 'Restaurant Operator';

  @override
  String get registerRoleOperatorBody =>
      'Run daily operations — orders, menu, staff, and financial close. Requires app admin approval.';

  @override
  String get registerRoleOwner => 'Restaurant Owner';

  @override
  String get registerRoleOwnerBody =>
      'View revenue, profit share, and audit summaries. Requires app admin approval.';

  @override
  String get registerRoleAdminOwner => 'Admin / Owner';

  @override
  String get registerRoleAdminOwnerBody =>
      'View deep analytics, manage staff, and optimize store sustainability.';

  @override
  String get registerDietaryPreferences => 'Dietary Preferences';

  @override
  String get registerDietVegetarian => 'Vegetarian';

  @override
  String get registerDietHalal => 'Halal';

  @override
  String get registerDietGlutenFree => 'Gluten-Free';

  @override
  String get registerCompleteProfile => 'Complete Profile';

  @override
  String get registerSetupProgress => 'Setup Progress';

  @override
  String get registerSetupPercent => '100%';

  @override
  String get reportsBreadcrumb => 'Dashboard / Reports Center';

  @override
  String get reportsCenterTitle => 'Reports & Analytics';

  @override
  String get reportsCenterSubtitle =>
      'Review your daily performance and download detailed documentation.';

  @override
  String get reportsDaily => 'Daily';

  @override
  String get reportsWeekly => 'Weekly';

  @override
  String get reportsMonthly => 'Monthly';

  @override
  String get reportsDailySales => 'Daily Sales';

  @override
  String get reportsDailySalesAmount => 'JOD 4,280.50';

  @override
  String get reportsSalesDelta => '+12.4% vs yesterday';

  @override
  String get reportsTipTotals => 'Tip Totals';

  @override
  String get reportsTipTotalAmount => 'JOD 312.00';

  @override
  String get reportsTipDistributed => 'Distributed to 14 staff members';

  @override
  String get reportsBreakageCosts => 'Breakage Costs';

  @override
  String get reportsBreakageAmount => 'JOD 45.25';

  @override
  String get reportsBreakageItems => '3 items recorded today';

  @override
  String get reportsDetailedReports => 'Detailed Reports';

  @override
  String get reportsSalesRevenue => 'Sales & Revenue';

  @override
  String get reportsSalesRevenueBody =>
      'Complete breakdown of transactions, tax, and tender types.';

  @override
  String get reportsStaffTips => 'Staff Hours & Tips';

  @override
  String get reportsStaffTipsBody =>
      'Timesheets, overtime alerts, and tip distribution logs.';

  @override
  String get reportsInventoryWastage => 'Inventory & Wastage';

  @override
  String get reportsInventoryWastageBody =>
      'Stock levels, shrinkage reports, and food waste analysis.';

  @override
  String get reportsSustainability => 'Sustainability (Tray Returns)';

  @override
  String get reportsSustainabilityBody =>
      'Tray return rates, reusable utensil tracking, and green initiatives.';

  @override
  String get reportsDownloadPdf => 'Download PDF';

  @override
  String get reportsExportCsv => 'Export CSV';

  @override
  String get reportsRevenueTrend => 'Revenue Trend';

  @override
  String get reportsLast24Hours => 'Last 24 Hours';

  @override
  String get reportsNavHome => 'Home';

  @override
  String get reportsNavReports => 'Reports';

  @override
  String get reportsNavStock => 'Stock';

  @override
  String get reportsNavProfile => 'Profile';

  @override
  String get rewardsCatalogTitle => 'Rewards Catalog';

  @override
  String get rewardsYourBalance => 'YOUR BALANCE';

  @override
  String get rewardsPointsValue => '4,850';

  @override
  String get rewardsSavorPoints => 'Savor Points';

  @override
  String get rewardsMemberSince => 'Member Since 2023';

  @override
  String get guestRewardsPreviewBody =>
      'Browse rewards now. Create an account before checkout to keep every point you earn.';

  @override
  String get guestRewardsPreviewAction => 'Create account to earn points';

  @override
  String get rewardsSearchHint => 'Search rewards...';

  @override
  String get rewardsAllItems => 'All Items';

  @override
  String get rewardsDrinks => 'Drinks';

  @override
  String get rewardsSides => 'Sides';

  @override
  String get rewardsMainCourse => 'Main Course';

  @override
  String get rewardsFeaturedReward => 'FEATURED REWARD';

  @override
  String get rewardsSignatureBurger => 'Signature Wagyu Burger';

  @override
  String get rewardsSignatureBurgerBody =>
      'Redeem for a full dining experience';

  @override
  String get rewardsPointsShort => 'PTS';

  @override
  String get rewardsNitroColdBrew => 'Nitro Cold Brew';

  @override
  String get rewardsTruffleParmFries => 'Truffle Parm Fries';

  @override
  String get rewardsBerryPowerBowl => 'Berry Power Bowl';

  @override
  String get rewardsDonutSelection => 'Donut Selection';

  @override
  String get rewardsSoldOut => 'Sold Out';

  @override
  String get rewardsSideBadge => 'SIDE';

  @override
  String get rewardsMainBadge => 'MAIN';

  @override
  String get rewardsOrdersNav => 'Orders';

  @override
  String get rewardsPosNav => 'POS';

  @override
  String get rewardsRewardsNav => 'Rewards';

  @override
  String get rewardsDeliveryNav => 'Delivery';

  @override
  String get rewardsAdminNav => 'Admin';

  @override
  String get roleSelectionMockTitle => 'Choose your role';

  @override
  String get roleSelectionWelcome => 'Select Your Portal';

  @override
  String get roleSelectionSubtitle =>
      'Choose your role to access specialized tools and services.';

  @override
  String get roleSelectionCustomerTitle => 'Customer';

  @override
  String get roleSelectionCustomerBody =>
      'Browse our menu, place orders for dine-in or takeaway, and track your loyalty rewards in real-time.';

  @override
  String get roleSelectionMockCustomerMetric => 'Customer storefront';

  @override
  String get roleSelectionCustomerChipMenu => 'Menu';

  @override
  String get roleSelectionCustomerChipReservations => 'Reservations';

  @override
  String get roleSelectionOwnerTitle => 'Owner';

  @override
  String get roleSelectionOwnerBody =>
      'Strategic overview of revenue, waste analytics, and multi-location growth metrics.';

  @override
  String get roleSelectionOwnerMetric => 'Daily Revenue: +12%';

  @override
  String get roleSelectionCashierTitle => 'Cashier';

  @override
  String get roleSelectionCashierBody =>
      'Front-of-house operations, rapid checkout, and guest table management.';

  @override
  String get roleSelectionOpenRegister => 'Open Register';

  @override
  String get roleSelectionKitchenTitle => 'Kitchen Staff';

  @override
  String get roleSelectionKitchenBody =>
      'KDS tile management, order prioritization, and ingredient stock alerts.';

  @override
  String get roleSelectionAdminMetric => 'System Health: 100%';

  @override
  String get roleSelectionOperatorMetric => '8 Active Orders';

  @override
  String get roleSelectionSupportMetric => '2 Pending Tickets';

  @override
  String get roleSelectionMarketingMetric => '3 Active Promos';

  @override
  String get roleSelectionKitchenMetric => '12 Active Orders';

  @override
  String get roleSelectionAdminTitle => 'Admin / Operator';

  @override
  String get roleSelectionAdminBody =>
      'Manage staff permissions, inventory procurement, and system configurations.';

  @override
  String get roleSelectionSystemOnline => 'SYSTEM STATUS: ONLINE';

  @override
  String get roleSelectionInventoryTitle => 'Inventory';

  @override
  String get roleSelectionInventoryBody =>
      'Review stock levels, wastage logs, ingredient details, and adjustment screens.';

  @override
  String get roleSelectionOpenInventory => 'Open Inventory';

  @override
  String get roleSelectionStaffTitle => 'Staff';

  @override
  String get roleSelectionStaffBody =>
      'Audit attendance, daily tips, and staff tip history screens.';

  @override
  String get roleSelectionOpenAttendance => 'Open Attendance';

  @override
  String get roleSelectionDeliveryTitle => 'Delivery Agent';

  @override
  String get roleSelectionDeliveryBody =>
      'Route optimization, order pickup confirmation, and digital proof-of-delivery.';

  @override
  String get roleSelectionStartShift => 'Start Shift';

  @override
  String get roleSelectionFooter =>
      'Select a workspace to continue. Permissions are assigned by your administrator.';

  @override
  String get orderTypeTitle => 'How would you like to savor?';

  @override
  String get orderTypeSubtitle =>
      'Choose your dining experience to view the appropriate menu.';

  @override
  String get orderTypeDineInBody =>
      'Reserve your spot and enjoy the full restaurant ambiance with table service.';

  @override
  String get orderTypeDineInAction => 'Select Table';

  @override
  String get orderTypeTakeawayBody =>
      'Order ahead and pick up your meal at the designated counter. Fast & convenient.';

  @override
  String get orderTypeTakeawayAction => 'Select Pickup';

  @override
  String get orderTypeDeliveryTitle => 'Standard Delivery';

  @override
  String get orderTypeDeliveryBody =>
      'Reliable delivery to your doorstep. Hot and fresh meals within 30-45 minutes.';

  @override
  String get orderTypeDeliveryAction => 'Set Address';

  @override
  String get orderTypePlatedTitle => 'Plated Delivery';

  @override
  String get orderTypePlatedBadge => 'Sustainability';

  @override
  String get orderTypePlatedBody =>
      'Premium experience using reusable ceramic plating. We pick up the dishes later.';

  @override
  String get orderTypePlatedAction => 'Select Premium';

  @override
  String get orderTypeNearbyCount => '15 people are currently ordering nearby';

  @override
  String get orderTypeGroupOrder => 'Group Order';

  @override
  String get orderTypeTerms => 'Terms of Service';

  @override
  String get termsHeroTitle => 'Order Terms & Conditions';

  @override
  String get termsHeroSubtitle =>
      'Review the checkout rules before placing an order.';

  @override
  String get termsPaymentTitle => 'Payment and confirmation';

  @override
  String get termsPaymentBody =>
      'Orders are confirmed after choosing a fulfillment method and completing payment. Fees may vary by service type and address.';

  @override
  String get termsGroupDeliveryTitle => 'Group delivery';

  @override
  String get termsGroupDeliveryBody =>
      'When group delivery is selected, the order may wait for another nearby order in the same area to reduce delivery cost and improve route efficiency.';

  @override
  String get termsChangesTitle => 'Changes and cancellation';

  @override
  String get termsChangesBody =>
      'Orders can be changed before preparation starts. Once preparation begins, some changes or cancellation may no longer be available.';

  @override
  String get orderTypeNavHome => 'Home';

  @override
  String get orderTypeNavOrders => 'Orders';

  @override
  String get orderTypeNavKitchen => 'Kitchen';

  @override
  String get orderTypeNavFinance => 'Finance';

  @override
  String get orderTypeNavMenu => 'Menu';

  @override
  String get returnFindOrder => 'Find Return Order';

  @override
  String get returnSearchHint => 'Receipt ID or Phone Number...';

  @override
  String get returnActiveDeposits => 'ACTIVE DEPOSITS';

  @override
  String get returnPendingCount => '12 Pending';

  @override
  String get returnReceipt8821 => '#REC-8821';

  @override
  String get returnReceipt7734 => '#REC-7734';

  @override
  String get returnAlexJohnson => 'Alex Johnston';

  @override
  String get returnSarahMiller => 'Sarah Miller';

  @override
  String get returnAmount25 => '25.00';

  @override
  String get returnAmount15 => '15.00';

  @override
  String get returnZeroDeduction => '-0.00';

  @override
  String get returnDeposit => 'DEPOSIT';

  @override
  String get returnProcessing => 'Processing';

  @override
  String get returnCurrentReceipt => '#REC-8821';

  @override
  String get returnOfficialDeposit => 'OFFICIAL DEPOSIT';

  @override
  String get returnCustomerLine => 'Customer: Alex Johnston • 04/10/2023';

  @override
  String get returnCheckDamage => 'Check for Damage';

  @override
  String get returnMainTray => 'Main Tray';

  @override
  String get returnPlates => 'Plates (2x)';

  @override
  String get returnCutlerySet => 'Cutlery Set';

  @override
  String get returnBrokenMissing => 'BROKEN / MISSING';

  @override
  String get returnBaseRefund => 'Base Refund';

  @override
  String get returnDamageDeductions => 'Damage Deductions';

  @override
  String get returnTotalRefund => 'Total Refund';

  @override
  String get returnRefundCash => 'Refund to Cash';

  @override
  String get returnRefundWallet => 'Refund to Wallet';

  @override
  String get returnPolicyTip => 'Policy Tip';

  @override
  String get returnPolicyTipBody =>
      'Stains on linens are not charged as damage.';

  @override
  String get returnManagerOverride => 'Manager Override';

  @override
  String get returnManagerOverrideBody => 'Scan ID to waive damage fees.';

  @override
  String get returnNavHome => 'Home';

  @override
  String get returnNavOrders => 'Orders';

  @override
  String get returnNavKitchen => 'Kitchen';

  @override
  String get returnNavFinance => 'Finance';

  @override
  String get returnNavMenu => 'Menu';

  @override
  String get returnIdentifyOrder => 'Identify Order';

  @override
  String get returnScanTrayTag => 'Scan Tray Tag or Order ID';

  @override
  String get returnDetailSearchValue => '#LJ-9928-XT';

  @override
  String get returnQrPrompt => 'Position QR code within frame for auto-scan';

  @override
  String get returnRetrieveOrderData => 'Retrieve Order Data';

  @override
  String get returnRecentSelfReturns => 'Recent Self-Returns';

  @override
  String get returnRecentP2812 => 'P2812';

  @override
  String get returnRecentProcessed2m => 'Processed 2m ago';

  @override
  String get returnRecentP9809 => 'P9809';

  @override
  String get returnRecentProcessed5m => 'Processed 5m ago';

  @override
  String get returnOrder9928 => 'Order #9928 - James Wilson';

  @override
  String get returnActiveReturn => 'ACTIVE RETURN';

  @override
  String get returnOriginalService => 'Original Service';

  @override
  String get returnDineInTable14 => 'Dine-In • Table 14';

  @override
  String get returnVerifyConditions => 'Verify Item Conditions';

  @override
  String get returnSignatureCeramicPlatter => 'Signature Ceramic Platter';

  @override
  String get returnStandardServiceTray => 'Standard Service Tray';

  @override
  String get returnPlatterDeposit => '\$10.00 Deposit';

  @override
  String get returnTrayDeposit => '\$2.00 Deposit';

  @override
  String get returnReturnedGood => 'Returned (Good)';

  @override
  String get returnDamagedLost => 'Damaged/Lost';

  @override
  String get returnSummaryCeramicPlatter => 'Ceramic Platter (Returned)';

  @override
  String get returnSummaryServiceTray => 'Service Tray (Returned)';

  @override
  String get returnSummarySustainabilityBonus => 'Sustainability Bonus';

  @override
  String get returnSummaryInstantRefund => 'Total Instant Refund';

  @override
  String get returnSummaryDestination => 'Destination: Customer Wallet';

  @override
  String get returnProcessClose => 'Process Refund & Close';

  @override
  String get returnReportIssue => 'Report Issue';

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
  String get returnRefundSummary => 'Refund Summary';

  @override
  String get splashTagline => 'Traditional Taste, Zero Waste';

  @override
  String get splashHeadline => 'Premium Levantine Cuisine';

  @override
  String get splashMotto => 'Taste. Belong. Sustain.';

  @override
  String get splashInitializing => 'WELCOME TO OUR TABLE';

  @override
  String get staffShiftInProgress => 'Shift in Progress';

  @override
  String get staffActiveNow => 'ACTIVE NOW';

  @override
  String get staffCurrentDuration => 'Current Duration';

  @override
  String get staffDurationValue => '04:22:18';

  @override
  String get staffCheckInTime => 'Check-in Time';

  @override
  String get staffCheckInValue => '08:00 AM';

  @override
  String get staffShiftRole => 'Shift Role';

  @override
  String get staffFloorLead => 'Floor Lead';

  @override
  String get staffCheckOut => 'Check-out';

  @override
  String get staffAddShiftNote => 'Add Shift Note';

  @override
  String get staffLatestOrderActivity => 'Latest Order Activity';

  @override
  String get staffLatestOrderDetail => 'Table 14 - Main Course Plated';

  @override
  String get staffNavHome => 'Home';

  @override
  String get staffNavOrders => 'Orders';

  @override
  String get staffNavKitchen => 'Kitchen';

  @override
  String get staffNavMenu => 'Menu';

  @override
  String get staffPortalTitle => 'Culinary Logic';

  @override
  String get staffCurrentShiftDuration => 'CURRENT SHIFT DURATION';

  @override
  String get staffStartedAt => 'Shift started at 08:00 AM';

  @override
  String get staffCheckOutShift => 'Check-out Shift';

  @override
  String get staffBreakTime => 'Break Time';

  @override
  String get staffSwapTask => 'Swap Task';

  @override
  String get staffCurrentFocus => 'Current Focus';

  @override
  String get staffTableService => 'Table 12 Service';

  @override
  String get staffKitchenCoordination => 'Kitchen Coordination';

  @override
  String get staffSectionZone => 'Section: Zone A';

  @override
  String get staffTotalOrdersManaged => 'Total Orders Managed: 18';

  @override
  String get staffCapacity => '75% Capacity';

  @override
  String get staffShiftPerformance => 'Shift Performance';

  @override
  String get staffTipsEarnedToday => 'TIPS EARNED TODAY';

  @override
  String get staffTipsAmount => '42.50 JOD';

  @override
  String get staffAvgServiceTime => 'Avg Service Time';

  @override
  String get staffAvgServiceValue => '12:04';

  @override
  String get staffCustomerRating => 'Customer Rating';

  @override
  String get staffRatingValue => '4.9';

  @override
  String get staffManagerNotes => 'Manager Notes';

  @override
  String get staffChefSpecialNote =>
      'Chef\'s Special: Grilled Sea Bass\nSuggest as high priority for dinner.';

  @override
  String get staffVipReservationNote =>
      'VIP Reservation at 07:30 PM\nTable 4 prepared for Mr. Al-Sayed.';

  @override
  String get staffAttendanceTitle => 'Attendance';

  @override
  String get staffCheckInDate => 'Friday, May 29';

  @override
  String get staffCheckInClock => '10:56:38';

  @override
  String get staffCheckInAction => 'Check-in';

  @override
  String get staffShiftStart => 'Shift Start';

  @override
  String get staffShiftStartValue => '08:00 AM';

  @override
  String get staffStatus => 'Status';

  @override
  String get staffLate => 'LATE';

  @override
  String get staffTodaySchedule => 'Today\'s Schedule';

  @override
  String get staffKitchenDept => 'Kitchen Dept';

  @override
  String get staffMorningPrepService => 'Morning Prep & Service';

  @override
  String get staffMorningShiftTime => '08:00 AM - 04:00 PM (8h)';

  @override
  String get staffNavAttendance => 'Attendance';

  @override
  String get staffNavProfile => 'Profile';

  @override
  String get staffOffDuty => 'CURRENTLY OFF-DUTY';

  @override
  String get staffShiftDetails => 'Shift Details';

  @override
  String get staffShiftDetailsBody =>
      'Review your scheduled session before starting.';

  @override
  String get staffRole => 'Role';

  @override
  String get staffLeadChef => 'Lead Chef';

  @override
  String get staffScheduledTime => 'Scheduled Time';

  @override
  String get staffScheduledTimeValue => '06:00 AM - 02:00 PM';

  @override
  String get staffExpectedEarnings => 'Expected Earnings';

  @override
  String get staffExpectedEarningsValue => '75.00 JOD';

  @override
  String get staffLocation => 'Location';

  @override
  String get staffMainKitchen => 'Main Kitchen';

  @override
  String get staffGpsCheckInNote =>
      'Checking in will record your GPS location and timestamp.';

  @override
  String get staffNavInventory => 'Inventory';

  @override
  String get staffNavFinances => 'Finances';

  @override
  String get staffTipsBrand => 'Ayletna Tips';

  @override
  String get staffTipsReportMeta => 'Personal Report • Today, Oct 24';

  @override
  String get staffDailyTipsSummary => 'Daily Tips Summary';

  @override
  String get staffVerifiedRevenue => 'Verified Revenue';

  @override
  String get staffTotalTipsEarned => 'Total Tips Earned (JOD)';

  @override
  String get staffDailyTipsAmount => '84.50';

  @override
  String get staffJod => 'JOD';

  @override
  String get staffTipsVsYesterday => '+12% vs Yesterday';

  @override
  String get staffTipsLastEntry => 'Last entry: 14:32';

  @override
  String get staffBreakfastShift => 'Breakfast Shift';

  @override
  String get staffBreakfastTime => '07:00 - 11:30';

  @override
  String get staffBreakfastAmount => '22.00 JOD';

  @override
  String get staffVerified => 'Verified';

  @override
  String get staffLunchRush => 'Lunch Rush';

  @override
  String get staffLunchTime => '12:00 - 16:30';

  @override
  String get staffLunchAmount => '62.50 JOD';

  @override
  String get staffEarningsPolicy => 'Earnings Policy';

  @override
  String get staffEarningsPolicyBody =>
      'Please review your daily totals. By acknowledging, you confirm the recorded tips match your shift logs. Payouts are processed every Thursday.';

  @override
  String get staffCashTips => 'Cash Tips';

  @override
  String get staffCashTipsAmount => '35.00 JOD';

  @override
  String get staffDigitalTips => 'Digital Tips';

  @override
  String get staffDigitalTipsAmount => '49.50 JOD';

  @override
  String get staffFinalTotal => 'Final Total';

  @override
  String get staffFinalTotalAmount => '84.50 JOD';

  @override
  String get staffAcknowledgeReceipt => 'Acknowledge Receipt';

  @override
  String get staffAcknowledgeNote =>
      'Acknowledgment timestamp will be recorded for audit purposes.';

  @override
  String get staffTransactionHistory => 'Transaction History';

  @override
  String get staffViewFullLog => 'View Full Log';

  @override
  String get staffTxnDelivery => 'Delivery';

  @override
  String get staffTxnDineIn => 'Dine-in';

  @override
  String get staffTxnTakeaway => 'Takeaway';

  @override
  String get staffTxnDeliveryMeta => 'Order #9822';

  @override
  String get staffTxnDineInMeta => 'Table 12 • Lunch';

  @override
  String get staffTxnTakeawayMeta => 'App Order • Pickup';

  @override
  String get staffTxnDeliveryAmount => '4.00 JOD';

  @override
  String get staffTxnDineInAmount => '12.50 JOD';

  @override
  String get staffTxnTakeawayAmount => '2.25 JOD';

  @override
  String get staffTxnDeliveryTime => '14:15';

  @override
  String get staffTxnDineInTime => '13:50';

  @override
  String get staffTxnTakeawayTime => '13:10';

  @override
  String get staffNavTips => 'Tips';

  @override
  String get staffPerformanceSummary => 'Performance Summary';

  @override
  String get staffTotalHours => 'Total Hours';

  @override
  String get staffTotalHoursValue => '124.5 hrs';

  @override
  String get staffHoursDelta => '+4.2% from last month';

  @override
  String get staffTotalTips => 'Total Tips';

  @override
  String get staffTotalTipsValue => '1,432.50 JOD';

  @override
  String get staffAvgTripRate => 'Avg 11.50/hr tip rate';

  @override
  String get staffShiftsCompleted => 'Shifts Completed';

  @override
  String get staffShiftsCompletedValue => '22';

  @override
  String get staffNoLatesPeriod => '0 lates this period';

  @override
  String get staffThisMonth => 'This Month';

  @override
  String get staffLastMonth => 'Last Month';

  @override
  String get staffCustomRange => 'Custom Range';

  @override
  String get staffThisWeek => 'This Week';

  @override
  String get staffLastWeek => 'Last Week';

  @override
  String get staffDinnerService => 'Dinner Service';

  @override
  String get staffDinnerDate => 'OCT\n24';

  @override
  String get staffDinnerTime => '16:30 - 23:15';

  @override
  String get staffDinnerHours => '6.75 hrs';

  @override
  String get staffDinnerTips => '+84.20 Tips';

  @override
  String get staffBrunchShift => 'Brunch Shift';

  @override
  String get staffBrunchDate => 'OCT\n22';

  @override
  String get staffBrunchTime => '09:00 - 15:30';

  @override
  String get staffBrunchHours => '6.5 hrs';

  @override
  String get staffBrunchTips => '+52.00 Tips';

  @override
  String get staffClosingShift => 'Closing Shift';

  @override
  String get staffClosingDate => 'OCT\n19';

  @override
  String get staffClosingTime => '17:00 - 01:30';

  @override
  String get staffClosingHours => '8.5 hrs';

  @override
  String get staffClosingTips => '+112.45 Tips';

  @override
  String get staffDoubleShift => 'Double Shift';

  @override
  String get staffDoubleDate => 'OCT\n18';

  @override
  String get staffDoubleTime => '10:00 - 22:00';

  @override
  String get staffDoubleHours => '12.0 hrs';

  @override
  String get staffDoubleTips => '+156.10 Tips';

  @override
  String get staffOvertime => 'Overtime';

  @override
  String get staffDownloadTaxStatement => 'Download Tax Statement';

  @override
  String get staffNavDashboard => 'Dashboard';

  @override
  String get staffNavHistory => 'History';

  @override
  String get staffNavSchedule => 'Schedule';

  @override
  String get staffNavPay => 'Pay';

  @override
  String get staffNavAdmin => 'Admin';

  @override
  String get sustainabilityAlertsTitle => 'Sustainability Alerts';

  @override
  String get sustainabilityAlertsSubtitle =>
      'Operational insights and ecological milestones for the Culinary Logic ecosystem. Monitor tray cycles and sustainability KPIs in real-time.';

  @override
  String get sustainabilityActiveGoal => 'Active Goal';

  @override
  String get sustainabilityGoalReached => 'Sustainability Goal: 92% reached';

  @override
  String get sustainabilityGoalBody =>
      'Target for this week: 95% plastic-free tray management.';

  @override
  String get sustainabilityCurrentProgress => 'Current Progress';

  @override
  String get sustainabilityProgressPercent => '92%';

  @override
  String get sustainabilityUrgentAction => 'Urgent Action';

  @override
  String get sustainabilityReminderTitle =>
      'Reminder:\n4 trays\npending\ncollection';

  @override
  String get sustainabilityStationB =>
      'Station B requires immediate clearance to maintain sanitation flow.';

  @override
  String get sustainabilityDispatch => 'Dispatch';

  @override
  String get sustainabilityPolicyUpdate => 'New Sanitation Policy Update';

  @override
  String get sustainabilityPolicyBody =>
      'Updated protocols for compostable tray sanitization have been implemented for Q3.';

  @override
  String get sustainabilityViewDocument => 'View Document';

  @override
  String get sustainabilityCo2Offset => '1.2 Tons';

  @override
  String get sustainabilityCo2Subtitle => 'CO2 offset YTD';

  @override
  String get sustainabilityTrayFeed => 'Real-time Tray Feed';

  @override
  String get sustainabilityInRotation => 'In Rotation';

  @override
  String get sustainabilityInRotationValue => '142';

  @override
  String get sustainabilityCleaningCycle => 'Cleaning cycle';

  @override
  String get sustainabilityCleaningCycleValue => '28';

  @override
  String get sustainabilityAverageReturn => 'Average Return';

  @override
  String get sustainabilityAverageReturnValue => '14m';

  @override
  String get takeawayBrandTitle => 'Ayletna System';

  @override
  String get takeawayChoosePickupDetails => 'Choose Pickup Details';

  @override
  String get takeawayPickupSubtitle =>
      'Select a time that works for you in Amman, Jordan.';

  @override
  String get takeawayHubName => 'Ayletna Hub - Downtown';

  @override
  String get takeawayHubAddress => 'King Abdullah II St, Amman';

  @override
  String get takeawayOpen => 'Open';

  @override
  String get takeawayAsap => 'ASAP';

  @override
  String get takeawayAsapTime => '15 - 20 mins';

  @override
  String get takeawaySchedule => 'Schedule';

  @override
  String get takeawayChooseTime => 'Choose time';

  @override
  String get takeawayAvailableSlots => 'Available Slots';

  @override
  String get takeawayCurrency => 'JOD (Jordanian Dinar)';

  @override
  String get takeawayToday => 'Today';

  @override
  String get takeawayTomorrow => 'Tomorrow';

  @override
  String get takeawayOct25 => 'Oct 25';

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
  String get takeawayFull => 'Full';

  @override
  String get takeawayPickupFee => 'Pickup Fee';

  @override
  String get takeawayPickupFeeValue => '0.000 JOD';

  @override
  String get takeawayConfirmPickupTime => 'Confirm Pickup Time';

  @override
  String get tipBrandTitle => 'Ayletna System';

  @override
  String get tipSupportTeamTitle => 'Support Our Culinary Team';

  @override
  String get tipAppreciationQuote =>
      '\"Your appreciation goes directly to the heart of the kitchen. Every tip fuels our team\'s passion for creating unforgettable flavors for you.\"';

  @override
  String get tipAddAppreciation => 'Add Appreciation';

  @override
  String get tipAddAppreciationBody => 'Show some love to the chefs and staff.';

  @override
  String get tipSmallThankYou => 'Small Thank You';

  @override
  String get tipGenerousTip => 'Generous Tip';

  @override
  String get tipCulinaryHero => 'Culinary Hero';

  @override
  String get tipCustomAmountJod => 'Custom Amount (JOD)';

  @override
  String get tipCustomAmountValue => 'JOD 0.00';

  @override
  String get tipCustomAmountBody =>
      'Enter any amount you wish to contribute to the team.';

  @override
  String get tipConfirmAppreciation => 'Confirm Appreciation';

  @override
  String get tipSkip => 'Skip';

  @override
  String get trackingBrandTitle => 'Ayletna System';

  @override
  String get trackingEstimatedArrival => 'Estimated Arrival';

  @override
  String get trackingArrivalTime => '12:45 PM';

  @override
  String get trackingOnTheWay => 'On the Way';

  @override
  String get trackingOrderNumber => 'Order #77429';

  @override
  String get trackingPremium => 'Premium';

  @override
  String get trackingFromRestaurant => 'From: Ayletna Bistro';

  @override
  String get trackingOrderReceived => 'Order Received';

  @override
  String get trackingOrderReceivedBody => 'Confirmed at 12:15 PM';

  @override
  String get trackingPreparingKitchen => 'Preparing in Kitchen';

  @override
  String get trackingPreparingBody => 'Chef is finishing your meal';

  @override
  String get trackingOnWayTitle => 'On the Way';

  @override
  String get trackingOnWayBody => 'Driver: Marcus (5 mins away)';

  @override
  String get trackingCallMarcus => 'Call driver';

  @override
  String get trackingDelivered => 'Delivered';

  @override
  String get trackingDeliveredBody => 'Estimated by 12:45 PM';

  @override
  String get trackingOrderSummary => 'Order Summary';

  @override
  String get trackingTruffleRisotto => '1x Truffle Risotto';

  @override
  String get trackingGardenSalad => '1x Garden Salad';

  @override
  String get trackingRisottoPrice => '24.00';

  @override
  String get trackingSaladPrice => '12.00';

  @override
  String get trackingTotal => 'Total';

  @override
  String get trackingTotalPrice => '36.00';

  @override
  String get trackingNeedHelp => 'Need help?';

  @override
  String get trackingHelpBody =>
      'Our support team is available 24/7 for any delivery concerns.';

  @override
  String get trackingContactSupport => 'Contact Support';

  @override
  String get trackingNoContactDelivery => 'No-Contact Delivery';

  @override
  String get trackingNoContactBody => 'Requested by customer';

  @override
  String get trackingQualityAssured => 'Quality Assured';

  @override
  String get trackingQualityBody => 'Triple checked by kitchen';

  @override
  String get trackingEcoPackaging => 'Eco Packaging';

  @override
  String get trackingEcoBody => '100% Biodegradable';

  @override
  String get userManagementTitle => 'Staff Management';

  @override
  String get userManagementSubtitle =>
      'Oversee your kitchen and front-of-house team.';

  @override
  String get userAddNewStaff => 'Add New Staff';

  @override
  String get userActiveStaff => 'Active Staff';

  @override
  String get userActiveStaffCount => '24';

  @override
  String get userRolesDefined => 'Roles Defined';

  @override
  String get userRolesDefinedCount => '8';

  @override
  String get userCurrentShift => 'Current Shift';

  @override
  String get userCurrentShiftCount => '12';

  @override
  String get userActive => 'Active';

  @override
  String get userInactive => 'Inactive';

  @override
  String get userElenaName => 'Elena Rodriguez';

  @override
  String get userElenaRole => 'Lead Chef';

  @override
  String get userElenaEmail => 'elena.r@culinarylogic.com';

  @override
  String get userElenaShift => 'Shift: Morning (6AM - 2PM)';

  @override
  String get userMarcusName => 'Marcus Chen';

  @override
  String get userMarcusRole => 'Cashier';

  @override
  String get userMarcusEmail => 'm.chen@culinarylogic.com';

  @override
  String get userMarcusShift => 'Shift: Afternoon (2PM - 10PM)';

  @override
  String get userSarahName => 'Sarah Jenkins';

  @override
  String get userSarahRole => 'Delivery Lead';

  @override
  String get userSarahEmail => 's.jenkins@culinarylogic.com';

  @override
  String get userSarahShift => 'Shift: On Leave';

  @override
  String get userDavidName => 'David Okafor';

  @override
  String get userDavidRole => 'Sous Chef';

  @override
  String get userDavidEmail => 'd.okafor@culinarylogic.com';

  @override
  String get userDavidShift => 'Shift: Evening (4PM - 12AM)';

  @override
  String get userLindaName => 'Linda Vane';

  @override
  String get userLindaRole => 'Hostess';

  @override
  String get userLindaEmail => 'linda.v@culinarylogic.com';

  @override
  String get userLindaShift => 'Shift: Dinner Rush (6PM - 11PM)';

  @override
  String get userManagePermissions => 'Manage Permissions';

  @override
  String get userInviteNewTeamMember => 'Invite New Team Member';

  @override
  String get walletBrandTitle => 'Ayletna System';

  @override
  String get walletTotalBalance => 'Total Balance';

  @override
  String get walletCurrency => 'JOD';

  @override
  String get walletBalanceAmount => '142.50';

  @override
  String get walletTopUp => 'Top Up';

  @override
  String get walletTransfer => 'Transfer';

  @override
  String get walletSavorPoints => 'Savor Points';

  @override
  String get walletGoldTier => 'Gold Tier';

  @override
  String get walletPointsAmount => '2,450';

  @override
  String get walletPointsToPlatinum => '550 pts to Platinum';

  @override
  String get walletAvailableRewards => 'Available Rewards';

  @override
  String get walletAvailableRewardsCount => '3';

  @override
  String get walletPointsValue => 'Points Value';

  @override
  String get walletPointsValueAmount => 'JOD 12.25';

  @override
  String get walletViewRewardCatalog => 'View Reward Catalog';

  @override
  String get walletRecentTransactions => 'Recent Transactions';

  @override
  String get walletTheBurgerHub => 'The Burger Hub';

  @override
  String get walletBurgerMeta => 'Today, 2:45 PM • Dine-in';

  @override
  String get walletBurgerAmount => '- JOD 12.50';

  @override
  String get walletBurgerPoints => '+ 25 pts';

  @override
  String get walletRefundTitle => 'Refund: Canceled Order';

  @override
  String get walletRefundMeta => 'Yesterday, 9:12 AM • Delivery';

  @override
  String get walletRefundAmount => '+ JOD 8.75';

  @override
  String get walletRefundCredit => 'Wallet Credit';

  @override
  String get walletTopUpTitle => 'Wallet Top-Up';

  @override
  String get walletTopUpMeta => 'Oct 24, 6:30 PM • Visa **** 4242';

  @override
  String get walletTopUpAmount => '+ JOD 50.00';

  @override
  String get walletTopUpStatus => 'Success';

  @override
  String get walletPastaPrime => 'Pasta Prime';

  @override
  String get walletPastaMeta => 'Oct 23, 1:15 PM • Takeaway';

  @override
  String get walletPastaAmount => '- JOD 14.20';

  @override
  String get walletPastaPoints => '+ 28 pts';

  @override
  String get walletFreeDrinkReward => 'Free Drink Reward';

  @override
  String get walletFreeDrinkMeta => 'Oct 22, 11:00 AM • Point Redemption';

  @override
  String get walletFreeDrinkAmount => 'JOD 0.00';

  @override
  String get walletFreeDrinkPoints => '- 500 pts';

  @override
  String get walletViewAllHistory => 'View All History';

  @override
  String get refundStep2Title => 'Step 2 of 3';

  @override
  String get refundStep2Header => 'Damage Assessment';

  @override
  String get refundStep2Body =>
      'Inspect returned items for any structural damage. Selecting \'Damaged\' will allow you to enter a deduction from the initial deposit.';

  @override
  String get refundCeramicPlate => 'Ceramic Mezze Plate';

  @override
  String get refundCeramicPlateAsset => 'Asset ID: SAV-P-442';

  @override
  String get refundWoodenTray => 'Wooden Serving Tray (Large)';

  @override
  String get refundWoodenTrayAsset => 'Asset ID: SAV-T-012';

  @override
  String get refundCoffeePot => 'Signature Coffee Pot';

  @override
  String get refundCoffeePotAsset => 'Asset ID: SAV-P-118';

  @override
  String get refundReturned => 'Returned';

  @override
  String get refundDamaged => 'Damaged';

  @override
  String get refundDepositSummary => 'Deposit Summary';

  @override
  String get refundHeldFunds => '(Held Funds)';

  @override
  String get refundDepositAmount => '15.00';

  @override
  String get refundEstimateBody =>
      'Estimated refund will update automatically based on damage deductions entered above.';

  @override
  String get refundCancelFlow => 'Cancel Flow';

  @override
  String get refundReviewRefund => 'Review Refund';

  @override
  String get refundStep3Title => 'Step 3 of 3';

  @override
  String get refundReadyForPayout => 'Ready for Payout';

  @override
  String get refundSettlementSummary => 'Settlement Summary';

  @override
  String get refundOriginalDeposit => 'Original Deposit';

  @override
  String get refundReceivedAtTable => 'Received at Table 12';

  @override
  String get refundOriginalDepositAmount => '5.00 JOD';

  @override
  String get refundBreakageFees => 'Breakage Fees';

  @override
  String get refundBreakageDetails => '1x Ceramic Plate, 1x Glass';

  @override
  String get refundBreakageAmount => '- 1.50 JOD';

  @override
  String get refundNetRefund => 'Net Refund';

  @override
  String get refundCreditingWallet => 'Crediting to Customer Wallet';

  @override
  String get refundNetRefundAmount => '3.50 JOD';

  @override
  String get refundTotalSettlement => 'Total Settlement';

  @override
  String get refundImmediateNotice =>
      'The refund will be processed immediately to the user\'s Ayletna Wallet. A digital receipt will be sent via SMS to +962 *** *** 44.';

  @override
  String get refundCustomerInfo => 'Customer Info';

  @override
  String get refundCustomerName => 'Zaid Al-Farah';

  @override
  String get refundCustomerTier => 'Gold Member';

  @override
  String get refundCurrentWallet => 'Current Wallet';

  @override
  String get refundPostRefund => 'Post-Refund';

  @override
  String get refundCurrentWalletAmount => '12.45 JOD';

  @override
  String get refundPostRefundAmount => '15.95 JOD';

  @override
  String get refundTerminalId => 'Terminal ID';

  @override
  String get refundTerminalCode => 'POS-AMM-042';

  @override
  String get refundAuthorizedCashier => 'Authorized cashier pin';

  @override
  String get refundVerifiedTransaction => 'Verified Transaction';

  @override
  String get refundConfirmProcess => 'Confirm & Process Refund';

  @override
  String get refundModifyAssessment => 'Modify Breakage Assessment';

  @override
  String get refundIdentification => 'Identification';

  @override
  String get refundAssessment => 'Assessment';

  @override
  String get refundSettlement => 'Settlement';

  @override
  String get returnStep1Title => 'Return Items';

  @override
  String get returnStep1Subtitle => 'Step 1 of 2: Checklist';

  @override
  String get returnOrder8842 => 'Order #8842';

  @override
  String get returnOrderMeta => 'Table 12 • 4 Items Expected';

  @override
  String get returnExpectedCeramicItems => 'Expected Ceramic Items';

  @override
  String get returnDeepBowls => '2x Deep Bowls';

  @override
  String get returnDeepBowlsMeta => 'Signature Series • Sage Trim';

  @override
  String get returnMainPlates => '2x Main Plates';

  @override
  String get returnMainPlatesMeta => 'Signature Series • 12-inch';

  @override
  String get returnCollected => 'Collected';

  @override
  String get returnMissing => 'Missing';

  @override
  String get returnMissingWarning =>
      'Missing items will be flagged for manager review and may incur a replacement fee for the customer.';

  @override
  String get returnContinueStep2 => 'Continue to Step 2';

  @override
  String get returnStep2Title => 'Step 2 of 2';

  @override
  String get returnConfirmation => 'Confirmation';

  @override
  String get returnVerificationComplete => 'Verification Complete';

  @override
  String get returnVerificationBody =>
      'Deposit will be credited to wallet instantly.';

  @override
  String get returnBreakageFeeAmount => '- 2.500 JOD';

  @override
  String get returnBreakageFeeBody => '2x Ceramic Bowls reported damaged';

  @override
  String get returnNetRefundAmount => '12.500 JOD';

  @override
  String get returnReadyInstantCredit => 'Ready for instant credit';

  @override
  String get returnSummaryDetails => 'Summary Details';

  @override
  String get returnOriginalDeposit => 'Original Deposit';

  @override
  String get returnOriginalDepositAmount => '15.000 JOD';

  @override
  String get returnBreakageTwoItems => 'Breakage (2 Items)';

  @override
  String get returnProcessingFee => 'Processing Fee';

  @override
  String get returnWaived => 'Waived';

  @override
  String get returnFinalRefund => 'Final Refund';

  @override
  String get returnSignToConfirm => 'Sign to Confirm';

  @override
  String get returnSignatureRequired => 'Customer signature required here';

  @override
  String get returnClearSignature => 'Clear Signature';

  @override
  String get returnFinalizeReturn => 'Finalize Return';

  @override
  String get returnFinalizeDisclaimer =>
      'By clicking Finalize Return, you confirm that all items have been inspected and the refund amount is accurate.';

  @override
  String get platedReturnBadge => 'Plated Experience';

  @override
  String get platedReturnReadyTitle => 'Ready to return?';

  @override
  String get platedReturnReadyBody =>
      'We hope you enjoyed your meal! Please let us know how you\'d like to return your ceramic plate set.';

  @override
  String get platedReturnDepositTitle => 'Refundable Deposit';

  @override
  String get platedReturnDepositBody =>
      'Your 5 JOD deposit will be credited back to your wallet instantly upon receipt of the items.';

  @override
  String get platedReturnSchedulePickup => 'Schedule Pickup';

  @override
  String get platedReturnSelfReturn => 'I\'ll return it myself';

  @override
  String get screenRatingReview => 'Rate your meal';

  @override
  String get screenRatingReviewDesc =>
      'Post-delivery rating and review screen.';

  @override
  String get ratingHeroTitle => 'How was your Ayletna meal?';

  @override
  String get ratingHeroSubtitle =>
      'Your note helps the kitchen keep every dish warm, fresh, and generous.';

  @override
  String get ratingOrderLabel => 'Order experience';

  @override
  String get ratingKitchenTitle => 'Kitchen and freshness';

  @override
  String get ratingDeliveryTitle => 'Delivery and handoff';

  @override
  String get ratingPackagingTitle => 'Packaging and plated return';

  @override
  String get ratingCommentLabel => 'Add a short note';

  @override
  String get ratingCommentHint =>
      'Tell us what tasted great or what we should improve';

  @override
  String get ratingSubmit => 'Send review';

  @override
  String get ratingSuccess =>
      'Thanks. Your review was added to your rewards profile.';

  @override
  String get ratingRewardLoop => '+50 Savor Points after review';

  @override
  String get ratingReviewLater => 'Review later';

  @override
  String get reportFilterIntro =>
      'Choose the analytics scope before reviewing sales, inventory, tips, and plate decisions.';

  @override
  String get reportFilterPeriod => 'Period';

  @override
  String get reportFilterChannel => 'Channel';

  @override
  String get reportFilterModules => 'Report modules';

  @override
  String get reportFilterSummary => 'Filter summary';

  @override
  String reportFilterModuleCount(int count) {
    return '$count modules';
  }

  @override
  String get reportFilterReset => 'Reset';

  @override
  String get reportFilterApply => 'Apply filters';

  @override
  String get reportFilterApplied => 'Report filters applied';

  @override
  String get reportFilterShift => 'Shift';

  @override
  String get reportFilterAllChannels => 'All channels';

  @override
  String get reportFilterDineIn => 'Dine-in';

  @override
  String get reportFilterTakeaway => 'Takeaway';

  @override
  String get reportFilterDelivery => 'Delivery';

  @override
  String get reportFilterPlated => 'Plated';

  @override
  String get reportFilterPlatesDeposits => 'Plates & deposits';

  @override
  String get cartCustomizationQuantity => 'Quantity';

  @override
  String get adminGrowthHubBadge => 'Admin Team & Growth Hub';

  @override
  String get adminGrowthHubHero =>
      'One place to manage team hours, owner privacy, loyalty, and offers instead of scattered weak pages.';

  @override
  String get adminGrowthHubTodayHours => 'Today hours';

  @override
  String get adminGrowthHubLoyaltyGuests => 'Loyalty guests';

  @override
  String get adminGrowthHubActiveOffers => 'Active offers';

  @override
  String get adminGrowthStaffTitle => 'Team Hours & Shifts';

  @override
  String get adminGrowthStaffSubtitle =>
      'Track coverage, hours, and tips by restaurant role.';

  @override
  String get adminGrowthKitchen => 'Kitchen';

  @override
  String get adminGrowthKitchenDetail => 'Good cover, one reminder late';

  @override
  String get adminGrowthCashier => 'Cashier';

  @override
  String get adminGrowthCashierDetail => 'Close shift needs approval';

  @override
  String get adminGrowthDelivery => 'Delivery';

  @override
  String get adminGrowthDeliveryDetail => 'Evening peak needs one more driver';

  @override
  String get adminGrowthTips => 'Tips';

  @override
  String get adminGrowthTipsDetail => 'Ready after hours approval';

  @override
  String get adminGrowthPrivacySubtitle =>
      'Owner view and finance-report visibility rules.';

  @override
  String get adminGrowthLoyaltySubtitle =>
      'Turn loyalty into repeat visits and clear food orders.';

  @override
  String get adminGrowthPointsRule => 'Points rule';

  @override
  String get adminGrowthEnableLunchMultiplier => 'Double loyalty points';

  @override
  String get adminGrowthLunchMultiplierBody =>
      'When on, customers earn 2× points on add-to-cart from product detail.';

  @override
  String get adminGrowthBirthdayDessertBody =>
      'Visible only during the guest birthday window.';

  @override
  String get adminGrowthTarget => 'Target';

  @override
  String get adminGrowthTargetBody => 'Second visit within 14 days';

  @override
  String get adminGrowthOffersSubtitle =>
      'Offers connect to inventory and margins, not generic marketing cards.';

  @override
  String get adminGrowthShawarmaOffer => 'Shawarma meal lunch offer';

  @override
  String get adminGrowthShawarmaOfferBody =>
      'Tied to lunch peak and prep capacity.';

  @override
  String get adminGrowthFamilyTrayOffer => 'Family plated bundle';

  @override
  String get adminGrowthFamilyTrayOfferBody =>
      'Requires tray availability and clear deposit rule.';

  @override
  String get adminGrowthHomeOffers => 'Home offers';

  @override
  String get adminGrowthHomeOffersBody =>
      'Shown in the offers section when the list is not empty.';

  @override
  String get adminGrowthCombos => 'Combos';

  @override
  String get adminGrowthCombosBody =>
      'Shown in combo sections on customer and guest pages.';

  @override
  String get adminGrowthDiscountedItems => 'Discounted items';

  @override
  String get adminGrowthDiscountedItemsBody =>
      'Hidden automatically when no discounted items exist.';

  @override
  String get adminGrowthSubscriptionItems => 'Subscription items';

  @override
  String get adminGrowthSubscriptionItemsBody =>
      'Supports monthly or annual subscription offers.';

  @override
  String get adminGrowthTargetMargin => 'Target margin';

  @override
  String get adminGrowthTargetMarginBody =>
      'Do not publish if margin drops below target.';

  @override
  String get adminGrowthDecisionStaff =>
      'Approve close-shift hours before tip payout.';

  @override
  String get adminGrowthDecisionPrivacy =>
      'Show net profit only during owner performance review.';

  @override
  String get adminGrowthDecisionLoyalty =>
      'Tie point multipliers to soft demand windows.';

  @override
  String get adminGrowthDecisionOffers =>
      'Test the shawarma offer before publishing plated bundles.';

  @override
  String get adminGrowthSuggestedDecision => 'Suggested Decision';

  @override
  String get adminGrowthExpectedImpact => 'Expected impact';

  @override
  String get adminGrowthExpectedImpactValue => '+8% repeat orders';

  @override
  String get adminGrowthActionsTitle => 'Admin Actions';

  @override
  String get adminGrowthActionsSubtitle =>
      'Manage growth campaigns and offers.';

  @override
  String get adminGrowthSaveSettings => 'Save settings';

  @override
  String get adminGrowthSettingsSaved => 'Hub settings saved';

  @override
  String get adminGrowthOpenAuditLog => 'Open audit log';

  @override
  String get languageEmblemArabic => 'ع';

  @override
  String get languageEmblemEnglish => 'EN';

  @override
  String get authLoginInvalidCredentials =>
      'Invalid phone, email, or password.';

  @override
  String get settingsProfileRefreshed => 'Profile refreshed.';

  @override
  String ownershipShareValue(String share) {
    return '$share%';
  }

  @override
  String get pendingApprovalRefreshed => 'Approval status checked.';

  @override
  String get roleSelectionOpsSection => 'Operations & customer';

  @override
  String get supportCreateTicketTitle => 'Open support ticket';

  @override
  String get supportFieldTitleEn => 'Title (EN)';

  @override
  String get supportFieldTitleAr => 'Title (AR)';

  @override
  String get supportFieldDescriptionEn => 'Description (EN)';

  @override
  String get supportFieldDescriptionAr => 'Description (AR)';

  @override
  String get supportSubmitTicket => 'Submit ticket';

  @override
  String get supportValidationTitleBody => 'Enter title and description';

  @override
  String get supportTicketsEmpty => 'No tickets yet.';

  @override
  String get supportMessageStaffPrefix => 'Support: ';

  @override
  String get supportYourRating => 'Your rating';

  @override
  String get supportYourReply => 'Your reply';

  @override
  String get supportSendReply => 'Send reply';

  @override
  String get supportRateAfterResolved => 'Rate only after ticket is resolved';

  @override
  String timeAgoMinutes(int count) {
    return '${count}m ago';
  }

  @override
  String timeAgoHours(int count) {
    return '${count}h ago';
  }

  @override
  String timeAgoDays(int count) {
    return '${count}d ago';
  }

  @override
  String get promoDetailOfferDetails => 'Offer details';

  @override
  String get promoDetailIncludes => 'Includes';

  @override
  String get promoDetailDescription => 'Description';

  @override
  String get promoDetailDiscount => 'Discount';

  @override
  String get promoDetailLoyaltyPoints => 'Loyalty points';

  @override
  String get promoDetailValidFor => 'Valid for';

  @override
  String get promoDetailThisWeek => 'This week';

  @override
  String get promoDetailLimitedOfferDesc =>
      'Limited-time offer. Order now before it expires.';

  @override
  String get promoDetailComboDesc =>
      'A bundled combo that brings our best dishes together at a special price.';

  @override
  String get promoDetailBundleSavings => 'Bundle savings';

  @override
  String get promoDetailItemsCount => 'Items';

  @override
  String get promoDetailBillingCycle => 'Billing cycle';

  @override
  String get promoDetailWeekly => 'Weekly';

  @override
  String get promoDetailMonthly => 'Monthly';

  @override
  String get promoDetailSubscriptionDesc =>
      'Weekly or monthly meal subscription.';

  @override
  String get promoDetailViewMeal => 'View meal';

  @override
  String promoPercentOff(String percent) {
    return '$percent% off';
  }

  @override
  String get cartInvalidPromoCode => 'Invalid code — try AYLETNA10 or WELCOME';

  @override
  String get homeOfferAddedToCart => 'Offer added to cart';

  @override
  String get homeComboAddedToCart => 'Combo added to cart';

  @override
  String get productAddedToCart => 'Added to cart';

  @override
  String get productContinueShopping => 'Continue shopping';

  @override
  String get productCheckout => 'Checkout';

  @override
  String get productRelatedProducts => 'Related products';

  @override
  String get productCustomerReviews => 'Customer reviews';

  @override
  String get productMoreReviews => 'More reviews';

  @override
  String productRewardCoins(int count) {
    return '$count coins';
  }

  @override
  String get searchRefreshed => 'Menu search refreshed';

  @override
  String get productNoReviewsYet => 'No approved reviews yet.';

  @override
  String get prepMockTimerDisplay => '12:49';

  @override
  String get platedConfirmCollectionBody =>
      'Start the plated return collection for this stop?';

  @override
  String get productReviewsTitle => 'Product reviews';

  @override
  String get productReviewsApprovedTitle => 'Approved reviews';

  @override
  String productReviewsCountFor(int count, String title) {
    return '$count reviews for $title';
  }

  @override
  String get productReviewsEmptyPrompt =>
      'No approved reviews yet. Rate your order after delivery.';

  @override
  String get productRewardEarnBefore => 'You are about to earn ';

  @override
  String get productRewardEarnAfter =>
      ' with this item. Keep collecting rewards and redeem them later for Ayletna discounts and treats.';

  @override
  String get orderReorderFailed =>
      'Could not rebuild this order. Some items may no longer be available.';

  @override
  String get orderTrackingLoadError =>
      'Unable to load order tracking. Pull to refresh or try again later.';

  @override
  String get ratingOrderLoadError => 'Unable to load order details for rating.';

  @override
  String get paymentHistoryEmpty => 'No payments recorded yet.';

  @override
  String get redemptionNoRewardSelected => 'No reward selected';

  @override
  String get redemptionInsufficientPoints => 'Insufficient points';

  @override
  String get redemptionPointsBalanceTitle => 'Points balance';

  @override
  String redemptionPointsBalanceValue(int balance) {
    return '$balance pts';
  }

  @override
  String redemptionCostLabel(int cost) {
    return 'Redemption cost: $cost';
  }

  @override
  String get supportChatYou => 'You';

  @override
  String supportChatLinkedTicket(String ticketId) {
    return 'Linked ticket: $ticketId';
  }

  @override
  String get supportChatTicketFromLiveChat => 'Help request from live chat';

  @override
  String get supportChatTicketTitle => 'Live chat';

  @override
  String get cartCompleteOrderTitle => 'Complete your order';

  @override
  String get cartPopularAddonsSubtitle => 'Popular add-ons for your basket';

  @override
  String get cashierConfirmLogTip => 'Log this tip amount to the shift total?';

  @override
  String get checkoutPaymentSummaryTitle => 'Payment summary';

  @override
  String get addressesDeleteFailed =>
      'Could not delete this address. Try again.';

  @override
  String get deliveryOrder8845Title => 'Order #8845';

  @override
  String get inventoryBatchLotLabel => 'Batch / lot';

  @override
  String get inventoryBatchLotHint => 'LOT-SAL-042';

  @override
  String get inventoryExpiryDateLabel => 'Expiry date';

  @override
  String get inventoryExpiryDateHint => '2026-06-20';

  @override
  String get inventoryEvidenceTitle => 'Receipt / photo evidence';

  @override
  String get inventoryAttachSupplierReceipt => 'Attach supplier receipt';

  @override
  String get inventoryAddShelfPhoto => 'Add shelf photo';

  @override
  String get mapDefaultAddressTitle => 'Home';

  @override
  String get mapDefaultAddressText => '123 Gastronomy Lane, Central Hub, Amman';

  @override
  String comboDiscountOff(String percent) {
    return '$percent% off';
  }

  @override
  String get billingPeriodWeekly => 'Weekly';

  @override
  String get billingPeriodMonthly => 'Monthly';

  @override
  String get catalogBrowseEmpty => 'New items will appear here when available.';

  @override
  String get guestOfferCartUnavailable =>
      'This offer cannot be added to your cart yet.';

  @override
  String get profileRefreshed => 'Profile refreshed.';

  @override
  String get profileDeactivateNotAvailable =>
      'Account deactivation is temporarily unavailable. Contact support.';

  @override
  String get profileDeactivateConfirmBody =>
      'This ends the demo session and returns you to sign-in. Real account deletion will require support once the backend is live.';

  @override
  String get profileDeactivatedMock => 'Demo account signed out.';

  @override
  String get addressSavedSuccess => 'Address saved';

  @override
  String get addressSaveFailed => 'Could not save address';

  @override
  String get cashierAttachAddressTitle => 'Attach address to account';

  @override
  String get cashierMobileNumber => 'Mobile number';

  @override
  String get cashierAccountIdOptional => 'Account ID (optional)';

  @override
  String get cashierSaveAndAttach => 'Save & attach';

  @override
  String get cashierEnterAddressFirst => 'Enter an address first';

  @override
  String get cashierDeliveryAddressLabel => 'Delivery address';

  @override
  String get cashierSavedAddressesTitle => 'Saved addresses';

  @override
  String get cashierSearchAddressHint => 'Search by name or mobile';

  @override
  String get cashierNoMatchingAddresses => 'No matching saved addresses';

  @override
  String get cashierSaveAddressLabel => 'Save address';

  @override
  String get cashierAttachToAccountLabel => 'Attach to phone / account';

  @override
  String get cashierOfferAddedToCart => 'Offer added to cart';

  @override
  String get settingsToggleSaved => 'Setting saved';

  @override
  String get deliveryReturnProcessRefreshed => 'Return process refreshed.';

  @override
  String get adminCommandCenterBadge => 'Live Command Center';

  @override
  String get adminCommandCenterHeadline =>
      'Priority now: late tickets, stockouts, cash close, and driver delays.';

  @override
  String get adminCommandCenterBody =>
      'Built for the restaurant owner: fast decisions, clear operations, and direct links into every station.';

  @override
  String get adminActiveOrdersMetric => 'Active orders';

  @override
  String get adminUrgentAlertsMetric => 'Urgent alerts';

  @override
  String get adminOpenOrdersBoard => 'Open Orders Board';

  @override
  String get adminCashCloseAction => 'Cash Close';

  @override
  String get adminNeedsAttentionTitle => 'Needs Your Attention';

  @override
  String get adminNeedsAttentionSubtitle =>
      'Prioritized by guest impact and shift risk.';

  @override
  String adminLateTicketsLabel(int count) {
    return '$count tickets running late';
  }

  @override
  String get adminLateTicketsDetail =>
      'Shawarma and fryer station need attention within 4 minutes.';

  @override
  String get adminOpenOrdersAction => 'Open orders';

  @override
  String adminBelowThresholdDetail(int count) {
    return '$count ingredients below threshold.';
  }

  @override
  String get adminDriverDelayedLabel => 'Driver delayed on plated delivery';

  @override
  String adminDriverDelayedDetail(String orderId, String customer) {
    return 'Order #$orderId on the road — $customer.';
  }

  @override
  String get adminDeliveryRouteAction => 'Delivery route';

  @override
  String get adminNoUrgentAlerts =>
      'No urgent alerts — operations look stable.';

  @override
  String get adminLiveOrdersSubtitle =>
      'Every order channel with prep and settlement context.';

  @override
  String get adminCashCloseTitle => 'Cash Close';

  @override
  String get adminCashCloseSubtitle => 'Verify sales, tips, and refunds.';

  @override
  String get adminReviewShiftClose => 'Review Shift Close';

  @override
  String get adminStockoutImpactTitle => 'Menu Stockout Impact';

  @override
  String get adminStockoutImpactSubtitle =>
      'Connect low ingredients to dishes before peak.';

  @override
  String get adminInventoryAction => 'Inventory';

  @override
  String get adminNoCriticalStock => 'No critical stock alerts.';

  @override
  String get adminDriversReturnsTitle => 'Drivers & Returns';

  @override
  String get adminDriversReturnsSubtitle =>
      'Food delivery and plated returns in one view.';

  @override
  String get adminNoActiveDelivery => 'No active delivery tasks.';

  @override
  String adminOrderLabel(String id) {
    return 'Order #$id';
  }

  @override
  String adminTrayReturnLabel(String id) {
    return 'Tray return #$id';
  }

  @override
  String get adminReturnBadge => 'Return';

  @override
  String get adminOpenDeliveryTasks => 'Open Delivery Tasks';

  @override
  String get adminTeamSnapshotSubtitle => 'Current team by station.';

  @override
  String get adminQuickControlsTitle => 'Quick Controls';

  @override
  String get adminQuickControlsSubtitle =>
      'Admin links without bottom navigation.';

  @override
  String get platesOpsBadge => 'Plate Asset & Deposit Ops';

  @override
  String get platesOpsHeadline =>
      'Track trays, bowls, breakage, deposits, and returns from one board.';

  @override
  String get platesInStock => 'In stock';

  @override
  String get platesCirculating => 'Circulating';

  @override
  String get platesAssetValue => 'Asset value';

  @override
  String get platesCatalogSubtitle =>
      'Physical assets with SKU, value, stock, and circulation.';

  @override
  String get platesReturnWindowValue => '48 hours';

  @override
  String get platesReturnReminders => 'Return reminders';

  @override
  String get platesBreakageTrackSubtitle =>
      'Track breakage and missing items before settlement.';

  @override
  String get platesBreakageDefault => 'Plate breakage';

  @override
  String get platesBreakageDescription => 'Description';

  @override
  String get platesBreakageLossJod => 'Loss (JOD)';

  @override
  String platesStockNowUnits(int count) {
    return 'Stock now $count units';
  }

  @override
  String get supportTicketsTitle => 'Support Tickets';

  @override
  String get supportTicketsHero => 'Customer Support Center';

  @override
  String get supportTicketNotFound => 'Ticket not found';

  @override
  String get supportTicketStatusLabel => 'Status';

  @override
  String get supportTicketStatusUpdated => 'Status updated';

  @override
  String get supportTicketConversation => 'Conversation';

  @override
  String get supportTicketReplyArabic => 'Arabic reply';

  @override
  String get supportTicketReplyEnglish => 'English reply';

  @override
  String get supportTicketSendReply => 'Send reply';

  @override
  String get supportTicketReplyFailed => 'Could not send reply';

  @override
  String get supportTicketReplySent => 'Reply sent';

  @override
  String get supportTicketCustomerFeedback => 'Customer feedback';

  @override
  String get hrAttendancePayrollTitle => 'Attendance & Payroll';

  @override
  String get hrStaffAttendanceTooltip => 'Staff attendance';

  @override
  String get hrPeriodDaily => 'Daily';

  @override
  String get hrPeriodMonthly => 'Monthly';

  @override
  String get hrTotalPayable => 'Total payable';

  @override
  String get hrExportCsv => 'Export CSV';

  @override
  String get hrExportCsvSuccess => 'Payroll CSV exported.';

  @override
  String get hrPayrollRulesTitle => 'Payroll rules';

  @override
  String hrPayrollDelayRule(int minutes, String fee, String currency) {
    return 'Delay > $minutes min → fee $fee $currency';
  }

  @override
  String get hrDelayLabel => 'Delay';

  @override
  String get hrOvertimeLabel => 'Overtime';

  @override
  String get hrPercentLabel => 'Percent';

  @override
  String get hrPayableLabel => 'Payable';

  @override
  String get hrMinutesShort => 'min';

  @override
  String get hrHoursShort => 'h';

  @override
  String get hrOutcomeFullPay => 'Full pay';

  @override
  String get hrOutcomeDelayFee => 'Delay fee';

  @override
  String get hrOutcomeDelayFeeDouble => 'Fee ×2';

  @override
  String get hrOutcomeAbsence => 'Absence';

  @override
  String get hrOutcomeOvertime => 'Overtime';

  @override
  String get productEditorAddMenuItem => 'Add menu item';

  @override
  String get productEditorSaveFirst => 'Save the item first';

  @override
  String get productEditorPreview => 'Preview';

  @override
  String get productEditorBadge => 'Menu Item Editor';

  @override
  String get productEditorBadgeDesc =>
      'Edit pricing, variants, modifiers, media, and station routing.';

  @override
  String get productEditorNameSection => 'Name & Description';

  @override
  String get productEditorNameSectionDesc =>
      'Bilingual copy shown on customer menu cards.';

  @override
  String get productEditorArabicName => 'Arabic name';

  @override
  String get productEditorEnglishName => 'English name';

  @override
  String get productEditorArabicDesc => 'Arabic description';

  @override
  String get productEditorEnglishDesc => 'English description';

  @override
  String get productEditorPricingSection => 'Pricing & Variants';

  @override
  String get productEditorPricingSectionDesc =>
      'Base price and portion/variant deltas.';

  @override
  String get productEditorBasePrice => 'Base price';

  @override
  String get productEditorAddVariant => 'Add variant';

  @override
  String get productEditorAddPortionTitle => 'Add portion size';

  @override
  String get productEditorPortionKeyLabel => 'Key (e.g. super)';

  @override
  String get productEditorPortionPriceDelta => 'Price delta (JOD)';

  @override
  String get productEditorEnterPortionKey => 'Enter a portion key';

  @override
  String get productEditorPortionAdded => 'Portion added';

  @override
  String get productEditorPortionKeyExists => 'Key already exists';

  @override
  String get productEditorModifiersSection => 'Modifiers';

  @override
  String get productEditorModifiersSectionDesc =>
      'Attach catalog add-ons to this item.';

  @override
  String get productEditorNoAddons => 'No catalog addons yet.';

  @override
  String get productEditorMediaSection => 'Media & Display';

  @override
  String get productEditorMediaSectionDesc => 'Images and menu presentation.';

  @override
  String get productEditorMediaFallback => 'No image yet — add 1 to 5 photos.';

  @override
  String get productEditorPrepStationSection => 'Prep Station';

  @override
  String get productEditorPrepStationSectionDesc =>
      'Route tickets to the correct kitchen lane.';

  @override
  String get productEditorAvailabilitySection => 'Availability & Channels';

  @override
  String get productEditorAvailabilitySectionDesc =>
      'Control where this item is visible.';

  @override
  String get productEditorAvailableNow => 'Available now';

  @override
  String get productEditorFeatured => 'Featured in menu';

  @override
  String get productEditorSavePublishSection => 'Save & Publish';

  @override
  String get productEditorSavePublishCreateDesc =>
      'Create then publish to the menu.';

  @override
  String get productEditorSavePublishEditDesc =>
      'Persists edits to catalog and custom menu items.';

  @override
  String get productEditorAddMinImages => 'Add at least 1 image (up to 5)';

  @override
  String get productEditorCheckRequiredFields => 'Check required fields';

  @override
  String get productEditorMenuItemSaved => 'Menu item saved';

  @override
  String get productEditorPublishToMenu => 'Publish to menu';

  @override
  String get productEditorPublishTitle => 'Publish menu item';

  @override
  String get productEditorPublishMessage =>
      'The item will appear in selected sales channels.';

  @override
  String get productEditorAddImageBeforePublish =>
      'Add at least 1 image before publishing';

  @override
  String get productEditorCheckNamePrice => 'Check name and price';

  @override
  String get productEditorPublished => 'Published';

  @override
  String get productEditorBackToMenu => 'Back to menu management';

  @override
  String get productEditorPrepStationShawarma => 'Shawarma station';

  @override
  String get productEditorPrepStationFryer => 'Fryer station';

  @override
  String get productEditorPrepStationColdPrep => 'Cold prep';

  @override
  String get productEditorPrepStationDrinks => 'Drinks';

  @override
  String get auditLogTrueTrailBadge => 'True Audit Trail';

  @override
  String get auditLogHeroHeadline =>
      'Track who changed what, when, and from which operational area.';

  @override
  String get auditLogTodayEvents => 'Today events';

  @override
  String get auditLogSensitiveChanges => 'Sensitive changes';

  @override
  String get auditLogNeedsReview => 'Needs review';

  @override
  String get auditLogRequestConfirmMessage =>
      'A detailed audit request will be logged for review.';

  @override
  String get auditLogExportLog => 'Export log';

  @override
  String get auditLogExportDownloaded => 'Export file downloaded';

  @override
  String get auditLogTimelineSubtitle =>
      'Timeline of administrative and operational events.';

  @override
  String get auditLogNoEventsInScope => 'No events in this scope.';

  @override
  String get auditLogDetailedAuditRequested => 'Detailed audit requested';

  @override
  String get auditLogAuditExported => 'Audit log exported';

  @override
  String get auditLogShiftCloseApproved => 'Shift close approved';

  @override
  String get auditLogUserActivated => 'User activated';

  @override
  String get auditLogUserDeactivated => 'User deactivated';

  @override
  String get auditLogDepositSettingsSaved => 'Deposit settings saved';

  @override
  String get auditLogTrayBreakageArea => 'Tray breakage';

  @override
  String get auditLogInventoryArea => 'Inventory';

  @override
  String get auditLogUserRoleChanged => 'User role changed';

  @override
  String get auditLogCashierShiftClosed => 'Cashier shift closed';

  @override
  String get auditLogTrayDepositEdited => 'Tray deposit policy edited';

  @override
  String get auditLogFiltersTitle => 'Audit Filters';

  @override
  String get auditLogFiltersSubtitle => 'Scope the log quickly.';

  @override
  String get auditLogGovernanceTitle => 'Governance Snapshot';

  @override
  String get auditLogGovernanceSubtitle =>
      'Security and permission posture for this shift.';

  @override
  String get auditLogFailedLogins => 'Failed login attempts';

  @override
  String get auditLogPermissionChanges => 'Permission changes';

  @override
  String get auditLogFinancialEdits => 'Financial edits';

  @override
  String get auditLogInventorySubtitle =>
      'Recent stock adjustments from inventory.';

  @override
  String get auditLogNoStockChanges => 'No stock changes yet.';

  @override
  String get auditLogActorOwner => 'Owner';

  @override
  String get auditLogActorOperator => 'Operator';

  @override
  String get auditLogActorFinance => 'Finance';

  @override
  String get auditLogActorLogistics => 'Logistics';

  @override
  String get auditLogActorSystem => 'System';

  @override
  String get auditLogAreaGovernance => 'Governance';

  @override
  String get auditLogAreaReports => 'Reports';

  @override
  String get auditLogAreaCashClose => 'Cash close';

  @override
  String get auditLogAreaRolesPrivacy => 'Roles & Privacy';

  @override
  String get auditLogAreaFinance => 'Finance';

  @override
  String get auditLogAreaAdminLog => 'Admin log';

  @override
  String get auditLogToday => 'Today';

  @override
  String get auditLogYesterday1820 => 'Yesterday 18:20';

  @override
  String get auditLogToday0942 => 'Today 09:42';

  @override
  String get auditLogToday0858 => 'Today 08:58';

  @override
  String get auditLogActorOperatorAhmad => 'Operator Ahmad';

  @override
  String get auditLogActorCashierLayla => 'Cashier Layla';

  @override
  String get auditLogAuditRequestDetail =>
      'Request logged for review before shift close.';

  @override
  String get auditLogAuditExportDetail => 'CSV audit file downloaded.';

  @override
  String get auditLogShiftCloseDetail => 'Revenue, tips, and refunds approved.';

  @override
  String auditLogDepositSavedDetail(String amount, String hours) {
    return 'Deposit $amount JOD · ${hours}h window';
  }

  @override
  String get auditLogRoleChangeDetail =>
      'Sara moved from Kitchen to Station Supervisor.';

  @override
  String get auditLogCashierCloseDetail =>
      'Revenue, tips, and refunds were approved.';

  @override
  String get auditLogTrayDepositEditDetail =>
      'Global deposit and return window updated.';

  @override
  String get auditLogSystemEntryDetail => 'Automated admin event recorded.';

  @override
  String get orderDetailAdminSendUpdate => 'Send update';

  @override
  String get orderDetailAdminOrderTotal => 'Order total';

  @override
  String get orderDetailAdminDeposit => 'Deposit';

  @override
  String get orderDetailAdminOnRoute => 'On route';

  @override
  String get orderDetailAdminOnRouteValue => '28 min';

  @override
  String get orderDetailAdminSendGuestUpdateTitle => 'Send guest update';

  @override
  String get orderDetailAdminUpdatePreparing => 'Order is preparing';

  @override
  String get orderDetailAdminUpdateReady => 'Order is ready';

  @override
  String get orderDetailAdminUpdateOnWay => 'Driver is on the way';

  @override
  String get orderDetailAdminUpdateDelay => 'Delay — we apologize';

  @override
  String get orderDetailAdminUpdateSent => 'Update sent';

  @override
  String get orderDetailAdminDelayNoticeSent => 'Delay notice sent';

  @override
  String get orderDetailAdminGuestPaymentTitle => 'Guest & Payment';

  @override
  String get orderDetailAdminGuestPaymentSubtitle =>
      'Key context for closing and contact.';

  @override
  String get orderDetailAdminGuestLabel => 'Guest';

  @override
  String get orderDetailAdminChannelLabel => 'Channel';

  @override
  String get orderDetailAdminFoodTotal => 'Food total';

  @override
  String get orderDetailAdminTrayDeposit => 'Tray deposit';

  @override
  String get orderDetailAdminKitchenTicketTitle => 'Kitchen Ticket';

  @override
  String get orderDetailAdminKitchenTicketSubtitle =>
      'Items and station summary.';

  @override
  String get orderDetailAdminPrepStationNote => 'Prep station';

  @override
  String get orderDetailAdminOpenKitchen => 'Open kitchen pass';

  @override
  String get orderDetailAdminActionsTitle => 'Admin Actions';

  @override
  String get orderDetailAdminContactGuest => 'Contact guest';

  @override
  String get orderDetailAdminChangeStatus => 'Change order status';

  @override
  String get orderDetailAdminChangeStatusTitle => 'Change status';

  @override
  String get orderDetailAdminBackToBoard => 'Back to order board';

  @override
  String get orderDetailAdminPosReceived => 'POS received';

  @override
  String get orderDetailAdminKitchenPrep => 'Kitchen prep';

  @override
  String get orderDetailAdminCloseSettle => 'Close & settle';

  @override
  String get orderDetailAdminTimelineNext => 'Next';

  @override
  String get orderDetailAdminTimelineTitle => 'Order Timeline';

  @override
  String get orderDetailAdminTimelineSubtitle => 'From entry to settlement.';

  @override
  String get orderDetailAdminRisksTitle => 'Risks & Notes';

  @override
  String get orderDetailAdminDeliveryTiming => 'Delivery timing';

  @override
  String get orderDetailAdminNoDeposit => 'No deposit';

  @override
  String get orderDetailAdminOperationalNote => 'Operational note';

  @override
  String get productEditorHeroHeadline =>
      'Edit bilingual naming, pricing, variants, modifiers, prep routing, and availability.';

  @override
  String get productEditorIdentitySubtitle =>
      'Customer-facing copy shown in the menu.';

  @override
  String get productEditorMediaGalleryHint =>
      '1–5 images — warm food media for each angle.';

  @override
  String get productEditorMediaUsage =>
      'Product gallery • menu card • POS tile';

  @override
  String get productEditorStationSubtitle =>
      'Controls where the kitchen ticket appears.';

  @override
  String get orderDetailAdminContactPhone => '+962 7 9000 0000';

  @override
  String get commonOpen => 'Open';

  @override
  String get settingsOpsBadge => 'Operations Settings';

  @override
  String get settingsOpsHeroHeadline =>
      'Control hours, stations, order rules, delivery zones, taxes, receipts, and alerts.';

  @override
  String get settingsAppAdminHeroHeadline =>
      'System configuration, integrations, and platform permissions.';

  @override
  String get settingsHeroNineSections => '9 sections';

  @override
  String get settingsHeroUiOnly => 'Settings';

  @override
  String get settingsHeroDrawerNav => 'Drawer navigation';

  @override
  String get settingsBusinessHoursTitle => 'Business Hours & Order Rules';

  @override
  String get settingsBusinessHoursSubtitle =>
      'Set service state, prep rules, and pre-order behavior.';

  @override
  String get settingsAcceptingOrders => 'Accepting orders now';

  @override
  String get settingsDeliveryEnabled => 'Delivery enabled now';

  @override
  String get settingsTodayHours => 'Today hours';

  @override
  String get settingsTodayHoursValue => '8:00 AM - 12:00 AM';

  @override
  String get settingsPreOrdersLabel => 'Pre-orders';

  @override
  String get settingsPreOrdersDetail => 'Up to 3 days ahead';

  @override
  String get settingsStationsTitle => 'Stations & Operating Rules';

  @override
  String get settingsStationsSubtitle =>
      'Route menu items to kitchen stations and prep rules.';

  @override
  String get settingsShawarmaStation => 'Shawarma station';

  @override
  String get settingsShawarmaPrepDetail => '8 min average prep';

  @override
  String get settingsFryerStation => 'Fryer station';

  @override
  String get settingsFryerLoadDetail => 'Load limit 12 tickets';

  @override
  String get settingsLateTicketThreshold => 'Late-ticket threshold';

  @override
  String get settingsLateTicketDetail => 'Escalate after 15 minutes';

  @override
  String get settingsSystemPlatformTitle => 'System & platform';

  @override
  String get settingsSystemPlatformSubtitle =>
      'Integrations, users, roles, and audit.';

  @override
  String get settingsIntegrationsDetail => 'Supabase, SMS, payments';

  @override
  String get settingsAuditTrailDetail => 'Full platform audit trail';

  @override
  String get settingsStaffTitle => 'Staff & attendance';

  @override
  String get settingsStaffSubtitle =>
      'Shift roster, attendance, and approvals.';

  @override
  String get settingsStaffHoursDetail => 'Shifts, attendance, and hours';

  @override
  String get settingsAttendanceHrLabel => 'Attendance & HR';

  @override
  String get settingsAttendanceHrDetail => 'Attendance log and approvals';

  @override
  String get settingsFeesTaxesTitle => 'Fees & Taxes';

  @override
  String get settingsFeesTaxesSubtitle =>
      'Delivery fees, tax display, and receipt layout.';

  @override
  String get settingsDeliveryFeesLabel => 'Delivery fees';

  @override
  String get settingsDeliveryFeesDetail => 'Zone-based delivery charge rules';

  @override
  String get settingsReceiptTemplateLabel => 'Receipt template';

  @override
  String get settingsReceiptTemplateDetail =>
      'Logo, footer, and tax line layout';

  @override
  String get settingsNotificationsTitle => 'Notifications & Alerts';

  @override
  String get settingsNotificationsSubtitle =>
      'Kitchen, inventory, and tray-return alerts.';

  @override
  String get settingsKitchenAlertsDetail => 'Prep delay and station overload';

  @override
  String get settingsLowStockAlert => 'Low stock alert';

  @override
  String get settingsLowStockDetail => 'Below 15% threshold';

  @override
  String get settingsTrayReturnReminders => 'Tray return reminders';

  @override
  String get settingsTrayReturnDetail => '60 minutes after delivery';

  @override
  String get settingsAppAdminShortcuts => 'App admin shortcuts';

  @override
  String get settingsOpsShortcuts => 'Operations shortcuts';

  @override
  String get settingsShortcutsSubtitle => 'Jump to high-traffic admin screens.';

  @override
  String get settingsAttendancePayrollShortcut => 'Attendance & payroll';

  @override
  String get settingsPreOrdersShortcut => 'Pre-orders';

  @override
  String get ordersMgmtFilterTitle => 'Filter order board';

  @override
  String get ordersMgmtFilterMessage =>
      'Filter by channel, station, or delay status.';

  @override
  String get ordersMgmtFilterTooltip => 'Filter';

  @override
  String get ordersMgmtLaneNeedsDecision => 'Needs Decision';

  @override
  String get ordersMgmtLaneNeedsDecisionSub => 'Late, missing, or escalated';

  @override
  String get ordersMgmtLanePreparing => 'Preparing';

  @override
  String get ordersMgmtLanePreparingSub => 'Kitchen in progress';

  @override
  String get ordersMgmtLaneReadyRoute => 'Ready / On Route';

  @override
  String get ordersMgmtLaneReadyRouteSub => 'Ready to handoff or on the road';

  @override
  String get ordersMgmtHeroBadge => 'Live Order Board';

  @override
  String get ordersMgmtOpenOrders => 'Open orders';

  @override
  String get ordersMgmtActiveValue => 'Active value';

  @override
  String get ordersMgmtPlatedOrders => 'Plated orders';

  @override
  String get ordersMgmtEmptyLane => 'No orders here';

  @override
  String get ordersMgmtOpenDetail => 'Open detail';

  @override
  String get ordersMgmtEscalate => 'Escalate';

  @override
  String get ordersMgmtEscalationLogged => 'Escalation logged';

  @override
  String get ordersMgmtRecentlyClosed => 'Recently Closed';

  @override
  String get ordersMgmtHistory => 'History';

  @override
  String get ordersMgmtDeliveredStatus => 'Delivered';

  @override
  String get financialCloseBadge => 'Cash Close & Profit Split';

  @override
  String get financialCloseHeroHeadline =>
      'Reconcile shift revenue, cash, cards, deposits, tips, then approve net profit.';

  @override
  String get financialCloseShiftRevenue => 'Shift revenue';

  @override
  String get financialCloseOrdersCount => 'Orders';

  @override
  String get financialCloseDistributableNet => 'Distributable net';

  @override
  String get financialCloseSummaryTitle => 'Shift Close Summary';

  @override
  String get financialCloseSummarySubtitle =>
      'Operational numbers before approving the close.';

  @override
  String get financialCloseStatusLabel => 'Status';

  @override
  String get financialCloseStatusReady => 'Ready to close';

  @override
  String get financialCloseTenderTitle => 'Tender Reconciliation';

  @override
  String get financialCloseTenderSubtitle =>
      'Cash, card, and wallet must match the cashier ledger.';

  @override
  String get financialCloseCash => 'Cash';

  @override
  String get financialCloseCards => 'Cards';

  @override
  String get financialCloseWallet => 'Wallet';

  @override
  String get financialCloseDepositsTitle => 'Deposits & Refunds';

  @override
  String get financialCloseDepositsSubtitle =>
      'Tray deposits, refunds, and breakage exposure.';

  @override
  String get financialCloseRefundsToday => 'Refunds today';

  @override
  String get financialCloseBreakageFees => 'Potential breakage fees';

  @override
  String get financialCloseReviewTrayReturns => 'Review tray returns';

  @override
  String get financialCloseTipsTitle => 'Tips & Variance';

  @override
  String get financialCloseTipsSubtitle =>
      'Shift tip pool and reconciliation variance.';

  @override
  String get financialCloseCurrentTips => 'Current shift tips';

  @override
  String get financialCloseVariance => 'Reconciliation variance';

  @override
  String get financialCloseSplitTitle => 'Net Profit Split';

  @override
  String get financialCloseSplitSubtitle =>
      'Owner and operator shares after costs and tips.';

  @override
  String get financialCloseApproveTitle => 'Approve Close';

  @override
  String get financialCloseOwnerViewOnly => 'Owner view only';

  @override
  String get financialCloseApprovedReadOnly => 'Close approved (read-only)';

  @override
  String get financialCloseAwaitingApproval => 'Awaiting operator approval';

  @override
  String get financialCloseApproveSubtitle =>
      'Lock the shift after reconciliation checks.';

  @override
  String get financialCloseApproveShift => 'Approve shift close';

  @override
  String get financialCloseApproveConfirmTitle => 'Approve close';

  @override
  String get financialCloseApproveConfirmMessage =>
      'This will lock shift totals for audit.';

  @override
  String get financialCloseApprovedSuccess => 'Shift close approved';

  @override
  String get settingsStaffCardSubtitle => 'Staff hours and attendance.';

  @override
  String get settingsFeesTaxesCardSubtitle =>
      'Sales tax, delivery fees, deposits, and receipts.';

  @override
  String get settingsDeliveryFeesZoneMinimum =>
      'Zone-based fee and minimum order';

  @override
  String get settingsReceiptTemplateTerms => 'Logo, tax, and return terms';

  @override
  String get settingsNotificationsCardSubtitle =>
      'Kitchen, driver, inventory, and return alerts.';

  @override
  String get settingsLateKitchenTicketAlerts => 'Late kitchen ticket alerts';

  @override
  String get settingsShortcutsJumpSubtitle =>
      'Jump to specialized settings without bottom navigation.';

  @override
  String get ordersMgmtHeroHeadline =>
      'Track every order from POS to kitchen to handoff.';

  @override
  String get ordersMgmtRecentlyClosedSub =>
      'Completed or delivered orders for quick audit.';

  @override
  String get ordersMgmtOpPending =>
      'Waiting for kitchen confirmation or item availability.';

  @override
  String get ordersMgmtOpReady => 'Ready for handoff, verify packaging.';

  @override
  String get ordersMgmtOpOnWay => 'On route, monitor arrival time.';

  @override
  String get ordersMgmtOpPreparing => 'In preparation, watch station timing.';

  @override
  String get financialCloseDepositsExcludedSubtitle =>
      'Deposits are conditional funds and excluded from profit split.';

  @override
  String get financialCloseTipsSeparateSubtitle =>
      'Tips stay separate from revenue and go to staff.';

  @override
  String get financialCloseSplitAfterCostsSubtitle =>
      'After excluding tips, deposits, and operating expenses.';

  @override
  String get financialCloseApproveUiOnlySubtitle =>
      'Review totals before approving the shift close.';

  @override
  String get financialCloseApproveMockMessage =>
      'Shift close approval will be logged for audit.';

  @override
  String get financialCloseReportDownloaded =>
      'Report downloaded — print to PDF from browser';

  @override
  String get financialCloseVarianceLabel => 'Variance';

  @override
  String get actionAdd => 'Add';

  @override
  String get catalogCrudAdded => 'Added';

  @override
  String get catalogCrudCheckFields => 'Check required fields';

  @override
  String get catalogCrudUpdated => 'Updated';

  @override
  String get catalogCrudUpdateFailed => 'Update failed';

  @override
  String get catalogCrudDeleted => 'Deleted';

  @override
  String get catalogCrudNameEn => 'Name EN';

  @override
  String get catalogCrudNameAr => 'Name AR';

  @override
  String get catalogCrudIconKey => 'Icon key';

  @override
  String get catalogCrudPrice => 'Price';

  @override
  String get catalogCrudMinOneImage => 'Add at least 1 image';

  @override
  String get menuCatalogTitle => 'Menu Catalog';

  @override
  String get menuCatalogTabCategories => 'Categories';

  @override
  String get menuCatalogTabAddons => 'Addons';

  @override
  String get menuCatalogTabRelated => 'Related';

  @override
  String get menuCatalogAddCategory => 'Add category';

  @override
  String get menuCatalogAddAddon => 'Add addon';

  @override
  String get menuCatalogAddonImageRequired => 'Add an image for the addon';

  @override
  String get menuCatalogLinkRelated => 'Link related products';

  @override
  String menuCatalogLinkRelatedSubtitle(String sampleIds) {
    return 'Example IDs: $sampleIds';
  }

  @override
  String get menuCatalogProductId => 'Product ID';

  @override
  String get menuCatalogRelatedIds => 'Related IDs (comma-separated)';

  @override
  String get menuCatalogSaveLink => 'Save link';

  @override
  String get menuCatalogSaved => 'Saved';

  @override
  String get menuCatalogEnterProductId => 'Enter a product ID';

  @override
  String get promoMgmtTabDiscounts => 'Discounts';

  @override
  String get promoMgmtTabOffers => 'Offers';

  @override
  String get promoMgmtCreateCombo => 'Create combo';

  @override
  String get promoMgmtDiscountPercent => 'Discount %';

  @override
  String get promoMgmtDiscountProduct => 'Discount product';

  @override
  String get promoMgmtMenuItemId => 'Menu item ID';

  @override
  String get promoMgmtNewOffer => 'New offer';

  @override
  String get promoMgmtSubscriptionMeal => 'Subscription meal';

  @override
  String orderDetailAdminHeroTitle(String orderId) {
    return 'Order #$orderId admin timeline';
  }

  @override
  String orderDetailAdminHeroBody(String customer) {
    return '$customer • Verify handoff timing, deposit, and notes before closing.';
  }

  @override
  String get orderDetailAdminActionsSubtitle =>
      'Update status, notes, and escalations for this order.';

  @override
  String get orderDetailAdminChangeStatusMessage =>
      'Choose the next status for this order.';

  @override
  String get orderDetailAdminTimelinePosDetail =>
      'Order entered and payment captured.';

  @override
  String get orderDetailAdminTimelinePrepDetail => 'Items prepared and packed.';

  @override
  String get orderDetailAdminTimelineOnWayDetail =>
      'Courier is on the way to the guest.';

  @override
  String get orderDetailAdminTimelineWaitingDetail =>
      'Waiting for the next operational step.';

  @override
  String get orderDetailAdminTimelineCloseDetail =>
      'Confirm handoff, deposit, and any breakage fee.';

  @override
  String get orderDetailAdminRisksSubtitle =>
      'What the owner should know before closing this order.';

  @override
  String get orderDetailAdminRiskTimingDetail =>
      'Eight minutes above route average.';

  @override
  String get orderDetailAdminRiskTrayDetail =>
      'Confirm tray return expectation at handoff.';

  @override
  String hrPayrollOnTimeRule(int minutes) {
    return 'On time (≤ $minutes min) → 100% salary';
  }

  @override
  String hrPayrollDelayDoubleRule(int minutes) {
    return 'Late > $minutes min → fee ×2';
  }

  @override
  String hrPayrollAbsenceRule(int minutes) {
    return 'Late > $minutes min → absence (0% even if present)';
  }

  @override
  String hrPayrollOvertimeRule(int minutes, String multiplier) {
    return 'Work > $minutes min beyond schedule → $multiplier× extra hours pay';
  }

  @override
  String supportTicketsHeroBody(int count) {
    return '$count active tickets — update status, reply to customers, track feedback.';
  }

  @override
  String get supportTicketStatusOpen => 'Open';

  @override
  String get supportTicketStatusInProgress => 'In progress';

  @override
  String get supportTicketStatusWaiting => 'Waiting';

  @override
  String get supportTicketStatusResolved => 'Resolved';

  @override
  String get supportTicketStatusClosed => 'Closed';

  @override
  String get reportsHubBadge => 'Restaurant Analytics Hub';

  @override
  String get reportsHubHeadline =>
      'Connect sales, channels, tips, waste, and trays to clear operating decisions.';

  @override
  String get reportsOpsScorecardsTitle => 'Operating Scorecards';

  @override
  String get reportsOpsScorecardsSubtitle =>
      'Numbers that drive today, not just export files.';

  @override
  String get reportsAvgOrderLabel => 'Average order';

  @override
  String get reportsTrayReturnSuccess => 'Tray return success';

  @override
  String get reportsWasteBreakageCost => 'Waste & breakage cost';

  @override
  String get reportsTrendSubtitle => 'Order trend across recent service hours.';

  @override
  String get reportsTodayPeakLabel => 'Today peak';

  @override
  String get reportsTodayPeakValue => 'Lunch and evening delivery';

  @override
  String get reportsDecisionsTitle => 'Recommended Decisions';

  @override
  String get reportsDecisionsSubtitle =>
      'Analytics connected to restaurant operations.';

  @override
  String get reportsInsightShawarmaLabel =>
      'Increase shawarma prep before lunch';

  @override
  String get reportsInsightShawarmaDetail =>
      'Channel sales are 12% above baseline.';

  @override
  String get reportsReviewFryerLabel => 'Review fryer wastage';

  @override
  String get reportsApproveTipsLabel => 'Approve tip distribution';

  @override
  String get reportsModulesTitle => 'Analytics Modules';

  @override
  String get reportsPlatesDepositsTitle => 'Plates & deposits';

  @override
  String get reportsExportTitle => 'Export & Share';

  @override
  String get reportsExportSubtitle =>
      'Exports are now an outcome, not the whole screen.';

  @override
  String get reportsExportOperatorOnly =>
      'Export is available to the operator role only.';

  @override
  String get preOrderOpsBadge => 'Pre-order Operations';

  @override
  String get preOrderOpsHeadline =>
      'Review tomorrow orders, prep capacity, trays, and pickup windows before accepting pre-orders.';

  @override
  String get preOrderOpsNeedDecision => 'Need decision';

  @override
  String get preOrderOpsPickupWindows => 'Pickup windows';

  @override
  String get preOrderOpsReservedTrays => 'Reserved trays';

  @override
  String get preOrderOpsEmptyMessage => 'No pre-orders pending';

  @override
  String get preOrderOpsReviewQueue => 'Review Queue';

  @override
  String get preOrderOpsReviewQueueSub =>
      'Each pre-order needs a clear decision before prep.';

  @override
  String get preOrderOpsAccept => 'Accept';

  @override
  String get preOrderOpsAccepted => 'Pre-order accepted';

  @override
  String get preOrderOpsAdjustTime => 'Adjust time';

  @override
  String get preOrderOpsPickupUpdated => 'Pickup time updated';

  @override
  String get preOrderOpsPrepCapacity => 'Prep Capacity';

  @override
  String get preOrderOpsPrepCapacitySub =>
      'Accept orders based on available stations.';

  @override
  String get preOrderOpsStationShawarma => 'Shawarma';

  @override
  String get preOrderOpsStationPizza => 'Pizza';

  @override
  String get preOrderOpsStationPlated => 'Plated trays';

  @override
  String get preOrderOpsRulesTitle => 'Pre-order Rules';

  @override
  String get preOrderOpsRulesSubtitle =>
      'Configure pre-order rules and availability.';

  @override
  String get preOrderOpsRuleCutoff => 'Cutoff: 9 PM';

  @override
  String get preOrderOpsRuleMinPrep => 'Minimum prep: 2 hours';

  @override
  String get preOrderOpsRuleTraysBeforePay => 'Confirm trays before payment';

  @override
  String get rewardsAdminSetupTitle => 'Rewards Setup';

  @override
  String get rewardsAdminPointsRules => 'Points rules';

  @override
  String rewardsAdminPointsPerJod(String points) {
    return '$points points per JOD spent';
  }

  @override
  String get rewardsAdminAddReward => 'Add reward';

  @override
  String get rewardsAdminPointsRequired => 'Points required';

  @override
  String get rewardsAdminCategory => 'Category';

  @override
  String get rewardsAdminAddToCatalog => 'Add to catalog';

  @override
  String get rewardsAdminActiveRewards => 'Active rewards';

  @override
  String get rewardsAdminRewardAdded => 'Reward added';

  @override
  String get rewardsAdminCategoryDrinks => 'Drinks';

  @override
  String get rewardsAdminCategorySides => 'Sides';

  @override
  String get rewardsAdminCategoryMain => 'Main';

  @override
  String get rewardsAdminArtIcon => 'Art icon';

  @override
  String get rewardsAdminColorAccent => 'Color accent';

  @override
  String get rewardsAdminBadgeAr => 'Badge AR';

  @override
  String get rewardsAdminBadgeEn => 'Badge EN';

  @override
  String get rewardsAdminArtGeneric => 'Generic';

  @override
  String get rewardsAdminArtBurger => 'Burger';

  @override
  String get rewardsAdminArtDrink => 'Drink';

  @override
  String get rewardsAdminArtFries => 'Fries';

  @override
  String get rewardsAdminArtBowl => 'Bowl';

  @override
  String get rewardsAdminArtDonut => 'Donut';

  @override
  String get rewardsAdminColorGold => 'Gold';

  @override
  String get rewardsAdminColorOrange => 'Orange';

  @override
  String get rewardsAdminColorOlive => 'Olive';

  @override
  String get rewardsAdminColorDelivery => 'Delivery';

  @override
  String get rewardsAdminColorDineIn => 'Dine in';

  @override
  String get rewardsAdminColorSecondary => 'Secondary';

  @override
  String get rewardsAdminColorTertiary => 'Tertiary';

  @override
  String get rewardsAdminColorOutline => 'Outline';

  @override
  String get rewardsAdminSoldOut => 'Sold out';

  @override
  String get rewardsAdminTitleAr => 'Title AR';

  @override
  String get rewardsAdminTitleEn => 'Title EN';

  @override
  String get rewardsAdminDescriptionAr => 'Description AR';

  @override
  String get rewardsAdminDescriptionEn => 'Description EN';

  @override
  String get rewardsAdminPointsLabel => 'Points';

  @override
  String rewardsAdminRewardMeta(int points, String category) {
    return '$points pts · $category';
  }

  @override
  String get quantityIncrease => 'Increase quantity';

  @override
  String get quantityDecrease => 'Decrease quantity';

  @override
  String get menuMgmtPublished => 'Published';

  @override
  String get menuMgmtDraft => 'Draft';

  @override
  String get menuMgmtPublish => 'Publish';

  @override
  String get menuMgmtUnpublish => 'Unpublish';

  @override
  String get menuMgmtPublishSuccess => 'Published';

  @override
  String get menuMgmtHiddenFromMenu => 'Hidden from customer menu';

  @override
  String get filterByRole => 'Filter by role';

  @override
  String get rbacUserNotFound => 'User not found';

  @override
  String get rbacAccountActions => 'Account actions';

  @override
  String get rbacApprove => 'Approve';

  @override
  String get rbacReject => 'Reject';

  @override
  String get rbacSuspend => 'Suspend';

  @override
  String get rbacActivate => 'Activate';

  @override
  String get rbacInvite => 'Invite';

  @override
  String get rbacInviteMockMessage => 'Invite sent';

  @override
  String get rbacApprovedMessage => 'Approved';

  @override
  String get rbacRejectedMessage => 'Rejected';

  @override
  String get rbacSuspendedMessage => 'Suspended';

  @override
  String get rbacActivatedMessage => 'Activated';

  @override
  String get rbacAssignedRoles => 'Assigned roles';

  @override
  String get rbacStatusActive => 'Active';

  @override
  String get rbacStatusPendingApproval => 'Pending approval';

  @override
  String get rbacStatusSuspended => 'Suspended';

  @override
  String get rbacOwnershipPercent => 'Ownership %';

  @override
  String get rbacOwnershipHint => 'e.g. 35';

  @override
  String get reviewModerationTitle => 'Review Moderation';

  @override
  String reviewModerationHeroBody(int count) {
    return '$count reviews awaiting moderation — approve to publish, reject or flag for follow-up.';
  }

  @override
  String get reviewModerationReject => 'Reject';

  @override
  String get reviewModerationFlag => 'Flag';

  @override
  String get reviewModerationUpdated => 'Review updated';

  @override
  String get reviewModerationStatusPending => 'Pending';

  @override
  String get reviewModerationStatusApproved => 'Approved';

  @override
  String get reviewModerationStatusRejected => 'Rejected';

  @override
  String get reviewModerationStatusFlagged => 'Flagged';

  @override
  String get plateEditorBadge => 'Asset & Deposit Editor';

  @override
  String get plateEditorHeadline =>
      'Set asset value, stock, deposit, and breakage fees.';

  @override
  String get plateEditorAssetIdentityTitle => 'Asset Identity';

  @override
  String get plateEditorAssetIdentitySubtitle =>
      'Used by inventory, delivery, and returns.';

  @override
  String get plateEditorAssetNameAr => 'Arabic asset name';

  @override
  String get plateEditorAssetNameEn => 'English asset name';

  @override
  String get plateEditorAssetSku => 'Asset SKU';

  @override
  String get plateEditorReplacementValue => 'Replacement value';

  @override
  String get plateEditorStockTitle => 'Stock & Circulation';

  @override
  String get plateEditorStockSubtitle =>
      'Operational counts used by the return flow.';

  @override
  String get plateEditorRequiresDeposit => 'Requires deposit on delivery';

  @override
  String get plateEditorAvailableDelivery => 'Available for delivery orders';

  @override
  String get plateEditorDepositRulesSubtitle =>
      'Deposit rules for this asset type.';

  @override
  String get plateEditorConditionFeesTitle => 'Condition & Fees';

  @override
  String get plateEditorConditionFeesSubtitle =>
      'Used during plated return processing.';

  @override
  String get plateEditorFeeFullBreakage => 'Full breakage fee';

  @override
  String get plateEditorFeeScratch => 'Scratch / minor damage';

  @override
  String get plateEditorFeeMissing => 'Missing on return';

  @override
  String get plateEditorSaveTitle => 'Save Asset';

  @override
  String get plateEditorSaveSubtitle => 'Save plate settings for the menu.';

  @override
  String get plateEditorSavedSuccess => 'Asset settings saved';

  @override
  String get plateEditorBackToPlates => 'Back to plates';

  @override
  String get adminShowLess => 'Show less';

  @override
  String adminTipRowSubtitle(String orderId, String hours) {
    return 'ID: $orderId · $hours hrs';
  }

  @override
  String get rbacRoleDefaultsSaved => 'Role defaults saved';

  @override
  String get rbacNoPendingChanges => 'No pending permission changes to save';

  @override
  String get rbacResetDefaults => 'Reset defaults';

  @override
  String get rbacResetDefaultsSuccess => 'Reset to factory defaults';

  @override
  String rbacUsersWithRoleLink(int count) {
    return '$count users with this role — view list';
  }

  @override
  String get reportFilterPageSubtitle =>
      'The same filter used inside the reports hub, available as a full admin page.';

  @override
  String get reviewModerationAlreadyProcessed =>
      'This review was already moderated.';

  @override
  String get reviewModerationRejectConfirmTitle => 'Reject review?';

  @override
  String get reviewModerationRejectConfirmMessage =>
      'The review will be hidden from the public menu.';

  @override
  String get reviewModerationFlagConfirmTitle => 'Flag review?';

  @override
  String get reviewModerationFlagConfirmMessage =>
      'The review will be marked for support follow-up.';

  @override
  String get supportFaqDeleteConfirmTitle => 'Delete FAQ entry?';

  @override
  String get supportFaqDeleteConfirmMessage =>
      'This entry will be removed from the public FAQ list.';

  @override
  String get supportFaqDeleteBlocked =>
      'Keep at least one FAQ entry in the editor.';

  @override
  String get supportFaqDeleted => 'FAQ entry removed';

  @override
  String get rbacResetConfirmTitle => 'Reset role defaults?';

  @override
  String get rbacResetConfirmMessage =>
      'All permissions for this role will return to factory defaults.';

  @override
  String get rbacAllPermissionsDenied =>
      'At least one permission must be allowed before saving.';

  @override
  String get adminTipPoolEmpty =>
      'Tip pool must be greater than zero before approval.';

  @override
  String get reportFilterAtLeastOneModule =>
      'Select at least one report module.';

  @override
  String get marketingBlogUnpublishConfirmTitle => 'Move post to draft?';

  @override
  String get marketingBlogUnpublishConfirmMessage =>
      'Published posts will no longer appear on the blog.';

  @override
  String get marketingBlogDeleteConfirmTitle => 'Delete blog post?';

  @override
  String get marketingBlogDeleteConfirmMessage =>
      'This removes the post from marketing and the customer blog.';

  @override
  String get marketingBlogDraftNeedsTitle =>
      'Add a title before publishing this draft.';

  @override
  String get opsKitchenBoardRefreshed => 'Kitchen pass refreshed.';

  @override
  String get opsInventoryItemRefreshed => 'Inventory item refreshed.';

  @override
  String get inventoryItemSelectTitle => 'Select an inventory item';

  @override
  String get inventoryItemSelectBody =>
      'Open an alert from the inventory dashboard to review stock, supplier, and adjustment history.';

  @override
  String get inventoryItemOpenDashboard => 'Open inventory dashboard';

  @override
  String get opsStaffTipsRefreshed => 'Daily tips refreshed.';

  @override
  String get opsCashierHistoryRefreshed => 'Transaction history refreshed.';

  @override
  String get supportChatPriorityHigh => 'High';

  @override
  String get supportChatPriorityNormal => 'Normal';

  @override
  String supportChatWaitingMinutes(int minutes, String id) {
    return 'Waiting $minutes min · $id';
  }

  @override
  String get supportChatAcceptAction => 'Accept chat';

  @override
  String get supportChatAccepted => 'Chat accepted';

  @override
  String supportChatAcceptBodyAr(String customer, String id) {
    return 'محادثة مباشرة مع $customer ($id)';
  }

  @override
  String supportChatAcceptBodyEn(String customer, String id) {
    return 'Live chat with $customer ($id)';
  }

  @override
  String get supportChatAcceptReplyAr => 'تم قبول المحادثة من قائمة الانتظار.';

  @override
  String get supportChatAcceptReplyEn => 'Chat accepted from the queue.';

  @override
  String get supportChatAcceptFailed => 'Chat is no longer in the queue.';

  @override
  String get supportOrderLookupReadOnlyBanner =>
      'Read-only lookup — orders cannot be edited';

  @override
  String get supportOrderLookupSearchLabel => 'Order # or customer';

  @override
  String get supportOrderLookupSearchHint => 'e.g. 4821';

  @override
  String get supportOrderLookupNoResults => 'No matching orders';

  @override
  String get staffTipHistoryNoData =>
      'No tip history rows to export for this range.';

  @override
  String get marketingCalendarSelectDay =>
      'Select a day on the calendar first.';

  @override
  String get marketingCalendarScheduleConfirmTitle => 'Schedule campaign?';

  @override
  String get marketingCalendarScheduleConfirmMessage =>
      'Adds an internal planning slot only — does not publish to customers.';

  @override
  String get marketingCalendarScheduledSuccess => 'Campaign slot scheduled';

  @override
  String get marketingPushScheduleConfirmTitle => 'Schedule push send?';

  @override
  String get marketingPushScheduleConfirmMessage =>
      'Schedules an in-app customer notification.';

  @override
  String get marketingPushDeleteConfirmTitle => 'Delete push campaign?';

  @override
  String get marketingPushDeleteConfirmMessage =>
      'This removes the draft or scheduled campaign from the marketing list.';

  @override
  String get marketingPushBodyRequired =>
      'Add notification body text before scheduling.';

  @override
  String get marketingPushScheduleFailed =>
      'Campaign draft could not be scheduled.';

  @override
  String get opsDeliveryOrderRefreshed => 'Delivery order refreshed.';

  @override
  String get marketingSocialMetaBusiness => 'Meta Business';

  @override
  String get marketingSocialInstagramPlatform => 'Instagram';

  @override
  String get marketingSocialMetaSubtitle => 'Restaurant Facebook page';

  @override
  String get marketingSocialInstagramSubtitle => 'Posts & reels publishing';

  @override
  String get permissionMatrixEmpty => 'No capabilities apply to this role.';

  @override
  String get permissionAccessFull => 'Full';

  @override
  String get permissionAccessRead => 'Read';

  @override
  String get permissionAccessDenied => 'Denied';

  @override
  String get permissionAccessPostponed => 'Postponed';

  @override
  String rbacPostponedUntil(String date) {
    return 'Postponed until $date';
  }

  @override
  String get rbacSelectPostponeDate => 'Select postpone date';

  @override
  String get rbacPostponeDateRequired =>
      'Choose a date when postponing access.';

  @override
  String get rbacOpenRoleDefaults => 'Open role defaults in Screen A';

  @override
  String get loginDemoModeNotice =>
      'Use hub shortcuts to open a role workspace.';

  @override
  String get loginDemoSignedIn => 'Signed in successfully.';

  @override
  String get roleSelectionNoApprovedRoles =>
      'No approved roles yet. Contact your app administrator.';

  @override
  String get registerViewTerms => 'View terms';

  @override
  String get rbacRoleGroupManagement => 'Management';

  @override
  String get rbacRoleGroupSpecialist => 'Specialist';

  @override
  String get rbacRoleGroupOperations => 'Operations';

  @override
  String get rbacRoleGroupManagementSpecialist => 'Management & specialist';

  @override
  String get customerDiscountsEmptyTitle => 'No active discounts';

  @override
  String get customerDiscountsEmptyBody =>
      'Check back soon or browse the menu for current offers.';

  @override
  String get customerPromoNotFoundTitle => 'Promotion not found';

  @override
  String get customerPromoNotFoundBody =>
      'This offer may have expired or been removed.';

  @override
  String get promoApplyUnavailable =>
      'This promotion cannot be applied to your cart right now.';

  @override
  String get permSupportRefunds => 'Order refunds & cancel';

  @override
  String get permSupportSla => 'SLA & shift handover';

  @override
  String get permMarketingMenuPricing => 'Menu price publish';

  @override
  String get permMarketingPublish => 'Campaign publish';

  @override
  String get permOperatorCampaignApprove => 'Campaign co-approval';

  @override
  String get supportSlaAtRisk => 'SLA at risk';

  @override
  String get supportSlaBreached => 'SLA breached';

  @override
  String get supportResolvedToday => 'Resolved (24h)';

  @override
  String get supportAvgResponseTime => 'Avg response';

  @override
  String supportAvgResponseMinutes(int minutes) {
    return '$minutes min';
  }

  @override
  String get supportShiftHandoverTitle => 'Shift handover';

  @override
  String get supportShiftHandoverHint =>
      'Open tickets, blockers, and notes for the next agent…';

  @override
  String get supportShiftHandoverSaved => 'Handover notes saved';

  @override
  String supportShiftHandoverLast(String when) {
    return 'Last handover: $when';
  }

  @override
  String get supportAgentPerformanceTitle => 'Agent performance (today)';

  @override
  String get supportTicketCustomerPhone => 'Customer phone';

  @override
  String get supportTicketCustomerAddress => 'Customer address';

  @override
  String get supportTicketEscalateOperator => 'Escalate to Operator';

  @override
  String get supportTicketEscalateCashier => 'Escalate to Cashier';

  @override
  String supportTicketEscalated(String target) {
    return 'Ticket escalated to $target';
  }

  @override
  String get supportOrderLookupActionsBanner =>
      'Support can issue refunds and cancel orders.';

  @override
  String get supportOrderRefundAction => 'Issue refund';

  @override
  String get supportOrderCancelAction => 'Cancel order';

  @override
  String get supportOrderRefundConfirmTitle => 'Issue refund?';

  @override
  String get supportOrderRefundConfirmMessage =>
      'A refund will be logged for audit.';

  @override
  String get supportOrderCancelConfirmTitle => 'Cancel order?';

  @override
  String get supportOrderCancelConfirmMessage =>
      'This marks the order cancelled and logs audit.';

  @override
  String get supportOrderRefunded => 'Refund recorded';

  @override
  String get supportOrderCancelled => 'Order cancelled';

  @override
  String get supportOrderAlreadyCancelled => 'Order is already cancelled';

  @override
  String get marketingPublishSubmit => 'Submit for operator approval';

  @override
  String get marketingPublishSubmitted => 'Sent to operator for co-approval';

  @override
  String get marketingPublishPendingTitle => 'Pending operator approval';

  @override
  String get marketingOfferActiveToggle => 'Customer visible';

  @override
  String get marketingOfferActiveOn => 'Live';

  @override
  String get marketingOfferActiveOff => 'Hidden';

  @override
  String get marketingPublishApprove => 'Approve & publish';

  @override
  String get marketingPublishReject => 'Reject';

  @override
  String get marketingPublishApproved => 'Campaign published';

  @override
  String get marketingPublishRejected => 'Campaign rejected';

  @override
  String get marketingSubscriptionContentOnly =>
      'Manage subscription content and billing options.';

  @override
  String get marketingSubscriptionValue => 'Subscription value';

  @override
  String marketingSubscriptionMealsTotal(int count) {
    return '$count meals';
  }

  @override
  String marketingSubscriptionRegularSum(String amount) {
    return 'Regular sum: $amount';
  }

  @override
  String marketingSubscriptionSaving(String amount) {
    return 'You save: $amount';
  }

  @override
  String get marketingSubscriptionCoverage => 'Meals per day';

  @override
  String marketingSubscriptionUncovered(int count) {
    return '$count days without meals';
  }

  @override
  String marketingSubscriptionDayMeals(int day, int count) {
    return 'Day $day: $count meals';
  }

  @override
  String get marketingSubscriptionFreeDelivery => 'Free delivery';

  @override
  String marketingSubscriptionEditDay(int day) {
    return 'Day $day';
  }

  @override
  String get marketingSubscriptionPickMeals => 'Pick meals for this day';

  @override
  String get auditEventRefund => 'Refund';

  @override
  String get auditEventOrderCancel => 'Order cancel';

  @override
  String get auditEventPriceChange => 'Price change';

  @override
  String get auditEventOfferPublished => 'Offer published';

  @override
  String get marketingMenuPricePublishTitle => 'Menu price publish';

  @override
  String get marketingMenuPricePublishBanner =>
      'Marketing can update base menu prices. Each change is logged for operator audit before publish.';

  @override
  String get operatorEscalationsInboxTitle => 'Support escalations';

  @override
  String get operatorEscalationsInboxSubtitle =>
      'Tickets escalated from Support — refund, cancel, or policy requests';

  @override
  String get operatorEscalationAcknowledge => 'Acknowledge';

  @override
  String get operatorEscalationAcknowledged => 'Escalation acknowledged';

  @override
  String get operatorEscalationOpenTicket => 'Open ticket';

  @override
  String operatorEscalationTarget(String target) {
    return 'Escalated to $target';
  }

  @override
  String get marketingHomeOpsTitle => 'Today’s marketing pulse';

  @override
  String get marketingVisitorsToday => 'Visitors today';

  @override
  String get marketingPurchasesToday => 'Purchases today';

  @override
  String get marketingActiveCampaigns => 'Active campaigns';

  @override
  String get marketingTopSellers => 'Top 10 purchasing items';

  @override
  String get marketingTopRatings => 'Top ratings';

  @override
  String marketingPendingApprovals(int count) {
    return '$count need approval';
  }

  @override
  String get marketingSocialInteractions => 'Social interactions';

  @override
  String get marketingInsightFilterAll => 'All';

  @override
  String get marketingInsightFilterPending => 'Pending approval';

  @override
  String get marketingInsightFilterApproved => 'Approved';

  @override
  String get marketingInsightOpenEdit => 'Open editor';

  @override
  String get marketingInsightPurchasesHint =>
      'Filter by day range — tap a row for related product';

  @override
  String get marketingInsightVisitorsHint =>
      'Visitor volume by segment — tap for related campaign';

  @override
  String get marketingProductSearchHint => 'Search product by name';

  @override
  String get marketingDiscountProductPoints => 'Product points (locked)';

  @override
  String get marketingProductCreate => 'Create product';

  @override
  String get marketingProductPreviewTab => 'Preview';

  @override
  String get marketingProductDetailsTitle => 'Product details';

  @override
  String get marketingLoyaltyCreateSheetTitle => 'New loyalty occasion';

  @override
  String get marketingSocialMonitorTitle => 'Social monitoring';

  @override
  String get marketingSocialUsers => 'Users';

  @override
  String get marketingSocialBlogs => 'Blogs';

  @override
  String get marketingSocialActionsToday => 'Actions today';

  @override
  String get marketingSocialActionsWeek => 'Actions this week';

  @override
  String get marketingSocialNoIntegration =>
      'Monitoring only — app integrations are managed elsewhere.';

  @override
  String get marketingPromoCodesTitle => 'Promotion codes';

  @override
  String get marketingPromoCodeCreate => 'Create promo code';

  @override
  String get marketingPromoCodeValue => 'Code';

  @override
  String get marketingPromoCodeCategory => 'Category';

  @override
  String get marketingPromoCategoryDiscount => 'Discount';

  @override
  String get marketingPromoCategoryAddPoints => 'Add points';

  @override
  String get marketingPromoCategoryFreeMeal => 'Free meal';

  @override
  String get marketingPromoCategoryInviteFriends => 'Invite friends';

  @override
  String get marketingBlogPlatforms => 'Posted to';

  @override
  String get marketingBlogPickPlatforms => 'Social platforms';

  @override
  String get brandingSettingsTitle => 'App branding';

  @override
  String get brandingSettingsSubtitle =>
      'Name, slogan, and logo shown on splash and login (EN + AR).';

  @override
  String get brandingNameEn => 'App name (English)';

  @override
  String get brandingNameAr => 'App name (Arabic)';

  @override
  String get brandingSloganEn => 'Slogan (English)';

  @override
  String get brandingSloganAr => 'Slogan (Arabic)';

  @override
  String get brandingLogoUrl => 'Logo image URL';

  @override
  String get brandingLogoUrlHint => 'Leave empty for default logo';

  @override
  String get brandingSave => 'Save branding';

  @override
  String get brandingReset => 'Reset to defaults';

  @override
  String get brandingSaved => 'Branding updated';

  @override
  String get drawerGroupHub => 'Hub';

  @override
  String get drawerGroupOrders => 'Orders';

  @override
  String get drawerGroupMenu => 'Menu';

  @override
  String get drawerGroupPeople => 'People';

  @override
  String get drawerGroupMoney => 'Money';

  @override
  String get drawerGroupSettings => 'Settings';

  @override
  String get drawerGroupPromotions => 'Promotions';

  @override
  String get drawerGroupCatalog => 'Catalog';

  @override
  String get drawerGroupLoyalty => 'Loyalty';

  @override
  String get drawerGroupContent => 'Content';

  @override
  String get cartMoreFulfillmentOptions => 'More delivery options';

  @override
  String get cartHideFulfillmentOptions => 'Show fewer options';
}

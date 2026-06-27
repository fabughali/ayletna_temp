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
  String get authLoginRequiredFields => 'Enter your phone or email and password.';

  @override
  String get authForgotIdentifierRequired => 'Enter your registered phone or email.';

  @override
  String get authOtpInvalid => 'Enter the 6-digit code sent to your phone.';

  @override
  String get authPasswordMismatch => 'Passwords do not match.';

  @override
  String get authRegisterFieldsRequired => 'Fill in all required fields and accept the terms.';

  @override
  String get authOtpResent => 'A new verification code was sent.';

  @override
  String get authPasswordResetSuccess => 'Password reset. You can sign in now.';

  @override
  String get roleSelectionNotApproved => 'This role is not approved for your account.';

  @override
  String get pendingApprovalNote => 'Operational roles require operator approval';

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
  String get checkoutAppreciationSubtitle => 'Your kindness fuels our culinary team.';

  @override
  String get checkoutFairWageNote => '100% of your tips are shared equally among our kitchen and delivery staff as part of our fair-wage commitment.';

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
  String get homeFeaturedTitle => 'Featured';

  @override
  String get categoryEyebrow => 'Category';

  @override
  String get categoryMezzeTitle => 'Cold Mezze & Appetizers';

  @override
  String get categoryMezzeDescription => 'Discover our selection of traditional Levantine starters, prepared daily with fresh ingredients and authentic Jordanian flavors.';

  @override
  String get categoryShawarmaHeroTitle => 'Legendary Beef Shawarma';

  @override
  String get categoryShawarmaHeroDescription => 'Slow-roasted premium beef marinated in traditional spices, served with our signature garlic whip.';

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
  String get deliveryHomeAddress => 'Villa 42, Al-Reem Street, Sweifieh, Amman, Jordan';

  @override
  String get deliveryWorkAddress => 'The Business Park, Building 5, 3rd Floor, King Hussein Business Park, Amman';

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
  String get deliveryExpressZoneNote => 'Your current selection is within our 15-minute express zone.';

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
  String get deliveryReturnsSubtitle => 'Review all completed tray collections and financial settlements.';

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
  String get platedReturnReminderBody => 'Please prepare the tray for pickup after your meal.';

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
  String get depositConfigurationSubtitle => 'Manage global deposit rates and automated return policy enforcement.';

  @override
  String get depositGlobalTitle => 'Global Deposit';

  @override
  String get depositGlobalAmountLabel => 'Global Deposit Amount (JOD)';

  @override
  String get depositGlobalHelp => 'This amount is automatically added to all takeaway and delivery orders containing trays.';

  @override
  String get depositWarning => 'Increasing the deposit amount will update all new orders instantly. Active pending orders will retain their original deposit value.';

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
  String get screenWallet => 'Wallet';

  @override
  String get screenLoyalty => 'Loyalty';

  @override
  String get screenRewardsCatalog => 'Rewards';

  @override
  String get screenRewardsHistory => 'Rewards history';

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
  String get demoActionTag => 'Demo';

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
  String get integrationsSecurityNote => 'Fill the credentials your provider gave you. Secrets are stored securely in production (Supabase Vault) — never in app code.';

  @override
  String get integrationsSaveAll => 'Save all integrations';

  @override
  String get integrationsSaveSuccess => 'Integration settings saved.';

  @override
  String get integrationsTestConnection => 'Test connection';

  @override
  String get integrationsTestSuccess => 'Connection test passed (mock).';

  @override
  String get integrationsTestIncomplete => 'Complete the required fields for this section first.';

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
  String get integrationsSupabaseSubtitle => 'Database, auth, realtime, and edge functions.';

  @override
  String get integrationsSupabaseUrl => 'Project URL';

  @override
  String get integrationsSupabaseUrlHint => 'https://xxxxx.supabase.co';

  @override
  String get integrationsSupabaseAnonKey => 'Anon (public) key';

  @override
  String get integrationsSupabaseAnonKeyHint => 'eyJhbGciOiJIUzI1NiIsInR5cCI6...';

  @override
  String get integrationsSupabaseServiceRoleKey => 'Service role key (server only)';

  @override
  String get integrationsSupabaseServiceRoleKeyHint => 'For Edge Functions / backend deploy';

  @override
  String get integrationsSupabaseProjectRef => 'Project reference ID';

  @override
  String get integrationsSupabaseProjectRefHint => 'e.g. abcdefghijklmnop';

  @override
  String get integrationsSmsTitle => 'SMS provider';

  @override
  String get integrationsSmsSubtitle => 'OTP codes and plate return SMS (Unifonic, Twilio, etc.).';

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
  String get integrationsWhatsappSubtitle => 'Friendly return reminders and customer updates.';

  @override
  String get integrationsWhatsappBusinessAccountId => 'Business account ID';

  @override
  String get integrationsWhatsappBusinessAccountIdHint => 'Meta Business account ID';

  @override
  String get integrationsWhatsappPhoneNumberId => 'Phone number ID';

  @override
  String get integrationsWhatsappPhoneNumberIdHint => 'WhatsApp Cloud API phone number ID';

  @override
  String get integrationsWhatsappAccessToken => 'Permanent access token';

  @override
  String get integrationsWhatsappAccessTokenHint => 'System user token from Meta';

  @override
  String get integrationsWhatsappWebhookVerifyToken => 'Webhook verify token';

  @override
  String get integrationsWhatsappWebhookVerifyTokenHint => 'Random string for webhook verification';

  @override
  String get integrationsTelephonyTitle => 'Phone & OTP';

  @override
  String get integrationsTelephonySubtitle => 'Support line, country code, and OTP sender number.';

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
  String get integrationsOtpSenderNumberHint => 'Registered sender for verification SMS';

  @override
  String get integrationsPaymentsTitle => 'Payment gateways';

  @override
  String get integrationsPaymentsSubtitle => 'Stripe, Google Pay, Apple Pay, regional gateways, and licensed wallet.';

  @override
  String get integrationsPaymentGatewayProvider => 'Primary gateway';

  @override
  String get integrationsPaymentGatewayProviderHint => 'Stripe / MyFatoorah / HyperPay / Checkout.com';

  @override
  String get integrationsStripePublishableKey => 'Stripe publishable key';

  @override
  String get integrationsStripePublishableKeyHint => 'pk_live_... or pk_test_...';

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
  String get integrationsGooglePayMerchantIdHint => 'Google Pay merchant identifier';

  @override
  String get integrationsGooglePayMerchantName => 'Google Pay merchant name';

  @override
  String get integrationsGooglePayMerchantNameHint => 'Ayletna Restaurant';

  @override
  String get integrationsApplePayMerchantId => 'Apple Pay merchant ID';

  @override
  String get integrationsApplePayMerchantIdHint => 'merchant.com.ayletna.restaurant';

  @override
  String get integrationsPaymentGatewayApiKey => 'Regional gateway API key';

  @override
  String get integrationsPaymentGatewayApiKeyHint => 'MyFatoorah / HyperPay API key';

  @override
  String get integrationsPaymentGatewayMerchantId => 'Regional merchant ID';

  @override
  String get integrationsPaymentGatewayMerchantIdHint => 'Merchant or terminal ID';

  @override
  String get integrationsPaymentGatewayWebhookUrl => 'Payment webhook URL';

  @override
  String get integrationsPaymentGatewayWebhookUrlHint => 'https://your-project.supabase.co/functions/v1/payment-webhook';

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
  String get integrationsWalletDeepLinkSchemeHint => 'ayletna://payment/callback';

  @override
  String get integrationsWalletWebhookSecret => 'Wallet webhook secret';

  @override
  String get integrationsWalletWebhookSecretHint => 'Shared secret for wallet callbacks';

  @override
  String get integrationsAiTitle => 'AI agent';

  @override
  String get integrationsAiSubtitle => 'Support chat and operator assistants (ChatGPT, Qwen, etc.).';

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
  String get integrationsAiModelNameHint => 'gpt-4o / qwen-max / claude-3-5-sonnet';

  @override
  String get integrationsAiBaseUrl => 'API base URL (optional)';

  @override
  String get integrationsAiBaseUrlHint => 'https://api.openai.com/v1';

  @override
  String get integrationsAiSupportChatEnabled => 'Enable AI support chat';

  @override
  String get integrationsAiSupportChatEnabledHint => 'Route customer support chat through the configured agent';

  @override
  String get integrationsOtherTitle => 'Other services';

  @override
  String get integrationsOtherSubtitle => 'Maps, push notifications, email, and monitoring.';

  @override
  String get integrationsGoogleMapsApiKey => 'Google Maps API key';

  @override
  String get integrationsGoogleMapsApiKeyHint => 'Restricted by bundle / referrer';

  @override
  String get integrationsFcmServerKey => 'FCM server key';

  @override
  String get integrationsFcmServerKeyHint => 'Firebase Cloud Messaging server key';

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
  String get integrationsAttendanceWifiSubtitle => 'Staff check-in/out only works on this router WiFi — not mobile data or outside networks.';

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
  String get attendanceWifiCheckFailed => 'Could not read WiFi status. Try again.';

  @override
  String get attendanceWifiNotConfigured => 'Admin has not registered restaurant WiFi yet. Ask the operator to configure it in App Integrations.';

  @override
  String get attendanceWifiRequired => 'Connect to the restaurant WiFi to record attendance. Mobile data and outside networks are blocked.';

  @override
  String attendanceWifiConnected(String ssid) {
    return 'Connected to restaurant WiFi: $ssid';
  }

  @override
  String attendanceWifiDemoMatched(String ssid) {
    return 'Demo mode: treating as restaurant WiFi ($ssid)';
  }

  @override
  String get attendanceWifiWebDemoNote => 'Web prototype simulates WiFi match when demo mode is on. Production uses the mobile app on restaurant WiFi.';

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
  String get attendanceFingerprintComingHint => 'Tap fingerprint to confirm arrival time';

  @override
  String get attendanceFingerprintLeavingHint => 'Tap fingerprint to confirm leaving time';

  @override
  String get attendanceBiometricTitle => 'Fingerprint approval';

  @override
  String get attendanceBiometricConfirm => 'Approve with fingerprint';

  @override
  String get attendanceBiometricCheckInReason => 'Confirm your arrival at the restaurant';

  @override
  String get attendanceBiometricCheckOutReason => 'Confirm you are leaving the restaurant';

  @override
  String get attendanceBiometricUnavailable => 'Biometric authentication is not available on this device.';

  @override
  String get attendanceBiometricFailed => 'Fingerprint verification failed. Try again.';

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
  String get otpVerificationSubtitle => 'Enter the 6-digit code we sent to your phone.';

  @override
  String get screenPaymentSubtitle => 'Choose how you want to pay for this order.';

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
  String get cashierMenuSearchHint => 'Search menu item, offer, combo, or description...';

  @override
  String get cashierPromotionsTitle => 'Offers, combos, discounts, subscriptions';

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
  String get cashierSplitTotalMismatch => 'Split amounts must equal the amount payable.';

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
  String get cashierElectronicTicketSent => 'Electronic ticket sent to client phone via WhatsApp';

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
  String get cashierPostponeSaved => 'Order postponed — resume from cashier history';

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
  String get financialTotalsMismatch => 'Totals do not match ledger — recalculate before closing.';

  @override
  String get screenFinancialCalculationSubtitle => 'Daily revenue, tips, and deposit totals.';

  @override
  String platedBreakageCost(String amount) {
    return 'Missing plates will incur a $amount JOD breakage fee.';
  }

  @override
  String get screenPlatedReturnProcessSubtitle => 'Count returned trays and note any missing items.';

  @override
  String get profileAccountSection => 'Account';

  @override
  String get profileOrdersSection => 'Orders & rewards';

  @override
  String get platedDeliveryDepositNote => 'A refundable deposit applies to plated delivery orders.';

  @override
  String get adminInventoryLowTitle => 'Inventory Low: Ribeye Steak';

  @override
  String get adminInventoryLowBody => 'Only 14 units remaining. Projected to run out in 2 hours.';

  @override
  String get adminRestockAction => 'Restock';

  @override
  String get adminPendingTipTitle => 'Pending Tip Distribution';

  @override
  String get adminPendingTipBody => '12 transactions awaiting shift closure for distribution.';

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
  String get adminMarketInsightBody => 'Demand for plated dishes is up 22% this evening compared to last Friday. Recommend boosting appetizer prep.';

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
  String get financialWhyBody => 'Our profit distribution engine ensures every dinar is accounted for by separating gross revenue from distributable profit, excluding staff tips, and holding refundable deposits outside the owner/operator split.';

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
  String get forgotPasswordSubtitle => 'Enter your registered phone or email to receive a reset code';

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
  String get guestRoyalMansafSubtitle => 'Authentic Karak jameed and tender local lamb. 15% off for first-time guests.';

  @override
  String get guestWeekendFeast => 'Weekend Feast';

  @override
  String get guestWeekendFeastSubtitle => 'Order any appetizer and main to get a free Jallab drink.';

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
  String get homeSearchHint => 'Search for Mansaf, Shawarma or more...';

  @override
  String get screenSearch => 'Search';

  @override
  String get searchTitle => 'Find your next meal';

  @override
  String get searchSubtitle => 'Search the Ayletna menu by dish, category, or ingredient-style description.';

  @override
  String get searchStartTitle => 'Type a dish name';

  @override
  String get searchStartBody => 'Try shawarma, hummus, pizza, falafel, burger, or any craving from the menu.';

  @override
  String get searchEmptyTitle => 'No dishes found';

  @override
  String get searchEmptyBody => 'Try a different dish name or browse the full menu categories.';

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
  String get homeZeroWasteSubtitle => 'Get your feast served on authentic clay plates. 5 JOD refundable deposit per plate.';

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
  String get homeSustainabilityBody => 'Choose the Plated option for an eco-friendly experience. A small deposit for our premium clayware will be added and fully refunded when we collect the plates after your meal.';

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
  String get inventoryLowStockTrigger => 'Triggers Low Stock alert at this level.';

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
  String get prepFriesSpecs => 'Parmesan Dust • Rosemary Sprig • Truffle Aioli Side';

  @override
  String get prepHouseCaesar => 'House Caesar Salad';

  @override
  String get prepCaesarSpecs => 'Dressing on the side • No Anchovies';

  @override
  String get prepKitchenNotes => 'Kitchen Notes';

  @override
  String get prepKitchenNoteBody => 'Birthday celebration at Table 14. Please ensure all plated dishes go out simultaneously. Guest in Seat 2 has a severe onion allergy; ensure strict cross-contamination protocol for the Wagyu Burgers.';

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
  String get languageWelcomeTitle => 'Welcome';

  @override
  String get languageWelcomeSubtitle => 'Choose your preferred language to continue';

  @override
  String get languageEnglishSubtitle => 'Western Interface';

  @override
  String get languageArabicSubtitle => 'Arabic Interface';

  @override
  String get languageAccessGateway => 'Universal Access Gateway';

  @override
  String get loginWelcomeBack => 'Welcome back';

  @override
  String get loginOperationalSubtitle => 'Order your favorite meals, track your feast, and come back to what you love.';

  @override
  String get loginPhoneOrEmail => 'Phone or Email';

  @override
  String get loginEmailHint => 'e.g. guest@ayletna.com';

  @override
  String get loginAction => 'Login';

  @override
  String get loginOr => 'or';

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
  String get loyaltyLocked => 'Locked';

  @override
  String get loyaltySignaturePlatter => 'Signature BBQ Platter';

  @override
  String get loyaltySignaturePlatterDesc => 'Redeem for a full grill platter with three sides.';

  @override
  String get loyaltyLargePizza => 'Any Large Pizza';

  @override
  String get loyaltyLargePizzaDesc => 'Choose any large flatbread from our family oven menu.';

  @override
  String get loyaltyFreeDessert => 'Free Dessert';

  @override
  String get loyaltyFreeDessertDesc => 'A sweet treat from our pastry chef\'s daily selection.';

  @override
  String get loyaltyChefTasting => 'Chef\'s Tasting for Two';

  @override
  String get loyaltyChefTastingDesc => 'Private tasting experience curated by our executive chef.';

  @override
  String loyaltyPointsShort(String points) {
    return '$points pts';
  }

  @override
  String get loyaltyDine => 'Dine';

  @override
  String get loyaltyDineDesc => 'Earn 10 points for every 1 JOD spent at any Ayletna branch.';

  @override
  String get loyaltyCollect => 'Collect';

  @override
  String get loyaltyCollectDesc => 'Watch your points grow and unlock premium tier benefits.';

  @override
  String get loyaltyEnjoy => 'Enjoy';

  @override
  String get loyaltyEnjoyDesc => 'Redeem your hard-earned points for exclusive rewards.';

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
  String get menuManagementSubtitle => 'Manage your digital menu items, pricing, and live availability.';

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
  String get cartGuestSignInPrompt => 'Sign in to place your order and track delivery in real time.';

  @override
  String get cartCheckoutStepBasket => 'Basket';

  @override
  String get cartCheckoutStepFulfillment => 'Fulfillment';

  @override
  String get cartCheckoutStepPayment => 'Payment';

  @override
  String get cartCheckoutStepReview => 'Review';

  @override
  String get demoModeBanner => 'Demo mode — actions use mock data and are not saved.';

  @override
  String get cartTermsNotice => 'By clicking, you agree to our Terms of Service.';

  @override
  String get cartViewItems => 'View items';

  @override
  String get cartFulfillmentTitle => 'Choose fulfillment';

  @override
  String get cartFulfillmentSubtitle => 'Choose the service method directly in the cart without opening a separate screen.';

  @override
  String get cartGroupDeliveryTitle => 'Group delivery';

  @override
  String get cartGroupDeliveryBody => 'Wait for a nearby order in the same area to reduce delivery cost and improve route efficiency.';

  @override
  String get cartTermsAndConditions => 'Terms and conditions';

  @override
  String get cartSelectedAddress => 'Selected address';

  @override
  String get cartAddressRequired => 'Choose a default delivery address before checkout.';

  @override
  String get cartChooseAddress => 'Choose address';

  @override
  String get cartPaymentType => 'Payment type';

  @override
  String get cartTipTitle => 'Add a tip';

  @override
  String get cartTipSubtitle => 'Optional appreciation for the kitchen and delivery team.';

  @override
  String get cartNoTip => 'No tip';

  @override
  String get cartHelpTitle => 'Need help with your order?';

  @override
  String get cartChatWithUs => 'Chat with us';

  @override
  String get supportHeroTitle => 'How can we help?';

  @override
  String get supportHeroBody => 'Choose the fastest mock support channel for order questions, delivery updates, or payment help.';

  @override
  String get supportLiveChatTitle => 'Live chat';

  @override
  String get supportLiveChatBody => 'Start a quick conversation with the service team.';

  @override
  String get supportCallTitle => 'Call restaurant';

  @override
  String get supportCallBody => 'Speak with the front desk about urgent order changes.';

  @override
  String get supportWhatsappTitle => 'WhatsApp support';

  @override
  String get supportWhatsappBody => 'Send a message with your order details and preferred contact time.';

  @override
  String get supportOrderHelpTitle => 'Order help';

  @override
  String get supportOrderHelpBody => 'Use this page for cart, delivery, payment, and plated-return questions.';

  @override
  String get supportFaqTitle => 'FAQ';

  @override
  String get supportFaqBody => 'Browse common delivery, payment, and plated-return answers.';

  @override
  String get supportTicketsTitle => 'Support tickets';

  @override
  String get supportTicketsSubtitle => 'Track open and resolved mock support requests.';

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
  String get supportTicketRemarkHint => 'Write a note about the support response...';

  @override
  String get supportTicketSubmitRating => 'Submit rating';

  @override
  String get supportTicketRatingSaved => 'Ticket rating saved.';

  @override
  String get supportNewTicketTitle => 'Live chat ticket';

  @override
  String get supportNewTicketBody => 'A new chat session was opened with the customer care team.';

  @override
  String get supportTicketOpened => 'New support ticket opened.';

  @override
  String get supportChatHeroTitle => 'Live support chat';

  @override
  String get supportChatHeroBody => 'The agent starts with chat and opens a ticket only when follow-up is needed.';

  @override
  String get supportChatActiveSession => 'Active chat session';

  @override
  String get supportChatNoTicketYet => 'No ticket opened yet';

  @override
  String get supportChatAgentGreeting => 'Welcome to Ayletna support. Tell me what happened and I will check if this needs a ticket.';

  @override
  String get supportChatCustomerSample => 'I need help with my active order.';

  @override
  String get supportChatAgentDecision => 'I can help here first. If the issue needs restaurant follow-up, I will open a ticket and keep it visible in Support.';

  @override
  String get supportChatAgentName => 'Ayletna Agent';

  @override
  String get supportChatCustomerName => 'You';

  @override
  String get supportChatAgentTicketNote => 'Only the support agent can open a follow-up ticket after reviewing the chat.';

  @override
  String get supportChatMessageLabel => 'Message';

  @override
  String get supportChatMessageHint => 'Write your question or order note...';

  @override
  String get supportChatSend => 'Send message';

  @override
  String get supportChatOpenTicket => 'Open ticket if needed';

  @override
  String get supportAdminSetupNote => 'Restaurant phone and WhatsApp numbers are preconfigured for mockup and can be edited later from admin settings.';

  @override
  String get supportExternalActionFallback => 'Could not open this action. Use the displayed contact details.';

  @override
  String get screenFaq => 'FAQ';

  @override
  String get faqHeroTitle => 'Frequently asked questions';

  @override
  String get faqHeroBody => 'Quick answers before opening a support ticket.';

  @override
  String get faqDeliveryTitle => 'How do delivery updates work?';

  @override
  String get faqDeliveryBody => 'Active orders show a timeline. When the order is on the way, the driver contact button becomes available.';

  @override
  String get faqPaymentTitle => 'Which payment methods are supported?';

  @override
  String get faqPaymentBody => 'The mock checkout currently shows card and cash flows, with wallet/payment screens kept for future configuration.';

  @override
  String get faqPlatedTitle => 'How does plated delivery work?';

  @override
  String get faqPlatedBody => 'Reusable trays include a refundable deposit and follow the plated-return reminder flow.';

  @override
  String get cartMargheritaPremium => 'Margherita Premium';

  @override
  String get cartMargheritaPremiumDesc => 'Extra Buffalo Mozzarella, Fresh Basil';

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
  String get orderHistorySubtitle => 'Manage your past dining experiences and re-order your favorites.';

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
  String get orderHistoryWeekendSubtitle => 'Get 15% off on your next re-order.';

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
  String get orderHistoryDriverContactBody => 'Your order is on the way. Call the driver if you need to coordinate delivery.';

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
  String get profileEpicureanTier => 'Epicurean Tier';

  @override
  String get profileGoldStatus => 'Gold Status';

  @override
  String get profileSavorPoints => 'Savor Points';

  @override
  String get profilePointsValue => '4,850';

  @override
  String get profileTierProgress => '1,150 points until Platinum Tier benefits.';

  @override
  String get profileRewardsCatalog => 'Rewards Catalog';

  @override
  String get profilePointsHistory => 'Points activity';

  @override
  String get profilePointsHistorySubtitle => 'Recent reward points earned and redeemed.';

  @override
  String get profileViewAllPointsHistory => 'View All History';

  @override
  String get profilePaymentHistory => 'Payment history';

  @override
  String get profilePaymentHistorySubtitle => 'Recent successful customer payments.';

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
  String get profileDeleteAddressBody => 'This mock action removes the saved address from your profile view.';

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
  String get profileOrderStatusSubtitle => 'Push notifications and SMS for your active orders';

  @override
  String get profileLoyaltyRewards => 'Loyalty & Rewards';

  @override
  String get profileLoyaltySubtitle => 'Monthly statement of points and tier bonuses';

  @override
  String get profileMarketingOffers => 'Marketing & Offers';

  @override
  String get profileMarketingSubtitle => 'Exclusive discounts and seasonal menu announcements';

  @override
  String get profileLogout => 'Logout';

  @override
  String get profileDeactivateAccount => 'Deactivate Account';

  @override
  String get settingsPersonalSubtitle => 'View your profile photo, name, contact details, and notification preferences.';

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
  String get settingsStaffShiftAlertsSubtitle => 'Kitchen, delivery, inventory, and attendance reminders.';

  @override
  String get settingsStaffOrderAlertsSubtitle => 'Order updates relevant to your station or route.';

  @override
  String get settingsBusinessSettingsHint => 'Restaurant operations, roles, taxes, receipts, and system alerts.';

  @override
  String get addressesTitle => 'Saved Addresses';

  @override
  String get addressesAddNew => 'Add New Address';

  @override
  String get addressesDelete => 'Delete';

  @override
  String get addressesDefault => 'Default';

  @override
  String get addressesHomeTitle => 'Home';

  @override
  String get addressesHomeBody => '124 Maple Avenue, Apt 4B, Silver Springs, MD 20910';

  @override
  String get addressesOfficeTitle => 'Office';

  @override
  String get addressesOfficeBody => 'Ayletna HQ, 888 Innovation Way, Suite 200, Amman';

  @override
  String get addressesGymTitle => 'Gym';

  @override
  String get addressesGymBody => 'Iron Peak Fitness Center, 45 Strength Blvd, Amman';

  @override
  String get addressesHelper => 'Easily manage your frequent delivery spots for faster checkout.';

  @override
  String get mapAddressTitle => 'Save address as';

  @override
  String get mapAddressTitleHint => 'Home, Office, Family house...';

  @override
  String get mapAddressText => 'Written address';

  @override
  String get mapAddressTextHint => 'Building, street, floor, nearby landmark...';

  @override
  String get mapSelectOnMap => 'Choose location from map';

  @override
  String get mapLocationSelected => 'Location selected from map';

  @override
  String get mapSaveAddress => 'Save address';

  @override
  String get mapRequiredFields => 'Choose a map location and write the address before saving.';

  @override
  String get notificationsTitle => 'Notifications';

  @override
  String get notificationsSubtitle => 'Stay updated with your latest kitchen and delivery activities.';

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
  String get notificationsWeeklySubtitle => 'Sustainability goals reached 92% this week!';

  @override
  String get notificationsViewDetails => 'View details';

  @override
  String get notificationsRecentAlerts => 'Recent Alerts';

  @override
  String get notificationsYesterday => 'Yesterday';

  @override
  String get notificationsDeliveryTitle => 'Order #8829 is out for delivery';

  @override
  String get notificationsDeliveryBody => 'Driver Ahmad has picked up the order and is heading to the destination.';

  @override
  String get notificationsTwoMins => '2 mins ago';

  @override
  String get notificationsTrackMap => 'Track Map';

  @override
  String get notificationsContactDriver => 'Contact Driver';

  @override
  String get notificationsTipTitle => 'Tip distribution ready';

  @override
  String get notificationsTipBody => 'The tip pool for the morning shift has been calculated and is ready for distribution.';

  @override
  String get notificationsFifteenMins => '15 mins ago';

  @override
  String get notificationsDistributeNow => 'Distribute Now';

  @override
  String get notificationsReviewBreakdown => 'Review Breakdown';

  @override
  String get notificationsTrayTitle => 'Tray collection reminder';

  @override
  String get notificationsTrayBody => 'Sustainability alert: 12 reusable trays are currently unreturned at Block B collection points.';

  @override
  String get notificationsFortyFiveMins => '45 mins ago';

  @override
  String get notificationsPingStaff => 'Ping Collection Staff';

  @override
  String get notificationsStockTitle => 'Stock alert: Premium Espresso Beans';

  @override
  String get notificationsStockBody => 'Inventory level dropped below the 15% threshold. Consider restocking soon to avoid service interruption.';

  @override
  String get notificationsOneHour => '1 hour ago';

  @override
  String get notificationsOrderMore => 'Order More';

  @override
  String get notificationsIgnoreNow => 'Ignore for now';

  @override
  String get notificationsPickupTitle => 'Order #7741 is ready for pickup';

  @override
  String get notificationsPickupBody => 'The plated meal is now on the heat rack at Station 3.';

  @override
  String get notificationsThreeHours => '3 hours ago';

  @override
  String get notificationsViewTicket => 'View Ticket';

  @override
  String get notificationsPolicyTitle => 'New Policy Update';

  @override
  String get notificationsPolicyBody => 'The sanitation guidelines have been updated. Please review the new checklist in the staff portal.';

  @override
  String get notificationsTwentyFourHours => '24 hours ago';

  @override
  String get notificationsAlertsNav => 'Alerts';

  @override
  String get orderConfirmedThanks => 'Thank You';

  @override
  String get orderConfirmedSuccess => 'Your order has been placed successfully.';

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
  String get orderConfirmedEmailSent => 'A confirmation email has been sent to your inbox.';

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
  String get otpResendLimitReached => 'Resend limit reached. Please try again later.';

  @override
  String get otpSecurityNote => 'Ayletna uses bank-grade encryption to protect your account security.';

  @override
  String get ownerDashboardTitle => 'Executive Performance';

  @override
  String get ownerDashboardSubtitle => 'Real-time financial health and profit analysis for June 2024.';

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
  String get ownerProfitAllocationBody => 'Calculated based on the 50/50 Owner-Operator agreement.';

  @override
  String get ownerSplitRatio => 'Split Ratio';

  @override
  String get ownerOperatorShare => 'Operator\'s Share';

  @override
  String get ownerExpensesBody => 'Consolidated monthly overhead including COGS, utilities, and labor. Internal recipes and unit costs are restricted for privacy.';

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
  String get ownerMonthlyRentMeta => 'June 05, 2024 • Transaction ID: #TXN-9021';

  @override
  String get ownerCateringEvent => 'Catering Event: Al-Mansour Corp';

  @override
  String get ownerCateringEventMeta => 'June 02, 2024 • Transaction ID: #TXN-8842';

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
  String get ownerPrivacyBody => 'Configure exactly what information the property owner can see in their dashboard. Maintain operational privacy while ensuring transparency on key business metrics.';

  @override
  String get ownerPrivacyHero => 'Enterprise Security Controls';

  @override
  String get ownerHideRawCosts => 'Hide Raw Material Costs';

  @override
  String get ownerHideRawCostsBody => 'Mask individual item costs in the inventory and procurement reports. Owner will see aggregated totals only.';

  @override
  String get ownerHideStaffSalaries => 'Hide Specific Staff Salaries';

  @override
  String get ownerHideStaffSalariesBody => 'Restrict visibility of granular payroll data. Individual salary breakdowns will be hidden from the owner\'s view.';

  @override
  String get ownerShowOnlyNetProfit => 'Show Only Net Profit';

  @override
  String get ownerShowOnlyNetProfitBody => 'When enabled, the owner dashboard will suppress all gross revenue and operational expense breakdowns, presenting only the final Net Profit figure for the period.';

  @override
  String get ownerLivePreview => 'Live Preview: Owner Perspective';

  @override
  String get ownerGrossRevenue => 'Gross Revenue';

  @override
  String get ownerOperatingCosts => 'Operating Costs';

  @override
  String get ownerNetProfitLabel => 'Net Profit';

  @override
  String get ownerPreviewNote => 'Data above reflects the current visibility settings applied to the Owner dashboard.';

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
  String get paymentCheckoutSubtitle => 'Choose your preferred payment method to complete the order.';

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
  String get platedHowSubtitle => 'Enjoy your favorite restaurant meals on real ceramic plates, delivered to your door and collected when you\'re done.';

  @override
  String get platedHowItWorks => 'How It Works';

  @override
  String get platedStepOrderTitle => '1. Order Plated';

  @override
  String get platedStepOrderBody => 'Select the Plated option at checkout for participating local restaurants.';

  @override
  String get platedStepEnjoyTitle => '2. Enjoy Meal';

  @override
  String get platedStepEnjoyBody => 'No soggy paper boxes. Experience the true taste of your meal on high-quality ceramic.';

  @override
  String get platedStepPickupTitle => '3. We Pick Up';

  @override
  String get platedStepPickupBody => 'Leave the tray at your door. We\'ll collect, professionally sanitize, and reuse it.';

  @override
  String get platedBondTitle => 'The Sustainable Bond';

  @override
  String get platedBondBody => 'To maintain our high-quality ceramic tray library, a refundable deposit is required for every Plated order. This ensures the loop remains closed and sustainable.';

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
  String get platedLearnSanitation => 'Learn more about our sanitation standards';

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
  String get platedWasteReduced => 'Your work reduces waste by 4.2kg per pickup today.';

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
  String get platesCatalogSubtitle => 'Manage stock levels, circulation, and breakage costs.';

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
  String get platesInStock => 'In Stock';

  @override
  String get platesCirculating => 'Circulating';

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
  String get platesBowlBreakageMeta => 'Station: Dishwashing Area • Reported by Sarah M.';

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
  String get platesRestockBody => 'Large Serving Trays are currently below the safety threshold (50 units).';

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
  String get productMansafDescription => 'The national dish of Jordan. Tender chunks of local lamb cooked in a rich, tangy sauce of fermented dried yogurt (Jameed), served on a bed of aromatic turmeric rice and thin shrak bread. Garnished with golden fried nuts and fresh parsley for a perfect crunch and zest.';

  @override
  String get productRating => '4.9 (120+ reviews)';

  @override
  String get productPrepTime => 'Prep time: 45-60 mins';

  @override
  String get productInclVat => 'Incl. VAT';

  @override
  String get productBestSeller => 'Best Seller';

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
  String get productInstructionsHint => 'e.g., Please ensure the jameed is served hot.';

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
  String get previewProductBody => 'A curated selection of farm-to-table ingredients including organic poached eggs, hand-crafted sourdough, Hass avocado, and wild arugula. Perfect for high-focus operational fuel.';

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
  String get previewDietaryMessage => 'Please login to specify allergies or special preparation requests.';

  @override
  String get previewLoginAddCart => 'Login to Add to Cart';

  @override
  String get previewNewToApp => 'New to Ayletna?';

  @override
  String get previewCreateAccount => 'Create an account';

  @override
  String get registerJoinTitle => 'Join Ayletna';

  @override
  String get registerJoinSubtitle => 'Create your account to start managing your culinary experience.';

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
  String get registerPreferencesSubtitle => 'Tell us what you enjoy so Ayletna can recommend meals that feel made for you.';

  @override
  String get registerPrimaryRole => 'Your Ayletna experience';

  @override
  String get registerRoleCustomer => 'Customer';

  @override
  String get registerRoleCustomerBody => 'Order delicious meals, track delivery, and manage your favorites.';

  @override
  String get registerRoleStaff => 'Restaurant Staff';

  @override
  String get registerRoleStaffBody => 'Access KDS, manage inventory, and process active orders.';

  @override
  String get registerRoleAdminOwner => 'Admin / Owner';

  @override
  String get registerRoleAdminOwnerBody => 'View deep analytics, manage staff, and optimize store sustainability.';

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
  String get reportsCenterSubtitle => 'Review your daily performance and download detailed documentation.';

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
  String get reportsSalesRevenueBody => 'Complete breakdown of transactions, tax, and tender types.';

  @override
  String get reportsStaffTips => 'Staff Hours & Tips';

  @override
  String get reportsStaffTipsBody => 'Timesheets, overtime alerts, and tip distribution logs.';

  @override
  String get reportsInventoryWastage => 'Inventory & Wastage';

  @override
  String get reportsInventoryWastageBody => 'Stock levels, shrinkage reports, and food waste analysis.';

  @override
  String get reportsSustainability => 'Sustainability (Tray Returns)';

  @override
  String get reportsSustainabilityBody => 'Tray return rates, reusable utensil tracking, and green initiatives.';

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
  String get guestRewardsPreviewBody => 'Browse rewards now. Create an account before checkout to keep every point you earn.';

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
  String get rewardsSignatureBurgerBody => 'Redeem for a full dining experience';

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
  String get roleSelectionMockTitle => 'Mock role chooser';

  @override
  String get roleSelectionWelcome => 'Choose a role to audit the app';

  @override
  String get roleSelectionSubtitle => 'In production, roles are assigned by an admin. For this mockup, choose any role to test screens and design.';

  @override
  String get roleSelectionCustomerTitle => 'Customer';

  @override
  String get roleSelectionCustomerBody => 'Browse our menu, place orders for dine-in or takeaway, and track your loyalty rewards in real-time.';

  @override
  String get roleSelectionMockCustomerMetric => 'Customer storefront';

  @override
  String get roleSelectionCustomerChipMenu => 'Menu';

  @override
  String get roleSelectionCustomerChipReservations => 'Reservations';

  @override
  String get roleSelectionOwnerTitle => 'Owner';

  @override
  String get roleSelectionOwnerBody => 'Strategic overview of revenue, waste analytics, and multi-location growth metrics.';

  @override
  String get roleSelectionOwnerMetric => 'Daily Revenue: +12%';

  @override
  String get roleSelectionCashierTitle => 'Cashier';

  @override
  String get roleSelectionCashierBody => 'Front-of-house operations, rapid checkout, and guest table management.';

  @override
  String get roleSelectionOpenRegister => 'Open Register';

  @override
  String get roleSelectionKitchenTitle => 'Kitchen Staff';

  @override
  String get roleSelectionKitchenBody => 'KDS tile management, order prioritization, and ingredient stock alerts.';

  @override
  String get roleSelectionKitchenMetric => '12 Active Orders';

  @override
  String get roleSelectionAdminTitle => 'Admin / Operator';

  @override
  String get roleSelectionAdminBody => 'Manage staff permissions, inventory procurement, and system configurations.';

  @override
  String get roleSelectionSystemOnline => 'SYSTEM STATUS: ONLINE';

  @override
  String get roleSelectionInventoryTitle => 'Inventory';

  @override
  String get roleSelectionInventoryBody => 'Review stock levels, wastage logs, ingredient details, and adjustment screens.';

  @override
  String get roleSelectionOpenInventory => 'Open Inventory';

  @override
  String get roleSelectionStaffTitle => 'Staff';

  @override
  String get roleSelectionStaffBody => 'Audit attendance, daily tips, and staff tip history screens.';

  @override
  String get roleSelectionOpenAttendance => 'Open Attendance';

  @override
  String get roleSelectionDeliveryTitle => 'Delivery Agent';

  @override
  String get roleSelectionDeliveryBody => 'Route optimization, order pickup confirmation, and digital proof-of-delivery.';

  @override
  String get roleSelectionStartShift => 'Start Shift';

  @override
  String get roleSelectionFooter => 'Mockup-only role switching. Admin-assigned permissions will replace this chooser later.';

  @override
  String get orderTypeTitle => 'How would you like to savor?';

  @override
  String get orderTypeSubtitle => 'Choose your dining experience to view the appropriate menu.';

  @override
  String get orderTypeDineInBody => 'Reserve your spot and enjoy the full restaurant ambiance with table service.';

  @override
  String get orderTypeDineInAction => 'Select Table';

  @override
  String get orderTypeTakeawayBody => 'Order ahead and pick up your meal at the designated counter. Fast & convenient.';

  @override
  String get orderTypeTakeawayAction => 'Select Pickup';

  @override
  String get orderTypeDeliveryTitle => 'Standard Delivery';

  @override
  String get orderTypeDeliveryBody => 'Reliable delivery to your doorstep. Hot and fresh meals within 30-45 minutes.';

  @override
  String get orderTypeDeliveryAction => 'Set Address';

  @override
  String get orderTypePlatedTitle => 'Plated Delivery';

  @override
  String get orderTypePlatedBadge => 'Sustainability';

  @override
  String get orderTypePlatedBody => 'Premium experience using reusable ceramic plating. We pick up the dishes later.';

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
  String get termsHeroSubtitle => 'This mock screen explains the core checkout rules before placing an order.';

  @override
  String get termsPaymentTitle => 'Payment and confirmation';

  @override
  String get termsPaymentBody => 'Orders are confirmed after choosing a fulfillment method and completing payment. Fees may vary by service type and address.';

  @override
  String get termsGroupDeliveryTitle => 'Group delivery';

  @override
  String get termsGroupDeliveryBody => 'When group delivery is selected, the order may wait for another nearby order in the same area to reduce delivery cost and improve route efficiency.';

  @override
  String get termsChangesTitle => 'Changes and cancellation';

  @override
  String get termsChangesBody => 'Orders can be changed before preparation starts. Once preparation begins, some changes or cancellation may no longer be available.';

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
  String get returnPolicyTipBody => 'Stains on linens are not charged as damage.';

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
  String get splashInitializing => 'INITIALIZING AYLETNA LOGIC';

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
  String get staffChefSpecialNote => 'Chef\'s Special: Grilled Sea Bass\nSuggest as high priority for dinner.';

  @override
  String get staffVipReservationNote => 'VIP Reservation at 07:30 PM\nTable 4 prepared for Mr. Al-Sayed.';

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
  String get staffShiftDetailsBody => 'Review your scheduled session before starting.';

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
  String get staffGpsCheckInNote => 'Checking in will record your GPS location and timestamp.';

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
  String get staffEarningsPolicyBody => 'Please review your daily totals. By acknowledging, you confirm the recorded tips match your shift logs. Payouts are processed every Thursday.';

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
  String get staffAcknowledgeNote => 'Acknowledgment timestamp will be recorded for audit purposes.';

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
  String get sustainabilityAlertsSubtitle => 'Operational insights and ecological milestones for the Culinary Logic ecosystem. Monitor tray cycles and sustainability KPIs in real-time.';

  @override
  String get sustainabilityActiveGoal => 'Active Goal';

  @override
  String get sustainabilityGoalReached => 'Sustainability Goal: 92% reached';

  @override
  String get sustainabilityGoalBody => 'Target for this week: 95% plastic-free tray management.';

  @override
  String get sustainabilityCurrentProgress => 'Current Progress';

  @override
  String get sustainabilityProgressPercent => '92%';

  @override
  String get sustainabilityUrgentAction => 'Urgent Action';

  @override
  String get sustainabilityReminderTitle => 'Reminder:\n4 trays\npending\ncollection';

  @override
  String get sustainabilityStationB => 'Station B requires immediate clearance to maintain sanitation flow.';

  @override
  String get sustainabilityDispatch => 'Dispatch';

  @override
  String get sustainabilityPolicyUpdate => 'New Sanitation Policy Update';

  @override
  String get sustainabilityPolicyBody => 'Updated protocols for compostable tray sanitization have been implemented for Q3.';

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
  String get takeawayPickupSubtitle => 'Select a time that works for you in Amman, Jordan.';

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
  String get tipAppreciationQuote => '\"Your appreciation goes directly to the heart of the kitchen. Every tip fuels our team\'s passion for creating unforgettable flavors for you.\"';

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
  String get tipCustomAmountBody => 'Enter any amount you wish to contribute to the team.';

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
  String get trackingCallMarcus => 'Call Marcus';

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
  String get trackingHelpBody => 'Our support team is available 24/7 for any delivery concerns.';

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
  String get userManagementSubtitle => 'Oversee your kitchen and front-of-house team.';

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
  String get refundStep2Body => 'Inspect returned items for any structural damage. Selecting \'Damaged\' will allow you to enter a deduction from the initial deposit.';

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
  String get refundEstimateBody => 'Estimated refund will update automatically based on damage deductions entered above.';

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
  String get refundImmediateNotice => 'The refund will be processed immediately to the user\'s Ayletna Wallet. A digital receipt will be sent via SMS to +962 *** *** 44.';

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
  String get returnMissingWarning => 'Missing items will be flagged for manager review and may incur a replacement fee for the customer.';

  @override
  String get returnContinueStep2 => 'Continue to Step 2';

  @override
  String get returnStep2Title => 'Step 2 of 2';

  @override
  String get returnConfirmation => 'Confirmation';

  @override
  String get returnVerificationComplete => 'Verification Complete';

  @override
  String get returnVerificationBody => 'Deposit will be credited to wallet instantly.';

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
  String get returnFinalizeDisclaimer => 'By clicking Finalize Return, you confirm that all items have been inspected and the refund amount is accurate.';

  @override
  String get platedReturnBadge => 'Plated Experience';

  @override
  String get platedReturnReadyTitle => 'Ready to return?';

  @override
  String get platedReturnReadyBody => 'We hope you enjoyed your meal! Please let us know how you\'d like to return your ceramic plate set.';

  @override
  String get platedReturnDepositTitle => 'Refundable Deposit';

  @override
  String get platedReturnDepositBody => 'Your 5 JOD deposit will be credited back to your wallet instantly upon receipt of the items.';

  @override
  String get platedReturnSchedulePickup => 'Schedule Pickup';

  @override
  String get platedReturnSelfReturn => 'I\'ll return it myself';

  @override
  String get screenRatingReview => 'Rate your meal';

  @override
  String get screenRatingReviewDesc => 'Post-delivery rating and review screen.';

  @override
  String get ratingHeroTitle => 'How was your Ayletna meal?';

  @override
  String get ratingHeroSubtitle => 'Your note helps the kitchen keep every dish warm, fresh, and generous.';

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
  String get ratingCommentHint => 'Tell us what tasted great or what we should improve';

  @override
  String get ratingSubmit => 'Send review';

  @override
  String get ratingSuccess => 'Thanks. Your review was added to your rewards profile.';

  @override
  String get ratingRewardLoop => '+50 Savor Points after review';

  @override
  String get ratingReviewLater => 'Review later';

  @override
  String get reportFilterIntro => 'Choose the analytics scope before reviewing sales, inventory, tips, and plate decisions.';

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
  String get adminGrowthHubHero => 'One place to manage team hours, owner privacy, loyalty, and offers instead of scattered weak pages.';

  @override
  String get adminGrowthHubTodayHours => 'Today hours';

  @override
  String get adminGrowthHubLoyaltyGuests => 'Loyalty guests';

  @override
  String get adminGrowthHubActiveOffers => 'Active offers';

  @override
  String get adminGrowthStaffTitle => 'Team Hours & Shifts';

  @override
  String get adminGrowthStaffSubtitle => 'Track coverage, hours, and tips by restaurant role.';

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
  String get adminGrowthPrivacySubtitle => 'Owner view and finance-report visibility rules.';

  @override
  String get adminGrowthLoyaltySubtitle => 'Turn loyalty into repeat visits and clear food orders.';

  @override
  String get adminGrowthPointsRule => 'Points rule';

  @override
  String get adminGrowthEnableLunchMultiplier => 'Enable lunch multiplier';

  @override
  String get adminGrowthLunchMultiplierBody => '12 PM to 4 PM for best-selling menu items.';

  @override
  String get adminGrowthBirthdayDessertBody => 'Visible only during the guest birthday window.';

  @override
  String get adminGrowthTarget => 'Target';

  @override
  String get adminGrowthTargetBody => 'Second visit within 14 days';

  @override
  String get adminGrowthOffersSubtitle => 'Offers connect to inventory and margins, not generic marketing cards.';

  @override
  String get adminGrowthShawarmaOffer => 'Shawarma meal lunch offer';

  @override
  String get adminGrowthShawarmaOfferBody => 'Tied to lunch peak and prep capacity.';

  @override
  String get adminGrowthFamilyTrayOffer => 'Family plated bundle';

  @override
  String get adminGrowthFamilyTrayOfferBody => 'Requires tray availability and clear deposit rule.';

  @override
  String get adminGrowthHomeOffers => 'Home offers';

  @override
  String get adminGrowthHomeOffersBody => 'Shown in the offers section when the list is not empty.';

  @override
  String get adminGrowthCombos => 'Combos';

  @override
  String get adminGrowthCombosBody => 'Shown in combo sections on customer and guest pages.';

  @override
  String get adminGrowthDiscountedItems => 'Discounted items';

  @override
  String get adminGrowthDiscountedItemsBody => 'Hidden automatically when no discounted items exist.';

  @override
  String get adminGrowthSubscriptionItems => 'Subscription items';

  @override
  String get adminGrowthSubscriptionItemsBody => 'Supports monthly or annual subscription mock offers.';

  @override
  String get adminGrowthTargetMargin => 'Target margin';

  @override
  String get adminGrowthTargetMarginBody => 'Do not publish if margin drops below target.';

  @override
  String get adminGrowthDecisionStaff => 'Approve close-shift hours before tip payout.';

  @override
  String get adminGrowthDecisionPrivacy => 'Show net profit only during owner performance review.';

  @override
  String get adminGrowthDecisionLoyalty => 'Tie point multipliers to soft demand windows.';

  @override
  String get adminGrowthDecisionOffers => 'Test the shawarma offer before publishing plated bundles.';

  @override
  String get adminGrowthSuggestedDecision => 'Suggested Decision';

  @override
  String get adminGrowthExpectedImpact => 'Expected impact';

  @override
  String get adminGrowthExpectedImpactValue => '+8% repeat orders';

  @override
  String get adminGrowthActionsTitle => 'Admin Actions';

  @override
  String get adminGrowthActionsSubtitle => 'All actions are UI-only mock actions.';

  @override
  String get adminGrowthSaveSettings => 'Save settings';

  @override
  String get adminGrowthSettingsSaved => 'Hub settings saved';

  @override
  String get adminGrowthOpenAuditLog => 'Open audit log';
}

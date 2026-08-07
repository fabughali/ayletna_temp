import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Ayletna Restaurant'**
  String get appTitle;

  /// No description provided for @brandName.
  ///
  /// In en, this message translates to:
  /// **'Ayletna'**
  String get brandName;

  /// No description provided for @brandNameAr.
  ///
  /// In en, this message translates to:
  /// **'مطعم عيلتنا'**
  String get brandNameAr;

  /// No description provided for @comingSoon.
  ///
  /// In en, this message translates to:
  /// **'Soon قريباً'**
  String get comingSoon;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading'**
  String get loading;

  /// No description provided for @actionContinue.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get actionContinue;

  /// No description provided for @actionCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get actionCancel;

  /// No description provided for @actionSave.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get actionSave;

  /// No description provided for @favoritesSaved.
  ///
  /// In en, this message translates to:
  /// **'Saved to favorites'**
  String get favoritesSaved;

  /// No description provided for @favoritesRemoved.
  ///
  /// In en, this message translates to:
  /// **'Removed from favorites'**
  String get favoritesRemoved;

  /// No description provided for @actionAddToCart.
  ///
  /// In en, this message translates to:
  /// **'Add to Cart'**
  String get actionAddToCart;

  /// No description provided for @actionSignIn.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get actionSignIn;

  /// No description provided for @actionRegister.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get actionRegister;

  /// No description provided for @actionForgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot password?'**
  String get actionForgotPassword;

  /// No description provided for @actionVerify.
  ///
  /// In en, this message translates to:
  /// **'Verify'**
  String get actionVerify;

  /// No description provided for @actionGuestBrowse.
  ///
  /// In en, this message translates to:
  /// **'Browse as guest'**
  String get actionGuestBrowse;

  /// No description provided for @fieldEmailOrPhone.
  ///
  /// In en, this message translates to:
  /// **'Email or phone'**
  String get fieldEmailOrPhone;

  /// No description provided for @fieldPassword.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get fieldPassword;

  /// No description provided for @fieldName.
  ///
  /// In en, this message translates to:
  /// **'Full name'**
  String get fieldName;

  /// No description provided for @languageArabic.
  ///
  /// In en, this message translates to:
  /// **'العربية'**
  String get languageArabic;

  /// No description provided for @languageEnglish.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get languageEnglish;

  /// No description provided for @selectLanguageTitle.
  ///
  /// In en, this message translates to:
  /// **'Choose your language'**
  String get selectLanguageTitle;

  /// No description provided for @selectLanguageSubtitle.
  ///
  /// In en, this message translates to:
  /// **'You can change this later in settings'**
  String get selectLanguageSubtitle;

  /// No description provided for @guestSignInToOrder.
  ///
  /// In en, this message translates to:
  /// **'Sign in to order'**
  String get guestSignInToOrder;

  /// No description provided for @termsAccept.
  ///
  /// In en, this message translates to:
  /// **'I accept the terms and privacy policy'**
  String get termsAccept;

  /// No description provided for @registerAsCustomer.
  ///
  /// In en, this message translates to:
  /// **'Customer (instant)'**
  String get registerAsCustomer;

  /// No description provided for @registerAsStaff.
  ///
  /// In en, this message translates to:
  /// **'Request staff role (pending approval)'**
  String get registerAsStaff;

  /// No description provided for @authLoginRequiredFields.
  ///
  /// In en, this message translates to:
  /// **'Enter your phone or email and password.'**
  String get authLoginRequiredFields;

  /// No description provided for @authForgotIdentifierRequired.
  ///
  /// In en, this message translates to:
  /// **'Enter your registered phone or email.'**
  String get authForgotIdentifierRequired;

  /// No description provided for @authOtpInvalid.
  ///
  /// In en, this message translates to:
  /// **'Enter the 6-digit code sent to your phone.'**
  String get authOtpInvalid;

  /// No description provided for @authPasswordMismatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match.'**
  String get authPasswordMismatch;

  /// No description provided for @authRegisterFieldsRequired.
  ///
  /// In en, this message translates to:
  /// **'Fill in all required fields and accept the terms.'**
  String get authRegisterFieldsRequired;

  /// No description provided for @authOtpResent.
  ///
  /// In en, this message translates to:
  /// **'A new verification code was sent.'**
  String get authOtpResent;

  /// No description provided for @authPasswordResetSuccess.
  ///
  /// In en, this message translates to:
  /// **'Password reset. You can sign in now.'**
  String get authPasswordResetSuccess;

  /// No description provided for @roleSelectionNotApproved.
  ///
  /// In en, this message translates to:
  /// **'This role is not approved for your account.'**
  String get roleSelectionNotApproved;

  /// No description provided for @pendingApprovalNote.
  ///
  /// In en, this message translates to:
  /// **'Your account is under review. Our team is verifying your staff credentials to ensure the best service for our guests.'**
  String get pendingApprovalNote;

  /// No description provided for @pendingApprovalTimelineTitle.
  ///
  /// In en, this message translates to:
  /// **'Approval progress'**
  String get pendingApprovalTimelineTitle;

  /// No description provided for @pendingApprovalStepSubmitted.
  ///
  /// In en, this message translates to:
  /// **'Submitted'**
  String get pendingApprovalStepSubmitted;

  /// No description provided for @pendingApprovalStepReview.
  ///
  /// In en, this message translates to:
  /// **'Reviewing'**
  String get pendingApprovalStepReview;

  /// No description provided for @pendingApprovalStepActivated.
  ///
  /// In en, this message translates to:
  /// **'Activated'**
  String get pendingApprovalStepActivated;

  /// No description provided for @pendingApprovalContactSupport.
  ///
  /// In en, this message translates to:
  /// **'Contact Support'**
  String get pendingApprovalContactSupport;

  /// No description provided for @currencyJod.
  ///
  /// In en, this message translates to:
  /// **'JOD'**
  String get currencyJod;

  /// No description provided for @orderTypeDineIn.
  ///
  /// In en, this message translates to:
  /// **'Dine-in'**
  String get orderTypeDineIn;

  /// No description provided for @orderTypeTakeaway.
  ///
  /// In en, this message translates to:
  /// **'Takeaway'**
  String get orderTypeTakeaway;

  /// No description provided for @orderTypeDelivery.
  ///
  /// In en, this message translates to:
  /// **'Delivery'**
  String get orderTypeDelivery;

  /// No description provided for @orderTypePlated.
  ///
  /// In en, this message translates to:
  /// **'Plated delivery'**
  String get orderTypePlated;

  /// No description provided for @tipPreset1.
  ///
  /// In en, this message translates to:
  /// **'1 JOD'**
  String get tipPreset1;

  /// No description provided for @tipPreset2.
  ///
  /// In en, this message translates to:
  /// **'2 JOD'**
  String get tipPreset2;

  /// No description provided for @tipPreset5.
  ///
  /// In en, this message translates to:
  /// **'5 JOD'**
  String get tipPreset5;

  /// No description provided for @tipCustom.
  ///
  /// In en, this message translates to:
  /// **'Custom'**
  String get tipCustom;

  /// No description provided for @checkoutFood.
  ///
  /// In en, this message translates to:
  /// **'Food'**
  String get checkoutFood;

  /// No description provided for @checkoutTip.
  ///
  /// In en, this message translates to:
  /// **'Tip'**
  String get checkoutTip;

  /// No description provided for @checkoutDeposit.
  ///
  /// In en, this message translates to:
  /// **'Deposit'**
  String get checkoutDeposit;

  /// No description provided for @checkoutPaymentMethod.
  ///
  /// In en, this message translates to:
  /// **'Payment Method'**
  String get checkoutPaymentMethod;

  /// No description provided for @checkoutWalletBalance.
  ///
  /// In en, this message translates to:
  /// **'JOD {amount}'**
  String checkoutWalletBalance(String amount);

  /// No description provided for @checkoutCardMasked.
  ///
  /// In en, this message translates to:
  /// **'**** 9012'**
  String get checkoutCardMasked;

  /// No description provided for @checkoutCashArrival.
  ///
  /// In en, this message translates to:
  /// **'Pay on arrival'**
  String get checkoutCashArrival;

  /// No description provided for @checkoutAppreciationTitle.
  ///
  /// In en, this message translates to:
  /// **'Show your appreciation'**
  String get checkoutAppreciationTitle;

  /// No description provided for @checkoutAppreciationSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Your kindness fuels our culinary team.'**
  String get checkoutAppreciationSubtitle;

  /// No description provided for @checkoutFairWageNote.
  ///
  /// In en, this message translates to:
  /// **'100% of your tips are shared equally among our kitchen and delivery staff as part of our fair-wage commitment.'**
  String get checkoutFairWageNote;

  /// No description provided for @checkoutOrderSummary.
  ///
  /// In en, this message translates to:
  /// **'Order Summary'**
  String get checkoutOrderSummary;

  /// No description provided for @checkoutFoodSubtotal.
  ///
  /// In en, this message translates to:
  /// **'Food Subtotal'**
  String get checkoutFoodSubtotal;

  /// No description provided for @checkoutDeliveryFee.
  ///
  /// In en, this message translates to:
  /// **'Delivery Fee'**
  String get checkoutDeliveryFee;

  /// No description provided for @checkoutPlatedDeposit.
  ///
  /// In en, this message translates to:
  /// **'Plated Deposit'**
  String get checkoutPlatedDeposit;

  /// No description provided for @checkoutDepositRefundNote.
  ///
  /// In en, this message translates to:
  /// **'Refundable upon plate collection.'**
  String get checkoutDepositRefundNote;

  /// No description provided for @checkoutStaffAppreciation.
  ///
  /// In en, this message translates to:
  /// **'Staff Appreciation'**
  String get checkoutStaffAppreciation;

  /// No description provided for @checkoutTotal.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get checkoutTotal;

  /// No description provided for @checkoutTaxInclusive.
  ///
  /// In en, this message translates to:
  /// **'Inclusive of taxes'**
  String get checkoutTaxInclusive;

  /// No description provided for @checkoutPlaceOrder.
  ///
  /// In en, this message translates to:
  /// **'Place Order'**
  String get checkoutPlaceOrder;

  /// No description provided for @checkoutPlaceOrderAmount.
  ///
  /// In en, this message translates to:
  /// **'Place Order • {amount}'**
  String checkoutPlaceOrderAmount(String amount);

  /// No description provided for @roleCustomer.
  ///
  /// In en, this message translates to:
  /// **'Customer'**
  String get roleCustomer;

  /// No description provided for @roleCashier.
  ///
  /// In en, this message translates to:
  /// **'Cashier'**
  String get roleCashier;

  /// No description provided for @roleKitchen.
  ///
  /// In en, this message translates to:
  /// **'Kitchen'**
  String get roleKitchen;

  /// No description provided for @roleDelivery.
  ///
  /// In en, this message translates to:
  /// **'Delivery'**
  String get roleDelivery;

  /// No description provided for @roleInventory.
  ///
  /// In en, this message translates to:
  /// **'Inventory'**
  String get roleInventory;

  /// No description provided for @roleStaff.
  ///
  /// In en, this message translates to:
  /// **'Staff'**
  String get roleStaff;

  /// No description provided for @roleOperator.
  ///
  /// In en, this message translates to:
  /// **'Operator'**
  String get roleOperator;

  /// No description provided for @roleOwner.
  ///
  /// In en, this message translates to:
  /// **'Owner'**
  String get roleOwner;

  /// No description provided for @roleAdmin.
  ///
  /// In en, this message translates to:
  /// **'App Admin'**
  String get roleAdmin;

  /// No description provided for @roleSupport.
  ///
  /// In en, this message translates to:
  /// **'Support'**
  String get roleSupport;

  /// No description provided for @roleMarketing.
  ///
  /// In en, this message translates to:
  /// **'Marketing'**
  String get roleMarketing;

  /// No description provided for @hubAppAdmin.
  ///
  /// In en, this message translates to:
  /// **'App Administration'**
  String get hubAppAdmin;

  /// No description provided for @hubOperator.
  ///
  /// In en, this message translates to:
  /// **'Restaurant Operations'**
  String get hubOperator;

  /// No description provided for @hubOwner.
  ///
  /// In en, this message translates to:
  /// **'Owner Portal'**
  String get hubOwner;

  /// No description provided for @hubSupportDesk.
  ///
  /// In en, this message translates to:
  /// **'Support Desk'**
  String get hubSupportDesk;

  /// No description provided for @hubMarketing.
  ///
  /// In en, this message translates to:
  /// **'Marketing Hub'**
  String get hubMarketing;

  /// No description provided for @rolePermissionsTitle.
  ///
  /// In en, this message translates to:
  /// **'Roles & Rules'**
  String get rolePermissionsTitle;

  /// No description provided for @rolePermissionsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Default permission bundles per role'**
  String get rolePermissionsSubtitle;

  /// No description provided for @userPermissionsTitle.
  ///
  /// In en, this message translates to:
  /// **'Users & Permissions'**
  String get userPermissionsTitle;

  /// No description provided for @userPermissionsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Assigned roles, inherited rules, and overrides'**
  String get userPermissionsSubtitle;

  /// No description provided for @switchRoleTitle.
  ///
  /// In en, this message translates to:
  /// **'Active Role'**
  String get switchRoleTitle;

  /// No description provided for @switchRoleSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Only shown when your account has multiple roles'**
  String get switchRoleSubtitle;

  /// No description provided for @settingsDarkMode.
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get settingsDarkMode;

  /// No description provided for @settingsDarkModeOff.
  ///
  /// In en, this message translates to:
  /// **'Off'**
  String get settingsDarkModeOff;

  /// No description provided for @settingsDarkModeOn.
  ///
  /// In en, this message translates to:
  /// **'On'**
  String get settingsDarkModeOn;

  /// No description provided for @settingsAppearance.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get settingsAppearance;

  /// No description provided for @settingsAppearanceSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Choose light, dark, or match your device.'**
  String get settingsAppearanceSubtitle;

  /// No description provided for @settingsThemeLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get settingsThemeLight;

  /// No description provided for @settingsThemeDark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get settingsThemeDark;

  /// No description provided for @settingsThemeAuto.
  ///
  /// In en, this message translates to:
  /// **'Auto'**
  String get settingsThemeAuto;

  /// No description provided for @settingsNotificationsSummary.
  ///
  /// In en, this message translates to:
  /// **'Push, Email'**
  String get settingsNotificationsSummary;

  /// No description provided for @inheritedRulesTitle.
  ///
  /// In en, this message translates to:
  /// **'Inherited rules'**
  String get inheritedRulesTitle;

  /// No description provided for @userOverridesTitle.
  ///
  /// In en, this message translates to:
  /// **'User overrides'**
  String get userOverridesTitle;

  /// No description provided for @effectivePermissionsTitle.
  ///
  /// In en, this message translates to:
  /// **'Effective permissions'**
  String get effectivePermissionsTitle;

  /// No description provided for @ownershipPercentageLabel.
  ///
  /// In en, this message translates to:
  /// **'Ownership %'**
  String get ownershipPercentageLabel;

  /// No description provided for @pendingApprovalRequestedRoles.
  ///
  /// In en, this message translates to:
  /// **'Requested access: {roles}. An app administrator will review your account.'**
  String pendingApprovalRequestedRoles(String roles);

  /// No description provided for @supportChatQueueTitle.
  ///
  /// In en, this message translates to:
  /// **'Live chat queue'**
  String get supportChatQueueTitle;

  /// No description provided for @supportChatQueueSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Accept waiting customer conversations.'**
  String get supportChatQueueSubtitle;

  /// No description provided for @supportOrderLookupTitle.
  ///
  /// In en, this message translates to:
  /// **'Order lookup'**
  String get supportOrderLookupTitle;

  /// No description provided for @supportOrderLookupSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Search orders by number or customer name for ticket context.'**
  String get supportOrderLookupSubtitle;

  /// No description provided for @supportFaqEditorTitle.
  ///
  /// In en, this message translates to:
  /// **'FAQ editor'**
  String get supportFaqEditorTitle;

  /// No description provided for @supportFaqAddTitle.
  ///
  /// In en, this message translates to:
  /// **'Add FAQ entry'**
  String get supportFaqAddTitle;

  /// No description provided for @supportFaqAddAction.
  ///
  /// In en, this message translates to:
  /// **'Add entry'**
  String get supportFaqAddAction;

  /// No description provided for @supportFaqPublished.
  ///
  /// In en, this message translates to:
  /// **'Published'**
  String get supportFaqPublished;

  /// No description provided for @supportFaqDraft.
  ///
  /// In en, this message translates to:
  /// **'Draft'**
  String get supportFaqDraft;

  /// No description provided for @supportFaqPublish.
  ///
  /// In en, this message translates to:
  /// **'Publish'**
  String get supportFaqPublish;

  /// No description provided for @supportFaqUnpublish.
  ///
  /// In en, this message translates to:
  /// **'Unpublish'**
  String get supportFaqUnpublish;

  /// No description provided for @supportFaqSavedMock.
  ///
  /// In en, this message translates to:
  /// **'FAQ saved'**
  String get supportFaqSavedMock;

  /// No description provided for @supportFaqValidation.
  ///
  /// In en, this message translates to:
  /// **'Enter at least English title and body.'**
  String get supportFaqValidation;

  /// No description provided for @supportFaqBodyLabelEn.
  ///
  /// In en, this message translates to:
  /// **'Body (EN)'**
  String get supportFaqBodyLabelEn;

  /// No description provided for @supportFaqBodyLabelAr.
  ///
  /// In en, this message translates to:
  /// **'Body (AR)'**
  String get supportFaqBodyLabelAr;

  /// No description provided for @hubOwnerPerformanceSummary.
  ///
  /// In en, this message translates to:
  /// **'Performance summary'**
  String get hubOwnerPerformanceSummary;

  /// No description provided for @hubOwnerShare.
  ///
  /// In en, this message translates to:
  /// **'Owner share'**
  String get hubOwnerShare;

  /// No description provided for @hubOwnerSharePercent.
  ///
  /// In en, this message translates to:
  /// **'{percent}% stake'**
  String hubOwnerSharePercent(String percent);

  /// No description provided for @hubNetRevenue.
  ///
  /// In en, this message translates to:
  /// **'Net revenue'**
  String get hubNetRevenue;

  /// No description provided for @hubTodayRevenue.
  ///
  /// In en, this message translates to:
  /// **'Today revenue'**
  String get hubTodayRevenue;

  /// No description provided for @hubTodayOrders.
  ///
  /// In en, this message translates to:
  /// **'{count} orders'**
  String hubTodayOrders(String count);

  /// No description provided for @hubSupportSummary.
  ///
  /// In en, this message translates to:
  /// **'Support summary'**
  String get hubSupportSummary;

  /// No description provided for @hubOpenTickets.
  ///
  /// In en, this message translates to:
  /// **'Open tickets'**
  String get hubOpenTickets;

  /// No description provided for @hubChatQueue.
  ///
  /// In en, this message translates to:
  /// **'Chat queue'**
  String get hubChatQueue;

  /// No description provided for @hubPendingReviews.
  ///
  /// In en, this message translates to:
  /// **'Pending reviews'**
  String get hubPendingReviews;

  /// No description provided for @hubAvgWait.
  ///
  /// In en, this message translates to:
  /// **'Avg wait'**
  String get hubAvgWait;

  /// No description provided for @hubAvgWaitMinutes.
  ///
  /// In en, this message translates to:
  /// **'{minutes}m'**
  String hubAvgWaitMinutes(String minutes);

  /// No description provided for @hubAvgWaitMinutesAr.
  ///
  /// In en, this message translates to:
  /// **'{minutes} د'**
  String hubAvgWaitMinutesAr(String minutes);

  /// No description provided for @marketingCampaignSummary.
  ///
  /// In en, this message translates to:
  /// **'Campaign summary'**
  String get marketingCampaignSummary;

  /// No description provided for @marketingActiveOffers.
  ///
  /// In en, this message translates to:
  /// **'Active offers'**
  String get marketingActiveOffers;

  /// No description provided for @marketingCombosPromos.
  ///
  /// In en, this message translates to:
  /// **'Combos / promos'**
  String get marketingCombosPromos;

  /// No description provided for @marketingLoyaltyMembers.
  ///
  /// In en, this message translates to:
  /// **'Loyalty members'**
  String get marketingLoyaltyMembers;

  /// No description provided for @marketingRedemptionRate.
  ///
  /// In en, this message translates to:
  /// **'Redemption rate'**
  String get marketingRedemptionRate;

  /// No description provided for @marketingVisualCatalog.
  ///
  /// In en, this message translates to:
  /// **'Visual catalog'**
  String get marketingVisualCatalog;

  /// No description provided for @marketingCampaignCalendar.
  ///
  /// In en, this message translates to:
  /// **'Campaign calendar'**
  String get marketingCampaignCalendar;

  /// No description provided for @marketingSocialIntegrations.
  ///
  /// In en, this message translates to:
  /// **'Social integrations'**
  String get marketingSocialIntegrations;

  /// No description provided for @marketingBlogTitle.
  ///
  /// In en, this message translates to:
  /// **'Blog & content'**
  String get marketingBlogTitle;

  /// No description provided for @marketingBlogAddPost.
  ///
  /// In en, this message translates to:
  /// **'New blog post'**
  String get marketingBlogAddPost;

  /// No description provided for @marketingBlogPublished.
  ///
  /// In en, this message translates to:
  /// **'Published'**
  String get marketingBlogPublished;

  /// No description provided for @marketingBlogDraft.
  ///
  /// In en, this message translates to:
  /// **'Draft'**
  String get marketingBlogDraft;

  /// No description provided for @marketingBlogDraftAdded.
  ///
  /// In en, this message translates to:
  /// **'Draft added'**
  String get marketingBlogDraftAdded;

  /// No description provided for @marketingBlogStatusToggled.
  ///
  /// In en, this message translates to:
  /// **'Publication status updated'**
  String get marketingBlogStatusToggled;

  /// No description provided for @marketingBlogNewDraftAr.
  ///
  /// In en, this message translates to:
  /// **'مسودة جديدة'**
  String get marketingBlogNewDraftAr;

  /// No description provided for @marketingBlogNewDraftEn.
  ///
  /// In en, this message translates to:
  /// **'New draft'**
  String get marketingBlogNewDraftEn;

  /// No description provided for @marketingTabOffers.
  ///
  /// In en, this message translates to:
  /// **'Offers'**
  String get marketingTabOffers;

  /// No description provided for @marketingTabCombos.
  ///
  /// In en, this message translates to:
  /// **'Combos'**
  String get marketingTabCombos;

  /// No description provided for @marketingTabDiscounts.
  ///
  /// In en, this message translates to:
  /// **'Discounts'**
  String get marketingTabDiscounts;

  /// No description provided for @marketingTabSubscriptions.
  ///
  /// In en, this message translates to:
  /// **'Subscriptions'**
  String get marketingTabSubscriptions;

  /// No description provided for @marketingTabCampaign.
  ///
  /// In en, this message translates to:
  /// **'Campaign'**
  String get marketingTabCampaign;

  /// No description provided for @marketingTabLoyalty.
  ///
  /// In en, this message translates to:
  /// **'Loyalty'**
  String get marketingTabLoyalty;

  /// No description provided for @marketingTabSocial.
  ///
  /// In en, this message translates to:
  /// **'Social'**
  String get marketingTabSocial;

  /// No description provided for @marketingTabBlog.
  ///
  /// In en, this message translates to:
  /// **'Blog'**
  String get marketingTabBlog;

  /// No description provided for @marketingPushCampaignsTitle.
  ///
  /// In en, this message translates to:
  /// **'Push campaigns'**
  String get marketingPushCampaignsTitle;

  /// No description provided for @marketingPushCampaignsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Draft and schedule customer push notifications.'**
  String get marketingPushCampaignsSubtitle;

  /// No description provided for @marketingPushAddDraft.
  ///
  /// In en, this message translates to:
  /// **'New push draft'**
  String get marketingPushAddDraft;

  /// No description provided for @marketingPushDraft.
  ///
  /// In en, this message translates to:
  /// **'Draft'**
  String get marketingPushDraft;

  /// No description provided for @marketingPushScheduledStatus.
  ///
  /// In en, this message translates to:
  /// **'Scheduled'**
  String get marketingPushScheduledStatus;

  /// No description provided for @marketingPushSent.
  ///
  /// In en, this message translates to:
  /// **'Sent'**
  String get marketingPushSent;

  /// No description provided for @marketingPushScheduled.
  ///
  /// In en, this message translates to:
  /// **'Scheduled for'**
  String get marketingPushScheduled;

  /// No description provided for @marketingPushScheduleAction.
  ///
  /// In en, this message translates to:
  /// **'Schedule send'**
  String get marketingPushScheduleAction;

  /// No description provided for @marketingPushScheduledMock.
  ///
  /// In en, this message translates to:
  /// **'Campaign scheduled'**
  String get marketingPushScheduledMock;

  /// No description provided for @marketingPushDraftAdded.
  ///
  /// In en, this message translates to:
  /// **'Push draft added'**
  String get marketingPushDraftAdded;

  /// No description provided for @marketingPushNewDraftAr.
  ///
  /// In en, this message translates to:
  /// **'إشعار جديد'**
  String get marketingPushNewDraftAr;

  /// No description provided for @marketingPushNewDraftEn.
  ///
  /// In en, this message translates to:
  /// **'New notification'**
  String get marketingPushNewDraftEn;

  /// No description provided for @marketingPushFieldTitleAr.
  ///
  /// In en, this message translates to:
  /// **'Title (Arabic)'**
  String get marketingPushFieldTitleAr;

  /// No description provided for @marketingPushFieldTitleEn.
  ///
  /// In en, this message translates to:
  /// **'Title (English)'**
  String get marketingPushFieldTitleEn;

  /// No description provided for @marketingPushFieldBodyAr.
  ///
  /// In en, this message translates to:
  /// **'Body (Arabic)'**
  String get marketingPushFieldBodyAr;

  /// No description provided for @marketingPushFieldBodyEn.
  ///
  /// In en, this message translates to:
  /// **'Body (English)'**
  String get marketingPushFieldBodyEn;

  /// No description provided for @marketingPushNoSchedule.
  ///
  /// In en, this message translates to:
  /// **'No schedule yet'**
  String get marketingPushNoSchedule;

  /// No description provided for @opsInboxTitle.
  ///
  /// In en, this message translates to:
  /// **'Shift inbox'**
  String get opsInboxTitle;

  /// No description provided for @opsInboxSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Operational alerts for your role. Customer marketing pushes stay on the customer inbox.'**
  String get opsInboxSubtitle;

  /// No description provided for @opsInboxShiftAlertTitle.
  ///
  /// In en, this message translates to:
  /// **'Shift reminder'**
  String get opsInboxShiftAlertTitle;

  /// No description provided for @opsInboxShiftAlertBody.
  ///
  /// In en, this message translates to:
  /// **'Confirm attendance and tip status before closing your shift.'**
  String get opsInboxShiftAlertBody;

  /// No description provided for @opsInboxOrderAlertTitle.
  ///
  /// In en, this message translates to:
  /// **'Active orders need attention'**
  String get opsInboxOrderAlertTitle;

  /// No description provided for @opsInboxOrderAlertBody.
  ///
  /// In en, this message translates to:
  /// **'Open your hub dashboard to review queued work.'**
  String get opsInboxOrderAlertBody;

  /// No description provided for @opsInboxOpenHub.
  ///
  /// In en, this message translates to:
  /// **'Open hub'**
  String get opsInboxOpenHub;

  /// No description provided for @platedReturnPickupScheduled.
  ///
  /// In en, this message translates to:
  /// **'Pickup scheduled'**
  String get platedReturnPickupScheduled;

  /// No description provided for @platedReturnSelfReturnLogged.
  ///
  /// In en, this message translates to:
  /// **'Self-return logged'**
  String get platedReturnSelfReturnLogged;

  /// No description provided for @marketingCalendarNoEvents.
  ///
  /// In en, this message translates to:
  /// **'No campaigns scheduled for this day'**
  String get marketingCalendarNoEvents;

  /// No description provided for @marketingCalendarScheduleAction.
  ///
  /// In en, this message translates to:
  /// **'Schedule campaign'**
  String get marketingCalendarScheduleAction;

  /// No description provided for @marketingCalendarMockSave.
  ///
  /// In en, this message translates to:
  /// **'Campaign saved'**
  String get marketingCalendarMockSave;

  /// No description provided for @marketingCalendarPlanningOnlyNotice.
  ///
  /// In en, this message translates to:
  /// **'Internal planning calendar only — slots do not publish offers, blog posts, or customer notifications. Use Offers, Blog, or Push campaigns to go live.'**
  String get marketingCalendarPlanningOnlyNotice;

  /// No description provided for @marketingCalendarCampaignsOn.
  ///
  /// In en, this message translates to:
  /// **'Campaigns on {date}'**
  String marketingCalendarCampaignsOn(String date);

  /// No description provided for @marketingSocialConnectTitle.
  ///
  /// In en, this message translates to:
  /// **'Connect accounts'**
  String get marketingSocialConnectTitle;

  /// No description provided for @marketingSocialConnectSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Connect your social accounts to publish updates.'**
  String get marketingSocialConnectSubtitle;

  /// No description provided for @marketingSocialConnected.
  ///
  /// In en, this message translates to:
  /// **'Connected'**
  String get marketingSocialConnected;

  /// No description provided for @marketingSocialNotConnected.
  ///
  /// In en, this message translates to:
  /// **'Not connected'**
  String get marketingSocialNotConnected;

  /// No description provided for @marketingSocialDisconnect.
  ///
  /// In en, this message translates to:
  /// **'Disconnect account'**
  String get marketingSocialDisconnect;

  /// No description provided for @marketingSocialConnectOAuth.
  ///
  /// In en, this message translates to:
  /// **'Connect with OAuth'**
  String get marketingSocialConnectOAuth;

  /// No description provided for @marketingSocialConnectedMock.
  ///
  /// In en, this message translates to:
  /// **'Connected'**
  String get marketingSocialConnectedMock;

  /// No description provided for @marketingSocialDisconnectedMock.
  ///
  /// In en, this message translates to:
  /// **'Account disconnected'**
  String get marketingSocialDisconnectedMock;

  /// No description provided for @marketingSocialConnectedSince.
  ///
  /// In en, this message translates to:
  /// **'Connected since {date}'**
  String marketingSocialConnectedSince(String date);

  /// No description provided for @marketingKindOffer.
  ///
  /// In en, this message translates to:
  /// **'Offer'**
  String get marketingKindOffer;

  /// No description provided for @marketingKindPromo.
  ///
  /// In en, this message translates to:
  /// **'Promo'**
  String get marketingKindPromo;

  /// No description provided for @marketingKindSocial.
  ///
  /// In en, this message translates to:
  /// **'Social'**
  String get marketingKindSocial;

  /// No description provided for @marketingKindLoyalty.
  ///
  /// In en, this message translates to:
  /// **'Loyalty'**
  String get marketingKindLoyalty;

  /// No description provided for @ticketPriorityLow.
  ///
  /// In en, this message translates to:
  /// **'Low'**
  String get ticketPriorityLow;

  /// No description provided for @ticketPriorityNormal.
  ///
  /// In en, this message translates to:
  /// **'Normal'**
  String get ticketPriorityNormal;

  /// No description provided for @ticketPriorityHigh.
  ///
  /// In en, this message translates to:
  /// **'High'**
  String get ticketPriorityHigh;

  /// No description provided for @ticketSlaOnTrack.
  ///
  /// In en, this message translates to:
  /// **'SLA: On track'**
  String get ticketSlaOnTrack;

  /// No description provided for @ticketSlaAtRisk.
  ///
  /// In en, this message translates to:
  /// **'SLA: At risk'**
  String get ticketSlaAtRisk;

  /// No description provided for @ticketSlaBreached.
  ///
  /// In en, this message translates to:
  /// **'SLA: Breached'**
  String get ticketSlaBreached;

  /// No description provided for @ownerViewConfigApplied.
  ///
  /// In en, this message translates to:
  /// **'Owner visibility profile applied'**
  String get ownerViewConfigApplied;

  /// No description provided for @filterAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get filterAll;

  /// No description provided for @filterByStatus.
  ///
  /// In en, this message translates to:
  /// **'Filter by status'**
  String get filterByStatus;

  /// No description provided for @filterByPriority.
  ///
  /// In en, this message translates to:
  /// **'Filter by priority'**
  String get filterByPriority;

  /// No description provided for @screenCustomizationModal.
  ///
  /// In en, this message translates to:
  /// **'Customize item'**
  String get screenCustomizationModal;

  /// No description provided for @screenCustomizationModalDesc.
  ///
  /// In en, this message translates to:
  /// **'Choose size and add-ons'**
  String get screenCustomizationModalDesc;

  /// No description provided for @hubNavigateHint.
  ///
  /// In en, this message translates to:
  /// **'Tap a destination to open the screen'**
  String get hubNavigateHint;

  /// No description provided for @screenPendingApproval.
  ///
  /// In en, this message translates to:
  /// **'Pending approval'**
  String get screenPendingApproval;

  /// No description provided for @actionSignOut.
  ///
  /// In en, this message translates to:
  /// **'Sign out'**
  String get actionSignOut;

  /// No description provided for @homeCategoriesTitle.
  ///
  /// In en, this message translates to:
  /// **'Categories'**
  String get homeCategoriesTitle;

  /// No description provided for @categoryEmptyMessage.
  ///
  /// In en, this message translates to:
  /// **'No items in this category yet.'**
  String get categoryEmptyMessage;

  /// No description provided for @homeExploreMenuTitle.
  ///
  /// In en, this message translates to:
  /// **'Explore Menu'**
  String get homeExploreMenuTitle;

  /// No description provided for @homeFeaturedTitle.
  ///
  /// In en, this message translates to:
  /// **'Featured Offers'**
  String get homeFeaturedTitle;

  /// No description provided for @homeStatusLabel.
  ///
  /// In en, this message translates to:
  /// **'STATUS'**
  String get homeStatusLabel;

  /// No description provided for @homePointsLabel.
  ///
  /// In en, this message translates to:
  /// **'Points'**
  String get homePointsLabel;

  /// No description provided for @homeCategoryAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get homeCategoryAll;

  /// No description provided for @homeFeaturedBadge.
  ///
  /// In en, this message translates to:
  /// **'Featured'**
  String get homeFeaturedBadge;

  /// No description provided for @homeAddToOrder.
  ///
  /// In en, this message translates to:
  /// **'Add to Order'**
  String get homeAddToOrder;

  /// No description provided for @homeSeeAll.
  ///
  /// In en, this message translates to:
  /// **'See All'**
  String get homeSeeAll;

  /// No description provided for @categoryEyebrow.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get categoryEyebrow;

  /// No description provided for @categoryMezzeTitle.
  ///
  /// In en, this message translates to:
  /// **'Cold Mezze & Appetizers'**
  String get categoryMezzeTitle;

  /// No description provided for @categoryMezzeDescription.
  ///
  /// In en, this message translates to:
  /// **'Discover our selection of traditional Levantine starters, prepared daily with fresh ingredients and authentic Jordanian flavors.'**
  String get categoryMezzeDescription;

  /// No description provided for @categoryShawarmaHeroTitle.
  ///
  /// In en, this message translates to:
  /// **'Legendary Beef Shawarma'**
  String get categoryShawarmaHeroTitle;

  /// No description provided for @categoryShawarmaHeroDescription.
  ///
  /// In en, this message translates to:
  /// **'Slow-roasted premium beef marinated in traditional spices, served with our signature garlic whip.'**
  String get categoryShawarmaHeroDescription;

  /// No description provided for @actionAddToOrder.
  ///
  /// In en, this message translates to:
  /// **'Add to Order'**
  String get actionAddToOrder;

  /// No description provided for @exploreMenuCategoriesTitle.
  ///
  /// In en, this message translates to:
  /// **'Menu Categories'**
  String get exploreMenuCategoriesTitle;

  /// No description provided for @exploreDailyRevenue.
  ///
  /// In en, this message translates to:
  /// **'Daily Revenue'**
  String get exploreDailyRevenue;

  /// No description provided for @explorePendingOrders.
  ///
  /// In en, this message translates to:
  /// **'Pending Orders'**
  String get explorePendingOrders;

  /// No description provided for @exploreActive.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get exploreActive;

  /// No description provided for @badgePlated.
  ///
  /// In en, this message translates to:
  /// **'Plated'**
  String get badgePlated;

  /// No description provided for @badgeDineInOnly.
  ///
  /// In en, this message translates to:
  /// **'Dine-in Only'**
  String get badgeDineInOnly;

  /// No description provided for @badgeLargeFamily.
  ///
  /// In en, this message translates to:
  /// **'Large Family'**
  String get badgeLargeFamily;

  /// No description provided for @badgeBestseller.
  ///
  /// In en, this message translates to:
  /// **'Bestseller'**
  String get badgeBestseller;

  /// No description provided for @badgeHighProtein.
  ///
  /// In en, this message translates to:
  /// **'High Protein'**
  String get badgeHighProtein;

  /// No description provided for @badgePlateMeal.
  ///
  /// In en, this message translates to:
  /// **'Plate Meal'**
  String get badgePlateMeal;

  /// No description provided for @badgeKetoChoice.
  ///
  /// In en, this message translates to:
  /// **'Keto Choice'**
  String get badgeKetoChoice;

  /// No description provided for @badgeSpicy.
  ///
  /// In en, this message translates to:
  /// **'Spicy'**
  String get badgeSpicy;

  /// No description provided for @badgeSignature.
  ///
  /// In en, this message translates to:
  /// **'Signature'**
  String get badgeSignature;

  /// No description provided for @badgeVegetarian.
  ///
  /// In en, this message translates to:
  /// **'Vegetarian'**
  String get badgeVegetarian;

  /// No description provided for @badgeHealthy.
  ///
  /// In en, this message translates to:
  /// **'Healthy'**
  String get badgeHealthy;

  /// No description provided for @badgeChefFavorite.
  ///
  /// In en, this message translates to:
  /// **'Chef favorite'**
  String get badgeChefFavorite;

  /// No description provided for @badgeFamily.
  ///
  /// In en, this message translates to:
  /// **'Family'**
  String get badgeFamily;

  /// No description provided for @cartEmptyMessage.
  ///
  /// In en, this message translates to:
  /// **'Your cart is empty'**
  String get cartEmptyMessage;

  /// No description provided for @productNotSelected.
  ///
  /// In en, this message translates to:
  /// **'Select a product from the menu'**
  String get productNotSelected;

  /// No description provided for @orderNumberLabel.
  ///
  /// In en, this message translates to:
  /// **'Order'**
  String get orderNumberLabel;

  /// No description provided for @orderStatusPreparing.
  ///
  /// In en, this message translates to:
  /// **'Preparing'**
  String get orderStatusPreparing;

  /// No description provided for @orderStatusReady.
  ///
  /// In en, this message translates to:
  /// **'Ready'**
  String get orderStatusReady;

  /// No description provided for @orderStatusOnWay.
  ///
  /// In en, this message translates to:
  /// **'On the way'**
  String get orderStatusOnWay;

  /// No description provided for @orderStatusDelivered.
  ///
  /// In en, this message translates to:
  /// **'Delivered'**
  String get orderStatusDelivered;

  /// No description provided for @orderStatusPending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get orderStatusPending;

  /// No description provided for @tableNumberLabel.
  ///
  /// In en, this message translates to:
  /// **'Table number'**
  String get tableNumberLabel;

  /// No description provided for @pickupTimeLabel.
  ///
  /// In en, this message translates to:
  /// **'Pickup time'**
  String get pickupTimeLabel;

  /// No description provided for @addressLabel.
  ///
  /// In en, this message translates to:
  /// **'Delivery address'**
  String get addressLabel;

  /// No description provided for @deliveryChooseAddress.
  ///
  /// In en, this message translates to:
  /// **'Choose Delivery Address'**
  String get deliveryChooseAddress;

  /// No description provided for @deliveryVerifiedZone.
  ///
  /// In en, this message translates to:
  /// **'Verified Zone'**
  String get deliveryVerifiedZone;

  /// No description provided for @deliveryHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get deliveryHome;

  /// No description provided for @deliveryWork.
  ///
  /// In en, this message translates to:
  /// **'Work'**
  String get deliveryWork;

  /// No description provided for @deliveryHomeAddress.
  ///
  /// In en, this message translates to:
  /// **'Villa 42, Al-Reem Street, Sweifieh, Amman, Jordan'**
  String get deliveryHomeAddress;

  /// No description provided for @deliveryWorkAddress.
  ///
  /// In en, this message translates to:
  /// **'The Business Park, Building 5, 3rd Floor, King Hussein Business Park, Amman'**
  String get deliveryWorkAddress;

  /// No description provided for @deliveryEdit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get deliveryEdit;

  /// No description provided for @deliveryRemove.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get deliveryRemove;

  /// No description provided for @deliveryAddNewAddress.
  ///
  /// In en, this message translates to:
  /// **'Add New Delivery Address'**
  String get deliveryAddNewAddress;

  /// No description provided for @deliveryMapPreview.
  ///
  /// In en, this message translates to:
  /// **'Area Map Preview'**
  String get deliveryMapPreview;

  /// No description provided for @deliveryRapidDelivery.
  ///
  /// In en, this message translates to:
  /// **'Rapid Delivery'**
  String get deliveryRapidDelivery;

  /// No description provided for @deliveryVerification.
  ///
  /// In en, this message translates to:
  /// **'Delivery Verification'**
  String get deliveryVerification;

  /// No description provided for @deliveryStandardAvailable.
  ///
  /// In en, this message translates to:
  /// **'Standard Delivery Available'**
  String get deliveryStandardAvailable;

  /// No description provided for @deliveryExpressZoneNote.
  ///
  /// In en, this message translates to:
  /// **'Your current selection is within our 15-minute express zone.'**
  String get deliveryExpressZoneNote;

  /// No description provided for @deliveryStandardFee.
  ///
  /// In en, this message translates to:
  /// **'Standard Delivery Fee'**
  String get deliveryStandardFee;

  /// No description provided for @deliveryEstimatedTotal.
  ///
  /// In en, this message translates to:
  /// **'Estimated Total'**
  String get deliveryEstimatedTotal;

  /// No description provided for @deliveryConfirmCheckout.
  ///
  /// In en, this message translates to:
  /// **'Confirm Address & Checkout'**
  String get deliveryConfirmCheckout;

  /// No description provided for @deliveryOrderTitle.
  ///
  /// In en, this message translates to:
  /// **'Order #{id}'**
  String deliveryOrderTitle(String id);

  /// No description provided for @deliveryCollectionPoint.
  ///
  /// In en, this message translates to:
  /// **'Collection Point'**
  String get deliveryCollectionPoint;

  /// No description provided for @deliveryKitchenStationB.
  ///
  /// In en, this message translates to:
  /// **'Kitchen Station B'**
  String get deliveryKitchenStationB;

  /// No description provided for @deliveryReadyForPickup.
  ///
  /// In en, this message translates to:
  /// **'Ready for Pickup'**
  String get deliveryReadyForPickup;

  /// No description provided for @deliveryPickupCustomer.
  ///
  /// In en, this message translates to:
  /// **'Customer: {name}'**
  String deliveryPickupCustomer(String name);

  /// No description provided for @deliveryVerifyAllItems.
  ///
  /// In en, this message translates to:
  /// **'Verify All Items ({count})'**
  String deliveryVerifyAllItems(int count);

  /// No description provided for @deliveryBagCount.
  ///
  /// In en, this message translates to:
  /// **'Bag 1 of 1'**
  String get deliveryBagCount;

  /// No description provided for @deliveryOrderTotal.
  ///
  /// In en, this message translates to:
  /// **'Order Total'**
  String get deliveryOrderTotal;

  /// No description provided for @deliveryReusableBagDeposit.
  ///
  /// In en, this message translates to:
  /// **'Reusable Bag Deposit'**
  String get deliveryReusableBagDeposit;

  /// No description provided for @deliveryTotalToCollect.
  ///
  /// In en, this message translates to:
  /// **'Total to Collect'**
  String get deliveryTotalToCollect;

  /// No description provided for @deliveryCashOnDelivery.
  ///
  /// In en, this message translates to:
  /// **'Cash on Delivery'**
  String get deliveryCashOnDelivery;

  /// No description provided for @deliveryReportMissingItem.
  ///
  /// In en, this message translates to:
  /// **'Report Missing Item'**
  String get deliveryReportMissingItem;

  /// No description provided for @deliveryConfirmPickup.
  ///
  /// In en, this message translates to:
  /// **'Confirm Pickup'**
  String get deliveryConfirmPickup;

  /// No description provided for @deliveryDashboardTitle.
  ///
  /// In en, this message translates to:
  /// **'Delivery Dashboard'**
  String get deliveryDashboardTitle;

  /// No description provided for @deliveryShiftSummary.
  ///
  /// In en, this message translates to:
  /// **'Shift Active: 4h 12m • 8 tasks completed'**
  String get deliveryShiftSummary;

  /// No description provided for @deliveryTasks.
  ///
  /// In en, this message translates to:
  /// **'Delivery Tasks'**
  String get deliveryTasks;

  /// No description provided for @deliveryReturnTasks.
  ///
  /// In en, this message translates to:
  /// **'Return Tasks'**
  String get deliveryReturnTasks;

  /// No description provided for @deliveryTaskBadge.
  ///
  /// In en, this message translates to:
  /// **'Delivery'**
  String get deliveryTaskBadge;

  /// No description provided for @deliveryPlatedReturnBadge.
  ///
  /// In en, this message translates to:
  /// **'Plated • Tray Return'**
  String get deliveryPlatedReturnBadge;

  /// No description provided for @deliveryReadyToGo.
  ///
  /// In en, this message translates to:
  /// **'Ready to Go'**
  String get deliveryReadyToGo;

  /// No description provided for @deliveryPendingKitchen.
  ///
  /// In en, this message translates to:
  /// **'Pending Kitchen'**
  String get deliveryPendingKitchen;

  /// No description provided for @deliveryAddNote.
  ///
  /// In en, this message translates to:
  /// **'Add Note'**
  String get deliveryAddNote;

  /// No description provided for @deliveryStartDelivery.
  ///
  /// In en, this message translates to:
  /// **'Start Delivery'**
  String get deliveryStartDelivery;

  /// No description provided for @deliveryMarkCollected.
  ///
  /// In en, this message translates to:
  /// **'Mark Collected'**
  String get deliveryMarkCollected;

  /// No description provided for @deliveryOverdue.
  ///
  /// In en, this message translates to:
  /// **'15m Overdue'**
  String get deliveryOverdue;

  /// No description provided for @deliveryOrder8842Address.
  ///
  /// In en, this message translates to:
  /// **'1282 Park Avenue'**
  String get deliveryOrder8842Address;

  /// No description provided for @deliveryOrder8842Note.
  ///
  /// In en, this message translates to:
  /// **'Apt 4B • High-rise Entry Code 4421'**
  String get deliveryOrder8842Note;

  /// No description provided for @deliveryTable14Pickup.
  ///
  /// In en, this message translates to:
  /// **'Table #14 Pickup'**
  String get deliveryTable14Pickup;

  /// No description provided for @deliverySkyLounge.
  ///
  /// In en, this message translates to:
  /// **'Sky Lounge Terrace'**
  String get deliverySkyLounge;

  /// No description provided for @deliveryTrayReturnDetails.
  ///
  /// In en, this message translates to:
  /// **'2 Ceramic Platters • 4 Wine Glasses'**
  String get deliveryTrayReturnDetails;

  /// No description provided for @deliveryOrder8845Address.
  ///
  /// In en, this message translates to:
  /// **'882 Broadway St'**
  String get deliveryOrder8845Address;

  /// No description provided for @deliveryOrder8845Note.
  ///
  /// In en, this message translates to:
  /// **'Office Lobby • Leave at Front Desk'**
  String get deliveryOrder8845Note;

  /// No description provided for @deliveryNextStop.
  ///
  /// In en, this message translates to:
  /// **'Next Stop'**
  String get deliveryNextStop;

  /// No description provided for @deliveryMilesAway.
  ///
  /// In en, this message translates to:
  /// **'3.2 miles'**
  String get deliveryMilesAway;

  /// No description provided for @deliveryCurrentDirection.
  ///
  /// In en, this message translates to:
  /// **'Current Direction'**
  String get deliveryCurrentDirection;

  /// No description provided for @deliveryNorthPark.
  ///
  /// In en, this message translates to:
  /// **'North on Park Ave'**
  String get deliveryNorthPark;

  /// No description provided for @deliveryShiftEarnings.
  ///
  /// In en, this message translates to:
  /// **'Shift Earnings'**
  String get deliveryShiftEarnings;

  /// No description provided for @deliveryIncludesTips.
  ///
  /// In en, this message translates to:
  /// **'Includes {amount} Tips'**
  String deliveryIncludesTips(String amount);

  /// No description provided for @deliveryViewHistory.
  ///
  /// In en, this message translates to:
  /// **'View History'**
  String get deliveryViewHistory;

  /// No description provided for @deliveryHistoryTotalEarnings.
  ///
  /// In en, this message translates to:
  /// **'Total Earnings Today'**
  String get deliveryHistoryTotalEarnings;

  /// No description provided for @deliveryHistoryEarningsDelta.
  ///
  /// In en, this message translates to:
  /// **'+12% from yesterday'**
  String get deliveryHistoryEarningsDelta;

  /// No description provided for @deliveryHistoryCompleted.
  ///
  /// In en, this message translates to:
  /// **'Deliveries Completed'**
  String get deliveryHistoryCompleted;

  /// No description provided for @deliveryHistoryAvgTime.
  ///
  /// In en, this message translates to:
  /// **'Avg: 22 mins per delivery'**
  String get deliveryHistoryAvgTime;

  /// No description provided for @deliveryHistoryTipsEarned.
  ///
  /// In en, this message translates to:
  /// **'Total Tips Earned'**
  String get deliveryHistoryTipsEarned;

  /// No description provided for @deliveryHistoryGoal.
  ///
  /// In en, this message translates to:
  /// **'65% of your goal reached'**
  String get deliveryHistoryGoal;

  /// No description provided for @deliveryHistoryTitle.
  ///
  /// In en, this message translates to:
  /// **'Delivery History'**
  String get deliveryHistoryTitle;

  /// No description provided for @deliveryHistoryFilter.
  ///
  /// In en, this message translates to:
  /// **'Filter'**
  String get deliveryHistoryFilter;

  /// No description provided for @deliveryTipEarned.
  ///
  /// In en, this message translates to:
  /// **'Tip Earned:'**
  String get deliveryTipEarned;

  /// No description provided for @deliveryViewDetails.
  ///
  /// In en, this message translates to:
  /// **'View Details'**
  String get deliveryViewDetails;

  /// No description provided for @deliveryLoadPreviousDays.
  ///
  /// In en, this message translates to:
  /// **'Load Previous Days'**
  String get deliveryLoadPreviousDays;

  /// No description provided for @deliveryFinance.
  ///
  /// In en, this message translates to:
  /// **'Finance'**
  String get deliveryFinance;

  /// No description provided for @deliveryReturnsTitle.
  ///
  /// In en, this message translates to:
  /// **'Delivery - Past Returns History'**
  String get deliveryReturnsTitle;

  /// No description provided for @deliveryReturnsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Review all completed tray collections and financial settlements.'**
  String get deliveryReturnsSubtitle;

  /// No description provided for @deliveryReturnsContext.
  ///
  /// In en, this message translates to:
  /// **'Logistics / Returns'**
  String get deliveryReturnsContext;

  /// No description provided for @deliveryReturnTasksTitle.
  ///
  /// In en, this message translates to:
  /// **'Return Tasks'**
  String get deliveryReturnTasksTitle;

  /// No description provided for @deliveryActiveCollections.
  ///
  /// In en, this message translates to:
  /// **'Active Collections'**
  String get deliveryActiveCollections;

  /// No description provided for @deliveryScheduledCount.
  ///
  /// In en, this message translates to:
  /// **'{count} Scheduled'**
  String deliveryScheduledCount(int count);

  /// No description provided for @deliverySustainabilityGoal.
  ///
  /// In en, this message translates to:
  /// **'Sustainability Goal'**
  String get deliverySustainabilityGoal;

  /// No description provided for @deliveryTrayCount.
  ///
  /// In en, this message translates to:
  /// **'{count} Trays'**
  String deliveryTrayCount(int count);

  /// No description provided for @deliveryArrived.
  ///
  /// In en, this message translates to:
  /// **'Arrived'**
  String get deliveryArrived;

  /// No description provided for @deliveryRouteOverview.
  ///
  /// In en, this message translates to:
  /// **'Route Overview'**
  String get deliveryRouteOverview;

  /// No description provided for @deliveryMilesRemaining.
  ///
  /// In en, this message translates to:
  /// **'4.2 Miles Remaining'**
  String get deliveryMilesRemaining;

  /// No description provided for @deliveryTotalTrays.
  ///
  /// In en, this message translates to:
  /// **'Total Trays'**
  String get deliveryTotalTrays;

  /// No description provided for @deliverySuccessfullyReturned.
  ///
  /// In en, this message translates to:
  /// **'Successfully Returned'**
  String get deliverySuccessfullyReturned;

  /// No description provided for @deliveryDepositsRefunded.
  ///
  /// In en, this message translates to:
  /// **'Deposits Refunded'**
  String get deliveryDepositsRefunded;

  /// No description provided for @deliveryReturnedToCustomers.
  ///
  /// In en, this message translates to:
  /// **'Returned to Customers'**
  String get deliveryReturnedToCustomers;

  /// No description provided for @deliveryBreakageFees.
  ///
  /// In en, this message translates to:
  /// **'Breakage Fees'**
  String get deliveryBreakageFees;

  /// No description provided for @deliveryReportedDamage.
  ///
  /// In en, this message translates to:
  /// **'Reported Damage'**
  String get deliveryReportedDamage;

  /// No description provided for @deliverySuccessRate.
  ///
  /// In en, this message translates to:
  /// **'Success Rate'**
  String get deliverySuccessRate;

  /// No description provided for @deliveryDayAverage.
  ///
  /// In en, this message translates to:
  /// **'32 Day Average'**
  String get deliveryDayAverage;

  /// No description provided for @deliveryRecentReturns.
  ///
  /// In en, this message translates to:
  /// **'Recent Returns'**
  String get deliveryRecentReturns;

  /// No description provided for @deliveryThisWeek.
  ///
  /// In en, this message translates to:
  /// **'This Week'**
  String get deliveryThisWeek;

  /// No description provided for @deliveryFilters.
  ///
  /// In en, this message translates to:
  /// **'Filters'**
  String get deliveryFilters;

  /// No description provided for @deliveryExport.
  ///
  /// In en, this message translates to:
  /// **'Export'**
  String get deliveryExport;

  /// No description provided for @deliveryRefunded.
  ///
  /// In en, this message translates to:
  /// **'Refunded'**
  String get deliveryRefunded;

  /// No description provided for @deliveryNetRefund.
  ///
  /// In en, this message translates to:
  /// **'Net Refund'**
  String get deliveryNetRefund;

  /// No description provided for @deliveryLoadMoreHistory.
  ///
  /// In en, this message translates to:
  /// **'Load More History'**
  String get deliveryLoadMoreHistory;

  /// No description provided for @couponCodeLabel.
  ///
  /// In en, this message translates to:
  /// **'Coupon code'**
  String get couponCodeLabel;

  /// No description provided for @walletBalanceLabel.
  ///
  /// In en, this message translates to:
  /// **'Balance'**
  String get walletBalanceLabel;

  /// No description provided for @loyaltyPointsLabel.
  ///
  /// In en, this message translates to:
  /// **'Points'**
  String get loyaltyPointsLabel;

  /// No description provided for @mapSelectHint.
  ///
  /// In en, this message translates to:
  /// **'Tap the map to set the delivery location.'**
  String get mapSelectHint;

  /// No description provided for @actionConfirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get actionConfirm;

  /// No description provided for @screenNotReady.
  ///
  /// In en, this message translates to:
  /// **'Screen loading…'**
  String get screenNotReady;

  /// No description provided for @platedReturnReminderBody.
  ///
  /// In en, this message translates to:
  /// **'Please prepare the tray for pickup after your meal.'**
  String get platedReturnReminderBody;

  /// No description provided for @redemptionConfirmBody.
  ///
  /// In en, this message translates to:
  /// **'Redeem your points for this reward?'**
  String get redemptionConfirmBody;

  /// No description provided for @reportDateFrom.
  ///
  /// In en, this message translates to:
  /// **'From date'**
  String get reportDateFrom;

  /// No description provided for @reportDateTo.
  ///
  /// In en, this message translates to:
  /// **'To date'**
  String get reportDateTo;

  /// No description provided for @depositAmountLabel.
  ///
  /// In en, this message translates to:
  /// **'Deposit amount (JOD)'**
  String get depositAmountLabel;

  /// No description provided for @depositBreadcrumbSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get depositBreadcrumbSettings;

  /// No description provided for @depositBreadcrumbLogistics.
  ///
  /// In en, this message translates to:
  /// **'Logistics'**
  String get depositBreadcrumbLogistics;

  /// No description provided for @depositBreadcrumbTrayReturns.
  ///
  /// In en, this message translates to:
  /// **'Tray Deposits & Returns'**
  String get depositBreadcrumbTrayReturns;

  /// No description provided for @depositTrayConfiguration.
  ///
  /// In en, this message translates to:
  /// **'Tray Configuration'**
  String get depositTrayConfiguration;

  /// No description provided for @depositConfigurationSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Manage global deposit rates and automated return policy enforcement.'**
  String get depositConfigurationSubtitle;

  /// No description provided for @depositGlobalTitle.
  ///
  /// In en, this message translates to:
  /// **'Global Deposit'**
  String get depositGlobalTitle;

  /// No description provided for @depositGlobalAmountLabel.
  ///
  /// In en, this message translates to:
  /// **'Global Deposit Amount (JOD)'**
  String get depositGlobalAmountLabel;

  /// No description provided for @depositGlobalHelp.
  ///
  /// In en, this message translates to:
  /// **'This amount is automatically added to all takeaway and delivery orders containing trays.'**
  String get depositGlobalHelp;

  /// No description provided for @depositWarning.
  ///
  /// In en, this message translates to:
  /// **'Increasing the deposit amount will update all new orders instantly. Active pending orders will retain their original deposit value.'**
  String get depositWarning;

  /// No description provided for @depositReturnWindow.
  ///
  /// In en, this message translates to:
  /// **'Return Window'**
  String get depositReturnWindow;

  /// No description provided for @depositMaxReturnWindow.
  ///
  /// In en, this message translates to:
  /// **'Max Return Window'**
  String get depositMaxReturnWindow;

  /// No description provided for @depositHours.
  ///
  /// In en, this message translates to:
  /// **'{count} Hours'**
  String depositHours(int count);

  /// No description provided for @depositOneHour.
  ///
  /// In en, this message translates to:
  /// **'1 Hr'**
  String get depositOneHour;

  /// No description provided for @depositSevenDays.
  ///
  /// In en, this message translates to:
  /// **'7 Days'**
  String get depositSevenDays;

  /// No description provided for @depositAutomatedReminders.
  ///
  /// In en, this message translates to:
  /// **'Automated Reminders'**
  String get depositAutomatedReminders;

  /// No description provided for @depositReminderChannel.
  ///
  /// In en, this message translates to:
  /// **'Notify via SMS/Email'**
  String get depositReminderChannel;

  /// No description provided for @depositSave.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get depositSave;

  /// No description provided for @settingsNotifications.
  ///
  /// In en, this message translates to:
  /// **'Push notifications'**
  String get settingsNotifications;

  /// No description provided for @settingsOwnerPrivacy.
  ///
  /// In en, this message translates to:
  /// **'Hide tip details from owner'**
  String get settingsOwnerPrivacy;

  /// No description provided for @screenLanguageSelection.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get screenLanguageSelection;

  /// No description provided for @screenLogin.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get screenLogin;

  /// No description provided for @screenOtpVerification.
  ///
  /// In en, this message translates to:
  /// **'Verification'**
  String get screenOtpVerification;

  /// No description provided for @screenRegister.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get screenRegister;

  /// No description provided for @screenForgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Reset password'**
  String get screenForgotPassword;

  /// No description provided for @screenRoleSelection.
  ///
  /// In en, this message translates to:
  /// **'Choose role'**
  String get screenRoleSelection;

  /// No description provided for @screenGuestBrowse.
  ///
  /// In en, this message translates to:
  /// **'Menu (guest)'**
  String get screenGuestBrowse;

  /// No description provided for @screenHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get screenHome;

  /// No description provided for @screenMenu.
  ///
  /// In en, this message translates to:
  /// **'Menu'**
  String get screenMenu;

  /// No description provided for @screenCategory.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get screenCategory;

  /// No description provided for @screenProductDetail.
  ///
  /// In en, this message translates to:
  /// **'Product'**
  String get screenProductDetail;

  /// No description provided for @screenCart.
  ///
  /// In en, this message translates to:
  /// **'Cart'**
  String get screenCart;

  /// No description provided for @screenSupport.
  ///
  /// In en, this message translates to:
  /// **'Support'**
  String get screenSupport;

  /// No description provided for @screenOrderTypeSelection.
  ///
  /// In en, this message translates to:
  /// **'Order type'**
  String get screenOrderTypeSelection;

  /// No description provided for @screenDineInTable.
  ///
  /// In en, this message translates to:
  /// **'Table number'**
  String get screenDineInTable;

  /// No description provided for @screenTakeawayPickup.
  ///
  /// In en, this message translates to:
  /// **'Pickup'**
  String get screenTakeawayPickup;

  /// No description provided for @screenDeliveryAddress.
  ///
  /// In en, this message translates to:
  /// **'Delivery address'**
  String get screenDeliveryAddress;

  /// No description provided for @screenPlatedDeliveryInfo.
  ///
  /// In en, this message translates to:
  /// **'Plated delivery'**
  String get screenPlatedDeliveryInfo;

  /// No description provided for @screenCheckout.
  ///
  /// In en, this message translates to:
  /// **'Checkout'**
  String get screenCheckout;

  /// No description provided for @screenTipSelection.
  ///
  /// In en, this message translates to:
  /// **'Tip'**
  String get screenTipSelection;

  /// No description provided for @screenPayment.
  ///
  /// In en, this message translates to:
  /// **'Payment'**
  String get screenPayment;

  /// No description provided for @screenOrderConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Order confirmed'**
  String get screenOrderConfirmation;

  /// No description provided for @screenOrderTracking.
  ///
  /// In en, this message translates to:
  /// **'Track order'**
  String get screenOrderTracking;

  /// No description provided for @screenOrderHistory.
  ///
  /// In en, this message translates to:
  /// **'Order history'**
  String get screenOrderHistory;

  /// No description provided for @drawerOrders.
  ///
  /// In en, this message translates to:
  /// **'Orders'**
  String get drawerOrders;

  /// No description provided for @drawerBlog.
  ///
  /// In en, this message translates to:
  /// **'Blog'**
  String get drawerBlog;

  /// No description provided for @screenWallet.
  ///
  /// In en, this message translates to:
  /// **'Wallet'**
  String get screenWallet;

  /// No description provided for @screenLoyalty.
  ///
  /// In en, this message translates to:
  /// **'Loyalty'**
  String get screenLoyalty;

  /// No description provided for @screenRewardsCatalog.
  ///
  /// In en, this message translates to:
  /// **'Rewards'**
  String get screenRewardsCatalog;

  /// No description provided for @screenRewardsHistory.
  ///
  /// In en, this message translates to:
  /// **'Rewards history'**
  String get screenRewardsHistory;

  /// No description provided for @rewardsHistoryEmpty.
  ///
  /// In en, this message translates to:
  /// **'No point activity yet. Order or redeem a reward.'**
  String get rewardsHistoryEmpty;

  /// No description provided for @screenPaymentHistory.
  ///
  /// In en, this message translates to:
  /// **'Payment history'**
  String get screenPaymentHistory;

  /// No description provided for @screenRedemptionConfirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm redemption'**
  String get screenRedemptionConfirm;

  /// No description provided for @screenProfile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get screenProfile;

  /// No description provided for @screenAccountSettings.
  ///
  /// In en, this message translates to:
  /// **'Account settings'**
  String get screenAccountSettings;

  /// No description provided for @drawerSectionMore.
  ///
  /// In en, this message translates to:
  /// **'More'**
  String get drawerSectionMore;

  /// No description provided for @demoActionTag.
  ///
  /// In en, this message translates to:
  /// **''**
  String get demoActionTag;

  /// No description provided for @screenAddresses.
  ///
  /// In en, this message translates to:
  /// **'Addresses'**
  String get screenAddresses;

  /// No description provided for @screenMapPicker.
  ///
  /// In en, this message translates to:
  /// **'Map'**
  String get screenMapPicker;

  /// No description provided for @screenNotifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get screenNotifications;

  /// No description provided for @screenPlatedReturnReminder.
  ///
  /// In en, this message translates to:
  /// **'Return tray'**
  String get screenPlatedReturnReminder;

  /// No description provided for @screenOffers.
  ///
  /// In en, this message translates to:
  /// **'Offers'**
  String get screenOffers;

  /// No description provided for @screenCouponApply.
  ///
  /// In en, this message translates to:
  /// **'Coupon'**
  String get screenCouponApply;

  /// No description provided for @screenComboBuilder.
  ///
  /// In en, this message translates to:
  /// **'Combo builder'**
  String get screenComboBuilder;

  /// No description provided for @screenKitchenDashboard.
  ///
  /// In en, this message translates to:
  /// **'Kitchen'**
  String get screenKitchenDashboard;

  /// No description provided for @screenOrderPrep.
  ///
  /// In en, this message translates to:
  /// **'Order prep'**
  String get screenOrderPrep;

  /// No description provided for @screenInventoryDashboard.
  ///
  /// In en, this message translates to:
  /// **'Inventory'**
  String get screenInventoryDashboard;

  /// No description provided for @screenInventoryItem.
  ///
  /// In en, this message translates to:
  /// **'Item details'**
  String get screenInventoryItem;

  /// No description provided for @screenStockAdjustment.
  ///
  /// In en, this message translates to:
  /// **'Stock adjustment'**
  String get screenStockAdjustment;

  /// No description provided for @screenDeliveryDashboard.
  ///
  /// In en, this message translates to:
  /// **'Delivery'**
  String get screenDeliveryDashboard;

  /// No description provided for @screenDeliveryOrder.
  ///
  /// In en, this message translates to:
  /// **'Delivery order'**
  String get screenDeliveryOrder;

  /// No description provided for @screenPlatedReturnTask.
  ///
  /// In en, this message translates to:
  /// **'Return tasks'**
  String get screenPlatedReturnTask;

  /// No description provided for @screenPlatedReturnProcess.
  ///
  /// In en, this message translates to:
  /// **'Return process'**
  String get screenPlatedReturnProcess;

  /// No description provided for @screenCashierOrder.
  ///
  /// In en, this message translates to:
  /// **'Cashier POS'**
  String get screenCashierOrder;

  /// No description provided for @screenCashierTipEntry.
  ///
  /// In en, this message translates to:
  /// **'Cash tip'**
  String get screenCashierTipEntry;

  /// No description provided for @screenCashierDepositRefund.
  ///
  /// In en, this message translates to:
  /// **'Deposit refund'**
  String get screenCashierDepositRefund;

  /// No description provided for @screenCashierOrderHistory.
  ///
  /// In en, this message translates to:
  /// **'Cashier order history'**
  String get screenCashierOrderHistory;

  /// No description provided for @screenStaffAttendance.
  ///
  /// In en, this message translates to:
  /// **'Attendance'**
  String get screenStaffAttendance;

  /// No description provided for @screenStaffDailyTips.
  ///
  /// In en, this message translates to:
  /// **'Daily tips'**
  String get screenStaffDailyTips;

  /// No description provided for @screenStaffTipHistory.
  ///
  /// In en, this message translates to:
  /// **'Tip history'**
  String get screenStaffTipHistory;

  /// No description provided for @screenAdminDashboard.
  ///
  /// In en, this message translates to:
  /// **'Admin'**
  String get screenAdminDashboard;

  /// No description provided for @screenOrdersManagement.
  ///
  /// In en, this message translates to:
  /// **'Orders'**
  String get screenOrdersManagement;

  /// No description provided for @screenOrderDetailAdmin.
  ///
  /// In en, this message translates to:
  /// **'Order detail'**
  String get screenOrderDetailAdmin;

  /// No description provided for @screenReports.
  ///
  /// In en, this message translates to:
  /// **'Reports'**
  String get screenReports;

  /// No description provided for @screenReportFilter.
  ///
  /// In en, this message translates to:
  /// **'Report filters'**
  String get screenReportFilter;

  /// No description provided for @screenFinancialCalculation.
  ///
  /// In en, this message translates to:
  /// **'Financial calculation'**
  String get screenFinancialCalculation;

  /// No description provided for @screenDailyTipDistribution.
  ///
  /// In en, this message translates to:
  /// **'Tip distribution'**
  String get screenDailyTipDistribution;

  /// No description provided for @screenPlatesManagement.
  ///
  /// In en, this message translates to:
  /// **'Plates'**
  String get screenPlatesManagement;

  /// No description provided for @screenPlateEditor.
  ///
  /// In en, this message translates to:
  /// **'Edit plate'**
  String get screenPlateEditor;

  /// No description provided for @screenDepositConfig.
  ///
  /// In en, this message translates to:
  /// **'Deposit config'**
  String get screenDepositConfig;

  /// No description provided for @screenUserManagement.
  ///
  /// In en, this message translates to:
  /// **'Users'**
  String get screenUserManagement;

  /// No description provided for @screenMenuManagement.
  ///
  /// In en, this message translates to:
  /// **'Menu'**
  String get screenMenuManagement;

  /// No description provided for @screenProductEditor.
  ///
  /// In en, this message translates to:
  /// **'Edit product'**
  String get screenProductEditor;

  /// No description provided for @screenOffersManagement.
  ///
  /// In en, this message translates to:
  /// **'Offers management'**
  String get screenOffersManagement;

  /// No description provided for @screenDiscountsManagement.
  ///
  /// In en, this message translates to:
  /// **'Discounts management'**
  String get screenDiscountsManagement;

  /// No description provided for @marketingDiscountLabelAr.
  ///
  /// In en, this message translates to:
  /// **'Label AR'**
  String get marketingDiscountLabelAr;

  /// No description provided for @marketingDiscountLabelEn.
  ///
  /// In en, this message translates to:
  /// **'Label EN'**
  String get marketingDiscountLabelEn;

  /// No description provided for @marketingLinkedRewardTitle.
  ///
  /// In en, this message translates to:
  /// **'Linked reward'**
  String get marketingLinkedRewardTitle;

  /// No description provided for @marketingLinkedRewardNone.
  ///
  /// In en, this message translates to:
  /// **'No linked reward'**
  String get marketingLinkedRewardNone;

  /// No description provided for @marketingCampaignAttachTitle.
  ///
  /// In en, this message translates to:
  /// **'Attach offers & combos'**
  String get marketingCampaignAttachTitle;

  /// No description provided for @marketingCalendarCampaignAuthorityNotice.
  ///
  /// In en, this message translates to:
  /// **'Campaigns control customer visibility. Offers, combos, and discounts only appear while their campaign window is live.'**
  String get marketingCalendarCampaignAuthorityNotice;

  /// No description provided for @screenAddonsManagement.
  ///
  /// In en, this message translates to:
  /// **'Add-ons'**
  String get screenAddonsManagement;

  /// No description provided for @menuCatalogTabProduct.
  ///
  /// In en, this message translates to:
  /// **'Product'**
  String get menuCatalogTabProduct;

  /// No description provided for @menuCatalogTabProducts.
  ///
  /// In en, this message translates to:
  /// **'Products'**
  String get menuCatalogTabProducts;

  /// No description provided for @menuCatalogTabReward.
  ///
  /// In en, this message translates to:
  /// **'Reward'**
  String get menuCatalogTabReward;

  /// No description provided for @menuCatalogTabRatings.
  ///
  /// In en, this message translates to:
  /// **'Ratings'**
  String get menuCatalogTabRatings;

  /// No description provided for @menuCatalogPickProduct.
  ///
  /// In en, this message translates to:
  /// **'Select a product'**
  String get menuCatalogPickProduct;

  /// No description provided for @menuCatalogPickProductHint.
  ///
  /// In en, this message translates to:
  /// **'Choose a product to manage add-ons or related items.'**
  String get menuCatalogPickProductHint;

  /// No description provided for @menuCatalogRewardPointsLabel.
  ///
  /// In en, this message translates to:
  /// **'Reward points'**
  String get menuCatalogRewardPointsLabel;

  /// No description provided for @menuCatalogEditRating.
  ///
  /// In en, this message translates to:
  /// **'Edit rating & remarks'**
  String get menuCatalogEditRating;

  /// No description provided for @menuCatalogRatingSaved.
  ///
  /// In en, this message translates to:
  /// **'Rating updated'**
  String get menuCatalogRatingSaved;

  /// No description provided for @menuCatalogManageProduct.
  ///
  /// In en, this message translates to:
  /// **'Manage'**
  String get menuCatalogManageProduct;

  /// No description provided for @menuCatalogNoProducts.
  ///
  /// In en, this message translates to:
  /// **'No products yet'**
  String get menuCatalogNoProducts;

  /// No description provided for @menuCatalogAttachAddonsHint.
  ///
  /// In en, this message translates to:
  /// **'Select approved add-ons for this product. Mark free or set a price override.'**
  String get menuCatalogAttachAddonsHint;

  /// No description provided for @menuCatalogAddonPriceOverride.
  ///
  /// In en, this message translates to:
  /// **'Price override (JOD)'**
  String get menuCatalogAddonPriceOverride;

  /// No description provided for @menuCatalogRelatedMultiSelectHint.
  ///
  /// In en, this message translates to:
  /// **'Select related products from the active menu.'**
  String get menuCatalogRelatedMultiSelectHint;

  /// No description provided for @catalogCrudAddonKey.
  ///
  /// In en, this message translates to:
  /// **'Key'**
  String get catalogCrudAddonKey;

  /// No description provided for @catalogCrudLabelEn.
  ///
  /// In en, this message translates to:
  /// **'Label EN'**
  String get catalogCrudLabelEn;

  /// No description provided for @catalogCrudLabelAr.
  ///
  /// In en, this message translates to:
  /// **'Label AR'**
  String get catalogCrudLabelAr;

  /// No description provided for @catalogCrudSortOrder.
  ///
  /// In en, this message translates to:
  /// **'Sort order'**
  String get catalogCrudSortOrder;

  /// No description provided for @catalogCrudDescriptionEn.
  ///
  /// In en, this message translates to:
  /// **'Description EN'**
  String get catalogCrudDescriptionEn;

  /// No description provided for @catalogCrudDescriptionAr.
  ///
  /// In en, this message translates to:
  /// **'Description AR'**
  String get catalogCrudDescriptionAr;

  /// No description provided for @catalogCrudMealType.
  ///
  /// In en, this message translates to:
  /// **'Meal type'**
  String get catalogCrudMealType;

  /// No description provided for @catalogCrudMealMain.
  ///
  /// In en, this message translates to:
  /// **'Main'**
  String get catalogCrudMealMain;

  /// No description provided for @catalogCrudMealSide.
  ///
  /// In en, this message translates to:
  /// **'Side'**
  String get catalogCrudMealSide;

  /// No description provided for @catalogCrudMealDrink.
  ///
  /// In en, this message translates to:
  /// **'Drink'**
  String get catalogCrudMealDrink;

  /// No description provided for @catalogCrudMealDessert.
  ///
  /// In en, this message translates to:
  /// **'Dessert'**
  String get catalogCrudMealDessert;

  /// No description provided for @loyaltyOccasionsTitle.
  ///
  /// In en, this message translates to:
  /// **'Occasion rewards'**
  String get loyaltyOccasionsTitle;

  /// No description provided for @loyaltyOccasionsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Active occasions apply to all customers.'**
  String get loyaltyOccasionsSubtitle;

  /// No description provided for @loyaltyOccasionAddCustom.
  ///
  /// In en, this message translates to:
  /// **'Add custom occasion'**
  String get loyaltyOccasionAddCustom;

  /// No description provided for @loyaltyOccasionRewardEn.
  ///
  /// In en, this message translates to:
  /// **'Reward title EN'**
  String get loyaltyOccasionRewardEn;

  /// No description provided for @loyaltyOccasionRewardAr.
  ///
  /// In en, this message translates to:
  /// **'Reward title AR'**
  String get loyaltyOccasionRewardAr;

  /// No description provided for @loyaltyOccasionPoints.
  ///
  /// In en, this message translates to:
  /// **'Bonus points'**
  String get loyaltyOccasionPoints;

  /// No description provided for @rewardsAdminTiersHint.
  ///
  /// In en, this message translates to:
  /// **'Earn and redeem rates by points balance band.'**
  String get rewardsAdminTiersHint;

  /// No description provided for @rewardsAdminTierRange.
  ///
  /// In en, this message translates to:
  /// **'{min}–{max} pts'**
  String rewardsAdminTierRange(String min, String max);

  /// No description provided for @rewardsAdminTierRates.
  ///
  /// In en, this message translates to:
  /// **'Earn {earn}/JOD · Redeem ×{redeem}'**
  String rewardsAdminTierRates(String earn, String redeem);

  /// No description provided for @rewardsAdminTierMin.
  ///
  /// In en, this message translates to:
  /// **'Min points'**
  String get rewardsAdminTierMin;

  /// No description provided for @rewardsAdminTierMax.
  ///
  /// In en, this message translates to:
  /// **'Max points (blank = open)'**
  String get rewardsAdminTierMax;

  /// No description provided for @rewardsAdminTierEarn.
  ///
  /// In en, this message translates to:
  /// **'Earn per JOD'**
  String get rewardsAdminTierEarn;

  /// No description provided for @rewardsAdminTierRedeem.
  ///
  /// In en, this message translates to:
  /// **'Redeem factor'**
  String get rewardsAdminTierRedeem;

  /// No description provided for @marketingCampaignScheduleTitle.
  ///
  /// In en, this message translates to:
  /// **'Campaign schedule'**
  String get marketingCampaignScheduleTitle;

  /// No description provided for @marketingCampaignScheduleHint.
  ///
  /// In en, this message translates to:
  /// **'Pick or create a campaign window. Activating always requires a fresh schedule.'**
  String get marketingCampaignScheduleHint;

  /// No description provided for @marketingCampaignNew.
  ///
  /// In en, this message translates to:
  /// **'New campaign'**
  String get marketingCampaignNew;

  /// No description provided for @marketingCampaignNone.
  ///
  /// In en, this message translates to:
  /// **'No campaign'**
  String get marketingCampaignNone;

  /// No description provided for @marketingCampaignPickExisting.
  ///
  /// In en, this message translates to:
  /// **'Existing campaign'**
  String get marketingCampaignPickExisting;

  /// No description provided for @marketingCampaignInvalidWindow.
  ///
  /// In en, this message translates to:
  /// **'End must be after start'**
  String get marketingCampaignInvalidWindow;

  /// No description provided for @marketingScheduleStart.
  ///
  /// In en, this message translates to:
  /// **'Start: {when}'**
  String marketingScheduleStart(String when);

  /// No description provided for @marketingScheduleEnd.
  ///
  /// In en, this message translates to:
  /// **'End: {when}'**
  String marketingScheduleEnd(String when);

  /// No description provided for @marketingRewardPointsLabel.
  ///
  /// In en, this message translates to:
  /// **'Reward points'**
  String get marketingRewardPointsLabel;

  /// No description provided for @marketingVisibilityNeedsSchedule.
  ///
  /// In en, this message translates to:
  /// **'Schedule a campaign before showing this item'**
  String get marketingVisibilityNeedsSchedule;

  /// No description provided for @marketingCampaignAdjust.
  ///
  /// In en, this message translates to:
  /// **'Adjust campaign'**
  String get marketingCampaignAdjust;

  /// No description provided for @marketingBadgeEn.
  ///
  /// In en, this message translates to:
  /// **'Badge EN'**
  String get marketingBadgeEn;

  /// No description provided for @marketingBadgeAr.
  ///
  /// In en, this message translates to:
  /// **'Badge AR'**
  String get marketingBadgeAr;

  /// No description provided for @screenLoyaltyConfig.
  ///
  /// In en, this message translates to:
  /// **'Loyalty config'**
  String get screenLoyaltyConfig;

  /// No description provided for @screenOwnerViewConfig.
  ///
  /// In en, this message translates to:
  /// **'Owner privacy'**
  String get screenOwnerViewConfig;

  /// No description provided for @screenPreOrder.
  ///
  /// In en, this message translates to:
  /// **'Pre-orders'**
  String get screenPreOrder;

  /// No description provided for @screenSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get screenSettings;

  /// No description provided for @screenAppIntegrations.
  ///
  /// In en, this message translates to:
  /// **'App Integrations'**
  String get screenAppIntegrations;

  /// No description provided for @integrationsSecurityNote.
  ///
  /// In en, this message translates to:
  /// **'Fill the credentials your provider gave you. Secrets are stored securely in production (Supabase Vault) — never in app code.'**
  String get integrationsSecurityNote;

  /// No description provided for @integrationsSaveAll.
  ///
  /// In en, this message translates to:
  /// **'Save all integrations'**
  String get integrationsSaveAll;

  /// No description provided for @integrationsSaveSuccess.
  ///
  /// In en, this message translates to:
  /// **'Integration settings saved.'**
  String get integrationsSaveSuccess;

  /// No description provided for @integrationsTestConnection.
  ///
  /// In en, this message translates to:
  /// **'Test connection'**
  String get integrationsTestConnection;

  /// No description provided for @integrationsTestSuccess.
  ///
  /// In en, this message translates to:
  /// **'Connection test passed'**
  String get integrationsTestSuccess;

  /// No description provided for @integrationsTestIncomplete.
  ///
  /// In en, this message translates to:
  /// **'Complete the required fields for this section first.'**
  String get integrationsTestIncomplete;

  /// No description provided for @integrationsStatusConfigured.
  ///
  /// In en, this message translates to:
  /// **'Configured'**
  String get integrationsStatusConfigured;

  /// No description provided for @integrationsStatusIncomplete.
  ///
  /// In en, this message translates to:
  /// **'Incomplete'**
  String get integrationsStatusIncomplete;

  /// No description provided for @integrationsLastSaved.
  ///
  /// In en, this message translates to:
  /// **'Last saved: {date}'**
  String integrationsLastSaved(String date);

  /// No description provided for @integrationsSupabaseTitle.
  ///
  /// In en, this message translates to:
  /// **'Supabase'**
  String get integrationsSupabaseTitle;

  /// No description provided for @integrationsSupabaseSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Database, auth, realtime, and edge functions.'**
  String get integrationsSupabaseSubtitle;

  /// No description provided for @integrationsSupabaseUrl.
  ///
  /// In en, this message translates to:
  /// **'Project URL'**
  String get integrationsSupabaseUrl;

  /// No description provided for @integrationsSupabaseUrlHint.
  ///
  /// In en, this message translates to:
  /// **'https://xxxxx.supabase.co'**
  String get integrationsSupabaseUrlHint;

  /// No description provided for @integrationsSupabaseAnonKey.
  ///
  /// In en, this message translates to:
  /// **'Anon (public) key'**
  String get integrationsSupabaseAnonKey;

  /// No description provided for @integrationsSupabaseAnonKeyHint.
  ///
  /// In en, this message translates to:
  /// **'eyJhbGciOiJIUzI1NiIsInR5cCI6...'**
  String get integrationsSupabaseAnonKeyHint;

  /// No description provided for @integrationsSupabaseServiceRoleKey.
  ///
  /// In en, this message translates to:
  /// **'Service role key (server only)'**
  String get integrationsSupabaseServiceRoleKey;

  /// No description provided for @integrationsSupabaseServiceRoleKeyHint.
  ///
  /// In en, this message translates to:
  /// **'For Edge Functions / backend deploy'**
  String get integrationsSupabaseServiceRoleKeyHint;

  /// No description provided for @integrationsSupabaseProjectRef.
  ///
  /// In en, this message translates to:
  /// **'Project reference ID'**
  String get integrationsSupabaseProjectRef;

  /// No description provided for @integrationsSupabaseProjectRefHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. abcdefghijklmnop'**
  String get integrationsSupabaseProjectRefHint;

  /// No description provided for @integrationsSmsTitle.
  ///
  /// In en, this message translates to:
  /// **'SMS provider'**
  String get integrationsSmsTitle;

  /// No description provided for @integrationsSmsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'OTP codes and plate return SMS (Unifonic, Twilio, etc.).'**
  String get integrationsSmsSubtitle;

  /// No description provided for @integrationsSmsProvider.
  ///
  /// In en, this message translates to:
  /// **'Provider name'**
  String get integrationsSmsProvider;

  /// No description provided for @integrationsSmsProviderHint.
  ///
  /// In en, this message translates to:
  /// **'Unifonic / Twilio / custom'**
  String get integrationsSmsProviderHint;

  /// No description provided for @integrationsSmsApiKey.
  ///
  /// In en, this message translates to:
  /// **'API key'**
  String get integrationsSmsApiKey;

  /// No description provided for @integrationsSmsApiKeyHint.
  ///
  /// In en, this message translates to:
  /// **'Provider API key or token'**
  String get integrationsSmsApiKeyHint;

  /// No description provided for @integrationsSmsSenderId.
  ///
  /// In en, this message translates to:
  /// **'Sender ID / from number'**
  String get integrationsSmsSenderId;

  /// No description provided for @integrationsSmsSenderIdHint.
  ///
  /// In en, this message translates to:
  /// **'Ayletna or +962...'**
  String get integrationsSmsSenderIdHint;

  /// No description provided for @integrationsSmsApiUrl.
  ///
  /// In en, this message translates to:
  /// **'API base URL (optional)'**
  String get integrationsSmsApiUrl;

  /// No description provided for @integrationsSmsApiUrlHint.
  ///
  /// In en, this message translates to:
  /// **'https://api.unifonic.com/...'**
  String get integrationsSmsApiUrlHint;

  /// No description provided for @integrationsWhatsappTitle.
  ///
  /// In en, this message translates to:
  /// **'WhatsApp Business'**
  String get integrationsWhatsappTitle;

  /// No description provided for @integrationsWhatsappSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Friendly return reminders and customer updates.'**
  String get integrationsWhatsappSubtitle;

  /// No description provided for @integrationsWhatsappBusinessAccountId.
  ///
  /// In en, this message translates to:
  /// **'Business account ID'**
  String get integrationsWhatsappBusinessAccountId;

  /// No description provided for @integrationsWhatsappBusinessAccountIdHint.
  ///
  /// In en, this message translates to:
  /// **'Meta Business account ID'**
  String get integrationsWhatsappBusinessAccountIdHint;

  /// No description provided for @integrationsWhatsappPhoneNumberId.
  ///
  /// In en, this message translates to:
  /// **'Phone number ID'**
  String get integrationsWhatsappPhoneNumberId;

  /// No description provided for @integrationsWhatsappPhoneNumberIdHint.
  ///
  /// In en, this message translates to:
  /// **'WhatsApp Cloud API phone number ID'**
  String get integrationsWhatsappPhoneNumberIdHint;

  /// No description provided for @integrationsWhatsappAccessToken.
  ///
  /// In en, this message translates to:
  /// **'Permanent access token'**
  String get integrationsWhatsappAccessToken;

  /// No description provided for @integrationsWhatsappAccessTokenHint.
  ///
  /// In en, this message translates to:
  /// **'System user token from Meta'**
  String get integrationsWhatsappAccessTokenHint;

  /// No description provided for @integrationsWhatsappWebhookVerifyToken.
  ///
  /// In en, this message translates to:
  /// **'Webhook verify token'**
  String get integrationsWhatsappWebhookVerifyToken;

  /// No description provided for @integrationsWhatsappWebhookVerifyTokenHint.
  ///
  /// In en, this message translates to:
  /// **'Random string for webhook verification'**
  String get integrationsWhatsappWebhookVerifyTokenHint;

  /// No description provided for @integrationsTelephonyTitle.
  ///
  /// In en, this message translates to:
  /// **'Phone & OTP'**
  String get integrationsTelephonyTitle;

  /// No description provided for @integrationsTelephonySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Support line, country code, and OTP sender number.'**
  String get integrationsTelephonySubtitle;

  /// No description provided for @integrationsSupportPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Support phone number'**
  String get integrationsSupportPhoneNumber;

  /// No description provided for @integrationsSupportPhoneNumberHint.
  ///
  /// In en, this message translates to:
  /// **'+962 7 0000 0000'**
  String get integrationsSupportPhoneNumberHint;

  /// No description provided for @integrationsDefaultCountryCode.
  ///
  /// In en, this message translates to:
  /// **'Default country code'**
  String get integrationsDefaultCountryCode;

  /// No description provided for @integrationsDefaultCountryCodeHint.
  ///
  /// In en, this message translates to:
  /// **'+962'**
  String get integrationsDefaultCountryCodeHint;

  /// No description provided for @integrationsOtpSenderNumber.
  ///
  /// In en, this message translates to:
  /// **'OTP sender number'**
  String get integrationsOtpSenderNumber;

  /// No description provided for @integrationsOtpSenderNumberHint.
  ///
  /// In en, this message translates to:
  /// **'Registered sender for verification SMS'**
  String get integrationsOtpSenderNumberHint;

  /// No description provided for @integrationsPaymentsTitle.
  ///
  /// In en, this message translates to:
  /// **'Payment gateways'**
  String get integrationsPaymentsTitle;

  /// No description provided for @integrationsPaymentsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Stripe, Google Pay, Apple Pay, regional gateways, and licensed wallet.'**
  String get integrationsPaymentsSubtitle;

  /// No description provided for @integrationsPaymentGatewayProvider.
  ///
  /// In en, this message translates to:
  /// **'Primary gateway'**
  String get integrationsPaymentGatewayProvider;

  /// No description provided for @integrationsPaymentGatewayProviderHint.
  ///
  /// In en, this message translates to:
  /// **'Stripe / MyFatoorah / HyperPay / Checkout.com'**
  String get integrationsPaymentGatewayProviderHint;

  /// No description provided for @integrationsStripePublishableKey.
  ///
  /// In en, this message translates to:
  /// **'Stripe publishable key'**
  String get integrationsStripePublishableKey;

  /// No description provided for @integrationsStripePublishableKeyHint.
  ///
  /// In en, this message translates to:
  /// **'pk_live_... or pk_test_...'**
  String get integrationsStripePublishableKeyHint;

  /// No description provided for @integrationsStripeSecretKey.
  ///
  /// In en, this message translates to:
  /// **'Stripe secret key'**
  String get integrationsStripeSecretKey;

  /// No description provided for @integrationsStripeSecretKeyHint.
  ///
  /// In en, this message translates to:
  /// **'sk_live_... (server-side)'**
  String get integrationsStripeSecretKeyHint;

  /// No description provided for @integrationsStripeWebhookSecret.
  ///
  /// In en, this message translates to:
  /// **'Stripe webhook secret'**
  String get integrationsStripeWebhookSecret;

  /// No description provided for @integrationsStripeWebhookSecretHint.
  ///
  /// In en, this message translates to:
  /// **'whsec_...'**
  String get integrationsStripeWebhookSecretHint;

  /// No description provided for @integrationsGooglePayMerchantId.
  ///
  /// In en, this message translates to:
  /// **'Google Pay merchant ID'**
  String get integrationsGooglePayMerchantId;

  /// No description provided for @integrationsGooglePayMerchantIdHint.
  ///
  /// In en, this message translates to:
  /// **'Google Pay merchant identifier'**
  String get integrationsGooglePayMerchantIdHint;

  /// No description provided for @integrationsGooglePayMerchantName.
  ///
  /// In en, this message translates to:
  /// **'Google Pay merchant name'**
  String get integrationsGooglePayMerchantName;

  /// No description provided for @integrationsGooglePayMerchantNameHint.
  ///
  /// In en, this message translates to:
  /// **'Ayletna Restaurant'**
  String get integrationsGooglePayMerchantNameHint;

  /// No description provided for @integrationsApplePayMerchantId.
  ///
  /// In en, this message translates to:
  /// **'Apple Pay merchant ID'**
  String get integrationsApplePayMerchantId;

  /// No description provided for @integrationsApplePayMerchantIdHint.
  ///
  /// In en, this message translates to:
  /// **'merchant.com.ayletna.restaurant'**
  String get integrationsApplePayMerchantIdHint;

  /// No description provided for @integrationsPaymentGatewayApiKey.
  ///
  /// In en, this message translates to:
  /// **'Regional gateway API key'**
  String get integrationsPaymentGatewayApiKey;

  /// No description provided for @integrationsPaymentGatewayApiKeyHint.
  ///
  /// In en, this message translates to:
  /// **'MyFatoorah / HyperPay API key'**
  String get integrationsPaymentGatewayApiKeyHint;

  /// No description provided for @integrationsPaymentGatewayMerchantId.
  ///
  /// In en, this message translates to:
  /// **'Regional merchant ID'**
  String get integrationsPaymentGatewayMerchantId;

  /// No description provided for @integrationsPaymentGatewayMerchantIdHint.
  ///
  /// In en, this message translates to:
  /// **'Merchant or terminal ID'**
  String get integrationsPaymentGatewayMerchantIdHint;

  /// No description provided for @integrationsPaymentGatewayWebhookUrl.
  ///
  /// In en, this message translates to:
  /// **'Payment webhook URL'**
  String get integrationsPaymentGatewayWebhookUrl;

  /// No description provided for @integrationsPaymentGatewayWebhookUrlHint.
  ///
  /// In en, this message translates to:
  /// **'https://your-project.supabase.co/functions/v1/payment-webhook'**
  String get integrationsPaymentGatewayWebhookUrlHint;

  /// No description provided for @integrationsWalletSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'Licensed wallet (Jordan)'**
  String get integrationsWalletSectionTitle;

  /// No description provided for @integrationsWalletProviderName.
  ///
  /// In en, this message translates to:
  /// **'Wallet provider name'**
  String get integrationsWalletProviderName;

  /// No description provided for @integrationsWalletProviderNameHint.
  ///
  /// In en, this message translates to:
  /// **'Licensed wallet partner'**
  String get integrationsWalletProviderNameHint;

  /// No description provided for @integrationsWalletAppId.
  ///
  /// In en, this message translates to:
  /// **'Wallet app ID'**
  String get integrationsWalletAppId;

  /// No description provided for @integrationsWalletAppIdHint.
  ///
  /// In en, this message translates to:
  /// **'Merchant / app identifier'**
  String get integrationsWalletAppIdHint;

  /// No description provided for @integrationsWalletDeepLinkScheme.
  ///
  /// In en, this message translates to:
  /// **'Deep link scheme'**
  String get integrationsWalletDeepLinkScheme;

  /// No description provided for @integrationsWalletDeepLinkSchemeHint.
  ///
  /// In en, this message translates to:
  /// **'ayletna://payment/callback'**
  String get integrationsWalletDeepLinkSchemeHint;

  /// No description provided for @integrationsWalletWebhookSecret.
  ///
  /// In en, this message translates to:
  /// **'Wallet webhook secret'**
  String get integrationsWalletWebhookSecret;

  /// No description provided for @integrationsWalletWebhookSecretHint.
  ///
  /// In en, this message translates to:
  /// **'Shared secret for wallet callbacks'**
  String get integrationsWalletWebhookSecretHint;

  /// No description provided for @integrationsAiTitle.
  ///
  /// In en, this message translates to:
  /// **'AI agent'**
  String get integrationsAiTitle;

  /// No description provided for @integrationsAiSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Support chat and operator assistants (ChatGPT, Qwen, etc.).'**
  String get integrationsAiSubtitle;

  /// No description provided for @integrationsAiProvider.
  ///
  /// In en, this message translates to:
  /// **'AI provider'**
  String get integrationsAiProvider;

  /// No description provided for @integrationsAiProviderHint.
  ///
  /// In en, this message translates to:
  /// **'OpenAI / Qwen / Anthropic / custom'**
  String get integrationsAiProviderHint;

  /// No description provided for @integrationsAiApiKey.
  ///
  /// In en, this message translates to:
  /// **'API key'**
  String get integrationsAiApiKey;

  /// No description provided for @integrationsAiApiKeyHint.
  ///
  /// In en, this message translates to:
  /// **'Provider API key'**
  String get integrationsAiApiKeyHint;

  /// No description provided for @integrationsAiModelName.
  ///
  /// In en, this message translates to:
  /// **'Model name'**
  String get integrationsAiModelName;

  /// No description provided for @integrationsAiModelNameHint.
  ///
  /// In en, this message translates to:
  /// **'gpt-4o / qwen-max / claude-3-5-sonnet'**
  String get integrationsAiModelNameHint;

  /// No description provided for @integrationsAiBaseUrl.
  ///
  /// In en, this message translates to:
  /// **'API base URL (optional)'**
  String get integrationsAiBaseUrl;

  /// No description provided for @integrationsAiBaseUrlHint.
  ///
  /// In en, this message translates to:
  /// **'https://api.openai.com/v1'**
  String get integrationsAiBaseUrlHint;

  /// No description provided for @integrationsAiSupportChatEnabled.
  ///
  /// In en, this message translates to:
  /// **'Enable AI support chat'**
  String get integrationsAiSupportChatEnabled;

  /// No description provided for @integrationsAiSupportChatEnabledHint.
  ///
  /// In en, this message translates to:
  /// **'Route customer support chat through the configured agent'**
  String get integrationsAiSupportChatEnabledHint;

  /// No description provided for @integrationsOtherTitle.
  ///
  /// In en, this message translates to:
  /// **'Other services'**
  String get integrationsOtherTitle;

  /// No description provided for @integrationsOtherSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Maps, push notifications, email, and monitoring.'**
  String get integrationsOtherSubtitle;

  /// No description provided for @integrationsGoogleMapsApiKey.
  ///
  /// In en, this message translates to:
  /// **'Google Maps API key'**
  String get integrationsGoogleMapsApiKey;

  /// No description provided for @integrationsGoogleMapsApiKeyHint.
  ///
  /// In en, this message translates to:
  /// **'Restricted by bundle / referrer'**
  String get integrationsGoogleMapsApiKeyHint;

  /// No description provided for @integrationsFcmServerKey.
  ///
  /// In en, this message translates to:
  /// **'FCM server key'**
  String get integrationsFcmServerKey;

  /// No description provided for @integrationsFcmServerKeyHint.
  ///
  /// In en, this message translates to:
  /// **'Firebase Cloud Messaging server key'**
  String get integrationsFcmServerKeyHint;

  /// No description provided for @integrationsEmailProvider.
  ///
  /// In en, this message translates to:
  /// **'Email provider'**
  String get integrationsEmailProvider;

  /// No description provided for @integrationsEmailProviderHint.
  ///
  /// In en, this message translates to:
  /// **'SendGrid / Amazon SES'**
  String get integrationsEmailProviderHint;

  /// No description provided for @integrationsEmailApiKey.
  ///
  /// In en, this message translates to:
  /// **'Email API key'**
  String get integrationsEmailApiKey;

  /// No description provided for @integrationsEmailApiKeyHint.
  ///
  /// In en, this message translates to:
  /// **'SendGrid or SES credentials'**
  String get integrationsEmailApiKeyHint;

  /// No description provided for @integrationsEmailFromAddress.
  ///
  /// In en, this message translates to:
  /// **'From email address'**
  String get integrationsEmailFromAddress;

  /// No description provided for @integrationsEmailFromAddressHint.
  ///
  /// In en, this message translates to:
  /// **'noreply@ayletna.com'**
  String get integrationsEmailFromAddressHint;

  /// No description provided for @integrationsSentryDsn.
  ///
  /// In en, this message translates to:
  /// **'Sentry DSN (optional)'**
  String get integrationsSentryDsn;

  /// No description provided for @integrationsSentryDsnHint.
  ///
  /// In en, this message translates to:
  /// **'https://...@sentry.io/...'**
  String get integrationsSentryDsnHint;

  /// No description provided for @integrationsAttendanceWifiTitle.
  ///
  /// In en, this message translates to:
  /// **'Restaurant WiFi (attendance)'**
  String get integrationsAttendanceWifiTitle;

  /// No description provided for @integrationsAttendanceWifiSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Staff check-in/out only works on this router WiFi — not mobile data or outside networks.'**
  String get integrationsAttendanceWifiSubtitle;

  /// No description provided for @integrationsRestaurantWifiSsid.
  ///
  /// In en, this message translates to:
  /// **'WiFi network name (SSID)'**
  String get integrationsRestaurantWifiSsid;

  /// No description provided for @integrationsRestaurantWifiSsidHint.
  ///
  /// In en, this message translates to:
  /// **'Ayletna-Staff'**
  String get integrationsRestaurantWifiSsidHint;

  /// No description provided for @integrationsRestaurantWifiBssid.
  ///
  /// In en, this message translates to:
  /// **'Router BSSID (MAC address)'**
  String get integrationsRestaurantWifiBssid;

  /// No description provided for @integrationsRestaurantWifiBssidHint.
  ///
  /// In en, this message translates to:
  /// **'aa:bb:cc:dd:ee:ff'**
  String get integrationsRestaurantWifiBssidHint;

  /// No description provided for @integrationsRestaurantWifiGatewayIp.
  ///
  /// In en, this message translates to:
  /// **'Gateway IP (optional)'**
  String get integrationsRestaurantWifiGatewayIp;

  /// No description provided for @integrationsRestaurantWifiGatewayIpHint.
  ///
  /// In en, this message translates to:
  /// **'192.168.1.1'**
  String get integrationsRestaurantWifiGatewayIpHint;

  /// No description provided for @integrationsRestaurantBranchLabel.
  ///
  /// In en, this message translates to:
  /// **'Branch label'**
  String get integrationsRestaurantBranchLabel;

  /// No description provided for @integrationsRestaurantBranchLabelHint.
  ///
  /// In en, this message translates to:
  /// **'Main kitchen — Amman'**
  String get integrationsRestaurantBranchLabelHint;

  /// No description provided for @attendanceGateTitle.
  ///
  /// In en, this message translates to:
  /// **'Record attendance'**
  String get attendanceGateTitle;

  /// No description provided for @attendanceModeComing.
  ///
  /// In en, this message translates to:
  /// **'Coming'**
  String get attendanceModeComing;

  /// No description provided for @attendanceModeLeaving.
  ///
  /// In en, this message translates to:
  /// **'Leaving'**
  String get attendanceModeLeaving;

  /// No description provided for @attendanceWifiChecking.
  ///
  /// In en, this message translates to:
  /// **'Checking restaurant WiFi…'**
  String get attendanceWifiChecking;

  /// No description provided for @attendanceWifiCheckFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not read WiFi status. Try again.'**
  String get attendanceWifiCheckFailed;

  /// No description provided for @attendanceWifiNotConfigured.
  ///
  /// In en, this message translates to:
  /// **'Admin has not registered restaurant WiFi yet. Ask the operator to configure it in App Integrations.'**
  String get attendanceWifiNotConfigured;

  /// No description provided for @attendanceWifiRequired.
  ///
  /// In en, this message translates to:
  /// **'Connect to the restaurant WiFi to record attendance. Mobile data and outside networks are blocked.'**
  String get attendanceWifiRequired;

  /// No description provided for @attendanceWifiConnected.
  ///
  /// In en, this message translates to:
  /// **'Connected to restaurant WiFi: {ssid}'**
  String attendanceWifiConnected(String ssid);

  /// No description provided for @attendanceWifiDemoMatched.
  ///
  /// In en, this message translates to:
  /// **'Connected to restaurant WiFi ({ssid})'**
  String attendanceWifiDemoMatched(String ssid);

  /// No description provided for @attendanceWifiWebDemoNote.
  ///
  /// In en, this message translates to:
  /// **'Attendance check-in uses the restaurant WiFi network.'**
  String get attendanceWifiWebDemoNote;

  /// No description provided for @attendanceWifiWrongNetwork.
  ///
  /// In en, this message translates to:
  /// **'Wrong network ({current}). Required: {expected}'**
  String attendanceWifiWrongNetwork(String current, String expected);

  /// No description provided for @attendanceWifiUnknown.
  ///
  /// In en, this message translates to:
  /// **'Not on WiFi'**
  String get attendanceWifiUnknown;

  /// No description provided for @attendanceWifiRefresh.
  ///
  /// In en, this message translates to:
  /// **'Refresh WiFi check'**
  String get attendanceWifiRefresh;

  /// No description provided for @attendanceLastRecordedWifi.
  ///
  /// In en, this message translates to:
  /// **'Last recorded on WiFi: {ssid}'**
  String attendanceLastRecordedWifi(String ssid);

  /// No description provided for @attendanceFingerprintComingHint.
  ///
  /// In en, this message translates to:
  /// **'Tap fingerprint to confirm arrival time'**
  String get attendanceFingerprintComingHint;

  /// No description provided for @attendanceFingerprintLeavingHint.
  ///
  /// In en, this message translates to:
  /// **'Tap fingerprint to confirm leaving time'**
  String get attendanceFingerprintLeavingHint;

  /// No description provided for @attendanceBiometricTitle.
  ///
  /// In en, this message translates to:
  /// **'Fingerprint approval'**
  String get attendanceBiometricTitle;

  /// No description provided for @attendanceBiometricConfirm.
  ///
  /// In en, this message translates to:
  /// **'Approve with fingerprint'**
  String get attendanceBiometricConfirm;

  /// No description provided for @attendanceBiometricCheckInReason.
  ///
  /// In en, this message translates to:
  /// **'Confirm your arrival at the restaurant'**
  String get attendanceBiometricCheckInReason;

  /// No description provided for @attendanceBiometricCheckOutReason.
  ///
  /// In en, this message translates to:
  /// **'Confirm you are leaving the restaurant'**
  String get attendanceBiometricCheckOutReason;

  /// No description provided for @attendanceBiometricUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Biometric authentication is not available on this device.'**
  String get attendanceBiometricUnavailable;

  /// No description provided for @attendanceBiometricFailed.
  ///
  /// In en, this message translates to:
  /// **'Fingerprint verification failed. Try again.'**
  String get attendanceBiometricFailed;

  /// No description provided for @screenAuditLog.
  ///
  /// In en, this message translates to:
  /// **'Audit log'**
  String get screenAuditLog;

  /// No description provided for @screenStaffHoursReport.
  ///
  /// In en, this message translates to:
  /// **'Staff hours'**
  String get screenStaffHoursReport;

  /// No description provided for @screenLanguageSelectionDesc.
  ///
  /// In en, this message translates to:
  /// **'Language screen.'**
  String get screenLanguageSelectionDesc;

  /// No description provided for @screenLoginDesc.
  ///
  /// In en, this message translates to:
  /// **'Sign in screen.'**
  String get screenLoginDesc;

  /// No description provided for @screenOtpVerificationDesc.
  ///
  /// In en, this message translates to:
  /// **'Verification screen.'**
  String get screenOtpVerificationDesc;

  /// No description provided for @screenRegisterDesc.
  ///
  /// In en, this message translates to:
  /// **'Register screen.'**
  String get screenRegisterDesc;

  /// No description provided for @screenForgotPasswordDesc.
  ///
  /// In en, this message translates to:
  /// **'Reset password screen.'**
  String get screenForgotPasswordDesc;

  /// No description provided for @screenRoleSelectionDesc.
  ///
  /// In en, this message translates to:
  /// **'Choose role screen.'**
  String get screenRoleSelectionDesc;

  /// No description provided for @screenGuestBrowseDesc.
  ///
  /// In en, this message translates to:
  /// **'Menu (guest) screen.'**
  String get screenGuestBrowseDesc;

  /// No description provided for @screenHomeDesc.
  ///
  /// In en, this message translates to:
  /// **'Home screen.'**
  String get screenHomeDesc;

  /// No description provided for @screenCategoryDesc.
  ///
  /// In en, this message translates to:
  /// **'Category screen.'**
  String get screenCategoryDesc;

  /// No description provided for @screenProductDetailDesc.
  ///
  /// In en, this message translates to:
  /// **'Product screen.'**
  String get screenProductDetailDesc;

  /// No description provided for @screenCartDesc.
  ///
  /// In en, this message translates to:
  /// **'Cart screen.'**
  String get screenCartDesc;

  /// No description provided for @screenOrderTypeSelectionDesc.
  ///
  /// In en, this message translates to:
  /// **'Order type screen.'**
  String get screenOrderTypeSelectionDesc;

  /// No description provided for @screenDineInTableDesc.
  ///
  /// In en, this message translates to:
  /// **'Table number screen.'**
  String get screenDineInTableDesc;

  /// No description provided for @screenTakeawayPickupDesc.
  ///
  /// In en, this message translates to:
  /// **'Pickup screen.'**
  String get screenTakeawayPickupDesc;

  /// No description provided for @screenDeliveryAddressDesc.
  ///
  /// In en, this message translates to:
  /// **'Delivery address screen.'**
  String get screenDeliveryAddressDesc;

  /// No description provided for @screenPlatedDeliveryInfoDesc.
  ///
  /// In en, this message translates to:
  /// **'Plated delivery screen.'**
  String get screenPlatedDeliveryInfoDesc;

  /// No description provided for @screenCheckoutDesc.
  ///
  /// In en, this message translates to:
  /// **'Checkout screen.'**
  String get screenCheckoutDesc;

  /// No description provided for @screenTipSelectionDesc.
  ///
  /// In en, this message translates to:
  /// **'Tip screen.'**
  String get screenTipSelectionDesc;

  /// No description provided for @screenPaymentDesc.
  ///
  /// In en, this message translates to:
  /// **'Payment screen.'**
  String get screenPaymentDesc;

  /// No description provided for @screenOrderConfirmationDesc.
  ///
  /// In en, this message translates to:
  /// **'Order confirmed screen.'**
  String get screenOrderConfirmationDesc;

  /// No description provided for @screenOrderTrackingDesc.
  ///
  /// In en, this message translates to:
  /// **'Track order screen.'**
  String get screenOrderTrackingDesc;

  /// No description provided for @screenOrderHistoryDesc.
  ///
  /// In en, this message translates to:
  /// **'Order history screen.'**
  String get screenOrderHistoryDesc;

  /// No description provided for @screenWalletDesc.
  ///
  /// In en, this message translates to:
  /// **'Wallet screen.'**
  String get screenWalletDesc;

  /// No description provided for @screenLoyaltyDesc.
  ///
  /// In en, this message translates to:
  /// **'Loyalty screen.'**
  String get screenLoyaltyDesc;

  /// No description provided for @screenRewardsCatalogDesc.
  ///
  /// In en, this message translates to:
  /// **'Rewards screen.'**
  String get screenRewardsCatalogDesc;

  /// No description provided for @screenRedemptionConfirmDesc.
  ///
  /// In en, this message translates to:
  /// **'Confirm redemption screen.'**
  String get screenRedemptionConfirmDesc;

  /// No description provided for @screenProfileDesc.
  ///
  /// In en, this message translates to:
  /// **'Profile screen.'**
  String get screenProfileDesc;

  /// No description provided for @screenAddressesDesc.
  ///
  /// In en, this message translates to:
  /// **'Addresses screen.'**
  String get screenAddressesDesc;

  /// No description provided for @screenMapPickerDesc.
  ///
  /// In en, this message translates to:
  /// **'Map screen.'**
  String get screenMapPickerDesc;

  /// No description provided for @screenNotificationsDesc.
  ///
  /// In en, this message translates to:
  /// **'Notifications screen.'**
  String get screenNotificationsDesc;

  /// No description provided for @screenPlatedReturnReminderDesc.
  ///
  /// In en, this message translates to:
  /// **'Return tray screen.'**
  String get screenPlatedReturnReminderDesc;

  /// No description provided for @screenOffersDesc.
  ///
  /// In en, this message translates to:
  /// **'Offers screen.'**
  String get screenOffersDesc;

  /// No description provided for @screenCouponApplyDesc.
  ///
  /// In en, this message translates to:
  /// **'Coupon screen.'**
  String get screenCouponApplyDesc;

  /// No description provided for @screenComboBuilderDesc.
  ///
  /// In en, this message translates to:
  /// **'Combo builder screen.'**
  String get screenComboBuilderDesc;

  /// No description provided for @screenKitchenDashboardDesc.
  ///
  /// In en, this message translates to:
  /// **'Kitchen screen.'**
  String get screenKitchenDashboardDesc;

  /// No description provided for @screenOrderPrepDesc.
  ///
  /// In en, this message translates to:
  /// **'Order prep screen.'**
  String get screenOrderPrepDesc;

  /// No description provided for @screenInventoryDashboardDesc.
  ///
  /// In en, this message translates to:
  /// **'Inventory screen.'**
  String get screenInventoryDashboardDesc;

  /// No description provided for @screenInventoryItemDesc.
  ///
  /// In en, this message translates to:
  /// **'Item details screen.'**
  String get screenInventoryItemDesc;

  /// No description provided for @screenStockAdjustmentDesc.
  ///
  /// In en, this message translates to:
  /// **'Stock adjustment screen.'**
  String get screenStockAdjustmentDesc;

  /// No description provided for @screenDeliveryDashboardDesc.
  ///
  /// In en, this message translates to:
  /// **'Delivery screen.'**
  String get screenDeliveryDashboardDesc;

  /// No description provided for @screenDeliveryOrderDesc.
  ///
  /// In en, this message translates to:
  /// **'Delivery order screen.'**
  String get screenDeliveryOrderDesc;

  /// No description provided for @screenPlatedReturnTaskDesc.
  ///
  /// In en, this message translates to:
  /// **'Return tasks screen.'**
  String get screenPlatedReturnTaskDesc;

  /// No description provided for @screenPlatedReturnProcessDesc.
  ///
  /// In en, this message translates to:
  /// **'Return process screen.'**
  String get screenPlatedReturnProcessDesc;

  /// No description provided for @screenCashierOrderDesc.
  ///
  /// In en, this message translates to:
  /// **'Cashier POS screen.'**
  String get screenCashierOrderDesc;

  /// No description provided for @screenCashierTipEntryDesc.
  ///
  /// In en, this message translates to:
  /// **'Cash tip screen.'**
  String get screenCashierTipEntryDesc;

  /// No description provided for @screenCashierDepositRefundDesc.
  ///
  /// In en, this message translates to:
  /// **'Deposit refund screen.'**
  String get screenCashierDepositRefundDesc;

  /// No description provided for @screenStaffAttendanceDesc.
  ///
  /// In en, this message translates to:
  /// **'Attendance screen.'**
  String get screenStaffAttendanceDesc;

  /// No description provided for @screenStaffDailyTipsDesc.
  ///
  /// In en, this message translates to:
  /// **'Daily tips screen.'**
  String get screenStaffDailyTipsDesc;

  /// No description provided for @screenStaffTipHistoryDesc.
  ///
  /// In en, this message translates to:
  /// **'Tip history screen.'**
  String get screenStaffTipHistoryDesc;

  /// No description provided for @screenAdminDashboardDesc.
  ///
  /// In en, this message translates to:
  /// **'Admin screen.'**
  String get screenAdminDashboardDesc;

  /// No description provided for @screenOrdersManagementDesc.
  ///
  /// In en, this message translates to:
  /// **'Orders screen.'**
  String get screenOrdersManagementDesc;

  /// No description provided for @screenOrderDetailAdminDesc.
  ///
  /// In en, this message translates to:
  /// **'Order detail screen.'**
  String get screenOrderDetailAdminDesc;

  /// No description provided for @screenReportsDesc.
  ///
  /// In en, this message translates to:
  /// **'Reports screen.'**
  String get screenReportsDesc;

  /// No description provided for @screenReportFilterDesc.
  ///
  /// In en, this message translates to:
  /// **'Report filters screen.'**
  String get screenReportFilterDesc;

  /// No description provided for @screenFinancialCalculationDesc.
  ///
  /// In en, this message translates to:
  /// **'Financial calculation screen.'**
  String get screenFinancialCalculationDesc;

  /// No description provided for @screenDailyTipDistributionDesc.
  ///
  /// In en, this message translates to:
  /// **'Tip distribution screen.'**
  String get screenDailyTipDistributionDesc;

  /// No description provided for @screenPlatesManagementDesc.
  ///
  /// In en, this message translates to:
  /// **'Plates screen.'**
  String get screenPlatesManagementDesc;

  /// No description provided for @screenPlateEditorDesc.
  ///
  /// In en, this message translates to:
  /// **'Edit plate screen.'**
  String get screenPlateEditorDesc;

  /// No description provided for @screenDepositConfigDesc.
  ///
  /// In en, this message translates to:
  /// **'Deposit config screen.'**
  String get screenDepositConfigDesc;

  /// No description provided for @screenUserManagementDesc.
  ///
  /// In en, this message translates to:
  /// **'Users screen.'**
  String get screenUserManagementDesc;

  /// No description provided for @screenMenuManagementDesc.
  ///
  /// In en, this message translates to:
  /// **'Menu screen.'**
  String get screenMenuManagementDesc;

  /// No description provided for @screenProductEditorDesc.
  ///
  /// In en, this message translates to:
  /// **'Edit product screen.'**
  String get screenProductEditorDesc;

  /// No description provided for @screenOffersManagementDesc.
  ///
  /// In en, this message translates to:
  /// **'Offers management screen.'**
  String get screenOffersManagementDesc;

  /// No description provided for @screenLoyaltyConfigDesc.
  ///
  /// In en, this message translates to:
  /// **'Loyalty config screen.'**
  String get screenLoyaltyConfigDesc;

  /// No description provided for @screenOwnerViewConfigDesc.
  ///
  /// In en, this message translates to:
  /// **'Owner privacy screen.'**
  String get screenOwnerViewConfigDesc;

  /// No description provided for @screenPreOrderDesc.
  ///
  /// In en, this message translates to:
  /// **'Pre-orders screen.'**
  String get screenPreOrderDesc;

  /// No description provided for @screenSettingsDesc.
  ///
  /// In en, this message translates to:
  /// **'Settings screen.'**
  String get screenSettingsDesc;

  /// No description provided for @screenAuditLogDesc.
  ///
  /// In en, this message translates to:
  /// **'Audit log screen.'**
  String get screenAuditLogDesc;

  /// No description provided for @screenStaffHoursReportDesc.
  ///
  /// In en, this message translates to:
  /// **'Staff hours screen.'**
  String get screenStaffHoursReportDesc;

  /// No description provided for @otpVerificationSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Enter the 6-digit code we sent to your phone.'**
  String get otpVerificationSubtitle;

  /// No description provided for @screenPaymentSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Choose how you want to pay for this order.'**
  String get screenPaymentSubtitle;

  /// No description provided for @paymentMethodCash.
  ///
  /// In en, this message translates to:
  /// **'Cash'**
  String get paymentMethodCash;

  /// No description provided for @paymentMethodCard.
  ///
  /// In en, this message translates to:
  /// **'Card / Visa'**
  String get paymentMethodCard;

  /// No description provided for @paymentMethodWallet.
  ///
  /// In en, this message translates to:
  /// **'Wallet'**
  String get paymentMethodWallet;

  /// No description provided for @paymentErrorDemo.
  ///
  /// In en, this message translates to:
  /// **'Payment declined. Please try another method.'**
  String get paymentErrorDemo;

  /// No description provided for @cashierCurrentOrder.
  ///
  /// In en, this message translates to:
  /// **'Current Order'**
  String get cashierCurrentOrder;

  /// No description provided for @cashierWalkIn.
  ///
  /// In en, this message translates to:
  /// **'Walk-in'**
  String get cashierWalkIn;

  /// No description provided for @cashierOrderEmpty.
  ///
  /// In en, this message translates to:
  /// **'Order is empty'**
  String get cashierOrderEmpty;

  /// No description provided for @cashierSubtotal.
  ///
  /// In en, this message translates to:
  /// **'Subtotal'**
  String get cashierSubtotal;

  /// No description provided for @cashierTax.
  ///
  /// In en, this message translates to:
  /// **'Tax (16%)'**
  String get cashierTax;

  /// No description provided for @cashierTotal.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get cashierTotal;

  /// No description provided for @cashierVoidOrder.
  ///
  /// In en, this message translates to:
  /// **'Void Order'**
  String get cashierVoidOrder;

  /// No description provided for @cashierSaveDraft.
  ///
  /// In en, this message translates to:
  /// **'Save Draft'**
  String get cashierSaveDraft;

  /// No description provided for @cashierProcessPayment.
  ///
  /// In en, this message translates to:
  /// **'Process Payment'**
  String get cashierProcessPayment;

  /// No description provided for @cashierFind.
  ///
  /// In en, this message translates to:
  /// **'Find'**
  String get cashierFind;

  /// No description provided for @cashierShiftTotalRevenue.
  ///
  /// In en, this message translates to:
  /// **'Shift total revenue'**
  String get cashierShiftTotalRevenue;

  /// No description provided for @cashierOrdersCount.
  ///
  /// In en, this message translates to:
  /// **'Orders count'**
  String get cashierOrdersCount;

  /// No description provided for @cashierAverageOrder.
  ///
  /// In en, this message translates to:
  /// **'Average: {amount} JOD/order'**
  String cashierAverageOrder(String amount);

  /// No description provided for @cashierSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search order # or amount...'**
  String get cashierSearchHint;

  /// No description provided for @cashierAllOrders.
  ///
  /// In en, this message translates to:
  /// **'All Orders'**
  String get cashierAllOrders;

  /// No description provided for @cashierRecentTransactions.
  ///
  /// In en, this message translates to:
  /// **'Recent Transactions'**
  String get cashierRecentTransactions;

  /// No description provided for @cashierPaid.
  ///
  /// In en, this message translates to:
  /// **'Paid'**
  String get cashierPaid;

  /// No description provided for @cashierRefunded.
  ///
  /// In en, this message translates to:
  /// **'Refunded'**
  String get cashierRefunded;

  /// No description provided for @cashierLoadOlder.
  ///
  /// In en, this message translates to:
  /// **'Load Older Transactions'**
  String get cashierLoadOlder;

  /// No description provided for @cashierShiftDelta.
  ///
  /// In en, this message translates to:
  /// **'+12% vs last shift'**
  String get cashierShiftDelta;

  /// No description provided for @cashierCurrentShiftTips.
  ///
  /// In en, this message translates to:
  /// **'Current Shift Tips'**
  String get cashierCurrentShiftTips;

  /// No description provided for @cashierEnterAmount.
  ///
  /// In en, this message translates to:
  /// **'Enter Amount'**
  String get cashierEnterAmount;

  /// No description provided for @cashierAssignTipTo.
  ///
  /// In en, this message translates to:
  /// **'Assign Tip To'**
  String get cashierAssignTipTo;

  /// No description provided for @cashierSharedPool.
  ///
  /// In en, this message translates to:
  /// **'Shared Pool'**
  String get cashierSharedPool;

  /// No description provided for @cashierLogTipEntry.
  ///
  /// In en, this message translates to:
  /// **'Log Tip Entry'**
  String get cashierLogTipEntry;

  /// No description provided for @cashierMenuSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search menu item, offer, combo, or description...'**
  String get cashierMenuSearchHint;

  /// No description provided for @cashierPromotionsTitle.
  ///
  /// In en, this message translates to:
  /// **'Offers, combos, discounts, subscriptions'**
  String get cashierPromotionsTitle;

  /// No description provided for @cashierLocationDetails.
  ///
  /// In en, this message translates to:
  /// **'Location details'**
  String get cashierLocationDetails;

  /// No description provided for @cashierTableNumber.
  ///
  /// In en, this message translates to:
  /// **'Table number'**
  String get cashierTableNumber;

  /// No description provided for @cashierNoTableNeeded.
  ///
  /// In en, this message translates to:
  /// **'No table needed'**
  String get cashierNoTableNeeded;

  /// No description provided for @cashierAddress.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get cashierAddress;

  /// No description provided for @cashierBuildingNumber.
  ///
  /// In en, this message translates to:
  /// **'Building number'**
  String get cashierBuildingNumber;

  /// No description provided for @cashierFloorNumber.
  ///
  /// In en, this message translates to:
  /// **'Floor number'**
  String get cashierFloorNumber;

  /// No description provided for @cashierDoorAccessCode.
  ///
  /// In en, this message translates to:
  /// **'Main door access code (if required)'**
  String get cashierDoorAccessCode;

  /// No description provided for @cashierContactPerson.
  ///
  /// In en, this message translates to:
  /// **'Contact person'**
  String get cashierContactPerson;

  /// No description provided for @cashierDeliveryTimeSchedule.
  ///
  /// In en, this message translates to:
  /// **'Delivery time schedule'**
  String get cashierDeliveryTimeSchedule;

  /// No description provided for @cashierSplitPayment.
  ///
  /// In en, this message translates to:
  /// **'Split payment'**
  String get cashierSplitPayment;

  /// No description provided for @cashierSplitTotalMismatch.
  ///
  /// In en, this message translates to:
  /// **'Split amounts must equal the amount payable.'**
  String get cashierSplitTotalMismatch;

  /// No description provided for @cashierPaymentDetails.
  ///
  /// In en, this message translates to:
  /// **'Payment details'**
  String get cashierPaymentDetails;

  /// No description provided for @cashierSelectPaymentMethod.
  ///
  /// In en, this message translates to:
  /// **'Select a payment method'**
  String get cashierSelectPaymentMethod;

  /// No description provided for @cashierPriorBalance.
  ///
  /// In en, this message translates to:
  /// **'Previous balance'**
  String get cashierPriorBalance;

  /// No description provided for @cashierPaymentReceived.
  ///
  /// In en, this message translates to:
  /// **'Payment received'**
  String get cashierPaymentReceived;

  /// No description provided for @cashierPaymentReceivedConfirmed.
  ///
  /// In en, this message translates to:
  /// **'Payment confirmed'**
  String get cashierPaymentReceivedConfirmed;

  /// No description provided for @cashierCashReceived.
  ///
  /// In en, this message translates to:
  /// **'Cash received from client'**
  String get cashierCashReceived;

  /// No description provided for @cashierRemainingDue.
  ///
  /// In en, this message translates to:
  /// **'Remaining due'**
  String get cashierRemainingDue;

  /// No description provided for @cashierCashChange.
  ///
  /// In en, this message translates to:
  /// **'Return to client'**
  String get cashierCashChange;

  /// No description provided for @cashierViewReceipt.
  ///
  /// In en, this message translates to:
  /// **'View receipt'**
  String get cashierViewReceipt;

  /// No description provided for @cashierPrintRollReceipt.
  ///
  /// In en, this message translates to:
  /// **'Print roll receipt'**
  String get cashierPrintRollReceipt;

  /// No description provided for @cashierClientInvoice.
  ///
  /// In en, this message translates to:
  /// **'Client invoice'**
  String get cashierClientInvoice;

  /// No description provided for @cashierInvoicePoints.
  ///
  /// In en, this message translates to:
  /// **'Points earned'**
  String get cashierInvoicePoints;

  /// No description provided for @cashierItemsCount.
  ///
  /// In en, this message translates to:
  /// **'Items'**
  String get cashierItemsCount;

  /// No description provided for @cashierPromotionSavings.
  ///
  /// In en, this message translates to:
  /// **'Promotion savings'**
  String get cashierPromotionSavings;

  /// No description provided for @cashierPromotionDiscounts.
  ///
  /// In en, this message translates to:
  /// **'Discounts'**
  String get cashierPromotionDiscounts;

  /// No description provided for @cashierPromotionSubscriptions.
  ///
  /// In en, this message translates to:
  /// **'Subscriptions'**
  String get cashierPromotionSubscriptions;

  /// No description provided for @cashierTabOrder.
  ///
  /// In en, this message translates to:
  /// **'Ticket'**
  String get cashierTabOrder;

  /// No description provided for @cashierTabFulfillment.
  ///
  /// In en, this message translates to:
  /// **'Delivery'**
  String get cashierTabFulfillment;

  /// No description provided for @cashierTabTip.
  ///
  /// In en, this message translates to:
  /// **'Tip'**
  String get cashierTabTip;

  /// No description provided for @cashierTabPayment.
  ///
  /// In en, this message translates to:
  /// **'Payment'**
  String get cashierTabPayment;

  /// No description provided for @cashierTabConfirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get cashierTabConfirm;

  /// No description provided for @cashierBackTab.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get cashierBackTab;

  /// No description provided for @cashierSendElectronicTicket.
  ///
  /// In en, this message translates to:
  /// **'Send QR / e-ticket'**
  String get cashierSendElectronicTicket;

  /// No description provided for @cashierElectronicTicketSent.
  ///
  /// In en, this message translates to:
  /// **'Electronic ticket sent to client phone via WhatsApp'**
  String get cashierElectronicTicketSent;

  /// No description provided for @cashierSendOrderPreparation.
  ///
  /// In en, this message translates to:
  /// **'Send order for preparation'**
  String get cashierSendOrderPreparation;

  /// No description provided for @cashierKeypadReset.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get cashierKeypadReset;

  /// No description provided for @cashierKeypadDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get cashierKeypadDelete;

  /// No description provided for @cashierKeypadDone.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get cashierKeypadDone;

  /// No description provided for @cashierKeypadSpace.
  ///
  /// In en, this message translates to:
  /// **'Space'**
  String get cashierKeypadSpace;

  /// No description provided for @cashierCashReturnDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Confirm cash return'**
  String get cashierCashReturnDialogTitle;

  /// No description provided for @cashierReceivedValue.
  ///
  /// In en, this message translates to:
  /// **'Received value'**
  String get cashierReceivedValue;

  /// No description provided for @cashierDeductedValue.
  ///
  /// In en, this message translates to:
  /// **'Deducted value'**
  String get cashierDeductedValue;

  /// No description provided for @cashierReturnHighlighted.
  ///
  /// In en, this message translates to:
  /// **'Return to client'**
  String get cashierReturnHighlighted;

  /// No description provided for @cashierReadyForConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Ready'**
  String get cashierReadyForConfirmation;

  /// No description provided for @cashierPaymentPending.
  ///
  /// In en, this message translates to:
  /// **'Payment pending'**
  String get cashierPaymentPending;

  /// No description provided for @cashierFulfillmentCharge.
  ///
  /// In en, this message translates to:
  /// **'Delivery type'**
  String get cashierFulfillmentCharge;

  /// No description provided for @cashierTipAmount.
  ///
  /// In en, this message translates to:
  /// **'Tip'**
  String get cashierTipAmount;

  /// No description provided for @cashierPaymentMethod.
  ///
  /// In en, this message translates to:
  /// **'Payment'**
  String get cashierPaymentMethod;

  /// No description provided for @cashierPaidAmount.
  ///
  /// In en, this message translates to:
  /// **'Paid'**
  String get cashierPaidAmount;

  /// No description provided for @cashierBalanceDue.
  ///
  /// In en, this message translates to:
  /// **'Balance due'**
  String get cashierBalanceDue;

  /// No description provided for @cashierPostponeOrder.
  ///
  /// In en, this message translates to:
  /// **'Postpone order'**
  String get cashierPostponeOrder;

  /// No description provided for @cashierPostponeTitle.
  ///
  /// In en, this message translates to:
  /// **'Postpone unpaid order'**
  String get cashierPostponeTitle;

  /// No description provided for @cashierPostponeReason.
  ///
  /// In en, this message translates to:
  /// **'Reason'**
  String get cashierPostponeReason;

  /// No description provided for @cashierPostponeReasonVisaDeclined.
  ///
  /// In en, this message translates to:
  /// **'Card declined'**
  String get cashierPostponeReasonVisaDeclined;

  /// No description provided for @cashierPostponeReasonFetchingCash.
  ///
  /// In en, this message translates to:
  /// **'Client fetching cash'**
  String get cashierPostponeReasonFetchingCash;

  /// No description provided for @cashierPostponeReasonNoChange.
  ///
  /// In en, this message translates to:
  /// **'No change available'**
  String get cashierPostponeReasonNoChange;

  /// No description provided for @cashierPostponeReasonOther.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get cashierPostponeReasonOther;

  /// No description provided for @cashierPostponeNote.
  ///
  /// In en, this message translates to:
  /// **'Notes (optional)'**
  String get cashierPostponeNote;

  /// No description provided for @cashierPostponeSaved.
  ///
  /// In en, this message translates to:
  /// **'Order postponed — resume from cashier history'**
  String get cashierPostponeSaved;

  /// No description provided for @cashierPostponed.
  ///
  /// In en, this message translates to:
  /// **'Postponed'**
  String get cashierPostponed;

  /// No description provided for @cashierResumeOrder.
  ///
  /// In en, this message translates to:
  /// **'Resume checkout'**
  String get cashierResumeOrder;

  /// No description provided for @cashierNewOrder.
  ///
  /// In en, this message translates to:
  /// **'Start new order'**
  String get cashierNewOrder;

  /// No description provided for @cashierKitchenSent.
  ///
  /// In en, this message translates to:
  /// **'Sent to kitchen'**
  String get cashierKitchenSent;

  /// No description provided for @cashierPromotionOffers.
  ///
  /// In en, this message translates to:
  /// **'Offers'**
  String get cashierPromotionOffers;

  /// No description provided for @cashierPromotionCombos.
  ///
  /// In en, this message translates to:
  /// **'Combos'**
  String get cashierPromotionCombos;

  /// No description provided for @cashierDrawerIdentity.
  ///
  /// In en, this message translates to:
  /// **'Cashier #{number} · {name}'**
  String cashierDrawerIdentity(String number, String name);

  /// No description provided for @screenEditProfile.
  ///
  /// In en, this message translates to:
  /// **'Edit profile'**
  String get screenEditProfile;

  /// No description provided for @fieldEmail.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get fieldEmail;

  /// No description provided for @fieldPhone.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get fieldPhone;

  /// No description provided for @actionEditProfile.
  ///
  /// In en, this message translates to:
  /// **'Edit profile'**
  String get actionEditProfile;

  /// No description provided for @adminKpiOrders.
  ///
  /// In en, this message translates to:
  /// **'Today\'s orders'**
  String get adminKpiOrders;

  /// No description provided for @adminKpiRevenue.
  ///
  /// In en, this message translates to:
  /// **'Revenue'**
  String get adminKpiRevenue;

  /// No description provided for @adminKpiTips.
  ///
  /// In en, this message translates to:
  /// **'Tips pool'**
  String get adminKpiTips;

  /// No description provided for @adminOverviewSection.
  ///
  /// In en, this message translates to:
  /// **'Overview'**
  String get adminOverviewSection;

  /// No description provided for @adminModulesSection.
  ///
  /// In en, this message translates to:
  /// **'Modules'**
  String get adminModulesSection;

  /// No description provided for @financialTotalsMismatch.
  ///
  /// In en, this message translates to:
  /// **'Totals do not match ledger — recalculate before closing.'**
  String get financialTotalsMismatch;

  /// No description provided for @screenFinancialCalculationSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Daily revenue, tips, and deposit totals.'**
  String get screenFinancialCalculationSubtitle;

  /// No description provided for @platedBreakageCost.
  ///
  /// In en, this message translates to:
  /// **'Missing plates will incur a {amount} JOD breakage fee.'**
  String platedBreakageCost(String amount);

  /// No description provided for @screenPlatedReturnProcessSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Count returned trays and note any missing items.'**
  String get screenPlatedReturnProcessSubtitle;

  /// No description provided for @profileAccountSection.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get profileAccountSection;

  /// No description provided for @profileOrdersSection.
  ///
  /// In en, this message translates to:
  /// **'Orders & rewards'**
  String get profileOrdersSection;

  /// No description provided for @platedDeliveryDepositNote.
  ///
  /// In en, this message translates to:
  /// **'A refundable deposit applies to plated delivery orders.'**
  String get platedDeliveryDepositNote;

  /// No description provided for @adminInventoryLowTitle.
  ///
  /// In en, this message translates to:
  /// **'Inventory Low: Ribeye Steak'**
  String get adminInventoryLowTitle;

  /// No description provided for @adminInventoryLowBody.
  ///
  /// In en, this message translates to:
  /// **'Only 14 units remaining. Projected to run out in 2 hours.'**
  String get adminInventoryLowBody;

  /// No description provided for @adminRestockAction.
  ///
  /// In en, this message translates to:
  /// **'Restock'**
  String get adminRestockAction;

  /// No description provided for @adminPendingTipTitle.
  ///
  /// In en, this message translates to:
  /// **'Pending Tip Distribution'**
  String get adminPendingTipTitle;

  /// No description provided for @adminPendingTipBody.
  ///
  /// In en, this message translates to:
  /// **'12 transactions awaiting shift closure for distribution.'**
  String get adminPendingTipBody;

  /// No description provided for @adminReviewAction.
  ///
  /// In en, this message translates to:
  /// **'Review'**
  String get adminReviewAction;

  /// No description provided for @adminRevenueToday.
  ///
  /// In en, this message translates to:
  /// **'Total Revenue (Today)'**
  String get adminRevenueToday;

  /// No description provided for @adminRevenueDelta.
  ///
  /// In en, this message translates to:
  /// **'+14.2% from yesterday'**
  String get adminRevenueDelta;

  /// No description provided for @adminTipsCollected.
  ///
  /// In en, this message translates to:
  /// **'Tips Collected'**
  String get adminTipsCollected;

  /// No description provided for @adminTipsAwaiting.
  ///
  /// In en, this message translates to:
  /// **'Awaiting distribution'**
  String get adminTipsAwaiting;

  /// No description provided for @adminTipHistoryAction.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get adminTipHistoryAction;

  /// No description provided for @adminTipDistributeAction.
  ///
  /// In en, this message translates to:
  /// **'Distribute'**
  String get adminTipDistributeAction;

  /// No description provided for @adminDailyTipPool.
  ///
  /// In en, this message translates to:
  /// **'Daily Tip Pool'**
  String get adminDailyTipPool;

  /// No description provided for @adminTipDeltaYesterday.
  ///
  /// In en, this message translates to:
  /// **'+12% from yesterday'**
  String get adminTipDeltaYesterday;

  /// No description provided for @adminStaffDistribution.
  ///
  /// In en, this message translates to:
  /// **'Staff Distribution'**
  String get adminStaffDistribution;

  /// No description provided for @adminMembersScheduled.
  ///
  /// In en, this message translates to:
  /// **'Members Scheduled'**
  String get adminMembersScheduled;

  /// No description provided for @adminTotalHoursLogged.
  ///
  /// In en, this message translates to:
  /// **'Total Hours Logged'**
  String get adminTotalHoursLogged;

  /// No description provided for @adminAverageRate.
  ///
  /// In en, this message translates to:
  /// **'Avg. Rate: {amount} / hr'**
  String adminAverageRate(String amount);

  /// No description provided for @adminStaffBreakdown.
  ///
  /// In en, this message translates to:
  /// **'Staff Breakdown'**
  String get adminStaffBreakdown;

  /// No description provided for @adminRecalculatePool.
  ///
  /// In en, this message translates to:
  /// **'Recalculate Pool'**
  String get adminRecalculatePool;

  /// No description provided for @adminApproveAllDistributions.
  ///
  /// In en, this message translates to:
  /// **'Approve All Distributions'**
  String get adminApproveAllDistributions;

  /// No description provided for @adminStaffMember.
  ///
  /// In en, this message translates to:
  /// **'Staff Member'**
  String get adminStaffMember;

  /// No description provided for @adminRole.
  ///
  /// In en, this message translates to:
  /// **'Role'**
  String get adminRole;

  /// No description provided for @adminHours.
  ///
  /// In en, this message translates to:
  /// **'Hours'**
  String get adminHours;

  /// No description provided for @adminTipShare.
  ///
  /// In en, this message translates to:
  /// **'Tip Share'**
  String get adminTipShare;

  /// No description provided for @adminShowAllStaff.
  ///
  /// In en, this message translates to:
  /// **'Show All 14 Staff Members'**
  String get adminShowAllStaff;

  /// No description provided for @adminCalculationLogic.
  ///
  /// In en, this message translates to:
  /// **'Calculation Logic'**
  String get adminCalculationLogic;

  /// No description provided for @adminNetSalesTips.
  ///
  /// In en, this message translates to:
  /// **'Net Sales Tips (85%)'**
  String get adminNetSalesTips;

  /// No description provided for @adminDirectServicePremium.
  ///
  /// In en, this message translates to:
  /// **'Direct Service Premium (10%)'**
  String get adminDirectServicePremium;

  /// No description provided for @adminCarryOver.
  ///
  /// In en, this message translates to:
  /// **'Admin Carry Over (5%)'**
  String get adminCarryOver;

  /// No description provided for @adminCalculatedPointRate.
  ///
  /// In en, this message translates to:
  /// **'Calculated Point Rate'**
  String get adminCalculatedPointRate;

  /// No description provided for @adminShareDistribution.
  ///
  /// In en, this message translates to:
  /// **'Share Distribution'**
  String get adminShareDistribution;

  /// No description provided for @adminLossBreakage.
  ///
  /// In en, this message translates to:
  /// **'Loss / Breakage'**
  String get adminLossBreakage;

  /// No description provided for @adminBreakageReports.
  ///
  /// In en, this message translates to:
  /// **'3 reports reported'**
  String get adminBreakageReports;

  /// No description provided for @adminBreakageOne.
  ///
  /// In en, this message translates to:
  /// **'Unknown item #441 · 3 JOD'**
  String get adminBreakageOne;

  /// No description provided for @adminBreakageTwo.
  ///
  /// In en, this message translates to:
  /// **'Snapping drink · 25 JOD'**
  String get adminBreakageTwo;

  /// No description provided for @adminLiveOrderStatus.
  ///
  /// In en, this message translates to:
  /// **'Live Order Status'**
  String get adminLiveOrderStatus;

  /// No description provided for @adminManageStations.
  ///
  /// In en, this message translates to:
  /// **'Manage Stations'**
  String get adminManageStations;

  /// No description provided for @adminHighDemand.
  ///
  /// In en, this message translates to:
  /// **'High demand'**
  String get adminHighDemand;

  /// No description provided for @adminNormalFlow.
  ///
  /// In en, this message translates to:
  /// **'Avg wait'**
  String get adminNormalFlow;

  /// No description provided for @adminStationLoad.
  ///
  /// In en, this message translates to:
  /// **'Active Station Load'**
  String get adminStationLoad;

  /// No description provided for @adminGrillStation.
  ///
  /// In en, this message translates to:
  /// **'Grill Station'**
  String get adminGrillStation;

  /// No description provided for @adminColdPrepStation.
  ///
  /// In en, this message translates to:
  /// **'Cold Prep / Salads'**
  String get adminColdPrepStation;

  /// No description provided for @adminCapacity.
  ///
  /// In en, this message translates to:
  /// **'capacity'**
  String get adminCapacity;

  /// No description provided for @adminStaffOnShift.
  ///
  /// In en, this message translates to:
  /// **'Staff On Shift'**
  String get adminStaffOnShift;

  /// No description provided for @adminManageRoster.
  ///
  /// In en, this message translates to:
  /// **'Manage Roster'**
  String get adminManageRoster;

  /// No description provided for @adminStaffActive.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get adminStaffActive;

  /// No description provided for @adminStaffBreak.
  ///
  /// In en, this message translates to:
  /// **'Break'**
  String get adminStaffBreak;

  /// No description provided for @adminMarketInsight.
  ///
  /// In en, this message translates to:
  /// **'Market Insight'**
  String get adminMarketInsight;

  /// No description provided for @adminMarketInsightBody.
  ///
  /// In en, this message translates to:
  /// **'Demand for plated dishes is up 22% this evening compared to last Friday. Recommend boosting appetizer prep.'**
  String get adminMarketInsightBody;

  /// No description provided for @adminNavOrders.
  ///
  /// In en, this message translates to:
  /// **'Orders'**
  String get adminNavOrders;

  /// No description provided for @adminNavPos.
  ///
  /// In en, this message translates to:
  /// **'POS'**
  String get adminNavPos;

  /// No description provided for @adminNavKitchen.
  ///
  /// In en, this message translates to:
  /// **'Kitchen'**
  String get adminNavKitchen;

  /// No description provided for @adminNavDelivery.
  ///
  /// In en, this message translates to:
  /// **'Delivery'**
  String get adminNavDelivery;

  /// No description provided for @adminNavAdmin.
  ///
  /// In en, this message translates to:
  /// **'Admin'**
  String get adminNavAdmin;

  /// No description provided for @screenCashierOrderHistoryDesc.
  ///
  /// In en, this message translates to:
  /// **'Cashier order history screen.'**
  String get screenCashierOrderHistoryDesc;

  /// No description provided for @dineWelcomeTitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Our Table'**
  String get dineWelcomeTitle;

  /// No description provided for @dineWelcomeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Enter your table number to begin ordering'**
  String get dineWelcomeSubtitle;

  /// No description provided for @dineScanQrCode.
  ///
  /// In en, this message translates to:
  /// **'Scan QR Code'**
  String get dineScanQrCode;

  /// No description provided for @dineOr.
  ///
  /// In en, this message translates to:
  /// **'OR'**
  String get dineOr;

  /// No description provided for @dineCurrencyStatus.
  ///
  /// In en, this message translates to:
  /// **'Currency Status'**
  String get dineCurrencyStatus;

  /// No description provided for @dineCurrencySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Paying in JOD (Jordanian Dinar)'**
  String get dineCurrencySubtitle;

  /// No description provided for @financialGrossRevenue.
  ///
  /// In en, this message translates to:
  /// **'Gross Revenue'**
  String get financialGrossRevenue;

  /// No description provided for @financialRevenueDelta.
  ///
  /// In en, this message translates to:
  /// **'+12.5% from last period'**
  String get financialRevenueDelta;

  /// No description provided for @financialTotalTipsExcluded.
  ///
  /// In en, this message translates to:
  /// **'Total Tips (Excluded)'**
  String get financialTotalTipsExcluded;

  /// No description provided for @financialTipsSeparate.
  ///
  /// In en, this message translates to:
  /// **'Distributed to staff separately'**
  String get financialTipsSeparate;

  /// No description provided for @financialEscrowDeposits.
  ///
  /// In en, this message translates to:
  /// **'Escrow Deposits'**
  String get financialEscrowDeposits;

  /// No description provided for @financialEscrowSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Conditional funds in-transit'**
  String get financialEscrowSubtitle;

  /// No description provided for @financialProfitEngine.
  ///
  /// In en, this message translates to:
  /// **'Profit Distribution Engine'**
  String get financialProfitEngine;

  /// No description provided for @financialNetRevenue.
  ///
  /// In en, this message translates to:
  /// **'Net Distributable Revenue'**
  String get financialNetRevenue;

  /// No description provided for @financialPrdSplitLogic.
  ///
  /// In en, this message translates to:
  /// **'PRD Split Logic'**
  String get financialPrdSplitLogic;

  /// No description provided for @financialOwnerShare.
  ///
  /// In en, this message translates to:
  /// **'Owner Share'**
  String get financialOwnerShare;

  /// No description provided for @financialOperatorShare.
  ///
  /// In en, this message translates to:
  /// **'Operator Share'**
  String get financialOperatorShare;

  /// No description provided for @financialRevenueLogicBreakdown.
  ///
  /// In en, this message translates to:
  /// **'Revenue Logic Breakdown'**
  String get financialRevenueLogicBreakdown;

  /// No description provided for @financialPhaseOne.
  ///
  /// In en, this message translates to:
  /// **'PHASE 1'**
  String get financialPhaseOne;

  /// No description provided for @financialPhaseTwo.
  ///
  /// In en, this message translates to:
  /// **'PHASE 2'**
  String get financialPhaseTwo;

  /// No description provided for @financialTotalCapturedRevenue.
  ///
  /// In en, this message translates to:
  /// **'Total Captured Revenue'**
  String get financialTotalCapturedRevenue;

  /// No description provided for @financialTipsExcludedFromShare.
  ///
  /// In en, this message translates to:
  /// **'Tips (Excluded from Share)'**
  String get financialTipsExcludedFromShare;

  /// No description provided for @financialOperationalExpenses.
  ///
  /// In en, this message translates to:
  /// **'Operational Expenses (Pre-Split)'**
  String get financialOperationalExpenses;

  /// No description provided for @financialNetDistributablePool.
  ///
  /// In en, this message translates to:
  /// **'Net Distributable Pool'**
  String get financialNetDistributablePool;

  /// No description provided for @financialShareAllocation.
  ///
  /// In en, this message translates to:
  /// **'Share Allocation (PRD v2.1)'**
  String get financialShareAllocation;

  /// No description provided for @financialOwnerTier.
  ///
  /// In en, this message translates to:
  /// **'Owner Tier 1'**
  String get financialOwnerTier;

  /// No description provided for @financialPrimary.
  ///
  /// In en, this message translates to:
  /// **'Primary'**
  String get financialPrimary;

  /// No description provided for @financialOperatorPerformance.
  ///
  /// In en, this message translates to:
  /// **'Operator Performance'**
  String get financialOperatorPerformance;

  /// No description provided for @financialIncentivized.
  ///
  /// In en, this message translates to:
  /// **'Incentivized'**
  String get financialIncentivized;

  /// No description provided for @financialBaseMultiplier.
  ///
  /// In en, this message translates to:
  /// **'Base Multiplier'**
  String get financialBaseMultiplier;

  /// No description provided for @financialAllocatedAmount.
  ///
  /// In en, this message translates to:
  /// **'Allocated Amount'**
  String get financialAllocatedAmount;

  /// No description provided for @financialInitiateDisbursement.
  ///
  /// In en, this message translates to:
  /// **'Initiate Bank Disbursement'**
  String get financialInitiateDisbursement;

  /// No description provided for @financialWhyMathMatters.
  ///
  /// In en, this message translates to:
  /// **'Why this math matters.'**
  String get financialWhyMathMatters;

  /// No description provided for @financialWhyBody.
  ///
  /// In en, this message translates to:
  /// **'Our profit distribution engine ensures every dinar is accounted for by separating gross revenue from distributable profit, excluding staff tips, and holding refundable deposits outside the owner/operator split.'**
  String get financialWhyBody;

  /// No description provided for @financialPdfReport.
  ///
  /// In en, this message translates to:
  /// **'Download PDF Report'**
  String get financialPdfReport;

  /// No description provided for @financialSharePartners.
  ///
  /// In en, this message translates to:
  /// **'Share with Partners'**
  String get financialSharePartners;

  /// No description provided for @financialOrders.
  ///
  /// In en, this message translates to:
  /// **'Orders'**
  String get financialOrders;

  /// No description provided for @financialPos.
  ///
  /// In en, this message translates to:
  /// **'POS'**
  String get financialPos;

  /// No description provided for @financialAdmin.
  ///
  /// In en, this message translates to:
  /// **'Admin'**
  String get financialAdmin;

  /// No description provided for @financialDelivery.
  ///
  /// In en, this message translates to:
  /// **'Delivery'**
  String get financialDelivery;

  /// No description provided for @forgotPasswordTitle.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password'**
  String get forgotPasswordTitle;

  /// No description provided for @forgotPasswordSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Enter your registered phone or email to receive a reset code'**
  String get forgotPasswordSubtitle;

  /// No description provided for @forgotEmailPhoneLabel.
  ///
  /// In en, this message translates to:
  /// **'Email or Phone Number'**
  String get forgotEmailPhoneLabel;

  /// No description provided for @forgotEmailPhoneHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. guest@ayletna.com'**
  String get forgotEmailPhoneHint;

  /// No description provided for @forgotSendCode.
  ///
  /// In en, this message translates to:
  /// **'Send Code'**
  String get forgotSendCode;

  /// No description provided for @forgotBackToLogin.
  ///
  /// In en, this message translates to:
  /// **'Back to login'**
  String get forgotBackToLogin;

  /// No description provided for @forgotNeedHelp.
  ///
  /// In en, this message translates to:
  /// **'Need help?'**
  String get forgotNeedHelp;

  /// No description provided for @forgotContactSupport.
  ///
  /// In en, this message translates to:
  /// **'Contact Ayletna Support'**
  String get forgotContactSupport;

  /// No description provided for @guestMenuNav.
  ///
  /// In en, this message translates to:
  /// **'Menu'**
  String get guestMenuNav;

  /// No description provided for @guestLocationsNav.
  ///
  /// In en, this message translates to:
  /// **'Locations'**
  String get guestLocationsNav;

  /// No description provided for @guestAboutNav.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get guestAboutNav;

  /// No description provided for @guestLimitedOffer.
  ///
  /// In en, this message translates to:
  /// **'Limited Time Offer'**
  String get guestLimitedOffer;

  /// No description provided for @guestRoyalMansafTitle.
  ///
  /// In en, this message translates to:
  /// **'The Royal Mansaf Experience'**
  String get guestRoyalMansafTitle;

  /// No description provided for @guestRoyalMansafSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Authentic Karak jameed and tender local lamb. 15% off for first-time guests.'**
  String get guestRoyalMansafSubtitle;

  /// No description provided for @guestWeekendFeast.
  ///
  /// In en, this message translates to:
  /// **'Weekend Feast'**
  String get guestWeekendFeast;

  /// No description provided for @guestWeekendFeastSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Order any appetizer and main to get a free Jallab drink.'**
  String get guestWeekendFeastSubtitle;

  /// No description provided for @guestClaimOffer.
  ///
  /// In en, this message translates to:
  /// **'Claim Offer'**
  String get guestClaimOffer;

  /// No description provided for @guestMansafSpecials.
  ///
  /// In en, this message translates to:
  /// **'Mansaf Specials'**
  String get guestMansafSpecials;

  /// No description provided for @guestItemsFound.
  ///
  /// In en, this message translates to:
  /// **'{count} items found'**
  String guestItemsFound(int count);

  /// No description provided for @guestRefreshingDrinks.
  ///
  /// In en, this message translates to:
  /// **'Refreshing Drinks'**
  String get guestRefreshingDrinks;

  /// No description provided for @guestBrowseMore.
  ///
  /// In en, this message translates to:
  /// **'Browse More'**
  String get guestBrowseMore;

  /// No description provided for @guestMintLemonade.
  ///
  /// In en, this message translates to:
  /// **'Mint Lemonade'**
  String get guestMintLemonade;

  /// No description provided for @guestArabicCoffee.
  ///
  /// In en, this message translates to:
  /// **'Arabic Coffee'**
  String get guestArabicCoffee;

  /// No description provided for @guestLocalWater.
  ///
  /// In en, this message translates to:
  /// **'Local Water'**
  String get guestLocalWater;

  /// No description provided for @guestSageTea.
  ///
  /// In en, this message translates to:
  /// **'Sage Tea'**
  String get guestSageTea;

  /// No description provided for @homeSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search dishes, categories...'**
  String get homeSearchHint;

  /// No description provided for @screenSearch.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get screenSearch;

  /// No description provided for @searchTitle.
  ///
  /// In en, this message translates to:
  /// **'Find your next meal'**
  String get searchTitle;

  /// No description provided for @searchSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Search the Ayletna menu by dish, category, or ingredient-style description.'**
  String get searchSubtitle;

  /// No description provided for @searchMenuHint.
  ///
  /// In en, this message translates to:
  /// **'Search menu, dishes, or ingredients...'**
  String get searchMenuHint;

  /// No description provided for @searchRecentTitle.
  ///
  /// In en, this message translates to:
  /// **'Recent Searches'**
  String get searchRecentTitle;

  /// No description provided for @searchClearAll.
  ///
  /// In en, this message translates to:
  /// **'Clear All'**
  String get searchClearAll;

  /// No description provided for @searchTopResults.
  ///
  /// In en, this message translates to:
  /// **'Top Results'**
  String get searchTopResults;

  /// No description provided for @searchItemsFound.
  ///
  /// In en, this message translates to:
  /// **'{count} items found'**
  String searchItemsFound(int count);

  /// No description provided for @searchAddShort.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get searchAddShort;

  /// No description provided for @searchStartTitle.
  ///
  /// In en, this message translates to:
  /// **'Type a dish name'**
  String get searchStartTitle;

  /// No description provided for @searchStartBody.
  ///
  /// In en, this message translates to:
  /// **'Try shawarma, hummus, pizza, falafel, burger, or any craving from the menu.'**
  String get searchStartBody;

  /// No description provided for @searchEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No dishes found'**
  String get searchEmptyTitle;

  /// No description provided for @searchEmptyBody.
  ///
  /// In en, this message translates to:
  /// **'Try a different dish name or browse the full menu categories.'**
  String get searchEmptyBody;

  /// No description provided for @searchResultsCount.
  ///
  /// In en, this message translates to:
  /// **'{count} results found'**
  String searchResultsCount(int count);

  /// No description provided for @searchPopularSuggestions.
  ///
  /// In en, this message translates to:
  /// **'Popular searches'**
  String get searchPopularSuggestions;

  /// No description provided for @searchBrowseMenu.
  ///
  /// In en, this message translates to:
  /// **'Browse full menu'**
  String get searchBrowseMenu;

  /// No description provided for @homePlatedDelivery.
  ///
  /// In en, this message translates to:
  /// **'PLATED DELIVERY'**
  String get homePlatedDelivery;

  /// No description provided for @homeZeroWasteTitle.
  ///
  /// In en, this message translates to:
  /// **'Traditional Taste,\nZero Waste.'**
  String get homeZeroWasteTitle;

  /// No description provided for @homeZeroWasteSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Get your feast served on authentic clay plates. 5 JOD refundable deposit per plate.'**
  String get homeZeroWasteSubtitle;

  /// No description provided for @homeOrderNow.
  ///
  /// In en, this message translates to:
  /// **'Order Now'**
  String get homeOrderNow;

  /// No description provided for @homeOffers.
  ///
  /// In en, this message translates to:
  /// **'Offers'**
  String get homeOffers;

  /// No description provided for @homeCombos.
  ///
  /// In en, this message translates to:
  /// **'Combos'**
  String get homeCombos;

  /// No description provided for @homeDiscounts.
  ///
  /// In en, this message translates to:
  /// **'Discounted items'**
  String get homeDiscounts;

  /// No description provided for @homeSubscriptions.
  ///
  /// In en, this message translates to:
  /// **'Subscription meals'**
  String get homeSubscriptions;

  /// No description provided for @homeStories.
  ///
  /// In en, this message translates to:
  /// **'From Ayletna'**
  String get homeStories;

  /// No description provided for @homeSubscriptionCta.
  ///
  /// In en, this message translates to:
  /// **'Subscribe'**
  String get homeSubscriptionCta;

  /// No description provided for @homeDiscountBadge.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get homeDiscountBadge;

  /// No description provided for @homePopularThisWeek.
  ///
  /// In en, this message translates to:
  /// **'Popular This Week'**
  String get homePopularThisWeek;

  /// No description provided for @homeViewAll.
  ///
  /// In en, this message translates to:
  /// **'View All'**
  String get homeViewAll;

  /// No description provided for @homeSustainabilityDeposit.
  ///
  /// In en, this message translates to:
  /// **'Sustainability Deposit'**
  String get homeSustainabilityDeposit;

  /// No description provided for @homeSustainabilityBody.
  ///
  /// In en, this message translates to:
  /// **'Choose the Plated option for an eco-friendly experience. A small deposit for our premium clayware will be added and fully refunded when we collect the plates after your meal.'**
  String get homeSustainabilityBody;

  /// No description provided for @homeLearnHowItWorks.
  ///
  /// In en, this message translates to:
  /// **'Learn how it works'**
  String get homeLearnHowItWorks;

  /// No description provided for @inventorySearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search ingredients...'**
  String get inventorySearchHint;

  /// No description provided for @inventoryLogWastage.
  ///
  /// In en, this message translates to:
  /// **'Log Wastage'**
  String get inventoryLogWastage;

  /// No description provided for @inventoryAddStock.
  ///
  /// In en, this message translates to:
  /// **'Add Stock'**
  String get inventoryAddStock;

  /// No description provided for @inventoryLowStockAlerts.
  ///
  /// In en, this message translates to:
  /// **'Low Stock Alerts'**
  String get inventoryLowStockAlerts;

  /// No description provided for @inventoryProtein.
  ///
  /// In en, this message translates to:
  /// **'PROTEIN'**
  String get inventoryProtein;

  /// No description provided for @inventoryDairy.
  ///
  /// In en, this message translates to:
  /// **'DAIRY'**
  String get inventoryDairy;

  /// No description provided for @inventoryProduce.
  ///
  /// In en, this message translates to:
  /// **'PRODUCE'**
  String get inventoryProduce;

  /// No description provided for @inventoryPantry.
  ///
  /// In en, this message translates to:
  /// **'PANTRY'**
  String get inventoryPantry;

  /// No description provided for @inventoryRibeyeSteak.
  ///
  /// In en, this message translates to:
  /// **'Ribeye Steak'**
  String get inventoryRibeyeSteak;

  /// No description provided for @inventoryHeavyCream.
  ///
  /// In en, this message translates to:
  /// **'Heavy Cream'**
  String get inventoryHeavyCream;

  /// No description provided for @inventoryFreshBasil.
  ///
  /// In en, this message translates to:
  /// **'Fresh Basil'**
  String get inventoryFreshBasil;

  /// No description provided for @inventoryTruffleOil.
  ///
  /// In en, this message translates to:
  /// **'Truffle Oil'**
  String get inventoryTruffleOil;

  /// No description provided for @inventoryRemaining.
  ///
  /// In en, this message translates to:
  /// **'{amount} remaining'**
  String inventoryRemaining(String amount);

  /// No description provided for @inventoryOutOfStock.
  ///
  /// In en, this message translates to:
  /// **'Out of Stock'**
  String get inventoryOutOfStock;

  /// No description provided for @inventoryReorderPoint.
  ///
  /// In en, this message translates to:
  /// **'Reorder Point: {amount}'**
  String inventoryReorderPoint(String amount);

  /// No description provided for @inventoryRequiredForDishes.
  ///
  /// In en, this message translates to:
  /// **'Required for 4 dishes'**
  String get inventoryRequiredForDishes;

  /// No description provided for @inventoryKeyLevels.
  ///
  /// In en, this message translates to:
  /// **'Key Ingredients Levels'**
  String get inventoryKeyLevels;

  /// No description provided for @inventoryFullList.
  ///
  /// In en, this message translates to:
  /// **'Full Inventory List'**
  String get inventoryFullList;

  /// No description provided for @inventoryOrganicChicken.
  ///
  /// In en, this message translates to:
  /// **'Organic Chicken Breast'**
  String get inventoryOrganicChicken;

  /// No description provided for @inventoryDairyEggs.
  ///
  /// In en, this message translates to:
  /// **'Dairy & Eggs Bundle'**
  String get inventoryDairyEggs;

  /// No description provided for @inventorySeafood.
  ///
  /// In en, this message translates to:
  /// **'Seafood (Salmon/Sea Bass)'**
  String get inventorySeafood;

  /// No description provided for @inventoryFlourStaples.
  ///
  /// In en, this message translates to:
  /// **'Flour & Dry Staples'**
  String get inventoryFlourStaples;

  /// No description provided for @inventoryLevelMeta.
  ///
  /// In en, this message translates to:
  /// **'{percent}% / {capacity}'**
  String inventoryLevelMeta(int percent, String capacity);

  /// No description provided for @inventoryValue.
  ///
  /// In en, this message translates to:
  /// **'Inventory Value'**
  String get inventoryValue;

  /// No description provided for @inventoryValueDelta.
  ///
  /// In en, this message translates to:
  /// **'+2.4% from last week'**
  String get inventoryValueDelta;

  /// No description provided for @inventoryPendingOrders.
  ///
  /// In en, this message translates to:
  /// **'Pending Orders'**
  String get inventoryPendingOrders;

  /// No description provided for @inventoryShipmentsToday.
  ///
  /// In en, this message translates to:
  /// **'3 shipments expected today'**
  String get inventoryShipmentsToday;

  /// No description provided for @inventoryStorageHealth.
  ///
  /// In en, this message translates to:
  /// **'Storage Health'**
  String get inventoryStorageHealth;

  /// No description provided for @inventoryColdStorage.
  ///
  /// In en, this message translates to:
  /// **'Cold Storage'**
  String get inventoryColdStorage;

  /// No description provided for @inventoryDryStorage.
  ///
  /// In en, this message translates to:
  /// **'Dry Storage'**
  String get inventoryDryStorage;

  /// No description provided for @inventoryFreezerUnit.
  ///
  /// In en, this message translates to:
  /// **'Freezer Unit B'**
  String get inventoryFreezerUnit;

  /// No description provided for @inventoryOptimal.
  ///
  /// In en, this message translates to:
  /// **'Optimal'**
  String get inventoryOptimal;

  /// No description provided for @inventoryAlert.
  ///
  /// In en, this message translates to:
  /// **'Alert'**
  String get inventoryAlert;

  /// No description provided for @inventoryRecentWastage.
  ///
  /// In en, this message translates to:
  /// **'Recent Wastage Logs'**
  String get inventoryRecentWastage;

  /// No description provided for @inventoryDownloadReport.
  ///
  /// In en, this message translates to:
  /// **'Download Report'**
  String get inventoryDownloadReport;

  /// No description provided for @inventoryItemName.
  ///
  /// In en, this message translates to:
  /// **'Item Name'**
  String get inventoryItemName;

  /// No description provided for @inventoryQuantity.
  ///
  /// In en, this message translates to:
  /// **'Quantity'**
  String get inventoryQuantity;

  /// No description provided for @inventoryReason.
  ///
  /// In en, this message translates to:
  /// **'Reason'**
  String get inventoryReason;

  /// No description provided for @inventoryValueLost.
  ///
  /// In en, this message translates to:
  /// **'Value Lost'**
  String get inventoryValueLost;

  /// No description provided for @inventoryLogDate.
  ///
  /// In en, this message translates to:
  /// **'Log Date'**
  String get inventoryLogDate;

  /// No description provided for @inventoryUser.
  ///
  /// In en, this message translates to:
  /// **'User'**
  String get inventoryUser;

  /// No description provided for @inventoryAvocadoCase.
  ///
  /// In en, this message translates to:
  /// **'Avocado (Case)'**
  String get inventoryAvocadoCase;

  /// No description provided for @inventoryWholeMilk.
  ///
  /// In en, this message translates to:
  /// **'Whole Milk'**
  String get inventoryWholeMilk;

  /// No description provided for @inventorySeaBassFillets.
  ///
  /// In en, this message translates to:
  /// **'Sea Bass Fillets'**
  String get inventorySeaBassFillets;

  /// No description provided for @inventorySpoilage.
  ///
  /// In en, this message translates to:
  /// **'Spoilage'**
  String get inventorySpoilage;

  /// No description provided for @inventoryExpired.
  ///
  /// In en, this message translates to:
  /// **'Expired'**
  String get inventoryExpired;

  /// No description provided for @inventoryPrepWaste.
  ///
  /// In en, this message translates to:
  /// **'Prep Waste'**
  String get inventoryPrepWaste;

  /// No description provided for @inventoryChefUser.
  ///
  /// In en, this message translates to:
  /// **'Chef Team'**
  String get inventoryChefUser;

  /// No description provided for @inventoryAdminUser.
  ///
  /// In en, this message translates to:
  /// **'Admin Team'**
  String get inventoryAdminUser;

  /// No description provided for @inventoryItemAtlanticSalmon.
  ///
  /// In en, this message translates to:
  /// **'Atlantic Salmon'**
  String get inventoryItemAtlanticSalmon;

  /// No description provided for @inventoryItemSupplyBadge.
  ///
  /// In en, this message translates to:
  /// **'Dine-in Supply'**
  String get inventoryItemSupplyBadge;

  /// No description provided for @inventoryItemPremiumFillet.
  ///
  /// In en, this message translates to:
  /// **'Premium Grade Fillet'**
  String get inventoryItemPremiumFillet;

  /// No description provided for @inventoryItemSku.
  ///
  /// In en, this message translates to:
  /// **'SKU: INV-SAL-042 | Fresh Wild-Caught'**
  String get inventoryItemSku;

  /// No description provided for @inventoryCurrentStock.
  ///
  /// In en, this message translates to:
  /// **'Current Stock'**
  String get inventoryCurrentStock;

  /// No description provided for @inventoryKg.
  ///
  /// In en, this message translates to:
  /// **'kg'**
  String get inventoryKg;

  /// No description provided for @inventorySafetyThreshold.
  ///
  /// In en, this message translates to:
  /// **'Safety Threshold'**
  String get inventorySafetyThreshold;

  /// No description provided for @inventoryHealthyInventory.
  ///
  /// In en, this message translates to:
  /// **'Healthy Inventory'**
  String get inventoryHealthyInventory;

  /// No description provided for @inventoryAdjustStock.
  ///
  /// In en, this message translates to:
  /// **'Adjust Stock'**
  String get inventoryAdjustStock;

  /// No description provided for @inventoryAdjustmentQuantity.
  ///
  /// In en, this message translates to:
  /// **'Adjustment Quantity (kg)'**
  String get inventoryAdjustmentQuantity;

  /// No description provided for @inventoryAdjustmentHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. -2.5'**
  String get inventoryAdjustmentHint;

  /// No description provided for @inventoryReasonAdjustment.
  ///
  /// In en, this message translates to:
  /// **'Reason for Adjustment'**
  String get inventoryReasonAdjustment;

  /// No description provided for @inventoryConsumption.
  ///
  /// In en, this message translates to:
  /// **'Consumption'**
  String get inventoryConsumption;

  /// No description provided for @inventoryDamageSpoilage.
  ///
  /// In en, this message translates to:
  /// **'Damage / Spoilage'**
  String get inventoryDamageSpoilage;

  /// No description provided for @inventoryCorrection.
  ///
  /// In en, this message translates to:
  /// **'Correction'**
  String get inventoryCorrection;

  /// No description provided for @inventoryArrivalShipment.
  ///
  /// In en, this message translates to:
  /// **'Arrival of Shipment'**
  String get inventoryArrivalShipment;

  /// No description provided for @inventoryThresholdConfig.
  ///
  /// In en, this message translates to:
  /// **'Safety Threshold Configuration'**
  String get inventoryThresholdConfig;

  /// No description provided for @inventoryLowStockTrigger.
  ///
  /// In en, this message translates to:
  /// **'Triggers Low Stock alert at this level.'**
  String get inventoryLowStockTrigger;

  /// No description provided for @inventoryUpdateInventory.
  ///
  /// In en, this message translates to:
  /// **'Update Inventory'**
  String get inventoryUpdateInventory;

  /// No description provided for @inventoryMainSupplier.
  ///
  /// In en, this message translates to:
  /// **'Main Supplier'**
  String get inventoryMainSupplier;

  /// No description provided for @inventorySupplierName.
  ///
  /// In en, this message translates to:
  /// **'North Atlantic Fisheries'**
  String get inventorySupplierName;

  /// No description provided for @inventorySupplierLeadTime.
  ///
  /// In en, this message translates to:
  /// **'Lead Time: 2 Business Days'**
  String get inventorySupplierLeadTime;

  /// No description provided for @inventoryContactRepresentative.
  ///
  /// In en, this message translates to:
  /// **'Contact Representative'**
  String get inventoryContactRepresentative;

  /// No description provided for @inventoryLastSevenDaysUsage.
  ///
  /// In en, this message translates to:
  /// **'Last 7 Days Usage'**
  String get inventoryLastSevenDaysUsage;

  /// No description provided for @inventoryInStock.
  ///
  /// In en, this message translates to:
  /// **'In Stock'**
  String get inventoryInStock;

  /// No description provided for @inventoryRecentHistoryAudit.
  ///
  /// In en, this message translates to:
  /// **'Recent History Audit'**
  String get inventoryRecentHistoryAudit;

  /// No description provided for @inventoryDate.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get inventoryDate;

  /// No description provided for @inventoryType.
  ///
  /// In en, this message translates to:
  /// **'Type'**
  String get inventoryType;

  /// No description provided for @inventoryAmount.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get inventoryAmount;

  /// No description provided for @inventoryBalance.
  ///
  /// In en, this message translates to:
  /// **'Balance'**
  String get inventoryBalance;

  /// No description provided for @inventoryTodayTime.
  ///
  /// In en, this message translates to:
  /// **'Today, 09:12 AM'**
  String get inventoryTodayTime;

  /// No description provided for @inventoryOct24Time.
  ///
  /// In en, this message translates to:
  /// **'Oct 24, 11:30 AM'**
  String get inventoryOct24Time;

  /// No description provided for @inventoryOct23Time.
  ///
  /// In en, this message translates to:
  /// **'Oct 23, 05:45 PM'**
  String get inventoryOct23Time;

  /// No description provided for @inventoryDeliveryType.
  ///
  /// In en, this message translates to:
  /// **'Delivery'**
  String get inventoryDeliveryType;

  /// No description provided for @inventoryChefShort.
  ///
  /// In en, this message translates to:
  /// **'M. Chef'**
  String get inventoryChefShort;

  /// No description provided for @inventorySysAdmin.
  ///
  /// In en, this message translates to:
  /// **'Sys Admin'**
  String get inventorySysAdmin;

  /// No description provided for @inventoryLineCook.
  ///
  /// In en, this message translates to:
  /// **'Line Cook'**
  String get inventoryLineCook;

  /// No description provided for @kitchenStatusWithCount.
  ///
  /// In en, this message translates to:
  /// **'{status} ({count})'**
  String kitchenStatusWithCount(String status, int count);

  /// No description provided for @kitchenOrderTitle.
  ///
  /// In en, this message translates to:
  /// **'Order #{id}'**
  String kitchenOrderTitle(String id);

  /// No description provided for @kitchenOrderMeta.
  ///
  /// In en, this message translates to:
  /// **'{source} • {time}'**
  String kitchenOrderMeta(String source, String time);

  /// No description provided for @kitchenDone.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get kitchenDone;

  /// No description provided for @kitchenTable12.
  ///
  /// In en, this message translates to:
  /// **'Table 12'**
  String get kitchenTable12;

  /// No description provided for @kitchenTable04.
  ///
  /// In en, this message translates to:
  /// **'Table 04'**
  String get kitchenTable04;

  /// No description provided for @kitchenUberEats.
  ///
  /// In en, this message translates to:
  /// **'UberEats'**
  String get kitchenUberEats;

  /// No description provided for @kitchenPickup.
  ///
  /// In en, this message translates to:
  /// **'Pickup'**
  String get kitchenPickup;

  /// No description provided for @kitchenWagyuBurger.
  ///
  /// In en, this message translates to:
  /// **'2x Wagyu Burger'**
  String get kitchenWagyuBurger;

  /// No description provided for @kitchenBurgerNote.
  ///
  /// In en, this message translates to:
  /// **'No onions, Extra cheese'**
  String get kitchenBurgerNote;

  /// No description provided for @kitchenTruffleFries.
  ///
  /// In en, this message translates to:
  /// **'1x Truffle Fries'**
  String get kitchenTruffleFries;

  /// No description provided for @kitchenMargheritaPizza.
  ///
  /// In en, this message translates to:
  /// **'1x Margherita Pizza'**
  String get kitchenMargheritaPizza;

  /// No description provided for @kitchenGardenSalad.
  ///
  /// In en, this message translates to:
  /// **'1x Garden Salad'**
  String get kitchenGardenSalad;

  /// No description provided for @kitchenCrispyTacos.
  ///
  /// In en, this message translates to:
  /// **'4x Crispy Tacos'**
  String get kitchenCrispyTacos;

  /// No description provided for @kitchenGuacamoleDip.
  ///
  /// In en, this message translates to:
  /// **'2x Guacamole Dip'**
  String get kitchenGuacamoleDip;

  /// No description provided for @kitchenRoastChicken.
  ///
  /// In en, this message translates to:
  /// **'1x Roast Chicken'**
  String get kitchenRoastChicken;

  /// No description provided for @kitchenMashedPotatoes.
  ///
  /// In en, this message translates to:
  /// **'1x Mashed Potatoes'**
  String get kitchenMashedPotatoes;

  /// No description provided for @prepTitle.
  ///
  /// In en, this message translates to:
  /// **'Order #{id} Prep'**
  String prepTitle(String id);

  /// No description provided for @prepPlated.
  ///
  /// In en, this message translates to:
  /// **'PLATED'**
  String get prepPlated;

  /// No description provided for @prepTable14.
  ///
  /// In en, this message translates to:
  /// **'Table 14'**
  String get prepTable14;

  /// No description provided for @prepGuestName.
  ///
  /// In en, this message translates to:
  /// **'Guest: Alexander Mercer'**
  String get prepGuestName;

  /// No description provided for @prepCovers.
  ///
  /// In en, this message translates to:
  /// **'4 Covers'**
  String get prepCovers;

  /// No description provided for @prepReceived.
  ///
  /// In en, this message translates to:
  /// **'Received 14:20'**
  String get prepReceived;

  /// No description provided for @prepOrderItems.
  ///
  /// In en, this message translates to:
  /// **'Order Items'**
  String get prepOrderItems;

  /// No description provided for @prepItemsTotal.
  ///
  /// In en, this message translates to:
  /// **'5 Items Total'**
  String get prepItemsTotal;

  /// No description provided for @prepQuantity.
  ///
  /// In en, this message translates to:
  /// **'{count}x'**
  String prepQuantity(int count);

  /// No description provided for @prepWagyuBurger.
  ///
  /// In en, this message translates to:
  /// **'Wagyu Burger'**
  String get prepWagyuBurger;

  /// No description provided for @prepNoOnions.
  ///
  /// In en, this message translates to:
  /// **'No onions'**
  String get prepNoOnions;

  /// No description provided for @prepBurgerSpecs.
  ///
  /// In en, this message translates to:
  /// **'Medium Rare • Brioche Bun • Extra Pickles'**
  String get prepBurgerSpecs;

  /// No description provided for @prepTruffleFries.
  ///
  /// In en, this message translates to:
  /// **'Truffle Fries'**
  String get prepTruffleFries;

  /// No description provided for @prepFriesSpecs.
  ///
  /// In en, this message translates to:
  /// **'Parmesan Dust • Rosemary Sprig • Truffle Aioli Side'**
  String get prepFriesSpecs;

  /// No description provided for @prepHouseCaesar.
  ///
  /// In en, this message translates to:
  /// **'House Caesar Salad'**
  String get prepHouseCaesar;

  /// No description provided for @prepCaesarSpecs.
  ///
  /// In en, this message translates to:
  /// **'Dressing on the side • No Anchovies'**
  String get prepCaesarSpecs;

  /// No description provided for @prepKitchenNotes.
  ///
  /// In en, this message translates to:
  /// **'Kitchen Notes'**
  String get prepKitchenNotes;

  /// No description provided for @prepKitchenNoteBody.
  ///
  /// In en, this message translates to:
  /// **'Birthday celebration at Table 14. Please ensure all plated dishes go out simultaneously. Guest in Seat 2 has a severe onion allergy; ensure strict cross-contamination protocol for the Wagyu Burgers.'**
  String get prepKitchenNoteBody;

  /// No description provided for @prepServer.
  ///
  /// In en, this message translates to:
  /// **'Server: David K.'**
  String get prepServer;

  /// No description provided for @prepUrgent.
  ///
  /// In en, this message translates to:
  /// **'Urgent'**
  String get prepUrgent;

  /// No description provided for @prepStages.
  ///
  /// In en, this message translates to:
  /// **'Preparation Stages'**
  String get prepStages;

  /// No description provided for @prepOrderReceived.
  ///
  /// In en, this message translates to:
  /// **'Order Received (14:20)'**
  String get prepOrderReceived;

  /// No description provided for @prepStarted.
  ///
  /// In en, this message translates to:
  /// **'Prep Started (14:22)'**
  String get prepStarted;

  /// No description provided for @prepAssemblyProgress.
  ///
  /// In en, this message translates to:
  /// **'Assembly In Progress'**
  String get prepAssemblyProgress;

  /// No description provided for @prepFinalPlating.
  ///
  /// In en, this message translates to:
  /// **'Final Plating'**
  String get prepFinalPlating;

  /// No description provided for @prepKitchenEfficiency.
  ///
  /// In en, this message translates to:
  /// **'Kitchen Efficiency'**
  String get prepKitchenEfficiency;

  /// No description provided for @prepSustainability.
  ///
  /// In en, this message translates to:
  /// **'94% Sustainability'**
  String get prepSustainability;

  /// No description provided for @prepBack.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get prepBack;

  /// No description provided for @prepIssue.
  ///
  /// In en, this message translates to:
  /// **'Issue'**
  String get prepIssue;

  /// No description provided for @prepProgress.
  ///
  /// In en, this message translates to:
  /// **'Progress'**
  String get prepProgress;

  /// No description provided for @prepItemsChecked.
  ///
  /// In en, this message translates to:
  /// **'{checked} / {total} Items Checked'**
  String prepItemsChecked(int checked, int total);

  /// No description provided for @prepMarkReady.
  ///
  /// In en, this message translates to:
  /// **'Mark as Ready'**
  String get prepMarkReady;

  /// No description provided for @kitchenView.
  ///
  /// In en, this message translates to:
  /// **'Kitchen View'**
  String get kitchenView;

  /// No description provided for @kitchenReadyHandover.
  ///
  /// In en, this message translates to:
  /// **'Ready for Handover'**
  String get kitchenReadyHandover;

  /// No description provided for @kitchenAllActive.
  ///
  /// In en, this message translates to:
  /// **'All Active'**
  String get kitchenAllActive;

  /// No description provided for @kitchenReadyCount.
  ///
  /// In en, this message translates to:
  /// **'Ready (12)'**
  String get kitchenReadyCount;

  /// No description provided for @kitchenPreparing.
  ///
  /// In en, this message translates to:
  /// **'Preparing'**
  String get kitchenPreparing;

  /// No description provided for @kitchenDelayed.
  ///
  /// In en, this message translates to:
  /// **'Delayed'**
  String get kitchenDelayed;

  /// No description provided for @kitchenAverageReadyTime.
  ///
  /// In en, this message translates to:
  /// **'Average Ready Time'**
  String get kitchenAverageReadyTime;

  /// No description provided for @kitchenReadyMinutes.
  ///
  /// In en, this message translates to:
  /// **'4:12 min'**
  String get kitchenReadyMinutes;

  /// No description provided for @kitchenHighestVolumeType.
  ///
  /// In en, this message translates to:
  /// **'Highest Volume Type'**
  String get kitchenHighestVolumeType;

  /// No description provided for @kitchenStationEfficiency.
  ///
  /// In en, this message translates to:
  /// **'Station Efficiency'**
  String get kitchenStationEfficiency;

  /// No description provided for @kitchenReadyTimer.
  ///
  /// In en, this message translates to:
  /// **'Ready {time}'**
  String kitchenReadyTimer(String time);

  /// No description provided for @kitchenOrd.
  ///
  /// In en, this message translates to:
  /// **'ORD #{id}'**
  String kitchenOrd(String id);

  /// No description provided for @kitchenSustainability.
  ///
  /// In en, this message translates to:
  /// **'Sustainability'**
  String get kitchenSustainability;

  /// No description provided for @kitchenExpressCounter.
  ///
  /// In en, this message translates to:
  /// **'Express Counter'**
  String get kitchenExpressCounter;

  /// No description provided for @kitchenGuestSarah.
  ///
  /// In en, this message translates to:
  /// **'Guest: Sarah W.'**
  String get kitchenGuestSarah;

  /// No description provided for @kitchenDoorDashJames.
  ///
  /// In en, this message translates to:
  /// **'DoorDash: James'**
  String get kitchenDoorDashJames;

  /// No description provided for @kitchenGuestMike.
  ///
  /// In en, this message translates to:
  /// **'Guest: Mike R.'**
  String get kitchenGuestMike;

  /// No description provided for @kitchenSignatureWagyuBurger.
  ///
  /// In en, this message translates to:
  /// **'Signature Wagyu Burger'**
  String get kitchenSignatureWagyuBurger;

  /// No description provided for @kitchenTruffleParmesanFries.
  ///
  /// In en, this message translates to:
  /// **'Truffle Parmesan Fries'**
  String get kitchenTruffleParmesanFries;

  /// No description provided for @kitchenIcedMatchaLatte.
  ///
  /// In en, this message translates to:
  /// **'Iced Matcha Latte'**
  String get kitchenIcedMatchaLatte;

  /// No description provided for @kitchenZeroWasteKaleBowl.
  ///
  /// In en, this message translates to:
  /// **'Zero-Waste Kale Bowl'**
  String get kitchenZeroWasteKaleBowl;

  /// No description provided for @kitchenRecycledPulpJuice.
  ///
  /// In en, this message translates to:
  /// **'Recycled Pulp Juice'**
  String get kitchenRecycledPulpJuice;

  /// No description provided for @kitchenCustomerWaiting.
  ///
  /// In en, this message translates to:
  /// **'Customer waiting over 15m'**
  String get kitchenCustomerWaiting;

  /// No description provided for @kitchenMediterraneanPlate.
  ///
  /// In en, this message translates to:
  /// **'Mediterranean Plate'**
  String get kitchenMediterraneanPlate;

  /// No description provided for @kitchenExtraPitaSide.
  ///
  /// In en, this message translates to:
  /// **'Extra Pita Side'**
  String get kitchenExtraPitaSide;

  /// No description provided for @kitchenCrispyChickenSando.
  ///
  /// In en, this message translates to:
  /// **'Crispy Chicken Sando'**
  String get kitchenCrispyChickenSando;

  /// No description provided for @kitchenSpicyRamenCombo.
  ///
  /// In en, this message translates to:
  /// **'Spicy Ramen Combo'**
  String get kitchenSpicyRamenCombo;

  /// No description provided for @kitchenGardenFreshSalad.
  ///
  /// In en, this message translates to:
  /// **'Garden Fresh Salad'**
  String get kitchenGardenFreshSalad;

  /// No description provided for @kitchenSpicedTofuTacos.
  ///
  /// In en, this message translates to:
  /// **'Spiced Tofu Tacos'**
  String get kitchenSpicedTofuTacos;

  /// No description provided for @kitchenRoastedCornDip.
  ///
  /// In en, this message translates to:
  /// **'Roasted Corn Dip'**
  String get kitchenRoastedCornDip;

  /// No description provided for @kitchenHandoverServer.
  ///
  /// In en, this message translates to:
  /// **'Handover to Server'**
  String get kitchenHandoverServer;

  /// No description provided for @kitchenHandoverNow.
  ///
  /// In en, this message translates to:
  /// **'Handover Now'**
  String get kitchenHandoverNow;

  /// No description provided for @kitchenHandoverGuest.
  ///
  /// In en, this message translates to:
  /// **'Handover to Guest'**
  String get kitchenHandoverGuest;

  /// No description provided for @kitchenHandoverCourier.
  ///
  /// In en, this message translates to:
  /// **'Handover to Courier'**
  String get kitchenHandoverCourier;

  /// No description provided for @languageWelcomeTitle.
  ///
  /// In en, this message translates to:
  /// **'Choose Your Language'**
  String get languageWelcomeTitle;

  /// No description provided for @languageWelcomeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Ayletna. Please select your preferred language to continue.'**
  String get languageWelcomeSubtitle;

  /// No description provided for @languageEnglishSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Western Interface'**
  String get languageEnglishSubtitle;

  /// No description provided for @languageArabicSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Arabic Interface'**
  String get languageArabicSubtitle;

  /// No description provided for @languageAccessGateway.
  ///
  /// In en, this message translates to:
  /// **'Universal Access Gateway'**
  String get languageAccessGateway;

  /// No description provided for @loginWelcomeBack.
  ///
  /// In en, this message translates to:
  /// **'Welcome back'**
  String get loginWelcomeBack;

  /// No description provided for @loginOperationalSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome back to Ayletna'**
  String get loginOperationalSubtitle;

  /// No description provided for @loginPhoneOrEmail.
  ///
  /// In en, this message translates to:
  /// **'Phone or Email'**
  String get loginPhoneOrEmail;

  /// No description provided for @loginEmailHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. guest@ayletna.com'**
  String get loginEmailHint;

  /// No description provided for @loginAction.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get loginAction;

  /// No description provided for @loginOr.
  ///
  /// In en, this message translates to:
  /// **'or'**
  String get loginOr;

  /// No description provided for @loginDemoHubTitle.
  ///
  /// In en, this message translates to:
  /// **'Staff hubs'**
  String get loginDemoHubTitle;

  /// No description provided for @loginDemoHubSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Sign in with a management or specialist role.'**
  String get loginDemoHubSubtitle;

  /// No description provided for @loginContinueGuest.
  ///
  /// In en, this message translates to:
  /// **'Continue as Guest'**
  String get loginContinueGuest;

  /// No description provided for @loginNoAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get loginNoAccount;

  /// No description provided for @loginTrustSecure.
  ///
  /// In en, this message translates to:
  /// **'Secure'**
  String get loginTrustSecure;

  /// No description provided for @loginTrustCloudSync.
  ///
  /// In en, this message translates to:
  /// **'Fresh favorites'**
  String get loginTrustCloudSync;

  /// No description provided for @loginTrustSupport.
  ///
  /// In en, this message translates to:
  /// **'Guest care'**
  String get loginTrustSupport;

  /// No description provided for @loginPasswordHint.
  ///
  /// In en, this message translates to:
  /// **'••••••••'**
  String get loginPasswordHint;

  /// No description provided for @loyaltyTitle.
  ///
  /// In en, this message translates to:
  /// **'Loyalty & Rewards'**
  String get loyaltyTitle;

  /// No description provided for @loyaltySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Savor every bite, collect every point.'**
  String get loyaltySubtitle;

  /// No description provided for @loyaltyGoldMember.
  ///
  /// In en, this message translates to:
  /// **'Gold Member'**
  String get loyaltyGoldMember;

  /// No description provided for @loyaltySavorPoints.
  ///
  /// In en, this message translates to:
  /// **'Savor Points'**
  String get loyaltySavorPoints;

  /// No description provided for @loyaltyLifetimePoints.
  ///
  /// In en, this message translates to:
  /// **'Lifetime Points'**
  String get loyaltyLifetimePoints;

  /// No description provided for @loyaltyNextTier.
  ///
  /// In en, this message translates to:
  /// **'Next Tier: Platinum'**
  String get loyaltyNextTier;

  /// No description provided for @loyaltyEarnMore.
  ///
  /// In en, this message translates to:
  /// **'Earn 550 more points to unlock'**
  String get loyaltyEarnMore;

  /// No description provided for @loyaltyProgressPercent.
  ///
  /// In en, this message translates to:
  /// **'82%'**
  String get loyaltyProgressPercent;

  /// No description provided for @loyaltyCurrentGold.
  ///
  /// In en, this message translates to:
  /// **'Current: Gold'**
  String get loyaltyCurrentGold;

  /// No description provided for @loyaltyGoalPoints.
  ///
  /// In en, this message translates to:
  /// **'Goal: 3,000 pts'**
  String get loyaltyGoalPoints;

  /// No description provided for @loyaltyGoldPerks.
  ///
  /// In en, this message translates to:
  /// **'Gold Perks'**
  String get loyaltyGoldPerks;

  /// No description provided for @loyaltyPerkMultiplier.
  ///
  /// In en, this message translates to:
  /// **'1.5x points on every order'**
  String get loyaltyPerkMultiplier;

  /// No description provided for @loyaltyPerkPriority.
  ///
  /// In en, this message translates to:
  /// **'Priority reservation booking'**
  String get loyaltyPerkPriority;

  /// No description provided for @loyaltyPerkDessert.
  ///
  /// In en, this message translates to:
  /// **'Complimentary birthday dessert'**
  String get loyaltyPerkDessert;

  /// No description provided for @loyaltyExplorePlatinum.
  ///
  /// In en, this message translates to:
  /// **'Explore Platinum Perks'**
  String get loyaltyExplorePlatinum;

  /// No description provided for @loyaltyAvailableRewards.
  ///
  /// In en, this message translates to:
  /// **'Available Rewards'**
  String get loyaltyAvailableRewards;

  /// No description provided for @loyaltyFilter.
  ///
  /// In en, this message translates to:
  /// **'Filter'**
  String get loyaltyFilter;

  /// No description provided for @loyaltySort.
  ///
  /// In en, this message translates to:
  /// **'Sort'**
  String get loyaltySort;

  /// No description provided for @loyaltyPopular.
  ///
  /// In en, this message translates to:
  /// **'Popular'**
  String get loyaltyPopular;

  /// No description provided for @loyaltyRedeem.
  ///
  /// In en, this message translates to:
  /// **'Redeem'**
  String get loyaltyRedeem;

  /// No description provided for @loyaltyNoRewardsInFilter.
  ///
  /// In en, this message translates to:
  /// **'No rewards in this filter right now.'**
  String get loyaltyNoRewardsInFilter;

  /// No description provided for @loyaltyLocked.
  ///
  /// In en, this message translates to:
  /// **'Locked'**
  String get loyaltyLocked;

  /// No description provided for @loyaltySignaturePlatter.
  ///
  /// In en, this message translates to:
  /// **'Signature BBQ Platter'**
  String get loyaltySignaturePlatter;

  /// No description provided for @loyaltySignaturePlatterDesc.
  ///
  /// In en, this message translates to:
  /// **'Redeem for a full grill platter with three sides.'**
  String get loyaltySignaturePlatterDesc;

  /// No description provided for @loyaltyLargePizza.
  ///
  /// In en, this message translates to:
  /// **'Any Large Pizza'**
  String get loyaltyLargePizza;

  /// No description provided for @loyaltyLargePizzaDesc.
  ///
  /// In en, this message translates to:
  /// **'Choose any large flatbread from our family oven menu.'**
  String get loyaltyLargePizzaDesc;

  /// No description provided for @loyaltyFreeDessert.
  ///
  /// In en, this message translates to:
  /// **'Free Dessert'**
  String get loyaltyFreeDessert;

  /// No description provided for @loyaltyFreeDessertDesc.
  ///
  /// In en, this message translates to:
  /// **'A sweet treat from our pastry chef\'s daily selection.'**
  String get loyaltyFreeDessertDesc;

  /// No description provided for @loyaltyChefTasting.
  ///
  /// In en, this message translates to:
  /// **'Chef\'s Tasting for Two'**
  String get loyaltyChefTasting;

  /// No description provided for @loyaltyChefTastingDesc.
  ///
  /// In en, this message translates to:
  /// **'Private tasting experience curated by our executive chef.'**
  String get loyaltyChefTastingDesc;

  /// No description provided for @loyaltyPointsShort.
  ///
  /// In en, this message translates to:
  /// **'{points} pts'**
  String loyaltyPointsShort(String points);

  /// No description provided for @loyaltyDine.
  ///
  /// In en, this message translates to:
  /// **'Dine'**
  String get loyaltyDine;

  /// No description provided for @loyaltyDineDesc.
  ///
  /// In en, this message translates to:
  /// **'Earn 10 points for every 1 JOD spent at any Ayletna branch.'**
  String get loyaltyDineDesc;

  /// No description provided for @loyaltyCollect.
  ///
  /// In en, this message translates to:
  /// **'Collect'**
  String get loyaltyCollect;

  /// No description provided for @loyaltyCollectDesc.
  ///
  /// In en, this message translates to:
  /// **'Watch your points grow and unlock premium tier benefits.'**
  String get loyaltyCollectDesc;

  /// No description provided for @loyaltyEnjoy.
  ///
  /// In en, this message translates to:
  /// **'Enjoy'**
  String get loyaltyEnjoy;

  /// No description provided for @loyaltyEnjoyDesc.
  ///
  /// In en, this message translates to:
  /// **'Redeem your hard-earned points for exclusive rewards.'**
  String get loyaltyEnjoyDesc;

  /// No description provided for @mapSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search for your delivery address...'**
  String get mapSearchHint;

  /// No description provided for @mapSearchValue.
  ///
  /// In en, this message translates to:
  /// **'123 Gastronomy Lane, Suite 400'**
  String get mapSearchValue;

  /// No description provided for @mapDeliveryPin.
  ///
  /// In en, this message translates to:
  /// **'Delivery Pin'**
  String get mapDeliveryPin;

  /// No description provided for @mapConfirmLocation.
  ///
  /// In en, this message translates to:
  /// **'Confirm Location'**
  String get mapConfirmLocation;

  /// No description provided for @mapSelectedAddress.
  ///
  /// In en, this message translates to:
  /// **'123 Gastronomy Lane, Central Hub, Amman'**
  String get mapSelectedAddress;

  /// No description provided for @mapAddNote.
  ///
  /// In en, this message translates to:
  /// **'Add Note'**
  String get mapAddNote;

  /// No description provided for @mapConfirmContinue.
  ///
  /// In en, this message translates to:
  /// **'Confirm & Continue'**
  String get mapConfirmContinue;

  /// No description provided for @mapQuickHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get mapQuickHome;

  /// No description provided for @mapQuickOffice.
  ///
  /// In en, this message translates to:
  /// **'Office'**
  String get mapQuickOffice;

  /// No description provided for @mapQuickRecent.
  ///
  /// In en, this message translates to:
  /// **'Recent'**
  String get mapQuickRecent;

  /// No description provided for @menuManagementTitle.
  ///
  /// In en, this message translates to:
  /// **'Menu Management'**
  String get menuManagementTitle;

  /// No description provided for @menuManagementSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Manage your digital menu items, pricing, and live availability.'**
  String get menuManagementSubtitle;

  /// No description provided for @menuAddNewItem.
  ///
  /// In en, this message translates to:
  /// **'Add New Item'**
  String get menuAddNewItem;

  /// No description provided for @menuBulkImport.
  ///
  /// In en, this message translates to:
  /// **'Bulk Import'**
  String get menuBulkImport;

  /// No description provided for @menuTotalItems.
  ///
  /// In en, this message translates to:
  /// **'Total Items'**
  String get menuTotalItems;

  /// No description provided for @menuTotalItemsDelta.
  ///
  /// In en, this message translates to:
  /// **'▲ 4 this month'**
  String get menuTotalItemsDelta;

  /// No description provided for @menuActiveNow.
  ///
  /// In en, this message translates to:
  /// **'Active Now'**
  String get menuActiveNow;

  /// No description provided for @menuInactiveCount.
  ///
  /// In en, this message translates to:
  /// **'6 inactive'**
  String get menuInactiveCount;

  /// No description provided for @menuOutOfStock.
  ///
  /// In en, this message translates to:
  /// **'Out of Stock'**
  String get menuOutOfStock;

  /// No description provided for @menuActionRequired.
  ///
  /// In en, this message translates to:
  /// **'Action required'**
  String get menuActionRequired;

  /// No description provided for @menuAvgPrice.
  ///
  /// In en, this message translates to:
  /// **'Avg. Price'**
  String get menuAvgPrice;

  /// No description provided for @menuMarketStable.
  ///
  /// In en, this message translates to:
  /// **'Market stable'**
  String get menuMarketStable;

  /// No description provided for @menuAllCategories.
  ///
  /// In en, this message translates to:
  /// **'All Categories'**
  String get menuAllCategories;

  /// No description provided for @menuMainCourse.
  ///
  /// In en, this message translates to:
  /// **'Main Course'**
  String get menuMainCourse;

  /// No description provided for @menuAppetizers.
  ///
  /// In en, this message translates to:
  /// **'Appetizers'**
  String get menuAppetizers;

  /// No description provided for @menuBeverages.
  ///
  /// In en, this message translates to:
  /// **'Beverages'**
  String get menuBeverages;

  /// No description provided for @menuDesserts.
  ///
  /// In en, this message translates to:
  /// **'Desserts'**
  String get menuDesserts;

  /// No description provided for @menuSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search menu items...'**
  String get menuSearchHint;

  /// No description provided for @menuInStock.
  ///
  /// In en, this message translates to:
  /// **'In Stock'**
  String get menuInStock;

  /// No description provided for @menuLowStock.
  ///
  /// In en, this message translates to:
  /// **'Low Stock (8)'**
  String get menuLowStock;

  /// No description provided for @menuOutOfStockLabel.
  ///
  /// In en, this message translates to:
  /// **'Out of Stock'**
  String get menuOutOfStockLabel;

  /// No description provided for @menuActive.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get menuActive;

  /// No description provided for @menuInactive.
  ///
  /// In en, this message translates to:
  /// **'Inactive'**
  String get menuInactive;

  /// No description provided for @menuDineIn.
  ///
  /// In en, this message translates to:
  /// **'Dine-in'**
  String get menuDineIn;

  /// No description provided for @menuTakeaway.
  ///
  /// In en, this message translates to:
  /// **'Takeaway'**
  String get menuTakeaway;

  /// No description provided for @menuDelivery.
  ///
  /// In en, this message translates to:
  /// **'Delivery'**
  String get menuDelivery;

  /// No description provided for @menuGrilledChickenSalad.
  ///
  /// In en, this message translates to:
  /// **'Grilled Chicken Salad'**
  String get menuGrilledChickenSalad;

  /// No description provided for @menuGrilledChickenSaladDesc.
  ///
  /// In en, this message translates to:
  /// **'Main Course • Organic Greens'**
  String get menuGrilledChickenSaladDesc;

  /// No description provided for @menuSignatureBurger.
  ///
  /// In en, this message translates to:
  /// **'Ayletna Signature Burger'**
  String get menuSignatureBurger;

  /// No description provided for @menuSignatureBurgerDesc.
  ///
  /// In en, this message translates to:
  /// **'Main Course • Beef Burger'**
  String get menuSignatureBurgerDesc;

  /// No description provided for @menuTruffleFries.
  ///
  /// In en, this message translates to:
  /// **'Hand-cut Truffle Fries'**
  String get menuTruffleFries;

  /// No description provided for @menuTruffleFriesDesc.
  ///
  /// In en, this message translates to:
  /// **'Appetizer • Truffle Oil'**
  String get menuTruffleFriesDesc;

  /// No description provided for @actionEdit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get actionEdit;

  /// No description provided for @actionRemove.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get actionRemove;

  /// No description provided for @actionApply.
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get actionApply;

  /// No description provided for @cartOrderItemsCount.
  ///
  /// In en, this message translates to:
  /// **'Order Items ({count})'**
  String cartOrderItemsCount(int count);

  /// No description provided for @cartClearAll.
  ///
  /// In en, this message translates to:
  /// **'Clear All'**
  String get cartClearAll;

  /// No description provided for @cartPromoCode.
  ///
  /// In en, this message translates to:
  /// **'Promo Code'**
  String get cartPromoCode;

  /// No description provided for @cartPromoHint.
  ///
  /// In en, this message translates to:
  /// **'Enter code'**
  String get cartPromoHint;

  /// No description provided for @cartYourCartTitle.
  ///
  /// In en, this message translates to:
  /// **'Your Cart'**
  String get cartYourCartTitle;

  /// No description provided for @cartReviewSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Review your items before placing the order.'**
  String get cartReviewSubtitle;

  /// No description provided for @cartOrderSummary.
  ///
  /// In en, this message translates to:
  /// **'Order Summary'**
  String get cartOrderSummary;

  /// No description provided for @cartFulfillment.
  ///
  /// In en, this message translates to:
  /// **'Fulfillment'**
  String get cartFulfillment;

  /// No description provided for @cartSubtotal.
  ///
  /// In en, this message translates to:
  /// **'Subtotal'**
  String get cartSubtotal;

  /// No description provided for @cartFree.
  ///
  /// In en, this message translates to:
  /// **'Free'**
  String get cartFree;

  /// No description provided for @cartDineInServiceFee.
  ///
  /// In en, this message translates to:
  /// **'Dine-in service fee'**
  String get cartDineInServiceFee;

  /// No description provided for @cartTakeawayPackagingFee.
  ///
  /// In en, this message translates to:
  /// **'Takeaway packaging fee'**
  String get cartTakeawayPackagingFee;

  /// No description provided for @cartDeliveryFee.
  ///
  /// In en, this message translates to:
  /// **'Delivery fee'**
  String get cartDeliveryFee;

  /// No description provided for @cartGroupDeliveryFee.
  ///
  /// In en, this message translates to:
  /// **'Group delivery fee'**
  String get cartGroupDeliveryFee;

  /// No description provided for @cartPlatedDeposit.
  ///
  /// In en, this message translates to:
  /// **'Reusable tray deposit'**
  String get cartPlatedDeposit;

  /// No description provided for @cartEstimatedTax.
  ///
  /// In en, this message translates to:
  /// **'Estimated Tax (5%)'**
  String get cartEstimatedTax;

  /// No description provided for @cartTotal.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get cartTotal;

  /// No description provided for @cartApproxUsd.
  ///
  /// In en, this message translates to:
  /// **'approx. \$30.73 USD'**
  String get cartApproxUsd;

  /// No description provided for @cartProceedCheckout.
  ///
  /// In en, this message translates to:
  /// **'Proceed to Checkout'**
  String get cartProceedCheckout;

  /// No description provided for @cartGuestSignInPrompt.
  ///
  /// In en, this message translates to:
  /// **'Sign in to place your order and track delivery in real time.'**
  String get cartGuestSignInPrompt;

  /// No description provided for @cartCheckoutStepBasket.
  ///
  /// In en, this message translates to:
  /// **'Basket'**
  String get cartCheckoutStepBasket;

  /// No description provided for @cartCheckoutStepFulfillment.
  ///
  /// In en, this message translates to:
  /// **'Fulfillment'**
  String get cartCheckoutStepFulfillment;

  /// No description provided for @cartCheckoutStepPayment.
  ///
  /// In en, this message translates to:
  /// **'Payment'**
  String get cartCheckoutStepPayment;

  /// No description provided for @cartCheckoutStepReview.
  ///
  /// In en, this message translates to:
  /// **'Review'**
  String get cartCheckoutStepReview;

  /// No description provided for @demoModeBanner.
  ///
  /// In en, this message translates to:
  /// **'Action completed.'**
  String get demoModeBanner;

  /// No description provided for @cartTermsNotice.
  ///
  /// In en, this message translates to:
  /// **'By clicking, you agree to our Terms of Service.'**
  String get cartTermsNotice;

  /// No description provided for @cartViewItems.
  ///
  /// In en, this message translates to:
  /// **'View items'**
  String get cartViewItems;

  /// No description provided for @cartFulfillmentTitle.
  ///
  /// In en, this message translates to:
  /// **'Choose fulfillment'**
  String get cartFulfillmentTitle;

  /// No description provided for @cartFulfillmentSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Choose the service method directly in the cart without opening a separate screen.'**
  String get cartFulfillmentSubtitle;

  /// No description provided for @cartGroupDeliveryTitle.
  ///
  /// In en, this message translates to:
  /// **'Group delivery'**
  String get cartGroupDeliveryTitle;

  /// No description provided for @cartGroupDeliveryBody.
  ///
  /// In en, this message translates to:
  /// **'Wait for a nearby order in the same area to reduce delivery cost and improve route efficiency.'**
  String get cartGroupDeliveryBody;

  /// No description provided for @cartTermsAndConditions.
  ///
  /// In en, this message translates to:
  /// **'Terms and conditions'**
  String get cartTermsAndConditions;

  /// No description provided for @cartSelectedAddress.
  ///
  /// In en, this message translates to:
  /// **'Selected address'**
  String get cartSelectedAddress;

  /// No description provided for @cartAddressRequired.
  ///
  /// In en, this message translates to:
  /// **'Choose a default delivery address before checkout.'**
  String get cartAddressRequired;

  /// No description provided for @cartChooseAddress.
  ///
  /// In en, this message translates to:
  /// **'Choose address'**
  String get cartChooseAddress;

  /// No description provided for @cartPaymentType.
  ///
  /// In en, this message translates to:
  /// **'Payment type'**
  String get cartPaymentType;

  /// No description provided for @cartTipTitle.
  ///
  /// In en, this message translates to:
  /// **'Add a tip'**
  String get cartTipTitle;

  /// No description provided for @cartTipSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Optional appreciation for the kitchen and delivery team.'**
  String get cartTipSubtitle;

  /// No description provided for @cartNoTip.
  ///
  /// In en, this message translates to:
  /// **'No tip'**
  String get cartNoTip;

  /// No description provided for @cartHelpTitle.
  ///
  /// In en, this message translates to:
  /// **'Need help with your order?'**
  String get cartHelpTitle;

  /// No description provided for @cartChatWithUs.
  ///
  /// In en, this message translates to:
  /// **'Chat with us'**
  String get cartChatWithUs;

  /// No description provided for @supportHeroTitle.
  ///
  /// In en, this message translates to:
  /// **'How can we help?'**
  String get supportHeroTitle;

  /// No description provided for @supportHeroBody.
  ///
  /// In en, this message translates to:
  /// **'Choose the fastest support channel for order questions, delivery updates, or payment help.'**
  String get supportHeroBody;

  /// No description provided for @supportLiveChatTitle.
  ///
  /// In en, this message translates to:
  /// **'Live chat'**
  String get supportLiveChatTitle;

  /// No description provided for @supportLiveChatBody.
  ///
  /// In en, this message translates to:
  /// **'Start a quick conversation with the service team.'**
  String get supportLiveChatBody;

  /// No description provided for @supportCallTitle.
  ///
  /// In en, this message translates to:
  /// **'Call restaurant'**
  String get supportCallTitle;

  /// No description provided for @supportCallBody.
  ///
  /// In en, this message translates to:
  /// **'Speak with the front desk about urgent order changes.'**
  String get supportCallBody;

  /// No description provided for @supportWhatsappTitle.
  ///
  /// In en, this message translates to:
  /// **'WhatsApp support'**
  String get supportWhatsappTitle;

  /// No description provided for @supportWhatsappBody.
  ///
  /// In en, this message translates to:
  /// **'Send a message with your order details and preferred contact time.'**
  String get supportWhatsappBody;

  /// No description provided for @supportOrderHelpTitle.
  ///
  /// In en, this message translates to:
  /// **'Order help'**
  String get supportOrderHelpTitle;

  /// No description provided for @supportOrderHelpBody.
  ///
  /// In en, this message translates to:
  /// **'Use this page for cart, delivery, payment, and plated-return questions.'**
  String get supportOrderHelpBody;

  /// No description provided for @supportFaqTitle.
  ///
  /// In en, this message translates to:
  /// **'FAQ'**
  String get supportFaqTitle;

  /// No description provided for @supportFaqBody.
  ///
  /// In en, this message translates to:
  /// **'Browse common delivery, payment, and plated-return answers.'**
  String get supportFaqBody;

  /// No description provided for @supportTicketsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Track open and resolved support requests.'**
  String get supportTicketsSubtitle;

  /// No description provided for @supportTicketRequestFollowUp.
  ///
  /// In en, this message translates to:
  /// **'Request follow-up'**
  String get supportTicketRequestFollowUp;

  /// No description provided for @supportTicketCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel ticket'**
  String get supportTicketCancel;

  /// No description provided for @supportTicketUrgent.
  ///
  /// In en, this message translates to:
  /// **'Mark urgent'**
  String get supportTicketUrgent;

  /// No description provided for @supportTicketActionSent.
  ///
  /// In en, this message translates to:
  /// **'Ticket action sent.'**
  String get supportTicketActionSent;

  /// No description provided for @supportTicketRateResponse.
  ///
  /// In en, this message translates to:
  /// **'Rate this response'**
  String get supportTicketRateResponse;

  /// No description provided for @supportTicketRemarkLabel.
  ///
  /// In en, this message translates to:
  /// **'Response remark'**
  String get supportTicketRemarkLabel;

  /// No description provided for @supportTicketRemarkHint.
  ///
  /// In en, this message translates to:
  /// **'Write a note about the support response...'**
  String get supportTicketRemarkHint;

  /// No description provided for @supportTicketSubmitRating.
  ///
  /// In en, this message translates to:
  /// **'Submit rating'**
  String get supportTicketSubmitRating;

  /// No description provided for @supportTicketRatingSaved.
  ///
  /// In en, this message translates to:
  /// **'Ticket rating saved.'**
  String get supportTicketRatingSaved;

  /// No description provided for @supportNewTicketTitle.
  ///
  /// In en, this message translates to:
  /// **'Live chat ticket'**
  String get supportNewTicketTitle;

  /// No description provided for @supportNewTicketBody.
  ///
  /// In en, this message translates to:
  /// **'A new chat session was opened with the customer care team.'**
  String get supportNewTicketBody;

  /// No description provided for @supportTicketOpened.
  ///
  /// In en, this message translates to:
  /// **'New support ticket opened.'**
  String get supportTicketOpened;

  /// No description provided for @supportChatHeroTitle.
  ///
  /// In en, this message translates to:
  /// **'Live support chat'**
  String get supportChatHeroTitle;

  /// No description provided for @supportChatHeroBody.
  ///
  /// In en, this message translates to:
  /// **'The agent starts with chat and opens a ticket only when follow-up is needed.'**
  String get supportChatHeroBody;

  /// No description provided for @supportChatActiveSession.
  ///
  /// In en, this message translates to:
  /// **'Active chat session'**
  String get supportChatActiveSession;

  /// No description provided for @supportChatNoTicketYet.
  ///
  /// In en, this message translates to:
  /// **'No ticket opened yet'**
  String get supportChatNoTicketYet;

  /// No description provided for @supportChatAgentGreeting.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Ayletna support. Tell me what happened and I will check if this needs a ticket.'**
  String get supportChatAgentGreeting;

  /// No description provided for @supportChatCustomerSample.
  ///
  /// In en, this message translates to:
  /// **'I need help with my active order.'**
  String get supportChatCustomerSample;

  /// No description provided for @supportChatAgentDecision.
  ///
  /// In en, this message translates to:
  /// **'I can help here first. If the issue needs restaurant follow-up, I will open a ticket and keep it visible in Support.'**
  String get supportChatAgentDecision;

  /// No description provided for @supportChatAgentName.
  ///
  /// In en, this message translates to:
  /// **'Ayletna Agent'**
  String get supportChatAgentName;

  /// No description provided for @supportChatCustomerName.
  ///
  /// In en, this message translates to:
  /// **'You'**
  String get supportChatCustomerName;

  /// No description provided for @supportChatAgentTicketNote.
  ///
  /// In en, this message translates to:
  /// **'Only the support agent can open a follow-up ticket after reviewing the chat.'**
  String get supportChatAgentTicketNote;

  /// No description provided for @supportChatMessageLabel.
  ///
  /// In en, this message translates to:
  /// **'Message'**
  String get supportChatMessageLabel;

  /// No description provided for @supportChatMessageHint.
  ///
  /// In en, this message translates to:
  /// **'Write your question or order note...'**
  String get supportChatMessageHint;

  /// No description provided for @supportChatSend.
  ///
  /// In en, this message translates to:
  /// **'Send message'**
  String get supportChatSend;

  /// No description provided for @supportChatOpenTicket.
  ///
  /// In en, this message translates to:
  /// **'Open ticket if needed'**
  String get supportChatOpenTicket;

  /// No description provided for @supportAdminSetupNote.
  ///
  /// In en, this message translates to:
  /// **'Restaurant phone and WhatsApp numbers can be edited from admin settings.'**
  String get supportAdminSetupNote;

  /// No description provided for @supportExternalActionFallback.
  ///
  /// In en, this message translates to:
  /// **'Could not open this action. Use the displayed contact details.'**
  String get supportExternalActionFallback;

  /// No description provided for @screenFaq.
  ///
  /// In en, this message translates to:
  /// **'FAQ'**
  String get screenFaq;

  /// No description provided for @faqHeroTitle.
  ///
  /// In en, this message translates to:
  /// **'Frequently asked questions'**
  String get faqHeroTitle;

  /// No description provided for @faqHeroBody.
  ///
  /// In en, this message translates to:
  /// **'Quick answers before opening a support ticket.'**
  String get faqHeroBody;

  /// No description provided for @faqDeliveryTitle.
  ///
  /// In en, this message translates to:
  /// **'How do delivery updates work?'**
  String get faqDeliveryTitle;

  /// No description provided for @faqDeliveryBody.
  ///
  /// In en, this message translates to:
  /// **'Active orders show a timeline. When the order is on the way, the driver contact button becomes available.'**
  String get faqDeliveryBody;

  /// No description provided for @faqPaymentTitle.
  ///
  /// In en, this message translates to:
  /// **'Which payment methods are supported?'**
  String get faqPaymentTitle;

  /// No description provided for @faqPaymentBody.
  ///
  /// In en, this message translates to:
  /// **'Checkout supports card and cash payment methods.'**
  String get faqPaymentBody;

  /// No description provided for @faqPlatedTitle.
  ///
  /// In en, this message translates to:
  /// **'How does plated delivery work?'**
  String get faqPlatedTitle;

  /// No description provided for @faqPlatedBody.
  ///
  /// In en, this message translates to:
  /// **'Reusable trays include a refundable deposit and follow the plated-return reminder flow.'**
  String get faqPlatedBody;

  /// No description provided for @cartMargheritaPremium.
  ///
  /// In en, this message translates to:
  /// **'Margherita Premium'**
  String get cartMargheritaPremium;

  /// No description provided for @cartMargheritaPremiumDesc.
  ///
  /// In en, this message translates to:
  /// **'Extra Buffalo Mozzarella, Fresh Basil'**
  String get cartMargheritaPremiumDesc;

  /// No description provided for @cartFreshOrangeJuice.
  ///
  /// In en, this message translates to:
  /// **'Fresh Orange Juice'**
  String get cartFreshOrangeJuice;

  /// No description provided for @cartFreshOrangeJuiceDesc.
  ///
  /// In en, this message translates to:
  /// **'Chilled, No Sugar Added'**
  String get cartFreshOrangeJuiceDesc;

  /// No description provided for @cartChocoLavaDelight.
  ///
  /// In en, this message translates to:
  /// **'Choco Lava Delight'**
  String get cartChocoLavaDelight;

  /// No description provided for @cartChocoLavaDelightDesc.
  ///
  /// In en, this message translates to:
  /// **'With Vanilla Bean Gelato'**
  String get cartChocoLavaDelightDesc;

  /// No description provided for @orderHistoryTitle.
  ///
  /// In en, this message translates to:
  /// **'Order History'**
  String get orderHistoryTitle;

  /// No description provided for @orderHistorySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Manage your past dining experiences and re-order your favorites.'**
  String get orderHistorySubtitle;

  /// No description provided for @orderHistoryFilter.
  ///
  /// In en, this message translates to:
  /// **'Filter'**
  String get orderHistoryFilter;

  /// No description provided for @orderHistoryLast30Days.
  ///
  /// In en, this message translates to:
  /// **'Last 30 Days'**
  String get orderHistoryLast30Days;

  /// No description provided for @orderHistoryInsights.
  ///
  /// In en, this message translates to:
  /// **'Insights'**
  String get orderHistoryInsights;

  /// No description provided for @orderHistoryTotalOrders.
  ///
  /// In en, this message translates to:
  /// **'Total Orders'**
  String get orderHistoryTotalOrders;

  /// No description provided for @orderHistoryTotalSpent.
  ///
  /// In en, this message translates to:
  /// **'Total Spent (JOD)'**
  String get orderHistoryTotalSpent;

  /// No description provided for @orderHistoryQuote.
  ///
  /// In en, this message translates to:
  /// **'\"Taste the consistency in every order.\"'**
  String get orderHistoryQuote;

  /// No description provided for @orderHistoryWeekendSpecial.
  ///
  /// In en, this message translates to:
  /// **'Weekend Special'**
  String get orderHistoryWeekendSpecial;

  /// No description provided for @orderHistoryWeekendSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Get 15% off on your next re-order.'**
  String get orderHistoryWeekendSubtitle;

  /// No description provided for @orderHistoryActive.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get orderHistoryActive;

  /// No description provided for @orderHistoryViewStatus.
  ///
  /// In en, this message translates to:
  /// **'View status'**
  String get orderHistoryViewStatus;

  /// No description provided for @orderHistoryProgressTitle.
  ///
  /// In en, this message translates to:
  /// **'Order progress'**
  String get orderHistoryProgressTitle;

  /// No description provided for @orderHistoryCurrentStep.
  ///
  /// In en, this message translates to:
  /// **'Current step'**
  String get orderHistoryCurrentStep;

  /// No description provided for @orderHistoryDoneStep.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get orderHistoryDoneStep;

  /// No description provided for @orderHistoryRemainingStep.
  ///
  /// In en, this message translates to:
  /// **'Remaining'**
  String get orderHistoryRemainingStep;

  /// No description provided for @orderHistoryStepCounter.
  ///
  /// In en, this message translates to:
  /// **'Step {current} of {total}'**
  String orderHistoryStepCounter(String current, String total);

  /// No description provided for @orderHistoryStatusUpdated.
  ///
  /// In en, this message translates to:
  /// **'Active order status updated.'**
  String get orderHistoryStatusUpdated;

  /// No description provided for @orderHistoryDriverContactTitle.
  ///
  /// In en, this message translates to:
  /// **'Driver contact'**
  String get orderHistoryDriverContactTitle;

  /// No description provided for @orderHistoryDriverContactBody.
  ///
  /// In en, this message translates to:
  /// **'Your order is on the way. Call the driver if you need to coordinate delivery.'**
  String get orderHistoryDriverContactBody;

  /// No description provided for @orderHistoryCallDriver.
  ///
  /// In en, this message translates to:
  /// **'Call driver'**
  String get orderHistoryCallDriver;

  /// No description provided for @orderHistoryCompleted.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get orderHistoryCompleted;

  /// No description provided for @orderHistoryCancelled.
  ///
  /// In en, this message translates to:
  /// **'Cancelled'**
  String get orderHistoryCancelled;

  /// No description provided for @orderHistoryViewInvoice.
  ///
  /// In en, this message translates to:
  /// **'View Invoice'**
  String get orderHistoryViewInvoice;

  /// No description provided for @orderHistoryNoInvoice.
  ///
  /// In en, this message translates to:
  /// **'No Invoice'**
  String get orderHistoryNoInvoice;

  /// No description provided for @orderHistoryReorder.
  ///
  /// In en, this message translates to:
  /// **'Re-order'**
  String get orderHistoryReorder;

  /// No description provided for @orderHistoryTryAgain.
  ///
  /// In en, this message translates to:
  /// **'Try Again'**
  String get orderHistoryTryAgain;

  /// No description provided for @orderHistoryShowMore.
  ///
  /// In en, this message translates to:
  /// **'Show More Orders'**
  String get orderHistoryShowMore;

  /// No description provided for @orderHistoryOrder9821.
  ///
  /// In en, this message translates to:
  /// **'Order #SV-9821'**
  String get orderHistoryOrder9821;

  /// No description provided for @orderHistoryOrder9750.
  ///
  /// In en, this message translates to:
  /// **'Order #SV-9750'**
  String get orderHistoryOrder9750;

  /// No description provided for @orderHistoryOrder9612.
  ///
  /// In en, this message translates to:
  /// **'Order #SV-9612'**
  String get orderHistoryOrder9612;

  /// No description provided for @orderHistoryDate9821.
  ///
  /// In en, this message translates to:
  /// **'Oct 12, 2023 • 14:30'**
  String get orderHistoryDate9821;

  /// No description provided for @orderHistoryDate9750.
  ///
  /// In en, this message translates to:
  /// **'Oct 08, 2023 • 20:15'**
  String get orderHistoryDate9750;

  /// No description provided for @orderHistoryDate9612.
  ///
  /// In en, this message translates to:
  /// **'Oct 02, 2023 • 19:45'**
  String get orderHistoryDate9612;

  /// No description provided for @orderHistoryDineInTable.
  ///
  /// In en, this message translates to:
  /// **'Dine-In • Table 4'**
  String get orderHistoryDineInTable;

  /// No description provided for @orderHistoryMansaf.
  ///
  /// In en, this message translates to:
  /// **'2x Mansaf Traditional'**
  String get orderHistoryMansaf;

  /// No description provided for @orderHistoryArabicSalad.
  ///
  /// In en, this message translates to:
  /// **'1x Arabic Salad'**
  String get orderHistoryArabicSalad;

  /// No description provided for @orderHistoryMintLemonade.
  ///
  /// In en, this message translates to:
  /// **'3x Fresh Mint Lemonade'**
  String get orderHistoryMintLemonade;

  /// No description provided for @orderHistorySeaBass.
  ///
  /// In en, this message translates to:
  /// **'1x Grilled Sea Bass'**
  String get orderHistorySeaBass;

  /// No description provided for @orderHistorySaffronRice.
  ///
  /// In en, this message translates to:
  /// **'2x Saffron Rice'**
  String get orderHistorySaffronRice;

  /// No description provided for @orderHistoryMixedGrill.
  ///
  /// In en, this message translates to:
  /// **'4x Mixed Grill Platter'**
  String get orderHistoryMixedGrill;

  /// No description provided for @orderHistoryMezzeTray.
  ///
  /// In en, this message translates to:
  /// **'1x Large Mezze Tray'**
  String get orderHistoryMezzeTray;

  /// No description provided for @profileAccountSettings.
  ///
  /// In en, this message translates to:
  /// **'Account Settings'**
  String get profileAccountSettings;

  /// No description provided for @profilePersonalProfile.
  ///
  /// In en, this message translates to:
  /// **'Personal Profile'**
  String get profilePersonalProfile;

  /// No description provided for @profileMemberName.
  ///
  /// In en, this message translates to:
  /// **'Leen Haddad'**
  String get profileMemberName;

  /// No description provided for @profileMemberSince.
  ///
  /// In en, this message translates to:
  /// **'Member since June 2022'**
  String get profileMemberSince;

  /// No description provided for @profileEditDetails.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile Details'**
  String get profileEditDetails;

  /// No description provided for @profileChangePhoto.
  ///
  /// In en, this message translates to:
  /// **'Change profile image'**
  String get profileChangePhoto;

  /// No description provided for @profilePhotoUpdated.
  ///
  /// In en, this message translates to:
  /// **'Profile image updated'**
  String get profilePhotoUpdated;

  /// No description provided for @profileChoosePhoto.
  ///
  /// In en, this message translates to:
  /// **'Choose a photo'**
  String get profileChoosePhoto;

  /// No description provided for @profileRemovePhoto.
  ///
  /// In en, this message translates to:
  /// **'Remove photo'**
  String get profileRemovePhoto;

  /// No description provided for @profileEpicureanTier.
  ///
  /// In en, this message translates to:
  /// **'Epicurean Tier'**
  String get profileEpicureanTier;

  /// No description provided for @profileGoldStatus.
  ///
  /// In en, this message translates to:
  /// **'Gold Status'**
  String get profileGoldStatus;

  /// No description provided for @profileSavorPoints.
  ///
  /// In en, this message translates to:
  /// **'Savor Points'**
  String get profileSavorPoints;

  /// No description provided for @profilePointsValue.
  ///
  /// In en, this message translates to:
  /// **'4,850'**
  String get profilePointsValue;

  /// No description provided for @profileTierProgress.
  ///
  /// In en, this message translates to:
  /// **'1,150 points until Platinum Tier benefits.'**
  String get profileTierProgress;

  /// No description provided for @profileRewardsCatalog.
  ///
  /// In en, this message translates to:
  /// **'Rewards Catalog'**
  String get profileRewardsCatalog;

  /// No description provided for @profilePointsHistory.
  ///
  /// In en, this message translates to:
  /// **'Points activity'**
  String get profilePointsHistory;

  /// No description provided for @profileNoPointsActivity.
  ///
  /// In en, this message translates to:
  /// **'No points activity yet.'**
  String get profileNoPointsActivity;

  /// No description provided for @profilePointsActivityLabel.
  ///
  /// In en, this message translates to:
  /// **'Points activity'**
  String get profilePointsActivityLabel;

  /// No description provided for @profilePointsHistorySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Recent reward points earned and redeemed.'**
  String get profilePointsHistorySubtitle;

  /// No description provided for @profileViewAllPointsHistory.
  ///
  /// In en, this message translates to:
  /// **'View All History'**
  String get profileViewAllPointsHistory;

  /// No description provided for @profilePaymentHistory.
  ///
  /// In en, this message translates to:
  /// **'Payment history'**
  String get profilePaymentHistory;

  /// No description provided for @profilePaymentHistorySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Recent successful customer payments.'**
  String get profilePaymentHistorySubtitle;

  /// No description provided for @profileViewAllPaymentHistory.
  ///
  /// In en, this message translates to:
  /// **'View Payment History'**
  String get profileViewAllPaymentHistory;

  /// No description provided for @profileContact.
  ///
  /// In en, this message translates to:
  /// **'Contact'**
  String get profileContact;

  /// No description provided for @profilePhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get profilePhoneNumber;

  /// No description provided for @profilePhoneValue.
  ///
  /// In en, this message translates to:
  /// **'+962 7 9123 4567'**
  String get profilePhoneValue;

  /// No description provided for @profileEmailAddress.
  ///
  /// In en, this message translates to:
  /// **'Email Address'**
  String get profileEmailAddress;

  /// No description provided for @profileEmailValue.
  ///
  /// In en, this message translates to:
  /// **'leen.haddad@example.com'**
  String get profileEmailValue;

  /// No description provided for @profileWalletBalance.
  ///
  /// In en, this message translates to:
  /// **'Wallet balance'**
  String get profileWalletBalance;

  /// No description provided for @profileWalletAmount.
  ///
  /// In en, this message translates to:
  /// **'124.50'**
  String get profileWalletAmount;

  /// No description provided for @profileWalletSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Available for instant checkout'**
  String get profileWalletSubtitle;

  /// No description provided for @profileVisaEnding.
  ///
  /// In en, this message translates to:
  /// **'Visa ending in 8842'**
  String get profileVisaEnding;

  /// No description provided for @profileVisaExpiry.
  ///
  /// In en, this message translates to:
  /// **'Expires 09/26'**
  String get profileVisaExpiry;

  /// No description provided for @profileManage.
  ///
  /// In en, this message translates to:
  /// **'Manage'**
  String get profileManage;

  /// No description provided for @profileSavedAddresses.
  ///
  /// In en, this message translates to:
  /// **'Saved Addresses'**
  String get profileSavedAddresses;

  /// No description provided for @profileAddNew.
  ///
  /// In en, this message translates to:
  /// **'Add New'**
  String get profileAddNew;

  /// No description provided for @profileDeleteAddressTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete address?'**
  String get profileDeleteAddressTitle;

  /// No description provided for @profileDeleteAddressBody.
  ///
  /// In en, this message translates to:
  /// **'This removes the saved address from your profile.'**
  String get profileDeleteAddressBody;

  /// No description provided for @profileHomeAddressTitle.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get profileHomeAddressTitle;

  /// No description provided for @profileHomeAddress.
  ///
  /// In en, this message translates to:
  /// **'42 Al-Reem Street, Apt 4B\nAmman, Jordan'**
  String get profileHomeAddress;

  /// No description provided for @profileOfficeAddressTitle.
  ///
  /// In en, this message translates to:
  /// **'Office'**
  String get profileOfficeAddressTitle;

  /// No description provided for @profileOfficeAddress.
  ///
  /// In en, this message translates to:
  /// **'Business Park, Suite 220\nAmman, Jordan'**
  String get profileOfficeAddress;

  /// No description provided for @profileNotificationPreferences.
  ///
  /// In en, this message translates to:
  /// **'Notification Preferences'**
  String get profileNotificationPreferences;

  /// No description provided for @profileOrderStatusUpdates.
  ///
  /// In en, this message translates to:
  /// **'Order Status Updates'**
  String get profileOrderStatusUpdates;

  /// No description provided for @profileOrderStatusSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Push notifications and SMS for your active orders'**
  String get profileOrderStatusSubtitle;

  /// No description provided for @profileLoyaltyRewards.
  ///
  /// In en, this message translates to:
  /// **'Loyalty & Rewards'**
  String get profileLoyaltyRewards;

  /// No description provided for @profileLoyaltySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Monthly statement of points and tier bonuses'**
  String get profileLoyaltySubtitle;

  /// No description provided for @profileMarketingOffers.
  ///
  /// In en, this message translates to:
  /// **'Marketing & Offers'**
  String get profileMarketingOffers;

  /// No description provided for @profileMarketingSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Exclusive discounts and seasonal menu announcements'**
  String get profileMarketingSubtitle;

  /// No description provided for @profileLogout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get profileLogout;

  /// No description provided for @profileDeactivateAccount.
  ///
  /// In en, this message translates to:
  /// **'Deactivate Account'**
  String get profileDeactivateAccount;

  /// No description provided for @settingsPersonalSubtitle.
  ///
  /// In en, this message translates to:
  /// **'View your profile photo, name, contact details, and notification preferences.'**
  String get settingsPersonalSubtitle;

  /// No description provided for @settingsEmployeeSince.
  ///
  /// In en, this message translates to:
  /// **'Team member since June 2022'**
  String get settingsEmployeeSince;

  /// No description provided for @settingsStaffDisplayName.
  ///
  /// In en, this message translates to:
  /// **'Omar Hassan'**
  String get settingsStaffDisplayName;

  /// No description provided for @settingsStaffPhoneValue.
  ///
  /// In en, this message translates to:
  /// **'+962 7 9000 1122'**
  String get settingsStaffPhoneValue;

  /// No description provided for @settingsStaffEmailValue.
  ///
  /// In en, this message translates to:
  /// **'omar.hassan@ayletna.com'**
  String get settingsStaffEmailValue;

  /// No description provided for @settingsStaffShiftAlerts.
  ///
  /// In en, this message translates to:
  /// **'Shift & task alerts'**
  String get settingsStaffShiftAlerts;

  /// No description provided for @settingsStaffShiftAlertsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Kitchen, delivery, inventory, and attendance reminders.'**
  String get settingsStaffShiftAlertsSubtitle;

  /// No description provided for @settingsStaffOrderAlertsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Order updates relevant to your station or route.'**
  String get settingsStaffOrderAlertsSubtitle;

  /// No description provided for @settingsBusinessSettingsHint.
  ///
  /// In en, this message translates to:
  /// **'Restaurant operations, roles, taxes, receipts, and system alerts.'**
  String get settingsBusinessSettingsHint;

  /// No description provided for @drawerBusinessSettings.
  ///
  /// In en, this message translates to:
  /// **'Business settings'**
  String get drawerBusinessSettings;

  /// No description provided for @addressesTitle.
  ///
  /// In en, this message translates to:
  /// **'Saved Addresses'**
  String get addressesTitle;

  /// No description provided for @addressesAddNew.
  ///
  /// In en, this message translates to:
  /// **'Add New Address'**
  String get addressesAddNew;

  /// No description provided for @addressesEmptyMessage.
  ///
  /// In en, this message translates to:
  /// **'No saved addresses yet. Add one for faster delivery checkout.'**
  String get addressesEmptyMessage;

  /// No description provided for @addressesDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get addressesDelete;

  /// No description provided for @addressesDefault.
  ///
  /// In en, this message translates to:
  /// **'Default'**
  String get addressesDefault;

  /// No description provided for @addressesHomeTitle.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get addressesHomeTitle;

  /// No description provided for @addressesHomeBody.
  ///
  /// In en, this message translates to:
  /// **'124 Maple Avenue, Apt 4B, Silver Springs, MD 20910'**
  String get addressesHomeBody;

  /// No description provided for @addressesOfficeTitle.
  ///
  /// In en, this message translates to:
  /// **'Office'**
  String get addressesOfficeTitle;

  /// No description provided for @addressesOfficeBody.
  ///
  /// In en, this message translates to:
  /// **'Ayletna HQ, 888 Innovation Way, Suite 200, Amman'**
  String get addressesOfficeBody;

  /// No description provided for @addressesGymTitle.
  ///
  /// In en, this message translates to:
  /// **'Gym'**
  String get addressesGymTitle;

  /// No description provided for @addressesGymBody.
  ///
  /// In en, this message translates to:
  /// **'Iron Peak Fitness Center, 45 Strength Blvd, Amman'**
  String get addressesGymBody;

  /// No description provided for @addressesHelper.
  ///
  /// In en, this message translates to:
  /// **'Easily manage your frequent delivery spots for faster checkout.'**
  String get addressesHelper;

  /// No description provided for @mapAddressTitle.
  ///
  /// In en, this message translates to:
  /// **'Save address as'**
  String get mapAddressTitle;

  /// No description provided for @mapAddressTitleHint.
  ///
  /// In en, this message translates to:
  /// **'Home, Office, Family house...'**
  String get mapAddressTitleHint;

  /// No description provided for @mapAddressText.
  ///
  /// In en, this message translates to:
  /// **'Written address'**
  String get mapAddressText;

  /// No description provided for @mapAddressTextHint.
  ///
  /// In en, this message translates to:
  /// **'Building, street, floor, nearby landmark...'**
  String get mapAddressTextHint;

  /// No description provided for @mapSelectOnMap.
  ///
  /// In en, this message translates to:
  /// **'Choose location from map'**
  String get mapSelectOnMap;

  /// No description provided for @mapLocationSelected.
  ///
  /// In en, this message translates to:
  /// **'Location selected from map'**
  String get mapLocationSelected;

  /// No description provided for @mapSaveAddress.
  ///
  /// In en, this message translates to:
  /// **'Save address'**
  String get mapSaveAddress;

  /// No description provided for @mapRequiredFields.
  ///
  /// In en, this message translates to:
  /// **'Choose a map location and write the address before saving.'**
  String get mapRequiredFields;

  /// No description provided for @notificationsTitle.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notificationsTitle;

  /// No description provided for @notificationsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Stay updated with your latest kitchen and delivery activities.'**
  String get notificationsSubtitle;

  /// No description provided for @notificationsClearAll.
  ///
  /// In en, this message translates to:
  /// **'Clear All'**
  String get notificationsClearAll;

  /// No description provided for @notificationsPreferences.
  ///
  /// In en, this message translates to:
  /// **'Preferences'**
  String get notificationsPreferences;

  /// No description provided for @notificationsCategories.
  ///
  /// In en, this message translates to:
  /// **'Categories'**
  String get notificationsCategories;

  /// No description provided for @notificationsAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get notificationsAll;

  /// No description provided for @notificationsOrderUpdates.
  ///
  /// In en, this message translates to:
  /// **'Order Updates'**
  String get notificationsOrderUpdates;

  /// No description provided for @notificationsSustainability.
  ///
  /// In en, this message translates to:
  /// **'Sustainability'**
  String get notificationsSustainability;

  /// No description provided for @notificationsAdminStaff.
  ///
  /// In en, this message translates to:
  /// **'Admin/Staff'**
  String get notificationsAdminStaff;

  /// No description provided for @notificationsWeeklyReport.
  ///
  /// In en, this message translates to:
  /// **'Weekly Report'**
  String get notificationsWeeklyReport;

  /// No description provided for @notificationsWeeklySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Sustainability goals reached 92% this week!'**
  String get notificationsWeeklySubtitle;

  /// No description provided for @notificationsViewDetails.
  ///
  /// In en, this message translates to:
  /// **'View details'**
  String get notificationsViewDetails;

  /// No description provided for @notificationsRecentAlerts.
  ///
  /// In en, this message translates to:
  /// **'Recent Alerts'**
  String get notificationsRecentAlerts;

  /// No description provided for @notificationsYesterday.
  ///
  /// In en, this message translates to:
  /// **'Yesterday'**
  String get notificationsYesterday;

  /// No description provided for @notificationsDeliveryTitle.
  ///
  /// In en, this message translates to:
  /// **'Order #8829 is out for delivery'**
  String get notificationsDeliveryTitle;

  /// No description provided for @notificationsDeliveryBody.
  ///
  /// In en, this message translates to:
  /// **'Driver Ahmad has picked up the order and is heading to the destination.'**
  String get notificationsDeliveryBody;

  /// No description provided for @notificationsTwoMins.
  ///
  /// In en, this message translates to:
  /// **'2 mins ago'**
  String get notificationsTwoMins;

  /// No description provided for @notificationsTrackMap.
  ///
  /// In en, this message translates to:
  /// **'Track Map'**
  String get notificationsTrackMap;

  /// No description provided for @notificationsContactDriver.
  ///
  /// In en, this message translates to:
  /// **'Contact Driver'**
  String get notificationsContactDriver;

  /// No description provided for @notificationsTipTitle.
  ///
  /// In en, this message translates to:
  /// **'Tip distribution ready'**
  String get notificationsTipTitle;

  /// No description provided for @notificationsTipBody.
  ///
  /// In en, this message translates to:
  /// **'The tip pool for the morning shift has been calculated and is ready for distribution.'**
  String get notificationsTipBody;

  /// No description provided for @notificationsFifteenMins.
  ///
  /// In en, this message translates to:
  /// **'15 mins ago'**
  String get notificationsFifteenMins;

  /// No description provided for @notificationsDistributeNow.
  ///
  /// In en, this message translates to:
  /// **'Distribute Now'**
  String get notificationsDistributeNow;

  /// No description provided for @notificationsReviewBreakdown.
  ///
  /// In en, this message translates to:
  /// **'Review Breakdown'**
  String get notificationsReviewBreakdown;

  /// No description provided for @notificationsTrayTitle.
  ///
  /// In en, this message translates to:
  /// **'Tray collection reminder'**
  String get notificationsTrayTitle;

  /// No description provided for @notificationsTrayBody.
  ///
  /// In en, this message translates to:
  /// **'Sustainability alert: 12 reusable trays are currently unreturned at Block B collection points.'**
  String get notificationsTrayBody;

  /// No description provided for @notificationsFortyFiveMins.
  ///
  /// In en, this message translates to:
  /// **'45 mins ago'**
  String get notificationsFortyFiveMins;

  /// No description provided for @notificationsPingStaff.
  ///
  /// In en, this message translates to:
  /// **'Ping Collection Staff'**
  String get notificationsPingStaff;

  /// No description provided for @notificationsStockTitle.
  ///
  /// In en, this message translates to:
  /// **'Stock alert: Premium Espresso Beans'**
  String get notificationsStockTitle;

  /// No description provided for @notificationsStockBody.
  ///
  /// In en, this message translates to:
  /// **'Inventory level dropped below the 15% threshold. Consider restocking soon to avoid service interruption.'**
  String get notificationsStockBody;

  /// No description provided for @notificationsOneHour.
  ///
  /// In en, this message translates to:
  /// **'1 hour ago'**
  String get notificationsOneHour;

  /// No description provided for @notificationsOrderMore.
  ///
  /// In en, this message translates to:
  /// **'Order More'**
  String get notificationsOrderMore;

  /// No description provided for @notificationsIgnoreNow.
  ///
  /// In en, this message translates to:
  /// **'Ignore for now'**
  String get notificationsIgnoreNow;

  /// No description provided for @notificationsPickupTitle.
  ///
  /// In en, this message translates to:
  /// **'Order #7741 is ready for pickup'**
  String get notificationsPickupTitle;

  /// No description provided for @notificationsPickupBody.
  ///
  /// In en, this message translates to:
  /// **'The plated meal is now on the heat rack at Station 3.'**
  String get notificationsPickupBody;

  /// No description provided for @notificationsThreeHours.
  ///
  /// In en, this message translates to:
  /// **'3 hours ago'**
  String get notificationsThreeHours;

  /// No description provided for @notificationsViewTicket.
  ///
  /// In en, this message translates to:
  /// **'View Ticket'**
  String get notificationsViewTicket;

  /// No description provided for @notificationsPolicyTitle.
  ///
  /// In en, this message translates to:
  /// **'New Policy Update'**
  String get notificationsPolicyTitle;

  /// No description provided for @notificationsPolicyBody.
  ///
  /// In en, this message translates to:
  /// **'The sanitation guidelines have been updated. Please review the new checklist in the staff portal.'**
  String get notificationsPolicyBody;

  /// No description provided for @notificationsTwentyFourHours.
  ///
  /// In en, this message translates to:
  /// **'24 hours ago'**
  String get notificationsTwentyFourHours;

  /// No description provided for @notificationsAlertsNav.
  ///
  /// In en, this message translates to:
  /// **'Alerts'**
  String get notificationsAlertsNav;

  /// No description provided for @orderConfirmedThanks.
  ///
  /// In en, this message translates to:
  /// **'Thank You'**
  String get orderConfirmedThanks;

  /// No description provided for @orderConfirmedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Your order has been placed successfully.'**
  String get orderConfirmedSuccess;

  /// No description provided for @orderConfirmedNumberLabel.
  ///
  /// In en, this message translates to:
  /// **'Order Number'**
  String get orderConfirmedNumberLabel;

  /// No description provided for @orderConfirmedNumber.
  ///
  /// In en, this message translates to:
  /// **'#CL-8829'**
  String get orderConfirmedNumber;

  /// No description provided for @orderConfirmedTypeLabel.
  ///
  /// In en, this message translates to:
  /// **'Order Type'**
  String get orderConfirmedTypeLabel;

  /// No description provided for @orderConfirmedType.
  ///
  /// In en, this message translates to:
  /// **'Plated Delivery'**
  String get orderConfirmedType;

  /// No description provided for @orderConfirmedArrivalLabel.
  ///
  /// In en, this message translates to:
  /// **'Estimated Arrival'**
  String get orderConfirmedArrivalLabel;

  /// No description provided for @orderConfirmedArrival.
  ///
  /// In en, this message translates to:
  /// **'12:45 PM - 1:15 PM'**
  String get orderConfirmedArrival;

  /// No description provided for @orderConfirmedAddressLabel.
  ///
  /// In en, this message translates to:
  /// **'Delivery Address'**
  String get orderConfirmedAddressLabel;

  /// No description provided for @orderConfirmedAddress.
  ///
  /// In en, this message translates to:
  /// **'221B Baker St, Amman'**
  String get orderConfirmedAddress;

  /// No description provided for @orderConfirmedTrack.
  ///
  /// In en, this message translates to:
  /// **'Track Order'**
  String get orderConfirmedTrack;

  /// No description provided for @orderConfirmedHome.
  ///
  /// In en, this message translates to:
  /// **'Back to Home'**
  String get orderConfirmedHome;

  /// No description provided for @orderConfirmedEmailSent.
  ///
  /// In en, this message translates to:
  /// **'A confirmation email has been sent to your inbox.'**
  String get orderConfirmedEmailSent;

  /// No description provided for @otpTitle.
  ///
  /// In en, this message translates to:
  /// **'OTP Verification'**
  String get otpTitle;

  /// No description provided for @otpSentCode.
  ///
  /// In en, this message translates to:
  /// **'We sent a 6-digit code to {phone}'**
  String otpSentCode(String phone);

  /// No description provided for @otpMaskedPhone.
  ///
  /// In en, this message translates to:
  /// **'+962 XXX XXXX'**
  String get otpMaskedPhone;

  /// No description provided for @otpResendIn.
  ///
  /// In en, this message translates to:
  /// **'Resend code in {time}'**
  String otpResendIn(String time);

  /// No description provided for @otpCountdown.
  ///
  /// In en, this message translates to:
  /// **'00:56'**
  String get otpCountdown;

  /// No description provided for @otpResendCode.
  ///
  /// In en, this message translates to:
  /// **'Resend code'**
  String get otpResendCode;

  /// No description provided for @otpResendLimitReached.
  ///
  /// In en, this message translates to:
  /// **'Resend limit reached. Please try again later.'**
  String get otpResendLimitReached;

  /// No description provided for @otpSecurityNote.
  ///
  /// In en, this message translates to:
  /// **'Ayletna uses bank-grade encryption to protect your account security.'**
  String get otpSecurityNote;

  /// No description provided for @ownerDashboardTitle.
  ///
  /// In en, this message translates to:
  /// **'Executive Performance'**
  String get ownerDashboardTitle;

  /// No description provided for @ownerDashboardSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Real-time financial health and profit analysis for June 2024.'**
  String get ownerDashboardSubtitle;

  /// No description provided for @ownerLast30Days.
  ///
  /// In en, this message translates to:
  /// **'Last 30 Days'**
  String get ownerLast30Days;

  /// No description provided for @ownerExportPdf.
  ///
  /// In en, this message translates to:
  /// **'Export PDF'**
  String get ownerExportPdf;

  /// No description provided for @ownerTotalRevenue.
  ///
  /// In en, this message translates to:
  /// **'Total Revenue'**
  String get ownerTotalRevenue;

  /// No description provided for @ownerRevenueDelta.
  ///
  /// In en, this message translates to:
  /// **'+12.5% from last month'**
  String get ownerRevenueDelta;

  /// No description provided for @ownerNetProfit.
  ///
  /// In en, this message translates to:
  /// **'Net Profit'**
  String get ownerNetProfit;

  /// No description provided for @ownerProfitDelta.
  ///
  /// In en, this message translates to:
  /// **'+5.2% yield'**
  String get ownerProfitDelta;

  /// No description provided for @ownerSharedTips.
  ///
  /// In en, this message translates to:
  /// **'Shared Tips'**
  String get ownerSharedTips;

  /// No description provided for @ownerTipsStatus.
  ///
  /// In en, this message translates to:
  /// **'Awaiting weekly distribution'**
  String get ownerTipsStatus;

  /// No description provided for @ownerPendingDeposits.
  ///
  /// In en, this message translates to:
  /// **'Pending Deposits'**
  String get ownerPendingDeposits;

  /// No description provided for @ownerDepositStatus.
  ///
  /// In en, this message translates to:
  /// **'Estimated settlement: 48h'**
  String get ownerDepositStatus;

  /// No description provided for @ownerWeeklyRevenueGrowth.
  ///
  /// In en, this message translates to:
  /// **'Weekly Revenue Growth'**
  String get ownerWeeklyRevenueGrowth;

  /// No description provided for @ownerRevenueLegend.
  ///
  /// In en, this message translates to:
  /// **'Revenue'**
  String get ownerRevenueLegend;

  /// No description provided for @ownerProjectedLegend.
  ///
  /// In en, this message translates to:
  /// **'Projected'**
  String get ownerProjectedLegend;

  /// No description provided for @ownerProfitAllocation.
  ///
  /// In en, this message translates to:
  /// **'Profit Allocation'**
  String get ownerProfitAllocation;

  /// No description provided for @ownerProfitAllocationBody.
  ///
  /// In en, this message translates to:
  /// **'Calculated based on the 50/50 Owner-Operator agreement.'**
  String get ownerProfitAllocationBody;

  /// No description provided for @ownerSplitRatio.
  ///
  /// In en, this message translates to:
  /// **'Split Ratio'**
  String get ownerSplitRatio;

  /// No description provided for @ownerOperatorShare.
  ///
  /// In en, this message translates to:
  /// **'Operator\'s Share'**
  String get ownerOperatorShare;

  /// No description provided for @ownerExpensesBody.
  ///
  /// In en, this message translates to:
  /// **'Consolidated monthly overhead including COGS, utilities, and labor. Internal recipes and unit costs are restricted for privacy.'**
  String get ownerExpensesBody;

  /// No description provided for @ownerConsolidatedTotal.
  ///
  /// In en, this message translates to:
  /// **'Consolidated Total'**
  String get ownerConsolidatedTotal;

  /// No description provided for @ownerRequestAudit.
  ///
  /// In en, this message translates to:
  /// **'Request Detailed Audit'**
  String get ownerRequestAudit;

  /// No description provided for @ownerRecentTransactions.
  ///
  /// In en, this message translates to:
  /// **'Recent Large Transactions'**
  String get ownerRecentTransactions;

  /// No description provided for @ownerViewAllActivity.
  ///
  /// In en, this message translates to:
  /// **'View All Activity'**
  String get ownerViewAllActivity;

  /// No description provided for @ownerMonthlyRent.
  ///
  /// In en, this message translates to:
  /// **'Monthly Rent Settlement'**
  String get ownerMonthlyRent;

  /// No description provided for @ownerMonthlyRentMeta.
  ///
  /// In en, this message translates to:
  /// **'June 05, 2024 • Transaction ID: #TXN-9021'**
  String get ownerMonthlyRentMeta;

  /// No description provided for @ownerCateringEvent.
  ///
  /// In en, this message translates to:
  /// **'Catering Event: Al-Mansour Corp'**
  String get ownerCateringEvent;

  /// No description provided for @ownerCateringEventMeta.
  ///
  /// In en, this message translates to:
  /// **'June 02, 2024 • Transaction ID: #TXN-8842'**
  String get ownerCateringEventMeta;

  /// No description provided for @ownerCompleted.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get ownerCompleted;

  /// No description provided for @ownerCleared.
  ///
  /// In en, this message translates to:
  /// **'Cleared'**
  String get ownerCleared;

  /// No description provided for @ownerFinanceNav.
  ///
  /// In en, this message translates to:
  /// **'Finance'**
  String get ownerFinanceNav;

  /// No description provided for @ownerMon.
  ///
  /// In en, this message translates to:
  /// **'Mon'**
  String get ownerMon;

  /// No description provided for @ownerTue.
  ///
  /// In en, this message translates to:
  /// **'Tue'**
  String get ownerTue;

  /// No description provided for @ownerWed.
  ///
  /// In en, this message translates to:
  /// **'Wed'**
  String get ownerWed;

  /// No description provided for @ownerThu.
  ///
  /// In en, this message translates to:
  /// **'Thu'**
  String get ownerThu;

  /// No description provided for @ownerFri.
  ///
  /// In en, this message translates to:
  /// **'Fri'**
  String get ownerFri;

  /// No description provided for @ownerSat.
  ///
  /// In en, this message translates to:
  /// **'Sat'**
  String get ownerSat;

  /// No description provided for @ownerSun.
  ///
  /// In en, this message translates to:
  /// **'Sun'**
  String get ownerSun;

  /// No description provided for @ownerPrivacyHeader.
  ///
  /// In en, this message translates to:
  /// **'Owner View Permissions'**
  String get ownerPrivacyHeader;

  /// No description provided for @ownerPrivacyBody.
  ///
  /// In en, this message translates to:
  /// **'Configure exactly what information the property owner can see in their dashboard. Maintain operational privacy while ensuring transparency on key business metrics.'**
  String get ownerPrivacyBody;

  /// No description provided for @ownerPrivacyHero.
  ///
  /// In en, this message translates to:
  /// **'Enterprise Security Controls'**
  String get ownerPrivacyHero;

  /// No description provided for @ownerHideRawCosts.
  ///
  /// In en, this message translates to:
  /// **'Hide Raw Material Costs'**
  String get ownerHideRawCosts;

  /// No description provided for @ownerHideRawCostsBody.
  ///
  /// In en, this message translates to:
  /// **'Mask individual item costs in the inventory and procurement reports. Owner will see aggregated totals only.'**
  String get ownerHideRawCostsBody;

  /// No description provided for @ownerHideStaffSalaries.
  ///
  /// In en, this message translates to:
  /// **'Hide Specific Staff Salaries'**
  String get ownerHideStaffSalaries;

  /// No description provided for @ownerHideStaffSalariesBody.
  ///
  /// In en, this message translates to:
  /// **'Restrict visibility of granular payroll data. Individual salary breakdowns will be hidden from the owner\'s view.'**
  String get ownerHideStaffSalariesBody;

  /// No description provided for @ownerShowOnlyNetProfit.
  ///
  /// In en, this message translates to:
  /// **'Show Only Net Profit'**
  String get ownerShowOnlyNetProfit;

  /// No description provided for @ownerShowOnlyNetProfitBody.
  ///
  /// In en, this message translates to:
  /// **'When enabled, the owner dashboard will suppress all gross revenue and operational expense breakdowns, presenting only the final Net Profit figure for the period.'**
  String get ownerShowOnlyNetProfitBody;

  /// No description provided for @ownerLivePreview.
  ///
  /// In en, this message translates to:
  /// **'Live Preview: Owner Perspective'**
  String get ownerLivePreview;

  /// No description provided for @ownerGrossRevenue.
  ///
  /// In en, this message translates to:
  /// **'Gross Revenue'**
  String get ownerGrossRevenue;

  /// No description provided for @ownerOperatingCosts.
  ///
  /// In en, this message translates to:
  /// **'Operating Costs'**
  String get ownerOperatingCosts;

  /// No description provided for @ownerNetProfitLabel.
  ///
  /// In en, this message translates to:
  /// **'Net Profit'**
  String get ownerNetProfitLabel;

  /// No description provided for @ownerPreviewNote.
  ///
  /// In en, this message translates to:
  /// **'Data above reflects the current visibility settings applied to the Owner dashboard.'**
  String get ownerPreviewNote;

  /// No description provided for @ownerDiscardChanges.
  ///
  /// In en, this message translates to:
  /// **'Discard Changes'**
  String get ownerDiscardChanges;

  /// No description provided for @ownerSaveConfigurations.
  ///
  /// In en, this message translates to:
  /// **'Save Configurations'**
  String get ownerSaveConfigurations;

  /// No description provided for @ownerAdminMode.
  ///
  /// In en, this message translates to:
  /// **'Admin Mode'**
  String get ownerAdminMode;

  /// No description provided for @ownerFinancesNav.
  ///
  /// In en, this message translates to:
  /// **'Finances'**
  String get ownerFinancesNav;

  /// No description provided for @ownerProfileNav.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get ownerProfileNav;

  /// No description provided for @paymentCheckoutTitle.
  ///
  /// In en, this message translates to:
  /// **'Checkout'**
  String get paymentCheckoutTitle;

  /// No description provided for @paymentCheckoutSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Choose your preferred payment method to complete the order.'**
  String get paymentCheckoutSubtitle;

  /// No description provided for @paymentTotalAmountDue.
  ///
  /// In en, this message translates to:
  /// **'Total Amount Due'**
  String get paymentTotalAmountDue;

  /// No description provided for @paymentSecureTransaction.
  ///
  /// In en, this message translates to:
  /// **'Secure encrypted transaction'**
  String get paymentSecureTransaction;

  /// No description provided for @paymentOrderReference.
  ///
  /// In en, this message translates to:
  /// **'Order Reference'**
  String get paymentOrderReference;

  /// No description provided for @paymentMethodsTitle.
  ///
  /// In en, this message translates to:
  /// **'Payment Methods'**
  String get paymentMethodsTitle;

  /// No description provided for @paymentWalletBalance.
  ///
  /// In en, this message translates to:
  /// **'Wallet Balance'**
  String get paymentWalletBalance;

  /// No description provided for @paymentAvailableAmount.
  ///
  /// In en, this message translates to:
  /// **'Available: {amount}'**
  String paymentAvailableAmount(Object amount);

  /// No description provided for @paymentCardTitle.
  ///
  /// In en, this message translates to:
  /// **'Credit / Debit Card'**
  String get paymentCardTitle;

  /// No description provided for @paymentCardSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Visa ending in •••• 4242'**
  String get paymentCardSubtitle;

  /// No description provided for @paymentApplePay.
  ///
  /// In en, this message translates to:
  /// **'Apple Pay'**
  String get paymentApplePay;

  /// No description provided for @paymentFastSecure.
  ///
  /// In en, this message translates to:
  /// **'Fast & Secure'**
  String get paymentFastSecure;

  /// No description provided for @paymentCashOnDelivery.
  ///
  /// In en, this message translates to:
  /// **'Cash on Delivery'**
  String get paymentCashOnDelivery;

  /// No description provided for @paymentPayWhenReceive.
  ///
  /// In en, this message translates to:
  /// **'Pay when you receive'**
  String get paymentPayWhenReceive;

  /// No description provided for @paymentAddNewMethod.
  ///
  /// In en, this message translates to:
  /// **'Add New Payment Method'**
  String get paymentAddNewMethod;

  /// No description provided for @paymentTotalAmount.
  ///
  /// In en, this message translates to:
  /// **'Total Amount'**
  String get paymentTotalAmount;

  /// No description provided for @paymentPayNow.
  ///
  /// In en, this message translates to:
  /// **'Pay Now'**
  String get paymentPayNow;

  /// No description provided for @paymentPayNowAmount.
  ///
  /// In en, this message translates to:
  /// **'Pay Now | {amount}'**
  String paymentPayNowAmount(Object amount);

  /// No description provided for @platedHowBadge.
  ///
  /// In en, this message translates to:
  /// **'Plated Delivery'**
  String get platedHowBadge;

  /// No description provided for @platedHowTitle.
  ///
  /// In en, this message translates to:
  /// **'Sustainable Dining, Redefined.'**
  String get platedHowTitle;

  /// No description provided for @platedHowSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Enjoy your favorite restaurant meals on real ceramic plates, delivered to your door and collected when you\'re done.'**
  String get platedHowSubtitle;

  /// No description provided for @platedHowItWorks.
  ///
  /// In en, this message translates to:
  /// **'How It Works'**
  String get platedHowItWorks;

  /// No description provided for @platedStepOrderTitle.
  ///
  /// In en, this message translates to:
  /// **'1. Order Plated'**
  String get platedStepOrderTitle;

  /// No description provided for @platedStepOrderBody.
  ///
  /// In en, this message translates to:
  /// **'Select the Plated option at checkout for participating local restaurants.'**
  String get platedStepOrderBody;

  /// No description provided for @platedStepEnjoyTitle.
  ///
  /// In en, this message translates to:
  /// **'2. Enjoy Meal'**
  String get platedStepEnjoyTitle;

  /// No description provided for @platedStepEnjoyBody.
  ///
  /// In en, this message translates to:
  /// **'No soggy paper boxes. Experience the true taste of your meal on high-quality ceramic.'**
  String get platedStepEnjoyBody;

  /// No description provided for @platedStepPickupTitle.
  ///
  /// In en, this message translates to:
  /// **'3. We Pick Up'**
  String get platedStepPickupTitle;

  /// No description provided for @platedStepPickupBody.
  ///
  /// In en, this message translates to:
  /// **'Leave the tray at your door. We\'ll collect, professionally sanitize, and reuse it.'**
  String get platedStepPickupBody;

  /// No description provided for @platedBondTitle.
  ///
  /// In en, this message translates to:
  /// **'The Sustainable Bond'**
  String get platedBondTitle;

  /// No description provided for @platedBondBody.
  ///
  /// In en, this message translates to:
  /// **'To maintain our high-quality ceramic tray library, a refundable deposit is required for every Plated order. This ensures the loop remains closed and sustainable.'**
  String get platedBondBody;

  /// No description provided for @platedDepositAmount.
  ///
  /// In en, this message translates to:
  /// **'5 JOD'**
  String get platedDepositAmount;

  /// No description provided for @platedFullyRefundable.
  ///
  /// In en, this message translates to:
  /// **'Fully Refundable'**
  String get platedFullyRefundable;

  /// No description provided for @platedWhyChoose.
  ///
  /// In en, this message translates to:
  /// **'Why Choose Sustainable?'**
  String get platedWhyChoose;

  /// No description provided for @platedWay.
  ///
  /// In en, this message translates to:
  /// **'The Plated Way'**
  String get platedWay;

  /// No description provided for @platedTraditionalDelivery.
  ///
  /// In en, this message translates to:
  /// **'Traditional Delivery'**
  String get platedTraditionalDelivery;

  /// No description provided for @platedZeroWaste.
  ///
  /// In en, this message translates to:
  /// **'Zero Single-use Waste'**
  String get platedZeroWaste;

  /// No description provided for @platedPlasticWaste.
  ///
  /// In en, this message translates to:
  /// **'Plastic & Cardboard Waste'**
  String get platedPlasticWaste;

  /// No description provided for @platedRetainsHeat.
  ///
  /// In en, this message translates to:
  /// **'Retains Heat Better'**
  String get platedRetainsHeat;

  /// No description provided for @platedLosesHeat.
  ///
  /// In en, this message translates to:
  /// **'Loses Heat Quickly'**
  String get platedLosesHeat;

  /// No description provided for @platedElevatedExperience.
  ///
  /// In en, this message translates to:
  /// **'Elevated Experience'**
  String get platedElevatedExperience;

  /// No description provided for @platedEatingBox.
  ///
  /// In en, this message translates to:
  /// **'Eating from a Box'**
  String get platedEatingBox;

  /// No description provided for @platedReadyPrompt.
  ///
  /// In en, this message translates to:
  /// **'Ready to join the movement?'**
  String get platedReadyPrompt;

  /// No description provided for @platedChooseSustainable.
  ///
  /// In en, this message translates to:
  /// **'Choose Sustainable'**
  String get platedChooseSustainable;

  /// No description provided for @platedLearnSanitation.
  ///
  /// In en, this message translates to:
  /// **'Learn more about our sanitation standards'**
  String get platedLearnSanitation;

  /// No description provided for @platedPickupsTitle.
  ///
  /// In en, this message translates to:
  /// **'Scheduled Pickups'**
  String get platedPickupsTitle;

  /// No description provided for @platedPickupsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'4 remaining tasks for Plated logistics'**
  String get platedPickupsSubtitle;

  /// No description provided for @platedPickupOverdue.
  ///
  /// In en, this message translates to:
  /// **'15m Overdue'**
  String get platedPickupOverdue;

  /// No description provided for @platedPickupIn20.
  ///
  /// In en, this message translates to:
  /// **'In 20m'**
  String get platedPickupIn20;

  /// No description provided for @platedPickupScheduled.
  ///
  /// In en, this message translates to:
  /// **'Scheduled: 14:30'**
  String get platedPickupScheduled;

  /// No description provided for @platedReturnItems.
  ///
  /// In en, this message translates to:
  /// **'Return Items'**
  String get platedReturnItems;

  /// No description provided for @platedReturnItemsLarge.
  ///
  /// In en, this message translates to:
  /// **'1x Large Tray, 4x Plates'**
  String get platedReturnItemsLarge;

  /// No description provided for @platedReturnItemsMedium.
  ///
  /// In en, this message translates to:
  /// **'2x Medium Boxes, 8x Utensil Sets'**
  String get platedReturnItemsMedium;

  /// No description provided for @platedReturnItemsTrays.
  ///
  /// In en, this message translates to:
  /// **'4x Large Trays'**
  String get platedReturnItemsTrays;

  /// No description provided for @platedOpenMaps.
  ///
  /// In en, this message translates to:
  /// **'Open in Maps'**
  String get platedOpenMaps;

  /// No description provided for @platedConfirmCollection.
  ///
  /// In en, this message translates to:
  /// **'Confirm Collection'**
  String get platedConfirmCollection;

  /// No description provided for @platedSustainableReturns.
  ///
  /// In en, this message translates to:
  /// **'Sustainable Returns'**
  String get platedSustainableReturns;

  /// No description provided for @platedWasteReduced.
  ///
  /// In en, this message translates to:
  /// **'Your work reduces waste by 4.2kg per pickup today.'**
  String get platedWasteReduced;

  /// No description provided for @platedCustomerEleanor.
  ///
  /// In en, this message translates to:
  /// **'Eleanor Shellstrop'**
  String get platedCustomerEleanor;

  /// No description provided for @platedAddressEleanor.
  ///
  /// In en, this message translates to:
  /// **'742 Evergreen Terrace, Springfield'**
  String get platedAddressEleanor;

  /// No description provided for @platedCustomerTahani.
  ///
  /// In en, this message translates to:
  /// **'Tahani Al-Jamil'**
  String get platedCustomerTahani;

  /// No description provided for @platedAddressTahani.
  ///
  /// In en, this message translates to:
  /// **'1200 Luxury Lane, Bel Air'**
  String get platedAddressTahani;

  /// No description provided for @platedCustomerChidi.
  ///
  /// In en, this message translates to:
  /// **'Chidi Anagonye'**
  String get platedCustomerChidi;

  /// No description provided for @platedAddressChidi.
  ///
  /// In en, this message translates to:
  /// **'Philosophy Dept, University Row'**
  String get platedAddressChidi;

  /// No description provided for @platesSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search catalog...'**
  String get platesSearchHint;

  /// No description provided for @platesTotalInventoryValue.
  ///
  /// In en, this message translates to:
  /// **'Total Inventory Value'**
  String get platesTotalInventoryValue;

  /// No description provided for @platesValueDelta.
  ///
  /// In en, this message translates to:
  /// **'+2.4%'**
  String get platesValueDelta;

  /// No description provided for @platesBreakageComparison.
  ///
  /// In en, this message translates to:
  /// **'vs last month breakage'**
  String get platesBreakageComparison;

  /// No description provided for @platesTotalCirculation.
  ///
  /// In en, this message translates to:
  /// **'Total In Circulation'**
  String get platesTotalCirculation;

  /// No description provided for @platesUnits.
  ///
  /// In en, this message translates to:
  /// **'Units'**
  String get platesUnits;

  /// No description provided for @platesReplacementsPending.
  ///
  /// In en, this message translates to:
  /// **'Replacements Pending'**
  String get platesReplacementsPending;

  /// No description provided for @platesItems.
  ///
  /// In en, this message translates to:
  /// **'Items'**
  String get platesItems;

  /// No description provided for @platesOrderRestock.
  ///
  /// In en, this message translates to:
  /// **'Order Restock'**
  String get platesOrderRestock;

  /// No description provided for @platesCatalogTitle.
  ///
  /// In en, this message translates to:
  /// **'Ceramic Tray Catalog'**
  String get platesCatalogTitle;

  /// No description provided for @platesNewComponent.
  ///
  /// In en, this message translates to:
  /// **'New Component'**
  String get platesNewComponent;

  /// No description provided for @platesFilter.
  ///
  /// In en, this message translates to:
  /// **'Filter'**
  String get platesFilter;

  /// No description provided for @platesLargeTray.
  ///
  /// In en, this message translates to:
  /// **'Large Serving Tray'**
  String get platesLargeTray;

  /// No description provided for @platesLargeTraySku.
  ///
  /// In en, this message translates to:
  /// **'SKU: CRT-102-L'**
  String get platesLargeTraySku;

  /// No description provided for @platesCeramicBowl.
  ///
  /// In en, this message translates to:
  /// **'Ceramic Bowl'**
  String get platesCeramicBowl;

  /// No description provided for @platesCeramicBowlSku.
  ///
  /// In en, this message translates to:
  /// **'SKU: CRT-205-M'**
  String get platesCeramicBowlSku;

  /// No description provided for @platesMezzePlate.
  ///
  /// In en, this message translates to:
  /// **'Mezze Plate'**
  String get platesMezzePlate;

  /// No description provided for @platesMezzePlateSku.
  ///
  /// In en, this message translates to:
  /// **'SKU: CRT-089-S'**
  String get platesMezzePlateSku;

  /// No description provided for @platesPerUnit.
  ///
  /// In en, this message translates to:
  /// **'Per Unit'**
  String get platesPerUnit;

  /// No description provided for @platesReplacementCost.
  ///
  /// In en, this message translates to:
  /// **'Repl. Cost: {amount}'**
  String platesReplacementCost(Object amount);

  /// No description provided for @platesDetails.
  ///
  /// In en, this message translates to:
  /// **'Details'**
  String get platesDetails;

  /// No description provided for @platesRecentBreakage.
  ///
  /// In en, this message translates to:
  /// **'Recent Breakage Reports'**
  String get platesRecentBreakage;

  /// No description provided for @platesBowlBreakage.
  ///
  /// In en, this message translates to:
  /// **'Ceramic Bowl - 4 Units Broken'**
  String get platesBowlBreakage;

  /// No description provided for @platesBowlBreakageMeta.
  ///
  /// In en, this message translates to:
  /// **'Station: Dishwashing Area • Reported by Sarah M.'**
  String get platesBowlBreakageMeta;

  /// No description provided for @platesMezzeBreakage.
  ///
  /// In en, this message translates to:
  /// **'Mezze Plate - 2 Units Broken'**
  String get platesMezzeBreakage;

  /// No description provided for @platesMezzeBreakageMeta.
  ///
  /// In en, this message translates to:
  /// **'Station: Dining Room • Floor Incident'**
  String get platesMezzeBreakageMeta;

  /// No description provided for @platesTodayTime.
  ///
  /// In en, this message translates to:
  /// **'Today, 2:45 PM'**
  String get platesTodayTime;

  /// No description provided for @platesYesterdayTime.
  ///
  /// In en, this message translates to:
  /// **'Yesterday, 9:12 PM'**
  String get platesYesterdayTime;

  /// No description provided for @platesViewBreakageLog.
  ///
  /// In en, this message translates to:
  /// **'View Full Breakage Log'**
  String get platesViewBreakageLog;

  /// No description provided for @platesRestockAlert.
  ///
  /// In en, this message translates to:
  /// **'Restock Alert'**
  String get platesRestockAlert;

  /// No description provided for @platesRestockBody.
  ///
  /// In en, this message translates to:
  /// **'Large Serving Trays are currently below the safety threshold (50 units).'**
  String get platesRestockBody;

  /// No description provided for @platesAutoRestockLevel.
  ///
  /// In en, this message translates to:
  /// **'Auto-Restock Level'**
  String get platesAutoRestockLevel;

  /// No description provided for @platesEnabled.
  ///
  /// In en, this message translates to:
  /// **'Enabled'**
  String get platesEnabled;

  /// No description provided for @platesUnitsProgress.
  ///
  /// In en, this message translates to:
  /// **'{current}/{total} units'**
  String platesUnitsProgress(int current, int total);

  /// No description provided for @platesOrderNow.
  ///
  /// In en, this message translates to:
  /// **'Order Now'**
  String get platesOrderNow;

  /// No description provided for @productMansafTitle.
  ///
  /// In en, this message translates to:
  /// **'Traditional Lamb Mansaf'**
  String get productMansafTitle;

  /// No description provided for @productMansafDescription.
  ///
  /// In en, this message translates to:
  /// **'The national dish of Jordan. Tender chunks of local lamb cooked in a rich, tangy sauce of fermented dried yogurt (Jameed), served on a bed of aromatic turmeric rice and thin shrak bread. Garnished with golden fried nuts and fresh parsley for a perfect crunch and zest.'**
  String get productMansafDescription;

  /// No description provided for @productRating.
  ///
  /// In en, this message translates to:
  /// **'4.9 (120+ reviews)'**
  String get productRating;

  /// No description provided for @productPrepTime.
  ///
  /// In en, this message translates to:
  /// **'Prep time: 45-60 mins'**
  String get productPrepTime;

  /// No description provided for @productInclVat.
  ///
  /// In en, this message translates to:
  /// **'Incl. VAT'**
  String get productInclVat;

  /// No description provided for @productBestSeller.
  ///
  /// In en, this message translates to:
  /// **'Best Seller'**
  String get productBestSeller;

  /// No description provided for @productLoyaltyOrderAddon.
  ///
  /// In en, this message translates to:
  /// **'Order add-on'**
  String get productLoyaltyOrderAddon;

  /// No description provided for @productChooseYourSide.
  ///
  /// In en, this message translates to:
  /// **'Choose Your Side'**
  String get productChooseYourSide;

  /// No description provided for @productAddExtras.
  ///
  /// In en, this message translates to:
  /// **'Add Extras'**
  String get productAddExtras;

  /// No description provided for @productSizePortion.
  ///
  /// In en, this message translates to:
  /// **'Size Portion'**
  String get productSizePortion;

  /// No description provided for @productRequired.
  ///
  /// In en, this message translates to:
  /// **'Required'**
  String get productRequired;

  /// No description provided for @productSinglePlatter.
  ///
  /// In en, this message translates to:
  /// **'Single Platter'**
  String get productSinglePlatter;

  /// No description provided for @productFamilySize.
  ///
  /// In en, this message translates to:
  /// **'Family Size (4-5 persons)'**
  String get productFamilySize;

  /// No description provided for @productAddonsPreferences.
  ///
  /// In en, this message translates to:
  /// **'Add-ons & Preferences'**
  String get productAddonsPreferences;

  /// No description provided for @productExtraJameed.
  ///
  /// In en, this message translates to:
  /// **'Extra Jameed Sauce'**
  String get productExtraJameed;

  /// No description provided for @productExtraAlmonds.
  ///
  /// In en, this message translates to:
  /// **'Extra Roasted Almonds'**
  String get productExtraAlmonds;

  /// No description provided for @productNoPineNuts.
  ///
  /// In en, this message translates to:
  /// **'No Pine Nuts (Allergy)'**
  String get productNoPineNuts;

  /// No description provided for @productFree.
  ///
  /// In en, this message translates to:
  /// **'Free'**
  String get productFree;

  /// No description provided for @productSpecialInstructions.
  ///
  /// In en, this message translates to:
  /// **'Special Instructions'**
  String get productSpecialInstructions;

  /// No description provided for @productInstructionsHint.
  ///
  /// In en, this message translates to:
  /// **'Any allergies or specific requests?'**
  String get productInstructionsHint;

  /// No description provided for @productAddToCartAmount.
  ///
  /// In en, this message translates to:
  /// **'Add to Cart | {amount}'**
  String productAddToCartAmount(Object amount);

  /// No description provided for @previewProductTitle.
  ///
  /// In en, this message translates to:
  /// **'The Executive Artisanal Platter'**
  String get previewProductTitle;

  /// No description provided for @previewPrice.
  ///
  /// In en, this message translates to:
  /// **'12.50 JOD'**
  String get previewPrice;

  /// No description provided for @previewTaxIncluded.
  ///
  /// In en, this message translates to:
  /// **'Tax incl.'**
  String get previewTaxIncluded;

  /// No description provided for @previewProductBody.
  ///
  /// In en, this message translates to:
  /// **'A curated selection of farm-to-table ingredients including organic poached eggs, hand-crafted sourdough, Hass avocado, and wild arugula. Perfect for high-focus operational fuel.'**
  String get previewProductBody;

  /// No description provided for @previewPreferredBase.
  ///
  /// In en, this message translates to:
  /// **'Preferred Base'**
  String get previewPreferredBase;

  /// No description provided for @previewToastedSourdough.
  ///
  /// In en, this message translates to:
  /// **'Toasted Sourdough'**
  String get previewToastedSourdough;

  /// No description provided for @previewMultigrainToast.
  ///
  /// In en, this message translates to:
  /// **'Multigrain Toast'**
  String get previewMultigrainToast;

  /// No description provided for @previewAddOns.
  ///
  /// In en, this message translates to:
  /// **'Add-ons'**
  String get previewAddOns;

  /// No description provided for @previewExtraSmokedSalmon.
  ///
  /// In en, this message translates to:
  /// **'Extra Smoked Salmon'**
  String get previewExtraSmokedSalmon;

  /// No description provided for @previewDoubleAvocado.
  ///
  /// In en, this message translates to:
  /// **'Double Avocado Portion'**
  String get previewDoubleAvocado;

  /// No description provided for @previewSalmonPrice.
  ///
  /// In en, this message translates to:
  /// **'+3.50 JOD'**
  String get previewSalmonPrice;

  /// No description provided for @previewAvocadoPrice.
  ///
  /// In en, this message translates to:
  /// **'+1.20 JOD'**
  String get previewAvocadoPrice;

  /// No description provided for @previewDietaryNotes.
  ///
  /// In en, this message translates to:
  /// **'Dietary Notes'**
  String get previewDietaryNotes;

  /// No description provided for @previewDietaryMessage.
  ///
  /// In en, this message translates to:
  /// **'Please login to specify allergies or special preparation requests.'**
  String get previewDietaryMessage;

  /// No description provided for @previewLoginAddCart.
  ///
  /// In en, this message translates to:
  /// **'Login to Add to Cart'**
  String get previewLoginAddCart;

  /// No description provided for @previewNewToApp.
  ///
  /// In en, this message translates to:
  /// **'New to Ayletna?'**
  String get previewNewToApp;

  /// No description provided for @previewCreateAccount.
  ///
  /// In en, this message translates to:
  /// **'Create an account'**
  String get previewCreateAccount;

  /// No description provided for @registerJoinTitle.
  ///
  /// In en, this message translates to:
  /// **'Join Ayletna'**
  String get registerJoinTitle;

  /// No description provided for @registerJoinSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Create your account to start managing your culinary experience.'**
  String get registerJoinSubtitle;

  /// No description provided for @registerFullName.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get registerFullName;

  /// No description provided for @registerNameHint.
  ///
  /// In en, this message translates to:
  /// **'John Doe'**
  String get registerNameHint;

  /// No description provided for @registerPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get registerPhoneNumber;

  /// No description provided for @registerPhoneHint.
  ///
  /// In en, this message translates to:
  /// **'+962 7 0000 0000'**
  String get registerPhoneHint;

  /// No description provided for @registerEmailAddress.
  ///
  /// In en, this message translates to:
  /// **'Email Address'**
  String get registerEmailAddress;

  /// No description provided for @registerEmailHint.
  ///
  /// In en, this message translates to:
  /// **'john@example.com'**
  String get registerEmailHint;

  /// No description provided for @registerConfirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get registerConfirmPassword;

  /// No description provided for @registerAgreePrefix.
  ///
  /// In en, this message translates to:
  /// **'I agree to the'**
  String get registerAgreePrefix;

  /// No description provided for @registerTermsService.
  ///
  /// In en, this message translates to:
  /// **'Terms of Service'**
  String get registerTermsService;

  /// No description provided for @registerPrivacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get registerPrivacyPolicy;

  /// No description provided for @registerAnd.
  ///
  /// In en, this message translates to:
  /// **'and'**
  String get registerAnd;

  /// No description provided for @registerOr.
  ///
  /// In en, this message translates to:
  /// **'OR'**
  String get registerOr;

  /// No description provided for @registerAlreadyAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get registerAlreadyAccount;

  /// No description provided for @registerLogin.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get registerLogin;

  /// No description provided for @registerStepTwoTitle.
  ///
  /// In en, this message translates to:
  /// **'Step 2 of 3'**
  String get registerStepTwoTitle;

  /// No description provided for @registerVerifyNumberTitle.
  ///
  /// In en, this message translates to:
  /// **'Verify your number'**
  String get registerVerifyNumberTitle;

  /// No description provided for @registerSixDigitSent.
  ///
  /// In en, this message translates to:
  /// **'We\'ve sent a 6-digit code to {phone}'**
  String registerSixDigitSent(String phone);

  /// No description provided for @registerMaskedPhone.
  ///
  /// In en, this message translates to:
  /// **'+962 7•• ••89'**
  String get registerMaskedPhone;

  /// No description provided for @registerDidntReceive.
  ///
  /// In en, this message translates to:
  /// **'Didn\'t receive the code?'**
  String get registerDidntReceive;

  /// No description provided for @registerResendCountdown.
  ///
  /// In en, this message translates to:
  /// **'Resend in 00:57'**
  String get registerResendCountdown;

  /// No description provided for @registerVerifyContinue.
  ///
  /// In en, this message translates to:
  /// **'Verify & Continue'**
  String get registerVerifyContinue;

  /// No description provided for @registerStepTwoLabel.
  ///
  /// In en, this message translates to:
  /// **'Step 2: Phone Verification'**
  String get registerStepTwoLabel;

  /// No description provided for @registerStepThreeTitle.
  ///
  /// In en, this message translates to:
  /// **'Step 3 of 3'**
  String get registerStepThreeTitle;

  /// No description provided for @registerPreferencesTitle.
  ///
  /// In en, this message translates to:
  /// **'Your food preferences'**
  String get registerPreferencesTitle;

  /// No description provided for @registerPreferencesSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Tell us what you enjoy so Ayletna can recommend meals that feel made for you.'**
  String get registerPreferencesSubtitle;

  /// No description provided for @registerPrimaryRole.
  ///
  /// In en, this message translates to:
  /// **'Your Ayletna experience'**
  String get registerPrimaryRole;

  /// No description provided for @registerRoleCustomer.
  ///
  /// In en, this message translates to:
  /// **'Customer'**
  String get registerRoleCustomer;

  /// No description provided for @registerRoleCustomerBody.
  ///
  /// In en, this message translates to:
  /// **'Order delicious meals, track delivery, and manage your favorites.'**
  String get registerRoleCustomerBody;

  /// No description provided for @registerRoleStaff.
  ///
  /// In en, this message translates to:
  /// **'Restaurant Staff'**
  String get registerRoleStaff;

  /// No description provided for @registerRoleStaffBody.
  ///
  /// In en, this message translates to:
  /// **'Access KDS, manage inventory, and process active orders.'**
  String get registerRoleStaffBody;

  /// No description provided for @registerRoleOperator.
  ///
  /// In en, this message translates to:
  /// **'Restaurant Operator'**
  String get registerRoleOperator;

  /// No description provided for @registerRoleOperatorBody.
  ///
  /// In en, this message translates to:
  /// **'Run daily operations — orders, menu, staff, and financial close. Requires app admin approval.'**
  String get registerRoleOperatorBody;

  /// No description provided for @registerRoleOwner.
  ///
  /// In en, this message translates to:
  /// **'Restaurant Owner'**
  String get registerRoleOwner;

  /// No description provided for @registerRoleOwnerBody.
  ///
  /// In en, this message translates to:
  /// **'View revenue, profit share, and audit summaries. Requires app admin approval.'**
  String get registerRoleOwnerBody;

  /// No description provided for @registerRoleAdminOwner.
  ///
  /// In en, this message translates to:
  /// **'Admin / Owner'**
  String get registerRoleAdminOwner;

  /// No description provided for @registerRoleAdminOwnerBody.
  ///
  /// In en, this message translates to:
  /// **'View deep analytics, manage staff, and optimize store sustainability.'**
  String get registerRoleAdminOwnerBody;

  /// No description provided for @registerDietaryPreferences.
  ///
  /// In en, this message translates to:
  /// **'Dietary Preferences'**
  String get registerDietaryPreferences;

  /// No description provided for @registerDietVegetarian.
  ///
  /// In en, this message translates to:
  /// **'Vegetarian'**
  String get registerDietVegetarian;

  /// No description provided for @registerDietHalal.
  ///
  /// In en, this message translates to:
  /// **'Halal'**
  String get registerDietHalal;

  /// No description provided for @registerDietGlutenFree.
  ///
  /// In en, this message translates to:
  /// **'Gluten-Free'**
  String get registerDietGlutenFree;

  /// No description provided for @registerCompleteProfile.
  ///
  /// In en, this message translates to:
  /// **'Complete Profile'**
  String get registerCompleteProfile;

  /// No description provided for @registerSetupProgress.
  ///
  /// In en, this message translates to:
  /// **'Setup Progress'**
  String get registerSetupProgress;

  /// No description provided for @registerSetupPercent.
  ///
  /// In en, this message translates to:
  /// **'100%'**
  String get registerSetupPercent;

  /// No description provided for @reportsBreadcrumb.
  ///
  /// In en, this message translates to:
  /// **'Dashboard / Reports Center'**
  String get reportsBreadcrumb;

  /// No description provided for @reportsCenterTitle.
  ///
  /// In en, this message translates to:
  /// **'Reports & Analytics'**
  String get reportsCenterTitle;

  /// No description provided for @reportsCenterSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Review your daily performance and download detailed documentation.'**
  String get reportsCenterSubtitle;

  /// No description provided for @reportsDaily.
  ///
  /// In en, this message translates to:
  /// **'Daily'**
  String get reportsDaily;

  /// No description provided for @reportsWeekly.
  ///
  /// In en, this message translates to:
  /// **'Weekly'**
  String get reportsWeekly;

  /// No description provided for @reportsMonthly.
  ///
  /// In en, this message translates to:
  /// **'Monthly'**
  String get reportsMonthly;

  /// No description provided for @reportsDailySales.
  ///
  /// In en, this message translates to:
  /// **'Daily Sales'**
  String get reportsDailySales;

  /// No description provided for @reportsDailySalesAmount.
  ///
  /// In en, this message translates to:
  /// **'JOD 4,280.50'**
  String get reportsDailySalesAmount;

  /// No description provided for @reportsSalesDelta.
  ///
  /// In en, this message translates to:
  /// **'+12.4% vs yesterday'**
  String get reportsSalesDelta;

  /// No description provided for @reportsTipTotals.
  ///
  /// In en, this message translates to:
  /// **'Tip Totals'**
  String get reportsTipTotals;

  /// No description provided for @reportsTipTotalAmount.
  ///
  /// In en, this message translates to:
  /// **'JOD 312.00'**
  String get reportsTipTotalAmount;

  /// No description provided for @reportsTipDistributed.
  ///
  /// In en, this message translates to:
  /// **'Distributed to 14 staff members'**
  String get reportsTipDistributed;

  /// No description provided for @reportsBreakageCosts.
  ///
  /// In en, this message translates to:
  /// **'Breakage Costs'**
  String get reportsBreakageCosts;

  /// No description provided for @reportsBreakageAmount.
  ///
  /// In en, this message translates to:
  /// **'JOD 45.25'**
  String get reportsBreakageAmount;

  /// No description provided for @reportsBreakageItems.
  ///
  /// In en, this message translates to:
  /// **'3 items recorded today'**
  String get reportsBreakageItems;

  /// No description provided for @reportsDetailedReports.
  ///
  /// In en, this message translates to:
  /// **'Detailed Reports'**
  String get reportsDetailedReports;

  /// No description provided for @reportsSalesRevenue.
  ///
  /// In en, this message translates to:
  /// **'Sales & Revenue'**
  String get reportsSalesRevenue;

  /// No description provided for @reportsSalesRevenueBody.
  ///
  /// In en, this message translates to:
  /// **'Complete breakdown of transactions, tax, and tender types.'**
  String get reportsSalesRevenueBody;

  /// No description provided for @reportsStaffTips.
  ///
  /// In en, this message translates to:
  /// **'Staff Hours & Tips'**
  String get reportsStaffTips;

  /// No description provided for @reportsStaffTipsBody.
  ///
  /// In en, this message translates to:
  /// **'Timesheets, overtime alerts, and tip distribution logs.'**
  String get reportsStaffTipsBody;

  /// No description provided for @reportsInventoryWastage.
  ///
  /// In en, this message translates to:
  /// **'Inventory & Wastage'**
  String get reportsInventoryWastage;

  /// No description provided for @reportsInventoryWastageBody.
  ///
  /// In en, this message translates to:
  /// **'Stock levels, shrinkage reports, and food waste analysis.'**
  String get reportsInventoryWastageBody;

  /// No description provided for @reportsSustainability.
  ///
  /// In en, this message translates to:
  /// **'Sustainability (Tray Returns)'**
  String get reportsSustainability;

  /// No description provided for @reportsSustainabilityBody.
  ///
  /// In en, this message translates to:
  /// **'Tray return rates, reusable utensil tracking, and green initiatives.'**
  String get reportsSustainabilityBody;

  /// No description provided for @reportsDownloadPdf.
  ///
  /// In en, this message translates to:
  /// **'Download PDF'**
  String get reportsDownloadPdf;

  /// No description provided for @reportsExportCsv.
  ///
  /// In en, this message translates to:
  /// **'Export CSV'**
  String get reportsExportCsv;

  /// No description provided for @reportsRevenueTrend.
  ///
  /// In en, this message translates to:
  /// **'Revenue Trend'**
  String get reportsRevenueTrend;

  /// No description provided for @reportsLast24Hours.
  ///
  /// In en, this message translates to:
  /// **'Last 24 Hours'**
  String get reportsLast24Hours;

  /// No description provided for @reportsNavHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get reportsNavHome;

  /// No description provided for @reportsNavReports.
  ///
  /// In en, this message translates to:
  /// **'Reports'**
  String get reportsNavReports;

  /// No description provided for @reportsNavStock.
  ///
  /// In en, this message translates to:
  /// **'Stock'**
  String get reportsNavStock;

  /// No description provided for @reportsNavProfile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get reportsNavProfile;

  /// No description provided for @rewardsCatalogTitle.
  ///
  /// In en, this message translates to:
  /// **'Rewards Catalog'**
  String get rewardsCatalogTitle;

  /// No description provided for @rewardsYourBalance.
  ///
  /// In en, this message translates to:
  /// **'YOUR BALANCE'**
  String get rewardsYourBalance;

  /// No description provided for @rewardsPointsValue.
  ///
  /// In en, this message translates to:
  /// **'4,850'**
  String get rewardsPointsValue;

  /// No description provided for @rewardsSavorPoints.
  ///
  /// In en, this message translates to:
  /// **'Savor Points'**
  String get rewardsSavorPoints;

  /// No description provided for @rewardsMemberSince.
  ///
  /// In en, this message translates to:
  /// **'Member Since 2023'**
  String get rewardsMemberSince;

  /// No description provided for @guestRewardsPreviewBody.
  ///
  /// In en, this message translates to:
  /// **'Browse rewards now. Create an account before checkout to keep every point you earn.'**
  String get guestRewardsPreviewBody;

  /// No description provided for @guestRewardsPreviewAction.
  ///
  /// In en, this message translates to:
  /// **'Create account to earn points'**
  String get guestRewardsPreviewAction;

  /// No description provided for @rewardsSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search rewards...'**
  String get rewardsSearchHint;

  /// No description provided for @rewardsAllItems.
  ///
  /// In en, this message translates to:
  /// **'All Items'**
  String get rewardsAllItems;

  /// No description provided for @rewardsDrinks.
  ///
  /// In en, this message translates to:
  /// **'Drinks'**
  String get rewardsDrinks;

  /// No description provided for @rewardsSides.
  ///
  /// In en, this message translates to:
  /// **'Sides'**
  String get rewardsSides;

  /// No description provided for @rewardsMainCourse.
  ///
  /// In en, this message translates to:
  /// **'Main Course'**
  String get rewardsMainCourse;

  /// No description provided for @rewardsFeaturedReward.
  ///
  /// In en, this message translates to:
  /// **'FEATURED REWARD'**
  String get rewardsFeaturedReward;

  /// No description provided for @rewardsSignatureBurger.
  ///
  /// In en, this message translates to:
  /// **'Signature Wagyu Burger'**
  String get rewardsSignatureBurger;

  /// No description provided for @rewardsSignatureBurgerBody.
  ///
  /// In en, this message translates to:
  /// **'Redeem for a full dining experience'**
  String get rewardsSignatureBurgerBody;

  /// No description provided for @rewardsPointsShort.
  ///
  /// In en, this message translates to:
  /// **'PTS'**
  String get rewardsPointsShort;

  /// No description provided for @rewardsNitroColdBrew.
  ///
  /// In en, this message translates to:
  /// **'Nitro Cold Brew'**
  String get rewardsNitroColdBrew;

  /// No description provided for @rewardsTruffleParmFries.
  ///
  /// In en, this message translates to:
  /// **'Truffle Parm Fries'**
  String get rewardsTruffleParmFries;

  /// No description provided for @rewardsBerryPowerBowl.
  ///
  /// In en, this message translates to:
  /// **'Berry Power Bowl'**
  String get rewardsBerryPowerBowl;

  /// No description provided for @rewardsDonutSelection.
  ///
  /// In en, this message translates to:
  /// **'Donut Selection'**
  String get rewardsDonutSelection;

  /// No description provided for @rewardsSoldOut.
  ///
  /// In en, this message translates to:
  /// **'Sold Out'**
  String get rewardsSoldOut;

  /// No description provided for @rewardsSideBadge.
  ///
  /// In en, this message translates to:
  /// **'SIDE'**
  String get rewardsSideBadge;

  /// No description provided for @rewardsMainBadge.
  ///
  /// In en, this message translates to:
  /// **'MAIN'**
  String get rewardsMainBadge;

  /// No description provided for @rewardsOrdersNav.
  ///
  /// In en, this message translates to:
  /// **'Orders'**
  String get rewardsOrdersNav;

  /// No description provided for @rewardsPosNav.
  ///
  /// In en, this message translates to:
  /// **'POS'**
  String get rewardsPosNav;

  /// No description provided for @rewardsRewardsNav.
  ///
  /// In en, this message translates to:
  /// **'Rewards'**
  String get rewardsRewardsNav;

  /// No description provided for @rewardsDeliveryNav.
  ///
  /// In en, this message translates to:
  /// **'Delivery'**
  String get rewardsDeliveryNav;

  /// No description provided for @rewardsAdminNav.
  ///
  /// In en, this message translates to:
  /// **'Admin'**
  String get rewardsAdminNav;

  /// No description provided for @roleSelectionMockTitle.
  ///
  /// In en, this message translates to:
  /// **'Choose your role'**
  String get roleSelectionMockTitle;

  /// No description provided for @roleSelectionWelcome.
  ///
  /// In en, this message translates to:
  /// **'Select Your Portal'**
  String get roleSelectionWelcome;

  /// No description provided for @roleSelectionSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Choose your role to access specialized tools and services.'**
  String get roleSelectionSubtitle;

  /// No description provided for @roleSelectionCustomerTitle.
  ///
  /// In en, this message translates to:
  /// **'Customer'**
  String get roleSelectionCustomerTitle;

  /// No description provided for @roleSelectionCustomerBody.
  ///
  /// In en, this message translates to:
  /// **'Browse our menu, place orders for dine-in or takeaway, and track your loyalty rewards in real-time.'**
  String get roleSelectionCustomerBody;

  /// No description provided for @roleSelectionMockCustomerMetric.
  ///
  /// In en, this message translates to:
  /// **'Customer storefront'**
  String get roleSelectionMockCustomerMetric;

  /// No description provided for @roleSelectionCustomerChipMenu.
  ///
  /// In en, this message translates to:
  /// **'Menu'**
  String get roleSelectionCustomerChipMenu;

  /// No description provided for @roleSelectionCustomerChipReservations.
  ///
  /// In en, this message translates to:
  /// **'Reservations'**
  String get roleSelectionCustomerChipReservations;

  /// No description provided for @roleSelectionOwnerTitle.
  ///
  /// In en, this message translates to:
  /// **'Owner'**
  String get roleSelectionOwnerTitle;

  /// No description provided for @roleSelectionOwnerBody.
  ///
  /// In en, this message translates to:
  /// **'Strategic overview of revenue, waste analytics, and multi-location growth metrics.'**
  String get roleSelectionOwnerBody;

  /// No description provided for @roleSelectionOwnerMetric.
  ///
  /// In en, this message translates to:
  /// **'Daily Revenue: +12%'**
  String get roleSelectionOwnerMetric;

  /// No description provided for @roleSelectionCashierTitle.
  ///
  /// In en, this message translates to:
  /// **'Cashier'**
  String get roleSelectionCashierTitle;

  /// No description provided for @roleSelectionCashierBody.
  ///
  /// In en, this message translates to:
  /// **'Front-of-house operations, rapid checkout, and guest table management.'**
  String get roleSelectionCashierBody;

  /// No description provided for @roleSelectionOpenRegister.
  ///
  /// In en, this message translates to:
  /// **'Open Register'**
  String get roleSelectionOpenRegister;

  /// No description provided for @roleSelectionKitchenTitle.
  ///
  /// In en, this message translates to:
  /// **'Kitchen Staff'**
  String get roleSelectionKitchenTitle;

  /// No description provided for @roleSelectionKitchenBody.
  ///
  /// In en, this message translates to:
  /// **'KDS tile management, order prioritization, and ingredient stock alerts.'**
  String get roleSelectionKitchenBody;

  /// No description provided for @roleSelectionAdminMetric.
  ///
  /// In en, this message translates to:
  /// **'System Health: 100%'**
  String get roleSelectionAdminMetric;

  /// No description provided for @roleSelectionOperatorMetric.
  ///
  /// In en, this message translates to:
  /// **'8 Active Orders'**
  String get roleSelectionOperatorMetric;

  /// No description provided for @roleSelectionSupportMetric.
  ///
  /// In en, this message translates to:
  /// **'2 Pending Tickets'**
  String get roleSelectionSupportMetric;

  /// No description provided for @roleSelectionMarketingMetric.
  ///
  /// In en, this message translates to:
  /// **'3 Active Promos'**
  String get roleSelectionMarketingMetric;

  /// No description provided for @roleSelectionKitchenMetric.
  ///
  /// In en, this message translates to:
  /// **'12 Active Orders'**
  String get roleSelectionKitchenMetric;

  /// No description provided for @roleSelectionAdminTitle.
  ///
  /// In en, this message translates to:
  /// **'Admin / Operator'**
  String get roleSelectionAdminTitle;

  /// No description provided for @roleSelectionAdminBody.
  ///
  /// In en, this message translates to:
  /// **'Manage staff permissions, inventory procurement, and system configurations.'**
  String get roleSelectionAdminBody;

  /// No description provided for @roleSelectionSystemOnline.
  ///
  /// In en, this message translates to:
  /// **'SYSTEM STATUS: ONLINE'**
  String get roleSelectionSystemOnline;

  /// No description provided for @roleSelectionInventoryTitle.
  ///
  /// In en, this message translates to:
  /// **'Inventory'**
  String get roleSelectionInventoryTitle;

  /// No description provided for @roleSelectionInventoryBody.
  ///
  /// In en, this message translates to:
  /// **'Review stock levels, wastage logs, ingredient details, and adjustment screens.'**
  String get roleSelectionInventoryBody;

  /// No description provided for @roleSelectionOpenInventory.
  ///
  /// In en, this message translates to:
  /// **'Open Inventory'**
  String get roleSelectionOpenInventory;

  /// No description provided for @roleSelectionStaffTitle.
  ///
  /// In en, this message translates to:
  /// **'Staff'**
  String get roleSelectionStaffTitle;

  /// No description provided for @roleSelectionStaffBody.
  ///
  /// In en, this message translates to:
  /// **'Audit attendance, daily tips, and staff tip history screens.'**
  String get roleSelectionStaffBody;

  /// No description provided for @roleSelectionOpenAttendance.
  ///
  /// In en, this message translates to:
  /// **'Open Attendance'**
  String get roleSelectionOpenAttendance;

  /// No description provided for @roleSelectionDeliveryTitle.
  ///
  /// In en, this message translates to:
  /// **'Delivery Agent'**
  String get roleSelectionDeliveryTitle;

  /// No description provided for @roleSelectionDeliveryBody.
  ///
  /// In en, this message translates to:
  /// **'Route optimization, order pickup confirmation, and digital proof-of-delivery.'**
  String get roleSelectionDeliveryBody;

  /// No description provided for @roleSelectionStartShift.
  ///
  /// In en, this message translates to:
  /// **'Start Shift'**
  String get roleSelectionStartShift;

  /// No description provided for @roleSelectionFooter.
  ///
  /// In en, this message translates to:
  /// **'Select a workspace to continue. Permissions are assigned by your administrator.'**
  String get roleSelectionFooter;

  /// No description provided for @orderTypeTitle.
  ///
  /// In en, this message translates to:
  /// **'How would you like to savor?'**
  String get orderTypeTitle;

  /// No description provided for @orderTypeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Choose your dining experience to view the appropriate menu.'**
  String get orderTypeSubtitle;

  /// No description provided for @orderTypeDineInBody.
  ///
  /// In en, this message translates to:
  /// **'Reserve your spot and enjoy the full restaurant ambiance with table service.'**
  String get orderTypeDineInBody;

  /// No description provided for @orderTypeDineInAction.
  ///
  /// In en, this message translates to:
  /// **'Select Table'**
  String get orderTypeDineInAction;

  /// No description provided for @orderTypeTakeawayBody.
  ///
  /// In en, this message translates to:
  /// **'Order ahead and pick up your meal at the designated counter. Fast & convenient.'**
  String get orderTypeTakeawayBody;

  /// No description provided for @orderTypeTakeawayAction.
  ///
  /// In en, this message translates to:
  /// **'Select Pickup'**
  String get orderTypeTakeawayAction;

  /// No description provided for @orderTypeDeliveryTitle.
  ///
  /// In en, this message translates to:
  /// **'Standard Delivery'**
  String get orderTypeDeliveryTitle;

  /// No description provided for @orderTypeDeliveryBody.
  ///
  /// In en, this message translates to:
  /// **'Reliable delivery to your doorstep. Hot and fresh meals within 30-45 minutes.'**
  String get orderTypeDeliveryBody;

  /// No description provided for @orderTypeDeliveryAction.
  ///
  /// In en, this message translates to:
  /// **'Set Address'**
  String get orderTypeDeliveryAction;

  /// No description provided for @orderTypePlatedTitle.
  ///
  /// In en, this message translates to:
  /// **'Plated Delivery'**
  String get orderTypePlatedTitle;

  /// No description provided for @orderTypePlatedBadge.
  ///
  /// In en, this message translates to:
  /// **'Sustainability'**
  String get orderTypePlatedBadge;

  /// No description provided for @orderTypePlatedBody.
  ///
  /// In en, this message translates to:
  /// **'Premium experience using reusable ceramic plating. We pick up the dishes later.'**
  String get orderTypePlatedBody;

  /// No description provided for @orderTypePlatedAction.
  ///
  /// In en, this message translates to:
  /// **'Select Premium'**
  String get orderTypePlatedAction;

  /// No description provided for @orderTypeNearbyCount.
  ///
  /// In en, this message translates to:
  /// **'15 people are currently ordering nearby'**
  String get orderTypeNearbyCount;

  /// No description provided for @orderTypeGroupOrder.
  ///
  /// In en, this message translates to:
  /// **'Group Order'**
  String get orderTypeGroupOrder;

  /// No description provided for @orderTypeTerms.
  ///
  /// In en, this message translates to:
  /// **'Terms of Service'**
  String get orderTypeTerms;

  /// No description provided for @termsHeroTitle.
  ///
  /// In en, this message translates to:
  /// **'Order Terms & Conditions'**
  String get termsHeroTitle;

  /// No description provided for @termsHeroSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Review the checkout rules before placing an order.'**
  String get termsHeroSubtitle;

  /// No description provided for @termsPaymentTitle.
  ///
  /// In en, this message translates to:
  /// **'Payment and confirmation'**
  String get termsPaymentTitle;

  /// No description provided for @termsPaymentBody.
  ///
  /// In en, this message translates to:
  /// **'Orders are confirmed after choosing a fulfillment method and completing payment. Fees may vary by service type and address.'**
  String get termsPaymentBody;

  /// No description provided for @termsGroupDeliveryTitle.
  ///
  /// In en, this message translates to:
  /// **'Group delivery'**
  String get termsGroupDeliveryTitle;

  /// No description provided for @termsGroupDeliveryBody.
  ///
  /// In en, this message translates to:
  /// **'When group delivery is selected, the order may wait for another nearby order in the same area to reduce delivery cost and improve route efficiency.'**
  String get termsGroupDeliveryBody;

  /// No description provided for @termsChangesTitle.
  ///
  /// In en, this message translates to:
  /// **'Changes and cancellation'**
  String get termsChangesTitle;

  /// No description provided for @termsChangesBody.
  ///
  /// In en, this message translates to:
  /// **'Orders can be changed before preparation starts. Once preparation begins, some changes or cancellation may no longer be available.'**
  String get termsChangesBody;

  /// No description provided for @orderTypeNavHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get orderTypeNavHome;

  /// No description provided for @orderTypeNavOrders.
  ///
  /// In en, this message translates to:
  /// **'Orders'**
  String get orderTypeNavOrders;

  /// No description provided for @orderTypeNavKitchen.
  ///
  /// In en, this message translates to:
  /// **'Kitchen'**
  String get orderTypeNavKitchen;

  /// No description provided for @orderTypeNavFinance.
  ///
  /// In en, this message translates to:
  /// **'Finance'**
  String get orderTypeNavFinance;

  /// No description provided for @orderTypeNavMenu.
  ///
  /// In en, this message translates to:
  /// **'Menu'**
  String get orderTypeNavMenu;

  /// No description provided for @returnFindOrder.
  ///
  /// In en, this message translates to:
  /// **'Find Return Order'**
  String get returnFindOrder;

  /// No description provided for @returnSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Receipt ID or Phone Number...'**
  String get returnSearchHint;

  /// No description provided for @returnActiveDeposits.
  ///
  /// In en, this message translates to:
  /// **'ACTIVE DEPOSITS'**
  String get returnActiveDeposits;

  /// No description provided for @returnPendingCount.
  ///
  /// In en, this message translates to:
  /// **'12 Pending'**
  String get returnPendingCount;

  /// No description provided for @returnReceipt8821.
  ///
  /// In en, this message translates to:
  /// **'#REC-8821'**
  String get returnReceipt8821;

  /// No description provided for @returnReceipt7734.
  ///
  /// In en, this message translates to:
  /// **'#REC-7734'**
  String get returnReceipt7734;

  /// No description provided for @returnAlexJohnson.
  ///
  /// In en, this message translates to:
  /// **'Alex Johnston'**
  String get returnAlexJohnson;

  /// No description provided for @returnSarahMiller.
  ///
  /// In en, this message translates to:
  /// **'Sarah Miller'**
  String get returnSarahMiller;

  /// No description provided for @returnAmount25.
  ///
  /// In en, this message translates to:
  /// **'25.00'**
  String get returnAmount25;

  /// No description provided for @returnAmount15.
  ///
  /// In en, this message translates to:
  /// **'15.00'**
  String get returnAmount15;

  /// No description provided for @returnZeroDeduction.
  ///
  /// In en, this message translates to:
  /// **'-0.00'**
  String get returnZeroDeduction;

  /// No description provided for @returnDeposit.
  ///
  /// In en, this message translates to:
  /// **'DEPOSIT'**
  String get returnDeposit;

  /// No description provided for @returnProcessing.
  ///
  /// In en, this message translates to:
  /// **'Processing'**
  String get returnProcessing;

  /// No description provided for @returnCurrentReceipt.
  ///
  /// In en, this message translates to:
  /// **'#REC-8821'**
  String get returnCurrentReceipt;

  /// No description provided for @returnOfficialDeposit.
  ///
  /// In en, this message translates to:
  /// **'OFFICIAL DEPOSIT'**
  String get returnOfficialDeposit;

  /// No description provided for @returnCustomerLine.
  ///
  /// In en, this message translates to:
  /// **'Customer: Alex Johnston • 04/10/2023'**
  String get returnCustomerLine;

  /// No description provided for @returnCheckDamage.
  ///
  /// In en, this message translates to:
  /// **'Check for Damage'**
  String get returnCheckDamage;

  /// No description provided for @returnMainTray.
  ///
  /// In en, this message translates to:
  /// **'Main Tray'**
  String get returnMainTray;

  /// No description provided for @returnPlates.
  ///
  /// In en, this message translates to:
  /// **'Plates (2x)'**
  String get returnPlates;

  /// No description provided for @returnCutlerySet.
  ///
  /// In en, this message translates to:
  /// **'Cutlery Set'**
  String get returnCutlerySet;

  /// No description provided for @returnBrokenMissing.
  ///
  /// In en, this message translates to:
  /// **'BROKEN / MISSING'**
  String get returnBrokenMissing;

  /// No description provided for @returnBaseRefund.
  ///
  /// In en, this message translates to:
  /// **'Base Refund'**
  String get returnBaseRefund;

  /// No description provided for @returnDamageDeductions.
  ///
  /// In en, this message translates to:
  /// **'Damage Deductions'**
  String get returnDamageDeductions;

  /// No description provided for @returnTotalRefund.
  ///
  /// In en, this message translates to:
  /// **'Total Refund'**
  String get returnTotalRefund;

  /// No description provided for @returnRefundCash.
  ///
  /// In en, this message translates to:
  /// **'Refund to Cash'**
  String get returnRefundCash;

  /// No description provided for @returnRefundWallet.
  ///
  /// In en, this message translates to:
  /// **'Refund to Wallet'**
  String get returnRefundWallet;

  /// No description provided for @returnPolicyTip.
  ///
  /// In en, this message translates to:
  /// **'Policy Tip'**
  String get returnPolicyTip;

  /// No description provided for @returnPolicyTipBody.
  ///
  /// In en, this message translates to:
  /// **'Stains on linens are not charged as damage.'**
  String get returnPolicyTipBody;

  /// No description provided for @returnManagerOverride.
  ///
  /// In en, this message translates to:
  /// **'Manager Override'**
  String get returnManagerOverride;

  /// No description provided for @returnManagerOverrideBody.
  ///
  /// In en, this message translates to:
  /// **'Scan ID to waive damage fees.'**
  String get returnManagerOverrideBody;

  /// No description provided for @returnNavHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get returnNavHome;

  /// No description provided for @returnNavOrders.
  ///
  /// In en, this message translates to:
  /// **'Orders'**
  String get returnNavOrders;

  /// No description provided for @returnNavKitchen.
  ///
  /// In en, this message translates to:
  /// **'Kitchen'**
  String get returnNavKitchen;

  /// No description provided for @returnNavFinance.
  ///
  /// In en, this message translates to:
  /// **'Finance'**
  String get returnNavFinance;

  /// No description provided for @returnNavMenu.
  ///
  /// In en, this message translates to:
  /// **'Menu'**
  String get returnNavMenu;

  /// No description provided for @returnIdentifyOrder.
  ///
  /// In en, this message translates to:
  /// **'Identify Order'**
  String get returnIdentifyOrder;

  /// No description provided for @returnScanTrayTag.
  ///
  /// In en, this message translates to:
  /// **'Scan Tray Tag or Order ID'**
  String get returnScanTrayTag;

  /// No description provided for @returnDetailSearchValue.
  ///
  /// In en, this message translates to:
  /// **'#LJ-9928-XT'**
  String get returnDetailSearchValue;

  /// No description provided for @returnQrPrompt.
  ///
  /// In en, this message translates to:
  /// **'Position QR code within frame for auto-scan'**
  String get returnQrPrompt;

  /// No description provided for @returnRetrieveOrderData.
  ///
  /// In en, this message translates to:
  /// **'Retrieve Order Data'**
  String get returnRetrieveOrderData;

  /// No description provided for @returnRecentSelfReturns.
  ///
  /// In en, this message translates to:
  /// **'Recent Self-Returns'**
  String get returnRecentSelfReturns;

  /// No description provided for @returnRecentP2812.
  ///
  /// In en, this message translates to:
  /// **'P2812'**
  String get returnRecentP2812;

  /// No description provided for @returnRecentProcessed2m.
  ///
  /// In en, this message translates to:
  /// **'Processed 2m ago'**
  String get returnRecentProcessed2m;

  /// No description provided for @returnRecentP9809.
  ///
  /// In en, this message translates to:
  /// **'P9809'**
  String get returnRecentP9809;

  /// No description provided for @returnRecentProcessed5m.
  ///
  /// In en, this message translates to:
  /// **'Processed 5m ago'**
  String get returnRecentProcessed5m;

  /// No description provided for @returnOrder9928.
  ///
  /// In en, this message translates to:
  /// **'Order #9928 - James Wilson'**
  String get returnOrder9928;

  /// No description provided for @returnActiveReturn.
  ///
  /// In en, this message translates to:
  /// **'ACTIVE RETURN'**
  String get returnActiveReturn;

  /// No description provided for @returnOriginalService.
  ///
  /// In en, this message translates to:
  /// **'Original Service'**
  String get returnOriginalService;

  /// No description provided for @returnDineInTable14.
  ///
  /// In en, this message translates to:
  /// **'Dine-In • Table 14'**
  String get returnDineInTable14;

  /// No description provided for @returnVerifyConditions.
  ///
  /// In en, this message translates to:
  /// **'Verify Item Conditions'**
  String get returnVerifyConditions;

  /// No description provided for @returnSignatureCeramicPlatter.
  ///
  /// In en, this message translates to:
  /// **'Signature Ceramic Platter'**
  String get returnSignatureCeramicPlatter;

  /// No description provided for @returnStandardServiceTray.
  ///
  /// In en, this message translates to:
  /// **'Standard Service Tray'**
  String get returnStandardServiceTray;

  /// No description provided for @returnPlatterDeposit.
  ///
  /// In en, this message translates to:
  /// **'\$10.00 Deposit'**
  String get returnPlatterDeposit;

  /// No description provided for @returnTrayDeposit.
  ///
  /// In en, this message translates to:
  /// **'\$2.00 Deposit'**
  String get returnTrayDeposit;

  /// No description provided for @returnReturnedGood.
  ///
  /// In en, this message translates to:
  /// **'Returned (Good)'**
  String get returnReturnedGood;

  /// No description provided for @returnDamagedLost.
  ///
  /// In en, this message translates to:
  /// **'Damaged/Lost'**
  String get returnDamagedLost;

  /// No description provided for @returnSummaryCeramicPlatter.
  ///
  /// In en, this message translates to:
  /// **'Ceramic Platter (Returned)'**
  String get returnSummaryCeramicPlatter;

  /// No description provided for @returnSummaryServiceTray.
  ///
  /// In en, this message translates to:
  /// **'Service Tray (Returned)'**
  String get returnSummaryServiceTray;

  /// No description provided for @returnSummarySustainabilityBonus.
  ///
  /// In en, this message translates to:
  /// **'Sustainability Bonus'**
  String get returnSummarySustainabilityBonus;

  /// No description provided for @returnSummaryInstantRefund.
  ///
  /// In en, this message translates to:
  /// **'Total Instant Refund'**
  String get returnSummaryInstantRefund;

  /// No description provided for @returnSummaryDestination.
  ///
  /// In en, this message translates to:
  /// **'Destination: Customer Wallet'**
  String get returnSummaryDestination;

  /// No description provided for @returnProcessClose.
  ///
  /// In en, this message translates to:
  /// **'Process Refund & Close'**
  String get returnProcessClose;

  /// No description provided for @returnReportIssue.
  ///
  /// In en, this message translates to:
  /// **'Report Issue'**
  String get returnReportIssue;

  /// No description provided for @returnAmount4_50.
  ///
  /// In en, this message translates to:
  /// **'+\$4.50'**
  String get returnAmount4_50;

  /// No description provided for @returnAmount12.
  ///
  /// In en, this message translates to:
  /// **'+\$12.00'**
  String get returnAmount12;

  /// No description provided for @returnAmount10.
  ///
  /// In en, this message translates to:
  /// **'+\$10.00'**
  String get returnAmount10;

  /// No description provided for @returnAmount2.
  ///
  /// In en, this message translates to:
  /// **'+\$2.00'**
  String get returnAmount2;

  /// No description provided for @returnAmount0_50.
  ///
  /// In en, this message translates to:
  /// **'+\$0.50'**
  String get returnAmount0_50;

  /// No description provided for @returnAmount12_50.
  ///
  /// In en, this message translates to:
  /// **'\$12.50'**
  String get returnAmount12_50;

  /// No description provided for @returnRefundSummary.
  ///
  /// In en, this message translates to:
  /// **'Refund Summary'**
  String get returnRefundSummary;

  /// No description provided for @splashTagline.
  ///
  /// In en, this message translates to:
  /// **'Traditional Taste, Zero Waste'**
  String get splashTagline;

  /// No description provided for @splashHeadline.
  ///
  /// In en, this message translates to:
  /// **'Premium Levantine Cuisine'**
  String get splashHeadline;

  /// No description provided for @splashMotto.
  ///
  /// In en, this message translates to:
  /// **'Taste. Belong. Sustain.'**
  String get splashMotto;

  /// No description provided for @splashInitializing.
  ///
  /// In en, this message translates to:
  /// **'WELCOME TO OUR TABLE'**
  String get splashInitializing;

  /// No description provided for @staffShiftInProgress.
  ///
  /// In en, this message translates to:
  /// **'Shift in Progress'**
  String get staffShiftInProgress;

  /// No description provided for @staffActiveNow.
  ///
  /// In en, this message translates to:
  /// **'ACTIVE NOW'**
  String get staffActiveNow;

  /// No description provided for @staffCurrentDuration.
  ///
  /// In en, this message translates to:
  /// **'Current Duration'**
  String get staffCurrentDuration;

  /// No description provided for @staffDurationValue.
  ///
  /// In en, this message translates to:
  /// **'04:22:18'**
  String get staffDurationValue;

  /// No description provided for @staffCheckInTime.
  ///
  /// In en, this message translates to:
  /// **'Check-in Time'**
  String get staffCheckInTime;

  /// No description provided for @staffCheckInValue.
  ///
  /// In en, this message translates to:
  /// **'08:00 AM'**
  String get staffCheckInValue;

  /// No description provided for @staffShiftRole.
  ///
  /// In en, this message translates to:
  /// **'Shift Role'**
  String get staffShiftRole;

  /// No description provided for @staffFloorLead.
  ///
  /// In en, this message translates to:
  /// **'Floor Lead'**
  String get staffFloorLead;

  /// No description provided for @staffCheckOut.
  ///
  /// In en, this message translates to:
  /// **'Check-out'**
  String get staffCheckOut;

  /// No description provided for @staffAddShiftNote.
  ///
  /// In en, this message translates to:
  /// **'Add Shift Note'**
  String get staffAddShiftNote;

  /// No description provided for @staffLatestOrderActivity.
  ///
  /// In en, this message translates to:
  /// **'Latest Order Activity'**
  String get staffLatestOrderActivity;

  /// No description provided for @staffLatestOrderDetail.
  ///
  /// In en, this message translates to:
  /// **'Table 14 - Main Course Plated'**
  String get staffLatestOrderDetail;

  /// No description provided for @staffNavHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get staffNavHome;

  /// No description provided for @staffNavOrders.
  ///
  /// In en, this message translates to:
  /// **'Orders'**
  String get staffNavOrders;

  /// No description provided for @staffNavKitchen.
  ///
  /// In en, this message translates to:
  /// **'Kitchen'**
  String get staffNavKitchen;

  /// No description provided for @staffNavMenu.
  ///
  /// In en, this message translates to:
  /// **'Menu'**
  String get staffNavMenu;

  /// No description provided for @staffPortalTitle.
  ///
  /// In en, this message translates to:
  /// **'Culinary Logic'**
  String get staffPortalTitle;

  /// No description provided for @staffCurrentShiftDuration.
  ///
  /// In en, this message translates to:
  /// **'CURRENT SHIFT DURATION'**
  String get staffCurrentShiftDuration;

  /// No description provided for @staffStartedAt.
  ///
  /// In en, this message translates to:
  /// **'Shift started at 08:00 AM'**
  String get staffStartedAt;

  /// No description provided for @staffCheckOutShift.
  ///
  /// In en, this message translates to:
  /// **'Check-out Shift'**
  String get staffCheckOutShift;

  /// No description provided for @staffBreakTime.
  ///
  /// In en, this message translates to:
  /// **'Break Time'**
  String get staffBreakTime;

  /// No description provided for @staffSwapTask.
  ///
  /// In en, this message translates to:
  /// **'Swap Task'**
  String get staffSwapTask;

  /// No description provided for @staffCurrentFocus.
  ///
  /// In en, this message translates to:
  /// **'Current Focus'**
  String get staffCurrentFocus;

  /// No description provided for @staffTableService.
  ///
  /// In en, this message translates to:
  /// **'Table 12 Service'**
  String get staffTableService;

  /// No description provided for @staffKitchenCoordination.
  ///
  /// In en, this message translates to:
  /// **'Kitchen Coordination'**
  String get staffKitchenCoordination;

  /// No description provided for @staffSectionZone.
  ///
  /// In en, this message translates to:
  /// **'Section: Zone A'**
  String get staffSectionZone;

  /// No description provided for @staffTotalOrdersManaged.
  ///
  /// In en, this message translates to:
  /// **'Total Orders Managed: 18'**
  String get staffTotalOrdersManaged;

  /// No description provided for @staffCapacity.
  ///
  /// In en, this message translates to:
  /// **'75% Capacity'**
  String get staffCapacity;

  /// No description provided for @staffShiftPerformance.
  ///
  /// In en, this message translates to:
  /// **'Shift Performance'**
  String get staffShiftPerformance;

  /// No description provided for @staffTipsEarnedToday.
  ///
  /// In en, this message translates to:
  /// **'TIPS EARNED TODAY'**
  String get staffTipsEarnedToday;

  /// No description provided for @staffTipsAmount.
  ///
  /// In en, this message translates to:
  /// **'42.50 JOD'**
  String get staffTipsAmount;

  /// No description provided for @staffAvgServiceTime.
  ///
  /// In en, this message translates to:
  /// **'Avg Service Time'**
  String get staffAvgServiceTime;

  /// No description provided for @staffAvgServiceValue.
  ///
  /// In en, this message translates to:
  /// **'12:04'**
  String get staffAvgServiceValue;

  /// No description provided for @staffCustomerRating.
  ///
  /// In en, this message translates to:
  /// **'Customer Rating'**
  String get staffCustomerRating;

  /// No description provided for @staffRatingValue.
  ///
  /// In en, this message translates to:
  /// **'4.9'**
  String get staffRatingValue;

  /// No description provided for @staffManagerNotes.
  ///
  /// In en, this message translates to:
  /// **'Manager Notes'**
  String get staffManagerNotes;

  /// No description provided for @staffChefSpecialNote.
  ///
  /// In en, this message translates to:
  /// **'Chef\'s Special: Grilled Sea Bass\nSuggest as high priority for dinner.'**
  String get staffChefSpecialNote;

  /// No description provided for @staffVipReservationNote.
  ///
  /// In en, this message translates to:
  /// **'VIP Reservation at 07:30 PM\nTable 4 prepared for Mr. Al-Sayed.'**
  String get staffVipReservationNote;

  /// No description provided for @staffAttendanceTitle.
  ///
  /// In en, this message translates to:
  /// **'Attendance'**
  String get staffAttendanceTitle;

  /// No description provided for @staffCheckInDate.
  ///
  /// In en, this message translates to:
  /// **'Friday, May 29'**
  String get staffCheckInDate;

  /// No description provided for @staffCheckInClock.
  ///
  /// In en, this message translates to:
  /// **'10:56:38'**
  String get staffCheckInClock;

  /// No description provided for @staffCheckInAction.
  ///
  /// In en, this message translates to:
  /// **'Check-in'**
  String get staffCheckInAction;

  /// No description provided for @staffShiftStart.
  ///
  /// In en, this message translates to:
  /// **'Shift Start'**
  String get staffShiftStart;

  /// No description provided for @staffShiftStartValue.
  ///
  /// In en, this message translates to:
  /// **'08:00 AM'**
  String get staffShiftStartValue;

  /// No description provided for @staffStatus.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get staffStatus;

  /// No description provided for @staffLate.
  ///
  /// In en, this message translates to:
  /// **'LATE'**
  String get staffLate;

  /// No description provided for @staffTodaySchedule.
  ///
  /// In en, this message translates to:
  /// **'Today\'s Schedule'**
  String get staffTodaySchedule;

  /// No description provided for @staffKitchenDept.
  ///
  /// In en, this message translates to:
  /// **'Kitchen Dept'**
  String get staffKitchenDept;

  /// No description provided for @staffMorningPrepService.
  ///
  /// In en, this message translates to:
  /// **'Morning Prep & Service'**
  String get staffMorningPrepService;

  /// No description provided for @staffMorningShiftTime.
  ///
  /// In en, this message translates to:
  /// **'08:00 AM - 04:00 PM (8h)'**
  String get staffMorningShiftTime;

  /// No description provided for @staffNavAttendance.
  ///
  /// In en, this message translates to:
  /// **'Attendance'**
  String get staffNavAttendance;

  /// No description provided for @staffNavProfile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get staffNavProfile;

  /// No description provided for @staffOffDuty.
  ///
  /// In en, this message translates to:
  /// **'CURRENTLY OFF-DUTY'**
  String get staffOffDuty;

  /// No description provided for @staffShiftDetails.
  ///
  /// In en, this message translates to:
  /// **'Shift Details'**
  String get staffShiftDetails;

  /// No description provided for @staffShiftDetailsBody.
  ///
  /// In en, this message translates to:
  /// **'Review your scheduled session before starting.'**
  String get staffShiftDetailsBody;

  /// No description provided for @staffRole.
  ///
  /// In en, this message translates to:
  /// **'Role'**
  String get staffRole;

  /// No description provided for @staffLeadChef.
  ///
  /// In en, this message translates to:
  /// **'Lead Chef'**
  String get staffLeadChef;

  /// No description provided for @staffScheduledTime.
  ///
  /// In en, this message translates to:
  /// **'Scheduled Time'**
  String get staffScheduledTime;

  /// No description provided for @staffScheduledTimeValue.
  ///
  /// In en, this message translates to:
  /// **'06:00 AM - 02:00 PM'**
  String get staffScheduledTimeValue;

  /// No description provided for @staffExpectedEarnings.
  ///
  /// In en, this message translates to:
  /// **'Expected Earnings'**
  String get staffExpectedEarnings;

  /// No description provided for @staffExpectedEarningsValue.
  ///
  /// In en, this message translates to:
  /// **'75.00 JOD'**
  String get staffExpectedEarningsValue;

  /// No description provided for @staffLocation.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get staffLocation;

  /// No description provided for @staffMainKitchen.
  ///
  /// In en, this message translates to:
  /// **'Main Kitchen'**
  String get staffMainKitchen;

  /// No description provided for @staffGpsCheckInNote.
  ///
  /// In en, this message translates to:
  /// **'Checking in will record your GPS location and timestamp.'**
  String get staffGpsCheckInNote;

  /// No description provided for @staffNavInventory.
  ///
  /// In en, this message translates to:
  /// **'Inventory'**
  String get staffNavInventory;

  /// No description provided for @staffNavFinances.
  ///
  /// In en, this message translates to:
  /// **'Finances'**
  String get staffNavFinances;

  /// No description provided for @staffTipsBrand.
  ///
  /// In en, this message translates to:
  /// **'Ayletna Tips'**
  String get staffTipsBrand;

  /// No description provided for @staffTipsReportMeta.
  ///
  /// In en, this message translates to:
  /// **'Personal Report • Today, Oct 24'**
  String get staffTipsReportMeta;

  /// No description provided for @staffDailyTipsSummary.
  ///
  /// In en, this message translates to:
  /// **'Daily Tips Summary'**
  String get staffDailyTipsSummary;

  /// No description provided for @staffVerifiedRevenue.
  ///
  /// In en, this message translates to:
  /// **'Verified Revenue'**
  String get staffVerifiedRevenue;

  /// No description provided for @staffTotalTipsEarned.
  ///
  /// In en, this message translates to:
  /// **'Total Tips Earned (JOD)'**
  String get staffTotalTipsEarned;

  /// No description provided for @staffDailyTipsAmount.
  ///
  /// In en, this message translates to:
  /// **'84.50'**
  String get staffDailyTipsAmount;

  /// No description provided for @staffJod.
  ///
  /// In en, this message translates to:
  /// **'JOD'**
  String get staffJod;

  /// No description provided for @staffTipsVsYesterday.
  ///
  /// In en, this message translates to:
  /// **'+12% vs Yesterday'**
  String get staffTipsVsYesterday;

  /// No description provided for @staffTipsLastEntry.
  ///
  /// In en, this message translates to:
  /// **'Last entry: 14:32'**
  String get staffTipsLastEntry;

  /// No description provided for @staffBreakfastShift.
  ///
  /// In en, this message translates to:
  /// **'Breakfast Shift'**
  String get staffBreakfastShift;

  /// No description provided for @staffBreakfastTime.
  ///
  /// In en, this message translates to:
  /// **'07:00 - 11:30'**
  String get staffBreakfastTime;

  /// No description provided for @staffBreakfastAmount.
  ///
  /// In en, this message translates to:
  /// **'22.00 JOD'**
  String get staffBreakfastAmount;

  /// No description provided for @staffVerified.
  ///
  /// In en, this message translates to:
  /// **'Verified'**
  String get staffVerified;

  /// No description provided for @staffLunchRush.
  ///
  /// In en, this message translates to:
  /// **'Lunch Rush'**
  String get staffLunchRush;

  /// No description provided for @staffLunchTime.
  ///
  /// In en, this message translates to:
  /// **'12:00 - 16:30'**
  String get staffLunchTime;

  /// No description provided for @staffLunchAmount.
  ///
  /// In en, this message translates to:
  /// **'62.50 JOD'**
  String get staffLunchAmount;

  /// No description provided for @staffEarningsPolicy.
  ///
  /// In en, this message translates to:
  /// **'Earnings Policy'**
  String get staffEarningsPolicy;

  /// No description provided for @staffEarningsPolicyBody.
  ///
  /// In en, this message translates to:
  /// **'Please review your daily totals. By acknowledging, you confirm the recorded tips match your shift logs. Payouts are processed every Thursday.'**
  String get staffEarningsPolicyBody;

  /// No description provided for @staffCashTips.
  ///
  /// In en, this message translates to:
  /// **'Cash Tips'**
  String get staffCashTips;

  /// No description provided for @staffCashTipsAmount.
  ///
  /// In en, this message translates to:
  /// **'35.00 JOD'**
  String get staffCashTipsAmount;

  /// No description provided for @staffDigitalTips.
  ///
  /// In en, this message translates to:
  /// **'Digital Tips'**
  String get staffDigitalTips;

  /// No description provided for @staffDigitalTipsAmount.
  ///
  /// In en, this message translates to:
  /// **'49.50 JOD'**
  String get staffDigitalTipsAmount;

  /// No description provided for @staffFinalTotal.
  ///
  /// In en, this message translates to:
  /// **'Final Total'**
  String get staffFinalTotal;

  /// No description provided for @staffFinalTotalAmount.
  ///
  /// In en, this message translates to:
  /// **'84.50 JOD'**
  String get staffFinalTotalAmount;

  /// No description provided for @staffAcknowledgeReceipt.
  ///
  /// In en, this message translates to:
  /// **'Acknowledge Receipt'**
  String get staffAcknowledgeReceipt;

  /// No description provided for @staffAcknowledgeNote.
  ///
  /// In en, this message translates to:
  /// **'Acknowledgment timestamp will be recorded for audit purposes.'**
  String get staffAcknowledgeNote;

  /// No description provided for @staffTransactionHistory.
  ///
  /// In en, this message translates to:
  /// **'Transaction History'**
  String get staffTransactionHistory;

  /// No description provided for @staffViewFullLog.
  ///
  /// In en, this message translates to:
  /// **'View Full Log'**
  String get staffViewFullLog;

  /// No description provided for @staffTxnDelivery.
  ///
  /// In en, this message translates to:
  /// **'Delivery'**
  String get staffTxnDelivery;

  /// No description provided for @staffTxnDineIn.
  ///
  /// In en, this message translates to:
  /// **'Dine-in'**
  String get staffTxnDineIn;

  /// No description provided for @staffTxnTakeaway.
  ///
  /// In en, this message translates to:
  /// **'Takeaway'**
  String get staffTxnTakeaway;

  /// No description provided for @staffTxnDeliveryMeta.
  ///
  /// In en, this message translates to:
  /// **'Order #9822'**
  String get staffTxnDeliveryMeta;

  /// No description provided for @staffTxnDineInMeta.
  ///
  /// In en, this message translates to:
  /// **'Table 12 • Lunch'**
  String get staffTxnDineInMeta;

  /// No description provided for @staffTxnTakeawayMeta.
  ///
  /// In en, this message translates to:
  /// **'App Order • Pickup'**
  String get staffTxnTakeawayMeta;

  /// No description provided for @staffTxnDeliveryAmount.
  ///
  /// In en, this message translates to:
  /// **'4.00 JOD'**
  String get staffTxnDeliveryAmount;

  /// No description provided for @staffTxnDineInAmount.
  ///
  /// In en, this message translates to:
  /// **'12.50 JOD'**
  String get staffTxnDineInAmount;

  /// No description provided for @staffTxnTakeawayAmount.
  ///
  /// In en, this message translates to:
  /// **'2.25 JOD'**
  String get staffTxnTakeawayAmount;

  /// No description provided for @staffTxnDeliveryTime.
  ///
  /// In en, this message translates to:
  /// **'14:15'**
  String get staffTxnDeliveryTime;

  /// No description provided for @staffTxnDineInTime.
  ///
  /// In en, this message translates to:
  /// **'13:50'**
  String get staffTxnDineInTime;

  /// No description provided for @staffTxnTakeawayTime.
  ///
  /// In en, this message translates to:
  /// **'13:10'**
  String get staffTxnTakeawayTime;

  /// No description provided for @staffNavTips.
  ///
  /// In en, this message translates to:
  /// **'Tips'**
  String get staffNavTips;

  /// No description provided for @staffPerformanceSummary.
  ///
  /// In en, this message translates to:
  /// **'Performance Summary'**
  String get staffPerformanceSummary;

  /// No description provided for @staffTotalHours.
  ///
  /// In en, this message translates to:
  /// **'Total Hours'**
  String get staffTotalHours;

  /// No description provided for @staffTotalHoursValue.
  ///
  /// In en, this message translates to:
  /// **'124.5 hrs'**
  String get staffTotalHoursValue;

  /// No description provided for @staffHoursDelta.
  ///
  /// In en, this message translates to:
  /// **'+4.2% from last month'**
  String get staffHoursDelta;

  /// No description provided for @staffTotalTips.
  ///
  /// In en, this message translates to:
  /// **'Total Tips'**
  String get staffTotalTips;

  /// No description provided for @staffTotalTipsValue.
  ///
  /// In en, this message translates to:
  /// **'1,432.50 JOD'**
  String get staffTotalTipsValue;

  /// No description provided for @staffAvgTripRate.
  ///
  /// In en, this message translates to:
  /// **'Avg 11.50/hr tip rate'**
  String get staffAvgTripRate;

  /// No description provided for @staffShiftsCompleted.
  ///
  /// In en, this message translates to:
  /// **'Shifts Completed'**
  String get staffShiftsCompleted;

  /// No description provided for @staffShiftsCompletedValue.
  ///
  /// In en, this message translates to:
  /// **'22'**
  String get staffShiftsCompletedValue;

  /// No description provided for @staffNoLatesPeriod.
  ///
  /// In en, this message translates to:
  /// **'0 lates this period'**
  String get staffNoLatesPeriod;

  /// No description provided for @staffThisMonth.
  ///
  /// In en, this message translates to:
  /// **'This Month'**
  String get staffThisMonth;

  /// No description provided for @staffLastMonth.
  ///
  /// In en, this message translates to:
  /// **'Last Month'**
  String get staffLastMonth;

  /// No description provided for @staffCustomRange.
  ///
  /// In en, this message translates to:
  /// **'Custom Range'**
  String get staffCustomRange;

  /// No description provided for @staffThisWeek.
  ///
  /// In en, this message translates to:
  /// **'This Week'**
  String get staffThisWeek;

  /// No description provided for @staffLastWeek.
  ///
  /// In en, this message translates to:
  /// **'Last Week'**
  String get staffLastWeek;

  /// No description provided for @staffDinnerService.
  ///
  /// In en, this message translates to:
  /// **'Dinner Service'**
  String get staffDinnerService;

  /// No description provided for @staffDinnerDate.
  ///
  /// In en, this message translates to:
  /// **'OCT\n24'**
  String get staffDinnerDate;

  /// No description provided for @staffDinnerTime.
  ///
  /// In en, this message translates to:
  /// **'16:30 - 23:15'**
  String get staffDinnerTime;

  /// No description provided for @staffDinnerHours.
  ///
  /// In en, this message translates to:
  /// **'6.75 hrs'**
  String get staffDinnerHours;

  /// No description provided for @staffDinnerTips.
  ///
  /// In en, this message translates to:
  /// **'+84.20 Tips'**
  String get staffDinnerTips;

  /// No description provided for @staffBrunchShift.
  ///
  /// In en, this message translates to:
  /// **'Brunch Shift'**
  String get staffBrunchShift;

  /// No description provided for @staffBrunchDate.
  ///
  /// In en, this message translates to:
  /// **'OCT\n22'**
  String get staffBrunchDate;

  /// No description provided for @staffBrunchTime.
  ///
  /// In en, this message translates to:
  /// **'09:00 - 15:30'**
  String get staffBrunchTime;

  /// No description provided for @staffBrunchHours.
  ///
  /// In en, this message translates to:
  /// **'6.5 hrs'**
  String get staffBrunchHours;

  /// No description provided for @staffBrunchTips.
  ///
  /// In en, this message translates to:
  /// **'+52.00 Tips'**
  String get staffBrunchTips;

  /// No description provided for @staffClosingShift.
  ///
  /// In en, this message translates to:
  /// **'Closing Shift'**
  String get staffClosingShift;

  /// No description provided for @staffClosingDate.
  ///
  /// In en, this message translates to:
  /// **'OCT\n19'**
  String get staffClosingDate;

  /// No description provided for @staffClosingTime.
  ///
  /// In en, this message translates to:
  /// **'17:00 - 01:30'**
  String get staffClosingTime;

  /// No description provided for @staffClosingHours.
  ///
  /// In en, this message translates to:
  /// **'8.5 hrs'**
  String get staffClosingHours;

  /// No description provided for @staffClosingTips.
  ///
  /// In en, this message translates to:
  /// **'+112.45 Tips'**
  String get staffClosingTips;

  /// No description provided for @staffDoubleShift.
  ///
  /// In en, this message translates to:
  /// **'Double Shift'**
  String get staffDoubleShift;

  /// No description provided for @staffDoubleDate.
  ///
  /// In en, this message translates to:
  /// **'OCT\n18'**
  String get staffDoubleDate;

  /// No description provided for @staffDoubleTime.
  ///
  /// In en, this message translates to:
  /// **'10:00 - 22:00'**
  String get staffDoubleTime;

  /// No description provided for @staffDoubleHours.
  ///
  /// In en, this message translates to:
  /// **'12.0 hrs'**
  String get staffDoubleHours;

  /// No description provided for @staffDoubleTips.
  ///
  /// In en, this message translates to:
  /// **'+156.10 Tips'**
  String get staffDoubleTips;

  /// No description provided for @staffOvertime.
  ///
  /// In en, this message translates to:
  /// **'Overtime'**
  String get staffOvertime;

  /// No description provided for @staffDownloadTaxStatement.
  ///
  /// In en, this message translates to:
  /// **'Download Tax Statement'**
  String get staffDownloadTaxStatement;

  /// No description provided for @staffNavDashboard.
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get staffNavDashboard;

  /// No description provided for @staffNavHistory.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get staffNavHistory;

  /// No description provided for @staffNavSchedule.
  ///
  /// In en, this message translates to:
  /// **'Schedule'**
  String get staffNavSchedule;

  /// No description provided for @staffNavPay.
  ///
  /// In en, this message translates to:
  /// **'Pay'**
  String get staffNavPay;

  /// No description provided for @staffNavAdmin.
  ///
  /// In en, this message translates to:
  /// **'Admin'**
  String get staffNavAdmin;

  /// No description provided for @sustainabilityAlertsTitle.
  ///
  /// In en, this message translates to:
  /// **'Sustainability Alerts'**
  String get sustainabilityAlertsTitle;

  /// No description provided for @sustainabilityAlertsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Operational insights and ecological milestones for the Culinary Logic ecosystem. Monitor tray cycles and sustainability KPIs in real-time.'**
  String get sustainabilityAlertsSubtitle;

  /// No description provided for @sustainabilityActiveGoal.
  ///
  /// In en, this message translates to:
  /// **'Active Goal'**
  String get sustainabilityActiveGoal;

  /// No description provided for @sustainabilityGoalReached.
  ///
  /// In en, this message translates to:
  /// **'Sustainability Goal: 92% reached'**
  String get sustainabilityGoalReached;

  /// No description provided for @sustainabilityGoalBody.
  ///
  /// In en, this message translates to:
  /// **'Target for this week: 95% plastic-free tray management.'**
  String get sustainabilityGoalBody;

  /// No description provided for @sustainabilityCurrentProgress.
  ///
  /// In en, this message translates to:
  /// **'Current Progress'**
  String get sustainabilityCurrentProgress;

  /// No description provided for @sustainabilityProgressPercent.
  ///
  /// In en, this message translates to:
  /// **'92%'**
  String get sustainabilityProgressPercent;

  /// No description provided for @sustainabilityUrgentAction.
  ///
  /// In en, this message translates to:
  /// **'Urgent Action'**
  String get sustainabilityUrgentAction;

  /// No description provided for @sustainabilityReminderTitle.
  ///
  /// In en, this message translates to:
  /// **'Reminder:\n4 trays\npending\ncollection'**
  String get sustainabilityReminderTitle;

  /// No description provided for @sustainabilityStationB.
  ///
  /// In en, this message translates to:
  /// **'Station B requires immediate clearance to maintain sanitation flow.'**
  String get sustainabilityStationB;

  /// No description provided for @sustainabilityDispatch.
  ///
  /// In en, this message translates to:
  /// **'Dispatch'**
  String get sustainabilityDispatch;

  /// No description provided for @sustainabilityPolicyUpdate.
  ///
  /// In en, this message translates to:
  /// **'New Sanitation Policy Update'**
  String get sustainabilityPolicyUpdate;

  /// No description provided for @sustainabilityPolicyBody.
  ///
  /// In en, this message translates to:
  /// **'Updated protocols for compostable tray sanitization have been implemented for Q3.'**
  String get sustainabilityPolicyBody;

  /// No description provided for @sustainabilityViewDocument.
  ///
  /// In en, this message translates to:
  /// **'View Document'**
  String get sustainabilityViewDocument;

  /// No description provided for @sustainabilityCo2Offset.
  ///
  /// In en, this message translates to:
  /// **'1.2 Tons'**
  String get sustainabilityCo2Offset;

  /// No description provided for @sustainabilityCo2Subtitle.
  ///
  /// In en, this message translates to:
  /// **'CO2 offset YTD'**
  String get sustainabilityCo2Subtitle;

  /// No description provided for @sustainabilityTrayFeed.
  ///
  /// In en, this message translates to:
  /// **'Real-time Tray Feed'**
  String get sustainabilityTrayFeed;

  /// No description provided for @sustainabilityInRotation.
  ///
  /// In en, this message translates to:
  /// **'In Rotation'**
  String get sustainabilityInRotation;

  /// No description provided for @sustainabilityInRotationValue.
  ///
  /// In en, this message translates to:
  /// **'142'**
  String get sustainabilityInRotationValue;

  /// No description provided for @sustainabilityCleaningCycle.
  ///
  /// In en, this message translates to:
  /// **'Cleaning cycle'**
  String get sustainabilityCleaningCycle;

  /// No description provided for @sustainabilityCleaningCycleValue.
  ///
  /// In en, this message translates to:
  /// **'28'**
  String get sustainabilityCleaningCycleValue;

  /// No description provided for @sustainabilityAverageReturn.
  ///
  /// In en, this message translates to:
  /// **'Average Return'**
  String get sustainabilityAverageReturn;

  /// No description provided for @sustainabilityAverageReturnValue.
  ///
  /// In en, this message translates to:
  /// **'14m'**
  String get sustainabilityAverageReturnValue;

  /// No description provided for @takeawayBrandTitle.
  ///
  /// In en, this message translates to:
  /// **'Ayletna System'**
  String get takeawayBrandTitle;

  /// No description provided for @takeawayChoosePickupDetails.
  ///
  /// In en, this message translates to:
  /// **'Choose Pickup Details'**
  String get takeawayChoosePickupDetails;

  /// No description provided for @takeawayPickupSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Select a time that works for you in Amman, Jordan.'**
  String get takeawayPickupSubtitle;

  /// No description provided for @takeawayHubName.
  ///
  /// In en, this message translates to:
  /// **'Ayletna Hub - Downtown'**
  String get takeawayHubName;

  /// No description provided for @takeawayHubAddress.
  ///
  /// In en, this message translates to:
  /// **'King Abdullah II St, Amman'**
  String get takeawayHubAddress;

  /// No description provided for @takeawayOpen.
  ///
  /// In en, this message translates to:
  /// **'Open'**
  String get takeawayOpen;

  /// No description provided for @takeawayAsap.
  ///
  /// In en, this message translates to:
  /// **'ASAP'**
  String get takeawayAsap;

  /// No description provided for @takeawayAsapTime.
  ///
  /// In en, this message translates to:
  /// **'15 - 20 mins'**
  String get takeawayAsapTime;

  /// No description provided for @takeawaySchedule.
  ///
  /// In en, this message translates to:
  /// **'Schedule'**
  String get takeawaySchedule;

  /// No description provided for @takeawayChooseTime.
  ///
  /// In en, this message translates to:
  /// **'Choose time'**
  String get takeawayChooseTime;

  /// No description provided for @takeawayAvailableSlots.
  ///
  /// In en, this message translates to:
  /// **'Available Slots'**
  String get takeawayAvailableSlots;

  /// No description provided for @takeawayCurrency.
  ///
  /// In en, this message translates to:
  /// **'JOD (Jordanian Dinar)'**
  String get takeawayCurrency;

  /// No description provided for @takeawayToday.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get takeawayToday;

  /// No description provided for @takeawayTomorrow.
  ///
  /// In en, this message translates to:
  /// **'Tomorrow'**
  String get takeawayTomorrow;

  /// No description provided for @takeawayOct25.
  ///
  /// In en, this message translates to:
  /// **'Oct 25'**
  String get takeawayOct25;

  /// No description provided for @takeawaySlot1230.
  ///
  /// In en, this message translates to:
  /// **'12:30 PM'**
  String get takeawaySlot1230;

  /// No description provided for @takeawaySlot0100.
  ///
  /// In en, this message translates to:
  /// **'01:00 PM'**
  String get takeawaySlot0100;

  /// No description provided for @takeawaySlot0130.
  ///
  /// In en, this message translates to:
  /// **'01:30 PM'**
  String get takeawaySlot0130;

  /// No description provided for @takeawaySlot0200.
  ///
  /// In en, this message translates to:
  /// **'02:00 PM'**
  String get takeawaySlot0200;

  /// No description provided for @takeawaySlot0230.
  ///
  /// In en, this message translates to:
  /// **'02:30 PM'**
  String get takeawaySlot0230;

  /// No description provided for @takeawayFull.
  ///
  /// In en, this message translates to:
  /// **'Full'**
  String get takeawayFull;

  /// No description provided for @takeawayPickupFee.
  ///
  /// In en, this message translates to:
  /// **'Pickup Fee'**
  String get takeawayPickupFee;

  /// No description provided for @takeawayPickupFeeValue.
  ///
  /// In en, this message translates to:
  /// **'0.000 JOD'**
  String get takeawayPickupFeeValue;

  /// No description provided for @takeawayConfirmPickupTime.
  ///
  /// In en, this message translates to:
  /// **'Confirm Pickup Time'**
  String get takeawayConfirmPickupTime;

  /// No description provided for @tipBrandTitle.
  ///
  /// In en, this message translates to:
  /// **'Ayletna System'**
  String get tipBrandTitle;

  /// No description provided for @tipSupportTeamTitle.
  ///
  /// In en, this message translates to:
  /// **'Support Our Culinary Team'**
  String get tipSupportTeamTitle;

  /// No description provided for @tipAppreciationQuote.
  ///
  /// In en, this message translates to:
  /// **'\"Your appreciation goes directly to the heart of the kitchen. Every tip fuels our team\'s passion for creating unforgettable flavors for you.\"'**
  String get tipAppreciationQuote;

  /// No description provided for @tipAddAppreciation.
  ///
  /// In en, this message translates to:
  /// **'Add Appreciation'**
  String get tipAddAppreciation;

  /// No description provided for @tipAddAppreciationBody.
  ///
  /// In en, this message translates to:
  /// **'Show some love to the chefs and staff.'**
  String get tipAddAppreciationBody;

  /// No description provided for @tipSmallThankYou.
  ///
  /// In en, this message translates to:
  /// **'Small Thank You'**
  String get tipSmallThankYou;

  /// No description provided for @tipGenerousTip.
  ///
  /// In en, this message translates to:
  /// **'Generous Tip'**
  String get tipGenerousTip;

  /// No description provided for @tipCulinaryHero.
  ///
  /// In en, this message translates to:
  /// **'Culinary Hero'**
  String get tipCulinaryHero;

  /// No description provided for @tipCustomAmountJod.
  ///
  /// In en, this message translates to:
  /// **'Custom Amount (JOD)'**
  String get tipCustomAmountJod;

  /// No description provided for @tipCustomAmountValue.
  ///
  /// In en, this message translates to:
  /// **'JOD 0.00'**
  String get tipCustomAmountValue;

  /// No description provided for @tipCustomAmountBody.
  ///
  /// In en, this message translates to:
  /// **'Enter any amount you wish to contribute to the team.'**
  String get tipCustomAmountBody;

  /// No description provided for @tipConfirmAppreciation.
  ///
  /// In en, this message translates to:
  /// **'Confirm Appreciation'**
  String get tipConfirmAppreciation;

  /// No description provided for @tipSkip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get tipSkip;

  /// No description provided for @trackingBrandTitle.
  ///
  /// In en, this message translates to:
  /// **'Ayletna System'**
  String get trackingBrandTitle;

  /// No description provided for @trackingEstimatedArrival.
  ///
  /// In en, this message translates to:
  /// **'Estimated Arrival'**
  String get trackingEstimatedArrival;

  /// No description provided for @trackingArrivalTime.
  ///
  /// In en, this message translates to:
  /// **'12:45 PM'**
  String get trackingArrivalTime;

  /// No description provided for @trackingOnTheWay.
  ///
  /// In en, this message translates to:
  /// **'On the Way'**
  String get trackingOnTheWay;

  /// No description provided for @trackingOrderNumber.
  ///
  /// In en, this message translates to:
  /// **'Order #77429'**
  String get trackingOrderNumber;

  /// No description provided for @trackingPremium.
  ///
  /// In en, this message translates to:
  /// **'Premium'**
  String get trackingPremium;

  /// No description provided for @trackingFromRestaurant.
  ///
  /// In en, this message translates to:
  /// **'From: Ayletna Bistro'**
  String get trackingFromRestaurant;

  /// No description provided for @trackingOrderReceived.
  ///
  /// In en, this message translates to:
  /// **'Order Received'**
  String get trackingOrderReceived;

  /// No description provided for @trackingOrderReceivedBody.
  ///
  /// In en, this message translates to:
  /// **'Confirmed at 12:15 PM'**
  String get trackingOrderReceivedBody;

  /// No description provided for @trackingPreparingKitchen.
  ///
  /// In en, this message translates to:
  /// **'Preparing in Kitchen'**
  String get trackingPreparingKitchen;

  /// No description provided for @trackingPreparingBody.
  ///
  /// In en, this message translates to:
  /// **'Chef is finishing your meal'**
  String get trackingPreparingBody;

  /// No description provided for @trackingOnWayTitle.
  ///
  /// In en, this message translates to:
  /// **'On the Way'**
  String get trackingOnWayTitle;

  /// No description provided for @trackingOnWayBody.
  ///
  /// In en, this message translates to:
  /// **'Driver: Marcus (5 mins away)'**
  String get trackingOnWayBody;

  /// No description provided for @trackingCallMarcus.
  ///
  /// In en, this message translates to:
  /// **'Call driver'**
  String get trackingCallMarcus;

  /// No description provided for @trackingDelivered.
  ///
  /// In en, this message translates to:
  /// **'Delivered'**
  String get trackingDelivered;

  /// No description provided for @trackingDeliveredBody.
  ///
  /// In en, this message translates to:
  /// **'Estimated by 12:45 PM'**
  String get trackingDeliveredBody;

  /// No description provided for @trackingOrderSummary.
  ///
  /// In en, this message translates to:
  /// **'Order Summary'**
  String get trackingOrderSummary;

  /// No description provided for @trackingTruffleRisotto.
  ///
  /// In en, this message translates to:
  /// **'1x Truffle Risotto'**
  String get trackingTruffleRisotto;

  /// No description provided for @trackingGardenSalad.
  ///
  /// In en, this message translates to:
  /// **'1x Garden Salad'**
  String get trackingGardenSalad;

  /// No description provided for @trackingRisottoPrice.
  ///
  /// In en, this message translates to:
  /// **'24.00'**
  String get trackingRisottoPrice;

  /// No description provided for @trackingSaladPrice.
  ///
  /// In en, this message translates to:
  /// **'12.00'**
  String get trackingSaladPrice;

  /// No description provided for @trackingTotal.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get trackingTotal;

  /// No description provided for @trackingTotalPrice.
  ///
  /// In en, this message translates to:
  /// **'36.00'**
  String get trackingTotalPrice;

  /// No description provided for @trackingNeedHelp.
  ///
  /// In en, this message translates to:
  /// **'Need help?'**
  String get trackingNeedHelp;

  /// No description provided for @trackingHelpBody.
  ///
  /// In en, this message translates to:
  /// **'Our support team is available 24/7 for any delivery concerns.'**
  String get trackingHelpBody;

  /// No description provided for @trackingContactSupport.
  ///
  /// In en, this message translates to:
  /// **'Contact Support'**
  String get trackingContactSupport;

  /// No description provided for @trackingNoContactDelivery.
  ///
  /// In en, this message translates to:
  /// **'No-Contact Delivery'**
  String get trackingNoContactDelivery;

  /// No description provided for @trackingNoContactBody.
  ///
  /// In en, this message translates to:
  /// **'Requested by customer'**
  String get trackingNoContactBody;

  /// No description provided for @trackingQualityAssured.
  ///
  /// In en, this message translates to:
  /// **'Quality Assured'**
  String get trackingQualityAssured;

  /// No description provided for @trackingQualityBody.
  ///
  /// In en, this message translates to:
  /// **'Triple checked by kitchen'**
  String get trackingQualityBody;

  /// No description provided for @trackingEcoPackaging.
  ///
  /// In en, this message translates to:
  /// **'Eco Packaging'**
  String get trackingEcoPackaging;

  /// No description provided for @trackingEcoBody.
  ///
  /// In en, this message translates to:
  /// **'100% Biodegradable'**
  String get trackingEcoBody;

  /// No description provided for @userManagementTitle.
  ///
  /// In en, this message translates to:
  /// **'Staff Management'**
  String get userManagementTitle;

  /// No description provided for @userManagementSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Oversee your kitchen and front-of-house team.'**
  String get userManagementSubtitle;

  /// No description provided for @userAddNewStaff.
  ///
  /// In en, this message translates to:
  /// **'Add New Staff'**
  String get userAddNewStaff;

  /// No description provided for @userActiveStaff.
  ///
  /// In en, this message translates to:
  /// **'Active Staff'**
  String get userActiveStaff;

  /// No description provided for @userActiveStaffCount.
  ///
  /// In en, this message translates to:
  /// **'24'**
  String get userActiveStaffCount;

  /// No description provided for @userRolesDefined.
  ///
  /// In en, this message translates to:
  /// **'Roles Defined'**
  String get userRolesDefined;

  /// No description provided for @userRolesDefinedCount.
  ///
  /// In en, this message translates to:
  /// **'8'**
  String get userRolesDefinedCount;

  /// No description provided for @userCurrentShift.
  ///
  /// In en, this message translates to:
  /// **'Current Shift'**
  String get userCurrentShift;

  /// No description provided for @userCurrentShiftCount.
  ///
  /// In en, this message translates to:
  /// **'12'**
  String get userCurrentShiftCount;

  /// No description provided for @userActive.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get userActive;

  /// No description provided for @userInactive.
  ///
  /// In en, this message translates to:
  /// **'Inactive'**
  String get userInactive;

  /// No description provided for @userElenaName.
  ///
  /// In en, this message translates to:
  /// **'Elena Rodriguez'**
  String get userElenaName;

  /// No description provided for @userElenaRole.
  ///
  /// In en, this message translates to:
  /// **'Lead Chef'**
  String get userElenaRole;

  /// No description provided for @userElenaEmail.
  ///
  /// In en, this message translates to:
  /// **'elena.r@culinarylogic.com'**
  String get userElenaEmail;

  /// No description provided for @userElenaShift.
  ///
  /// In en, this message translates to:
  /// **'Shift: Morning (6AM - 2PM)'**
  String get userElenaShift;

  /// No description provided for @userMarcusName.
  ///
  /// In en, this message translates to:
  /// **'Marcus Chen'**
  String get userMarcusName;

  /// No description provided for @userMarcusRole.
  ///
  /// In en, this message translates to:
  /// **'Cashier'**
  String get userMarcusRole;

  /// No description provided for @userMarcusEmail.
  ///
  /// In en, this message translates to:
  /// **'m.chen@culinarylogic.com'**
  String get userMarcusEmail;

  /// No description provided for @userMarcusShift.
  ///
  /// In en, this message translates to:
  /// **'Shift: Afternoon (2PM - 10PM)'**
  String get userMarcusShift;

  /// No description provided for @userSarahName.
  ///
  /// In en, this message translates to:
  /// **'Sarah Jenkins'**
  String get userSarahName;

  /// No description provided for @userSarahRole.
  ///
  /// In en, this message translates to:
  /// **'Delivery Lead'**
  String get userSarahRole;

  /// No description provided for @userSarahEmail.
  ///
  /// In en, this message translates to:
  /// **'s.jenkins@culinarylogic.com'**
  String get userSarahEmail;

  /// No description provided for @userSarahShift.
  ///
  /// In en, this message translates to:
  /// **'Shift: On Leave'**
  String get userSarahShift;

  /// No description provided for @userDavidName.
  ///
  /// In en, this message translates to:
  /// **'David Okafor'**
  String get userDavidName;

  /// No description provided for @userDavidRole.
  ///
  /// In en, this message translates to:
  /// **'Sous Chef'**
  String get userDavidRole;

  /// No description provided for @userDavidEmail.
  ///
  /// In en, this message translates to:
  /// **'d.okafor@culinarylogic.com'**
  String get userDavidEmail;

  /// No description provided for @userDavidShift.
  ///
  /// In en, this message translates to:
  /// **'Shift: Evening (4PM - 12AM)'**
  String get userDavidShift;

  /// No description provided for @userLindaName.
  ///
  /// In en, this message translates to:
  /// **'Linda Vane'**
  String get userLindaName;

  /// No description provided for @userLindaRole.
  ///
  /// In en, this message translates to:
  /// **'Hostess'**
  String get userLindaRole;

  /// No description provided for @userLindaEmail.
  ///
  /// In en, this message translates to:
  /// **'linda.v@culinarylogic.com'**
  String get userLindaEmail;

  /// No description provided for @userLindaShift.
  ///
  /// In en, this message translates to:
  /// **'Shift: Dinner Rush (6PM - 11PM)'**
  String get userLindaShift;

  /// No description provided for @userManagePermissions.
  ///
  /// In en, this message translates to:
  /// **'Manage Permissions'**
  String get userManagePermissions;

  /// No description provided for @userInviteNewTeamMember.
  ///
  /// In en, this message translates to:
  /// **'Invite New Team Member'**
  String get userInviteNewTeamMember;

  /// No description provided for @walletBrandTitle.
  ///
  /// In en, this message translates to:
  /// **'Ayletna System'**
  String get walletBrandTitle;

  /// No description provided for @walletTotalBalance.
  ///
  /// In en, this message translates to:
  /// **'Total Balance'**
  String get walletTotalBalance;

  /// No description provided for @walletCurrency.
  ///
  /// In en, this message translates to:
  /// **'JOD'**
  String get walletCurrency;

  /// No description provided for @walletBalanceAmount.
  ///
  /// In en, this message translates to:
  /// **'142.50'**
  String get walletBalanceAmount;

  /// No description provided for @walletTopUp.
  ///
  /// In en, this message translates to:
  /// **'Top Up'**
  String get walletTopUp;

  /// No description provided for @walletTransfer.
  ///
  /// In en, this message translates to:
  /// **'Transfer'**
  String get walletTransfer;

  /// No description provided for @walletSavorPoints.
  ///
  /// In en, this message translates to:
  /// **'Savor Points'**
  String get walletSavorPoints;

  /// No description provided for @walletGoldTier.
  ///
  /// In en, this message translates to:
  /// **'Gold Tier'**
  String get walletGoldTier;

  /// No description provided for @walletPointsAmount.
  ///
  /// In en, this message translates to:
  /// **'2,450'**
  String get walletPointsAmount;

  /// No description provided for @walletPointsToPlatinum.
  ///
  /// In en, this message translates to:
  /// **'550 pts to Platinum'**
  String get walletPointsToPlatinum;

  /// No description provided for @walletAvailableRewards.
  ///
  /// In en, this message translates to:
  /// **'Available Rewards'**
  String get walletAvailableRewards;

  /// No description provided for @walletAvailableRewardsCount.
  ///
  /// In en, this message translates to:
  /// **'3'**
  String get walletAvailableRewardsCount;

  /// No description provided for @walletPointsValue.
  ///
  /// In en, this message translates to:
  /// **'Points Value'**
  String get walletPointsValue;

  /// No description provided for @walletPointsValueAmount.
  ///
  /// In en, this message translates to:
  /// **'JOD 12.25'**
  String get walletPointsValueAmount;

  /// No description provided for @walletViewRewardCatalog.
  ///
  /// In en, this message translates to:
  /// **'View Reward Catalog'**
  String get walletViewRewardCatalog;

  /// No description provided for @walletRecentTransactions.
  ///
  /// In en, this message translates to:
  /// **'Recent Transactions'**
  String get walletRecentTransactions;

  /// No description provided for @walletTheBurgerHub.
  ///
  /// In en, this message translates to:
  /// **'The Burger Hub'**
  String get walletTheBurgerHub;

  /// No description provided for @walletBurgerMeta.
  ///
  /// In en, this message translates to:
  /// **'Today, 2:45 PM • Dine-in'**
  String get walletBurgerMeta;

  /// No description provided for @walletBurgerAmount.
  ///
  /// In en, this message translates to:
  /// **'- JOD 12.50'**
  String get walletBurgerAmount;

  /// No description provided for @walletBurgerPoints.
  ///
  /// In en, this message translates to:
  /// **'+ 25 pts'**
  String get walletBurgerPoints;

  /// No description provided for @walletRefundTitle.
  ///
  /// In en, this message translates to:
  /// **'Refund: Canceled Order'**
  String get walletRefundTitle;

  /// No description provided for @walletRefundMeta.
  ///
  /// In en, this message translates to:
  /// **'Yesterday, 9:12 AM • Delivery'**
  String get walletRefundMeta;

  /// No description provided for @walletRefundAmount.
  ///
  /// In en, this message translates to:
  /// **'+ JOD 8.75'**
  String get walletRefundAmount;

  /// No description provided for @walletRefundCredit.
  ///
  /// In en, this message translates to:
  /// **'Wallet Credit'**
  String get walletRefundCredit;

  /// No description provided for @walletTopUpTitle.
  ///
  /// In en, this message translates to:
  /// **'Wallet Top-Up'**
  String get walletTopUpTitle;

  /// No description provided for @walletTopUpMeta.
  ///
  /// In en, this message translates to:
  /// **'Oct 24, 6:30 PM • Visa **** 4242'**
  String get walletTopUpMeta;

  /// No description provided for @walletTopUpAmount.
  ///
  /// In en, this message translates to:
  /// **'+ JOD 50.00'**
  String get walletTopUpAmount;

  /// No description provided for @walletTopUpStatus.
  ///
  /// In en, this message translates to:
  /// **'Success'**
  String get walletTopUpStatus;

  /// No description provided for @walletPastaPrime.
  ///
  /// In en, this message translates to:
  /// **'Pasta Prime'**
  String get walletPastaPrime;

  /// No description provided for @walletPastaMeta.
  ///
  /// In en, this message translates to:
  /// **'Oct 23, 1:15 PM • Takeaway'**
  String get walletPastaMeta;

  /// No description provided for @walletPastaAmount.
  ///
  /// In en, this message translates to:
  /// **'- JOD 14.20'**
  String get walletPastaAmount;

  /// No description provided for @walletPastaPoints.
  ///
  /// In en, this message translates to:
  /// **'+ 28 pts'**
  String get walletPastaPoints;

  /// No description provided for @walletFreeDrinkReward.
  ///
  /// In en, this message translates to:
  /// **'Free Drink Reward'**
  String get walletFreeDrinkReward;

  /// No description provided for @walletFreeDrinkMeta.
  ///
  /// In en, this message translates to:
  /// **'Oct 22, 11:00 AM • Point Redemption'**
  String get walletFreeDrinkMeta;

  /// No description provided for @walletFreeDrinkAmount.
  ///
  /// In en, this message translates to:
  /// **'JOD 0.00'**
  String get walletFreeDrinkAmount;

  /// No description provided for @walletFreeDrinkPoints.
  ///
  /// In en, this message translates to:
  /// **'- 500 pts'**
  String get walletFreeDrinkPoints;

  /// No description provided for @walletViewAllHistory.
  ///
  /// In en, this message translates to:
  /// **'View All History'**
  String get walletViewAllHistory;

  /// No description provided for @refundStep2Title.
  ///
  /// In en, this message translates to:
  /// **'Step 2 of 3'**
  String get refundStep2Title;

  /// No description provided for @refundStep2Header.
  ///
  /// In en, this message translates to:
  /// **'Damage Assessment'**
  String get refundStep2Header;

  /// No description provided for @refundStep2Body.
  ///
  /// In en, this message translates to:
  /// **'Inspect returned items for any structural damage. Selecting \'Damaged\' will allow you to enter a deduction from the initial deposit.'**
  String get refundStep2Body;

  /// No description provided for @refundCeramicPlate.
  ///
  /// In en, this message translates to:
  /// **'Ceramic Mezze Plate'**
  String get refundCeramicPlate;

  /// No description provided for @refundCeramicPlateAsset.
  ///
  /// In en, this message translates to:
  /// **'Asset ID: SAV-P-442'**
  String get refundCeramicPlateAsset;

  /// No description provided for @refundWoodenTray.
  ///
  /// In en, this message translates to:
  /// **'Wooden Serving Tray (Large)'**
  String get refundWoodenTray;

  /// No description provided for @refundWoodenTrayAsset.
  ///
  /// In en, this message translates to:
  /// **'Asset ID: SAV-T-012'**
  String get refundWoodenTrayAsset;

  /// No description provided for @refundCoffeePot.
  ///
  /// In en, this message translates to:
  /// **'Signature Coffee Pot'**
  String get refundCoffeePot;

  /// No description provided for @refundCoffeePotAsset.
  ///
  /// In en, this message translates to:
  /// **'Asset ID: SAV-P-118'**
  String get refundCoffeePotAsset;

  /// No description provided for @refundReturned.
  ///
  /// In en, this message translates to:
  /// **'Returned'**
  String get refundReturned;

  /// No description provided for @refundDamaged.
  ///
  /// In en, this message translates to:
  /// **'Damaged'**
  String get refundDamaged;

  /// No description provided for @refundDepositSummary.
  ///
  /// In en, this message translates to:
  /// **'Deposit Summary'**
  String get refundDepositSummary;

  /// No description provided for @refundHeldFunds.
  ///
  /// In en, this message translates to:
  /// **'(Held Funds)'**
  String get refundHeldFunds;

  /// No description provided for @refundDepositAmount.
  ///
  /// In en, this message translates to:
  /// **'15.00'**
  String get refundDepositAmount;

  /// No description provided for @refundEstimateBody.
  ///
  /// In en, this message translates to:
  /// **'Estimated refund will update automatically based on damage deductions entered above.'**
  String get refundEstimateBody;

  /// No description provided for @refundCancelFlow.
  ///
  /// In en, this message translates to:
  /// **'Cancel Flow'**
  String get refundCancelFlow;

  /// No description provided for @refundReviewRefund.
  ///
  /// In en, this message translates to:
  /// **'Review Refund'**
  String get refundReviewRefund;

  /// No description provided for @refundStep3Title.
  ///
  /// In en, this message translates to:
  /// **'Step 3 of 3'**
  String get refundStep3Title;

  /// No description provided for @refundReadyForPayout.
  ///
  /// In en, this message translates to:
  /// **'Ready for Payout'**
  String get refundReadyForPayout;

  /// No description provided for @refundSettlementSummary.
  ///
  /// In en, this message translates to:
  /// **'Settlement Summary'**
  String get refundSettlementSummary;

  /// No description provided for @refundOriginalDeposit.
  ///
  /// In en, this message translates to:
  /// **'Original Deposit'**
  String get refundOriginalDeposit;

  /// No description provided for @refundReceivedAtTable.
  ///
  /// In en, this message translates to:
  /// **'Received at Table 12'**
  String get refundReceivedAtTable;

  /// No description provided for @refundOriginalDepositAmount.
  ///
  /// In en, this message translates to:
  /// **'5.00 JOD'**
  String get refundOriginalDepositAmount;

  /// No description provided for @refundBreakageFees.
  ///
  /// In en, this message translates to:
  /// **'Breakage Fees'**
  String get refundBreakageFees;

  /// No description provided for @refundBreakageDetails.
  ///
  /// In en, this message translates to:
  /// **'1x Ceramic Plate, 1x Glass'**
  String get refundBreakageDetails;

  /// No description provided for @refundBreakageAmount.
  ///
  /// In en, this message translates to:
  /// **'- 1.50 JOD'**
  String get refundBreakageAmount;

  /// No description provided for @refundNetRefund.
  ///
  /// In en, this message translates to:
  /// **'Net Refund'**
  String get refundNetRefund;

  /// No description provided for @refundCreditingWallet.
  ///
  /// In en, this message translates to:
  /// **'Crediting to Customer Wallet'**
  String get refundCreditingWallet;

  /// No description provided for @refundNetRefundAmount.
  ///
  /// In en, this message translates to:
  /// **'3.50 JOD'**
  String get refundNetRefundAmount;

  /// No description provided for @refundTotalSettlement.
  ///
  /// In en, this message translates to:
  /// **'Total Settlement'**
  String get refundTotalSettlement;

  /// No description provided for @refundImmediateNotice.
  ///
  /// In en, this message translates to:
  /// **'The refund will be processed immediately to the user\'s Ayletna Wallet. A digital receipt will be sent via SMS to +962 *** *** 44.'**
  String get refundImmediateNotice;

  /// No description provided for @refundCustomerInfo.
  ///
  /// In en, this message translates to:
  /// **'Customer Info'**
  String get refundCustomerInfo;

  /// No description provided for @refundCustomerName.
  ///
  /// In en, this message translates to:
  /// **'Zaid Al-Farah'**
  String get refundCustomerName;

  /// No description provided for @refundCustomerTier.
  ///
  /// In en, this message translates to:
  /// **'Gold Member'**
  String get refundCustomerTier;

  /// No description provided for @refundCurrentWallet.
  ///
  /// In en, this message translates to:
  /// **'Current Wallet'**
  String get refundCurrentWallet;

  /// No description provided for @refundPostRefund.
  ///
  /// In en, this message translates to:
  /// **'Post-Refund'**
  String get refundPostRefund;

  /// No description provided for @refundCurrentWalletAmount.
  ///
  /// In en, this message translates to:
  /// **'12.45 JOD'**
  String get refundCurrentWalletAmount;

  /// No description provided for @refundPostRefundAmount.
  ///
  /// In en, this message translates to:
  /// **'15.95 JOD'**
  String get refundPostRefundAmount;

  /// No description provided for @refundTerminalId.
  ///
  /// In en, this message translates to:
  /// **'Terminal ID'**
  String get refundTerminalId;

  /// No description provided for @refundTerminalCode.
  ///
  /// In en, this message translates to:
  /// **'POS-AMM-042'**
  String get refundTerminalCode;

  /// No description provided for @refundAuthorizedCashier.
  ///
  /// In en, this message translates to:
  /// **'Authorized cashier pin'**
  String get refundAuthorizedCashier;

  /// No description provided for @refundVerifiedTransaction.
  ///
  /// In en, this message translates to:
  /// **'Verified Transaction'**
  String get refundVerifiedTransaction;

  /// No description provided for @refundConfirmProcess.
  ///
  /// In en, this message translates to:
  /// **'Confirm & Process Refund'**
  String get refundConfirmProcess;

  /// No description provided for @refundModifyAssessment.
  ///
  /// In en, this message translates to:
  /// **'Modify Breakage Assessment'**
  String get refundModifyAssessment;

  /// No description provided for @refundIdentification.
  ///
  /// In en, this message translates to:
  /// **'Identification'**
  String get refundIdentification;

  /// No description provided for @refundAssessment.
  ///
  /// In en, this message translates to:
  /// **'Assessment'**
  String get refundAssessment;

  /// No description provided for @refundSettlement.
  ///
  /// In en, this message translates to:
  /// **'Settlement'**
  String get refundSettlement;

  /// No description provided for @returnStep1Title.
  ///
  /// In en, this message translates to:
  /// **'Return Items'**
  String get returnStep1Title;

  /// No description provided for @returnStep1Subtitle.
  ///
  /// In en, this message translates to:
  /// **'Step 1 of 2: Checklist'**
  String get returnStep1Subtitle;

  /// No description provided for @returnOrder8842.
  ///
  /// In en, this message translates to:
  /// **'Order #8842'**
  String get returnOrder8842;

  /// No description provided for @returnOrderMeta.
  ///
  /// In en, this message translates to:
  /// **'Table 12 • 4 Items Expected'**
  String get returnOrderMeta;

  /// No description provided for @returnExpectedCeramicItems.
  ///
  /// In en, this message translates to:
  /// **'Expected Ceramic Items'**
  String get returnExpectedCeramicItems;

  /// No description provided for @returnDeepBowls.
  ///
  /// In en, this message translates to:
  /// **'2x Deep Bowls'**
  String get returnDeepBowls;

  /// No description provided for @returnDeepBowlsMeta.
  ///
  /// In en, this message translates to:
  /// **'Signature Series • Sage Trim'**
  String get returnDeepBowlsMeta;

  /// No description provided for @returnMainPlates.
  ///
  /// In en, this message translates to:
  /// **'2x Main Plates'**
  String get returnMainPlates;

  /// No description provided for @returnMainPlatesMeta.
  ///
  /// In en, this message translates to:
  /// **'Signature Series • 12-inch'**
  String get returnMainPlatesMeta;

  /// No description provided for @returnCollected.
  ///
  /// In en, this message translates to:
  /// **'Collected'**
  String get returnCollected;

  /// No description provided for @returnMissing.
  ///
  /// In en, this message translates to:
  /// **'Missing'**
  String get returnMissing;

  /// No description provided for @returnMissingWarning.
  ///
  /// In en, this message translates to:
  /// **'Missing items will be flagged for manager review and may incur a replacement fee for the customer.'**
  String get returnMissingWarning;

  /// No description provided for @returnContinueStep2.
  ///
  /// In en, this message translates to:
  /// **'Continue to Step 2'**
  String get returnContinueStep2;

  /// No description provided for @returnStep2Title.
  ///
  /// In en, this message translates to:
  /// **'Step 2 of 2'**
  String get returnStep2Title;

  /// No description provided for @returnConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Confirmation'**
  String get returnConfirmation;

  /// No description provided for @returnVerificationComplete.
  ///
  /// In en, this message translates to:
  /// **'Verification Complete'**
  String get returnVerificationComplete;

  /// No description provided for @returnVerificationBody.
  ///
  /// In en, this message translates to:
  /// **'Deposit will be credited to wallet instantly.'**
  String get returnVerificationBody;

  /// No description provided for @returnBreakageFeeAmount.
  ///
  /// In en, this message translates to:
  /// **'- 2.500 JOD'**
  String get returnBreakageFeeAmount;

  /// No description provided for @returnBreakageFeeBody.
  ///
  /// In en, this message translates to:
  /// **'2x Ceramic Bowls reported damaged'**
  String get returnBreakageFeeBody;

  /// No description provided for @returnNetRefundAmount.
  ///
  /// In en, this message translates to:
  /// **'12.500 JOD'**
  String get returnNetRefundAmount;

  /// No description provided for @returnReadyInstantCredit.
  ///
  /// In en, this message translates to:
  /// **'Ready for instant credit'**
  String get returnReadyInstantCredit;

  /// No description provided for @returnSummaryDetails.
  ///
  /// In en, this message translates to:
  /// **'Summary Details'**
  String get returnSummaryDetails;

  /// No description provided for @returnOriginalDeposit.
  ///
  /// In en, this message translates to:
  /// **'Original Deposit'**
  String get returnOriginalDeposit;

  /// No description provided for @returnOriginalDepositAmount.
  ///
  /// In en, this message translates to:
  /// **'15.000 JOD'**
  String get returnOriginalDepositAmount;

  /// No description provided for @returnBreakageTwoItems.
  ///
  /// In en, this message translates to:
  /// **'Breakage (2 Items)'**
  String get returnBreakageTwoItems;

  /// No description provided for @returnProcessingFee.
  ///
  /// In en, this message translates to:
  /// **'Processing Fee'**
  String get returnProcessingFee;

  /// No description provided for @returnWaived.
  ///
  /// In en, this message translates to:
  /// **'Waived'**
  String get returnWaived;

  /// No description provided for @returnFinalRefund.
  ///
  /// In en, this message translates to:
  /// **'Final Refund'**
  String get returnFinalRefund;

  /// No description provided for @returnSignToConfirm.
  ///
  /// In en, this message translates to:
  /// **'Sign to Confirm'**
  String get returnSignToConfirm;

  /// No description provided for @returnSignatureRequired.
  ///
  /// In en, this message translates to:
  /// **'Customer signature required here'**
  String get returnSignatureRequired;

  /// No description provided for @returnClearSignature.
  ///
  /// In en, this message translates to:
  /// **'Clear Signature'**
  String get returnClearSignature;

  /// No description provided for @returnFinalizeReturn.
  ///
  /// In en, this message translates to:
  /// **'Finalize Return'**
  String get returnFinalizeReturn;

  /// No description provided for @returnFinalizeDisclaimer.
  ///
  /// In en, this message translates to:
  /// **'By clicking Finalize Return, you confirm that all items have been inspected and the refund amount is accurate.'**
  String get returnFinalizeDisclaimer;

  /// No description provided for @platedReturnBadge.
  ///
  /// In en, this message translates to:
  /// **'Plated Experience'**
  String get platedReturnBadge;

  /// No description provided for @platedReturnReadyTitle.
  ///
  /// In en, this message translates to:
  /// **'Ready to return?'**
  String get platedReturnReadyTitle;

  /// No description provided for @platedReturnReadyBody.
  ///
  /// In en, this message translates to:
  /// **'We hope you enjoyed your meal! Please let us know how you\'d like to return your ceramic plate set.'**
  String get platedReturnReadyBody;

  /// No description provided for @platedReturnDepositTitle.
  ///
  /// In en, this message translates to:
  /// **'Refundable Deposit'**
  String get platedReturnDepositTitle;

  /// No description provided for @platedReturnDepositBody.
  ///
  /// In en, this message translates to:
  /// **'Your 5 JOD deposit will be credited back to your wallet instantly upon receipt of the items.'**
  String get platedReturnDepositBody;

  /// No description provided for @platedReturnSchedulePickup.
  ///
  /// In en, this message translates to:
  /// **'Schedule Pickup'**
  String get platedReturnSchedulePickup;

  /// No description provided for @platedReturnSelfReturn.
  ///
  /// In en, this message translates to:
  /// **'I\'ll return it myself'**
  String get platedReturnSelfReturn;

  /// No description provided for @screenRatingReview.
  ///
  /// In en, this message translates to:
  /// **'Rate your meal'**
  String get screenRatingReview;

  /// No description provided for @screenRatingReviewDesc.
  ///
  /// In en, this message translates to:
  /// **'Post-delivery rating and review screen.'**
  String get screenRatingReviewDesc;

  /// No description provided for @ratingHeroTitle.
  ///
  /// In en, this message translates to:
  /// **'How was your Ayletna meal?'**
  String get ratingHeroTitle;

  /// No description provided for @ratingHeroSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Your note helps the kitchen keep every dish warm, fresh, and generous.'**
  String get ratingHeroSubtitle;

  /// No description provided for @ratingOrderLabel.
  ///
  /// In en, this message translates to:
  /// **'Order experience'**
  String get ratingOrderLabel;

  /// No description provided for @ratingKitchenTitle.
  ///
  /// In en, this message translates to:
  /// **'Kitchen and freshness'**
  String get ratingKitchenTitle;

  /// No description provided for @ratingDeliveryTitle.
  ///
  /// In en, this message translates to:
  /// **'Delivery and handoff'**
  String get ratingDeliveryTitle;

  /// No description provided for @ratingPackagingTitle.
  ///
  /// In en, this message translates to:
  /// **'Packaging and plated return'**
  String get ratingPackagingTitle;

  /// No description provided for @ratingCommentLabel.
  ///
  /// In en, this message translates to:
  /// **'Add a short note'**
  String get ratingCommentLabel;

  /// No description provided for @ratingCommentHint.
  ///
  /// In en, this message translates to:
  /// **'Tell us what tasted great or what we should improve'**
  String get ratingCommentHint;

  /// No description provided for @ratingSubmit.
  ///
  /// In en, this message translates to:
  /// **'Send review'**
  String get ratingSubmit;

  /// No description provided for @ratingSuccess.
  ///
  /// In en, this message translates to:
  /// **'Thanks. Your review was added to your rewards profile.'**
  String get ratingSuccess;

  /// No description provided for @ratingRewardLoop.
  ///
  /// In en, this message translates to:
  /// **'+50 Savor Points after review'**
  String get ratingRewardLoop;

  /// No description provided for @ratingReviewLater.
  ///
  /// In en, this message translates to:
  /// **'Review later'**
  String get ratingReviewLater;

  /// No description provided for @reportFilterIntro.
  ///
  /// In en, this message translates to:
  /// **'Choose the analytics scope before reviewing sales, inventory, tips, and plate decisions.'**
  String get reportFilterIntro;

  /// No description provided for @reportFilterPeriod.
  ///
  /// In en, this message translates to:
  /// **'Period'**
  String get reportFilterPeriod;

  /// No description provided for @reportFilterChannel.
  ///
  /// In en, this message translates to:
  /// **'Channel'**
  String get reportFilterChannel;

  /// No description provided for @reportFilterModules.
  ///
  /// In en, this message translates to:
  /// **'Report modules'**
  String get reportFilterModules;

  /// No description provided for @reportFilterSummary.
  ///
  /// In en, this message translates to:
  /// **'Filter summary'**
  String get reportFilterSummary;

  /// No description provided for @reportFilterModuleCount.
  ///
  /// In en, this message translates to:
  /// **'{count} modules'**
  String reportFilterModuleCount(int count);

  /// No description provided for @reportFilterReset.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get reportFilterReset;

  /// No description provided for @reportFilterApply.
  ///
  /// In en, this message translates to:
  /// **'Apply filters'**
  String get reportFilterApply;

  /// No description provided for @reportFilterApplied.
  ///
  /// In en, this message translates to:
  /// **'Report filters applied'**
  String get reportFilterApplied;

  /// No description provided for @reportFilterShift.
  ///
  /// In en, this message translates to:
  /// **'Shift'**
  String get reportFilterShift;

  /// No description provided for @reportFilterAllChannels.
  ///
  /// In en, this message translates to:
  /// **'All channels'**
  String get reportFilterAllChannels;

  /// No description provided for @reportFilterDineIn.
  ///
  /// In en, this message translates to:
  /// **'Dine-in'**
  String get reportFilterDineIn;

  /// No description provided for @reportFilterTakeaway.
  ///
  /// In en, this message translates to:
  /// **'Takeaway'**
  String get reportFilterTakeaway;

  /// No description provided for @reportFilterDelivery.
  ///
  /// In en, this message translates to:
  /// **'Delivery'**
  String get reportFilterDelivery;

  /// No description provided for @reportFilterPlated.
  ///
  /// In en, this message translates to:
  /// **'Plated'**
  String get reportFilterPlated;

  /// No description provided for @reportFilterPlatesDeposits.
  ///
  /// In en, this message translates to:
  /// **'Plates & deposits'**
  String get reportFilterPlatesDeposits;

  /// No description provided for @cartCustomizationQuantity.
  ///
  /// In en, this message translates to:
  /// **'Quantity'**
  String get cartCustomizationQuantity;

  /// No description provided for @adminGrowthHubBadge.
  ///
  /// In en, this message translates to:
  /// **'Admin Team & Growth Hub'**
  String get adminGrowthHubBadge;

  /// No description provided for @adminGrowthHubHero.
  ///
  /// In en, this message translates to:
  /// **'One place to manage team hours, owner privacy, loyalty, and offers instead of scattered weak pages.'**
  String get adminGrowthHubHero;

  /// No description provided for @adminGrowthHubTodayHours.
  ///
  /// In en, this message translates to:
  /// **'Today hours'**
  String get adminGrowthHubTodayHours;

  /// No description provided for @adminGrowthHubLoyaltyGuests.
  ///
  /// In en, this message translates to:
  /// **'Loyalty guests'**
  String get adminGrowthHubLoyaltyGuests;

  /// No description provided for @adminGrowthHubActiveOffers.
  ///
  /// In en, this message translates to:
  /// **'Active offers'**
  String get adminGrowthHubActiveOffers;

  /// No description provided for @adminGrowthStaffTitle.
  ///
  /// In en, this message translates to:
  /// **'Team Hours & Shifts'**
  String get adminGrowthStaffTitle;

  /// No description provided for @adminGrowthStaffSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Track coverage, hours, and tips by restaurant role.'**
  String get adminGrowthStaffSubtitle;

  /// No description provided for @adminGrowthKitchen.
  ///
  /// In en, this message translates to:
  /// **'Kitchen'**
  String get adminGrowthKitchen;

  /// No description provided for @adminGrowthKitchenDetail.
  ///
  /// In en, this message translates to:
  /// **'Good cover, one reminder late'**
  String get adminGrowthKitchenDetail;

  /// No description provided for @adminGrowthCashier.
  ///
  /// In en, this message translates to:
  /// **'Cashier'**
  String get adminGrowthCashier;

  /// No description provided for @adminGrowthCashierDetail.
  ///
  /// In en, this message translates to:
  /// **'Close shift needs approval'**
  String get adminGrowthCashierDetail;

  /// No description provided for @adminGrowthDelivery.
  ///
  /// In en, this message translates to:
  /// **'Delivery'**
  String get adminGrowthDelivery;

  /// No description provided for @adminGrowthDeliveryDetail.
  ///
  /// In en, this message translates to:
  /// **'Evening peak needs one more driver'**
  String get adminGrowthDeliveryDetail;

  /// No description provided for @adminGrowthTips.
  ///
  /// In en, this message translates to:
  /// **'Tips'**
  String get adminGrowthTips;

  /// No description provided for @adminGrowthTipsDetail.
  ///
  /// In en, this message translates to:
  /// **'Ready after hours approval'**
  String get adminGrowthTipsDetail;

  /// No description provided for @adminGrowthPrivacySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Owner view and finance-report visibility rules.'**
  String get adminGrowthPrivacySubtitle;

  /// No description provided for @adminGrowthLoyaltySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Turn loyalty into repeat visits and clear food orders.'**
  String get adminGrowthLoyaltySubtitle;

  /// No description provided for @adminGrowthPointsRule.
  ///
  /// In en, this message translates to:
  /// **'Points rule'**
  String get adminGrowthPointsRule;

  /// No description provided for @adminGrowthEnableLunchMultiplier.
  ///
  /// In en, this message translates to:
  /// **'Double loyalty points'**
  String get adminGrowthEnableLunchMultiplier;

  /// No description provided for @adminGrowthLunchMultiplierBody.
  ///
  /// In en, this message translates to:
  /// **'When on, customers earn 2× points on add-to-cart from product detail.'**
  String get adminGrowthLunchMultiplierBody;

  /// No description provided for @adminGrowthBirthdayDessertBody.
  ///
  /// In en, this message translates to:
  /// **'Visible only during the guest birthday window.'**
  String get adminGrowthBirthdayDessertBody;

  /// No description provided for @adminGrowthTarget.
  ///
  /// In en, this message translates to:
  /// **'Target'**
  String get adminGrowthTarget;

  /// No description provided for @adminGrowthTargetBody.
  ///
  /// In en, this message translates to:
  /// **'Second visit within 14 days'**
  String get adminGrowthTargetBody;

  /// No description provided for @adminGrowthOffersSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Offers connect to inventory and margins, not generic marketing cards.'**
  String get adminGrowthOffersSubtitle;

  /// No description provided for @adminGrowthShawarmaOffer.
  ///
  /// In en, this message translates to:
  /// **'Shawarma meal lunch offer'**
  String get adminGrowthShawarmaOffer;

  /// No description provided for @adminGrowthShawarmaOfferBody.
  ///
  /// In en, this message translates to:
  /// **'Tied to lunch peak and prep capacity.'**
  String get adminGrowthShawarmaOfferBody;

  /// No description provided for @adminGrowthFamilyTrayOffer.
  ///
  /// In en, this message translates to:
  /// **'Family plated bundle'**
  String get adminGrowthFamilyTrayOffer;

  /// No description provided for @adminGrowthFamilyTrayOfferBody.
  ///
  /// In en, this message translates to:
  /// **'Requires tray availability and clear deposit rule.'**
  String get adminGrowthFamilyTrayOfferBody;

  /// No description provided for @adminGrowthHomeOffers.
  ///
  /// In en, this message translates to:
  /// **'Home offers'**
  String get adminGrowthHomeOffers;

  /// No description provided for @adminGrowthHomeOffersBody.
  ///
  /// In en, this message translates to:
  /// **'Shown in the offers section when the list is not empty.'**
  String get adminGrowthHomeOffersBody;

  /// No description provided for @adminGrowthCombos.
  ///
  /// In en, this message translates to:
  /// **'Combos'**
  String get adminGrowthCombos;

  /// No description provided for @adminGrowthCombosBody.
  ///
  /// In en, this message translates to:
  /// **'Shown in combo sections on customer and guest pages.'**
  String get adminGrowthCombosBody;

  /// No description provided for @adminGrowthDiscountedItems.
  ///
  /// In en, this message translates to:
  /// **'Discounted items'**
  String get adminGrowthDiscountedItems;

  /// No description provided for @adminGrowthDiscountedItemsBody.
  ///
  /// In en, this message translates to:
  /// **'Hidden automatically when no discounted items exist.'**
  String get adminGrowthDiscountedItemsBody;

  /// No description provided for @adminGrowthSubscriptionItems.
  ///
  /// In en, this message translates to:
  /// **'Subscription items'**
  String get adminGrowthSubscriptionItems;

  /// No description provided for @adminGrowthSubscriptionItemsBody.
  ///
  /// In en, this message translates to:
  /// **'Supports monthly or annual subscription offers.'**
  String get adminGrowthSubscriptionItemsBody;

  /// No description provided for @adminGrowthTargetMargin.
  ///
  /// In en, this message translates to:
  /// **'Target margin'**
  String get adminGrowthTargetMargin;

  /// No description provided for @adminGrowthTargetMarginBody.
  ///
  /// In en, this message translates to:
  /// **'Do not publish if margin drops below target.'**
  String get adminGrowthTargetMarginBody;

  /// No description provided for @adminGrowthDecisionStaff.
  ///
  /// In en, this message translates to:
  /// **'Approve close-shift hours before tip payout.'**
  String get adminGrowthDecisionStaff;

  /// No description provided for @adminGrowthDecisionPrivacy.
  ///
  /// In en, this message translates to:
  /// **'Show net profit only during owner performance review.'**
  String get adminGrowthDecisionPrivacy;

  /// No description provided for @adminGrowthDecisionLoyalty.
  ///
  /// In en, this message translates to:
  /// **'Tie point multipliers to soft demand windows.'**
  String get adminGrowthDecisionLoyalty;

  /// No description provided for @adminGrowthDecisionOffers.
  ///
  /// In en, this message translates to:
  /// **'Test the shawarma offer before publishing plated bundles.'**
  String get adminGrowthDecisionOffers;

  /// No description provided for @adminGrowthSuggestedDecision.
  ///
  /// In en, this message translates to:
  /// **'Suggested Decision'**
  String get adminGrowthSuggestedDecision;

  /// No description provided for @adminGrowthExpectedImpact.
  ///
  /// In en, this message translates to:
  /// **'Expected impact'**
  String get adminGrowthExpectedImpact;

  /// No description provided for @adminGrowthExpectedImpactValue.
  ///
  /// In en, this message translates to:
  /// **'+8% repeat orders'**
  String get adminGrowthExpectedImpactValue;

  /// No description provided for @adminGrowthActionsTitle.
  ///
  /// In en, this message translates to:
  /// **'Admin Actions'**
  String get adminGrowthActionsTitle;

  /// No description provided for @adminGrowthActionsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Manage growth campaigns and offers.'**
  String get adminGrowthActionsSubtitle;

  /// No description provided for @adminGrowthSaveSettings.
  ///
  /// In en, this message translates to:
  /// **'Save settings'**
  String get adminGrowthSaveSettings;

  /// No description provided for @adminGrowthSettingsSaved.
  ///
  /// In en, this message translates to:
  /// **'Hub settings saved'**
  String get adminGrowthSettingsSaved;

  /// No description provided for @adminGrowthOpenAuditLog.
  ///
  /// In en, this message translates to:
  /// **'Open audit log'**
  String get adminGrowthOpenAuditLog;

  /// No description provided for @languageEmblemArabic.
  ///
  /// In en, this message translates to:
  /// **'ع'**
  String get languageEmblemArabic;

  /// No description provided for @languageEmblemEnglish.
  ///
  /// In en, this message translates to:
  /// **'EN'**
  String get languageEmblemEnglish;

  /// No description provided for @authLoginInvalidCredentials.
  ///
  /// In en, this message translates to:
  /// **'Invalid phone, email, or password.'**
  String get authLoginInvalidCredentials;

  /// No description provided for @settingsProfileRefreshed.
  ///
  /// In en, this message translates to:
  /// **'Profile refreshed.'**
  String get settingsProfileRefreshed;

  /// No description provided for @ownershipShareValue.
  ///
  /// In en, this message translates to:
  /// **'{share}%'**
  String ownershipShareValue(String share);

  /// No description provided for @pendingApprovalRefreshed.
  ///
  /// In en, this message translates to:
  /// **'Approval status checked.'**
  String get pendingApprovalRefreshed;

  /// No description provided for @roleSelectionOpsSection.
  ///
  /// In en, this message translates to:
  /// **'Operations & customer'**
  String get roleSelectionOpsSection;

  /// No description provided for @supportCreateTicketTitle.
  ///
  /// In en, this message translates to:
  /// **'Open support ticket'**
  String get supportCreateTicketTitle;

  /// No description provided for @supportFieldTitleEn.
  ///
  /// In en, this message translates to:
  /// **'Title (EN)'**
  String get supportFieldTitleEn;

  /// No description provided for @supportFieldTitleAr.
  ///
  /// In en, this message translates to:
  /// **'Title (AR)'**
  String get supportFieldTitleAr;

  /// No description provided for @supportFieldDescriptionEn.
  ///
  /// In en, this message translates to:
  /// **'Description (EN)'**
  String get supportFieldDescriptionEn;

  /// No description provided for @supportFieldDescriptionAr.
  ///
  /// In en, this message translates to:
  /// **'Description (AR)'**
  String get supportFieldDescriptionAr;

  /// No description provided for @supportSubmitTicket.
  ///
  /// In en, this message translates to:
  /// **'Submit ticket'**
  String get supportSubmitTicket;

  /// No description provided for @supportValidationTitleBody.
  ///
  /// In en, this message translates to:
  /// **'Enter title and description'**
  String get supportValidationTitleBody;

  /// No description provided for @supportTicketsEmpty.
  ///
  /// In en, this message translates to:
  /// **'No tickets yet. Create one using the form above.'**
  String get supportTicketsEmpty;

  /// No description provided for @supportMessageStaffPrefix.
  ///
  /// In en, this message translates to:
  /// **'Support: '**
  String get supportMessageStaffPrefix;

  /// No description provided for @supportYourRating.
  ///
  /// In en, this message translates to:
  /// **'Your rating'**
  String get supportYourRating;

  /// No description provided for @supportYourReply.
  ///
  /// In en, this message translates to:
  /// **'Your reply'**
  String get supportYourReply;

  /// No description provided for @supportSendReply.
  ///
  /// In en, this message translates to:
  /// **'Send reply'**
  String get supportSendReply;

  /// No description provided for @supportRateAfterResolved.
  ///
  /// In en, this message translates to:
  /// **'Rate only after ticket is resolved'**
  String get supportRateAfterResolved;

  /// No description provided for @timeAgoMinutes.
  ///
  /// In en, this message translates to:
  /// **'{count}m ago'**
  String timeAgoMinutes(int count);

  /// No description provided for @timeAgoHours.
  ///
  /// In en, this message translates to:
  /// **'{count}h ago'**
  String timeAgoHours(int count);

  /// No description provided for @timeAgoDays.
  ///
  /// In en, this message translates to:
  /// **'{count}d ago'**
  String timeAgoDays(int count);

  /// No description provided for @promoDetailOfferDetails.
  ///
  /// In en, this message translates to:
  /// **'Offer details'**
  String get promoDetailOfferDetails;

  /// No description provided for @promoDetailIncludes.
  ///
  /// In en, this message translates to:
  /// **'Includes'**
  String get promoDetailIncludes;

  /// No description provided for @promoDetailDescription.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get promoDetailDescription;

  /// No description provided for @promoDetailDiscount.
  ///
  /// In en, this message translates to:
  /// **'Discount'**
  String get promoDetailDiscount;

  /// No description provided for @promoDetailLoyaltyPoints.
  ///
  /// In en, this message translates to:
  /// **'Loyalty points'**
  String get promoDetailLoyaltyPoints;

  /// No description provided for @promoDetailValidFor.
  ///
  /// In en, this message translates to:
  /// **'Valid for'**
  String get promoDetailValidFor;

  /// No description provided for @promoDetailThisWeek.
  ///
  /// In en, this message translates to:
  /// **'This week'**
  String get promoDetailThisWeek;

  /// No description provided for @promoDetailLimitedOfferDesc.
  ///
  /// In en, this message translates to:
  /// **'Limited-time offer. Order now before it expires.'**
  String get promoDetailLimitedOfferDesc;

  /// No description provided for @promoDetailComboDesc.
  ///
  /// In en, this message translates to:
  /// **'A bundled combo that brings our best dishes together at a special price.'**
  String get promoDetailComboDesc;

  /// No description provided for @promoDetailBundleSavings.
  ///
  /// In en, this message translates to:
  /// **'Bundle savings'**
  String get promoDetailBundleSavings;

  /// No description provided for @promoDetailItemsCount.
  ///
  /// In en, this message translates to:
  /// **'Items'**
  String get promoDetailItemsCount;

  /// No description provided for @promoDetailBillingCycle.
  ///
  /// In en, this message translates to:
  /// **'Billing cycle'**
  String get promoDetailBillingCycle;

  /// No description provided for @promoDetailWeekly.
  ///
  /// In en, this message translates to:
  /// **'Weekly'**
  String get promoDetailWeekly;

  /// No description provided for @promoDetailMonthly.
  ///
  /// In en, this message translates to:
  /// **'Monthly'**
  String get promoDetailMonthly;

  /// No description provided for @promoDetailSubscriptionDesc.
  ///
  /// In en, this message translates to:
  /// **'Weekly or monthly meal subscription.'**
  String get promoDetailSubscriptionDesc;

  /// No description provided for @promoDetailViewMeal.
  ///
  /// In en, this message translates to:
  /// **'View meal'**
  String get promoDetailViewMeal;

  /// No description provided for @promoPercentOff.
  ///
  /// In en, this message translates to:
  /// **'{percent}% off'**
  String promoPercentOff(String percent);

  /// No description provided for @cartInvalidPromoCode.
  ///
  /// In en, this message translates to:
  /// **'Invalid code — try AYLETNA10 or WELCOME'**
  String get cartInvalidPromoCode;

  /// No description provided for @homeOfferAddedToCart.
  ///
  /// In en, this message translates to:
  /// **'Offer added to cart'**
  String get homeOfferAddedToCart;

  /// No description provided for @homeComboAddedToCart.
  ///
  /// In en, this message translates to:
  /// **'Combo added to cart'**
  String get homeComboAddedToCart;

  /// No description provided for @productAddedToCart.
  ///
  /// In en, this message translates to:
  /// **'Added to cart'**
  String get productAddedToCart;

  /// No description provided for @productContinueShopping.
  ///
  /// In en, this message translates to:
  /// **'Continue shopping'**
  String get productContinueShopping;

  /// No description provided for @productCheckout.
  ///
  /// In en, this message translates to:
  /// **'Checkout'**
  String get productCheckout;

  /// No description provided for @productRelatedProducts.
  ///
  /// In en, this message translates to:
  /// **'Related products'**
  String get productRelatedProducts;

  /// No description provided for @productCustomerReviews.
  ///
  /// In en, this message translates to:
  /// **'Customer reviews'**
  String get productCustomerReviews;

  /// No description provided for @productMoreReviews.
  ///
  /// In en, this message translates to:
  /// **'More reviews'**
  String get productMoreReviews;

  /// No description provided for @productRewardCoins.
  ///
  /// In en, this message translates to:
  /// **'{count} coins'**
  String productRewardCoins(int count);

  /// No description provided for @searchRefreshed.
  ///
  /// In en, this message translates to:
  /// **'Menu search refreshed'**
  String get searchRefreshed;

  /// No description provided for @productNoReviewsYet.
  ///
  /// In en, this message translates to:
  /// **'No approved reviews yet.'**
  String get productNoReviewsYet;

  /// No description provided for @prepMockTimerDisplay.
  ///
  /// In en, this message translates to:
  /// **'12:49'**
  String get prepMockTimerDisplay;

  /// No description provided for @platedConfirmCollectionBody.
  ///
  /// In en, this message translates to:
  /// **'Start the plated return collection for this stop?'**
  String get platedConfirmCollectionBody;

  /// No description provided for @productReviewsTitle.
  ///
  /// In en, this message translates to:
  /// **'Product reviews'**
  String get productReviewsTitle;

  /// No description provided for @productReviewsApprovedTitle.
  ///
  /// In en, this message translates to:
  /// **'Approved reviews'**
  String get productReviewsApprovedTitle;

  /// No description provided for @productReviewsCountFor.
  ///
  /// In en, this message translates to:
  /// **'{count} reviews for {title}'**
  String productReviewsCountFor(int count, String title);

  /// No description provided for @productReviewsEmptyPrompt.
  ///
  /// In en, this message translates to:
  /// **'No approved reviews yet. Rate your order after delivery.'**
  String get productReviewsEmptyPrompt;

  /// No description provided for @productRewardEarnBefore.
  ///
  /// In en, this message translates to:
  /// **'You are about to earn '**
  String get productRewardEarnBefore;

  /// No description provided for @productRewardEarnAfter.
  ///
  /// In en, this message translates to:
  /// **' with this item. Keep collecting rewards and redeem them later for Ayletna discounts and treats.'**
  String get productRewardEarnAfter;

  /// No description provided for @orderReorderFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not rebuild this order. Some items may no longer be available.'**
  String get orderReorderFailed;

  /// No description provided for @orderTrackingLoadError.
  ///
  /// In en, this message translates to:
  /// **'Unable to load order tracking. Pull to refresh or try again later.'**
  String get orderTrackingLoadError;

  /// No description provided for @ratingOrderLoadError.
  ///
  /// In en, this message translates to:
  /// **'Unable to load order details for rating.'**
  String get ratingOrderLoadError;

  /// No description provided for @paymentHistoryEmpty.
  ///
  /// In en, this message translates to:
  /// **'No payments recorded yet.'**
  String get paymentHistoryEmpty;

  /// No description provided for @redemptionNoRewardSelected.
  ///
  /// In en, this message translates to:
  /// **'No reward selected'**
  String get redemptionNoRewardSelected;

  /// No description provided for @redemptionInsufficientPoints.
  ///
  /// In en, this message translates to:
  /// **'Insufficient points'**
  String get redemptionInsufficientPoints;

  /// No description provided for @redemptionPointsBalanceTitle.
  ///
  /// In en, this message translates to:
  /// **'Points balance'**
  String get redemptionPointsBalanceTitle;

  /// No description provided for @redemptionPointsBalanceValue.
  ///
  /// In en, this message translates to:
  /// **'{balance} pts'**
  String redemptionPointsBalanceValue(int balance);

  /// No description provided for @redemptionCostLabel.
  ///
  /// In en, this message translates to:
  /// **'Redemption cost: {cost}'**
  String redemptionCostLabel(int cost);

  /// No description provided for @supportChatYou.
  ///
  /// In en, this message translates to:
  /// **'You'**
  String get supportChatYou;

  /// No description provided for @supportChatLinkedTicket.
  ///
  /// In en, this message translates to:
  /// **'Linked ticket: {ticketId}'**
  String supportChatLinkedTicket(String ticketId);

  /// No description provided for @supportChatTicketFromLiveChat.
  ///
  /// In en, this message translates to:
  /// **'Help request from live chat'**
  String get supportChatTicketFromLiveChat;

  /// No description provided for @supportChatTicketTitle.
  ///
  /// In en, this message translates to:
  /// **'Live chat'**
  String get supportChatTicketTitle;

  /// No description provided for @cartCompleteOrderTitle.
  ///
  /// In en, this message translates to:
  /// **'Complete your order'**
  String get cartCompleteOrderTitle;

  /// No description provided for @cartPopularAddonsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Popular add-ons for your basket'**
  String get cartPopularAddonsSubtitle;

  /// No description provided for @cashierConfirmLogTip.
  ///
  /// In en, this message translates to:
  /// **'Log this tip amount to the shift total?'**
  String get cashierConfirmLogTip;

  /// No description provided for @checkoutPaymentSummaryTitle.
  ///
  /// In en, this message translates to:
  /// **'Payment summary'**
  String get checkoutPaymentSummaryTitle;

  /// No description provided for @addressesDeleteFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not delete this address. Try again.'**
  String get addressesDeleteFailed;

  /// No description provided for @deliveryOrder8845Title.
  ///
  /// In en, this message translates to:
  /// **'Order #8845'**
  String get deliveryOrder8845Title;

  /// No description provided for @inventoryBatchLotLabel.
  ///
  /// In en, this message translates to:
  /// **'Batch / lot'**
  String get inventoryBatchLotLabel;

  /// No description provided for @inventoryBatchLotHint.
  ///
  /// In en, this message translates to:
  /// **'LOT-SAL-042'**
  String get inventoryBatchLotHint;

  /// No description provided for @inventoryExpiryDateLabel.
  ///
  /// In en, this message translates to:
  /// **'Expiry date'**
  String get inventoryExpiryDateLabel;

  /// No description provided for @inventoryExpiryDateHint.
  ///
  /// In en, this message translates to:
  /// **'2026-06-20'**
  String get inventoryExpiryDateHint;

  /// No description provided for @inventoryEvidenceTitle.
  ///
  /// In en, this message translates to:
  /// **'Receipt / photo evidence'**
  String get inventoryEvidenceTitle;

  /// No description provided for @inventoryAttachSupplierReceipt.
  ///
  /// In en, this message translates to:
  /// **'Attach supplier receipt'**
  String get inventoryAttachSupplierReceipt;

  /// No description provided for @inventoryAddShelfPhoto.
  ///
  /// In en, this message translates to:
  /// **'Add shelf photo'**
  String get inventoryAddShelfPhoto;

  /// No description provided for @mapDefaultAddressTitle.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get mapDefaultAddressTitle;

  /// No description provided for @mapDefaultAddressText.
  ///
  /// In en, this message translates to:
  /// **'123 Gastronomy Lane, Central Hub, Amman'**
  String get mapDefaultAddressText;

  /// No description provided for @comboDiscountOff.
  ///
  /// In en, this message translates to:
  /// **'{percent}% off'**
  String comboDiscountOff(String percent);

  /// No description provided for @billingPeriodWeekly.
  ///
  /// In en, this message translates to:
  /// **'Weekly'**
  String get billingPeriodWeekly;

  /// No description provided for @billingPeriodMonthly.
  ///
  /// In en, this message translates to:
  /// **'Monthly'**
  String get billingPeriodMonthly;

  /// No description provided for @catalogBrowseEmpty.
  ///
  /// In en, this message translates to:
  /// **'New items will appear here when available.'**
  String get catalogBrowseEmpty;

  /// No description provided for @guestOfferCartUnavailable.
  ///
  /// In en, this message translates to:
  /// **'This offer cannot be added to your cart yet.'**
  String get guestOfferCartUnavailable;

  /// No description provided for @profileRefreshed.
  ///
  /// In en, this message translates to:
  /// **'Profile refreshed.'**
  String get profileRefreshed;

  /// No description provided for @profileDeactivateNotAvailable.
  ///
  /// In en, this message translates to:
  /// **'Account deactivation is temporarily unavailable. Contact support.'**
  String get profileDeactivateNotAvailable;

  /// No description provided for @profileDeactivateConfirmBody.
  ///
  /// In en, this message translates to:
  /// **'This ends the demo session and returns you to sign-in. Real account deletion will require support once the backend is live.'**
  String get profileDeactivateConfirmBody;

  /// No description provided for @profileDeactivatedMock.
  ///
  /// In en, this message translates to:
  /// **'Demo account signed out.'**
  String get profileDeactivatedMock;

  /// No description provided for @addressSavedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Address saved'**
  String get addressSavedSuccess;

  /// No description provided for @addressSaveFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not save address'**
  String get addressSaveFailed;

  /// No description provided for @cashierAttachAddressTitle.
  ///
  /// In en, this message translates to:
  /// **'Attach address to account'**
  String get cashierAttachAddressTitle;

  /// No description provided for @cashierMobileNumber.
  ///
  /// In en, this message translates to:
  /// **'Mobile number'**
  String get cashierMobileNumber;

  /// No description provided for @cashierAccountIdOptional.
  ///
  /// In en, this message translates to:
  /// **'Account ID (optional)'**
  String get cashierAccountIdOptional;

  /// No description provided for @cashierSaveAndAttach.
  ///
  /// In en, this message translates to:
  /// **'Save & attach'**
  String get cashierSaveAndAttach;

  /// No description provided for @cashierEnterAddressFirst.
  ///
  /// In en, this message translates to:
  /// **'Enter an address first'**
  String get cashierEnterAddressFirst;

  /// No description provided for @cashierDeliveryAddressLabel.
  ///
  /// In en, this message translates to:
  /// **'Delivery address'**
  String get cashierDeliveryAddressLabel;

  /// No description provided for @cashierSavedAddressesTitle.
  ///
  /// In en, this message translates to:
  /// **'Saved addresses'**
  String get cashierSavedAddressesTitle;

  /// No description provided for @cashierSearchAddressHint.
  ///
  /// In en, this message translates to:
  /// **'Search by name or mobile'**
  String get cashierSearchAddressHint;

  /// No description provided for @cashierNoMatchingAddresses.
  ///
  /// In en, this message translates to:
  /// **'No matching saved addresses'**
  String get cashierNoMatchingAddresses;

  /// No description provided for @cashierSaveAddressLabel.
  ///
  /// In en, this message translates to:
  /// **'Save address'**
  String get cashierSaveAddressLabel;

  /// No description provided for @cashierAttachToAccountLabel.
  ///
  /// In en, this message translates to:
  /// **'Attach to phone / account'**
  String get cashierAttachToAccountLabel;

  /// No description provided for @cashierOfferAddedToCart.
  ///
  /// In en, this message translates to:
  /// **'Offer added to cart'**
  String get cashierOfferAddedToCart;

  /// No description provided for @settingsToggleSaved.
  ///
  /// In en, this message translates to:
  /// **'Setting saved'**
  String get settingsToggleSaved;

  /// No description provided for @deliveryReturnProcessRefreshed.
  ///
  /// In en, this message translates to:
  /// **'Return process refreshed.'**
  String get deliveryReturnProcessRefreshed;

  /// No description provided for @adminCommandCenterBadge.
  ///
  /// In en, this message translates to:
  /// **'Live Command Center'**
  String get adminCommandCenterBadge;

  /// No description provided for @adminCommandCenterHeadline.
  ///
  /// In en, this message translates to:
  /// **'Priority now: late tickets, stockouts, cash close, and driver delays.'**
  String get adminCommandCenterHeadline;

  /// No description provided for @adminCommandCenterBody.
  ///
  /// In en, this message translates to:
  /// **'Built for the restaurant owner: fast decisions, clear operations, and direct links into every station.'**
  String get adminCommandCenterBody;

  /// No description provided for @adminActiveOrdersMetric.
  ///
  /// In en, this message translates to:
  /// **'Active orders'**
  String get adminActiveOrdersMetric;

  /// No description provided for @adminUrgentAlertsMetric.
  ///
  /// In en, this message translates to:
  /// **'Urgent alerts'**
  String get adminUrgentAlertsMetric;

  /// No description provided for @adminOpenOrdersBoard.
  ///
  /// In en, this message translates to:
  /// **'Open Orders Board'**
  String get adminOpenOrdersBoard;

  /// No description provided for @adminCashCloseAction.
  ///
  /// In en, this message translates to:
  /// **'Cash Close'**
  String get adminCashCloseAction;

  /// No description provided for @adminNeedsAttentionTitle.
  ///
  /// In en, this message translates to:
  /// **'Needs Your Attention'**
  String get adminNeedsAttentionTitle;

  /// No description provided for @adminNeedsAttentionSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Prioritized by guest impact and shift risk.'**
  String get adminNeedsAttentionSubtitle;

  /// No description provided for @adminLateTicketsLabel.
  ///
  /// In en, this message translates to:
  /// **'{count} tickets running late'**
  String adminLateTicketsLabel(int count);

  /// No description provided for @adminLateTicketsDetail.
  ///
  /// In en, this message translates to:
  /// **'Shawarma and fryer station need attention within 4 minutes.'**
  String get adminLateTicketsDetail;

  /// No description provided for @adminOpenOrdersAction.
  ///
  /// In en, this message translates to:
  /// **'Open orders'**
  String get adminOpenOrdersAction;

  /// No description provided for @adminBelowThresholdDetail.
  ///
  /// In en, this message translates to:
  /// **'{count} ingredients below threshold.'**
  String adminBelowThresholdDetail(int count);

  /// No description provided for @adminDriverDelayedLabel.
  ///
  /// In en, this message translates to:
  /// **'Driver delayed on plated delivery'**
  String get adminDriverDelayedLabel;

  /// No description provided for @adminDriverDelayedDetail.
  ///
  /// In en, this message translates to:
  /// **'Order #{orderId} on the road — {customer}.'**
  String adminDriverDelayedDetail(String orderId, String customer);

  /// No description provided for @adminDeliveryRouteAction.
  ///
  /// In en, this message translates to:
  /// **'Delivery route'**
  String get adminDeliveryRouteAction;

  /// No description provided for @adminNoUrgentAlerts.
  ///
  /// In en, this message translates to:
  /// **'No urgent alerts — operations look stable.'**
  String get adminNoUrgentAlerts;

  /// No description provided for @adminLiveOrdersSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Every order channel with prep and settlement context.'**
  String get adminLiveOrdersSubtitle;

  /// No description provided for @adminCashCloseTitle.
  ///
  /// In en, this message translates to:
  /// **'Cash Close'**
  String get adminCashCloseTitle;

  /// No description provided for @adminCashCloseSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Verify sales, tips, and refunds.'**
  String get adminCashCloseSubtitle;

  /// No description provided for @adminReviewShiftClose.
  ///
  /// In en, this message translates to:
  /// **'Review Shift Close'**
  String get adminReviewShiftClose;

  /// No description provided for @adminStockoutImpactTitle.
  ///
  /// In en, this message translates to:
  /// **'Menu Stockout Impact'**
  String get adminStockoutImpactTitle;

  /// No description provided for @adminStockoutImpactSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Connect low ingredients to dishes before peak.'**
  String get adminStockoutImpactSubtitle;

  /// No description provided for @adminInventoryAction.
  ///
  /// In en, this message translates to:
  /// **'Inventory'**
  String get adminInventoryAction;

  /// No description provided for @adminNoCriticalStock.
  ///
  /// In en, this message translates to:
  /// **'No critical stock alerts.'**
  String get adminNoCriticalStock;

  /// No description provided for @adminDriversReturnsTitle.
  ///
  /// In en, this message translates to:
  /// **'Drivers & Returns'**
  String get adminDriversReturnsTitle;

  /// No description provided for @adminDriversReturnsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Food delivery and plated returns in one view.'**
  String get adminDriversReturnsSubtitle;

  /// No description provided for @adminNoActiveDelivery.
  ///
  /// In en, this message translates to:
  /// **'No active delivery tasks.'**
  String get adminNoActiveDelivery;

  /// No description provided for @adminOrderLabel.
  ///
  /// In en, this message translates to:
  /// **'Order #{id}'**
  String adminOrderLabel(String id);

  /// No description provided for @adminTrayReturnLabel.
  ///
  /// In en, this message translates to:
  /// **'Tray return #{id}'**
  String adminTrayReturnLabel(String id);

  /// No description provided for @adminReturnBadge.
  ///
  /// In en, this message translates to:
  /// **'Return'**
  String get adminReturnBadge;

  /// No description provided for @adminOpenDeliveryTasks.
  ///
  /// In en, this message translates to:
  /// **'Open Delivery Tasks'**
  String get adminOpenDeliveryTasks;

  /// No description provided for @adminTeamSnapshotSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Current team by station.'**
  String get adminTeamSnapshotSubtitle;

  /// No description provided for @adminQuickControlsTitle.
  ///
  /// In en, this message translates to:
  /// **'Quick Controls'**
  String get adminQuickControlsTitle;

  /// No description provided for @adminQuickControlsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Admin links without bottom navigation.'**
  String get adminQuickControlsSubtitle;

  /// No description provided for @platesOpsBadge.
  ///
  /// In en, this message translates to:
  /// **'Plate Asset & Deposit Ops'**
  String get platesOpsBadge;

  /// No description provided for @platesOpsHeadline.
  ///
  /// In en, this message translates to:
  /// **'Track trays, bowls, breakage, deposits, and returns from one board.'**
  String get platesOpsHeadline;

  /// No description provided for @platesInStock.
  ///
  /// In en, this message translates to:
  /// **'In stock'**
  String get platesInStock;

  /// No description provided for @platesCirculating.
  ///
  /// In en, this message translates to:
  /// **'Circulating'**
  String get platesCirculating;

  /// No description provided for @platesAssetValue.
  ///
  /// In en, this message translates to:
  /// **'Asset value'**
  String get platesAssetValue;

  /// No description provided for @platesCatalogSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Physical assets with SKU, value, stock, and circulation.'**
  String get platesCatalogSubtitle;

  /// No description provided for @platesReturnWindowValue.
  ///
  /// In en, this message translates to:
  /// **'48 hours'**
  String get platesReturnWindowValue;

  /// No description provided for @platesReturnReminders.
  ///
  /// In en, this message translates to:
  /// **'Return reminders'**
  String get platesReturnReminders;

  /// No description provided for @platesBreakageTrackSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Track breakage and missing items before settlement.'**
  String get platesBreakageTrackSubtitle;

  /// No description provided for @platesBreakageDefault.
  ///
  /// In en, this message translates to:
  /// **'Plate breakage'**
  String get platesBreakageDefault;

  /// No description provided for @platesBreakageDescription.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get platesBreakageDescription;

  /// No description provided for @platesBreakageLossJod.
  ///
  /// In en, this message translates to:
  /// **'Loss (JOD)'**
  String get platesBreakageLossJod;

  /// No description provided for @platesStockNowUnits.
  ///
  /// In en, this message translates to:
  /// **'Stock now {count} units'**
  String platesStockNowUnits(int count);

  /// No description provided for @supportTicketsTitle.
  ///
  /// In en, this message translates to:
  /// **'Support Tickets'**
  String get supportTicketsTitle;

  /// No description provided for @supportTicketsHero.
  ///
  /// In en, this message translates to:
  /// **'Customer Support Center'**
  String get supportTicketsHero;

  /// No description provided for @supportTicketNotFound.
  ///
  /// In en, this message translates to:
  /// **'Ticket not found'**
  String get supportTicketNotFound;

  /// No description provided for @supportTicketStatusLabel.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get supportTicketStatusLabel;

  /// No description provided for @supportTicketStatusUpdated.
  ///
  /// In en, this message translates to:
  /// **'Status updated'**
  String get supportTicketStatusUpdated;

  /// No description provided for @supportTicketConversation.
  ///
  /// In en, this message translates to:
  /// **'Conversation'**
  String get supportTicketConversation;

  /// No description provided for @supportTicketReplyArabic.
  ///
  /// In en, this message translates to:
  /// **'Arabic reply'**
  String get supportTicketReplyArabic;

  /// No description provided for @supportTicketReplyEnglish.
  ///
  /// In en, this message translates to:
  /// **'English reply'**
  String get supportTicketReplyEnglish;

  /// No description provided for @supportTicketSendReply.
  ///
  /// In en, this message translates to:
  /// **'Send reply'**
  String get supportTicketSendReply;

  /// No description provided for @supportTicketReplyFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not send reply'**
  String get supportTicketReplyFailed;

  /// No description provided for @supportTicketReplySent.
  ///
  /// In en, this message translates to:
  /// **'Reply sent'**
  String get supportTicketReplySent;

  /// No description provided for @supportTicketCustomerFeedback.
  ///
  /// In en, this message translates to:
  /// **'Customer feedback'**
  String get supportTicketCustomerFeedback;

  /// No description provided for @hrAttendancePayrollTitle.
  ///
  /// In en, this message translates to:
  /// **'Attendance & Payroll'**
  String get hrAttendancePayrollTitle;

  /// No description provided for @hrStaffAttendanceTooltip.
  ///
  /// In en, this message translates to:
  /// **'Staff attendance'**
  String get hrStaffAttendanceTooltip;

  /// No description provided for @hrPeriodDaily.
  ///
  /// In en, this message translates to:
  /// **'Daily'**
  String get hrPeriodDaily;

  /// No description provided for @hrPeriodMonthly.
  ///
  /// In en, this message translates to:
  /// **'Monthly'**
  String get hrPeriodMonthly;

  /// No description provided for @hrTotalPayable.
  ///
  /// In en, this message translates to:
  /// **'Total payable'**
  String get hrTotalPayable;

  /// No description provided for @hrExportCsv.
  ///
  /// In en, this message translates to:
  /// **'Export CSV'**
  String get hrExportCsv;

  /// No description provided for @hrExportCsvSuccess.
  ///
  /// In en, this message translates to:
  /// **'Payroll CSV exported.'**
  String get hrExportCsvSuccess;

  /// No description provided for @hrPayrollRulesTitle.
  ///
  /// In en, this message translates to:
  /// **'Payroll rules'**
  String get hrPayrollRulesTitle;

  /// No description provided for @hrPayrollDelayRule.
  ///
  /// In en, this message translates to:
  /// **'Delay > {minutes} min → fee {fee} {currency}'**
  String hrPayrollDelayRule(int minutes, String fee, String currency);

  /// No description provided for @hrDelayLabel.
  ///
  /// In en, this message translates to:
  /// **'Delay'**
  String get hrDelayLabel;

  /// No description provided for @hrOvertimeLabel.
  ///
  /// In en, this message translates to:
  /// **'Overtime'**
  String get hrOvertimeLabel;

  /// No description provided for @hrPercentLabel.
  ///
  /// In en, this message translates to:
  /// **'Percent'**
  String get hrPercentLabel;

  /// No description provided for @hrPayableLabel.
  ///
  /// In en, this message translates to:
  /// **'Payable'**
  String get hrPayableLabel;

  /// No description provided for @hrMinutesShort.
  ///
  /// In en, this message translates to:
  /// **'min'**
  String get hrMinutesShort;

  /// No description provided for @hrHoursShort.
  ///
  /// In en, this message translates to:
  /// **'h'**
  String get hrHoursShort;

  /// No description provided for @hrOutcomeFullPay.
  ///
  /// In en, this message translates to:
  /// **'Full pay'**
  String get hrOutcomeFullPay;

  /// No description provided for @hrOutcomeDelayFee.
  ///
  /// In en, this message translates to:
  /// **'Delay fee'**
  String get hrOutcomeDelayFee;

  /// No description provided for @hrOutcomeDelayFeeDouble.
  ///
  /// In en, this message translates to:
  /// **'Fee ×2'**
  String get hrOutcomeDelayFeeDouble;

  /// No description provided for @hrOutcomeAbsence.
  ///
  /// In en, this message translates to:
  /// **'Absence'**
  String get hrOutcomeAbsence;

  /// No description provided for @hrOutcomeOvertime.
  ///
  /// In en, this message translates to:
  /// **'Overtime'**
  String get hrOutcomeOvertime;

  /// No description provided for @productEditorAddMenuItem.
  ///
  /// In en, this message translates to:
  /// **'Add menu item'**
  String get productEditorAddMenuItem;

  /// No description provided for @productEditorSaveFirst.
  ///
  /// In en, this message translates to:
  /// **'Save the item first'**
  String get productEditorSaveFirst;

  /// No description provided for @productEditorPreview.
  ///
  /// In en, this message translates to:
  /// **'Preview'**
  String get productEditorPreview;

  /// No description provided for @productEditorBadge.
  ///
  /// In en, this message translates to:
  /// **'Menu Item Editor'**
  String get productEditorBadge;

  /// No description provided for @productEditorBadgeDesc.
  ///
  /// In en, this message translates to:
  /// **'Edit pricing, variants, modifiers, media, and station routing.'**
  String get productEditorBadgeDesc;

  /// No description provided for @productEditorNameSection.
  ///
  /// In en, this message translates to:
  /// **'Name & Description'**
  String get productEditorNameSection;

  /// No description provided for @productEditorNameSectionDesc.
  ///
  /// In en, this message translates to:
  /// **'Bilingual copy shown on customer menu cards.'**
  String get productEditorNameSectionDesc;

  /// No description provided for @productEditorArabicName.
  ///
  /// In en, this message translates to:
  /// **'Arabic name'**
  String get productEditorArabicName;

  /// No description provided for @productEditorEnglishName.
  ///
  /// In en, this message translates to:
  /// **'English name'**
  String get productEditorEnglishName;

  /// No description provided for @productEditorArabicDesc.
  ///
  /// In en, this message translates to:
  /// **'Arabic description'**
  String get productEditorArabicDesc;

  /// No description provided for @productEditorEnglishDesc.
  ///
  /// In en, this message translates to:
  /// **'English description'**
  String get productEditorEnglishDesc;

  /// No description provided for @productEditorPricingSection.
  ///
  /// In en, this message translates to:
  /// **'Pricing & Variants'**
  String get productEditorPricingSection;

  /// No description provided for @productEditorPricingSectionDesc.
  ///
  /// In en, this message translates to:
  /// **'Base price and portion/variant deltas.'**
  String get productEditorPricingSectionDesc;

  /// No description provided for @productEditorBasePrice.
  ///
  /// In en, this message translates to:
  /// **'Base price'**
  String get productEditorBasePrice;

  /// No description provided for @productEditorAddVariant.
  ///
  /// In en, this message translates to:
  /// **'Add variant'**
  String get productEditorAddVariant;

  /// No description provided for @productEditorAddPortionTitle.
  ///
  /// In en, this message translates to:
  /// **'Add portion size'**
  String get productEditorAddPortionTitle;

  /// No description provided for @productEditorPortionKeyLabel.
  ///
  /// In en, this message translates to:
  /// **'Key (e.g. super)'**
  String get productEditorPortionKeyLabel;

  /// No description provided for @productEditorPortionPriceDelta.
  ///
  /// In en, this message translates to:
  /// **'Price delta (JOD)'**
  String get productEditorPortionPriceDelta;

  /// No description provided for @productEditorEnterPortionKey.
  ///
  /// In en, this message translates to:
  /// **'Enter a portion key'**
  String get productEditorEnterPortionKey;

  /// No description provided for @productEditorPortionAdded.
  ///
  /// In en, this message translates to:
  /// **'Portion added'**
  String get productEditorPortionAdded;

  /// No description provided for @productEditorPortionKeyExists.
  ///
  /// In en, this message translates to:
  /// **'Key already exists'**
  String get productEditorPortionKeyExists;

  /// No description provided for @productEditorModifiersSection.
  ///
  /// In en, this message translates to:
  /// **'Modifiers'**
  String get productEditorModifiersSection;

  /// No description provided for @productEditorModifiersSectionDesc.
  ///
  /// In en, this message translates to:
  /// **'Attach catalog add-ons to this item.'**
  String get productEditorModifiersSectionDesc;

  /// No description provided for @productEditorNoAddons.
  ///
  /// In en, this message translates to:
  /// **'No catalog addons yet.'**
  String get productEditorNoAddons;

  /// No description provided for @productEditorMediaSection.
  ///
  /// In en, this message translates to:
  /// **'Media & Display'**
  String get productEditorMediaSection;

  /// No description provided for @productEditorMediaSectionDesc.
  ///
  /// In en, this message translates to:
  /// **'Images and menu presentation.'**
  String get productEditorMediaSectionDesc;

  /// No description provided for @productEditorMediaFallback.
  ///
  /// In en, this message translates to:
  /// **'No image yet — add 1 to 5 photos.'**
  String get productEditorMediaFallback;

  /// No description provided for @productEditorPrepStationSection.
  ///
  /// In en, this message translates to:
  /// **'Prep Station'**
  String get productEditorPrepStationSection;

  /// No description provided for @productEditorPrepStationSectionDesc.
  ///
  /// In en, this message translates to:
  /// **'Route tickets to the correct kitchen lane.'**
  String get productEditorPrepStationSectionDesc;

  /// No description provided for @productEditorAvailabilitySection.
  ///
  /// In en, this message translates to:
  /// **'Availability & Channels'**
  String get productEditorAvailabilitySection;

  /// No description provided for @productEditorAvailabilitySectionDesc.
  ///
  /// In en, this message translates to:
  /// **'Control where this item is visible.'**
  String get productEditorAvailabilitySectionDesc;

  /// No description provided for @productEditorAvailableNow.
  ///
  /// In en, this message translates to:
  /// **'Available now'**
  String get productEditorAvailableNow;

  /// No description provided for @productEditorFeatured.
  ///
  /// In en, this message translates to:
  /// **'Featured in menu'**
  String get productEditorFeatured;

  /// No description provided for @productEditorSavePublishSection.
  ///
  /// In en, this message translates to:
  /// **'Save & Publish'**
  String get productEditorSavePublishSection;

  /// No description provided for @productEditorSavePublishCreateDesc.
  ///
  /// In en, this message translates to:
  /// **'Create then publish to the menu.'**
  String get productEditorSavePublishCreateDesc;

  /// No description provided for @productEditorSavePublishEditDesc.
  ///
  /// In en, this message translates to:
  /// **'Persists edits to catalog and custom menu items.'**
  String get productEditorSavePublishEditDesc;

  /// No description provided for @productEditorAddMinImages.
  ///
  /// In en, this message translates to:
  /// **'Add at least 1 image (up to 5)'**
  String get productEditorAddMinImages;

  /// No description provided for @productEditorCheckRequiredFields.
  ///
  /// In en, this message translates to:
  /// **'Check required fields'**
  String get productEditorCheckRequiredFields;

  /// No description provided for @productEditorMenuItemSaved.
  ///
  /// In en, this message translates to:
  /// **'Menu item saved'**
  String get productEditorMenuItemSaved;

  /// No description provided for @productEditorPublishToMenu.
  ///
  /// In en, this message translates to:
  /// **'Publish to menu'**
  String get productEditorPublishToMenu;

  /// No description provided for @productEditorPublishTitle.
  ///
  /// In en, this message translates to:
  /// **'Publish menu item'**
  String get productEditorPublishTitle;

  /// No description provided for @productEditorPublishMessage.
  ///
  /// In en, this message translates to:
  /// **'The item will appear in selected sales channels.'**
  String get productEditorPublishMessage;

  /// No description provided for @productEditorAddImageBeforePublish.
  ///
  /// In en, this message translates to:
  /// **'Add at least 1 image before publishing'**
  String get productEditorAddImageBeforePublish;

  /// No description provided for @productEditorCheckNamePrice.
  ///
  /// In en, this message translates to:
  /// **'Check name and price'**
  String get productEditorCheckNamePrice;

  /// No description provided for @productEditorPublished.
  ///
  /// In en, this message translates to:
  /// **'Published'**
  String get productEditorPublished;

  /// No description provided for @productEditorBackToMenu.
  ///
  /// In en, this message translates to:
  /// **'Back to menu management'**
  String get productEditorBackToMenu;

  /// No description provided for @productEditorPrepStationShawarma.
  ///
  /// In en, this message translates to:
  /// **'Shawarma station'**
  String get productEditorPrepStationShawarma;

  /// No description provided for @productEditorPrepStationFryer.
  ///
  /// In en, this message translates to:
  /// **'Fryer station'**
  String get productEditorPrepStationFryer;

  /// No description provided for @productEditorPrepStationColdPrep.
  ///
  /// In en, this message translates to:
  /// **'Cold prep'**
  String get productEditorPrepStationColdPrep;

  /// No description provided for @productEditorPrepStationDrinks.
  ///
  /// In en, this message translates to:
  /// **'Drinks'**
  String get productEditorPrepStationDrinks;

  /// No description provided for @auditLogTrueTrailBadge.
  ///
  /// In en, this message translates to:
  /// **'True Audit Trail'**
  String get auditLogTrueTrailBadge;

  /// No description provided for @auditLogHeroHeadline.
  ///
  /// In en, this message translates to:
  /// **'Track who changed what, when, and from which operational area.'**
  String get auditLogHeroHeadline;

  /// No description provided for @auditLogTodayEvents.
  ///
  /// In en, this message translates to:
  /// **'Today events'**
  String get auditLogTodayEvents;

  /// No description provided for @auditLogSensitiveChanges.
  ///
  /// In en, this message translates to:
  /// **'Sensitive changes'**
  String get auditLogSensitiveChanges;

  /// No description provided for @auditLogNeedsReview.
  ///
  /// In en, this message translates to:
  /// **'Needs review'**
  String get auditLogNeedsReview;

  /// No description provided for @auditLogRequestConfirmMessage.
  ///
  /// In en, this message translates to:
  /// **'A detailed audit request will be logged for review.'**
  String get auditLogRequestConfirmMessage;

  /// No description provided for @auditLogExportLog.
  ///
  /// In en, this message translates to:
  /// **'Export log'**
  String get auditLogExportLog;

  /// No description provided for @auditLogExportDownloaded.
  ///
  /// In en, this message translates to:
  /// **'Export file downloaded'**
  String get auditLogExportDownloaded;

  /// No description provided for @auditLogTimelineSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Timeline of administrative and operational events.'**
  String get auditLogTimelineSubtitle;

  /// No description provided for @auditLogNoEventsInScope.
  ///
  /// In en, this message translates to:
  /// **'No events in this scope.'**
  String get auditLogNoEventsInScope;

  /// No description provided for @auditLogDetailedAuditRequested.
  ///
  /// In en, this message translates to:
  /// **'Detailed audit requested'**
  String get auditLogDetailedAuditRequested;

  /// No description provided for @auditLogAuditExported.
  ///
  /// In en, this message translates to:
  /// **'Audit log exported'**
  String get auditLogAuditExported;

  /// No description provided for @auditLogShiftCloseApproved.
  ///
  /// In en, this message translates to:
  /// **'Shift close approved'**
  String get auditLogShiftCloseApproved;

  /// No description provided for @auditLogUserActivated.
  ///
  /// In en, this message translates to:
  /// **'User activated'**
  String get auditLogUserActivated;

  /// No description provided for @auditLogUserDeactivated.
  ///
  /// In en, this message translates to:
  /// **'User deactivated'**
  String get auditLogUserDeactivated;

  /// No description provided for @auditLogDepositSettingsSaved.
  ///
  /// In en, this message translates to:
  /// **'Deposit settings saved'**
  String get auditLogDepositSettingsSaved;

  /// No description provided for @auditLogTrayBreakageArea.
  ///
  /// In en, this message translates to:
  /// **'Tray breakage'**
  String get auditLogTrayBreakageArea;

  /// No description provided for @auditLogInventoryArea.
  ///
  /// In en, this message translates to:
  /// **'Inventory'**
  String get auditLogInventoryArea;

  /// No description provided for @auditLogUserRoleChanged.
  ///
  /// In en, this message translates to:
  /// **'User role changed'**
  String get auditLogUserRoleChanged;

  /// No description provided for @auditLogCashierShiftClosed.
  ///
  /// In en, this message translates to:
  /// **'Cashier shift closed'**
  String get auditLogCashierShiftClosed;

  /// No description provided for @auditLogTrayDepositEdited.
  ///
  /// In en, this message translates to:
  /// **'Tray deposit policy edited'**
  String get auditLogTrayDepositEdited;

  /// No description provided for @auditLogFiltersTitle.
  ///
  /// In en, this message translates to:
  /// **'Audit Filters'**
  String get auditLogFiltersTitle;

  /// No description provided for @auditLogFiltersSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Scope the log quickly.'**
  String get auditLogFiltersSubtitle;

  /// No description provided for @auditLogGovernanceTitle.
  ///
  /// In en, this message translates to:
  /// **'Governance Snapshot'**
  String get auditLogGovernanceTitle;

  /// No description provided for @auditLogGovernanceSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Security and permission posture for this shift.'**
  String get auditLogGovernanceSubtitle;

  /// No description provided for @auditLogFailedLogins.
  ///
  /// In en, this message translates to:
  /// **'Failed login attempts'**
  String get auditLogFailedLogins;

  /// No description provided for @auditLogPermissionChanges.
  ///
  /// In en, this message translates to:
  /// **'Permission changes'**
  String get auditLogPermissionChanges;

  /// No description provided for @auditLogFinancialEdits.
  ///
  /// In en, this message translates to:
  /// **'Financial edits'**
  String get auditLogFinancialEdits;

  /// No description provided for @auditLogInventorySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Recent stock adjustments from inventory.'**
  String get auditLogInventorySubtitle;

  /// No description provided for @auditLogNoStockChanges.
  ///
  /// In en, this message translates to:
  /// **'No stock changes yet.'**
  String get auditLogNoStockChanges;

  /// No description provided for @auditLogActorOwner.
  ///
  /// In en, this message translates to:
  /// **'Owner'**
  String get auditLogActorOwner;

  /// No description provided for @auditLogActorOperator.
  ///
  /// In en, this message translates to:
  /// **'Operator'**
  String get auditLogActorOperator;

  /// No description provided for @auditLogActorFinance.
  ///
  /// In en, this message translates to:
  /// **'Finance'**
  String get auditLogActorFinance;

  /// No description provided for @auditLogActorLogistics.
  ///
  /// In en, this message translates to:
  /// **'Logistics'**
  String get auditLogActorLogistics;

  /// No description provided for @auditLogActorSystem.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get auditLogActorSystem;

  /// No description provided for @auditLogAreaGovernance.
  ///
  /// In en, this message translates to:
  /// **'Governance'**
  String get auditLogAreaGovernance;

  /// No description provided for @auditLogAreaReports.
  ///
  /// In en, this message translates to:
  /// **'Reports'**
  String get auditLogAreaReports;

  /// No description provided for @auditLogAreaCashClose.
  ///
  /// In en, this message translates to:
  /// **'Cash close'**
  String get auditLogAreaCashClose;

  /// No description provided for @auditLogAreaRolesPrivacy.
  ///
  /// In en, this message translates to:
  /// **'Roles & Privacy'**
  String get auditLogAreaRolesPrivacy;

  /// No description provided for @auditLogAreaFinance.
  ///
  /// In en, this message translates to:
  /// **'Finance'**
  String get auditLogAreaFinance;

  /// No description provided for @auditLogAreaAdminLog.
  ///
  /// In en, this message translates to:
  /// **'Admin log'**
  String get auditLogAreaAdminLog;

  /// No description provided for @auditLogToday.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get auditLogToday;

  /// No description provided for @auditLogYesterday1820.
  ///
  /// In en, this message translates to:
  /// **'Yesterday 18:20'**
  String get auditLogYesterday1820;

  /// No description provided for @auditLogToday0942.
  ///
  /// In en, this message translates to:
  /// **'Today 09:42'**
  String get auditLogToday0942;

  /// No description provided for @auditLogToday0858.
  ///
  /// In en, this message translates to:
  /// **'Today 08:58'**
  String get auditLogToday0858;

  /// No description provided for @auditLogActorOperatorAhmad.
  ///
  /// In en, this message translates to:
  /// **'Operator Ahmad'**
  String get auditLogActorOperatorAhmad;

  /// No description provided for @auditLogActorCashierLayla.
  ///
  /// In en, this message translates to:
  /// **'Cashier Layla'**
  String get auditLogActorCashierLayla;

  /// No description provided for @auditLogAuditRequestDetail.
  ///
  /// In en, this message translates to:
  /// **'Request logged for review before shift close.'**
  String get auditLogAuditRequestDetail;

  /// No description provided for @auditLogAuditExportDetail.
  ///
  /// In en, this message translates to:
  /// **'CSV audit file downloaded.'**
  String get auditLogAuditExportDetail;

  /// No description provided for @auditLogShiftCloseDetail.
  ///
  /// In en, this message translates to:
  /// **'Revenue, tips, and refunds approved.'**
  String get auditLogShiftCloseDetail;

  /// No description provided for @auditLogDepositSavedDetail.
  ///
  /// In en, this message translates to:
  /// **'Deposit {amount} JOD · {hours}h window'**
  String auditLogDepositSavedDetail(String amount, String hours);

  /// No description provided for @auditLogRoleChangeDetail.
  ///
  /// In en, this message translates to:
  /// **'Sara moved from Kitchen to Station Supervisor.'**
  String get auditLogRoleChangeDetail;

  /// No description provided for @auditLogCashierCloseDetail.
  ///
  /// In en, this message translates to:
  /// **'Revenue, tips, and refunds were approved.'**
  String get auditLogCashierCloseDetail;

  /// No description provided for @auditLogTrayDepositEditDetail.
  ///
  /// In en, this message translates to:
  /// **'Global deposit and return window updated.'**
  String get auditLogTrayDepositEditDetail;

  /// No description provided for @auditLogSystemEntryDetail.
  ///
  /// In en, this message translates to:
  /// **'Automated admin event recorded.'**
  String get auditLogSystemEntryDetail;

  /// No description provided for @orderDetailAdminSendUpdate.
  ///
  /// In en, this message translates to:
  /// **'Send update'**
  String get orderDetailAdminSendUpdate;

  /// No description provided for @orderDetailAdminOrderTotal.
  ///
  /// In en, this message translates to:
  /// **'Order total'**
  String get orderDetailAdminOrderTotal;

  /// No description provided for @orderDetailAdminDeposit.
  ///
  /// In en, this message translates to:
  /// **'Deposit'**
  String get orderDetailAdminDeposit;

  /// No description provided for @orderDetailAdminOnRoute.
  ///
  /// In en, this message translates to:
  /// **'On route'**
  String get orderDetailAdminOnRoute;

  /// No description provided for @orderDetailAdminOnRouteValue.
  ///
  /// In en, this message translates to:
  /// **'28 min'**
  String get orderDetailAdminOnRouteValue;

  /// No description provided for @orderDetailAdminSendGuestUpdateTitle.
  ///
  /// In en, this message translates to:
  /// **'Send guest update'**
  String get orderDetailAdminSendGuestUpdateTitle;

  /// No description provided for @orderDetailAdminUpdatePreparing.
  ///
  /// In en, this message translates to:
  /// **'Order is preparing'**
  String get orderDetailAdminUpdatePreparing;

  /// No description provided for @orderDetailAdminUpdateReady.
  ///
  /// In en, this message translates to:
  /// **'Order is ready'**
  String get orderDetailAdminUpdateReady;

  /// No description provided for @orderDetailAdminUpdateOnWay.
  ///
  /// In en, this message translates to:
  /// **'Driver is on the way'**
  String get orderDetailAdminUpdateOnWay;

  /// No description provided for @orderDetailAdminUpdateDelay.
  ///
  /// In en, this message translates to:
  /// **'Delay — we apologize'**
  String get orderDetailAdminUpdateDelay;

  /// No description provided for @orderDetailAdminUpdateSent.
  ///
  /// In en, this message translates to:
  /// **'Update sent'**
  String get orderDetailAdminUpdateSent;

  /// No description provided for @orderDetailAdminDelayNoticeSent.
  ///
  /// In en, this message translates to:
  /// **'Delay notice sent'**
  String get orderDetailAdminDelayNoticeSent;

  /// No description provided for @orderDetailAdminGuestPaymentTitle.
  ///
  /// In en, this message translates to:
  /// **'Guest & Payment'**
  String get orderDetailAdminGuestPaymentTitle;

  /// No description provided for @orderDetailAdminGuestPaymentSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Key context for closing and contact.'**
  String get orderDetailAdminGuestPaymentSubtitle;

  /// No description provided for @orderDetailAdminGuestLabel.
  ///
  /// In en, this message translates to:
  /// **'Guest'**
  String get orderDetailAdminGuestLabel;

  /// No description provided for @orderDetailAdminChannelLabel.
  ///
  /// In en, this message translates to:
  /// **'Channel'**
  String get orderDetailAdminChannelLabel;

  /// No description provided for @orderDetailAdminFoodTotal.
  ///
  /// In en, this message translates to:
  /// **'Food total'**
  String get orderDetailAdminFoodTotal;

  /// No description provided for @orderDetailAdminTrayDeposit.
  ///
  /// In en, this message translates to:
  /// **'Tray deposit'**
  String get orderDetailAdminTrayDeposit;

  /// No description provided for @orderDetailAdminKitchenTicketTitle.
  ///
  /// In en, this message translates to:
  /// **'Kitchen Ticket'**
  String get orderDetailAdminKitchenTicketTitle;

  /// No description provided for @orderDetailAdminKitchenTicketSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Items and station summary.'**
  String get orderDetailAdminKitchenTicketSubtitle;

  /// No description provided for @orderDetailAdminPrepStationNote.
  ///
  /// In en, this message translates to:
  /// **'Prep station'**
  String get orderDetailAdminPrepStationNote;

  /// No description provided for @orderDetailAdminOpenKitchen.
  ///
  /// In en, this message translates to:
  /// **'Open kitchen pass'**
  String get orderDetailAdminOpenKitchen;

  /// No description provided for @orderDetailAdminActionsTitle.
  ///
  /// In en, this message translates to:
  /// **'Admin Actions'**
  String get orderDetailAdminActionsTitle;

  /// No description provided for @orderDetailAdminContactGuest.
  ///
  /// In en, this message translates to:
  /// **'Contact guest'**
  String get orderDetailAdminContactGuest;

  /// No description provided for @orderDetailAdminChangeStatus.
  ///
  /// In en, this message translates to:
  /// **'Change order status'**
  String get orderDetailAdminChangeStatus;

  /// No description provided for @orderDetailAdminChangeStatusTitle.
  ///
  /// In en, this message translates to:
  /// **'Change status'**
  String get orderDetailAdminChangeStatusTitle;

  /// No description provided for @orderDetailAdminBackToBoard.
  ///
  /// In en, this message translates to:
  /// **'Back to order board'**
  String get orderDetailAdminBackToBoard;

  /// No description provided for @orderDetailAdminPosReceived.
  ///
  /// In en, this message translates to:
  /// **'POS received'**
  String get orderDetailAdminPosReceived;

  /// No description provided for @orderDetailAdminKitchenPrep.
  ///
  /// In en, this message translates to:
  /// **'Kitchen prep'**
  String get orderDetailAdminKitchenPrep;

  /// No description provided for @orderDetailAdminCloseSettle.
  ///
  /// In en, this message translates to:
  /// **'Close & settle'**
  String get orderDetailAdminCloseSettle;

  /// No description provided for @orderDetailAdminTimelineNext.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get orderDetailAdminTimelineNext;

  /// No description provided for @orderDetailAdminTimelineTitle.
  ///
  /// In en, this message translates to:
  /// **'Order Timeline'**
  String get orderDetailAdminTimelineTitle;

  /// No description provided for @orderDetailAdminTimelineSubtitle.
  ///
  /// In en, this message translates to:
  /// **'From entry to settlement.'**
  String get orderDetailAdminTimelineSubtitle;

  /// No description provided for @orderDetailAdminRisksTitle.
  ///
  /// In en, this message translates to:
  /// **'Risks & Notes'**
  String get orderDetailAdminRisksTitle;

  /// No description provided for @orderDetailAdminDeliveryTiming.
  ///
  /// In en, this message translates to:
  /// **'Delivery timing'**
  String get orderDetailAdminDeliveryTiming;

  /// No description provided for @orderDetailAdminNoDeposit.
  ///
  /// In en, this message translates to:
  /// **'No deposit'**
  String get orderDetailAdminNoDeposit;

  /// No description provided for @orderDetailAdminOperationalNote.
  ///
  /// In en, this message translates to:
  /// **'Operational note'**
  String get orderDetailAdminOperationalNote;

  /// No description provided for @productEditorHeroHeadline.
  ///
  /// In en, this message translates to:
  /// **'Edit bilingual naming, pricing, variants, modifiers, prep routing, and availability.'**
  String get productEditorHeroHeadline;

  /// No description provided for @productEditorIdentitySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Customer-facing copy shown in the menu.'**
  String get productEditorIdentitySubtitle;

  /// No description provided for @productEditorMediaGalleryHint.
  ///
  /// In en, this message translates to:
  /// **'1–5 images — warm food media for each angle.'**
  String get productEditorMediaGalleryHint;

  /// No description provided for @productEditorMediaUsage.
  ///
  /// In en, this message translates to:
  /// **'Product gallery • menu card • POS tile'**
  String get productEditorMediaUsage;

  /// No description provided for @productEditorStationSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Controls where the kitchen ticket appears.'**
  String get productEditorStationSubtitle;

  /// No description provided for @orderDetailAdminContactPhone.
  ///
  /// In en, this message translates to:
  /// **'+962 7 9000 0000'**
  String get orderDetailAdminContactPhone;

  /// No description provided for @commonOpen.
  ///
  /// In en, this message translates to:
  /// **'Open'**
  String get commonOpen;

  /// No description provided for @settingsOpsBadge.
  ///
  /// In en, this message translates to:
  /// **'Operations Settings'**
  String get settingsOpsBadge;

  /// No description provided for @settingsOpsHeroHeadline.
  ///
  /// In en, this message translates to:
  /// **'Control hours, stations, order rules, delivery zones, taxes, receipts, and alerts.'**
  String get settingsOpsHeroHeadline;

  /// No description provided for @settingsAppAdminHeroHeadline.
  ///
  /// In en, this message translates to:
  /// **'System configuration, integrations, and platform permissions.'**
  String get settingsAppAdminHeroHeadline;

  /// No description provided for @settingsHeroNineSections.
  ///
  /// In en, this message translates to:
  /// **'9 sections'**
  String get settingsHeroNineSections;

  /// No description provided for @settingsHeroUiOnly.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsHeroUiOnly;

  /// No description provided for @settingsHeroDrawerNav.
  ///
  /// In en, this message translates to:
  /// **'Drawer navigation'**
  String get settingsHeroDrawerNav;

  /// No description provided for @settingsBusinessHoursTitle.
  ///
  /// In en, this message translates to:
  /// **'Business Hours & Order Rules'**
  String get settingsBusinessHoursTitle;

  /// No description provided for @settingsBusinessHoursSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Set service state, prep rules, and pre-order behavior.'**
  String get settingsBusinessHoursSubtitle;

  /// No description provided for @settingsAcceptingOrders.
  ///
  /// In en, this message translates to:
  /// **'Accepting orders now'**
  String get settingsAcceptingOrders;

  /// No description provided for @settingsDeliveryEnabled.
  ///
  /// In en, this message translates to:
  /// **'Delivery enabled now'**
  String get settingsDeliveryEnabled;

  /// No description provided for @settingsTodayHours.
  ///
  /// In en, this message translates to:
  /// **'Today hours'**
  String get settingsTodayHours;

  /// No description provided for @settingsTodayHoursValue.
  ///
  /// In en, this message translates to:
  /// **'8:00 AM - 12:00 AM'**
  String get settingsTodayHoursValue;

  /// No description provided for @settingsPreOrdersLabel.
  ///
  /// In en, this message translates to:
  /// **'Pre-orders'**
  String get settingsPreOrdersLabel;

  /// No description provided for @settingsPreOrdersDetail.
  ///
  /// In en, this message translates to:
  /// **'Up to 3 days ahead'**
  String get settingsPreOrdersDetail;

  /// No description provided for @settingsStationsTitle.
  ///
  /// In en, this message translates to:
  /// **'Stations & Operating Rules'**
  String get settingsStationsTitle;

  /// No description provided for @settingsStationsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Route menu items to kitchen stations and prep rules.'**
  String get settingsStationsSubtitle;

  /// No description provided for @settingsShawarmaStation.
  ///
  /// In en, this message translates to:
  /// **'Shawarma station'**
  String get settingsShawarmaStation;

  /// No description provided for @settingsShawarmaPrepDetail.
  ///
  /// In en, this message translates to:
  /// **'8 min average prep'**
  String get settingsShawarmaPrepDetail;

  /// No description provided for @settingsFryerStation.
  ///
  /// In en, this message translates to:
  /// **'Fryer station'**
  String get settingsFryerStation;

  /// No description provided for @settingsFryerLoadDetail.
  ///
  /// In en, this message translates to:
  /// **'Load limit 12 tickets'**
  String get settingsFryerLoadDetail;

  /// No description provided for @settingsLateTicketThreshold.
  ///
  /// In en, this message translates to:
  /// **'Late-ticket threshold'**
  String get settingsLateTicketThreshold;

  /// No description provided for @settingsLateTicketDetail.
  ///
  /// In en, this message translates to:
  /// **'Escalate after 15 minutes'**
  String get settingsLateTicketDetail;

  /// No description provided for @settingsSystemPlatformTitle.
  ///
  /// In en, this message translates to:
  /// **'System & platform'**
  String get settingsSystemPlatformTitle;

  /// No description provided for @settingsSystemPlatformSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Integrations, users, roles, and audit.'**
  String get settingsSystemPlatformSubtitle;

  /// No description provided for @settingsIntegrationsDetail.
  ///
  /// In en, this message translates to:
  /// **'Supabase, SMS, payments'**
  String get settingsIntegrationsDetail;

  /// No description provided for @settingsAuditTrailDetail.
  ///
  /// In en, this message translates to:
  /// **'Full platform audit trail'**
  String get settingsAuditTrailDetail;

  /// No description provided for @settingsStaffTitle.
  ///
  /// In en, this message translates to:
  /// **'Staff & attendance'**
  String get settingsStaffTitle;

  /// No description provided for @settingsStaffSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Shift roster, attendance, and approvals.'**
  String get settingsStaffSubtitle;

  /// No description provided for @settingsStaffHoursDetail.
  ///
  /// In en, this message translates to:
  /// **'Shifts, attendance, and hours'**
  String get settingsStaffHoursDetail;

  /// No description provided for @settingsAttendanceHrLabel.
  ///
  /// In en, this message translates to:
  /// **'Attendance & HR'**
  String get settingsAttendanceHrLabel;

  /// No description provided for @settingsAttendanceHrDetail.
  ///
  /// In en, this message translates to:
  /// **'Attendance log and approvals'**
  String get settingsAttendanceHrDetail;

  /// No description provided for @settingsFeesTaxesTitle.
  ///
  /// In en, this message translates to:
  /// **'Fees & Taxes'**
  String get settingsFeesTaxesTitle;

  /// No description provided for @settingsFeesTaxesSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Delivery fees, tax display, and receipt layout.'**
  String get settingsFeesTaxesSubtitle;

  /// No description provided for @settingsDeliveryFeesLabel.
  ///
  /// In en, this message translates to:
  /// **'Delivery fees'**
  String get settingsDeliveryFeesLabel;

  /// No description provided for @settingsDeliveryFeesDetail.
  ///
  /// In en, this message translates to:
  /// **'Zone-based delivery charge rules'**
  String get settingsDeliveryFeesDetail;

  /// No description provided for @settingsReceiptTemplateLabel.
  ///
  /// In en, this message translates to:
  /// **'Receipt template'**
  String get settingsReceiptTemplateLabel;

  /// No description provided for @settingsReceiptTemplateDetail.
  ///
  /// In en, this message translates to:
  /// **'Logo, footer, and tax line layout'**
  String get settingsReceiptTemplateDetail;

  /// No description provided for @settingsNotificationsTitle.
  ///
  /// In en, this message translates to:
  /// **'Notifications & Alerts'**
  String get settingsNotificationsTitle;

  /// No description provided for @settingsNotificationsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Kitchen, inventory, and tray-return alerts.'**
  String get settingsNotificationsSubtitle;

  /// No description provided for @settingsKitchenAlertsDetail.
  ///
  /// In en, this message translates to:
  /// **'Prep delay and station overload'**
  String get settingsKitchenAlertsDetail;

  /// No description provided for @settingsLowStockAlert.
  ///
  /// In en, this message translates to:
  /// **'Low stock alert'**
  String get settingsLowStockAlert;

  /// No description provided for @settingsLowStockDetail.
  ///
  /// In en, this message translates to:
  /// **'Below 15% threshold'**
  String get settingsLowStockDetail;

  /// No description provided for @settingsTrayReturnReminders.
  ///
  /// In en, this message translates to:
  /// **'Tray return reminders'**
  String get settingsTrayReturnReminders;

  /// No description provided for @settingsTrayReturnDetail.
  ///
  /// In en, this message translates to:
  /// **'60 minutes after delivery'**
  String get settingsTrayReturnDetail;

  /// No description provided for @settingsAppAdminShortcuts.
  ///
  /// In en, this message translates to:
  /// **'App admin shortcuts'**
  String get settingsAppAdminShortcuts;

  /// No description provided for @settingsOpsShortcuts.
  ///
  /// In en, this message translates to:
  /// **'Operations shortcuts'**
  String get settingsOpsShortcuts;

  /// No description provided for @settingsShortcutsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Jump to high-traffic admin screens.'**
  String get settingsShortcutsSubtitle;

  /// No description provided for @settingsAttendancePayrollShortcut.
  ///
  /// In en, this message translates to:
  /// **'Attendance & payroll'**
  String get settingsAttendancePayrollShortcut;

  /// No description provided for @settingsPreOrdersShortcut.
  ///
  /// In en, this message translates to:
  /// **'Pre-orders'**
  String get settingsPreOrdersShortcut;

  /// No description provided for @ordersMgmtFilterTitle.
  ///
  /// In en, this message translates to:
  /// **'Filter order board'**
  String get ordersMgmtFilterTitle;

  /// No description provided for @ordersMgmtFilterMessage.
  ///
  /// In en, this message translates to:
  /// **'Filter by channel, station, or delay status.'**
  String get ordersMgmtFilterMessage;

  /// No description provided for @ordersMgmtFilterTooltip.
  ///
  /// In en, this message translates to:
  /// **'Filter'**
  String get ordersMgmtFilterTooltip;

  /// No description provided for @ordersMgmtLaneNeedsDecision.
  ///
  /// In en, this message translates to:
  /// **'Needs Decision'**
  String get ordersMgmtLaneNeedsDecision;

  /// No description provided for @ordersMgmtLaneNeedsDecisionSub.
  ///
  /// In en, this message translates to:
  /// **'Late, missing, or escalated'**
  String get ordersMgmtLaneNeedsDecisionSub;

  /// No description provided for @ordersMgmtLanePreparing.
  ///
  /// In en, this message translates to:
  /// **'Preparing'**
  String get ordersMgmtLanePreparing;

  /// No description provided for @ordersMgmtLanePreparingSub.
  ///
  /// In en, this message translates to:
  /// **'Kitchen in progress'**
  String get ordersMgmtLanePreparingSub;

  /// No description provided for @ordersMgmtLaneReadyRoute.
  ///
  /// In en, this message translates to:
  /// **'Ready / On Route'**
  String get ordersMgmtLaneReadyRoute;

  /// No description provided for @ordersMgmtLaneReadyRouteSub.
  ///
  /// In en, this message translates to:
  /// **'Ready to handoff or on the road'**
  String get ordersMgmtLaneReadyRouteSub;

  /// No description provided for @ordersMgmtHeroBadge.
  ///
  /// In en, this message translates to:
  /// **'Live Order Board'**
  String get ordersMgmtHeroBadge;

  /// No description provided for @ordersMgmtOpenOrders.
  ///
  /// In en, this message translates to:
  /// **'Open orders'**
  String get ordersMgmtOpenOrders;

  /// No description provided for @ordersMgmtActiveValue.
  ///
  /// In en, this message translates to:
  /// **'Active value'**
  String get ordersMgmtActiveValue;

  /// No description provided for @ordersMgmtPlatedOrders.
  ///
  /// In en, this message translates to:
  /// **'Plated orders'**
  String get ordersMgmtPlatedOrders;

  /// No description provided for @ordersMgmtEmptyLane.
  ///
  /// In en, this message translates to:
  /// **'No orders here'**
  String get ordersMgmtEmptyLane;

  /// No description provided for @ordersMgmtOpenDetail.
  ///
  /// In en, this message translates to:
  /// **'Open detail'**
  String get ordersMgmtOpenDetail;

  /// No description provided for @ordersMgmtEscalate.
  ///
  /// In en, this message translates to:
  /// **'Escalate'**
  String get ordersMgmtEscalate;

  /// No description provided for @ordersMgmtEscalationLogged.
  ///
  /// In en, this message translates to:
  /// **'Escalation logged'**
  String get ordersMgmtEscalationLogged;

  /// No description provided for @ordersMgmtRecentlyClosed.
  ///
  /// In en, this message translates to:
  /// **'Recently Closed'**
  String get ordersMgmtRecentlyClosed;

  /// No description provided for @ordersMgmtHistory.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get ordersMgmtHistory;

  /// No description provided for @ordersMgmtDeliveredStatus.
  ///
  /// In en, this message translates to:
  /// **'Delivered'**
  String get ordersMgmtDeliveredStatus;

  /// No description provided for @financialCloseBadge.
  ///
  /// In en, this message translates to:
  /// **'Cash Close & Profit Split'**
  String get financialCloseBadge;

  /// No description provided for @financialCloseHeroHeadline.
  ///
  /// In en, this message translates to:
  /// **'Reconcile shift revenue, cash, cards, deposits, tips, then approve net profit.'**
  String get financialCloseHeroHeadline;

  /// No description provided for @financialCloseShiftRevenue.
  ///
  /// In en, this message translates to:
  /// **'Shift revenue'**
  String get financialCloseShiftRevenue;

  /// No description provided for @financialCloseOrdersCount.
  ///
  /// In en, this message translates to:
  /// **'Orders'**
  String get financialCloseOrdersCount;

  /// No description provided for @financialCloseDistributableNet.
  ///
  /// In en, this message translates to:
  /// **'Distributable net'**
  String get financialCloseDistributableNet;

  /// No description provided for @financialCloseSummaryTitle.
  ///
  /// In en, this message translates to:
  /// **'Shift Close Summary'**
  String get financialCloseSummaryTitle;

  /// No description provided for @financialCloseSummarySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Operational numbers before approving the close.'**
  String get financialCloseSummarySubtitle;

  /// No description provided for @financialCloseStatusLabel.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get financialCloseStatusLabel;

  /// No description provided for @financialCloseStatusReady.
  ///
  /// In en, this message translates to:
  /// **'Ready to close'**
  String get financialCloseStatusReady;

  /// No description provided for @financialCloseTenderTitle.
  ///
  /// In en, this message translates to:
  /// **'Tender Reconciliation'**
  String get financialCloseTenderTitle;

  /// No description provided for @financialCloseTenderSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Cash, card, and wallet must match the cashier ledger.'**
  String get financialCloseTenderSubtitle;

  /// No description provided for @financialCloseCash.
  ///
  /// In en, this message translates to:
  /// **'Cash'**
  String get financialCloseCash;

  /// No description provided for @financialCloseCards.
  ///
  /// In en, this message translates to:
  /// **'Cards'**
  String get financialCloseCards;

  /// No description provided for @financialCloseWallet.
  ///
  /// In en, this message translates to:
  /// **'Wallet'**
  String get financialCloseWallet;

  /// No description provided for @financialCloseDepositsTitle.
  ///
  /// In en, this message translates to:
  /// **'Deposits & Refunds'**
  String get financialCloseDepositsTitle;

  /// No description provided for @financialCloseDepositsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Tray deposits, refunds, and breakage exposure.'**
  String get financialCloseDepositsSubtitle;

  /// No description provided for @financialCloseRefundsToday.
  ///
  /// In en, this message translates to:
  /// **'Refunds today'**
  String get financialCloseRefundsToday;

  /// No description provided for @financialCloseBreakageFees.
  ///
  /// In en, this message translates to:
  /// **'Potential breakage fees'**
  String get financialCloseBreakageFees;

  /// No description provided for @financialCloseReviewTrayReturns.
  ///
  /// In en, this message translates to:
  /// **'Review tray returns'**
  String get financialCloseReviewTrayReturns;

  /// No description provided for @financialCloseTipsTitle.
  ///
  /// In en, this message translates to:
  /// **'Tips & Variance'**
  String get financialCloseTipsTitle;

  /// No description provided for @financialCloseTipsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Shift tip pool and reconciliation variance.'**
  String get financialCloseTipsSubtitle;

  /// No description provided for @financialCloseCurrentTips.
  ///
  /// In en, this message translates to:
  /// **'Current shift tips'**
  String get financialCloseCurrentTips;

  /// No description provided for @financialCloseVariance.
  ///
  /// In en, this message translates to:
  /// **'Reconciliation variance'**
  String get financialCloseVariance;

  /// No description provided for @financialCloseSplitTitle.
  ///
  /// In en, this message translates to:
  /// **'Net Profit Split'**
  String get financialCloseSplitTitle;

  /// No description provided for @financialCloseSplitSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Owner and operator shares after costs and tips.'**
  String get financialCloseSplitSubtitle;

  /// No description provided for @financialCloseApproveTitle.
  ///
  /// In en, this message translates to:
  /// **'Approve Close'**
  String get financialCloseApproveTitle;

  /// No description provided for @financialCloseOwnerViewOnly.
  ///
  /// In en, this message translates to:
  /// **'Owner view only'**
  String get financialCloseOwnerViewOnly;

  /// No description provided for @financialCloseApprovedReadOnly.
  ///
  /// In en, this message translates to:
  /// **'Close approved (read-only)'**
  String get financialCloseApprovedReadOnly;

  /// No description provided for @financialCloseAwaitingApproval.
  ///
  /// In en, this message translates to:
  /// **'Awaiting operator approval'**
  String get financialCloseAwaitingApproval;

  /// No description provided for @financialCloseApproveSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Lock the shift after reconciliation checks.'**
  String get financialCloseApproveSubtitle;

  /// No description provided for @financialCloseApproveShift.
  ///
  /// In en, this message translates to:
  /// **'Approve shift close'**
  String get financialCloseApproveShift;

  /// No description provided for @financialCloseApproveConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Approve close'**
  String get financialCloseApproveConfirmTitle;

  /// No description provided for @financialCloseApproveConfirmMessage.
  ///
  /// In en, this message translates to:
  /// **'This will lock shift totals for audit.'**
  String get financialCloseApproveConfirmMessage;

  /// No description provided for @financialCloseApprovedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Shift close approved'**
  String get financialCloseApprovedSuccess;

  /// No description provided for @settingsStaffCardSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Staff hours and attendance.'**
  String get settingsStaffCardSubtitle;

  /// No description provided for @settingsFeesTaxesCardSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Sales tax, delivery fees, deposits, and receipts.'**
  String get settingsFeesTaxesCardSubtitle;

  /// No description provided for @settingsDeliveryFeesZoneMinimum.
  ///
  /// In en, this message translates to:
  /// **'Zone-based fee and minimum order'**
  String get settingsDeliveryFeesZoneMinimum;

  /// No description provided for @settingsReceiptTemplateTerms.
  ///
  /// In en, this message translates to:
  /// **'Logo, tax, and return terms'**
  String get settingsReceiptTemplateTerms;

  /// No description provided for @settingsNotificationsCardSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Kitchen, driver, inventory, and return alerts.'**
  String get settingsNotificationsCardSubtitle;

  /// No description provided for @settingsLateKitchenTicketAlerts.
  ///
  /// In en, this message translates to:
  /// **'Late kitchen ticket alerts'**
  String get settingsLateKitchenTicketAlerts;

  /// No description provided for @settingsShortcutsJumpSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Jump to specialized settings without bottom navigation.'**
  String get settingsShortcutsJumpSubtitle;

  /// No description provided for @ordersMgmtHeroHeadline.
  ///
  /// In en, this message translates to:
  /// **'Track every order from POS to kitchen to handoff.'**
  String get ordersMgmtHeroHeadline;

  /// No description provided for @ordersMgmtRecentlyClosedSub.
  ///
  /// In en, this message translates to:
  /// **'Completed or delivered orders for quick audit.'**
  String get ordersMgmtRecentlyClosedSub;

  /// No description provided for @ordersMgmtOpPending.
  ///
  /// In en, this message translates to:
  /// **'Waiting for kitchen confirmation or item availability.'**
  String get ordersMgmtOpPending;

  /// No description provided for @ordersMgmtOpReady.
  ///
  /// In en, this message translates to:
  /// **'Ready for handoff, verify packaging.'**
  String get ordersMgmtOpReady;

  /// No description provided for @ordersMgmtOpOnWay.
  ///
  /// In en, this message translates to:
  /// **'On route, monitor arrival time.'**
  String get ordersMgmtOpOnWay;

  /// No description provided for @ordersMgmtOpPreparing.
  ///
  /// In en, this message translates to:
  /// **'In preparation, watch station timing.'**
  String get ordersMgmtOpPreparing;

  /// No description provided for @financialCloseDepositsExcludedSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Deposits are conditional funds and excluded from profit split.'**
  String get financialCloseDepositsExcludedSubtitle;

  /// No description provided for @financialCloseTipsSeparateSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Tips stay separate from revenue and go to staff.'**
  String get financialCloseTipsSeparateSubtitle;

  /// No description provided for @financialCloseSplitAfterCostsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'After excluding tips, deposits, and operating expenses.'**
  String get financialCloseSplitAfterCostsSubtitle;

  /// No description provided for @financialCloseApproveUiOnlySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Review totals before approving the shift close.'**
  String get financialCloseApproveUiOnlySubtitle;

  /// No description provided for @financialCloseApproveMockMessage.
  ///
  /// In en, this message translates to:
  /// **'Shift close approval will be logged for audit.'**
  String get financialCloseApproveMockMessage;

  /// No description provided for @financialCloseReportDownloaded.
  ///
  /// In en, this message translates to:
  /// **'Report downloaded — print to PDF from browser'**
  String get financialCloseReportDownloaded;

  /// No description provided for @financialCloseVarianceLabel.
  ///
  /// In en, this message translates to:
  /// **'Variance'**
  String get financialCloseVarianceLabel;

  /// No description provided for @actionAdd.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get actionAdd;

  /// No description provided for @catalogCrudAdded.
  ///
  /// In en, this message translates to:
  /// **'Added'**
  String get catalogCrudAdded;

  /// No description provided for @catalogCrudCheckFields.
  ///
  /// In en, this message translates to:
  /// **'Check required fields'**
  String get catalogCrudCheckFields;

  /// No description provided for @catalogCrudUpdated.
  ///
  /// In en, this message translates to:
  /// **'Updated'**
  String get catalogCrudUpdated;

  /// No description provided for @catalogCrudUpdateFailed.
  ///
  /// In en, this message translates to:
  /// **'Update failed'**
  String get catalogCrudUpdateFailed;

  /// No description provided for @catalogCrudDeleted.
  ///
  /// In en, this message translates to:
  /// **'Deleted'**
  String get catalogCrudDeleted;

  /// No description provided for @catalogCrudNameEn.
  ///
  /// In en, this message translates to:
  /// **'Name EN'**
  String get catalogCrudNameEn;

  /// No description provided for @catalogCrudNameAr.
  ///
  /// In en, this message translates to:
  /// **'Name AR'**
  String get catalogCrudNameAr;

  /// No description provided for @catalogCrudIconKey.
  ///
  /// In en, this message translates to:
  /// **'Icon key'**
  String get catalogCrudIconKey;

  /// No description provided for @catalogCrudPrice.
  ///
  /// In en, this message translates to:
  /// **'Price'**
  String get catalogCrudPrice;

  /// No description provided for @catalogCrudMinOneImage.
  ///
  /// In en, this message translates to:
  /// **'Add at least 1 image'**
  String get catalogCrudMinOneImage;

  /// No description provided for @menuCatalogTitle.
  ///
  /// In en, this message translates to:
  /// **'Menu Catalog'**
  String get menuCatalogTitle;

  /// No description provided for @menuCatalogTabCategories.
  ///
  /// In en, this message translates to:
  /// **'Categories'**
  String get menuCatalogTabCategories;

  /// No description provided for @menuCatalogTabAddons.
  ///
  /// In en, this message translates to:
  /// **'Addons'**
  String get menuCatalogTabAddons;

  /// No description provided for @menuCatalogTabRelated.
  ///
  /// In en, this message translates to:
  /// **'Related'**
  String get menuCatalogTabRelated;

  /// No description provided for @menuCatalogAddCategory.
  ///
  /// In en, this message translates to:
  /// **'Add category'**
  String get menuCatalogAddCategory;

  /// No description provided for @menuCatalogAddAddon.
  ///
  /// In en, this message translates to:
  /// **'Add addon'**
  String get menuCatalogAddAddon;

  /// No description provided for @menuCatalogAddonImageRequired.
  ///
  /// In en, this message translates to:
  /// **'Add an image for the addon'**
  String get menuCatalogAddonImageRequired;

  /// No description provided for @menuCatalogLinkRelated.
  ///
  /// In en, this message translates to:
  /// **'Link related products'**
  String get menuCatalogLinkRelated;

  /// No description provided for @menuCatalogLinkRelatedSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Example IDs: {sampleIds}'**
  String menuCatalogLinkRelatedSubtitle(String sampleIds);

  /// No description provided for @menuCatalogProductId.
  ///
  /// In en, this message translates to:
  /// **'Product ID'**
  String get menuCatalogProductId;

  /// No description provided for @menuCatalogRelatedIds.
  ///
  /// In en, this message translates to:
  /// **'Related IDs (comma-separated)'**
  String get menuCatalogRelatedIds;

  /// No description provided for @menuCatalogSaveLink.
  ///
  /// In en, this message translates to:
  /// **'Save link'**
  String get menuCatalogSaveLink;

  /// No description provided for @menuCatalogSaved.
  ///
  /// In en, this message translates to:
  /// **'Saved'**
  String get menuCatalogSaved;

  /// No description provided for @menuCatalogEnterProductId.
  ///
  /// In en, this message translates to:
  /// **'Enter a product ID'**
  String get menuCatalogEnterProductId;

  /// No description provided for @promoMgmtTabDiscounts.
  ///
  /// In en, this message translates to:
  /// **'Discounts'**
  String get promoMgmtTabDiscounts;

  /// No description provided for @promoMgmtTabOffers.
  ///
  /// In en, this message translates to:
  /// **'Offers'**
  String get promoMgmtTabOffers;

  /// No description provided for @promoMgmtCreateCombo.
  ///
  /// In en, this message translates to:
  /// **'Create combo'**
  String get promoMgmtCreateCombo;

  /// No description provided for @promoMgmtDiscountPercent.
  ///
  /// In en, this message translates to:
  /// **'Discount %'**
  String get promoMgmtDiscountPercent;

  /// No description provided for @promoMgmtDiscountProduct.
  ///
  /// In en, this message translates to:
  /// **'Discount product'**
  String get promoMgmtDiscountProduct;

  /// No description provided for @promoMgmtMenuItemId.
  ///
  /// In en, this message translates to:
  /// **'Menu item ID'**
  String get promoMgmtMenuItemId;

  /// No description provided for @promoMgmtNewOffer.
  ///
  /// In en, this message translates to:
  /// **'New offer'**
  String get promoMgmtNewOffer;

  /// No description provided for @promoMgmtSubscriptionMeal.
  ///
  /// In en, this message translates to:
  /// **'Subscription meal'**
  String get promoMgmtSubscriptionMeal;

  /// No description provided for @orderDetailAdminHeroTitle.
  ///
  /// In en, this message translates to:
  /// **'Order #{orderId} admin timeline'**
  String orderDetailAdminHeroTitle(String orderId);

  /// No description provided for @orderDetailAdminHeroBody.
  ///
  /// In en, this message translates to:
  /// **'{customer} • Verify handoff timing, deposit, and notes before closing.'**
  String orderDetailAdminHeroBody(String customer);

  /// No description provided for @orderDetailAdminActionsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Update status, notes, and escalations for this order.'**
  String get orderDetailAdminActionsSubtitle;

  /// No description provided for @orderDetailAdminChangeStatusMessage.
  ///
  /// In en, this message translates to:
  /// **'Choose the next status for this order.'**
  String get orderDetailAdminChangeStatusMessage;

  /// No description provided for @orderDetailAdminTimelinePosDetail.
  ///
  /// In en, this message translates to:
  /// **'Order entered and payment captured.'**
  String get orderDetailAdminTimelinePosDetail;

  /// No description provided for @orderDetailAdminTimelinePrepDetail.
  ///
  /// In en, this message translates to:
  /// **'Items prepared and packed.'**
  String get orderDetailAdminTimelinePrepDetail;

  /// No description provided for @orderDetailAdminTimelineOnWayDetail.
  ///
  /// In en, this message translates to:
  /// **'Courier is on the way to the guest.'**
  String get orderDetailAdminTimelineOnWayDetail;

  /// No description provided for @orderDetailAdminTimelineWaitingDetail.
  ///
  /// In en, this message translates to:
  /// **'Waiting for the next operational step.'**
  String get orderDetailAdminTimelineWaitingDetail;

  /// No description provided for @orderDetailAdminTimelineCloseDetail.
  ///
  /// In en, this message translates to:
  /// **'Confirm handoff, deposit, and any breakage fee.'**
  String get orderDetailAdminTimelineCloseDetail;

  /// No description provided for @orderDetailAdminRisksSubtitle.
  ///
  /// In en, this message translates to:
  /// **'What the owner should know before closing this order.'**
  String get orderDetailAdminRisksSubtitle;

  /// No description provided for @orderDetailAdminRiskTimingDetail.
  ///
  /// In en, this message translates to:
  /// **'Eight minutes above route average.'**
  String get orderDetailAdminRiskTimingDetail;

  /// No description provided for @orderDetailAdminRiskTrayDetail.
  ///
  /// In en, this message translates to:
  /// **'Confirm tray return expectation at handoff.'**
  String get orderDetailAdminRiskTrayDetail;

  /// No description provided for @hrPayrollOnTimeRule.
  ///
  /// In en, this message translates to:
  /// **'On time (≤ {minutes} min) → 100% salary'**
  String hrPayrollOnTimeRule(int minutes);

  /// No description provided for @hrPayrollDelayDoubleRule.
  ///
  /// In en, this message translates to:
  /// **'Late > {minutes} min → fee ×2'**
  String hrPayrollDelayDoubleRule(int minutes);

  /// No description provided for @hrPayrollAbsenceRule.
  ///
  /// In en, this message translates to:
  /// **'Late > {minutes} min → absence (0% even if present)'**
  String hrPayrollAbsenceRule(int minutes);

  /// No description provided for @hrPayrollOvertimeRule.
  ///
  /// In en, this message translates to:
  /// **'Work > {minutes} min beyond schedule → {multiplier}× extra hours pay'**
  String hrPayrollOvertimeRule(int minutes, String multiplier);

  /// No description provided for @supportTicketsHeroBody.
  ///
  /// In en, this message translates to:
  /// **'{count} active tickets — update status, reply to customers, track feedback.'**
  String supportTicketsHeroBody(int count);

  /// No description provided for @supportTicketStatusOpen.
  ///
  /// In en, this message translates to:
  /// **'Open'**
  String get supportTicketStatusOpen;

  /// No description provided for @supportTicketStatusInProgress.
  ///
  /// In en, this message translates to:
  /// **'In progress'**
  String get supportTicketStatusInProgress;

  /// No description provided for @supportTicketStatusWaiting.
  ///
  /// In en, this message translates to:
  /// **'Waiting'**
  String get supportTicketStatusWaiting;

  /// No description provided for @supportTicketStatusResolved.
  ///
  /// In en, this message translates to:
  /// **'Resolved'**
  String get supportTicketStatusResolved;

  /// No description provided for @supportTicketStatusClosed.
  ///
  /// In en, this message translates to:
  /// **'Closed'**
  String get supportTicketStatusClosed;

  /// No description provided for @reportsHubBadge.
  ///
  /// In en, this message translates to:
  /// **'Restaurant Analytics Hub'**
  String get reportsHubBadge;

  /// No description provided for @reportsHubHeadline.
  ///
  /// In en, this message translates to:
  /// **'Connect sales, channels, tips, waste, and trays to clear operating decisions.'**
  String get reportsHubHeadline;

  /// No description provided for @reportsOpsScorecardsTitle.
  ///
  /// In en, this message translates to:
  /// **'Operating Scorecards'**
  String get reportsOpsScorecardsTitle;

  /// No description provided for @reportsOpsScorecardsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Numbers that drive today, not just export files.'**
  String get reportsOpsScorecardsSubtitle;

  /// No description provided for @reportsAvgOrderLabel.
  ///
  /// In en, this message translates to:
  /// **'Average order'**
  String get reportsAvgOrderLabel;

  /// No description provided for @reportsTrayReturnSuccess.
  ///
  /// In en, this message translates to:
  /// **'Tray return success'**
  String get reportsTrayReturnSuccess;

  /// No description provided for @reportsWasteBreakageCost.
  ///
  /// In en, this message translates to:
  /// **'Waste & breakage cost'**
  String get reportsWasteBreakageCost;

  /// No description provided for @reportsTrendSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Order trend across recent service hours.'**
  String get reportsTrendSubtitle;

  /// No description provided for @reportsTodayPeakLabel.
  ///
  /// In en, this message translates to:
  /// **'Today peak'**
  String get reportsTodayPeakLabel;

  /// No description provided for @reportsTodayPeakValue.
  ///
  /// In en, this message translates to:
  /// **'Lunch and evening delivery'**
  String get reportsTodayPeakValue;

  /// No description provided for @reportsDecisionsTitle.
  ///
  /// In en, this message translates to:
  /// **'Recommended Decisions'**
  String get reportsDecisionsTitle;

  /// No description provided for @reportsDecisionsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Analytics connected to restaurant operations.'**
  String get reportsDecisionsSubtitle;

  /// No description provided for @reportsInsightShawarmaLabel.
  ///
  /// In en, this message translates to:
  /// **'Increase shawarma prep before lunch'**
  String get reportsInsightShawarmaLabel;

  /// No description provided for @reportsInsightShawarmaDetail.
  ///
  /// In en, this message translates to:
  /// **'Channel sales are 12% above baseline.'**
  String get reportsInsightShawarmaDetail;

  /// No description provided for @reportsReviewFryerLabel.
  ///
  /// In en, this message translates to:
  /// **'Review fryer wastage'**
  String get reportsReviewFryerLabel;

  /// No description provided for @reportsApproveTipsLabel.
  ///
  /// In en, this message translates to:
  /// **'Approve tip distribution'**
  String get reportsApproveTipsLabel;

  /// No description provided for @reportsModulesTitle.
  ///
  /// In en, this message translates to:
  /// **'Analytics Modules'**
  String get reportsModulesTitle;

  /// No description provided for @reportsPlatesDepositsTitle.
  ///
  /// In en, this message translates to:
  /// **'Plates & deposits'**
  String get reportsPlatesDepositsTitle;

  /// No description provided for @reportsExportTitle.
  ///
  /// In en, this message translates to:
  /// **'Export & Share'**
  String get reportsExportTitle;

  /// No description provided for @reportsExportSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Exports are now an outcome, not the whole screen.'**
  String get reportsExportSubtitle;

  /// No description provided for @reportsExportOperatorOnly.
  ///
  /// In en, this message translates to:
  /// **'Export is available to the operator role only.'**
  String get reportsExportOperatorOnly;

  /// No description provided for @preOrderOpsBadge.
  ///
  /// In en, this message translates to:
  /// **'Pre-order Operations'**
  String get preOrderOpsBadge;

  /// No description provided for @preOrderOpsHeadline.
  ///
  /// In en, this message translates to:
  /// **'Review tomorrow orders, prep capacity, trays, and pickup windows before accepting pre-orders.'**
  String get preOrderOpsHeadline;

  /// No description provided for @preOrderOpsNeedDecision.
  ///
  /// In en, this message translates to:
  /// **'Need decision'**
  String get preOrderOpsNeedDecision;

  /// No description provided for @preOrderOpsPickupWindows.
  ///
  /// In en, this message translates to:
  /// **'Pickup windows'**
  String get preOrderOpsPickupWindows;

  /// No description provided for @preOrderOpsReservedTrays.
  ///
  /// In en, this message translates to:
  /// **'Reserved trays'**
  String get preOrderOpsReservedTrays;

  /// No description provided for @preOrderOpsEmptyMessage.
  ///
  /// In en, this message translates to:
  /// **'No pre-orders pending'**
  String get preOrderOpsEmptyMessage;

  /// No description provided for @preOrderOpsReviewQueue.
  ///
  /// In en, this message translates to:
  /// **'Review Queue'**
  String get preOrderOpsReviewQueue;

  /// No description provided for @preOrderOpsReviewQueueSub.
  ///
  /// In en, this message translates to:
  /// **'Each pre-order needs a clear decision before prep.'**
  String get preOrderOpsReviewQueueSub;

  /// No description provided for @preOrderOpsAccept.
  ///
  /// In en, this message translates to:
  /// **'Accept'**
  String get preOrderOpsAccept;

  /// No description provided for @preOrderOpsAccepted.
  ///
  /// In en, this message translates to:
  /// **'Pre-order accepted'**
  String get preOrderOpsAccepted;

  /// No description provided for @preOrderOpsAdjustTime.
  ///
  /// In en, this message translates to:
  /// **'Adjust time'**
  String get preOrderOpsAdjustTime;

  /// No description provided for @preOrderOpsPickupUpdated.
  ///
  /// In en, this message translates to:
  /// **'Pickup time updated'**
  String get preOrderOpsPickupUpdated;

  /// No description provided for @preOrderOpsPrepCapacity.
  ///
  /// In en, this message translates to:
  /// **'Prep Capacity'**
  String get preOrderOpsPrepCapacity;

  /// No description provided for @preOrderOpsPrepCapacitySub.
  ///
  /// In en, this message translates to:
  /// **'Accept orders based on available stations.'**
  String get preOrderOpsPrepCapacitySub;

  /// No description provided for @preOrderOpsStationShawarma.
  ///
  /// In en, this message translates to:
  /// **'Shawarma'**
  String get preOrderOpsStationShawarma;

  /// No description provided for @preOrderOpsStationPizza.
  ///
  /// In en, this message translates to:
  /// **'Pizza'**
  String get preOrderOpsStationPizza;

  /// No description provided for @preOrderOpsStationPlated.
  ///
  /// In en, this message translates to:
  /// **'Plated trays'**
  String get preOrderOpsStationPlated;

  /// No description provided for @preOrderOpsRulesTitle.
  ///
  /// In en, this message translates to:
  /// **'Pre-order Rules'**
  String get preOrderOpsRulesTitle;

  /// No description provided for @preOrderOpsRulesSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Configure pre-order rules and availability.'**
  String get preOrderOpsRulesSubtitle;

  /// No description provided for @preOrderOpsRuleCutoff.
  ///
  /// In en, this message translates to:
  /// **'Cutoff: 9 PM'**
  String get preOrderOpsRuleCutoff;

  /// No description provided for @preOrderOpsRuleMinPrep.
  ///
  /// In en, this message translates to:
  /// **'Minimum prep: 2 hours'**
  String get preOrderOpsRuleMinPrep;

  /// No description provided for @preOrderOpsRuleTraysBeforePay.
  ///
  /// In en, this message translates to:
  /// **'Confirm trays before payment'**
  String get preOrderOpsRuleTraysBeforePay;

  /// No description provided for @rewardsAdminSetupTitle.
  ///
  /// In en, this message translates to:
  /// **'Rewards Setup'**
  String get rewardsAdminSetupTitle;

  /// No description provided for @rewardsAdminPointsRules.
  ///
  /// In en, this message translates to:
  /// **'Points rules'**
  String get rewardsAdminPointsRules;

  /// No description provided for @rewardsAdminPointsPerJod.
  ///
  /// In en, this message translates to:
  /// **'{points} points per JOD spent'**
  String rewardsAdminPointsPerJod(String points);

  /// No description provided for @rewardsAdminAddReward.
  ///
  /// In en, this message translates to:
  /// **'Add reward'**
  String get rewardsAdminAddReward;

  /// No description provided for @rewardsAdminPointsRequired.
  ///
  /// In en, this message translates to:
  /// **'Points required'**
  String get rewardsAdminPointsRequired;

  /// No description provided for @rewardsAdminCategory.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get rewardsAdminCategory;

  /// No description provided for @rewardsAdminAddToCatalog.
  ///
  /// In en, this message translates to:
  /// **'Add to catalog'**
  String get rewardsAdminAddToCatalog;

  /// No description provided for @rewardsAdminActiveRewards.
  ///
  /// In en, this message translates to:
  /// **'Active rewards'**
  String get rewardsAdminActiveRewards;

  /// No description provided for @rewardsAdminRewardAdded.
  ///
  /// In en, this message translates to:
  /// **'Reward added'**
  String get rewardsAdminRewardAdded;

  /// No description provided for @rewardsAdminCategoryDrinks.
  ///
  /// In en, this message translates to:
  /// **'Drinks'**
  String get rewardsAdminCategoryDrinks;

  /// No description provided for @rewardsAdminCategorySides.
  ///
  /// In en, this message translates to:
  /// **'Sides'**
  String get rewardsAdminCategorySides;

  /// No description provided for @rewardsAdminCategoryMain.
  ///
  /// In en, this message translates to:
  /// **'Main'**
  String get rewardsAdminCategoryMain;

  /// No description provided for @rewardsAdminArtIcon.
  ///
  /// In en, this message translates to:
  /// **'Art icon'**
  String get rewardsAdminArtIcon;

  /// No description provided for @rewardsAdminColorAccent.
  ///
  /// In en, this message translates to:
  /// **'Color accent'**
  String get rewardsAdminColorAccent;

  /// No description provided for @rewardsAdminBadgeAr.
  ///
  /// In en, this message translates to:
  /// **'Badge AR'**
  String get rewardsAdminBadgeAr;

  /// No description provided for @rewardsAdminBadgeEn.
  ///
  /// In en, this message translates to:
  /// **'Badge EN'**
  String get rewardsAdminBadgeEn;

  /// No description provided for @rewardsAdminArtGeneric.
  ///
  /// In en, this message translates to:
  /// **'Generic'**
  String get rewardsAdminArtGeneric;

  /// No description provided for @rewardsAdminArtBurger.
  ///
  /// In en, this message translates to:
  /// **'Burger'**
  String get rewardsAdminArtBurger;

  /// No description provided for @rewardsAdminArtDrink.
  ///
  /// In en, this message translates to:
  /// **'Drink'**
  String get rewardsAdminArtDrink;

  /// No description provided for @rewardsAdminArtFries.
  ///
  /// In en, this message translates to:
  /// **'Fries'**
  String get rewardsAdminArtFries;

  /// No description provided for @rewardsAdminArtBowl.
  ///
  /// In en, this message translates to:
  /// **'Bowl'**
  String get rewardsAdminArtBowl;

  /// No description provided for @rewardsAdminArtDonut.
  ///
  /// In en, this message translates to:
  /// **'Donut'**
  String get rewardsAdminArtDonut;

  /// No description provided for @rewardsAdminColorGold.
  ///
  /// In en, this message translates to:
  /// **'Gold'**
  String get rewardsAdminColorGold;

  /// No description provided for @rewardsAdminColorOrange.
  ///
  /// In en, this message translates to:
  /// **'Orange'**
  String get rewardsAdminColorOrange;

  /// No description provided for @rewardsAdminColorOlive.
  ///
  /// In en, this message translates to:
  /// **'Olive'**
  String get rewardsAdminColorOlive;

  /// No description provided for @rewardsAdminColorDelivery.
  ///
  /// In en, this message translates to:
  /// **'Delivery'**
  String get rewardsAdminColorDelivery;

  /// No description provided for @rewardsAdminColorDineIn.
  ///
  /// In en, this message translates to:
  /// **'Dine in'**
  String get rewardsAdminColorDineIn;

  /// No description provided for @rewardsAdminColorSecondary.
  ///
  /// In en, this message translates to:
  /// **'Secondary'**
  String get rewardsAdminColorSecondary;

  /// No description provided for @rewardsAdminColorTertiary.
  ///
  /// In en, this message translates to:
  /// **'Tertiary'**
  String get rewardsAdminColorTertiary;

  /// No description provided for @rewardsAdminColorOutline.
  ///
  /// In en, this message translates to:
  /// **'Outline'**
  String get rewardsAdminColorOutline;

  /// No description provided for @rewardsAdminSoldOut.
  ///
  /// In en, this message translates to:
  /// **'Sold out'**
  String get rewardsAdminSoldOut;

  /// No description provided for @rewardsAdminTitleAr.
  ///
  /// In en, this message translates to:
  /// **'Title AR'**
  String get rewardsAdminTitleAr;

  /// No description provided for @rewardsAdminTitleEn.
  ///
  /// In en, this message translates to:
  /// **'Title EN'**
  String get rewardsAdminTitleEn;

  /// No description provided for @rewardsAdminDescriptionAr.
  ///
  /// In en, this message translates to:
  /// **'Description AR'**
  String get rewardsAdminDescriptionAr;

  /// No description provided for @rewardsAdminDescriptionEn.
  ///
  /// In en, this message translates to:
  /// **'Description EN'**
  String get rewardsAdminDescriptionEn;

  /// No description provided for @rewardsAdminPointsLabel.
  ///
  /// In en, this message translates to:
  /// **'Points'**
  String get rewardsAdminPointsLabel;

  /// No description provided for @rewardsAdminRewardMeta.
  ///
  /// In en, this message translates to:
  /// **'{points} pts · {category}'**
  String rewardsAdminRewardMeta(int points, String category);

  /// No description provided for @quantityIncrease.
  ///
  /// In en, this message translates to:
  /// **'Increase quantity'**
  String get quantityIncrease;

  /// No description provided for @quantityDecrease.
  ///
  /// In en, this message translates to:
  /// **'Decrease quantity'**
  String get quantityDecrease;

  /// No description provided for @menuMgmtPublished.
  ///
  /// In en, this message translates to:
  /// **'Published'**
  String get menuMgmtPublished;

  /// No description provided for @menuMgmtDraft.
  ///
  /// In en, this message translates to:
  /// **'Draft'**
  String get menuMgmtDraft;

  /// No description provided for @menuMgmtPublish.
  ///
  /// In en, this message translates to:
  /// **'Publish'**
  String get menuMgmtPublish;

  /// No description provided for @menuMgmtUnpublish.
  ///
  /// In en, this message translates to:
  /// **'Unpublish'**
  String get menuMgmtUnpublish;

  /// No description provided for @menuMgmtPublishSuccess.
  ///
  /// In en, this message translates to:
  /// **'Published'**
  String get menuMgmtPublishSuccess;

  /// No description provided for @menuMgmtHiddenFromMenu.
  ///
  /// In en, this message translates to:
  /// **'Hidden from customer menu'**
  String get menuMgmtHiddenFromMenu;

  /// No description provided for @filterByRole.
  ///
  /// In en, this message translates to:
  /// **'Filter by role'**
  String get filterByRole;

  /// No description provided for @rbacUserNotFound.
  ///
  /// In en, this message translates to:
  /// **'User not found'**
  String get rbacUserNotFound;

  /// No description provided for @rbacAccountActions.
  ///
  /// In en, this message translates to:
  /// **'Account actions'**
  String get rbacAccountActions;

  /// No description provided for @rbacApprove.
  ///
  /// In en, this message translates to:
  /// **'Approve'**
  String get rbacApprove;

  /// No description provided for @rbacReject.
  ///
  /// In en, this message translates to:
  /// **'Reject'**
  String get rbacReject;

  /// No description provided for @rbacSuspend.
  ///
  /// In en, this message translates to:
  /// **'Suspend'**
  String get rbacSuspend;

  /// No description provided for @rbacActivate.
  ///
  /// In en, this message translates to:
  /// **'Activate'**
  String get rbacActivate;

  /// No description provided for @rbacInvite.
  ///
  /// In en, this message translates to:
  /// **'Invite'**
  String get rbacInvite;

  /// No description provided for @rbacInviteMockMessage.
  ///
  /// In en, this message translates to:
  /// **'Invite sent'**
  String get rbacInviteMockMessage;

  /// No description provided for @rbacApprovedMessage.
  ///
  /// In en, this message translates to:
  /// **'Approved'**
  String get rbacApprovedMessage;

  /// No description provided for @rbacRejectedMessage.
  ///
  /// In en, this message translates to:
  /// **'Rejected'**
  String get rbacRejectedMessage;

  /// No description provided for @rbacSuspendedMessage.
  ///
  /// In en, this message translates to:
  /// **'Suspended'**
  String get rbacSuspendedMessage;

  /// No description provided for @rbacActivatedMessage.
  ///
  /// In en, this message translates to:
  /// **'Activated'**
  String get rbacActivatedMessage;

  /// No description provided for @rbacAssignedRoles.
  ///
  /// In en, this message translates to:
  /// **'Assigned roles'**
  String get rbacAssignedRoles;

  /// No description provided for @rbacStatusActive.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get rbacStatusActive;

  /// No description provided for @rbacStatusPendingApproval.
  ///
  /// In en, this message translates to:
  /// **'Pending approval'**
  String get rbacStatusPendingApproval;

  /// No description provided for @rbacStatusSuspended.
  ///
  /// In en, this message translates to:
  /// **'Suspended'**
  String get rbacStatusSuspended;

  /// No description provided for @rbacOwnershipPercent.
  ///
  /// In en, this message translates to:
  /// **'Ownership %'**
  String get rbacOwnershipPercent;

  /// No description provided for @rbacOwnershipHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. 35'**
  String get rbacOwnershipHint;

  /// No description provided for @reviewModerationTitle.
  ///
  /// In en, this message translates to:
  /// **'Review Moderation'**
  String get reviewModerationTitle;

  /// No description provided for @reviewModerationHeroBody.
  ///
  /// In en, this message translates to:
  /// **'{count} reviews awaiting moderation — approve to publish, reject or flag for follow-up.'**
  String reviewModerationHeroBody(int count);

  /// No description provided for @reviewModerationReject.
  ///
  /// In en, this message translates to:
  /// **'Reject'**
  String get reviewModerationReject;

  /// No description provided for @reviewModerationFlag.
  ///
  /// In en, this message translates to:
  /// **'Flag'**
  String get reviewModerationFlag;

  /// No description provided for @reviewModerationUpdated.
  ///
  /// In en, this message translates to:
  /// **'Review updated'**
  String get reviewModerationUpdated;

  /// No description provided for @reviewModerationStatusPending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get reviewModerationStatusPending;

  /// No description provided for @reviewModerationStatusApproved.
  ///
  /// In en, this message translates to:
  /// **'Approved'**
  String get reviewModerationStatusApproved;

  /// No description provided for @reviewModerationStatusRejected.
  ///
  /// In en, this message translates to:
  /// **'Rejected'**
  String get reviewModerationStatusRejected;

  /// No description provided for @reviewModerationStatusFlagged.
  ///
  /// In en, this message translates to:
  /// **'Flagged'**
  String get reviewModerationStatusFlagged;

  /// No description provided for @plateEditorBadge.
  ///
  /// In en, this message translates to:
  /// **'Asset & Deposit Editor'**
  String get plateEditorBadge;

  /// No description provided for @plateEditorHeadline.
  ///
  /// In en, this message translates to:
  /// **'Set asset value, stock, deposit, and breakage fees.'**
  String get plateEditorHeadline;

  /// No description provided for @plateEditorAssetIdentityTitle.
  ///
  /// In en, this message translates to:
  /// **'Asset Identity'**
  String get plateEditorAssetIdentityTitle;

  /// No description provided for @plateEditorAssetIdentitySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Used by inventory, delivery, and returns.'**
  String get plateEditorAssetIdentitySubtitle;

  /// No description provided for @plateEditorAssetNameAr.
  ///
  /// In en, this message translates to:
  /// **'Arabic asset name'**
  String get plateEditorAssetNameAr;

  /// No description provided for @plateEditorAssetNameEn.
  ///
  /// In en, this message translates to:
  /// **'English asset name'**
  String get plateEditorAssetNameEn;

  /// No description provided for @plateEditorAssetSku.
  ///
  /// In en, this message translates to:
  /// **'Asset SKU'**
  String get plateEditorAssetSku;

  /// No description provided for @plateEditorReplacementValue.
  ///
  /// In en, this message translates to:
  /// **'Replacement value'**
  String get plateEditorReplacementValue;

  /// No description provided for @plateEditorStockTitle.
  ///
  /// In en, this message translates to:
  /// **'Stock & Circulation'**
  String get plateEditorStockTitle;

  /// No description provided for @plateEditorStockSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Operational counts used by the return flow.'**
  String get plateEditorStockSubtitle;

  /// No description provided for @plateEditorRequiresDeposit.
  ///
  /// In en, this message translates to:
  /// **'Requires deposit on delivery'**
  String get plateEditorRequiresDeposit;

  /// No description provided for @plateEditorAvailableDelivery.
  ///
  /// In en, this message translates to:
  /// **'Available for delivery orders'**
  String get plateEditorAvailableDelivery;

  /// No description provided for @plateEditorDepositRulesSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Deposit rules for this asset type.'**
  String get plateEditorDepositRulesSubtitle;

  /// No description provided for @plateEditorConditionFeesTitle.
  ///
  /// In en, this message translates to:
  /// **'Condition & Fees'**
  String get plateEditorConditionFeesTitle;

  /// No description provided for @plateEditorConditionFeesSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Used during plated return processing.'**
  String get plateEditorConditionFeesSubtitle;

  /// No description provided for @plateEditorFeeFullBreakage.
  ///
  /// In en, this message translates to:
  /// **'Full breakage fee'**
  String get plateEditorFeeFullBreakage;

  /// No description provided for @plateEditorFeeScratch.
  ///
  /// In en, this message translates to:
  /// **'Scratch / minor damage'**
  String get plateEditorFeeScratch;

  /// No description provided for @plateEditorFeeMissing.
  ///
  /// In en, this message translates to:
  /// **'Missing on return'**
  String get plateEditorFeeMissing;

  /// No description provided for @plateEditorSaveTitle.
  ///
  /// In en, this message translates to:
  /// **'Save Asset'**
  String get plateEditorSaveTitle;

  /// No description provided for @plateEditorSaveSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Save plate settings for the menu.'**
  String get plateEditorSaveSubtitle;

  /// No description provided for @plateEditorSavedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Asset settings saved'**
  String get plateEditorSavedSuccess;

  /// No description provided for @plateEditorBackToPlates.
  ///
  /// In en, this message translates to:
  /// **'Back to plates'**
  String get plateEditorBackToPlates;

  /// No description provided for @adminShowLess.
  ///
  /// In en, this message translates to:
  /// **'Show less'**
  String get adminShowLess;

  /// No description provided for @adminTipRowSubtitle.
  ///
  /// In en, this message translates to:
  /// **'ID: {orderId} · {hours} hrs'**
  String adminTipRowSubtitle(String orderId, String hours);

  /// No description provided for @rbacRoleDefaultsSaved.
  ///
  /// In en, this message translates to:
  /// **'Role defaults saved'**
  String get rbacRoleDefaultsSaved;

  /// No description provided for @rbacNoPendingChanges.
  ///
  /// In en, this message translates to:
  /// **'No pending permission changes to save'**
  String get rbacNoPendingChanges;

  /// No description provided for @rbacResetDefaults.
  ///
  /// In en, this message translates to:
  /// **'Reset defaults'**
  String get rbacResetDefaults;

  /// No description provided for @rbacResetDefaultsSuccess.
  ///
  /// In en, this message translates to:
  /// **'Reset to factory defaults'**
  String get rbacResetDefaultsSuccess;

  /// No description provided for @rbacUsersWithRoleLink.
  ///
  /// In en, this message translates to:
  /// **'{count} users with this role — view list'**
  String rbacUsersWithRoleLink(int count);

  /// No description provided for @reportFilterPageSubtitle.
  ///
  /// In en, this message translates to:
  /// **'The same filter used inside the reports hub, available as a full admin page.'**
  String get reportFilterPageSubtitle;

  /// No description provided for @reviewModerationAlreadyProcessed.
  ///
  /// In en, this message translates to:
  /// **'This review was already moderated.'**
  String get reviewModerationAlreadyProcessed;

  /// No description provided for @reviewModerationRejectConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Reject review?'**
  String get reviewModerationRejectConfirmTitle;

  /// No description provided for @reviewModerationRejectConfirmMessage.
  ///
  /// In en, this message translates to:
  /// **'The review will be hidden from the public menu.'**
  String get reviewModerationRejectConfirmMessage;

  /// No description provided for @reviewModerationFlagConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Flag review?'**
  String get reviewModerationFlagConfirmTitle;

  /// No description provided for @reviewModerationFlagConfirmMessage.
  ///
  /// In en, this message translates to:
  /// **'The review will be marked for support follow-up.'**
  String get reviewModerationFlagConfirmMessage;

  /// No description provided for @supportFaqDeleteConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete FAQ entry?'**
  String get supportFaqDeleteConfirmTitle;

  /// No description provided for @supportFaqDeleteConfirmMessage.
  ///
  /// In en, this message translates to:
  /// **'This entry will be removed from the public FAQ list.'**
  String get supportFaqDeleteConfirmMessage;

  /// No description provided for @supportFaqDeleteBlocked.
  ///
  /// In en, this message translates to:
  /// **'Keep at least one FAQ entry in the editor.'**
  String get supportFaqDeleteBlocked;

  /// No description provided for @supportFaqDeleted.
  ///
  /// In en, this message translates to:
  /// **'FAQ entry removed'**
  String get supportFaqDeleted;

  /// No description provided for @rbacResetConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Reset role defaults?'**
  String get rbacResetConfirmTitle;

  /// No description provided for @rbacResetConfirmMessage.
  ///
  /// In en, this message translates to:
  /// **'All permissions for this role will return to factory defaults.'**
  String get rbacResetConfirmMessage;

  /// No description provided for @rbacAllPermissionsDenied.
  ///
  /// In en, this message translates to:
  /// **'At least one permission must be allowed before saving.'**
  String get rbacAllPermissionsDenied;

  /// No description provided for @adminTipPoolEmpty.
  ///
  /// In en, this message translates to:
  /// **'Tip pool must be greater than zero before approval.'**
  String get adminTipPoolEmpty;

  /// No description provided for @reportFilterAtLeastOneModule.
  ///
  /// In en, this message translates to:
  /// **'Select at least one report module.'**
  String get reportFilterAtLeastOneModule;

  /// No description provided for @marketingBlogUnpublishConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Move post to draft?'**
  String get marketingBlogUnpublishConfirmTitle;

  /// No description provided for @marketingBlogUnpublishConfirmMessage.
  ///
  /// In en, this message translates to:
  /// **'Published posts will no longer appear on the blog.'**
  String get marketingBlogUnpublishConfirmMessage;

  /// No description provided for @marketingBlogDeleteConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete blog post?'**
  String get marketingBlogDeleteConfirmTitle;

  /// No description provided for @marketingBlogDeleteConfirmMessage.
  ///
  /// In en, this message translates to:
  /// **'This removes the post from marketing and the customer blog.'**
  String get marketingBlogDeleteConfirmMessage;

  /// No description provided for @marketingBlogDraftNeedsTitle.
  ///
  /// In en, this message translates to:
  /// **'Add a title before publishing this draft.'**
  String get marketingBlogDraftNeedsTitle;

  /// No description provided for @opsKitchenBoardRefreshed.
  ///
  /// In en, this message translates to:
  /// **'Kitchen pass refreshed.'**
  String get opsKitchenBoardRefreshed;

  /// No description provided for @opsInventoryItemRefreshed.
  ///
  /// In en, this message translates to:
  /// **'Inventory item refreshed.'**
  String get opsInventoryItemRefreshed;

  /// No description provided for @inventoryItemSelectTitle.
  ///
  /// In en, this message translates to:
  /// **'Select an inventory item'**
  String get inventoryItemSelectTitle;

  /// No description provided for @inventoryItemSelectBody.
  ///
  /// In en, this message translates to:
  /// **'Open an alert from the inventory dashboard to review stock, supplier, and adjustment history.'**
  String get inventoryItemSelectBody;

  /// No description provided for @inventoryItemOpenDashboard.
  ///
  /// In en, this message translates to:
  /// **'Open inventory dashboard'**
  String get inventoryItemOpenDashboard;

  /// No description provided for @opsStaffTipsRefreshed.
  ///
  /// In en, this message translates to:
  /// **'Daily tips refreshed.'**
  String get opsStaffTipsRefreshed;

  /// No description provided for @opsCashierHistoryRefreshed.
  ///
  /// In en, this message translates to:
  /// **'Transaction history refreshed.'**
  String get opsCashierHistoryRefreshed;

  /// No description provided for @supportChatPriorityHigh.
  ///
  /// In en, this message translates to:
  /// **'High'**
  String get supportChatPriorityHigh;

  /// No description provided for @supportChatPriorityNormal.
  ///
  /// In en, this message translates to:
  /// **'Normal'**
  String get supportChatPriorityNormal;

  /// No description provided for @supportChatWaitingMinutes.
  ///
  /// In en, this message translates to:
  /// **'Waiting {minutes} min · {id}'**
  String supportChatWaitingMinutes(int minutes, String id);

  /// No description provided for @supportChatAcceptAction.
  ///
  /// In en, this message translates to:
  /// **'Accept chat'**
  String get supportChatAcceptAction;

  /// No description provided for @supportChatAccepted.
  ///
  /// In en, this message translates to:
  /// **'Chat accepted'**
  String get supportChatAccepted;

  /// No description provided for @supportChatAcceptBodyAr.
  ///
  /// In en, this message translates to:
  /// **'محادثة مباشرة مع {customer} ({id})'**
  String supportChatAcceptBodyAr(String customer, String id);

  /// No description provided for @supportChatAcceptBodyEn.
  ///
  /// In en, this message translates to:
  /// **'Live chat with {customer} ({id})'**
  String supportChatAcceptBodyEn(String customer, String id);

  /// No description provided for @supportChatAcceptReplyAr.
  ///
  /// In en, this message translates to:
  /// **'تم قبول المحادثة من قائمة الانتظار.'**
  String get supportChatAcceptReplyAr;

  /// No description provided for @supportChatAcceptReplyEn.
  ///
  /// In en, this message translates to:
  /// **'Chat accepted from the queue.'**
  String get supportChatAcceptReplyEn;

  /// No description provided for @supportChatAcceptFailed.
  ///
  /// In en, this message translates to:
  /// **'Chat is no longer in the queue.'**
  String get supportChatAcceptFailed;

  /// No description provided for @supportOrderLookupReadOnlyBanner.
  ///
  /// In en, this message translates to:
  /// **'Read-only lookup — orders cannot be edited'**
  String get supportOrderLookupReadOnlyBanner;

  /// No description provided for @supportOrderLookupSearchLabel.
  ///
  /// In en, this message translates to:
  /// **'Order # or customer'**
  String get supportOrderLookupSearchLabel;

  /// No description provided for @supportOrderLookupSearchHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. 4821'**
  String get supportOrderLookupSearchHint;

  /// No description provided for @supportOrderLookupNoResults.
  ///
  /// In en, this message translates to:
  /// **'No matching orders'**
  String get supportOrderLookupNoResults;

  /// No description provided for @staffTipHistoryNoData.
  ///
  /// In en, this message translates to:
  /// **'No tip history rows to export for this range.'**
  String get staffTipHistoryNoData;

  /// No description provided for @marketingCalendarSelectDay.
  ///
  /// In en, this message translates to:
  /// **'Select a day on the calendar first.'**
  String get marketingCalendarSelectDay;

  /// No description provided for @marketingCalendarScheduleConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Schedule campaign?'**
  String get marketingCalendarScheduleConfirmTitle;

  /// No description provided for @marketingCalendarScheduleConfirmMessage.
  ///
  /// In en, this message translates to:
  /// **'Adds an internal planning slot only — does not publish to customers.'**
  String get marketingCalendarScheduleConfirmMessage;

  /// No description provided for @marketingCalendarScheduledSuccess.
  ///
  /// In en, this message translates to:
  /// **'Campaign slot scheduled'**
  String get marketingCalendarScheduledSuccess;

  /// No description provided for @marketingPushScheduleConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Schedule push send?'**
  String get marketingPushScheduleConfirmTitle;

  /// No description provided for @marketingPushScheduleConfirmMessage.
  ///
  /// In en, this message translates to:
  /// **'Schedules an in-app customer notification.'**
  String get marketingPushScheduleConfirmMessage;

  /// No description provided for @marketingPushDeleteConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete push campaign?'**
  String get marketingPushDeleteConfirmTitle;

  /// No description provided for @marketingPushDeleteConfirmMessage.
  ///
  /// In en, this message translates to:
  /// **'This removes the draft or scheduled campaign from the marketing list.'**
  String get marketingPushDeleteConfirmMessage;

  /// No description provided for @marketingPushBodyRequired.
  ///
  /// In en, this message translates to:
  /// **'Add notification body text before scheduling.'**
  String get marketingPushBodyRequired;

  /// No description provided for @marketingPushScheduleFailed.
  ///
  /// In en, this message translates to:
  /// **'Campaign draft could not be scheduled.'**
  String get marketingPushScheduleFailed;

  /// No description provided for @opsDeliveryOrderRefreshed.
  ///
  /// In en, this message translates to:
  /// **'Delivery order refreshed.'**
  String get opsDeliveryOrderRefreshed;

  /// No description provided for @marketingSocialMetaBusiness.
  ///
  /// In en, this message translates to:
  /// **'Meta Business'**
  String get marketingSocialMetaBusiness;

  /// No description provided for @marketingSocialInstagramPlatform.
  ///
  /// In en, this message translates to:
  /// **'Instagram'**
  String get marketingSocialInstagramPlatform;

  /// No description provided for @marketingSocialMetaSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Restaurant Facebook page'**
  String get marketingSocialMetaSubtitle;

  /// No description provided for @marketingSocialInstagramSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Posts & reels publishing'**
  String get marketingSocialInstagramSubtitle;

  /// No description provided for @permissionMatrixEmpty.
  ///
  /// In en, this message translates to:
  /// **'No capabilities apply to this role.'**
  String get permissionMatrixEmpty;

  /// No description provided for @permissionAccessFull.
  ///
  /// In en, this message translates to:
  /// **'Full'**
  String get permissionAccessFull;

  /// No description provided for @permissionAccessRead.
  ///
  /// In en, this message translates to:
  /// **'Read'**
  String get permissionAccessRead;

  /// No description provided for @permissionAccessDenied.
  ///
  /// In en, this message translates to:
  /// **'Denied'**
  String get permissionAccessDenied;

  /// No description provided for @permissionAccessPostponed.
  ///
  /// In en, this message translates to:
  /// **'Postponed'**
  String get permissionAccessPostponed;

  /// No description provided for @rbacPostponedUntil.
  ///
  /// In en, this message translates to:
  /// **'Postponed until {date}'**
  String rbacPostponedUntil(String date);

  /// No description provided for @rbacSelectPostponeDate.
  ///
  /// In en, this message translates to:
  /// **'Select postpone date'**
  String get rbacSelectPostponeDate;

  /// No description provided for @rbacPostponeDateRequired.
  ///
  /// In en, this message translates to:
  /// **'Choose a date when postponing access.'**
  String get rbacPostponeDateRequired;

  /// No description provided for @rbacOpenRoleDefaults.
  ///
  /// In en, this message translates to:
  /// **'Open role defaults in Screen A'**
  String get rbacOpenRoleDefaults;

  /// No description provided for @loginDemoModeNotice.
  ///
  /// In en, this message translates to:
  /// **'Use hub shortcuts to open a role workspace.'**
  String get loginDemoModeNotice;

  /// No description provided for @loginDemoSignedIn.
  ///
  /// In en, this message translates to:
  /// **'Signed in successfully.'**
  String get loginDemoSignedIn;

  /// No description provided for @roleSelectionNoApprovedRoles.
  ///
  /// In en, this message translates to:
  /// **'No approved roles yet. Contact your app administrator.'**
  String get roleSelectionNoApprovedRoles;

  /// No description provided for @registerViewTerms.
  ///
  /// In en, this message translates to:
  /// **'View terms'**
  String get registerViewTerms;

  /// No description provided for @rbacRoleGroupManagement.
  ///
  /// In en, this message translates to:
  /// **'Management'**
  String get rbacRoleGroupManagement;

  /// No description provided for @rbacRoleGroupSpecialist.
  ///
  /// In en, this message translates to:
  /// **'Specialist'**
  String get rbacRoleGroupSpecialist;

  /// No description provided for @rbacRoleGroupOperations.
  ///
  /// In en, this message translates to:
  /// **'Operations'**
  String get rbacRoleGroupOperations;

  /// No description provided for @rbacRoleGroupManagementSpecialist.
  ///
  /// In en, this message translates to:
  /// **'Management & specialist'**
  String get rbacRoleGroupManagementSpecialist;

  /// No description provided for @customerDiscountsEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No active discounts'**
  String get customerDiscountsEmptyTitle;

  /// No description provided for @customerDiscountsEmptyBody.
  ///
  /// In en, this message translates to:
  /// **'Check back soon or browse the menu for current offers.'**
  String get customerDiscountsEmptyBody;

  /// No description provided for @customerPromoNotFoundTitle.
  ///
  /// In en, this message translates to:
  /// **'Promotion not found'**
  String get customerPromoNotFoundTitle;

  /// No description provided for @customerPromoNotFoundBody.
  ///
  /// In en, this message translates to:
  /// **'This offer may have expired or been removed.'**
  String get customerPromoNotFoundBody;

  /// No description provided for @promoApplyUnavailable.
  ///
  /// In en, this message translates to:
  /// **'This promotion cannot be applied to your cart right now.'**
  String get promoApplyUnavailable;

  /// No description provided for @permSupportRefunds.
  ///
  /// In en, this message translates to:
  /// **'Order refunds & cancel'**
  String get permSupportRefunds;

  /// No description provided for @permSupportSla.
  ///
  /// In en, this message translates to:
  /// **'SLA & shift handover'**
  String get permSupportSla;

  /// No description provided for @permMarketingMenuPricing.
  ///
  /// In en, this message translates to:
  /// **'Menu price publish'**
  String get permMarketingMenuPricing;

  /// No description provided for @permMarketingPublish.
  ///
  /// In en, this message translates to:
  /// **'Campaign publish'**
  String get permMarketingPublish;

  /// No description provided for @permOperatorCampaignApprove.
  ///
  /// In en, this message translates to:
  /// **'Campaign co-approval'**
  String get permOperatorCampaignApprove;

  /// No description provided for @supportSlaAtRisk.
  ///
  /// In en, this message translates to:
  /// **'SLA at risk'**
  String get supportSlaAtRisk;

  /// No description provided for @supportSlaBreached.
  ///
  /// In en, this message translates to:
  /// **'SLA breached'**
  String get supportSlaBreached;

  /// No description provided for @supportResolvedToday.
  ///
  /// In en, this message translates to:
  /// **'Resolved (24h)'**
  String get supportResolvedToday;

  /// No description provided for @supportAvgResponseTime.
  ///
  /// In en, this message translates to:
  /// **'Avg response'**
  String get supportAvgResponseTime;

  /// No description provided for @supportAvgResponseMinutes.
  ///
  /// In en, this message translates to:
  /// **'{minutes} min'**
  String supportAvgResponseMinutes(int minutes);

  /// No description provided for @supportShiftHandoverTitle.
  ///
  /// In en, this message translates to:
  /// **'Shift handover'**
  String get supportShiftHandoverTitle;

  /// No description provided for @supportShiftHandoverHint.
  ///
  /// In en, this message translates to:
  /// **'Open tickets, blockers, and notes for the next agent…'**
  String get supportShiftHandoverHint;

  /// No description provided for @supportShiftHandoverSaved.
  ///
  /// In en, this message translates to:
  /// **'Handover notes saved'**
  String get supportShiftHandoverSaved;

  /// No description provided for @supportShiftHandoverLast.
  ///
  /// In en, this message translates to:
  /// **'Last handover: {when}'**
  String supportShiftHandoverLast(String when);

  /// No description provided for @supportAgentPerformanceTitle.
  ///
  /// In en, this message translates to:
  /// **'Agent performance (today)'**
  String get supportAgentPerformanceTitle;

  /// No description provided for @supportTicketCustomerPhone.
  ///
  /// In en, this message translates to:
  /// **'Customer phone'**
  String get supportTicketCustomerPhone;

  /// No description provided for @supportTicketCustomerAddress.
  ///
  /// In en, this message translates to:
  /// **'Customer address'**
  String get supportTicketCustomerAddress;

  /// No description provided for @supportTicketEscalateOperator.
  ///
  /// In en, this message translates to:
  /// **'Escalate to Operator'**
  String get supportTicketEscalateOperator;

  /// No description provided for @supportTicketEscalateCashier.
  ///
  /// In en, this message translates to:
  /// **'Escalate to Cashier'**
  String get supportTicketEscalateCashier;

  /// No description provided for @supportTicketEscalated.
  ///
  /// In en, this message translates to:
  /// **'Ticket escalated to {target}'**
  String supportTicketEscalated(String target);

  /// No description provided for @supportOrderLookupActionsBanner.
  ///
  /// In en, this message translates to:
  /// **'Support can issue refunds and cancel orders.'**
  String get supportOrderLookupActionsBanner;

  /// No description provided for @supportOrderRefundAction.
  ///
  /// In en, this message translates to:
  /// **'Issue refund'**
  String get supportOrderRefundAction;

  /// No description provided for @supportOrderCancelAction.
  ///
  /// In en, this message translates to:
  /// **'Cancel order'**
  String get supportOrderCancelAction;

  /// No description provided for @supportOrderRefundConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Issue refund?'**
  String get supportOrderRefundConfirmTitle;

  /// No description provided for @supportOrderRefundConfirmMessage.
  ///
  /// In en, this message translates to:
  /// **'A refund will be logged for audit.'**
  String get supportOrderRefundConfirmMessage;

  /// No description provided for @supportOrderCancelConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Cancel order?'**
  String get supportOrderCancelConfirmTitle;

  /// No description provided for @supportOrderCancelConfirmMessage.
  ///
  /// In en, this message translates to:
  /// **'This marks the order cancelled and logs audit.'**
  String get supportOrderCancelConfirmMessage;

  /// No description provided for @supportOrderRefunded.
  ///
  /// In en, this message translates to:
  /// **'Refund recorded'**
  String get supportOrderRefunded;

  /// No description provided for @supportOrderCancelled.
  ///
  /// In en, this message translates to:
  /// **'Order cancelled'**
  String get supportOrderCancelled;

  /// No description provided for @supportOrderAlreadyCancelled.
  ///
  /// In en, this message translates to:
  /// **'Order is already cancelled'**
  String get supportOrderAlreadyCancelled;

  /// No description provided for @marketingPublishSubmit.
  ///
  /// In en, this message translates to:
  /// **'Submit for operator approval'**
  String get marketingPublishSubmit;

  /// No description provided for @marketingPublishSubmitted.
  ///
  /// In en, this message translates to:
  /// **'Sent to operator for co-approval'**
  String get marketingPublishSubmitted;

  /// No description provided for @marketingPublishPendingTitle.
  ///
  /// In en, this message translates to:
  /// **'Pending operator approval'**
  String get marketingPublishPendingTitle;

  /// No description provided for @marketingOfferActiveToggle.
  ///
  /// In en, this message translates to:
  /// **'Customer visible'**
  String get marketingOfferActiveToggle;

  /// No description provided for @marketingOfferActiveOn.
  ///
  /// In en, this message translates to:
  /// **'Live'**
  String get marketingOfferActiveOn;

  /// No description provided for @marketingOfferActiveOff.
  ///
  /// In en, this message translates to:
  /// **'Hidden'**
  String get marketingOfferActiveOff;

  /// No description provided for @marketingPublishApprove.
  ///
  /// In en, this message translates to:
  /// **'Approve & publish'**
  String get marketingPublishApprove;

  /// No description provided for @marketingPublishReject.
  ///
  /// In en, this message translates to:
  /// **'Reject'**
  String get marketingPublishReject;

  /// No description provided for @marketingPublishApproved.
  ///
  /// In en, this message translates to:
  /// **'Campaign published'**
  String get marketingPublishApproved;

  /// No description provided for @marketingPublishRejected.
  ///
  /// In en, this message translates to:
  /// **'Campaign rejected'**
  String get marketingPublishRejected;

  /// No description provided for @marketingSubscriptionContentOnly.
  ///
  /// In en, this message translates to:
  /// **'Manage subscription content and billing options.'**
  String get marketingSubscriptionContentOnly;

  /// No description provided for @marketingSubscriptionValue.
  ///
  /// In en, this message translates to:
  /// **'Subscription value'**
  String get marketingSubscriptionValue;

  /// No description provided for @marketingSubscriptionMealsTotal.
  ///
  /// In en, this message translates to:
  /// **'{count} meals'**
  String marketingSubscriptionMealsTotal(int count);

  /// No description provided for @marketingSubscriptionRegularSum.
  ///
  /// In en, this message translates to:
  /// **'Regular sum: {amount}'**
  String marketingSubscriptionRegularSum(String amount);

  /// No description provided for @marketingSubscriptionSaving.
  ///
  /// In en, this message translates to:
  /// **'You save: {amount}'**
  String marketingSubscriptionSaving(String amount);

  /// No description provided for @marketingSubscriptionCoverage.
  ///
  /// In en, this message translates to:
  /// **'Meals per day'**
  String get marketingSubscriptionCoverage;

  /// No description provided for @marketingSubscriptionUncovered.
  ///
  /// In en, this message translates to:
  /// **'{count} days without meals'**
  String marketingSubscriptionUncovered(int count);

  /// No description provided for @marketingSubscriptionDayMeals.
  ///
  /// In en, this message translates to:
  /// **'Day {day}: {count} meals'**
  String marketingSubscriptionDayMeals(int day, int count);

  /// No description provided for @marketingSubscriptionFreeDelivery.
  ///
  /// In en, this message translates to:
  /// **'Free delivery'**
  String get marketingSubscriptionFreeDelivery;

  /// No description provided for @marketingSubscriptionEditDay.
  ///
  /// In en, this message translates to:
  /// **'Day {day}'**
  String marketingSubscriptionEditDay(int day);

  /// No description provided for @marketingSubscriptionPickMeals.
  ///
  /// In en, this message translates to:
  /// **'Pick meals for this day'**
  String get marketingSubscriptionPickMeals;

  /// No description provided for @auditEventRefund.
  ///
  /// In en, this message translates to:
  /// **'Refund'**
  String get auditEventRefund;

  /// No description provided for @auditEventOrderCancel.
  ///
  /// In en, this message translates to:
  /// **'Order cancel'**
  String get auditEventOrderCancel;

  /// No description provided for @auditEventPriceChange.
  ///
  /// In en, this message translates to:
  /// **'Price change'**
  String get auditEventPriceChange;

  /// No description provided for @auditEventOfferPublished.
  ///
  /// In en, this message translates to:
  /// **'Offer published'**
  String get auditEventOfferPublished;

  /// No description provided for @marketingMenuPricePublishTitle.
  ///
  /// In en, this message translates to:
  /// **'Menu price publish'**
  String get marketingMenuPricePublishTitle;

  /// No description provided for @marketingMenuPricePublishBanner.
  ///
  /// In en, this message translates to:
  /// **'Marketing can update base menu prices. Each change is logged for operator audit before publish.'**
  String get marketingMenuPricePublishBanner;

  /// No description provided for @operatorEscalationsInboxTitle.
  ///
  /// In en, this message translates to:
  /// **'Support escalations'**
  String get operatorEscalationsInboxTitle;

  /// No description provided for @operatorEscalationsInboxSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Tickets escalated from Support — refund, cancel, or policy requests'**
  String get operatorEscalationsInboxSubtitle;

  /// No description provided for @operatorEscalationAcknowledge.
  ///
  /// In en, this message translates to:
  /// **'Acknowledge'**
  String get operatorEscalationAcknowledge;

  /// No description provided for @operatorEscalationAcknowledged.
  ///
  /// In en, this message translates to:
  /// **'Escalation acknowledged'**
  String get operatorEscalationAcknowledged;

  /// No description provided for @operatorEscalationOpenTicket.
  ///
  /// In en, this message translates to:
  /// **'Open ticket'**
  String get operatorEscalationOpenTicket;

  /// No description provided for @operatorEscalationTarget.
  ///
  /// In en, this message translates to:
  /// **'Escalated to {target}'**
  String operatorEscalationTarget(String target);

  /// No description provided for @marketingHomeOpsTitle.
  ///
  /// In en, this message translates to:
  /// **'Today’s marketing pulse'**
  String get marketingHomeOpsTitle;

  /// No description provided for @marketingVisitorsToday.
  ///
  /// In en, this message translates to:
  /// **'Visitors today'**
  String get marketingVisitorsToday;

  /// No description provided for @marketingPurchasesToday.
  ///
  /// In en, this message translates to:
  /// **'Purchases today'**
  String get marketingPurchasesToday;

  /// No description provided for @marketingActiveCampaigns.
  ///
  /// In en, this message translates to:
  /// **'Active campaigns'**
  String get marketingActiveCampaigns;

  /// No description provided for @marketingTopSellers.
  ///
  /// In en, this message translates to:
  /// **'Top 10 purchasing items'**
  String get marketingTopSellers;

  /// No description provided for @marketingTopRatings.
  ///
  /// In en, this message translates to:
  /// **'Top ratings'**
  String get marketingTopRatings;

  /// No description provided for @marketingPendingApprovals.
  ///
  /// In en, this message translates to:
  /// **'{count} need approval'**
  String marketingPendingApprovals(int count);

  /// No description provided for @marketingSocialInteractions.
  ///
  /// In en, this message translates to:
  /// **'Social interactions'**
  String get marketingSocialInteractions;

  /// No description provided for @marketingInsightFilterAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get marketingInsightFilterAll;

  /// No description provided for @marketingInsightFilterPending.
  ///
  /// In en, this message translates to:
  /// **'Pending approval'**
  String get marketingInsightFilterPending;

  /// No description provided for @marketingInsightFilterApproved.
  ///
  /// In en, this message translates to:
  /// **'Approved'**
  String get marketingInsightFilterApproved;

  /// No description provided for @marketingInsightOpenEdit.
  ///
  /// In en, this message translates to:
  /// **'Open editor'**
  String get marketingInsightOpenEdit;

  /// No description provided for @marketingInsightPurchasesHint.
  ///
  /// In en, this message translates to:
  /// **'Filter by day range — tap a row for related product'**
  String get marketingInsightPurchasesHint;

  /// No description provided for @marketingInsightVisitorsHint.
  ///
  /// In en, this message translates to:
  /// **'Visitor volume by segment — tap for related campaign'**
  String get marketingInsightVisitorsHint;

  /// No description provided for @marketingProductSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search product by name'**
  String get marketingProductSearchHint;

  /// No description provided for @marketingDiscountProductPoints.
  ///
  /// In en, this message translates to:
  /// **'Product points (locked)'**
  String get marketingDiscountProductPoints;

  /// No description provided for @marketingProductCreate.
  ///
  /// In en, this message translates to:
  /// **'Create product'**
  String get marketingProductCreate;

  /// No description provided for @marketingProductPreviewTab.
  ///
  /// In en, this message translates to:
  /// **'Preview'**
  String get marketingProductPreviewTab;

  /// No description provided for @marketingProductDetailsTitle.
  ///
  /// In en, this message translates to:
  /// **'Product details'**
  String get marketingProductDetailsTitle;

  /// No description provided for @marketingLoyaltyCreateSheetTitle.
  ///
  /// In en, this message translates to:
  /// **'New loyalty occasion'**
  String get marketingLoyaltyCreateSheetTitle;

  /// No description provided for @marketingSocialMonitorTitle.
  ///
  /// In en, this message translates to:
  /// **'Social monitoring'**
  String get marketingSocialMonitorTitle;

  /// No description provided for @marketingSocialUsers.
  ///
  /// In en, this message translates to:
  /// **'Users'**
  String get marketingSocialUsers;

  /// No description provided for @marketingSocialBlogs.
  ///
  /// In en, this message translates to:
  /// **'Blogs'**
  String get marketingSocialBlogs;

  /// No description provided for @marketingSocialActionsToday.
  ///
  /// In en, this message translates to:
  /// **'Actions today'**
  String get marketingSocialActionsToday;

  /// No description provided for @marketingSocialActionsWeek.
  ///
  /// In en, this message translates to:
  /// **'Actions this week'**
  String get marketingSocialActionsWeek;

  /// No description provided for @marketingSocialNoIntegration.
  ///
  /// In en, this message translates to:
  /// **'Monitoring only — app integrations are managed elsewhere.'**
  String get marketingSocialNoIntegration;

  /// No description provided for @marketingPromoCodesTitle.
  ///
  /// In en, this message translates to:
  /// **'Promotion codes'**
  String get marketingPromoCodesTitle;

  /// No description provided for @marketingPromoCodeCreate.
  ///
  /// In en, this message translates to:
  /// **'Create promo code'**
  String get marketingPromoCodeCreate;

  /// No description provided for @marketingPromoCodeValue.
  ///
  /// In en, this message translates to:
  /// **'Code'**
  String get marketingPromoCodeValue;

  /// No description provided for @marketingPromoCodeCategory.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get marketingPromoCodeCategory;

  /// No description provided for @marketingPromoCategoryDiscount.
  ///
  /// In en, this message translates to:
  /// **'Discount'**
  String get marketingPromoCategoryDiscount;

  /// No description provided for @marketingPromoCategoryAddPoints.
  ///
  /// In en, this message translates to:
  /// **'Add points'**
  String get marketingPromoCategoryAddPoints;

  /// No description provided for @marketingPromoCategoryFreeMeal.
  ///
  /// In en, this message translates to:
  /// **'Free meal'**
  String get marketingPromoCategoryFreeMeal;

  /// No description provided for @marketingPromoCategoryInviteFriends.
  ///
  /// In en, this message translates to:
  /// **'Invite friends'**
  String get marketingPromoCategoryInviteFriends;

  /// No description provided for @marketingBlogPlatforms.
  ///
  /// In en, this message translates to:
  /// **'Posted to'**
  String get marketingBlogPlatforms;

  /// No description provided for @marketingBlogPickPlatforms.
  ///
  /// In en, this message translates to:
  /// **'Social platforms'**
  String get marketingBlogPickPlatforms;

  /// No description provided for @brandingSettingsTitle.
  ///
  /// In en, this message translates to:
  /// **'App branding'**
  String get brandingSettingsTitle;

  /// No description provided for @brandingSettingsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Name, slogan, and logo shown on splash and login (EN + AR).'**
  String get brandingSettingsSubtitle;

  /// No description provided for @brandingNameEn.
  ///
  /// In en, this message translates to:
  /// **'App name (English)'**
  String get brandingNameEn;

  /// No description provided for @brandingNameAr.
  ///
  /// In en, this message translates to:
  /// **'App name (Arabic)'**
  String get brandingNameAr;

  /// No description provided for @brandingSloganEn.
  ///
  /// In en, this message translates to:
  /// **'Slogan (English)'**
  String get brandingSloganEn;

  /// No description provided for @brandingSloganAr.
  ///
  /// In en, this message translates to:
  /// **'Slogan (Arabic)'**
  String get brandingSloganAr;

  /// No description provided for @brandingLogoUrl.
  ///
  /// In en, this message translates to:
  /// **'Logo image URL'**
  String get brandingLogoUrl;

  /// No description provided for @brandingLogoUrlHint.
  ///
  /// In en, this message translates to:
  /// **'Leave empty for default logo'**
  String get brandingLogoUrlHint;

  /// No description provided for @brandingSave.
  ///
  /// In en, this message translates to:
  /// **'Save branding'**
  String get brandingSave;

  /// No description provided for @brandingReset.
  ///
  /// In en, this message translates to:
  /// **'Reset to defaults'**
  String get brandingReset;

  /// No description provided for @brandingSaved.
  ///
  /// In en, this message translates to:
  /// **'Branding updated'**
  String get brandingSaved;

  /// No description provided for @drawerGroupHub.
  ///
  /// In en, this message translates to:
  /// **'Hub'**
  String get drawerGroupHub;

  /// No description provided for @drawerGroupOrders.
  ///
  /// In en, this message translates to:
  /// **'Orders'**
  String get drawerGroupOrders;

  /// No description provided for @drawerGroupMenu.
  ///
  /// In en, this message translates to:
  /// **'Menu'**
  String get drawerGroupMenu;

  /// No description provided for @drawerGroupPeople.
  ///
  /// In en, this message translates to:
  /// **'People'**
  String get drawerGroupPeople;

  /// No description provided for @drawerGroupMoney.
  ///
  /// In en, this message translates to:
  /// **'Money'**
  String get drawerGroupMoney;

  /// No description provided for @drawerGroupSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get drawerGroupSettings;

  /// No description provided for @drawerGroupPromotions.
  ///
  /// In en, this message translates to:
  /// **'Promotions'**
  String get drawerGroupPromotions;

  /// No description provided for @drawerGroupCatalog.
  ///
  /// In en, this message translates to:
  /// **'Catalog'**
  String get drawerGroupCatalog;

  /// No description provided for @drawerGroupLoyalty.
  ///
  /// In en, this message translates to:
  /// **'Loyalty'**
  String get drawerGroupLoyalty;

  /// No description provided for @drawerGroupContent.
  ///
  /// In en, this message translates to:
  /// **'Content'**
  String get drawerGroupContent;

  /// No description provided for @cartMoreFulfillmentOptions.
  ///
  /// In en, this message translates to:
  /// **'More delivery options'**
  String get cartMoreFulfillmentOptions;

  /// No description provided for @cartHideFulfillmentOptions.
  ///
  /// In en, this message translates to:
  /// **'Show fewer options'**
  String get cartHideFulfillmentOptions;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}

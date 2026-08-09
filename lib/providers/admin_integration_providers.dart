import 'package:flutter_riverpod/flutter_riverpod.dart';

enum AdminIntegrationSection {
  supabase,
  sms,
  whatsapp,
  telephony,
  payments,
  ai,
  attendanceWifi,
  other,
}

/// Operator-editable integration credentials (mock session → `app_settings` in production).
class AdminIntegrationConfigState {
  const AdminIntegrationConfigState({
    this.supabaseUrl = '',
    this.supabaseAnonKey = '',
    this.supabaseServiceRoleKey = '',
    this.supabaseProjectRef = '',
    this.smsProvider = '',
    this.smsApiKey = '',
    this.smsSenderId = '',
    this.smsApiUrl = '',
    this.whatsappBusinessAccountId = '',
    this.whatsappPhoneNumberId = '',
    this.whatsappAccessToken = '',
    this.whatsappWebhookVerifyToken = '',
    this.supportPhoneNumber = '',
    this.defaultCountryCode = '+962',
    this.otpSenderNumber = '',
    this.paymentGatewayProvider = '',
    this.stripePublishableKey = '',
    this.stripeSecretKey = '',
    this.stripeWebhookSecret = '',
    this.googlePayMerchantId = '',
    this.googlePayMerchantName = '',
    this.applePayMerchantId = '',
    this.paymentGatewayApiKey = '',
    this.paymentGatewayMerchantId = '',
    this.paymentGatewayWebhookUrl = '',
    this.walletProviderName = '',
    this.walletAppId = '',
    this.walletDeepLinkScheme = '',
    this.walletWebhookSecret = '',
    this.aiProvider = '',
    this.aiApiKey = '',
    this.aiModelName = '',
    this.aiBaseUrl = '',
    this.aiSupportChatEnabled = false,
    this.googleMapsApiKey = '',
    this.fcmServerKey = '',
    this.emailProvider = '',
    this.emailApiKey = '',
    this.emailFromAddress = '',
    this.sentryDsn = '',
    this.restaurantWifiSsid = '',
    this.restaurantWifiBssid = '',
    this.restaurantWifiGatewayIp = '',
    this.restaurantBranchLabel = '',
    this.lastSavedAt,
    this.lastTestedSection,
  });

  final String supabaseUrl;
  final String supabaseAnonKey;
  final String supabaseServiceRoleKey;
  final String supabaseProjectRef;
  final String smsProvider;
  final String smsApiKey;
  final String smsSenderId;
  final String smsApiUrl;
  final String whatsappBusinessAccountId;
  final String whatsappPhoneNumberId;
  final String whatsappAccessToken;
  final String whatsappWebhookVerifyToken;
  final String supportPhoneNumber;
  final String defaultCountryCode;
  final String otpSenderNumber;
  final String paymentGatewayProvider;
  final String stripePublishableKey;
  final String stripeSecretKey;
  final String stripeWebhookSecret;
  final String googlePayMerchantId;
  final String googlePayMerchantName;
  final String applePayMerchantId;
  final String paymentGatewayApiKey;
  final String paymentGatewayMerchantId;
  final String paymentGatewayWebhookUrl;
  final String walletProviderName;
  final String walletAppId;
  final String walletDeepLinkScheme;
  final String walletWebhookSecret;
  final String aiProvider;
  final String aiApiKey;
  final String aiModelName;
  final String aiBaseUrl;
  final bool aiSupportChatEnabled;
  final String googleMapsApiKey;
  final String fcmServerKey;
  final String emailProvider;
  final String emailApiKey;
  final String emailFromAddress;
  final String sentryDsn;
  final String restaurantWifiSsid;
  final String restaurantWifiBssid;
  final String restaurantWifiGatewayIp;
  final String restaurantBranchLabel;
  final DateTime? lastSavedAt;
  final AdminIntegrationSection? lastTestedSection;

  bool isSectionConfigured(AdminIntegrationSection section) {
    return switch (section) {
      AdminIntegrationSection.supabase =>
        supabaseUrl.trim().isNotEmpty && supabaseAnonKey.trim().isNotEmpty,
      AdminIntegrationSection.sms =>
        smsProvider.trim().isNotEmpty &&
            smsApiKey.trim().isNotEmpty &&
            smsSenderId.trim().isNotEmpty,
      AdminIntegrationSection.whatsapp =>
        whatsappPhoneNumberId.trim().isNotEmpty &&
            whatsappAccessToken.trim().isNotEmpty,
      AdminIntegrationSection.telephony =>
        supportPhoneNumber.trim().isNotEmpty &&
            defaultCountryCode.trim().isNotEmpty,
      AdminIntegrationSection.payments =>
        paymentGatewayProvider.trim().isNotEmpty &&
            (stripePublishableKey.trim().isNotEmpty ||
                paymentGatewayApiKey.trim().isNotEmpty),
      AdminIntegrationSection.ai =>
        aiProvider.trim().isNotEmpty && aiApiKey.trim().isNotEmpty,
      AdminIntegrationSection.attendanceWifi =>
        restaurantWifiSsid.trim().isNotEmpty &&
            restaurantWifiBssid.trim().isNotEmpty,
      AdminIntegrationSection.other =>
        googleMapsApiKey.trim().isNotEmpty ||
            fcmServerKey.trim().isNotEmpty ||
            emailApiKey.trim().isNotEmpty,
    };
  }

  AdminIntegrationConfigState copyWith({
    String? supabaseUrl,
    String? supabaseAnonKey,
    String? supabaseServiceRoleKey,
    String? supabaseProjectRef,
    String? smsProvider,
    String? smsApiKey,
    String? smsSenderId,
    String? smsApiUrl,
    String? whatsappBusinessAccountId,
    String? whatsappPhoneNumberId,
    String? whatsappAccessToken,
    String? whatsappWebhookVerifyToken,
    String? supportPhoneNumber,
    String? defaultCountryCode,
    String? otpSenderNumber,
    String? paymentGatewayProvider,
    String? stripePublishableKey,
    String? stripeSecretKey,
    String? stripeWebhookSecret,
    String? googlePayMerchantId,
    String? googlePayMerchantName,
    String? applePayMerchantId,
    String? paymentGatewayApiKey,
    String? paymentGatewayMerchantId,
    String? paymentGatewayWebhookUrl,
    String? walletProviderName,
    String? walletAppId,
    String? walletDeepLinkScheme,
    String? walletWebhookSecret,
    String? aiProvider,
    String? aiApiKey,
    String? aiModelName,
    String? aiBaseUrl,
    bool? aiSupportChatEnabled,
    String? googleMapsApiKey,
    String? fcmServerKey,
    String? emailProvider,
    String? emailApiKey,
    String? emailFromAddress,
    String? sentryDsn,
    String? restaurantWifiSsid,
    String? restaurantWifiBssid,
    String? restaurantWifiGatewayIp,
    String? restaurantBranchLabel,
    DateTime? lastSavedAt,
    AdminIntegrationSection? lastTestedSection,
    bool clearLastTestedSection = false,
  }) {
    return AdminIntegrationConfigState(
      supabaseUrl: supabaseUrl ?? this.supabaseUrl,
      supabaseAnonKey: supabaseAnonKey ?? this.supabaseAnonKey,
      supabaseServiceRoleKey:
          supabaseServiceRoleKey ?? this.supabaseServiceRoleKey,
      supabaseProjectRef: supabaseProjectRef ?? this.supabaseProjectRef,
      smsProvider: smsProvider ?? this.smsProvider,
      smsApiKey: smsApiKey ?? this.smsApiKey,
      smsSenderId: smsSenderId ?? this.smsSenderId,
      smsApiUrl: smsApiUrl ?? this.smsApiUrl,
      whatsappBusinessAccountId:
          whatsappBusinessAccountId ?? this.whatsappBusinessAccountId,
      whatsappPhoneNumberId:
          whatsappPhoneNumberId ?? this.whatsappPhoneNumberId,
      whatsappAccessToken: whatsappAccessToken ?? this.whatsappAccessToken,
      whatsappWebhookVerifyToken:
          whatsappWebhookVerifyToken ?? this.whatsappWebhookVerifyToken,
      supportPhoneNumber: supportPhoneNumber ?? this.supportPhoneNumber,
      defaultCountryCode: defaultCountryCode ?? this.defaultCountryCode,
      otpSenderNumber: otpSenderNumber ?? this.otpSenderNumber,
      paymentGatewayProvider:
          paymentGatewayProvider ?? this.paymentGatewayProvider,
      stripePublishableKey: stripePublishableKey ?? this.stripePublishableKey,
      stripeSecretKey: stripeSecretKey ?? this.stripeSecretKey,
      stripeWebhookSecret: stripeWebhookSecret ?? this.stripeWebhookSecret,
      googlePayMerchantId: googlePayMerchantId ?? this.googlePayMerchantId,
      googlePayMerchantName:
          googlePayMerchantName ?? this.googlePayMerchantName,
      applePayMerchantId: applePayMerchantId ?? this.applePayMerchantId,
      paymentGatewayApiKey: paymentGatewayApiKey ?? this.paymentGatewayApiKey,
      paymentGatewayMerchantId:
          paymentGatewayMerchantId ?? this.paymentGatewayMerchantId,
      paymentGatewayWebhookUrl:
          paymentGatewayWebhookUrl ?? this.paymentGatewayWebhookUrl,
      walletProviderName: walletProviderName ?? this.walletProviderName,
      walletAppId: walletAppId ?? this.walletAppId,
      walletDeepLinkScheme: walletDeepLinkScheme ?? this.walletDeepLinkScheme,
      walletWebhookSecret: walletWebhookSecret ?? this.walletWebhookSecret,
      aiProvider: aiProvider ?? this.aiProvider,
      aiApiKey: aiApiKey ?? this.aiApiKey,
      aiModelName: aiModelName ?? this.aiModelName,
      aiBaseUrl: aiBaseUrl ?? this.aiBaseUrl,
      aiSupportChatEnabled: aiSupportChatEnabled ?? this.aiSupportChatEnabled,
      googleMapsApiKey: googleMapsApiKey ?? this.googleMapsApiKey,
      fcmServerKey: fcmServerKey ?? this.fcmServerKey,
      emailProvider: emailProvider ?? this.emailProvider,
      emailApiKey: emailApiKey ?? this.emailApiKey,
      emailFromAddress: emailFromAddress ?? this.emailFromAddress,
      sentryDsn: sentryDsn ?? this.sentryDsn,
      restaurantWifiSsid: restaurantWifiSsid ?? this.restaurantWifiSsid,
      restaurantWifiBssid: restaurantWifiBssid ?? this.restaurantWifiBssid,
      restaurantWifiGatewayIp:
          restaurantWifiGatewayIp ?? this.restaurantWifiGatewayIp,
      restaurantBranchLabel:
          restaurantBranchLabel ?? this.restaurantBranchLabel,
      lastSavedAt: lastSavedAt ?? this.lastSavedAt,
      lastTestedSection:
          clearLastTestedSection
              ? null
              : (lastTestedSection ?? this.lastTestedSection),
    );
  }
}

class AdminIntegrationConfigNotifier
    extends StateNotifier<AdminIntegrationConfigState> {
  AdminIntegrationConfigNotifier() : super(const AdminIntegrationConfigState());

  void replaceAll(AdminIntegrationConfigState next) {
    state = next;
  }

  void save() {
    state = state.copyWith(lastSavedAt: DateTime.now());
  }

  bool testSection(AdminIntegrationSection section) {
    if (!state.isSectionConfigured(section)) {
      return false;
    }
    state = state.copyWith(lastTestedSection: section);
    return true;
  }
}

final adminIntegrationConfigProvider = StateNotifierProvider<
  AdminIntegrationConfigNotifier,
  AdminIntegrationConfigState
>((ref) => AdminIntegrationConfigNotifier());

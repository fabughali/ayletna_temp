import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:ayletna_restaurant_app/navigation/app_route_paths.dart';
import 'package:ayletna_restaurant_app/providers/admin_integration_providers.dart';
import 'package:ayletna_restaurant_app/utilities/utility_mock_feedback.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_text_field.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_icon_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_info_banner.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_refresh_list.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_scaffold_page.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_status_pill.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// PRD §13 / §18.6 — operator fills integration credentials without touching code.
class AdminAppIntegrationsScreen extends ConsumerStatefulWidget {
  const AdminAppIntegrationsScreen({super.key});

  @override
  ConsumerState<AdminAppIntegrationsScreen> createState() =>
      _AdminAppIntegrationsScreenState();
}

class _AdminAppIntegrationsScreenState
    extends ConsumerState<AdminAppIntegrationsScreen> {
  late final Map<String, TextEditingController> _controllers;
  bool _aiSupportChatEnabled = false;

  @override
  void initState() {
    super.initState();
    final config = ref.read(adminIntegrationConfigProvider);
    _aiSupportChatEnabled = config.aiSupportChatEnabled;
    _controllers = {
      'supabaseUrl': TextEditingController(text: config.supabaseUrl),
      'supabaseAnonKey': TextEditingController(text: config.supabaseAnonKey),
      'supabaseServiceRoleKey':
          TextEditingController(text: config.supabaseServiceRoleKey),
      'supabaseProjectRef':
          TextEditingController(text: config.supabaseProjectRef),
      'smsProvider': TextEditingController(text: config.smsProvider),
      'smsApiKey': TextEditingController(text: config.smsApiKey),
      'smsSenderId': TextEditingController(text: config.smsSenderId),
      'smsApiUrl': TextEditingController(text: config.smsApiUrl),
      'whatsappBusinessAccountId':
          TextEditingController(text: config.whatsappBusinessAccountId),
      'whatsappPhoneNumberId':
          TextEditingController(text: config.whatsappPhoneNumberId),
      'whatsappAccessToken':
          TextEditingController(text: config.whatsappAccessToken),
      'whatsappWebhookVerifyToken':
          TextEditingController(text: config.whatsappWebhookVerifyToken),
      'supportPhoneNumber':
          TextEditingController(text: config.supportPhoneNumber),
      'defaultCountryCode':
          TextEditingController(text: config.defaultCountryCode),
      'otpSenderNumber': TextEditingController(text: config.otpSenderNumber),
      'paymentGatewayProvider':
          TextEditingController(text: config.paymentGatewayProvider),
      'stripePublishableKey':
          TextEditingController(text: config.stripePublishableKey),
      'stripeSecretKey': TextEditingController(text: config.stripeSecretKey),
      'stripeWebhookSecret':
          TextEditingController(text: config.stripeWebhookSecret),
      'googlePayMerchantId':
          TextEditingController(text: config.googlePayMerchantId),
      'googlePayMerchantName':
          TextEditingController(text: config.googlePayMerchantName),
      'applePayMerchantId':
          TextEditingController(text: config.applePayMerchantId),
      'paymentGatewayApiKey':
          TextEditingController(text: config.paymentGatewayApiKey),
      'paymentGatewayMerchantId':
          TextEditingController(text: config.paymentGatewayMerchantId),
      'paymentGatewayWebhookUrl':
          TextEditingController(text: config.paymentGatewayWebhookUrl),
      'walletProviderName':
          TextEditingController(text: config.walletProviderName),
      'walletAppId': TextEditingController(text: config.walletAppId),
      'walletDeepLinkScheme':
          TextEditingController(text: config.walletDeepLinkScheme),
      'walletWebhookSecret':
          TextEditingController(text: config.walletWebhookSecret),
      'aiProvider': TextEditingController(text: config.aiProvider),
      'aiApiKey': TextEditingController(text: config.aiApiKey),
      'aiModelName': TextEditingController(text: config.aiModelName),
      'aiBaseUrl': TextEditingController(text: config.aiBaseUrl),
      'googleMapsApiKey':
          TextEditingController(text: config.googleMapsApiKey),
      'fcmServerKey': TextEditingController(text: config.fcmServerKey),
      'emailProvider': TextEditingController(text: config.emailProvider),
      'emailApiKey': TextEditingController(text: config.emailApiKey),
      'emailFromAddress':
          TextEditingController(text: config.emailFromAddress),
      'sentryDsn': TextEditingController(text: config.sentryDsn),
      'restaurantWifiSsid':
          TextEditingController(text: config.restaurantWifiSsid),
      'restaurantWifiBssid':
          TextEditingController(text: config.restaurantWifiBssid),
      'restaurantWifiGatewayIp':
          TextEditingController(text: config.restaurantWifiGatewayIp),
      'restaurantBranchLabel':
          TextEditingController(text: config.restaurantBranchLabel),
    };
  }

  @override
  void dispose() {
    for (final controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  AdminIntegrationConfigState _readDraft() {
    return AdminIntegrationConfigState(
      supabaseUrl: _controllers['supabaseUrl']!.text.trim(),
      supabaseAnonKey: _controllers['supabaseAnonKey']!.text.trim(),
      supabaseServiceRoleKey:
          _controllers['supabaseServiceRoleKey']!.text.trim(),
      supabaseProjectRef: _controllers['supabaseProjectRef']!.text.trim(),
      smsProvider: _controllers['smsProvider']!.text.trim(),
      smsApiKey: _controllers['smsApiKey']!.text.trim(),
      smsSenderId: _controllers['smsSenderId']!.text.trim(),
      smsApiUrl: _controllers['smsApiUrl']!.text.trim(),
      whatsappBusinessAccountId:
          _controllers['whatsappBusinessAccountId']!.text.trim(),
      whatsappPhoneNumberId:
          _controllers['whatsappPhoneNumberId']!.text.trim(),
      whatsappAccessToken: _controllers['whatsappAccessToken']!.text.trim(),
      whatsappWebhookVerifyToken:
          _controllers['whatsappWebhookVerifyToken']!.text.trim(),
      supportPhoneNumber: _controllers['supportPhoneNumber']!.text.trim(),
      defaultCountryCode: _controllers['defaultCountryCode']!.text.trim(),
      otpSenderNumber: _controllers['otpSenderNumber']!.text.trim(),
      paymentGatewayProvider:
          _controllers['paymentGatewayProvider']!.text.trim(),
      stripePublishableKey: _controllers['stripePublishableKey']!.text.trim(),
      stripeSecretKey: _controllers['stripeSecretKey']!.text.trim(),
      stripeWebhookSecret: _controllers['stripeWebhookSecret']!.text.trim(),
      googlePayMerchantId: _controllers['googlePayMerchantId']!.text.trim(),
      googlePayMerchantName:
          _controllers['googlePayMerchantName']!.text.trim(),
      applePayMerchantId: _controllers['applePayMerchantId']!.text.trim(),
      paymentGatewayApiKey: _controllers['paymentGatewayApiKey']!.text.trim(),
      paymentGatewayMerchantId:
          _controllers['paymentGatewayMerchantId']!.text.trim(),
      paymentGatewayWebhookUrl:
          _controllers['paymentGatewayWebhookUrl']!.text.trim(),
      walletProviderName: _controllers['walletProviderName']!.text.trim(),
      walletAppId: _controllers['walletAppId']!.text.trim(),
      walletDeepLinkScheme: _controllers['walletDeepLinkScheme']!.text.trim(),
      walletWebhookSecret: _controllers['walletWebhookSecret']!.text.trim(),
      aiProvider: _controllers['aiProvider']!.text.trim(),
      aiApiKey: _controllers['aiApiKey']!.text.trim(),
      aiModelName: _controllers['aiModelName']!.text.trim(),
      aiBaseUrl: _controllers['aiBaseUrl']!.text.trim(),
      aiSupportChatEnabled: _aiSupportChatEnabled,
      googleMapsApiKey: _controllers['googleMapsApiKey']!.text.trim(),
      fcmServerKey: _controllers['fcmServerKey']!.text.trim(),
      emailProvider: _controllers['emailProvider']!.text.trim(),
      emailApiKey: _controllers['emailApiKey']!.text.trim(),
      emailFromAddress: _controllers['emailFromAddress']!.text.trim(),
      sentryDsn: _controllers['sentryDsn']!.text.trim(),
      restaurantWifiSsid: _controllers['restaurantWifiSsid']!.text.trim(),
      restaurantWifiBssid: _controllers['restaurantWifiBssid']!.text.trim(),
      restaurantWifiGatewayIp:
          _controllers['restaurantWifiGatewayIp']!.text.trim(),
      restaurantBranchLabel:
          _controllers['restaurantBranchLabel']!.text.trim(),
    );
  }

  void _saveAll() {
    final l10n = AppLocalizations.of(context)!;
    ref.read(adminIntegrationConfigProvider.notifier).replaceAll(_readDraft());
    ref.read(adminIntegrationConfigProvider.notifier).save();
    UtilityMockFeedback.showSuccess(context, l10n.integrationsSaveSuccess);
    setState(() {});
  }

  void _testSection(AdminIntegrationSection section) {
    final l10n = AppLocalizations.of(context)!;
    ref.read(adminIntegrationConfigProvider.notifier).replaceAll(_readDraft());
    final ok = ref
        .read(adminIntegrationConfigProvider.notifier)
        .testSection(section);
    if (ok) {
      UtilityMockFeedback.showSuccess(context, l10n.integrationsTestSuccess);
    } else {
      UtilityMockFeedback.showError(context, l10n.integrationsTestIncomplete);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final config = ref.watch(adminIntegrationConfigProvider);
    final scheme = Theme.of(context).colorScheme;

    return WidgetsScaffoldPage(
      title: l10n.screenAppIntegrations,
      actions: [
        WidgetsIconButton(
          onPressed: () => context.push(AppRoutePaths.adminSettings),
          icon: Icons.settings_outlined,
          tooltip: l10n.screenSettings,
        ),
      ],
      child: WidgetsRefreshList(
        onRefresh: () async {
          await Future<void>.delayed(const Duration(milliseconds: 300));
        },
        child: ListView(
          padding: EdgeInsetsDirectional.only(
            top: CoreSpacing.md(context),
            bottom: CoreSpacing.xxl(context),
          ),
          children: [
            WidgetsInfoBanner(
              tone: WidgetsInfoBannerTone.info,
              message: l10n.integrationsSecurityNote,
            ),
            SizedBox(height: CoreSpacing.lg(context)),
            _IntegrationSectionCard(
              title: l10n.integrationsSupabaseTitle,
              subtitle: l10n.integrationsSupabaseSubtitle,
              icon: Icons.cloud_outlined,
              accent: CoreColors.orderTypeDelivery,
              configured: config.isSectionConfigured(
                AdminIntegrationSection.supabase,
              ),
              onTest: () => _testSection(AdminIntegrationSection.supabase),
              children: [
                _secretField(
                  l10n.integrationsSupabaseUrl,
                  'supabaseUrl',
                  hint: l10n.integrationsSupabaseUrlHint,
                  icon: Icons.link,
                ),
                _secretField(
                  l10n.integrationsSupabaseAnonKey,
                  'supabaseAnonKey',
                  hint: l10n.integrationsSupabaseAnonKeyHint,
                  icon: Icons.vpn_key_outlined,
                  obscure: true,
                ),
                _secretField(
                  l10n.integrationsSupabaseServiceRoleKey,
                  'supabaseServiceRoleKey',
                  hint: l10n.integrationsSupabaseServiceRoleKeyHint,
                  icon: Icons.admin_panel_settings_outlined,
                  obscure: true,
                ),
                _secretField(
                  l10n.integrationsSupabaseProjectRef,
                  'supabaseProjectRef',
                  hint: l10n.integrationsSupabaseProjectRefHint,
                  icon: Icons.tag_outlined,
                ),
              ],
            ),
            _IntegrationSectionCard(
              title: l10n.integrationsSmsTitle,
              subtitle: l10n.integrationsSmsSubtitle,
              icon: Icons.sms_outlined,
              accent: CoreColors.brandOlive,
              configured: config.isSectionConfigured(
                AdminIntegrationSection.sms,
              ),
              onTest: () => _testSection(AdminIntegrationSection.sms),
              children: [
                _secretField(
                  l10n.integrationsSmsProvider,
                  'smsProvider',
                  hint: l10n.integrationsSmsProviderHint,
                  icon: Icons.business_outlined,
                ),
                _secretField(
                  l10n.integrationsSmsApiKey,
                  'smsApiKey',
                  hint: l10n.integrationsSmsApiKeyHint,
                  icon: Icons.key_outlined,
                  obscure: true,
                ),
                _secretField(
                  l10n.integrationsSmsSenderId,
                  'smsSenderId',
                  hint: l10n.integrationsSmsSenderIdHint,
                  icon: Icons.outgoing_mail,
                ),
                _secretField(
                  l10n.integrationsSmsApiUrl,
                  'smsApiUrl',
                  hint: l10n.integrationsSmsApiUrlHint,
                  icon: Icons.http_outlined,
                ),
              ],
            ),
            _IntegrationSectionCard(
              title: l10n.integrationsWhatsappTitle,
              subtitle: l10n.integrationsWhatsappSubtitle,
              icon: Icons.chat_outlined,
              accent: CoreColors.semanticSuccess,
              configured: config.isSectionConfigured(
                AdminIntegrationSection.whatsapp,
              ),
              onTest: () => _testSection(AdminIntegrationSection.whatsapp),
              children: [
                _secretField(
                  l10n.integrationsWhatsappBusinessAccountId,
                  'whatsappBusinessAccountId',
                  hint: l10n.integrationsWhatsappBusinessAccountIdHint,
                  icon: Icons.storefront_outlined,
                ),
                _secretField(
                  l10n.integrationsWhatsappPhoneNumberId,
                  'whatsappPhoneNumberId',
                  hint: l10n.integrationsWhatsappPhoneNumberIdHint,
                  icon: Icons.phone_android_outlined,
                ),
                _secretField(
                  l10n.integrationsWhatsappAccessToken,
                  'whatsappAccessToken',
                  hint: l10n.integrationsWhatsappAccessTokenHint,
                  icon: Icons.lock_outline,
                  obscure: true,
                ),
                _secretField(
                  l10n.integrationsWhatsappWebhookVerifyToken,
                  'whatsappWebhookVerifyToken',
                  hint: l10n.integrationsWhatsappWebhookVerifyTokenHint,
                  icon: Icons.verified_user_outlined,
                  obscure: true,
                ),
              ],
            ),
            _IntegrationSectionCard(
              title: l10n.integrationsTelephonyTitle,
              subtitle: l10n.integrationsTelephonySubtitle,
              icon: Icons.phone_in_talk_outlined,
              accent: CoreColors.brandBrown,
              configured: config.isSectionConfigured(
                AdminIntegrationSection.telephony,
              ),
              onTest: () => _testSection(AdminIntegrationSection.telephony),
              children: [
                _secretField(
                  l10n.integrationsSupportPhoneNumber,
                  'supportPhoneNumber',
                  hint: l10n.integrationsSupportPhoneNumberHint,
                  icon: Icons.support_agent_outlined,
                  keyboardType: TextInputType.phone,
                  textDirection: TextDirection.ltr,
                ),
                _secretField(
                  l10n.integrationsDefaultCountryCode,
                  'defaultCountryCode',
                  hint: l10n.integrationsDefaultCountryCodeHint,
                  icon: Icons.flag_outlined,
                  textDirection: TextDirection.ltr,
                ),
                _secretField(
                  l10n.integrationsOtpSenderNumber,
                  'otpSenderNumber',
                  hint: l10n.integrationsOtpSenderNumberHint,
                  icon: Icons.pin_outlined,
                  keyboardType: TextInputType.phone,
                  textDirection: TextDirection.ltr,
                ),
              ],
            ),
            _IntegrationSectionCard(
              title: l10n.integrationsPaymentsTitle,
              subtitle: l10n.integrationsPaymentsSubtitle,
              icon: Icons.payments_outlined,
              accent: CoreColors.semanticRevenue,
              configured: config.isSectionConfigured(
                AdminIntegrationSection.payments,
              ),
              onTest: () => _testSection(AdminIntegrationSection.payments),
              children: [
                _secretField(
                  l10n.integrationsPaymentGatewayProvider,
                  'paymentGatewayProvider',
                  hint: l10n.integrationsPaymentGatewayProviderHint,
                  icon: Icons.account_balance_outlined,
                ),
                _secretField(
                  l10n.integrationsStripePublishableKey,
                  'stripePublishableKey',
                  hint: l10n.integrationsStripePublishableKeyHint,
                  icon: Icons.credit_card_outlined,
                ),
                _secretField(
                  l10n.integrationsStripeSecretKey,
                  'stripeSecretKey',
                  hint: l10n.integrationsStripeSecretKeyHint,
                  icon: Icons.lock_outline,
                  obscure: true,
                ),
                _secretField(
                  l10n.integrationsStripeWebhookSecret,
                  'stripeWebhookSecret',
                  hint: l10n.integrationsStripeWebhookSecretHint,
                  icon: Icons.webhook_outlined,
                  obscure: true,
                ),
                _secretField(
                  l10n.integrationsGooglePayMerchantId,
                  'googlePayMerchantId',
                  hint: l10n.integrationsGooglePayMerchantIdHint,
                  icon: Icons.wallet_outlined,
                ),
                _secretField(
                  l10n.integrationsGooglePayMerchantName,
                  'googlePayMerchantName',
                  hint: l10n.integrationsGooglePayMerchantNameHint,
                  icon: Icons.store_outlined,
                ),
                _secretField(
                  l10n.integrationsApplePayMerchantId,
                  'applePayMerchantId',
                  hint: l10n.integrationsApplePayMerchantIdHint,
                  icon: Icons.apple,
                ),
                _secretField(
                  l10n.integrationsPaymentGatewayApiKey,
                  'paymentGatewayApiKey',
                  hint: l10n.integrationsPaymentGatewayApiKeyHint,
                  icon: Icons.key_outlined,
                  obscure: true,
                ),
                _secretField(
                  l10n.integrationsPaymentGatewayMerchantId,
                  'paymentGatewayMerchantId',
                  hint: l10n.integrationsPaymentGatewayMerchantIdHint,
                  icon: Icons.badge_outlined,
                ),
                _secretField(
                  l10n.integrationsPaymentGatewayWebhookUrl,
                  'paymentGatewayWebhookUrl',
                  hint: l10n.integrationsPaymentGatewayWebhookUrlHint,
                  icon: Icons.link,
                ),
                const Divider(),
                Text(
                  l10n.integrationsWalletSectionTitle,
                  style: CoreTypography.titleMedium(
                    context,
                    scheme.onSurface,
                  ).copyWith(fontWeight: FontWeight.w900),
                ),
                SizedBox(height: CoreSpacing.sm(context)),
                _secretField(
                  l10n.integrationsWalletProviderName,
                  'walletProviderName',
                  hint: l10n.integrationsWalletProviderNameHint,
                  icon: Icons.account_balance_wallet_outlined,
                ),
                _secretField(
                  l10n.integrationsWalletAppId,
                  'walletAppId',
                  hint: l10n.integrationsWalletAppIdHint,
                  icon: Icons.apps_outlined,
                ),
                _secretField(
                  l10n.integrationsWalletDeepLinkScheme,
                  'walletDeepLinkScheme',
                  hint: l10n.integrationsWalletDeepLinkSchemeHint,
                  icon: Icons.open_in_new_outlined,
                ),
                _secretField(
                  l10n.integrationsWalletWebhookSecret,
                  'walletWebhookSecret',
                  hint: l10n.integrationsWalletWebhookSecretHint,
                  icon: Icons.security_outlined,
                  obscure: true,
                ),
              ],
            ),
            _IntegrationSectionCard(
              title: l10n.integrationsAiTitle,
              subtitle: l10n.integrationsAiSubtitle,
              icon: Icons.smart_toy_outlined,
              accent: CoreColors.orderTypePlated,
              configured: config.isSectionConfigured(
                AdminIntegrationSection.ai,
              ),
              onTest: () => _testSection(AdminIntegrationSection.ai),
              children: [
                _secretField(
                  l10n.integrationsAiProvider,
                  'aiProvider',
                  hint: l10n.integrationsAiProviderHint,
                  icon: Icons.hub_outlined,
                ),
                _secretField(
                  l10n.integrationsAiApiKey,
                  'aiApiKey',
                  hint: l10n.integrationsAiApiKeyHint,
                  icon: Icons.key_outlined,
                  obscure: true,
                ),
                _secretField(
                  l10n.integrationsAiModelName,
                  'aiModelName',
                  hint: l10n.integrationsAiModelNameHint,
                  icon: Icons.model_training_outlined,
                ),
                _secretField(
                  l10n.integrationsAiBaseUrl,
                  'aiBaseUrl',
                  hint: l10n.integrationsAiBaseUrlHint,
                  icon: Icons.language_outlined,
                ),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    l10n.integrationsAiSupportChatEnabled,
                    style: CoreTypography.titleMedium(
                      context,
                      scheme.onSurface,
                    ).copyWith(fontWeight: FontWeight.w800),
                  ),
                  subtitle: Text(
                    l10n.integrationsAiSupportChatEnabledHint,
                    style: CoreTypography.caption(
                      context,
                      scheme.onSurfaceVariant,
                    ),
                  ),
                  value: _aiSupportChatEnabled,
                  activeColor: CoreColors.brandOlive,
                  onChanged:
                      (value) => setState(() => _aiSupportChatEnabled = value),
                ),
              ],
            ),
            _IntegrationSectionCard(
              title: l10n.integrationsAttendanceWifiTitle,
              subtitle: l10n.integrationsAttendanceWifiSubtitle,
              icon: Icons.router_outlined,
              accent: CoreColors.brandBrown,
              configured: config.isSectionConfigured(
                AdminIntegrationSection.attendanceWifi,
              ),
              onTest: () => _testSection(AdminIntegrationSection.attendanceWifi),
              children: [
                _secretField(
                  l10n.integrationsRestaurantWifiSsid,
                  'restaurantWifiSsid',
                  hint: l10n.integrationsRestaurantWifiSsidHint,
                  icon: Icons.wifi_outlined,
                ),
                _secretField(
                  l10n.integrationsRestaurantWifiBssid,
                  'restaurantWifiBssid',
                  hint: l10n.integrationsRestaurantWifiBssidHint,
                  icon: Icons.router_outlined,
                ),
                _secretField(
                  l10n.integrationsRestaurantWifiGatewayIp,
                  'restaurantWifiGatewayIp',
                  hint: l10n.integrationsRestaurantWifiGatewayIpHint,
                  icon: Icons.lan_outlined,
                  keyboardType: TextInputType.number,
                  textDirection: TextDirection.ltr,
                ),
                _secretField(
                  l10n.integrationsRestaurantBranchLabel,
                  'restaurantBranchLabel',
                  hint: l10n.integrationsRestaurantBranchLabelHint,
                  icon: Icons.store_outlined,
                ),
              ],
            ),
            _IntegrationSectionCard(
              title: l10n.integrationsOtherTitle,
              subtitle: l10n.integrationsOtherSubtitle,
              icon: Icons.extension_outlined,
              accent: CoreColors.brandOrange,
              configured: config.isSectionConfigured(
                AdminIntegrationSection.other,
              ),
              onTest: () => _testSection(AdminIntegrationSection.other),
              children: [
                _secretField(
                  l10n.integrationsGoogleMapsApiKey,
                  'googleMapsApiKey',
                  hint: l10n.integrationsGoogleMapsApiKeyHint,
                  icon: Icons.map_outlined,
                  obscure: true,
                ),
                _secretField(
                  l10n.integrationsFcmServerKey,
                  'fcmServerKey',
                  hint: l10n.integrationsFcmServerKeyHint,
                  icon: Icons.notifications_active_outlined,
                  obscure: true,
                ),
                _secretField(
                  l10n.integrationsEmailProvider,
                  'emailProvider',
                  hint: l10n.integrationsEmailProviderHint,
                  icon: Icons.email_outlined,
                ),
                _secretField(
                  l10n.integrationsEmailApiKey,
                  'emailApiKey',
                  hint: l10n.integrationsEmailApiKeyHint,
                  icon: Icons.key_outlined,
                  obscure: true,
                ),
                _secretField(
                  l10n.integrationsEmailFromAddress,
                  'emailFromAddress',
                  hint: l10n.integrationsEmailFromAddressHint,
                  icon: Icons.alternate_email,
                ),
                _secretField(
                  l10n.integrationsSentryDsn,
                  'sentryDsn',
                  hint: l10n.integrationsSentryDsnHint,
                  icon: Icons.bug_report_outlined,
                ),
              ],
            ),
            SizedBox(height: CoreSpacing.lg(context)),
            Row(
              children: [
                Expanded(
                  child: WidgetsAppButton(
                    label: l10n.integrationsSaveAll,
                    onPressed: _saveAll,
                    icon: Icons.save_outlined,
                  ),
                ),
                SizedBox(width: CoreSpacing.md(context)),
                Expanded(
                  child: WidgetsAppButton(
                    label: l10n.actionCancel,
                    onPressed: () => context.pop(),
                    variant: WidgetsAppButtonVariant.outline,
                  ),
                ),
              ],
            ),
            if (config.lastSavedAt != null) ...[
              SizedBox(height: CoreSpacing.md(context)),
              Text(
                l10n.integrationsLastSaved(
                  MaterialLocalizations.of(
                    context,
                  ).formatShortDate(config.lastSavedAt!),
                ),
                textAlign: TextAlign.center,
                style: CoreTypography.caption(
                  context,
                  scheme.onSurfaceVariant,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _secretField(
    String label,
    String key, {
    required String hint,
    required IconData icon,
    bool obscure = false,
    TextInputType? keyboardType,
    TextDirection? textDirection,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: CoreSpacing.md(context)),
      child: WidgetsAppTextField(
        label: label,
        hintText: hint,
        prefixIcon: icon,
        controller: _controllers[key],
        obscureText: obscure,
        keyboardType: keyboardType,
        textDirection: textDirection,
      ),
    );
  }
}

class _IntegrationSectionCard extends StatelessWidget {
  const _IntegrationSectionCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.accent,
    required this.configured,
    required this.onTest,
    required this.children,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final Color accent;
  final bool configured;
  final VoidCallback onTest;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Padding(
      padding: EdgeInsets.only(bottom: CoreSpacing.lg(context)),
      child: WidgetsAppCard(
        title: title,
        subtitle: subtitle,
        accentColor: accent,
        leading: Icon(icon, color: accent),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: WidgetsStatusPill(
                label:
                    configured
                        ? l10n.integrationsStatusConfigured
                        : l10n.integrationsStatusIncomplete,
                color: configured ? CoreColors.semanticSuccess : accent,
                compact: true,
              ),
            ),
            SizedBox(height: CoreSpacing.md(context)),
            ...children,
            WidgetsAppButton(
              label: l10n.integrationsTestConnection,
              onPressed: onTest,
              icon: Icons.play_circle_outline,
              variant: WidgetsAppButtonVariant.outline,
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/data/models/model_saved_address.dart';
import 'package:ayletna_restaurant_app/data/repositories/repository_providers.dart';
import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:ayletna_restaurant_app/navigation/app_route_paths.dart';
import 'package:ayletna_restaurant_app/providers/checkout_draft_providers.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_action_bar.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_checkout_sections.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_checkout_step_strip.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_error_message.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_icon_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_page_header.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_scaffold_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Stepped checkout — fulfillment (step 2).
class CustomerCheckoutScreen extends ConsumerStatefulWidget {
  const CustomerCheckoutScreen({super.key});

  @override
  ConsumerState<CustomerCheckoutScreen> createState() =>
      _CustomerCheckoutScreenState();
}

class _CustomerCheckoutScreenState
    extends ConsumerState<CustomerCheckoutScreen> {
  bool _showMoreFulfillment = false;

  static const _extraFulfillments = [
    CheckoutFulfillment.groupDelivery,
    CheckoutFulfillment.plated,
  ];

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final draft = ref.watch(checkoutDraftProvider);
    final addressesAsync = ref.watch(savedAddressesProvider);
    final addressRequired = _requiresAddress(draft.fulfillment);
    final showMore =
        _showMoreFulfillment || _extraFulfillments.contains(draft.fulfillment);
    final canContinue =
        !addressRequired || draft.selectedAddressId != null;

    return WidgetsScaffoldPage(
      title: l10n.cartCheckoutStepFulfillment,
      showLeading: false,
      actions: [
        WidgetsIconButton(
          icon: Icons.support_agent_outlined,
          tooltip: l10n.screenSupport,
          onPressed: () => context.push(AppRoutePaths.support),
        ),
      ],
      bottomSheet: WidgetsActionBar(
        primary: WidgetsAppButton(
          label: l10n.actionContinue,
          icon: Icons.arrow_forward,
          fullWidth: true,
          onPressed:
              canContinue ? () => context.push(AppRoutePaths.payment) : null,
        ),
        secondary: WidgetsAppButton(
          label: l10n.prepBack,
          icon: Icons.arrow_back,
          variant: WidgetsAppButtonVariant.outline,
          fullWidth: true,
          onPressed: () {
            if (context.canPop()) {
              context.pop();
              return;
            }
            context.go(AppRoutePaths.cart);
          },
        ),
      ),
      child: ListView(
        padding: EdgeInsetsDirectional.only(
          top: CoreSpacing.md(context),
          bottom: CoreSpacing.xxl(context) * 3,
        ),
        children: [
          WidgetsPageHeader(
            title: l10n.cartCheckoutStepFulfillment,
            subtitle: l10n.cartFulfillmentSubtitle,
          ),
          SizedBox(height: CoreSpacing.md(context)),
          WidgetsCheckoutStepStrip(
            activeStep: 1,
            completedThrough: 0,
            onStepTapped: (step) => _jumpToStep(context, step),
          ),
          SizedBox(height: CoreSpacing.lg(context)),
          WidgetsCheckoutFulfillmentSection(
            selected: draft.fulfillment,
            showMore: showMore,
            onToggleMore:
                () =>
                    setState(() => _showMoreFulfillment = !_showMoreFulfillment),
            onSelected: (value) {
              ref.read(checkoutDraftProvider.notifier).setFulfillment(value);
              if (_extraFulfillments.contains(value)) {
                setState(() => _showMoreFulfillment = true);
              }
            },
            onTerms: () => context.push(AppRoutePaths.terms),
          ),
          if (addressRequired) ...[
            SizedBox(height: CoreSpacing.lg(context)),
            addressesAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => WidgetsErrorMessage(message: e.toString()),
              data:
                  (addresses) => _AddressPicker(
                    addresses: addresses,
                    selectedId: draft.selectedAddressId,
                    onSelected:
                        (id) => ref
                            .read(checkoutDraftProvider.notifier)
                            .setAddressId(id),
                  ),
            ),
          ],
        ],
      ),
    );
  }

  static bool _requiresAddress(CheckoutFulfillment fulfillment) {
    return fulfillment == CheckoutFulfillment.delivery ||
        fulfillment == CheckoutFulfillment.groupDelivery ||
        fulfillment == CheckoutFulfillment.plated;
  }

  static void _jumpToStep(BuildContext context, int step) {
    switch (step) {
      case 0:
        context.go(AppRoutePaths.cart);
      case 1:
        break;
      case 2:
        context.push(AppRoutePaths.payment);
      case 3:
        context.push(AppRoutePaths.checkoutReview);
    }
  }
}

class _AddressPicker extends StatelessWidget {
  const _AddressPicker({
    required this.addresses,
    required this.selectedId,
    required this.onSelected,
  });

  final List<ModelSavedAddress> addresses;
  final String? selectedId;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;

    return RadioGroup<String>(
      groupValue: selectedId,
      onChanged: (value) {
        if (value != null) onSelected(value);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            l10n.deliveryChooseAddress,
            style: CoreTypography.titleMedium(
              context,
              scheme.onSurface,
            ).copyWith(fontWeight: FontWeight.w800),
          ),
          SizedBox(height: CoreSpacing.sm(context)),
          for (final address in addresses)
            RadioListTile<String>(
              value: address.id,
              title: Text(
                Localizations.localeOf(context).languageCode == 'ar'
                    ? address.labelAr
                    : address.labelEn,
              ),
              subtitle: Text(
                Localizations.localeOf(context).languageCode == 'ar'
                    ? address.addressAr
                    : address.addressEn,
              ),
            ),
        ],
      ),
    );
  }
}

import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/data/models/model_saved_address.dart';
import 'package:ayletna_restaurant_app/data/repositories/repository_providers.dart';
import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:ayletna_restaurant_app/navigation/app_route_paths.dart';
import 'package:ayletna_restaurant_app/providers/checkout_draft_providers.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_page_header.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_checkout_step_strip.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_error_message.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_scaffold_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Stepped checkout — fulfillment and delivery details (step 2).
class CustomerCheckoutScreen extends ConsumerStatefulWidget {
  const CustomerCheckoutScreen({super.key});

  @override
  ConsumerState<CustomerCheckoutScreen> createState() =>
      _CustomerCheckoutScreenState();
}

class _CustomerCheckoutScreenState
    extends ConsumerState<CustomerCheckoutScreen> {
  bool _showMoreFulfillment = false;

  static const _primaryFulfillments = [
    CheckoutFulfillment.dineIn,
    CheckoutFulfillment.takeaway,
    CheckoutFulfillment.delivery,
  ];

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
        _showMoreFulfillment ||
        _extraFulfillments.contains(draft.fulfillment);
    final visibleOptions = [
      ..._primaryFulfillments,
      if (showMore) ..._extraFulfillments,
    ];

    final children = <Widget>[
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
      Text(
        l10n.cartFulfillmentTitle,
        style: CoreTypography.titleMedium(
          context,
          Theme.of(context).colorScheme.onSurface,
        ).copyWith(fontWeight: FontWeight.w900),
      ),
      SizedBox(height: CoreSpacing.md(context)),
      Wrap(
        spacing: CoreSpacing.sm(context),
        runSpacing: CoreSpacing.sm(context),
        children: [
          for (final option in visibleOptions)
            ChoiceChip(
              label: Text(_fulfillmentLabel(l10n, option)),
              selected: draft.fulfillment == option,
              onSelected:
                  (_) => ref
                      .read(checkoutDraftProvider.notifier)
                      .setFulfillment(option),
            ),
        ],
      ),
      Align(
        alignment: AlignmentDirectional.centerStart,
        child: TextButton(
          onPressed:
              () => setState(() => _showMoreFulfillment = !_showMoreFulfillment),
          child: Text(
            showMore
                ? l10n.cartHideFulfillmentOptions
                : l10n.cartMoreFulfillmentOptions,
          ),
        ),
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
                    (id) =>
                        ref.read(checkoutDraftProvider.notifier).setAddressId(id),
              ),
        ),
      ],
      SizedBox(height: CoreSpacing.xxl(context)),
      WidgetsAppButton(
        label: l10n.actionContinue,
        icon: Icons.arrow_forward,
        fullWidth: true,
        onPressed:
            !addressRequired || draft.selectedAddressId != null
                ? () => context.push(AppRoutePaths.payment)
                : null,
      ),
      SizedBox(height: CoreSpacing.sm(context)),
      WidgetsAppButton(
        label: l10n.screenCart,
        icon: Icons.shopping_basket_outlined,
        variant: WidgetsAppButtonVariant.outline,
        fullWidth: true,
        onPressed: () => context.go(AppRoutePaths.cart),
      ),
    ];

    return WidgetsScaffoldPage(
      title: l10n.cartCheckoutStepFulfillment,
      child: ListView.builder(
        padding: EdgeInsets.symmetric(vertical: CoreSpacing.md(context)),
        itemCount: children.length,
        itemBuilder: (context, index) => children[index],
      ),
    );
  }

  static bool _requiresAddress(CheckoutFulfillment fulfillment) {
    return fulfillment == CheckoutFulfillment.delivery ||
        fulfillment == CheckoutFulfillment.groupDelivery ||
        fulfillment == CheckoutFulfillment.plated;
  }

  static String _fulfillmentLabel(
    AppLocalizations l10n,
    CheckoutFulfillment fulfillment,
  ) {
    return switch (fulfillment) {
      CheckoutFulfillment.dineIn => l10n.orderTypeDineIn,
      CheckoutFulfillment.takeaway => l10n.orderTypeTakeaway,
      CheckoutFulfillment.delivery => l10n.orderTypeDelivery,
      CheckoutFulfillment.groupDelivery => l10n.cartGroupDeliveryTitle,
      CheckoutFulfillment.plated => l10n.orderTypePlated,
    };
  }

  static void _jumpToStep(BuildContext context, int step) {
    switch (step) {
      case 0:
        context.go(AppRoutePaths.cart);
      case 1:
        break;
      case 2:
      case 3:
        context.push(AppRoutePaths.payment);
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

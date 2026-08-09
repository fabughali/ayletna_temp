import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/data/mockup/mockup_catalog.dart';
import 'package:ayletna_restaurant_app/data/models/model_cart_customization_option.dart';
import 'package:ayletna_restaurant_app/data/models/model_cart_line.dart';
import 'package:ayletna_restaurant_app/data/models/model_menu_item.dart';
import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:ayletna_restaurant_app/providers/admin_catalog_providers.dart';
import 'package:ayletna_restaurant_app/providers/cart_providers.dart';
import 'package:ayletna_restaurant_app/utilities/utility_cart_option_labels.dart';
import 'package:ayletna_restaurant_app/utilities/utility_format_jod.dart';
import 'package:ayletna_restaurant_app/utilities/utility_mock_feedback.dart';
import 'package:ayletna_restaurant_app/utilities/utility_sizer.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_text_field.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_food_media_panel.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_food_tag.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_mock_food_image.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_price_badge.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_quantity_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> showWidgetsCartCustomizationSheet({
  required BuildContext context,
  required ModelMenuItem item,
  ModelCartLine? initialLine,
  String? replaceLineKey,
}) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    backgroundColor: Colors.transparent,
    builder:
        (context) => WidgetsCartCustomizationSheet(
          item: item,
          initialLine: initialLine,
          replaceLineKey: replaceLineKey,
        ),
  );
}

class WidgetsCartCustomizationSheet extends ConsumerStatefulWidget {
  const WidgetsCartCustomizationSheet({
    required this.item,
    this.initialLine,
    this.replaceLineKey,
    super.key,
  });

  final ModelMenuItem item;
  final ModelCartLine? initialLine;
  final String? replaceLineKey;

  @override
  ConsumerState<WidgetsCartCustomizationSheet> createState() =>
      _WidgetsCartCustomizationSheetState();
}

class _WidgetsCartCustomizationSheetState
    extends ConsumerState<WidgetsCartCustomizationSheet> {
  int _quantity = 1;
  String _portionKey = MockupCatalog.cartPortionOptions.first.key;
  final Set<String> _addonKeys = {};
  late final TextEditingController _remarksController;

  List<ModelCartCustomizationOption> get _portionOptions =>
      ref.watch(visiblePortionOptionsProvider);

  List<ModelCartCustomizationOption> get _addonOptions {
    return ref
        .watch(visibleAddonsProvider)
        .map(
          (addon) => ModelCartCustomizationOption(
            key: addon.key,
            priceDeltaJod: addon.priceDeltaJod,
          ),
        )
        .toList();
  }

  @override
  void initState() {
    super.initState();
    _remarksController = TextEditingController();
    final initial = widget.initialLine;
    if (initial == null) return;

    _quantity = initial.quantity;
    _remarksController.text = initial.remarks ?? '';
    final keys = (initial.configurationKey ?? '').split('|');
    for (final key in keys) {
      if (_portionOptions.any((option) => option.key == key) ||
          MockupCatalog.cartPortionOptions.any((option) => option.key == key)) {
        _portionKey = key;
      }
      if (MockupCatalog.cartAddonOptions.any((option) => option.key == key) ||
          key.startsWith('extra_') ||
          key.startsWith('add_')) {
        _addonKeys.add(key);
      }
    }
  }

  @override
  void dispose() {
    _remarksController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isAr = Localizations.localeOf(context).languageCode == 'ar';
    final scheme = Theme.of(context).colorScheme;
    final item = widget.item;
    final total = _calculateTotal(item.priceJod);
    final totalText = UtilityFormatJod.format(total, suffix: l10n.currencyJod);

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.viewInsetsOf(context).bottom,
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: scheme.surface,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(CoreSpacing.radiusCardOf(context) * 1.35),
          ),
          boxShadow: [
            BoxShadow(
              color: scheme.shadow.withValues(alpha: 0.16),
              blurRadius: UtilitySizer.of(context, 28),
              offset: const Offset(0, -10),
            ),
          ],
        ),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.sizeOf(context).height * 0.90,
          ),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(
                  CoreSpacing.lg(context),
                  CoreSpacing.md(context),
                  CoreSpacing.lg(context),
                  CoreSpacing.sm(context),
                ),
                child: Column(
                  children: [
                    const _SheetHandle(),
                    SizedBox(height: CoreSpacing.md(context)),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                l10n.screenCustomizationModal,
                                style: CoreTypography.headlineSmall(
                                  context,
                                  scheme.onSurface,
                                ).copyWith(fontWeight: FontWeight.w900),
                              ),
                              SizedBox(height: CoreSpacing.xs(context)),
                              Text(
                                isAr ? item.nameAr : item.nameEn,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: CoreTypography.bodyMedium(
                                  context,
                                  scheme.onSurfaceVariant,
                                ).copyWith(fontWeight: FontWeight.w800),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: CoreSpacing.md(context)),
                        WidgetsPriceBadge(
                          priceLabel: UtilityFormatJod.format(
                            item.priceJod,
                            suffix: l10n.currencyJod,
                          ),
                          compact: true,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Divider(color: scheme.outlineVariant, height: 1),
              Expanded(
                child: ListView(
                  padding: EdgeInsetsDirectional.fromSTEB(
                    CoreSpacing.lg(context),
                    CoreSpacing.lg(context),
                    CoreSpacing.lg(context),
                    CoreSpacing.xl(context),
                  ),
                  children: [
                    _ItemSummary(item: item, isAr: isAr),
                    SizedBox(height: CoreSpacing.xl(context)),
                    _QuantitySection(
                      quantity: _quantity,
                      onMinus:
                          () => setState(() {
                            if (_quantity > 1) _quantity--;
                          }),
                      onPlus: () => setState(() => _quantity++),
                    ),
                    SizedBox(height: CoreSpacing.xl(context)),
                    _PortionSection(
                      selectedKey: _portionKey,
                      onChanged:
                          (portionKey) =>
                              setState(() => _portionKey = portionKey),
                    ),
                    SizedBox(height: CoreSpacing.xl(context)),
                    _AddonsSection(
                      selectedKeys: _addonKeys,
                      addonOptions: _addonOptions,
                      onChanged:
                          (key, selected) => setState(() {
                            if (selected) {
                              _addonKeys.add(key);
                            } else {
                              _addonKeys.remove(key);
                            }
                          }),
                    ),
                    SizedBox(height: CoreSpacing.xl(context)),
                    WidgetsAppTextField(
                      label: l10n.productSpecialInstructions,
                      controller: _remarksController,
                      maxLines: 3,
                      hintText: l10n.productInstructionsHint,
                    ),
                  ],
                ),
              ),
              _SheetFooter(
                totalText: totalText,
                onCancel: () => Navigator.of(context).pop(),
                onAdd: _addToCart,
              ),
            ],
          ),
        ),
      ),
    );
  }

  double _calculateTotal(double basePrice) {
    return _calculateUnitPrice(basePrice) * _quantity;
  }

  double _calculateUnitPrice(double basePrice) {
    final portionPrice = _selectedPortion.priceDeltaJod;
    final addonsPrice = _addonOptions
        .where((option) => _addonKeys.contains(option.key))
        .fold<double>(0, (total, option) => total + option.priceDeltaJod);
    return basePrice + portionPrice + addonsPrice;
  }

  void _addToCart() {
    final l10n = AppLocalizations.of(context)!;
    final remarks = _remarksController.text.trim();
    final optionLabels = [
      cartOptionLabel(_selectedPortion.key, l10n),
      for (final option in _addonOptions)
        if (_addonKeys.contains(option.key)) cartOptionLabel(option.key, l10n),
    ];
    final configurationSummary = optionLabels.join(' • ');
    final configurationKey = [
      _selectedPortion.key,
      ..._addonOptions
          .where((option) => _addonKeys.contains(option.key))
          .map((option) => option.key),
      if (remarks.isNotEmpty) remarks,
    ].join('|');

    final cart = ref.read(cartProvider.notifier);
    final replaceLineKey = widget.replaceLineKey;
    if (replaceLineKey != null) {
      cart.removeItem(replaceLineKey);
    }
    cart.addConfiguredItem(
      item: widget.item,
      quantity: _quantity,
      unitPriceJod: _calculateUnitPrice(widget.item.priceJod),
      configurationKey: configurationKey,
      configurationAr: configurationSummary,
      configurationEn: configurationSummary,
      remarks: remarks.isEmpty ? null : remarks,
    );
    UtilityMockFeedback.showSuccess(context, l10n.actionAddToCart);
    Navigator.of(context).pop();
  }

  ModelCartCustomizationOption get _selectedPortion {
    return _portionOptions.firstWhere(
      (option) => option.key == _portionKey,
      orElse: () => _portionOptions.first,
    );
  }
}

class _SheetHandle extends StatelessWidget {
  const _SheetHandle();

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.outlineVariant,
        borderRadius: BorderRadius.circular(CoreSpacing.radiusChipOf(context)),
      ),
      child: SizedBox(
        width: CoreContentSizes.sheetGrabberWidth(context),
        height: CoreContentSizes.sheetGrabberHeight(context),
      ),
    );
  }
}

class _ItemSummary extends StatelessWidget {
  const _ItemSummary({required this.item, required this.isAr});

  final ModelMenuItem item;
  final bool isAr;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return WidgetsAppCard(
      variant: WidgetsAppCardVariant.food,
      padding: EdgeInsets.all(CoreSpacing.md(context)),
      child: Row(
        children: [
          SizedBox(
            width: UtilitySizer.of(context, 96),
            height: UtilitySizer.of(context, 82),
            child: WidgetsFoodMediaPanel(
              expand: true,
              child: WidgetsMockFoodImage(
                imageUrl: item.imageUrl,
                fallback: Icon(
                  Icons.restaurant_menu_outlined,
                  color: scheme.primary,
                ),
              ),
            ),
          ),
          SizedBox(width: CoreSpacing.md(context)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isAr ? item.nameAr : item.nameEn,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: CoreTypography.titleMedium(
                    context,
                    scheme.onSurface,
                  ).copyWith(fontWeight: FontWeight.w900),
                ),
                SizedBox(height: CoreSpacing.xs(context)),
                Text(
                  isAr ? item.descriptionAr : item.descriptionEn,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: CoreTypography.caption(
                    context,
                    scheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _QuantitySection extends StatelessWidget {
  const _QuantitySection({
    required this.quantity,
    required this.onMinus,
    required this.onPlus,
  });

  final int quantity;
  final VoidCallback onMinus;
  final VoidCallback onPlus;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;

    return Row(
      children: [
        Expanded(
          child: Text(
            l10n.cartCustomizationQuantity,
            style: CoreTypography.titleMedium(
              context,
              scheme.onSurface,
            ).copyWith(fontWeight: FontWeight.w900),
          ),
        ),
        SizedBox(width: CoreSpacing.md(context)),
        Expanded(
          child: WidgetsQuantityStepper(
            value: quantity,
            min: 1,
            expanded: true,
            onIncrement: onPlus,
            onDecrement: onMinus,
          ),
        ),
      ],
    );
  }
}

class _PortionSection extends ConsumerWidget {
  const _PortionSection({required this.selectedKey, required this.onChanged});

  final String selectedKey;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    final portions = ref.watch(visiblePortionOptionsProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                l10n.productSizePortion,
                style: CoreTypography.titleMedium(
                  context,
                  scheme.onSurface,
                ).copyWith(fontWeight: FontWeight.w900),
              ),
            ),
            WidgetsFoodTag(label: l10n.productRequired, color: scheme.primary),
          ],
        ),
        SizedBox(height: CoreSpacing.md(context)),
        for (var index = 0; index < portions.length; index++) ...[
          _PortionTile(
            option: portions[index],
            selectedKey: selectedKey,
            title: cartOptionLabel(portions[index].key, l10n),
            priceLabel: UtilityFormatJod.format(
              portions[index].priceDeltaJod,
              suffix: l10n.currencyJod,
            ),
            onChanged: onChanged,
          ),
          if (index != portions.length - 1)
            SizedBox(height: CoreSpacing.sm(context)),
        ],
      ],
    );
  }
}

class _PortionTile extends StatelessWidget {
  const _PortionTile({
    required this.option,
    required this.selectedKey,
    required this.title,
    required this.priceLabel,
    required this.onChanged,
  });

  final ModelCartCustomizationOption option;
  final String selectedKey;
  final String title;
  final String priceLabel;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isSelected = option.key == selectedKey;

    return WidgetsAppCard(
      variant:
          isSelected ? WidgetsAppCardVariant.food : WidgetsAppCardVariant.form,
      padding: EdgeInsets.all(CoreSpacing.md(context)),
      onTap: () => onChanged(option.key),
      child: Row(
        children: [
          Icon(
            isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
            color: isSelected ? scheme.primary : scheme.onSurfaceVariant,
          ),
          SizedBox(width: CoreSpacing.md(context)),
          Expanded(
            child: Text(
              title,
              style: CoreTypography.bodyMedium(
                context,
                scheme.onSurface,
              ).copyWith(fontWeight: FontWeight.w800),
            ),
          ),
          SizedBox(width: CoreSpacing.sm(context)),
          WidgetsPriceBadge(priceLabel: priceLabel, compact: true),
        ],
      ),
    );
  }
}

class _AddonsSection extends StatelessWidget {
  const _AddonsSection({
    required this.selectedKeys,
    required this.onChanged,
    required this.addonOptions,
  });

  final Set<String> selectedKeys;
  final void Function(String key, bool selected) onChanged;
  final List<ModelCartCustomizationOption> addonOptions;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.productAddonsPreferences,
          style: CoreTypography.titleMedium(
            context,
            scheme.onSurface,
          ).copyWith(fontWeight: FontWeight.w900),
        ),
        SizedBox(height: CoreSpacing.md(context)),
        WidgetsAppCard(
          variant: WidgetsAppCardVariant.form,
          padding: EdgeInsets.zero,
          child: Column(
            children: [
              for (final option in addonOptions) ...[
                _AddonTile(
                  value: selectedKeys.contains(option.key),
                  onChanged: (selected) => onChanged(option.key, selected),
                  title: cartOptionLabel(option.key, l10n),
                  price:
                      option.priceDeltaJod == 0
                          ? l10n.productFree
                          : UtilityFormatJod.format(
                            option.priceDeltaJod,
                            suffix: l10n.currencyJod,
                          ),
                ),
                if (option != addonOptions.last)
                  Divider(color: scheme.outlineVariant, height: 1),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _AddonTile extends StatelessWidget {
  const _AddonTile({
    required this.value,
    required this.onChanged,
    required this.title,
    required this.price,
  });

  final bool value;
  final ValueChanged<bool> onChanged;
  final String title;
  final String price;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return CheckboxListTile(
      value: value,
      onChanged: (next) => onChanged(next ?? false),
      title: Text(title),
      secondary: Text(
        price,
        style: CoreTypography.caption(context, scheme.onSurfaceVariant),
      ),
      controlAffinity: ListTileControlAffinity.leading,
      contentPadding: EdgeInsetsDirectional.symmetric(
        horizontal: CoreSpacing.md(context),
      ),
    );
  }
}

class _SheetFooter extends StatelessWidget {
  const _SheetFooter({
    required this.totalText,
    required this.onCancel,
    required this.onAdd,
  });

  final String totalText;
  final VoidCallback onCancel;
  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: scheme.surface,
        border: Border(top: BorderSide(color: scheme.outlineVariant)),
        boxShadow: [
          BoxShadow(
            color: scheme.shadow.withValues(alpha: 0.08),
            blurRadius: UtilitySizer.of(context, 18),
            offset: const Offset(0, -8),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.all(CoreSpacing.md(context)),
          child: Row(
            children: [
              WidgetsAppButton(
                label: l10n.actionCancel,
                onPressed: onCancel,
                variant: WidgetsAppButtonVariant.ghost,
              ),
              SizedBox(width: CoreSpacing.md(context)),
              Expanded(
                child: WidgetsAppButton(
                  label: l10n.productAddToCartAmount(totalText),
                  onPressed: onAdd,
                  icon: Icons.add_shopping_cart_outlined,
                  fullWidth: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

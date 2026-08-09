import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/data/mockup/mockup_catalog.dart';
import 'package:ayletna_restaurant_app/data/models/model_menu_item.dart';
import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:ayletna_restaurant_app/navigation/app_route_paths.dart';
import 'package:ayletna_restaurant_app/data/models/model_cart_customization_option.dart';
import 'package:ayletna_restaurant_app/providers/admin_catalog_providers.dart';
import 'package:ayletna_restaurant_app/providers/admin_session_providers.dart';
import 'package:ayletna_restaurant_app/providers/app_providers.dart';
import 'package:ayletna_restaurant_app/providers/menu_providers.dart';
import 'package:ayletna_restaurant_app/utilities/utility_menu_price_audit.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_info_banner.dart';
import 'package:ayletna_restaurant_app/utilities/utility_cart_option_labels.dart';
import 'package:ayletna_restaurant_app/utilities/utility_format_jod.dart';
import 'package:ayletna_restaurant_app/utilities/utility_mock_feedback.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_text_field.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_icon_bubble.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_icon_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_refresh_list.dart';
import 'package:ayletna_restaurant_app/utilities/utility_catalog_images.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_catalog_image_editor.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_scaffold_page.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_soft_badge.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// PRD [ProductEditorScreen].
class AdminProductEditorScreen extends ConsumerStatefulWidget {
  const AdminProductEditorScreen({
    super.key,
    this.createMode = false,
    this.productId,
  });

  final bool createMode;
  final String? productId;

  @override
  ConsumerState<AdminProductEditorScreen> createState() =>
      _AdminProductEditorScreenState();
}

class _AdminProductEditorScreenState
    extends ConsumerState<AdminProductEditorScreen> {
  var _available = true;
  var _featured = true;
  var _selectedStation = PrepStation.shawarma;
  var _selectedCategoryId = 'shawarma';
  final _selectedModifiers = <String>{};
  List<String> _imageUrls = const [];
  late final TextEditingController _nameAr;
  late final TextEditingController _nameEn;
  late final TextEditingController _descAr;
  late final TextEditingController _descEn;
  late final TextEditingController _price;

  @override
  void initState() {
    super.initState();
    _nameAr = TextEditingController();
    _nameEn = TextEditingController();
    _descAr = TextEditingController();
    _descEn = TextEditingController();
    _price = TextEditingController(text: widget.createMode ? '5.00' : '');
    if (!widget.createMode && widget.productId != null) {
      final overrides = ref.read(adminMenuProvider).catalogItemOverrides;
      final override = overrides[widget.productId!];
      final item =
          override ??
          MockupCatalog.itemById(widget.productId!) ??
          MockupCatalog.items.first;
      _nameAr.text = item.nameAr;
      _nameEn.text = item.nameEn;
      _descAr.text = item.descriptionAr;
      _descEn.text = item.descriptionEn;
      _price.text = item.priceJod.toStringAsFixed(2);
      _imageUrls = [...item.resolvedImageUrls];
    } else if (!widget.createMode) {
      final item = MockupCatalog.items.firstWhere(
        (candidate) => candidate.id == 'shawarma_meal_super',
        orElse: () => MockupCatalog.items.first,
      );
      _nameAr.text = item.nameAr;
      _nameEn.text = item.nameEn;
      _descAr.text = item.descriptionAr;
      _descEn.text = item.descriptionEn;
      _price.text = item.priceJod.toStringAsFixed(2);
      _imageUrls = [...item.resolvedImageUrls];
    }
  }

  @override
  void dispose() {
    _nameAr.dispose();
    _nameEn.dispose();
    _descAr.dispose();
    _descEn.dispose();
    _price.dispose();
    super.dispose();
  }

  ModelMenuItem _resolveItem() {
    if (widget.createMode) {
      return ModelMenuItem(
        id: 'draft_new',
        categoryId: _selectedCategoryId,
        nameAr: _nameAr.text,
        nameEn: _nameEn.text,
        priceJod: double.tryParse(_price.text) ?? 0,
        descriptionAr: _descAr.text,
        descriptionEn: _descEn.text,
        imageUrls: _imageUrls,
        imageUrl: _imageUrls.isNotEmpty ? _imageUrls.first : null,
        isAvailable: _available,
        isFeatured: _featured,
        prepStation: _selectedStation,
      );
    }
    final editId = widget.productId;
    if (editId != null) {
      final adminItems = ref.read(adminMenuProvider).addedMenuItems;
      for (final adminItem in adminItems) {
        if (adminItem.id == editId) return adminItem;
      }
      final override = ref.read(adminMenuProvider).catalogItemOverrides[editId];
      if (override != null) return override;
      return MockupCatalog.itemById(editId) ??
          MockupCatalog.items.first;
    }
    return MockupCatalog.items.firstWhere(
      (candidate) => candidate.id == 'shawarma_meal_super',
      orElse: () => MockupCatalog.items.first,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isAr = Localizations.localeOf(context).languageCode == 'ar';
    final item = _resolveItem();
    final isMarketing = ref.watch(appRoleProvider) == AppRole.marketing;

    return WidgetsScaffoldPage(
      title:
          widget.createMode
              ? l10n.productEditorAddMenuItem
              : l10n.screenProductEditor,
      actions: [
        WidgetsIconButton(
          onPressed: () => context.push(AppRoutePaths.operatorMenu),
          icon: Icons.restaurant_menu_outlined,
          tooltip: l10n.screenMenuManagement,
        ),
        WidgetsIconButton(
          onPressed: () {
            if (widget.createMode) {
              UtilityMockFeedback.showInfo(
                context,
                l10n.productEditorSaveFirst,
              );
              return;
            }
            final previewId = widget.productId ?? item.id;
            ref.read(selectedMenuItemIdProvider.notifier).state = previewId;
            context.push(AppRoutePaths.productDetail);
          },
          icon: Icons.visibility_outlined,
          tooltip: l10n.productEditorPreview,
        ),
      ],
      child: WidgetsRefreshList(
        onRefresh: () async {
          ref.invalidate(menuAllItemsProvider);
          ref.invalidate(visiblePortionOptionsProvider);
        },
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth >= 860;
            final editor = Column(
              children: [
                if (isMarketing) ...[
                  WidgetsInfoBanner(
                    title: l10n.marketingMenuPricePublishTitle,
                    message: l10n.marketingMenuPricePublishBanner,
                    icon: Icons.sell_outlined,
                  ),
                  SizedBox(height: CoreSpacing.lg(context)),
                ],
                _IdentityCard(
                  item: item,
                  isAr: isAr,
                  nameAr: _nameAr,
                  nameEn: _nameEn,
                  descAr: _descAr,
                  descEn: _descEn,
                  editable: widget.createMode || widget.productId != null,
                ),
                SizedBox(height: CoreSpacing.lg(context)),
                _PricingAndVariantsCard(
                  item: item,
                  l10n: l10n,
                  isAr: isAr,
                  priceController: _price,
                  editable: widget.createMode || widget.productId != null,
                ),
                SizedBox(height: CoreSpacing.lg(context)),
                _ModifiersCard(
                  selectedModifiers: _selectedModifiers,
                  onChanged:
                      (id, selected) => setState(() {
                        if (selected) {
                          _selectedModifiers.add(id);
                        } else {
                          _selectedModifiers.remove(id);
                        }
                      }),
                  isAr: isAr,
                  l10n: l10n,
                ),
              ],
            );
            final operations = Column(
              children: [
                _MediaCard(
                  item: item,
                  isAr: isAr,
                  imageUrls: _imageUrls,
                  onImagesChanged:
                      (urls) => setState(() => _imageUrls = urls),
                ),
                SizedBox(height: CoreSpacing.lg(context)),
                _CategoryCard(
                  selectedCategoryId: _selectedCategoryId,
                  onChanged:
                      (id) => setState(() => _selectedCategoryId = id),
                  isAr: isAr,
                ),
                SizedBox(height: CoreSpacing.lg(context)),
                _StationCard(
                  selectedStation: _selectedStation,
                  onChanged:
                      (station) => setState(() => _selectedStation = station),
                  isAr: isAr,
                ),
                SizedBox(height: CoreSpacing.lg(context)),
                _AvailabilityCard(
                  available: _available,
                  featured: _featured,
                  onAvailableChanged:
                      (value) => setState(() => _available = value),
                  onFeaturedChanged:
                      (value) => setState(() => _featured = value),
                  isAr: isAr,
                ),
                SizedBox(height: CoreSpacing.lg(context)),
                _SavePanel(
                  l10n: l10n,
                  isAr: isAr,
                  createMode: widget.createMode,
                  nameAr: _nameAr.text,
                  nameEn: _nameEn.text,
                  descAr: _descAr.text,
                  descEn: _descEn.text,
                  priceJod: double.tryParse(_price.text) ?? 0,
                  productId: item.id,
                  imageUrls: _imageUrls,
                  selectedCategoryId: _selectedCategoryId,
                  selectedStation: _selectedStation,
                  available: _available,
                  featured: _featured,
                ),
              ],
            );

            return ListView(
              padding: EdgeInsetsDirectional.only(
                top: CoreSpacing.md(context),
                bottom: CoreSpacing.xxl(context),
              ),
              children: [
                _EditorHero(item: item, l10n: l10n, isAr: isAr),
                SizedBox(height: CoreSpacing.lg(context)),
                if (isWide)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(flex: 6, child: editor),
                      SizedBox(width: CoreSpacing.lg(context)),
                      Expanded(flex: 4, child: operations),
                    ],
                  )
                else ...[
                  editor,
                  SizedBox(height: CoreSpacing.lg(context)),
                  operations,
                ],
              ],
            );
          },
        ),
      ),
    );
  }
}

class _EditorHero extends StatelessWidget {
  const _EditorHero({
    required this.item,
    required this.l10n,
    required this.isAr,
  });

  final ModelMenuItem item;
  final AppLocalizations l10n;
  final bool isAr;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(CoreSpacing.lg(context)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(CoreSpacing.radiusCardOf(context)),
        gradient: const LinearGradient(
          colors: [CoreColors.brandOlive, CoreColors.brandBrown],
          begin: AlignmentDirectional.topStart,
          end: AlignmentDirectional.bottomEnd,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                WidgetsSoftBadge(
                  label: l10n.productEditorBadge,
                  color: CoreColors.surfaceLight,
                  foreground: CoreColors.brandBrown,
                ),
                SizedBox(height: CoreSpacing.md(context)),
                Text(
                  l10n.productEditorHeroHeadline,
                  style: CoreTypography.headlineSmall(
                    context,
                    CoreColors.surfaceLight,
                  ).copyWith(fontWeight: FontWeight.w900),
                ),
                SizedBox(height: CoreSpacing.sm(context)),
                Text(
                  isAr ? item.nameAr : item.nameEn,
                  style: CoreTypography.bodyMedium(
                    context,
                    CoreColors.surfaceLight.withValues(alpha: 0.86),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: CoreSpacing.md(context)),
          _FoodPreview(color: CoreColors.surfaceLight, compact: true),
        ],
      ),
    );
  }
}

class _IdentityCard extends StatelessWidget {
  const _IdentityCard({
    required this.item,
    required this.isAr,
    this.nameAr,
    this.nameEn,
    this.descAr,
    this.descEn,
    this.editable = false,
  });

  final ModelMenuItem item;
  final bool isAr;
  final TextEditingController? nameAr;
  final TextEditingController? nameEn;
  final TextEditingController? descAr;
  final TextEditingController? descEn;
  final bool editable;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return WidgetsAppCard(
      title: l10n.productEditorNameSection,
      subtitle: l10n.productEditorIdentitySubtitle,
      leading: WidgetsIconBubble(
        icon: Icons.translate_outlined,
        color: CoreColors.brandOlive,
      ),
      child: Column(
        children: [
          WidgetsAppTextField(
            label: l10n.productEditorArabicName,
            controller: editable ? nameAr : null,
            initialValue: editable ? null : item.nameAr,
            prefixIcon: Icons.language_outlined,
          ),
          SizedBox(height: CoreSpacing.md(context)),
          WidgetsAppTextField(
            label: l10n.productEditorEnglishName,
            controller: editable ? nameEn : null,
            initialValue: editable ? null : item.nameEn,
            prefixIcon: Icons.abc_outlined,
          ),
          SizedBox(height: CoreSpacing.md(context)),
          WidgetsAppTextField(
            label: l10n.productEditorArabicDesc,
            controller: editable ? descAr : null,
            initialValue: editable ? null : item.descriptionAr,
            prefixIcon: Icons.notes_outlined,
            maxLines: 3,
          ),
          SizedBox(height: CoreSpacing.md(context)),
          WidgetsAppTextField(
            label: l10n.productEditorEnglishDesc,
            controller: editable ? descEn : null,
            initialValue: editable ? null : item.descriptionEn,
            prefixIcon: Icons.notes_outlined,
            maxLines: 3,
          ),
        ],
      ),
    );
  }
}

class _PricingAndVariantsCard extends ConsumerWidget {
  const _PricingAndVariantsCard({
    required this.item,
    required this.l10n,
    required this.isAr,
    this.priceController,
    this.editable = false,
  });

  final ModelMenuItem item;
  final AppLocalizations l10n;
  final bool isAr;
  final TextEditingController? priceController;
  final bool editable;

  static const _variantColors = [
    CoreColors.brandOlive,
    CoreColors.brandOrange,
    CoreColors.orderTypeDelivery,
    CoreColors.brandGold,
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final portions = ref.watch(visiblePortionOptionsProvider);

    return WidgetsAppCard(
      title: l10n.productEditorPricingSection,
      subtitle:
          isAr
              ? 'أحجام الحصة من الكatalog — تظهر للعميل في التفاصيل والسلة.'
              : 'Portion sizes from catalog — shown on detail and cart sheets.',
      leading: WidgetsIconBubble(
        icon: Icons.sell_outlined,
        color: CoreColors.semanticRevenue,
      ),
      child: Column(
        children: [
          WidgetsAppTextField(
            label: l10n.productEditorBasePrice,
            controller: editable ? priceController : null,
            initialValue:
                editable
                    ? null
                    : UtilityFormatJod.format(
                      item.priceJod,
                      suffix: l10n.currencyJod,
                    ),
            prefixIcon: Icons.payments_outlined,
            keyboardType: TextInputType.number,
          ),
          SizedBox(height: CoreSpacing.md(context)),
          for (var index = 0; index < portions.length; index++)
            _VariantRow(
              label: cartOptionLabel(portions[index].key, l10n),
              price: UtilityFormatJod.format(
                item.priceJod + portions[index].priceDeltaJod,
                suffix: l10n.currencyJod,
              ),
              color: _variantColors[index % _variantColors.length],
            ),
          SizedBox(height: CoreSpacing.sm(context)),
          WidgetsAppButton(
            label: l10n.productEditorAddVariant,
            onPressed: () => _showAddVariantDialog(context, ref),
            variant: WidgetsAppButtonVariant.outline,
            icon: Icons.add,
            fullWidth: true,
          ),
        ],
      ),
    );
  }

  Future<void> _showAddVariantDialog(BuildContext context, WidgetRef ref) async {
    final keyController = TextEditingController();
    final priceController = TextEditingController(text: '0');
    final added = await showDialog<bool>(
      context: context,
      builder:
          (dialogContext) => AlertDialog(
            title: Text(l10n.productEditorAddPortionTitle),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                WidgetsAppTextField(
                  controller: keyController,
                  label: l10n.productEditorPortionKeyLabel,
                ),
                SizedBox(height: CoreSpacing.md(context)),
                WidgetsAppTextField(
                  controller: priceController,
                  label: l10n.productEditorPortionPriceDelta,
                  keyboardType: TextInputType.number,
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(dialogContext, false),
                child: Text(l10n.actionCancel),
              ),
              TextButton(
                onPressed: () => Navigator.pop(dialogContext, true),
                child: Text(l10n.actionConfirm),
              ),
            ],
          ),
    );
    if (added != true || !context.mounted) {
      keyController.dispose();
      priceController.dispose();
      return;
    }
    final key = keyController.text.trim().toLowerCase().replaceAll(' ', '_');
    final delta = double.tryParse(priceController.text.trim()) ?? 0;
    keyController.dispose();
    priceController.dispose();
    if (key.isEmpty) {
      UtilityMockFeedback.showWarning(
        context,
        l10n.productEditorEnterPortionKey,
      );
      return;
    }
    final ok = ref
        .read(adminCatalogProvider.notifier)
        .addPortionOption(
          ModelCartCustomizationOption(key: key, priceDeltaJod: delta),
        );
    if (!context.mounted) return;
    UtilityMockFeedback.showSuccess(
      context,
      ok
          ? l10n.productEditorPortionAdded
          : l10n.productEditorPortionKeyExists,
    );
  }
}

class _ModifiersCard extends ConsumerWidget {
  const _ModifiersCard({
    required this.selectedModifiers,
    required this.onChanged,
    required this.isAr,
    required this.l10n,
  });

  final Set<String> selectedModifiers;
  final void Function(String id, bool selected) onChanged;
  final bool isAr;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final addons = ref.watch(visibleAddonsProvider);
    return WidgetsAppCard(
      title: l10n.productEditorModifiersSection,
      subtitle:
          isAr
              ? 'إضافات اختيارية تظهر في الكاشير والعميل.'
              : 'Optional choices shown to cashier and guest.',
      leading: WidgetsIconBubble(
        icon: Icons.tune_outlined,
        color: CoreColors.orderTypeTakeaway,
      ),
      child: Column(
        children: [
          if (addons.isEmpty)
            Text(
              l10n.productEditorNoAddons,
              style: CoreTypography.bodyMedium(
                context,
                Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            )
          else
            for (final addon in addons)
              _ModifierRow(
                data: _ModifierData(
                  id: addon.key,
                  labelAr: addon.labelAr,
                  labelEn: addon.labelEn,
                  priceJod: addon.priceDeltaJod,
                ),
                selected: selectedModifiers.contains(addon.key),
                onChanged: (value) => onChanged(addon.key, value),
                isAr: isAr,
                l10n: l10n,
              ),
        ],
      ),
    );
  }
}

class _MediaCard extends StatelessWidget {
  const _MediaCard({
    required this.item,
    required this.isAr,
    required this.imageUrls,
    required this.onImagesChanged,
  });

  final ModelMenuItem item;
  final bool isAr;
  final List<String> imageUrls;
  final ValueChanged<List<String>> onImagesChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return WidgetsAppCard(
      title: l10n.productEditorMediaSection,
      subtitle: l10n.productEditorMediaGalleryHint,
      leading: WidgetsIconBubble(
        icon: Icons.image_outlined,
        color: CoreColors.brandOrange,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            isAr ? item.nameAr : item.nameEn,
            style: CoreTypography.titleMedium(
              context,
              Theme.of(context).colorScheme.onSurface,
            ).copyWith(fontWeight: FontWeight.w900),
          ),
          SizedBox(height: CoreSpacing.xs(context)),
          Text(
            l10n.productEditorMediaUsage,
            style: CoreTypography.caption(
              context,
              Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          SizedBox(height: CoreSpacing.md(context)),
          WidgetsCatalogImageEditor(
            imageUrls: imageUrls,
            onChanged: onImagesChanged,
            isAr: isAr,
            minImages: CatalogImageLimits.minProductImages,
            maxImages: CatalogImageLimits.maxProductImages,
          ),
        ],
      ),
    );
  }
}

class _CategoryCard extends ConsumerWidget {
  const _CategoryCard({
    required this.selectedCategoryId,
    required this.onChanged,
    required this.isAr,
  });

  final String selectedCategoryId;
  final ValueChanged<String> onChanged;
  final bool isAr;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final categoriesAsync = ref.watch(menuCategoriesProvider);
    final categories = categoriesAsync.valueOrNull ?? const [];

    return WidgetsAppCard(
      title: l10n.categoryEyebrow,
      leading: WidgetsIconBubble(
        icon: Icons.category_outlined,
        color: CoreColors.brandBrown,
      ),
      child: DropdownButtonFormField<String>(
        initialValue: selectedCategoryId,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        ),
        items: categories.map((cat) {
          return DropdownMenuItem(
            value: cat.id,
            child: Text(isAr ? cat.nameAr : cat.nameEn),
          );
        }).toList(),
        onChanged: (val) {
          if (val != null) onChanged(val);
        },
      ),
    );
  }
}

class _StationCard extends StatelessWidget {
  const _StationCard({
    required this.selectedStation,
    required this.onChanged,
    required this.isAr,
  });

  final PrepStation selectedStation;
  final ValueChanged<PrepStation> onChanged;
  final bool isAr;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return WidgetsAppCard(
      title: l10n.productEditorPrepStationSection,
      subtitle: l10n.productEditorStationSubtitle,
      leading: WidgetsIconBubble(
        icon: Icons.soup_kitchen_outlined,
        color: CoreColors.brandBrown,
      ),
      child: Column(
        children: [
          for (final station in PrepStation.values)
            _StationOption(
              station: station,
              selected: station == selectedStation,
              onTap: () => onChanged(station),
              isAr: isAr,
            ),
        ],
      ),
    );
  }
}

class _AvailabilityCard extends StatelessWidget {
  const _AvailabilityCard({
    required this.available,
    required this.featured,
    required this.onAvailableChanged,
    required this.onFeaturedChanged,
    required this.isAr,
  });

  final bool available;
  final bool featured;
  final ValueChanged<bool> onAvailableChanged;
  final ValueChanged<bool> onFeaturedChanged;
  final bool isAr;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return WidgetsAppCard(
      title: l10n.productEditorAvailabilitySection,
      subtitle: l10n.productEditorAvailabilitySectionDesc,
      leading: WidgetsIconBubble(
        icon: Icons.toggle_on_outlined,
        color: CoreColors.semanticSuccess,
      ),
      child: Column(
        children: [
          _SwitchLine(
            label: l10n.productEditorAvailableNow,
            value: available,
            onChanged: onAvailableChanged,
          ),
          _SwitchLine(
            label: l10n.productEditorFeatured,
            value: featured,
            onChanged: onFeaturedChanged,
          ),
          SizedBox(height: CoreSpacing.sm(context)),
          Wrap(
            spacing: CoreSpacing.xs(context),
            runSpacing: CoreSpacing.xs(context),
            children: [
              WidgetsSoftBadge(
                label: l10n.orderTypeDineIn,
                color: CoreColors.orderTypeDineIn,
              ),
              WidgetsSoftBadge(
                label: l10n.orderTypeTakeaway,
                color: CoreColors.orderTypeTakeaway,
              ),
              WidgetsSoftBadge(
                label: l10n.orderTypeDelivery,
                color: CoreColors.orderTypeDelivery,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SavePanel extends ConsumerWidget {
  const _SavePanel({
    required this.l10n,
    required this.isAr,
    required this.createMode,
    required this.nameAr,
    required this.nameEn,
    required this.descAr,
    required this.descEn,
    required this.priceJod,
    required this.productId,
    this.imageUrls = const [],
    required this.selectedCategoryId,
    required this.selectedStation,
    required this.available,
    required this.featured,
  });

  final AppLocalizations l10n;
  final bool isAr;
  final bool createMode;
  final String nameAr;
  final String nameEn;
  final String descAr;
  final String descEn;
  final double priceJod;
  final String productId;
  final List<String> imageUrls;
  final String selectedCategoryId;
  final PrepStation selectedStation;
  final bool available;
  final bool featured;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return WidgetsAppCard(
      title: l10n.productEditorSavePublishSection,
      subtitle:
          createMode
              ? l10n.productEditorSavePublishCreateDesc
              : l10n.productEditorSavePublishEditDesc,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          WidgetsAppButton(
            label: l10n.actionSave,
            onPressed: () {
              if (imageUrls.length < CatalogImageLimits.minProductImages) {
                UtilityMockFeedback.showWarning(
                  context,
                  l10n.productEditorAddMinImages,
                );
                return;
              }
              final savedItem = ModelMenuItem(
                id: productId,
                categoryId: selectedCategoryId,
                nameAr: nameAr,
                nameEn: nameEn,
                priceJod: priceJod,
                descriptionAr: descAr,
                descriptionEn: descEn,
                imageUrls: imageUrls,
                imageUrl: imageUrls.first,
                isAvailable: available,
                isFeatured: featured,
                prepStation: selectedStation,
              );
              var ok = false;
              if (!createMode &&
                  productId.isNotEmpty &&
                  productId != 'draft_new') {
                recordMenuPriceChangeIfNeeded(
                  ref,
                  productId: productId,
                  productNameEn:
                      nameEn.trim().isNotEmpty ? nameEn.trim() : productId,
                  newPriceJod: priceJod,
                );
              }
              if (productId.startsWith('menu_custom_')) {
                ok = ref.read(adminMenuProvider.notifier).updateAddedMenuItem(savedItem);
              } else if (!createMode && productId.isNotEmpty && productId != 'draft_new') {
                ok = ref.read(adminMenuProvider.notifier).upsertCatalogItemOverride(savedItem);
              } else if (createMode) {
                ok = nameEn.trim().isNotEmpty && priceJod > 0;
              }
              if (!ok) {
                UtilityMockFeedback.showWarning(
                  context,
                  l10n.productEditorCheckRequiredFields,
                );
                return;
              }
              UtilityMockFeedback.showSuccess(
                context,
                l10n.productEditorMenuItemSaved,
              );
            },
            icon: Icons.save_outlined,
          ),
          SizedBox(height: CoreSpacing.sm(context)),
          WidgetsAppButton(
            label: l10n.productEditorPublishToMenu,
            onPressed:
                () => UtilityMockFeedback.showActionSheet(
                  context: context,
                  title: l10n.productEditorPublishTitle,
                  message: l10n.productEditorPublishMessage,
                  actions: [
                    MockSheetAction(
                      label: l10n.actionConfirm,
                      icon: Icons.publish_outlined,
                      onSelected: () {
                        if (imageUrls.length < CatalogImageLimits.minProductImages) {
                          UtilityMockFeedback.showWarning(
                            context,
                            l10n.productEditorAddImageBeforePublish,
                          );
                          return;
                        }
                        if (createMode) {
                          final created = ref
                              .read(adminMenuProvider.notifier)
                              .addMenuItem(
                                nameAr: nameAr,
                                nameEn: nameEn,
                                descriptionAr: descAr,
                                descriptionEn: descEn,
                                priceJod: priceJod,
                                imageUrls: imageUrls,
                                categoryId: selectedCategoryId,
                                isAvailable: available,
                                isFeatured: featured,
                                prepStation: selectedStation,
                              );
                          if (created == null) {
                            UtilityMockFeedback.showWarning(
                              context,
                              l10n.productEditorCheckNamePrice,
                            );
                            return;
                          }
                        } else {
                          recordMenuPriceChangeIfNeeded(
                            ref,
                            productId: productId,
                            productNameEn:
                                nameEn.trim().isNotEmpty ? nameEn.trim() : productId,
                            newPriceJod: priceJod,
                          );
                          ref
                              .read(adminMenuProvider.notifier)
                              .publishProduct(
                                productId.startsWith('menu_custom_')
                                    ? productId
                                    : productId,
                              );
                        }
                        UtilityMockFeedback.showSuccess(
                          context,
                          l10n.productEditorPublished,
                        );
                        context.push(AppRoutePaths.operatorMenu);
                      },
                    ),
                  ],
                ),
            icon: Icons.publish_outlined,
            variant: WidgetsAppButtonVariant.secondary,
          ),
          SizedBox(height: CoreSpacing.sm(context)),
          WidgetsAppButton(
            label: l10n.productEditorBackToMenu,
            onPressed: () => context.push(AppRoutePaths.operatorMenu),
            icon: Icons.arrow_back,
            variant: WidgetsAppButtonVariant.outline,
          ),
        ],
      ),
    );
  }
}

class _VariantRow extends StatelessWidget {
  const _VariantRow({
    required this.label,
    required this.price,
    required this.color,
  });

  final String label;
  final String price;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: CoreSpacing.sm(context)),
      padding: EdgeInsets.all(CoreSpacing.md(context)),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(CoreSpacing.radiusCardOf(context)),
      ),
      child: Row(
        children: [
          WidgetsSoftBadge(label: label, color: color),
          SizedBox(width: CoreSpacing.sm(context)),
          Expanded(
            child: Text(
              price,
              textAlign: TextAlign.end,
              style: CoreTypography.titleMedium(
                context,
                Theme.of(context).colorScheme.onSurface,
              ).copyWith(fontWeight: FontWeight.w900),
            ),
          ),
        ],
      ),
    );
  }
}

class _ModifierRow extends StatelessWidget {
  const _ModifierRow({
    required this.data,
    required this.selected,
    required this.onChanged,
    required this.isAr,
    required this.l10n,
  });

  final _ModifierData data;
  final bool selected;
  final ValueChanged<bool> onChanged;
  final bool isAr;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      value: selected,
      onChanged: (value) => onChanged(value ?? false),
      contentPadding: EdgeInsets.zero,
      title: Text(isAr ? data.labelAr : data.labelEn),
      subtitle: Text(
        UtilityFormatJod.format(data.priceJod, suffix: l10n.currencyJod),
      ),
    );
  }
}

class _StationOption extends StatelessWidget {
  const _StationOption({
    required this.station,
    required this.selected,
    required this.onTap,
    required this.isAr,
  });

  final PrepStation station;
  final bool selected;
  final VoidCallback onTap;
  final bool isAr;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final color = selected ? CoreColors.brandOlive : CoreColors.brandBrown;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(CoreSpacing.radiusCardOf(context)),
      child: Container(
        margin: EdgeInsets.only(bottom: CoreSpacing.sm(context)),
        padding: EdgeInsets.all(CoreSpacing.md(context)),
        decoration: BoxDecoration(
          color: color.withValues(alpha: selected ? 0.12 : 0.06),
          borderRadius: BorderRadius.circular(CoreSpacing.radiusCardOf(context)),
          border: Border.all(
            color: color.withValues(alpha: selected ? 0.35 : 0.14),
          ),
        ),
        child: Row(
          children: [
            Icon(
              selected ? Icons.radio_button_checked : Icons.radio_button_off,
              color: color,
            ),
            SizedBox(width: CoreSpacing.sm(context)),
            Expanded(
              child: Text(
                station.label(l10n),
                style: CoreTypography.titleMedium(
                  context,
                  Theme.of(context).colorScheme.onSurface,
                ).copyWith(fontWeight: FontWeight.w800),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SwitchLine extends StatelessWidget {
  const _SwitchLine({
    required this.label,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(
        label,
        style: CoreTypography.titleMedium(
          context,
          Theme.of(context).colorScheme.onSurface,
        ).copyWith(fontWeight: FontWeight.w800),
      ),
      value: value,
      activeThumbColor: CoreColors.brandOlive,
      onChanged: onChanged,
    );
  }
}

class _FoodPreview extends StatelessWidget {
  const _FoodPreview({required this.color, this.compact = false});

  final Color color;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(CoreSpacing.radiusCardOf(context)),
      child: SizedBox(
        width: compact ? 96 : double.infinity,
        height: compact ? 96 : CoreContentSizes.heroImageHeight(context) * 0.58,
        child: CustomPaint(
          painter: _MenuItemPainter(color: color),
          child: Align(
            alignment: AlignmentDirectional.bottomStart,
            child: Padding(
              padding: EdgeInsets.all(CoreSpacing.md(context)),
              child: Icon(
                Icons.restaurant_menu_outlined,
                color:
                    compact ? CoreColors.brandBrown : CoreColors.surfaceLight,
                size: compact ? 28 : 42,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _MenuItemPainter extends CustomPainter {
  const _MenuItemPainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final bg =
        Paint()
          ..shader = LinearGradient(
            colors: [color.withValues(alpha: 0.28), CoreColors.brandBrown],
            begin: AlignmentDirectional.topStart,
            end: AlignmentDirectional.bottomEnd,
          ).createShader(Offset.zero & size);
    canvas.drawRect(Offset.zero & size, bg);

    final plate =
        Paint()
          ..color = CoreColors.surfaceLight.withValues(alpha: 0.92)
          ..style = PaintingStyle.fill;
    final center = Offset(size.width * 0.58, size.height * 0.46);
    canvas.drawOval(
      Rect.fromCenter(
        center: center,
        width: size.width * 0.52,
        height: size.height * 0.32,
      ),
      plate,
    );

    final garnish =
        Paint()
          ..color = CoreColors.brandOlive.withValues(alpha: 0.86)
          ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(center.dx - 18, center.dy - 2), 9, garnish);
    canvas.drawCircle(
      Offset(center.dx + 14, center.dy + 4),
      11,
      Paint()..color = CoreColors.brandOrange.withValues(alpha: 0.90),
    );
  }

  @override
  bool shouldRepaint(covariant _MenuItemPainter oldDelegate) {
    return oldDelegate.color != color;
  }
}

class _ModifierData {
  const _ModifierData({
    required this.id,
    required this.labelAr,
    required this.labelEn,
    required this.priceJod,
  });

  final String id;
  final String labelAr;
  final String labelEn;
  final double priceJod;
}

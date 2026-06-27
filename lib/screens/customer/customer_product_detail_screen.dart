import 'dart:math' as math;

import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/data/mockup/mockup_catalog.dart';
import 'package:ayletna_restaurant_app/data/models/model_cart_customization_option.dart';
import 'package:ayletna_restaurant_app/data/models/model_menu_item.dart';
import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:ayletna_restaurant_app/navigation/app_route_paths.dart';
import 'package:ayletna_restaurant_app/data/models/model_admin_catalog.dart';
import 'package:ayletna_restaurant_app/providers/admin_catalog_providers.dart';
import 'package:ayletna_restaurant_app/providers/rewards_admin_providers.dart';
import 'package:ayletna_restaurant_app/providers/cart_providers.dart';
import 'package:ayletna_restaurant_app/providers/menu_providers.dart';
import 'package:ayletna_restaurant_app/providers/reviews_admin_providers.dart';
import 'package:ayletna_restaurant_app/utilities/utility_cart_option_labels.dart';
import 'package:ayletna_restaurant_app/utilities/utility_format_jod.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_text_field.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_cart_customization_sheet.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_cart_icon_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_icon_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_mock_food_image.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_price_badge.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_quantity_stepper.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_scaffold_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// PRD ProductDetailScreen.
class CustomerProductDetailScreen extends ConsumerStatefulWidget {
  const CustomerProductDetailScreen({super.key});

  @override
  ConsumerState<CustomerProductDetailScreen> createState() =>
      _CustomerProductDetailScreenState();
}

class _CustomerProductDetailScreenState
    extends ConsumerState<CustomerProductDetailScreen> {
  int _quantity = 1;
  String _portionKey = 'single';
  final Set<String> _selectedAddonKeys = {};
  int _galleryIndex = 0;
  late final PageController _galleryController;
  final _instructionsController = TextEditingController();

  static const _fallbackPrice = 14.50;

  @override
  void initState() {
    super.initState();
    _galleryController = PageController();
  }

  @override
  void dispose() {
    _galleryController.dispose();
    _instructionsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isAr = Localizations.localeOf(context).languageCode == 'ar';
    final item = ref.watch(selectedMenuItemProvider);
    final scheme = Theme.of(context).colorScheme;
    final productName =
        item == null
            ? l10n.productMansafTitle
            : (isAr ? item.nameAr : item.nameEn);
    final productDescription =
        item == null
            ? l10n.productMansafDescription
            : (isAr ? item.descriptionAr : item.descriptionEn);
    final basePrice = item?.priceJod ?? _fallbackPrice;
    final addons = ref.watch(visibleAddonsProvider);
    final portions = ref.watch(visiblePortionOptionsProvider);
    final total = _calculateTotal(basePrice, portions, addons);
    final totalText = UtilityFormatJod.format(total, suffix: l10n.currencyJod);
    final galleryImages = _galleryImagesFor(item?.imageUrl);
    final relatedItems = _relatedItemsFor(item, ref);

    return WidgetsScaffoldPage(
      title: productName,
      actions: [
        WidgetsIconButton(
          onPressed: () => context.push(AppRoutePaths.notifications),
          icon: Icons.notifications_outlined,
          tooltip: l10n.screenNotifications,
        ),
        const WidgetsCartIconButton(),
      ],
      bottomSheet: _StickyCartPanel(
        quantity: _quantity,
        totalText: totalText,
        onMinus:
            () => setState(() {
              if (_quantity > 1) {
                _quantity--;
              }
            }),
        onPlus: () => setState(() => _quantity++),
        onAdd: () {
          if (item != null) {
            final remarks = _instructionsController.text.trim();
            final configuration = _configurationSummary(l10n, portions, addons);
            final configKey = [
              _portionKey,
              ..._selectedAddonKeys,
              if (remarks.isNotEmpty) 'r:$remarks',
            ].join('|');
            ref
                .read(cartProvider.notifier)
                .addConfiguredItem(
                  item: item,
                  quantity: _quantity,
                  unitPriceJod: total / _quantity,
                  configurationKey: configKey,
                  configurationAr: configuration,
                  configurationEn: configuration,
                  remarks: remarks.isEmpty ? null : remarks,
                );
          }
          final pointsEarned =
              (total * ref.read(rewardsCatalogProvider).pointsPerJod).round();
          if (pointsEarned > 0) {
            ref.read(loyaltyPointsProvider.notifier).addPoints(
              pointsEarned,
              titleEn: 'Order add-on',
              titleAr: 'إضافة للطلب',
            );
          }
          _showRewardCartDialog(context, pointsEarned > 0 ? pointsEarned : 10 * _quantity);
        },
      ),
      child: ListView(
        padding: EdgeInsetsDirectional.only(
          top: CoreSpacing.md(context),
          bottom: CoreSpacing.xxl(context) * 3,
        ),
        children: [
          _ProductGallery(
            imageUrls: galleryImages,
            selectedIndex: _galleryIndex,
            controller: _galleryController,
            onChanged: (index) => setState(() => _galleryIndex = index),
            onSelected: (index) {
              setState(() => _galleryIndex = index);
              _galleryController.animateToPage(
                index,
                duration: const Duration(milliseconds: 260),
                curve: Curves.easeOutCubic,
              );
            },
          ),
          SizedBox(height: CoreSpacing.lg(context)),
          Text(
            productName,
            style: CoreTypography.headlineLarge(
              context,
              scheme.onSurface,
            ).copyWith(fontWeight: FontWeight.w900),
          ),
          SizedBox(height: CoreSpacing.sm(context)),
          Wrap(
            spacing: CoreSpacing.sm(context),
            runSpacing: CoreSpacing.xs(context),
            children: [
              _FoodTag(
                label: l10n.orderTypeDineIn,
                color: CoreColors.orderTypeDineIn,
              ),
              _FoodTag(label: l10n.productBestSeller, color: scheme.primary),
            ],
          ),
          SizedBox(height: CoreSpacing.md(context)),
          _MetaRow(
            l10n: l10n,
            onRatingTap: () => _showReviewPreview(
              context,
              productName,
              ref.watch(approvedReviewsForProductProvider(item?.id)),
            ),
          ),
          SizedBox(height: CoreSpacing.md(context)),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              WidgetsPriceBadge(
                priceLabel: UtilityFormatJod.format(
                  basePrice,
                  suffix: l10n.currencyJod,
                ),
              ),
              SizedBox(width: CoreSpacing.md(context)),
              Expanded(
                child: Text(
                  l10n.productInclVat,
                  style: CoreTypography.caption(
                    context,
                    scheme.onSurfaceVariant,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: CoreSpacing.lg(context)),
          Text(
            productDescription,
            style: CoreTypography.bodyMedium(context, scheme.onSurfaceVariant),
          ),
          SizedBox(height: CoreSpacing.xl(context)),
          _PortionSection(
            selectedKey: _portionKey,
            onChanged: (key) => setState(() => _portionKey = key),
          ),
          SizedBox(height: CoreSpacing.xl(context)),
          _AddonsSection(
            selectedKeys: _selectedAddonKeys,
            onToggle: (key, selected) {
              setState(() {
                if (selected) {
                  _selectedAddonKeys.add(key);
                } else {
                  _selectedAddonKeys.remove(key);
                }
              });
            },
          ),
          SizedBox(height: CoreSpacing.xl(context)),
          WidgetsAppTextField(
            label: l10n.productSpecialInstructions,
            controller: _instructionsController,
            maxLines: 4,
            hintText: l10n.productInstructionsHint,
          ),
          if (relatedItems.isNotEmpty) ...[
            SizedBox(height: CoreSpacing.xl(context)),
            _RelatedProductsRail(
              items: relatedItems,
              isAr: isAr,
              l10n: l10n,
              onOpen: (relatedItem) {
                ref.read(selectedMenuItemIdProvider.notifier).state =
                    relatedItem.id;
                setState(() {
                  _galleryIndex = 0;
                  _quantity = 1;
                  _portionKey = 'single';
                  _selectedAddonKeys.clear();
                  _instructionsController.clear();
                });
                _galleryController.jumpToPage(0);
              },
              onAdd:
                  (relatedItem) => showWidgetsCartCustomizationSheet(
                    context: context,
                    item: relatedItem,
                  ),
            ),
          ],
        ],
      ),
    );
  }

  List<String?> _galleryImagesFor(String? primaryImageUrl) {
    return [
      primaryImageUrl,
      'https://images.unsplash.com/photo-1544025162-d76694265947?auto=format&fit=crop&w=1200&q=82',
      'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?auto=format&fit=crop&w=1200&q=82',
      'https://images.unsplash.com/photo-1550547660-d9450f859349?auto=format&fit=crop&w=1200&q=82',
      'https://images.unsplash.com/photo-1529042410759-befb1204b468?auto=format&fit=crop&w=1200&q=82',
      'https://images.unsplash.com/photo-1540189549336-e6e99c3679fe?auto=format&fit=crop&w=1200&q=82',
    ].take(5).toList();
  }

  List<ModelMenuItem> _relatedItemsFor(ModelMenuItem? item, WidgetRef ref) {
    if (item == null) {
      return MockupCatalog.items.take(8).toList();
    }

    final adminRelated = ref.watch(relatedProductsForItemProvider(item.id));
    if (adminRelated.isNotEmpty) {
      return [
        for (final id in adminRelated)
          if (ref.watch(menuItemByIdProvider(id)) case final related?) related,
      ];
    }

    final sameCategory =
        MockupCatalog.items
            .where(
              (candidate) =>
                  candidate.categoryId == item.categoryId &&
                  candidate.id != item.id,
            )
            .take(8)
            .toList();
    if (sameCategory.isNotEmpty) {
      return sameCategory;
    }

    return MockupCatalog.items
        .where((candidate) => candidate.id != item.id)
        .take(8)
        .toList();
  }

  void _showReviewPreview(
    BuildContext context,
    String productName,
    List<ProductReviewRecord> reviews,
  ) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      builder:
          (context) => _ReviewPreviewSheet(
            productName: productName,
            reviews: reviews.take(10).toList(),
          ),
    );
  }

  double _calculateTotal(
    double basePrice,
    List<ModelCartCustomizationOption> portions,
    List<ModelMenuAddon> addons,
  ) {
    final portionPrice = portions
        .where((option) => option.key == _portionKey)
        .fold(0.0, (sum, option) => sum + option.priceDeltaJod);
    final addonPrice = addons
        .where((addon) => _selectedAddonKeys.contains(addon.key))
        .fold(0.0, (sum, addon) => sum + addon.priceDeltaJod);
    return (basePrice + portionPrice + addonPrice) * _quantity;
  }

  String _configurationSummary(
    AppLocalizations l10n,
    List<ModelCartCustomizationOption> portions,
    List<ModelMenuAddon> addons,
  ) {
    final isAr = Localizations.localeOf(context).languageCode == 'ar';
    final parts = <String>[
      cartOptionLabel(_portionKey, l10n),
      for (final addon in addons.where((a) => _selectedAddonKeys.contains(a.key)))
        isAr ? addon.labelAr : addon.labelEn,
    ];
    return parts.join(' • ');
  }

  Future<void> _showRewardCartDialog(BuildContext context, int quantity) {
    return showDialog<void>(
      context: context,
      builder: (dialogContext) => _CartRewardDialog(rewardCoins: 10 * quantity),
    );
  }
}

class _CartRewardDialog extends StatelessWidget {
  const _CartRewardDialog({required this.rewardCoins});

  final int rewardCoins;

  @override
  Widget build(BuildContext context) {
    final isAr = Localizations.localeOf(context).languageCode == 'ar';
    final scheme = Theme.of(context).colorScheme;
    final coinLabel = isAr ? '$rewardCoins عملات' : '$rewardCoins coins';

    return Dialog(
      insetPadding: EdgeInsets.symmetric(
        horizontal: CoreSpacing.xl(context),
        vertical: CoreSpacing.xl(context),
      ),
      backgroundColor: Colors.transparent,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 560),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: scheme.surface,
            borderRadius: BorderRadius.circular(CoreSpacing.radiusCard),
          ),
          child: Padding(
            padding: EdgeInsets.all(CoreSpacing.lg(context)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: WidgetsIconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icons.close,
                    tooltip:
                        MaterialLocalizations.of(context).closeButtonTooltip,
                    variant: WidgetsIconButtonVariant.tonal,
                  ),
                ),
                SizedBox(height: CoreSpacing.sm(context)),
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: CoreColors.brandGold.withValues(alpha: 0.14),
                    shape: BoxShape.circle,
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(CoreSpacing.lg(context)),
                    child: const Icon(
                      Icons.stars_rounded,
                      color: CoreColors.brandGold,
                      size: 44,
                    ),
                  ),
                ),
                SizedBox(height: CoreSpacing.lg(context)),
                Text(
                  isAr ? 'تمت الإضافة للسلة' : 'Added to cart',
                  textAlign: TextAlign.center,
                  style: CoreTypography.headlineSmall(
                    context,
                    scheme.onSurface,
                  ).copyWith(fontWeight: FontWeight.w900),
                ),
                SizedBox(height: CoreSpacing.md(context)),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: CoreTypography.bodyMedium(
                      context,
                      scheme.onSurfaceVariant,
                    ),
                    children:
                        isAr
                            ? [
                              const TextSpan(text: 'أنت على وشك كسب '),
                              TextSpan(
                                text: coinLabel,
                                style: TextStyle(
                                  color: scheme.primary,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              const TextSpan(
                                text:
                                    ' مع هذا الطلب. استمر بتجميع المكافآت واستبدلها لاحقاً بخصومات وهدايا من عيلتنا.',
                              ),
                            ]
                            : [
                              const TextSpan(text: 'You are about to earn '),
                              TextSpan(
                                text: coinLabel,
                                style: TextStyle(
                                  color: scheme.primary,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              const TextSpan(
                                text:
                                    ' with this item. Keep collecting rewards and redeem them later for Ayletna discounts and treats.',
                              ),
                            ],
                  ),
                ),
                SizedBox(height: CoreSpacing.xl(context)),
                WidgetsAppButton(
                  label: isAr ? 'متابعة التسوق' : 'Continue shopping',
                  onPressed: () {
                    final router = GoRouter.of(context);
                    Navigator.of(context).pop();
                    router.go(AppRoutePaths.category);
                  },
                  icon: Icons.restaurant_menu_outlined,
                  variant: WidgetsAppButtonVariant.outline,
                  fullWidth: true,
                ),
                SizedBox(height: CoreSpacing.sm(context)),
                WidgetsAppButton(
                  label: isAr ? 'الدفع' : 'Checkout',
                  onPressed: () {
                    final router = GoRouter.of(context);
                    Navigator.of(context).pop();
                    router.go(AppRoutePaths.cart);
                  },
                  icon: Icons.shopping_cart_checkout_outlined,
                  fullWidth: true,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ProductGallery extends StatelessWidget {
  const _ProductGallery({
    required this.imageUrls,
    required this.selectedIndex,
    required this.controller,
    required this.onChanged,
    required this.onSelected,
  });

  final List<String?> imageUrls;
  final int selectedIndex;
  final PageController controller;
  final ValueChanged<int> onChanged;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    return WidgetsAppCard(
      variant: WidgetsAppCardVariant.food,
      padding: EdgeInsets.all(CoreSpacing.md(context)),
      child: Column(
        children: [
          SizedBox(
            height: CoreContentSizes.categoryHeroHeight(context) * 0.86,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(CoreSpacing.radiusCard),
              child: PageView.builder(
                controller: controller,
                itemCount: imageUrls.length,
                onPageChanged: onChanged,
                itemBuilder:
                    (context, index) => WidgetsMockFoodImage(
                      imageUrl: imageUrls[index],
                      fallback: _GalleryFallback(index: index),
                    ),
              ),
            ),
          ),
          SizedBox(height: CoreSpacing.md(context)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (var index = 0; index < imageUrls.length; index++)
                _GalleryDot(
                  selected: index == selectedIndex,
                  onTap: () => onSelected(index),
                ),
            ],
          ),
          SizedBox(height: CoreSpacing.md(context)),
          LayoutBuilder(
            builder: (context, constraints) {
              final spacing = CoreSpacing.xs(context);
              final count = imageUrls.length;
              final totalSpacing = spacing * (count - 1);
              final thumbnailWidth =
                  ((constraints.maxWidth - totalSpacing) / count)
                      .clamp(28.0, 76.0)
                      .toDouble();
              final thumbnailHeight =
                  (thumbnailWidth * 0.82).clamp(34.0, 64.0).toDouble();

              return SizedBox(
                height: thumbnailHeight,
                child: Row(
                  children: [
                    for (var index = 0; index < count; index++) ...[
                      Expanded(
                        child: _GalleryThumbnail(
                          imageUrl: imageUrls[index],
                          index: index,
                          selected: index == selectedIndex,
                          onTap: () => onSelected(index),
                        ),
                      ),
                      if (index != count - 1) SizedBox(width: spacing),
                    ],
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _GalleryThumbnail extends StatelessWidget {
  const _GalleryThumbnail({
    required this.imageUrl,
    required this.index,
    required this.selected,
    required this.onTap,
  });

  final String? imageUrl;
  final int index;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(CoreSpacing.radiusButton),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(CoreSpacing.radiusButton),
          border: Border.all(
            color: selected ? scheme.primary : scheme.outlineVariant,
            width: selected ? 2 : 1,
          ),
        ),
        clipBehavior: Clip.antiAlias,
        child: WidgetsMockFoodImage(
          imageUrl: imageUrl,
          fallback: _GalleryFallback(index: index),
        ),
      ),
    );
  }
}

class _RelatedProductsRail extends StatelessWidget {
  const _RelatedProductsRail({
    required this.items,
    required this.isAr,
    required this.l10n,
    required this.onOpen,
    required this.onAdd,
  });

  final List<ModelMenuItem> items;
  final bool isAr;
  final AppLocalizations l10n;
  final ValueChanged<ModelMenuItem> onOpen;
  final ValueChanged<ModelMenuItem> onAdd;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          isAr ? 'منتجات ذات صلة' : 'Related products',
          style: CoreTypography.headlineSmall(
            context,
            scheme.onSurface,
          ).copyWith(fontWeight: FontWeight.w900),
        ),
        SizedBox(height: CoreSpacing.xs(context)),
        Text(
          isAr
              ? 'اقتراحات مناسبة مع هذا الصنف.'
              : 'Suggestions that pair well with this item.',
          style: CoreTypography.caption(context, scheme.onSurfaceVariant),
        ),
        SizedBox(height: CoreSpacing.md(context)),
        SizedBox(
          height: 230,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: items.length,
            separatorBuilder:
                (context, index) => SizedBox(width: CoreSpacing.md(context)),
            itemBuilder:
                (context, index) => _RelatedProductCard(
                  item: items[index],
                  isAr: isAr,
                  l10n: l10n,
                  onOpen: () => onOpen(items[index]),
                  onAdd: () => onAdd(items[index]),
                ),
          ),
        ),
      ],
    );
  }
}

class _RelatedProductCard extends StatelessWidget {
  const _RelatedProductCard({
    required this.item,
    required this.isAr,
    required this.l10n,
    required this.onOpen,
    required this.onAdd,
  });

  final ModelMenuItem item;
  final bool isAr;
  final AppLocalizations l10n;
  final VoidCallback onOpen;
  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return SizedBox(
      width: 188,
      child: WidgetsAppCard(
        variant: WidgetsAppCardVariant.food,
        padding: EdgeInsets.all(CoreSpacing.sm(context)),
        onTap: onOpen,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(CoreSpacing.radiusButton),
                child: WidgetsMockFoodImage(
                  imageUrl: item.imageUrl,
                  fallback: _GalleryFallback(index: item.id.hashCode),
                ),
              ),
            ),
            SizedBox(height: CoreSpacing.sm(context)),
            Text(
              isAr ? item.nameAr : item.nameEn,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: CoreTypography.bodyMedium(
                context,
                scheme.onSurface,
              ).copyWith(fontWeight: FontWeight.w900),
            ),
            SizedBox(height: CoreSpacing.xs(context)),
            Text(
              UtilityFormatJod.format(item.priceJod, suffix: l10n.currencyJod),
              style: CoreTypography.caption(
                context,
                scheme.primary,
              ).copyWith(fontWeight: FontWeight.w900),
            ),
            SizedBox(height: CoreSpacing.sm(context)),
            WidgetsAppButton(
              label: l10n.actionAddToCart,
              onPressed: onAdd,
              icon: Icons.add_shopping_cart_outlined,
              fullWidth: true,
            ),
          ],
        ),
      ),
    );
  }
}

class _GalleryDot extends StatelessWidget {
  const _GalleryDot({required this.selected, required this.onTap});

  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return InkWell(
      onTap: onTap,
      customBorder: const CircleBorder(),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        margin: EdgeInsets.symmetric(horizontal: CoreSpacing.xs(context) * 0.5),
        width: selected ? 22 : 8,
        height: 8,
        decoration: BoxDecoration(
          color: selected ? scheme.primary : scheme.outlineVariant,
          borderRadius: BorderRadius.circular(CoreSpacing.radiusChip),
        ),
      ),
    );
  }
}

class _GalleryFallback extends StatelessWidget {
  const _GalleryFallback({required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final color = switch (index % 4) {
      0 => scheme.primary,
      1 => CoreColors.brandGold,
      2 => CoreColors.orderTypePlated,
      _ => scheme.secondary,
    };

    return Stack(
      fit: StackFit.expand,
      children: [
        CustomPaint(
          painter: _MansafHeroPainter(
            rice: color.withValues(alpha: 0.22),
            meat: color,
            garnish: CoreColors.brandGold,
            plate: scheme.surfaceContainerLowest,
          ),
        ),
        Center(
          child: Icon(
            Icons.restaurant_menu_outlined,
            size: CoreContentSizes.categoryMenuImageIcon(context) * 1.25,
            color: color,
          ),
        ),
      ],
    );
  }
}

class _ReviewPreviewSheet extends StatelessWidget {
  const _ReviewPreviewSheet({required this.productName, required this.reviews});

  final String productName;
  final List<ProductReviewRecord> reviews;

  @override
  Widget build(BuildContext context) {
    final isAr = Localizations.localeOf(context).languageCode == 'ar';
    final scheme = Theme.of(context).colorScheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(CoreSpacing.radiusCard * 1.35),
        ),
        boxShadow: [
          BoxShadow(
            color: scheme.shadow.withValues(alpha: 0.16),
            blurRadius: 28,
            offset: const Offset(0, -10),
          ),
        ],
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.sizeOf(context).height * 0.84,
        ),
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(
            CoreSpacing.lg(context),
            CoreSpacing.md(context),
            CoreSpacing.lg(context),
            CoreSpacing.lg(context),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: scheme.outlineVariant,
                    borderRadius: BorderRadius.circular(CoreSpacing.radiusChip),
                  ),
                  child: const SizedBox(width: 44, height: 4),
                ),
              ),
              SizedBox(height: CoreSpacing.lg(context)),
              Text(
                isAr ? 'آراء العملاء' : 'Customer reviews',
                style: CoreTypography.headlineSmall(
                  context,
                  scheme.onSurface,
                ).copyWith(fontWeight: FontWeight.w900),
              ),
              SizedBox(height: CoreSpacing.xs(context)),
              Text(
                productName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: CoreTypography.bodyMedium(
                  context,
                  scheme.onSurfaceVariant,
                ),
              ),
              SizedBox(height: CoreSpacing.lg(context)),
              Expanded(
                child:
                    reviews.isEmpty
                        ? Center(
                          child: Text(
                            isAr
                                ? 'لا توجد تقييمات معتمدة بعد.'
                                : 'No approved reviews yet.',
                            style: CoreTypography.bodyMedium(
                              context,
                              scheme.onSurfaceVariant,
                            ),
                          ),
                        )
                        : ListView.separated(
                          padding: EdgeInsets.zero,
                          itemCount: reviews.length,
                          separatorBuilder:
                              (context, index) =>
                                  SizedBox(height: CoreSpacing.md(context)),
                          itemBuilder:
                              (context, index) => _ReviewCard(
                                review: reviews[index],
                                isAr: isAr,
                              ),
                        ),
              ),
              SizedBox(height: CoreSpacing.lg(context)),
              WidgetsAppButton(
                label: isAr ? 'المزيد من التقييمات' : 'More reviews',
                onPressed: () {
                  final router = GoRouter.of(context);
                  Navigator.of(context).pop();
                  router.push(AppRoutePaths.productReviews);
                },
                icon: Icons.rate_review_outlined,
                fullWidth: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ReviewCard extends StatelessWidget {
  const _ReviewCard({required this.review, required this.isAr});

  final ProductReviewRecord review;
  final bool isAr;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final initial =
        review.customerName.isNotEmpty
            ? review.customerName[0].toUpperCase()
            : '?';

    return WidgetsAppCard(
      variant: WidgetsAppCardVariant.form,
      padding: EdgeInsets.all(CoreSpacing.lg(context)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: scheme.primary.withValues(alpha: 0.12),
                child: Text(
                  initial,
                  style: CoreTypography.bodyMedium(
                    context,
                    scheme.primary,
                  ).copyWith(fontWeight: FontWeight.w900),
                ),
              ),
              SizedBox(width: CoreSpacing.md(context)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      review.customerName,
                      style: CoreTypography.titleMedium(
                        context,
                        scheme.onSurface,
                      ).copyWith(fontWeight: FontWeight.w900),
                    ),
                    SizedBox(height: CoreSpacing.xs(context)),
                    _StarsRow(rating: review.rating),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: CoreSpacing.lg(context)),
          Text(
            isAr ? review.commentAr : review.commentEn,
            maxLines: 6,
            overflow: TextOverflow.ellipsis,
            style: CoreTypography.bodyMedium(context, scheme.onSurfaceVariant),
          ),
        ],
      ),
    );
  }
}

class _StarsRow extends StatelessWidget {
  const _StarsRow({required this.rating});

  final int rating;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (var index = 1; index <= 5; index++)
          Icon(
            index <= rating ? Icons.star_rounded : Icons.star_outline_rounded,
            size: CoreContentSizes.orderTypeIcon(context),
            color: CoreColors.brandGold,
          ),
      ],
    );
  }
}

class _MetaRow extends StatelessWidget {
  const _MetaRow({required this.l10n, required this.onRatingTap});

  final AppLocalizations l10n;
  final VoidCallback onRatingTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Wrap(
      spacing: CoreSpacing.sm(context),
      runSpacing: CoreSpacing.xs(context),
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        InkWell(
          onTap: onRatingTap,
          borderRadius: BorderRadius.circular(CoreSpacing.radiusChip),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: CoreSpacing.xs(context),
              vertical: CoreSpacing.xs(context),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.star,
                  size: CoreContentSizes.orderTypeIcon(context),
                  color: CoreColors.brandGold,
                ),
                SizedBox(width: CoreSpacing.xs(context)),
                Text(
                  l10n.productRating,
                  style: CoreTypography.caption(
                    context,
                    scheme.primary,
                  ).copyWith(fontWeight: FontWeight.w900),
                ),
              ],
            ),
          ),
        ),
        Text(
          '•',
          style: CoreTypography.caption(context, scheme.onSurfaceVariant),
        ),
        Text(
          l10n.productPrepTime,
          style: CoreTypography.caption(context, scheme.onSurfaceVariant),
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
            _FoodTag(label: l10n.productRequired, color: scheme.primary),
          ],
        ),
        SizedBox(height: CoreSpacing.md(context)),
        for (var index = 0; index < portions.length; index++) ...[
          _PortionTile(
            optionKey: portions[index].key,
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
    required this.optionKey,
    required this.selectedKey,
    required this.title,
    required this.priceLabel,
    required this.onChanged,
  });

  final String optionKey;
  final String selectedKey;
  final String title;
  final String priceLabel;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isSelected = optionKey == selectedKey;

    return WidgetsAppCard(
      variant:
          isSelected ? WidgetsAppCardVariant.food : WidgetsAppCardVariant.form,
      padding: EdgeInsets.all(CoreSpacing.md(context)),
      onTap: () => onChanged(optionKey),
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

class _AddonsSection extends ConsumerWidget {
  const _AddonsSection({
    required this.selectedKeys,
    required this.onToggle,
  });

  final Set<String> selectedKeys;
  final void Function(String key, bool selected) onToggle;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    final isAr = Localizations.localeOf(context).languageCode == 'ar';
    final addons = ref.watch(visibleAddonsProvider);

    if (addons.isEmpty) {
      return const SizedBox.shrink();
    }

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
              for (var index = 0; index < addons.length; index++) ...[
                if (index > 0) Divider(color: scheme.outlineVariant, height: 1),
                _AddonTile(
                  value: selectedKeys.contains(addons[index].key),
                  onChanged:
                      (value) => onToggle(addons[index].key, value),
                  title: isAr ? addons[index].labelAr : addons[index].labelEn,
                  price:
                      addons[index].priceDeltaJod <= 0
                          ? l10n.productFree
                          : UtilityFormatJod.format(
                            addons[index].priceDeltaJod,
                            suffix: l10n.currencyJod,
                          ),
                ),
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

class _StickyCartPanel extends StatelessWidget {
  const _StickyCartPanel({
    required this.quantity,
    required this.totalText,
    required this.onMinus,
    required this.onPlus,
    required this.onAdd,
  });

  final int quantity;
  final String totalText;
  final VoidCallback onMinus;
  final VoidCallback onPlus;
  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;

    return SafeArea(
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: scheme.surface,
          border: Border(top: BorderSide(color: scheme.outlineVariant)),
          boxShadow: [
            BoxShadow(
              color: scheme.shadow.withValues(alpha: 0.08),
              blurRadius: 18,
              offset: const Offset(0, -8),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(CoreSpacing.md(context)),
          child: Row(
            children: [
              WidgetsQuantityStepper(
                value: quantity,
                min: 1,
                onIncrement: onPlus,
                onDecrement: onMinus,
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

class _FoodTag extends StatelessWidget {
  const _FoodTag({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(CoreSpacing.radiusChip),
        border: Border.all(color: color.withValues(alpha: 0.24)),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: CoreSpacing.sm(context),
          vertical: CoreSpacing.xs(context),
        ),
        child: Text(
          label,
          style: CoreTypography.caption(
            context,
            scheme.onSurface,
          ).copyWith(fontWeight: FontWeight.w800),
        ),
      ),
    );
  }
}

class _MansafHeroPainter extends CustomPainter {
  const _MansafHeroPainter({
    required this.rice,
    required this.meat,
    required this.garnish,
    required this.plate,
  });

  final Color rice;
  final Color meat;
  final Color garnish;
  final Color plate;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height * 0.58);
    final plateRect = Rect.fromCenter(
      center: center,
      width: size.width * 0.92,
      height: size.height * 0.36,
    );
    final shadow =
        Paint()
          ..color = CoreColors.brandBrown.withValues(alpha: 0.22)
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 14);
    final platePaint = Paint()..color = plate;
    final ricePaint = Paint()..color = rice.withValues(alpha: 0.92);
    final meatPaint = Paint()..color = meat.withValues(alpha: 0.82);
    final garnishPaint = Paint()..color = garnish;

    canvas.drawOval(plateRect.shift(const Offset(0, 12)), shadow);
    canvas.drawOval(plateRect, platePaint);
    canvas.drawOval(plateRect.deflate(18), ricePaint);

    for (var i = 0; i < 36; i++) {
      final angle = i * math.pi / 18;
      final start = Offset(
        center.dx + math.cos(angle) * size.width * 0.16,
        center.dy + math.sin(angle) * size.height * 0.08,
      );
      final end = Offset(
        center.dx + math.cos(angle) * size.width * 0.34,
        center.dy + math.sin(angle) * size.height * 0.15,
      );
      canvas.drawLine(
        start,
        end,
        Paint()
          ..color = plate.withValues(alpha: 0.35)
          ..strokeWidth = 1.2,
      );
    }

    for (var i = 0; i < 5; i++) {
      final dx = center.dx - size.width * 0.18 + (i * size.width * 0.09);
      final dy = center.dy - size.height * 0.12 + (i.isEven ? 0 : 10);
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromCenter(
            center: Offset(dx, dy),
            width: size.width * 0.16,
            height: size.height * 0.18,
          ),
          Radius.circular(CoreSpacing.radiusCard),
        ),
        meatPaint,
      );
    }

    for (var i = 0; i < 18; i++) {
      final angle = i * math.pi / 9;
      canvas.drawCircle(
        Offset(
          center.dx + math.cos(angle) * size.width * 0.30,
          center.dy + math.sin(angle) * size.height * 0.13,
        ),
        4,
        garnishPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _MansafHeroPainter oldDelegate) {
    return oldDelegate.rice != rice ||
        oldDelegate.meat != meat ||
        oldDelegate.garnish != garnish ||
        oldDelegate.plate != plate;
  }
}


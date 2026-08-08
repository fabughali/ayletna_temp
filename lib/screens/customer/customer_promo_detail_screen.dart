import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/utilities/utility_sizer.dart';
import 'package:ayletna_restaurant_app/data/models/model_menu_item.dart';
import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:ayletna_restaurant_app/navigation/app_route_paths.dart';
import 'package:ayletna_restaurant_app/providers/admin_catalog_providers.dart';
import 'package:ayletna_restaurant_app/providers/customer_offers_providers.dart';
import 'package:ayletna_restaurant_app/providers/menu_providers.dart';
import 'package:ayletna_restaurant_app/utilities/utility_format_jod.dart';
import 'package:ayletna_restaurant_app/utilities/utility_mock_feedback.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_action_bar.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_cart_customization_sheet.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_cart_icon_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_icon_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_mock_food_image.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_page_header.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_price_badge.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_scaffold_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

enum CustomerPromoDetailKind { offer, combo, subscription }

/// Dedicated detail screen for home offers, combos, and subscription meals.
class CustomerPromoDetailScreen extends ConsumerStatefulWidget {
  const CustomerPromoDetailScreen({
    required this.kind,
    required this.promoId,
    super.key,
  });

  final CustomerPromoDetailKind kind;
  final String promoId;

  @override
  ConsumerState<CustomerPromoDetailScreen> createState() =>
      _CustomerPromoDetailScreenState();
}

class _CustomerPromoDetailScreenState
    extends ConsumerState<CustomerPromoDetailScreen> {
  int _galleryIndex = 0;
  late final PageController _galleryController;

  @override
  void initState() {
    super.initState();
    _galleryController = PageController();
  }

  @override
  void dispose() {
    _galleryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isAr = Localizations.localeOf(context).languageCode == 'ar';
    final content = _resolveContent(ref, l10n, isAr);

    if (content == null) {
      return WidgetsScaffoldPage(
        title: l10n.customerPromoNotFoundTitle,
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(CoreSpacing.lg(context)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.local_offer_outlined,
                  size: CoreContentSizes.emptyStateIcon(context),
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
                SizedBox(height: CoreSpacing.md(context)),
                Text(
                  l10n.customerPromoNotFoundBody,
                  textAlign: TextAlign.center,
                  style: CoreTypography.bodyMedium(
                    context,
                    Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
                SizedBox(height: CoreSpacing.lg(context)),
                WidgetsAppButton(
                  label: l10n.searchBrowseMenu,
                  onPressed: () => context.go(AppRoutePaths.offers),
                  variant: WidgetsAppButtonVariant.outline,
                ),
              ],
            ),
          ),
        ),
      );
    }

    return WidgetsScaffoldPage(
      title: content.title,
      actions: [
        WidgetsIconButton(
          onPressed: () => context.push(AppRoutePaths.notifications),
          icon: Icons.notifications_outlined,
          tooltip: l10n.screenNotifications,
        ),
        const WidgetsCartIconButton(),
      ],
      bottomSheet: WidgetsActionBar(
        primary: WidgetsAppButton(
          label: content.primaryActionLabel,
          onPressed: () => _handlePrimaryAction(context, content),
          icon: content.primaryActionIcon,
          fullWidth: true,
        ),
        secondary:
            content.secondaryActionLabel == null ||
                    content.onSecondaryAction == null
                ? null
                : WidgetsAppButton(
                  label: content.secondaryActionLabel!,
                  onPressed: () => content.onSecondaryAction!(context, ref),
                  variant: WidgetsAppButtonVariant.outline,
                  fullWidth: true,
                ),
      ),
      child: ListView(
        padding: EdgeInsetsDirectional.only(
          top: CoreSpacing.md(context),
          bottom: CoreSpacing.xxl(context) * 3,
        ),
        children: [
          _PromoGallery(
            imageUrls: content.imageUrls,
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
          WidgetsPageHeader(
            title: content.title,
            subtitle: content.subtitle,
            eyebrow: content.badgeLabel,
          ),
          SizedBox(height: CoreSpacing.md(context)),
          Wrap(
            spacing: CoreSpacing.sm(context),
            runSpacing: CoreSpacing.xs(context),
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              _PromoTag(label: content.badgeLabel, color: content.badgeColor),
              if (content.priceLabel != null)
                WidgetsPriceBadge(priceLabel: content.priceLabel!),
            ],
          ),
          SizedBox(height: CoreSpacing.lg(context)),
          if (content.highlights.isNotEmpty) ...[
            _SectionTitle(title: l10n.promoDetailOfferDetails),
            SizedBox(height: CoreSpacing.sm(context)),
            WidgetsAppCard(
              variant: WidgetsAppCardVariant.food,
              padding: EdgeInsets.all(CoreSpacing.md(context)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  for (
                    var index = 0;
                    index < content.highlights.length;
                    index++
                  ) ...[
                    if (index > 0) Divider(height: CoreSpacing.lg(context)),
                    _HighlightRow(
                      icon: content.highlights[index].icon,
                      label: content.highlights[index].label,
                      value: content.highlights[index].value,
                    ),
                  ],
                ],
              ),
            ),
            SizedBox(height: CoreSpacing.lg(context)),
          ],
          if (content.includedItems.isNotEmpty) ...[
            _SectionTitle(title: l10n.promoDetailIncludes),
            SizedBox(height: CoreSpacing.sm(context)),
            WidgetsAppCard(
              variant: WidgetsAppCardVariant.form,
              padding: EdgeInsets.all(CoreSpacing.md(context)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  for (
                    var index = 0;
                    index < content.includedItems.length;
                    index++
                  ) ...[
                    if (index > 0) SizedBox(height: CoreSpacing.sm(context)),
                    _IncludedItemRow(item: content.includedItems[index]),
                  ],
                ],
              ),
            ),
            SizedBox(height: CoreSpacing.lg(context)),
          ],
          if (content.description != null) ...[
            _SectionTitle(title: l10n.promoDetailDescription),
            SizedBox(height: CoreSpacing.sm(context)),
            Text(
              content.description!,
              style: CoreTypography.bodyMedium(
                context,
                Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ],
      ),
    );
  }

  _PromoDetailContent? _resolveContent(
    WidgetRef ref,
    AppLocalizations l10n,
    bool isAr,
  ) {
    final scheme = Theme.of(context).colorScheme;

    switch (widget.kind) {
      case CustomerPromoDetailKind.offer:
        final offer = ref.watch(catalogOfferByIdProvider(widget.promoId));
        if (offer == null) return null;
        final discount = ref.watch(visibleDiscountsProvider).firstOrNull;
        final title = isAr ? offer.titleAr : offer.titleEn;
        final subtitle = isAr ? offer.subtitleAr : offer.subtitleEn;
        final discountLabel =
            discount != null
                ? l10n.promoPercentOff(discount.percentOff.toStringAsFixed(0))
                : null;
        return _PromoDetailContent(
          title: title,
          subtitle: subtitle,
          description: subtitle ?? l10n.promoDetailLimitedOfferDesc,
          badgeLabel: l10n.homeOffers,
          badgeColor: scheme.primary,
          priceLabel: discountLabel,
          imageUrls: _galleryUrls(offer.imageUrls),
          primaryActionLabel: l10n.guestClaimOffer,
          primaryActionIcon: Icons.local_offer_outlined,
          highlights: [
            if (discountLabel != null)
              _PromoHighlight(
                icon: Icons.percent_outlined,
                label: l10n.promoDetailDiscount,
                value: discountLabel,
              ),
            _PromoHighlight(
              icon: Icons.schedule_outlined,
              label: l10n.promoDetailValidFor,
              value: l10n.promoDetailThisWeek,
            ),
            _PromoHighlight(
              icon: Icons.loyalty_outlined,
              label: l10n.promoDetailLoyaltyPoints,
              value: l10n.loyaltyPointsShort('${discount != null ? 20 : 15}'),
            ),
          ],
          onPrimaryAction: (context, ref) {
            final applied = applyOfferToCart(ref, offer);
            if (!context.mounted) return;
            if (applied) {
              UtilityMockFeedback.showSuccess(context, l10n.guestClaimOffer);
              context.push(AppRoutePaths.cart);
            } else {
              UtilityMockFeedback.showWarning(
                context,
                l10n.promoApplyUnavailable,
              );
            }
          },
        );
      case CustomerPromoDetailKind.combo:
        final combo = ref.watch(catalogComboByIdProvider(widget.promoId));
        if (combo == null) return null;
        final title = isAr ? combo.titleAr : combo.titleEn;
        final subtitle = isAr ? combo.subtitleAr : combo.subtitleEn;
        final included =
            [
              for (final itemId in combo.itemIds)
                ref.watch(menuItemByIdProvider(itemId)),
            ].whereType<ModelMenuItem>().toList();
        return _PromoDetailContent(
          title: title,
          subtitle: subtitle,
          description: subtitle ?? l10n.promoDetailComboDesc,
          badgeLabel: l10n.homeCombos,
          badgeColor: CoreColors.brandOrange,
          priceLabel: UtilityFormatJod.format(
            combo.priceJod,
            suffix: l10n.currencyJod,
          ),
          imageUrls: _galleryUrls(combo.imageUrls),
          primaryActionLabel: l10n.actionAddToCart,
          primaryActionIcon: Icons.add_shopping_cart_outlined,
          secondaryActionLabel: l10n.screenComboBuilder,
          highlights: [
            _PromoHighlight(
              icon: Icons.savings_outlined,
              label: l10n.promoDetailBundleSavings,
              value: '${combo.discountPercent.toStringAsFixed(0)}%',
            ),
            _PromoHighlight(
              icon: Icons.restaurant_outlined,
              label: l10n.promoDetailItemsCount,
              value:
                  '${combo.itemIds.isEmpty ? included.length : combo.itemIds.length}',
            ),
            _PromoHighlight(
              icon: Icons.loyalty_outlined,
              label: l10n.promoDetailLoyaltyPoints,
              value: l10n.loyaltyPointsShort(
                '${(combo.priceJod * 10).round()}',
              ),
            ),
          ],
          includedItems: included,
          onPrimaryAction: (context, ref) {
            addComboToCart(ref, combo);
            if (!context.mounted) return;
            UtilityMockFeedback.showSuccess(context, l10n.actionAddToCart);
          },
          onSecondaryAction: (context, ref) {
            context.push(AppRoutePaths.combo);
          },
        );
      case CustomerPromoDetailKind.subscription:
        final meal = ref.watch(catalogSubscriptionByIdProvider(widget.promoId));
        if (meal == null) return null;
        final linkedItem = ref.watch(menuItemByIdProvider(meal.menuItemId));
        final title =
            isAr
                ? (meal.titleAr.isNotEmpty
                    ? meal.titleAr
                    : linkedItem?.nameAr ?? meal.menuItemId)
                : (meal.titleEn.isNotEmpty
                    ? meal.titleEn
                    : linkedItem?.nameEn ?? meal.menuItemId);
        final periodLabel =
            meal.billingPeriod == 'weekly'
                ? l10n.promoDetailWeekly
                : l10n.promoDetailMonthly;
        final itemDescription =
            linkedItem == null
                ? l10n.promoDetailSubscriptionDesc
                : (isAr ? linkedItem.descriptionAr : linkedItem.descriptionEn);
        final images =
            meal.imageUrls.isNotEmpty
                ? meal.imageUrls
                : (linkedItem?.resolvedImageUrls ?? const <String>[]);
        return _PromoDetailContent(
          title: title,
          subtitle: periodLabel,
          description: itemDescription,
          badgeLabel: l10n.homeSubscriptions,
          badgeColor: CoreColors.orderTypePlated,
          priceLabel:
              '${UtilityFormatJod.format(meal.priceJod, suffix: l10n.currencyJod)} / $periodLabel',
          imageUrls: _galleryUrls(images),
          primaryActionLabel: l10n.homeSubscriptionCta,
          primaryActionIcon: Icons.calendar_month_outlined,
          highlights: [
            _PromoHighlight(
              icon: Icons.autorenew_outlined,
              label: l10n.promoDetailBillingCycle,
              value: periodLabel,
            ),
            _PromoHighlight(
              icon: Icons.loyalty_outlined,
              label: l10n.promoDetailLoyaltyPoints,
              value: l10n.loyaltyPointsShort(
                '${linkedItem?.rewardPoints ?? (meal.priceJod * 10).round()}',
              ),
            ),
          ],
          includedItems: linkedItem == null ? const [] : [linkedItem],
          onPrimaryAction: (context, ref) {
            if (linkedItem != null) {
              showWidgetsCartCustomizationSheet(
                context: context,
                item: linkedItem,
              );
              return;
            }
            context.push(AppRoutePaths.loyalty);
          },
          onSecondaryAction:
              linkedItem == null
                  ? null
                  : (context, ref) {
                    ref.read(selectedMenuItemIdProvider.notifier).state =
                        linkedItem.id;
                    context.push(AppRoutePaths.productDetail);
                  },
          secondaryActionLabel:
              linkedItem == null ? null : l10n.promoDetailViewMeal,
        );
    }
  }

  void _handlePrimaryAction(BuildContext context, _PromoDetailContent content) {
    content.onPrimaryAction(context, ref);
  }

  List<String?> _galleryUrls(List<String> urls) {
    if (urls.isEmpty) return [null];
    return urls.map((url) => url as String?).toList();
  }
}

class _PromoDetailContent {
  const _PromoDetailContent({
    required this.title,
    required this.badgeLabel,
    required this.badgeColor,
    required this.imageUrls,
    required this.primaryActionLabel,
    required this.primaryActionIcon,
    required this.onPrimaryAction,
    this.subtitle,
    this.description,
    this.priceLabel,
    this.highlights = const [],
    this.includedItems = const [],
    this.secondaryActionLabel,
    this.onSecondaryAction,
  });

  final String title;
  final String? subtitle;
  final String? description;
  final String badgeLabel;
  final Color badgeColor;
  final String? priceLabel;
  final List<String?> imageUrls;
  final List<_PromoHighlight> highlights;
  final List<ModelMenuItem> includedItems;
  final String primaryActionLabel;
  final IconData primaryActionIcon;
  final String? secondaryActionLabel;
  final void Function(BuildContext context, WidgetRef ref) onPrimaryAction;
  final void Function(BuildContext context, WidgetRef ref)? onSecondaryAction;
}

class _PromoHighlight {
  const _PromoHighlight({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;
}

class _PromoGallery extends StatelessWidget {
  const _PromoGallery({
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
              borderRadius: BorderRadius.circular(CoreSpacing.radiusCardOf(context)),
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
          if (imageUrls.length > 1) ...[
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
          ],
        ],
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
    final colors = [
      scheme.primary,
      CoreColors.brandGold,
      CoreColors.brandOrange,
      scheme.secondary,
    ];
    return ColoredBox(
      color: colors[index % colors.length].withValues(alpha: 0.14),
      child: Center(
        child: Icon(
          Icons.restaurant_menu_outlined,
          size: CoreContentSizes.productHeroIcon(context) * 0.42,
          color: colors[index % colors.length],
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
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: CoreSpacing.xs(context) / 2),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(999),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          width: selected ? 18 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: selected ? scheme.primary : scheme.outlineVariant,
            borderRadius: BorderRadius.circular(999),
          ),
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: CoreTypography.titleMedium(
        context,
        Theme.of(context).colorScheme.onSurface,
      ).copyWith(fontWeight: FontWeight.w900),
    );
  }
}

class _PromoTag extends StatelessWidget {
  const _PromoTag({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(CoreSpacing.radiusChipOf(context)),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: CoreSpacing.sm(context),
          vertical: CoreSpacing.xs(context) / 2,
        ),
        child: Text(
          label,
          style: CoreTypography.caption(
            context,
            color,
          ).copyWith(fontWeight: FontWeight.w800),
        ),
      ),
    );
  }
}

class _HighlightRow extends StatelessWidget {
  const _HighlightRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Row(
      children: [
        Icon(icon, color: scheme.primary, size: CoreContentSizes.buttonIcon(context)),
        SizedBox(width: CoreSpacing.sm(context)),
        Expanded(
          child: Text(
            label,
            style: CoreTypography.bodyMedium(context, scheme.onSurfaceVariant),
          ),
        ),
        Text(
          value,
          style: CoreTypography.bodyMedium(
            context,
            scheme.onSurface,
          ).copyWith(fontWeight: FontWeight.w800),
        ),
      ],
    );
  }
}

class _IncludedItemRow extends ConsumerWidget {
  const _IncludedItemRow({required this.item});

  final ModelMenuItem item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isAr = Localizations.localeOf(context).languageCode == 'ar';
    final scheme = Theme.of(context).colorScheme;
    final name = isAr ? item.nameAr : item.nameEn;

    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(CoreSpacing.radiusChipOf(context)),
          child: SizedBox(
            width: UtilitySizer.of(context, 52),
            height: UtilitySizer.of(context, 52),
            child: WidgetsMockFoodImage(
              imageUrl: item.primaryImageUrl,
              fallback: ColoredBox(
                color: scheme.primary.withValues(alpha: 0.12),
                child: Icon(Icons.restaurant, color: scheme.primary),
              ),
            ),
          ),
        ),
        SizedBox(width: CoreSpacing.sm(context)),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: CoreTypography.bodyMedium(
                  context,
                  scheme.onSurface,
                ).copyWith(fontWeight: FontWeight.w800),
              ),
              Text(
                UtilityFormatJod.format(
                  item.priceJod,
                  suffix: AppLocalizations.of(context)!.currencyJod,
                ),
                style: CoreTypography.caption(context, scheme.onSurfaceVariant),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

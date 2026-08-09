import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/data/models/model_menu_item.dart';
import 'package:ayletna_restaurant_app/data/models/model_admin_mock.dart';
import 'package:ayletna_restaurant_app/data/mockup/mockup_catalog.dart';
import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:ayletna_restaurant_app/navigation/app_route_paths.dart';
import 'package:ayletna_restaurant_app/providers/admin_session_providers.dart';
import 'package:ayletna_restaurant_app/providers/menu_providers.dart';
import 'package:ayletna_restaurant_app/utilities/utility_confirm_dialog.dart';
import 'package:ayletna_restaurant_app/utilities/utility_mock_feedback.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_text_field.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_filter_chip.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_icon_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_illustration_panel.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_metric_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_refresh_list.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_scaffold_page.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_status_pill.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// PRD [MenuManagementScreen].
class AdminMenuManagementScreen extends ConsumerWidget {
  const AdminMenuManagementScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final menuState = ref.watch(adminMenuProvider);
    final query = menuState.searchQuery.toLowerCase();

    bool matches(String en, String ar) {
      if (query.isEmpty) return true;
      return en.toLowerCase().contains(query) || ar.toLowerCase().contains(query);
    }

    final addedItems =
        menuState.addedMenuItems
            .where((item) => matches(item.nameEn, item.nameAr))
            .toList();
    final seedItems =
        MockupCatalog.adminMenuItems
            .where((item) => matches(item.titleEn, item.titleAr))
            .toList();

    return WidgetsScaffoldPage(
      title: l10n.appTitle,
      actions: [
        WidgetsIconButton(
          onPressed: () => context.push(AppRoutePaths.notifications),
          icon: Icons.notifications_outlined,
          tooltip: l10n.screenNotifications,
        ),
      ],
      floatingActionButton: WidgetsAppButton(
        label: l10n.menuAddNewItem,
        onPressed:
            () => context.push('${AppRoutePaths.operatorProductEditor}?mode=create'),
        icon: Icons.add,
      ),
      child: WidgetsRefreshList(
        onRefresh: () async {
          ref.invalidate(menuAllItemsProvider);
          ref.invalidate(menuCategoriesProvider);
        },
        child: ListView(
          children: [
            _HeaderActions(l10n: l10n),
            SizedBox(height: CoreSpacing.lg(context)),
            const _MetricsGrid(),
            SizedBox(height: CoreSpacing.lg(context)),
            _FiltersCard(
              l10n: l10n,
              selectedIndex: menuState.selectedCategoryIndex,
              searchQuery: menuState.searchQuery,
              onSelected:
                  (index) =>
                      ref
                          .read(adminMenuProvider.notifier)
                          .setCategoryIndex(index),
              onSearchChanged:
                  (value) =>
                      ref.read(adminMenuProvider.notifier).setSearchQuery(value),
            ),
            SizedBox(height: CoreSpacing.md(context)),
            for (final item in addedItems) ...[
              _AddedMenuItemCard(item: item, isPublished: menuState.publishedProductIds.contains(item.id)),
              SizedBox(height: CoreSpacing.md(context)),
            ],
            for (final item in seedItems) ...[
              _MenuItemCard(
                item: item,
                catalogItemId: _catalogIdForAdminItem(item),
                active: menuState.activeOverrides[item.titleEn] ?? item.active,
                onActiveChanged:
                    (active) =>
                        ref
                            .read(adminMenuProvider.notifier)
                            .setItemActive(item.titleEn, active),
              ),
              SizedBox(height: CoreSpacing.md(context)),
            ],
            SizedBox(height: CoreSpacing.xxl(context)),
          ],
        ),
      ),
    );
  }
}

class _HeaderActions extends ConsumerWidget {
  const _HeaderActions({required this.l10n});

  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.menuManagementTitle,
          style: CoreTypography.headlineSmall(context, scheme.onSurface),
        ),
        SizedBox(height: CoreSpacing.xs(context)),
        Text(
          l10n.menuManagementSubtitle,
          style: CoreTypography.caption(context, scheme.onSurfaceVariant),
        ),
        SizedBox(height: CoreSpacing.md(context)),
        Wrap(
          spacing: CoreSpacing.sm(context),
          runSpacing: CoreSpacing.sm(context),
          children: [
            WidgetsAppButton(
              label: l10n.menuAddNewItem,
              onPressed:
                  () => context.push('${AppRoutePaths.operatorProductEditor}?mode=create'),
              icon: Icons.add,
            ),
            WidgetsAppButton(
              label: Localizations.localeOf(context).languageCode == 'ar'
                  ? 'فهرس المنيو'
                  : 'Menu catalog',
              onPressed: () => context.push(AppRoutePaths.marketingCatalog),
              icon: Icons.category_outlined,
              variant: WidgetsAppButtonVariant.outline,
            ),
            WidgetsAppButton(
              label: l10n.screenOffersManagement,
              onPressed: () => context.push(AppRoutePaths.marketingOffers),
              icon: Icons.local_offer_outlined,
              variant: WidgetsAppButtonVariant.outline,
            ),
            WidgetsAppButton(
              label: l10n.menuBulkImport,
              onPressed:
                  () => UtilityMockFeedback.showActionSheet(
                    context: context,
                    title: l10n.menuBulkImport,
                    message: l10n.menuManagementSubtitle,
                    actions: [
                      MockSheetAction(
                        label: l10n.actionConfirm,
                        icon: Icons.upload_file_outlined,
                        onSelected: () {
                          ref.read(adminMenuProvider.notifier).bulkImport();
                          UtilityMockFeedback.showSuccess(
                            context,
                            l10n.menuBulkImport,
                          );
                        },
                      ),
                    ],
                  ),
              icon: Icons.upload_file_outlined,
              variant: WidgetsAppButtonVariant.outline,
            ),
          ],
        ),
      ],
    );
  }
}

class _MetricsGrid extends StatelessWidget {
  const _MetricsGrid();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    final metrics = [
      _MetricData(
        label: l10n.menuTotalItems,
        value: '124',
        helper: l10n.menuTotalItemsDelta,
        color: CoreColors.semanticSuccess,
        icon: Icons.restaurant_menu_outlined,
      ),
      _MetricData(
        label: l10n.menuActiveNow,
        value: '118',
        helper: l10n.menuInactiveCount,
        color: scheme.primary,
        icon: Icons.toggle_on_outlined,
      ),
      _MetricData(
        label: l10n.menuOutOfStock,
        value: '3',
        helper: l10n.menuActionRequired,
        color: CoreColors.semanticError,
        icon: Icons.inventory_2_outlined,
      ),
      _MetricData(
        label: l10n.menuAvgPrice,
        value: '8.45',
        suffix: l10n.currencyJod,
        helper: l10n.menuMarketStable,
        color: scheme.tertiary,
        icon: Icons.sell_outlined,
      ),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final twoColumns = constraints.maxWidth > 560;
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: twoColumns ? 2 : 1,
            crossAxisSpacing: CoreSpacing.md(context),
            mainAxisSpacing: CoreSpacing.md(context),
            childAspectRatio: twoColumns ? 2.5 : 2.9,
          ),
          itemCount: metrics.length,
          itemBuilder: (context, index) {
            final data = metrics[index];
            return WidgetsMetricCard(
              label: data.label,
              value:
                  data.suffix == null
                      ? data.value
                      : '${data.value} ${data.suffix}',
              subtitle: data.helper,
              icon: data.icon,
              accentColor: data.color,
              compact: true,
            );
          },
        );
      },
    );
  }
}

class _FiltersCard extends StatefulWidget {
  const _FiltersCard({
    required this.l10n,
    required this.selectedIndex,
    required this.searchQuery,
    required this.onSelected,
    required this.onSearchChanged,
  });

  final AppLocalizations l10n;
  final int selectedIndex;
  final String searchQuery;
  final ValueChanged<int> onSelected;
  final ValueChanged<String> onSearchChanged;

  @override
  State<_FiltersCard> createState() => _FiltersCardState();
}

class _FiltersCardState extends State<_FiltersCard> {
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController(text: widget.searchQuery);
  }

  @override
  void didUpdateWidget(covariant _FiltersCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.searchQuery != widget.searchQuery &&
        _searchController.text != widget.searchQuery) {
      _searchController.text = widget.searchQuery;
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final categories = [
      widget.l10n.menuAllCategories,
      widget.l10n.menuMainCourse,
      widget.l10n.menuAppetizers,
      widget.l10n.menuBeverages,
      widget.l10n.menuDesserts,
    ];

    return WidgetsAppCard(
      accentColor: scheme.primary,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Wrap(
            spacing: CoreSpacing.sm(context),
            runSpacing: CoreSpacing.sm(context),
            children: [
              for (var index = 0; index < categories.length; index++)
                WidgetsFilterChip(
                  label: categories[index],
                  selected: index == widget.selectedIndex,
                  onSelected: (_) => widget.onSelected(index),
                ),
            ],
          ),
          SizedBox(height: CoreSpacing.md(context)),
          WidgetsAppTextField(
            controller: _searchController,
            label: widget.l10n.menuSearchHint,
            prefixIcon: Icons.search,
            onChanged: widget.onSearchChanged,
          ),
        ],
      ),
    );
  }
}

class _MenuItemCard extends ConsumerWidget {
  const _MenuItemCard({
    required this.item,
    required this.catalogItemId,
    required this.active,
    required this.onActiveChanged,
  });

  final ModelAdminMenuItem item;
  final String? catalogItemId;
  final bool active;
  final ValueChanged<bool> onActiveChanged;

  String get _editorRoute =>
      catalogItemId != null
          ? '${AppRoutePaths.operatorProductEditor}?id=$catalogItemId'
          : AppRoutePaths.operatorProductEditor;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    final isAr = Localizations.localeOf(context).languageCode == 'ar';
    final menuState = ref.watch(adminMenuProvider);
    final isPublished =
        catalogItemId == null ||
        menuState.isSeedProductPublished(catalogItemId!);
    final typeColor = _typeColor(item.typeKey);
    final stockLabel = _stockLabel(l10n, item.stockKey);

    return Opacity(
      opacity: active ? 1 : 0.82,
      child: WidgetsAppCard(
        padding: EdgeInsets.zero,
        accentColor: typeColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            WidgetsIllustrationPanel(
              height: CoreContentSizes.categoryMenuImageHeight(context),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  CustomPaint(
                    painter: _MenuFoodPainter(
                      color: typeColor,
                      plateColor: scheme.surface,
                      icon: _itemIcon(item.iconKey),
                      muted: !active,
                    ),
                  ),
                  PositionedDirectional(
                    top: CoreSpacing.sm(context),
                    start: CoreSpacing.sm(context),
                    child: WidgetsStatusPill(
                      label: _typeLabel(l10n, item.typeKey),
                      color: typeColor,
                      compact: true,
                    ),
                  ),
                  PositionedDirectional(
                    top: CoreSpacing.sm(context),
                    end: CoreSpacing.sm(context),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        if (catalogItemId != null)
                          WidgetsStatusPill(
                            label:
                                isPublished
                                    ? l10n.menuMgmtPublished
                                    : l10n.menuMgmtDraft,
                            color:
                                isPublished
                                    ? CoreColors.semanticSuccess
                                    : CoreColors.brandGold,
                            compact: true,
                          ),
                        if (catalogItemId != null)
                          SizedBox(height: CoreSpacing.xs(context)),
                        WidgetsStatusPill(
                          label: stockLabel,
                          color: _stockColor(scheme, item.stockKey),
                          compact: true,
                        ),
                      ],
                    ),
                  ),
                  if (!active)
                    DecoratedBox(
                      decoration: BoxDecoration(
                        color: scheme.scrim.withValues(alpha: 0.34),
                      ),
                      child: Center(
                        child: WidgetsStatusPill(
                          label: stockLabel.toUpperCase(),
                          color: scheme.error,
                          compact: true,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(CoreSpacing.md(context)),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              isAr ? item.titleAr : item.titleEn,
                              style: CoreTypography.titleMedium(
                                context,
                                scheme.onSurface,
                              ),
                            ),
                            Text(
                              isAr ? item.subtitleAr : item.subtitleEn,
                              style: CoreTypography.caption(
                                context,
                                scheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: CoreSpacing.md(context)),
                      Text.rich(
                        TextSpan(
                          text: item.priceLabel,
                          children: [
                            TextSpan(
                              text: ' ${l10n.currencyJod}',
                              style: CoreTypography.caption(
                                context,
                                scheme.primary,
                              ),
                            ),
                          ],
                        ),
                        style: CoreTypography.headlineSmall(
                          context,
                          scheme.primary,
                        ).copyWith(fontWeight: FontWeight.w900),
                      ),
                    ],
                  ),
                  SizedBox(height: CoreSpacing.lg(context)),
                  Row(
                    children: [
                      WidgetsAppSwitch(value: active, onChanged: onActiveChanged),
                      SizedBox(width: CoreSpacing.xs(context)),
                      Text(
                        active ? l10n.menuActive : l10n.menuInactive,
                        style: CoreTypography.caption(
                          context,
                          scheme.onSurfaceVariant,
                        ).copyWith(fontWeight: FontWeight.w800),
                      ),
                      const Spacer(),
                      WidgetsIconButton(
                        onPressed: () => context.push(_editorRoute),
                        icon: Icons.edit_square,
                        tooltip: l10n.actionEdit,
                      ),
                      WidgetsIconButton(
                        onPressed:
                            () => UtilityMockFeedback.showActionSheet(
                              context: context,
                              title: isAr ? item.titleAr : item.titleEn,
                              message: isAr ? item.subtitleAr : item.subtitleEn,
                              actions: [
                                MockSheetAction(
                                  label: l10n.actionEdit,
                                  icon: Icons.edit_square,
                                  onSelected: () => context.push(_editorRoute),
                                ),
                                if (catalogItemId != null)
                                  MockSheetAction(
                                    label:
                                        isPublished
                                            ? l10n.menuMgmtUnpublish
                                            : l10n.menuMgmtPublish,
                                    icon:
                                        isPublished
                                            ? Icons.visibility_off_outlined
                                            : Icons.publish_outlined,
                                    onSelected: () {
                                      final notifier =
                                          ref.read(adminMenuProvider.notifier);
                                      if (isPublished) {
                                        notifier.unpublishProduct(
                                          catalogItemId!,
                                        );
                                        UtilityMockFeedback.showInfo(
                                          context,
                                          l10n.menuMgmtHiddenFromMenu,
                                        );
                                      } else {
                                        notifier.publishProduct(
                                          catalogItemId!,
                                        );
                                        UtilityMockFeedback.showSuccess(
                                          context,
                                          l10n.menuMgmtPublishSuccess,
                                        );
                                      }
                                    },
                                  ),
                              ],
                            ),
                        icon: Icons.more_vert,
                        tooltip: l10n.screenSettings,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _typeLabel(AppLocalizations l10n, String key) {
    return switch (key) {
      'takeaway' => l10n.menuTakeaway,
      'delivery' => l10n.menuDelivery,
      _ => l10n.menuDineIn,
    };
  }

  String _stockLabel(AppLocalizations l10n, String key) {
    return switch (key) {
      'lowStock' => l10n.menuLowStock,
      'outOfStock' => l10n.menuOutOfStockLabel,
      _ => l10n.menuInStock,
    };
  }

  Color _typeColor(String key) {
    return switch (key) {
      'takeaway' => CoreColors.orderTypeTakeaway,
      'delivery' => CoreColors.orderTypeDelivery,
      _ => CoreColors.orderTypeDineIn,
    };
  }

  Color _stockColor(ColorScheme scheme, String key) {
    return switch (key) {
      'lowStock' => scheme.primaryContainer,
      'outOfStock' => scheme.surface,
      _ => scheme.surface.withValues(alpha: 0.92),
    };
  }

  IconData _itemIcon(String key) {
    return switch (key) {
      'burger' => Icons.lunch_dining,
      'fries' => Icons.fastfood,
      _ => Icons.ramen_dining,
    };
  }
}

class _MetricData {
  const _MetricData({
    required this.label,
    required this.value,
    required this.helper,
    required this.color,
    required this.icon,
    this.suffix,
  });

  final String label;
  final String value;
  final String helper;
  final Color color;
  final IconData icon;
  final String? suffix;
}

class _AddedMenuItemCard extends ConsumerWidget {
  const _AddedMenuItemCard({
    required this.item,
    required this.isPublished,
  });

  final ModelMenuItem item;
  final bool isPublished;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final isAr = Localizations.localeOf(context).languageCode == 'ar';
    final scheme = Theme.of(context).colorScheme;

    return WidgetsAppCard(
      variant: WidgetsAppCardVariant.food,
      padding: EdgeInsets.all(CoreSpacing.lg(context)),
      child: Row(
        children: [
          Icon(Icons.new_releases_outlined, color: CoreColors.brandGold),
          SizedBox(width: CoreSpacing.md(context)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isAr ? item.nameAr : item.nameEn,
                  style: CoreTypography.titleMedium(
                    context,
                    scheme.onSurface,
                  ).copyWith(fontWeight: FontWeight.w900),
                ),
                Text(
                  '${item.priceJod.toStringAsFixed(2)} JOD',
                  style: CoreTypography.caption(context, scheme.onSurfaceVariant),
                ),
              ],
            ),
          ),
          WidgetsStatusPill(
            label: isPublished ? l10n.menuMgmtPublished : l10n.menuMgmtDraft,
            color: isPublished ? CoreColors.semanticSuccess : CoreColors.brandGold,
          ),
          IconButton(
            onPressed:
                () => context.push(
                  '${AppRoutePaths.operatorProductEditor}?id=${item.id}',
                ),
            icon: const Icon(Icons.edit_outlined),
          ),
          IconButton(
            onPressed: () {
              confirmAdminDelete(
                context,
                isAr: isAr,
                onConfirmed: () {
                  ref.read(adminMenuProvider.notifier).removeAddedMenuItem(item.id);
                  UtilityMockFeedback.showInfo(context, l10n.catalogCrudDeleted);
                },
              );
            },
            icon: const Icon(Icons.delete_outline),
            color: CoreColors.semanticError,
          ),
        ],
      ),
    );
  }
}

class _MenuFoodPainter extends CustomPainter {
  const _MenuFoodPainter({
    required this.color,
    required this.plateColor,
    required this.icon,
    required this.muted,
  });

  final Color color;
  final Color plateColor;
  final IconData icon;
  final bool muted;

  @override
  void paint(Canvas canvas, Size size) {
    final background =
        Paint()
          ..shader = LinearGradient(
            begin: AlignmentDirectional.topStart,
            end: AlignmentDirectional.bottomEnd,
            colors: [
              color.withValues(alpha: muted ? 0.12 : 0.20),
              color.withValues(alpha: muted ? 0.26 : 0.54),
            ],
          ).createShader(Offset.zero & size);
    canvas.drawRect(Offset.zero & size, background);

    final platePaint =
        Paint()..color = plateColor.withValues(alpha: muted ? 0.28 : 0.76);
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(size.width * 0.56, size.height * 0.54),
        width: size.width * 0.56,
        height: size.height * 0.46,
      ),
      platePaint,
    );

    final accentPaint =
        Paint()..color = color.withValues(alpha: muted ? 0.24 : 0.82);
    canvas.drawCircle(
      Offset(size.width * 0.36, size.height * 0.42),
      size.shortestSide * 0.12,
      accentPaint,
    );
    canvas.drawCircle(
      Offset(size.width * 0.65, size.height * 0.50),
      size.shortestSide * 0.10,
      accentPaint,
    );

    final textPainter = TextPainter(
      text: TextSpan(
        text: String.fromCharCode(icon.codePoint),
        style: TextStyle(
          fontFamily: icon.fontFamily,
          package: icon.fontPackage,
          color: color.withValues(alpha: muted ? 0.30 : 0.82),
          fontSize: size.shortestSide * 0.34,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    textPainter.paint(
      canvas,
      Offset(
        size.width * 0.5 - textPainter.width / 2,
        size.height * 0.5 - textPainter.height / 2,
      ),
    );
  }

  @override
  bool shouldRepaint(covariant _MenuFoodPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.plateColor != plateColor ||
        oldDelegate.icon != icon ||
        oldDelegate.muted != muted;
  }
}

String? _catalogIdForAdminItem(ModelAdminMenuItem item) {
  for (final menuItem in MockupCatalog.items) {
    if (menuItem.nameEn.toLowerCase() == item.titleEn.toLowerCase()) {
      return menuItem.id;
    }
  }
  return null;
}

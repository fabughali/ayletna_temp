import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/data/mockup/mockup_catalog.dart';
import 'package:ayletna_restaurant_app/data/models/model_admin_catalog.dart';
import 'package:ayletna_restaurant_app/data/models/model_customer_reward.dart';
import 'package:ayletna_restaurant_app/data/models/model_menu_category.dart';
import 'package:ayletna_restaurant_app/data/models/model_menu_item.dart';
import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:ayletna_restaurant_app/providers/admin_catalog_providers.dart';
import 'package:ayletna_restaurant_app/providers/admin_session_providers.dart';
import 'package:ayletna_restaurant_app/providers/menu_providers.dart';
import 'package:ayletna_restaurant_app/providers/rewards_admin_providers.dart';
import 'package:ayletna_restaurant_app/providers/reviews_admin_providers.dart';
import 'package:ayletna_restaurant_app/utilities/utility_catalog_images.dart';
import 'package:ayletna_restaurant_app/utilities/utility_confirm_dialog.dart';
import 'package:ayletna_restaurant_app/utilities/utility_format_jod.dart';
import 'package:ayletna_restaurant_app/utilities/utility_mock_feedback.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_text_field.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_catalog_image_editor.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_mock_food_image.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_scaffold_page.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_status_pill.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Marketing visual catalog.
///
/// [categoriesOnly] = Categories CRUD only (no tabs, no products).
/// [productsHub] + [createMode] = Product form · Addons · Related · Preview.
/// [productsHub] + [lockProductId] = Product form · Addons · Related · Ratings · Preview.
/// Otherwise Categories | Products (legacy catalog).
class AdminMenuCatalogScreen extends ConsumerStatefulWidget {
  const AdminMenuCatalogScreen({
    super.key,
    this.initialTabIndex = 0,
    this.productsHub = false,
    this.categoriesOnly = false,
    this.showPreviewTab = false,
    this.createMode = false,
    this.lockProductId,
  });

  final int initialTabIndex;
  final bool productsHub;
  final bool categoriesOnly;
  final bool showPreviewTab;

  /// Create flow: form (not list), no Ratings tab, includes Preview.
  final bool createMode;

  /// Edit flow: form for this product id.
  final String? lockProductId;

  @override
  ConsumerState<AdminMenuCatalogScreen> createState() =>
      _AdminMenuCatalogScreenState();
}

class _AdminMenuCatalogScreenState extends ConsumerState<AdminMenuCatalogScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  String? _editorProductId;

  bool get _isEditorHub =>
      widget.productsHub &&
      (widget.createMode ||
          (widget.lockProductId != null && widget.lockProductId!.isNotEmpty));

  int get _tabCount {
    if (widget.categoriesOnly) return 1;
    if (widget.createMode) return 4; // Product, Addons, Related, Preview
    if (widget.productsHub) {
      return widget.showPreviewTab ? 5 : 4;
    }
    return 2;
  }

  @override
  void initState() {
    super.initState();
    final safeIndex = widget.initialTabIndex.clamp(0, _tabCount - 1);
    _tabController = TabController(
      length: _tabCount,
      vsync: this,
      initialIndex: safeIndex,
    );
    _tabController.addListener(() {
      if (mounted) setState(() {});
    });
    WidgetsBinding.instance.addPostFrameCallback((_) => _bootstrapEditor());
  }

  void _bootstrapEditor() {
    if (!mounted) return;
    if (widget.createMode) {
      final categories = ref.read(visibleCategoriesProvider);
      final categoryId =
          categories.isNotEmpty ? categories.first.id : 'shawarma';
      final created = ref.read(adminMenuProvider.notifier).addMenuItem(
            nameAr: 'منتج جديد',
            nameEn: 'New product',
            descriptionAr: '',
            descriptionEn: '',
            priceJod: 1,
            categoryId: categoryId,
            imageUrls: const [],
          );
      if (created != null) {
        setState(() => _editorProductId = created.id);
        ref.read(selectedMenuItemIdProvider.notifier).state = created.id;
      }
      return;
    }
    final lockId = widget.lockProductId;
    if (lockId != null && lockId.isNotEmpty) {
      setState(() => _editorProductId = lockId);
      ref.read(selectedMenuItemIdProvider.notifier).state = lockId;
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  String _title(AppLocalizations l10n) {
    if (widget.categoriesOnly) return l10n.menuCatalogTabCategories;
    if (!widget.productsHub) {
      return _tabController.index == 0
          ? l10n.menuCatalogTabCategories
          : l10n.menuCatalogTabProducts;
    }
    if (widget.createMode) {
      return switch (_tabController.index) {
        0 => l10n.menuCatalogTabProduct,
        1 => l10n.menuCatalogTabAddons,
        2 => l10n.menuCatalogTabRelated,
        _ => l10n.marketingProductPreviewTab,
      };
    }
    return switch (_tabController.index) {
      0 => l10n.menuCatalogTabProduct,
      1 => l10n.menuCatalogTabAddons,
      2 => l10n.menuCatalogTabRelated,
      3 => l10n.menuCatalogTabRatings,
      _ => l10n.marketingProductPreviewTab,
    };
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isAr = Localizations.localeOf(context).languageCode == 'ar';

    if (widget.categoriesOnly) {
      return WidgetsScaffoldPage(
        title: _title(l10n),
        child: _CategoriesTab(isAr: isAr),
      );
    }

    final editorId = _editorProductId;

    return WidgetsScaffoldPage(
      title:
          widget.createMode
              ? l10n.marketingProductCreate
              : (widget.lockProductId != null
                  ? l10n.marketingProductDetailsTitle
                  : _title(l10n)),
      child: Column(
        children: [
          TabBar(
            controller: _tabController,
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            tabs:
                widget.productsHub
                    ? [
                      Tab(text: l10n.menuCatalogTabProduct),
                      Tab(text: l10n.menuCatalogTabAddons),
                      Tab(text: l10n.menuCatalogTabRelated),
                      if (!widget.createMode)
                        Tab(text: l10n.menuCatalogTabRatings),
                      if (widget.showPreviewTab || widget.createMode)
                        Tab(text: l10n.marketingProductPreviewTab),
                    ]
                    : [
                      Tab(text: l10n.menuCatalogTabCategories),
                      Tab(text: l10n.menuCatalogTabProducts),
                    ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children:
                  widget.productsHub
                      ? [
                        if (_isEditorHub && editorId != null)
                          _ProductFormTab(
                            isAr: isAr,
                            productId: editorId,
                            isCreate: widget.createMode,
                          )
                        else if (_isEditorHub)
                          const Center(child: CircularProgressIndicator())
                        else
                          _ProductsTab(isAr: isAr, hubMode: true),
                        _ProductScopedHubTab(
                          isAr: isAr,
                          kind: _HubScopedKind.addons,
                          lockProductId: editorId,
                        ),
                        _ProductScopedHubTab(
                          isAr: isAr,
                          kind: _HubScopedKind.related,
                          lockProductId: editorId,
                        ),
                        if (!widget.createMode)
                          _MarketingRatingsTab(
                            isAr: isAr,
                            lockProductId: editorId ?? widget.lockProductId,
                          ),
                        if (widget.showPreviewTab || widget.createMode)
                          _CustomerProductPreviewTab(isAr: isAr),
                      ]
                      : [
                        _CategoriesTab(isAr: isAr),
                        _ProductsTab(isAr: isAr),
                      ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CategoriesTab extends ConsumerStatefulWidget {
  const _CategoriesTab({required this.isAr});

  final bool isAr;

  @override
  ConsumerState<_CategoriesTab> createState() => _CategoriesTabState();
}

class _CategoriesTabState extends ConsumerState<_CategoriesTab> {
  final _nameAr = TextEditingController();
  final _nameEn = TextEditingController();
  final _iconKey = TextEditingController(text: 'custom');
  final _sortOrder = TextEditingController(text: '0');
  final _descriptionAr = TextEditingController();
  final _descriptionEn = TextEditingController();
  var _mealType = '';

  @override
  void dispose() {
    _nameAr.dispose();
    _nameEn.dispose();
    _iconKey.dispose();
    _sortOrder.dispose();
    _descriptionAr.dispose();
    _descriptionEn.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final categories = ref.watch(visibleCategoriesProvider);

    final children = <Widget>[
        _AddFormCard(
          title: l10n.menuCatalogAddCategory,
          isAr: widget.isAr,
          onSubmit: () {
            final ok = ref.read(adminCatalogProvider.notifier).addCategory(
              ModelMenuCategory(
                id: nextCatalogId('cat'),
                nameAr: _nameAr.text,
                nameEn: _nameEn.text,
                iconKey: _iconKey.text,
                sortOrder: int.tryParse(_sortOrder.text) ?? 0,
                descriptionAr:
                    _descriptionAr.text.isNotEmpty ? _descriptionAr.text : null,
                descriptionEn:
                    _descriptionEn.text.isNotEmpty ? _descriptionEn.text : null,
                mealType: _mealType.isNotEmpty ? _mealType : null,
              ),
            );
            if (ok) {
              _nameAr.clear();
              _nameEn.clear();
              _sortOrder.text = '0';
              _descriptionAr.clear();
              _descriptionEn.clear();
              setState(() => _mealType = '');
              UtilityMockFeedback.showSuccess(context, l10n.catalogCrudAdded);
            } else {
              UtilityMockFeedback.showWarning(
                context,
                l10n.catalogCrudCheckFields,
              );
            }
          },
          fields: [
            WidgetsAppTextField(
              controller: _nameEn,
              label: l10n.catalogCrudNameEn,
            ),
            SizedBox(height: CoreSpacing.sm(context)),
            WidgetsAppTextField(
              controller: _nameAr,
              label: l10n.catalogCrudNameAr,
            ),
            SizedBox(height: CoreSpacing.sm(context)),
            WidgetsAppTextField(
              controller: _iconKey,
              label: l10n.catalogCrudIconKey,
            ),
            SizedBox(height: CoreSpacing.sm(context)),
            WidgetsAppTextField(
              controller: _sortOrder,
              label: l10n.catalogCrudSortOrder,
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: CoreSpacing.sm(context)),
            WidgetsAppTextField(
              controller: _descriptionEn,
              label: l10n.catalogCrudDescriptionEn,
              maxLines: 2,
            ),
            SizedBox(height: CoreSpacing.sm(context)),
            WidgetsAppTextField(
              controller: _descriptionAr,
              label: l10n.catalogCrudDescriptionAr,
              maxLines: 2,
            ),
            SizedBox(height: CoreSpacing.sm(context)),
            DropdownButtonFormField<String>(
              initialValue: _mealType.isEmpty ? null : _mealType,
              hint: Text(l10n.catalogCrudMealType),
              items: [
                DropdownMenuItem(
                  value: 'main',
                  child: Text(l10n.catalogCrudMealMain),
                ),
                DropdownMenuItem(
                  value: 'side',
                  child: Text(l10n.catalogCrudMealSide),
                ),
                DropdownMenuItem(
                  value: 'drink',
                  child: Text(l10n.catalogCrudMealDrink),
                ),
                DropdownMenuItem(
                  value: 'dessert',
                  child: Text(l10n.catalogCrudMealDessert),
                ),
              ],
              onChanged: (v) => setState(() => _mealType = v ?? ''),
            ),
          ],
        ),
        for (final category in categories)
          _CatalogListTile(
            title: widget.isAr ? category.nameAr : category.nameEn,
            subtitle: category.id,
            isAr: widget.isAr,
            onEdit: () => _editCategory(context, category),
            onDelete: () {
              confirmAdminDelete(
                context,
                isAr: widget.isAr,
                onConfirmed: () {
                  ref
                      .read(adminCatalogProvider.notifier)
                      .deleteCategory(category.id);
                  UtilityMockFeedback.showInfo(
                    context,
                    l10n.catalogCrudDeleted,
                  );
                },
              );
            },
          ),
    ];
    return ListView.builder(
      padding: EdgeInsets.all(CoreSpacing.lg(context)),
      itemCount: children.length,
      itemBuilder: (context, index) => children[index],
    );
  }

  void _editCategory(BuildContext context, ModelMenuCategory category) {
    final l10n = AppLocalizations.of(context)!;
    final nameAr = TextEditingController(text: category.nameAr);
    final nameEn = TextEditingController(text: category.nameEn);
    final sortOrder = TextEditingController(text: category.sortOrder.toString());
    final descriptionAr = TextEditingController(
      text: category.descriptionAr ?? '',
    );
    final descriptionEn = TextEditingController(
      text: category.descriptionEn ?? '',
    );
    var mealType = category.mealType ?? '';
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder:
          (ctx) => StatefulBuilder(
            builder:
                (ctx, setSheetState) => Padding(
                  padding: EdgeInsets.only(
                    left: CoreSpacing.lg(ctx),
                    right: CoreSpacing.lg(ctx),
                    top: CoreSpacing.lg(ctx),
                    bottom:
                        MediaQuery.viewInsetsOf(ctx).bottom +
                        CoreSpacing.lg(ctx),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        WidgetsAppTextField(
                          controller: nameEn,
                          label: l10n.catalogCrudNameEn,
                        ),
                        SizedBox(height: CoreSpacing.sm(ctx)),
                        WidgetsAppTextField(
                          controller: nameAr,
                          label: l10n.catalogCrudNameAr,
                        ),
                        SizedBox(height: CoreSpacing.sm(ctx)),
                        WidgetsAppTextField(
                          controller: sortOrder,
                          label: l10n.catalogCrudSortOrder,
                          keyboardType: TextInputType.number,
                        ),
                        SizedBox(height: CoreSpacing.sm(ctx)),
                        WidgetsAppTextField(
                          controller: descriptionEn,
                          label: l10n.catalogCrudDescriptionEn,
                          maxLines: 2,
                        ),
                        SizedBox(height: CoreSpacing.sm(ctx)),
                        WidgetsAppTextField(
                          controller: descriptionAr,
                          label: l10n.catalogCrudDescriptionAr,
                          maxLines: 2,
                        ),
                        SizedBox(height: CoreSpacing.sm(ctx)),
                        DropdownButtonFormField<String>(
                          initialValue: mealType.isEmpty ? null : mealType,
                          hint: Text(l10n.catalogCrudMealType),
                          items: [
                            DropdownMenuItem(
                              value: 'main',
                              child: Text(l10n.catalogCrudMealMain),
                            ),
                            DropdownMenuItem(
                              value: 'side',
                              child: Text(l10n.catalogCrudMealSide),
                            ),
                            DropdownMenuItem(
                              value: 'drink',
                              child: Text(l10n.catalogCrudMealDrink),
                            ),
                            DropdownMenuItem(
                              value: 'dessert',
                              child: Text(l10n.catalogCrudMealDessert),
                            ),
                          ],
                          onChanged:
                              (v) => setSheetState(() => mealType = v ?? ''),
                        ),
                        SizedBox(height: CoreSpacing.md(ctx)),
                        WidgetsAppButton(
                          label: l10n.actionSave,
                          onPressed: () {
                            ref
                                .read(adminCatalogProvider.notifier)
                                .updateCategory(
                                  category.copyWith(
                                    nameAr: nameAr.text,
                                    nameEn: nameEn.text,
                                    sortOrder:
                                        int.tryParse(sortOrder.text) ??
                                        category.sortOrder,
                                    descriptionAr:
                                        descriptionAr.text.isNotEmpty
                                            ? descriptionAr.text
                                            : null,
                                    descriptionEn:
                                        descriptionEn.text.isNotEmpty
                                            ? descriptionEn.text
                                            : null,
                                    mealType:
                                        mealType.isNotEmpty ? mealType : null,
                                  ),
                                );
                            Navigator.pop(ctx);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
          ),
    );
  }
}

class _ProductsTab extends ConsumerWidget {
  const _ProductsTab({required this.isAr, this.hubMode = false});

  final bool isAr;
  final bool hubMode;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final itemsAsync = ref.watch(menuAllItemsProvider);

    return itemsAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (_, __) => Center(child: Text(l10n.catalogCrudCheckFields)),
      data: (items) {
        if (items.isEmpty) {
          return Center(child: Text(l10n.menuCatalogNoProducts));
        }
        return ListView.separated(
          padding: EdgeInsets.all(CoreSpacing.md(context)),
          itemCount: items.length,
          separatorBuilder:
              (_, __) => SizedBox(height: CoreSpacing.md(context)),
          itemBuilder: (context, index) {
            final item = items[index];
            return _ProductCard(
              item: item,
              isAr: isAr,
              hubMode: hubMode,
            );
          },
        );
      },
    );
  }
}

class _ProductCard extends ConsumerWidget {
  const _ProductCard({
    required this.item,
    required this.isAr,
    this.hubMode = false,
  });

  final ModelMenuItem item;
  final bool isAr;
  final bool hubMode;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    final title = isAr ? item.nameAr : item.nameEn;
    final description = isAr ? item.descriptionAr : item.descriptionEn;
    final priceLabel = UtilityFormatJod.format(
      item.priceJod,
      suffix: l10n.currencyJod,
    );
    final imageUrl =
        item.primaryImageUrl ?? MockupCatalog.promoImageUrlFor(item.id);

    return WidgetsAppCard(
      variant: WidgetsAppCardVariant.food,
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AspectRatio(
            aspectRatio: 16 / 9,
            child: Stack(
              fit: StackFit.expand,
              children: [
                WidgetsMockFoodImage(
                  imageUrl: imageUrl,
                  fallback: ColoredBox(
                    color: CoreColors.brandOrange.withValues(alpha: 0.2),
                    child: Icon(Icons.restaurant_outlined, size: CoreContentSizes.emptyStateIcon(context)),
                  ),
                ),
                Positioned(
                  top: CoreSpacing.sm(context),
                  right: CoreSpacing.sm(context),
                  child: PopupMenuButton<String>(
                    icon: const Icon(Icons.more_vert, color: Colors.white),
                    onSelected: (value) async {
                      if (value == 'edit') {
                        _editProduct(context, ref, item);
                      } else if (value == 'manage' && !hubMode) {
                        await _openManageSheet(context, ref, item);
                      } else if (value == 'delete') {
                        confirmAdminDelete(
                          context,
                          isAr: isAr,
                          onConfirmed: () {
                            final removed = ref
                                .read(adminMenuProvider.notifier)
                                .removeAddedMenuItem(item.id);
                            if (!removed) {
                              ref
                                  .read(adminMenuProvider.notifier)
                                  .unpublishProduct(item.id);
                            }
                            UtilityMockFeedback.showInfo(
                              context,
                              l10n.catalogCrudDeleted,
                            );
                          },
                        );
                      }
                    },
                    itemBuilder:
                        (_) => [
                          PopupMenuItem(
                            value: 'edit',
                            child: Text(l10n.actionEdit),
                          ),
                          if (!hubMode)
                            PopupMenuItem(
                              value: 'manage',
                              child: Text(l10n.menuCatalogManageProduct),
                            ),
                          PopupMenuItem(
                            value: 'delete',
                            child: Text(l10n.addressesDelete),
                          ),
                        ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(CoreSpacing.md(context)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: CoreTypography.titleMedium(
                    context,
                    scheme.onSurface,
                  ).copyWith(fontWeight: FontWeight.w900),
                ),
                SizedBox(height: CoreSpacing.xs(context)),
                Text(
                  description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: CoreTypography.caption(
                    context,
                    scheme.onSurfaceVariant,
                  ),
                ),
                SizedBox(height: CoreSpacing.sm(context)),
                Text(
                  priceLabel,
                  style: CoreTypography.bodyMedium(
                    context,
                    CoreColors.brandOrange,
                  ).copyWith(fontWeight: FontWeight.w800),
                ),
                SizedBox(height: CoreSpacing.sm(context)),
                Text(
                  '${l10n.menuCatalogRewardPointsLabel}: ${item.rewardPoints}',
                  style: CoreTypography.caption(
                    context,
                    CoreColors.brandOlive,
                  ).copyWith(fontWeight: FontWeight.w700),
                ),
                SizedBox(height: CoreSpacing.sm(context)),
                Row(
                  children: [
                    Expanded(
                      child: WidgetsAppButton(
                        label: l10n.actionEdit,
                        variant: WidgetsAppButtonVariant.outline,
                        onPressed: () => _editProduct(context, ref, item),
                      ),
                    ),
                    if (!hubMode) ...[
                      SizedBox(width: CoreSpacing.sm(context)),
                      Expanded(
                        child: WidgetsAppButton(
                          label: l10n.menuCatalogManageProduct,
                          variant: WidgetsAppButtonVariant.outline,
                          onPressed: () => _openManageSheet(context, ref, item),
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _editProduct(
    BuildContext context,
    WidgetRef ref,
    ModelMenuItem item,
  ) {
    final l10n = AppLocalizations.of(context)!;
    final nameEn = TextEditingController(text: item.nameEn);
    final nameAr = TextEditingController(text: item.nameAr);
    final descEn = TextEditingController(text: item.descriptionEn);
    final descAr = TextEditingController(text: item.descriptionAr);
    final price = TextEditingController(text: item.priceJod.toString());
    var images = List<String>.from(item.resolvedImageUrls);
    var categoryId = item.categoryId;
    final categories = ref.read(visibleCategoriesProvider);

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder:
          (ctx) => StatefulBuilder(
            builder:
                (ctx, setSheet) => Padding(
                  padding: EdgeInsets.only(
                    left: CoreSpacing.lg(ctx),
                    right: CoreSpacing.lg(ctx),
                    top: CoreSpacing.lg(ctx),
                    bottom:
                        MediaQuery.viewInsetsOf(ctx).bottom +
                        CoreSpacing.lg(ctx),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        DropdownButtonFormField<String>(
                          initialValue:
                              categories.any((c) => c.id == categoryId)
                                  ? categoryId
                                  : (categories.isEmpty
                                      ? null
                                      : categories.first.id),
                          decoration: InputDecoration(
                            labelText: l10n.menuCatalogTabCategories,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                CoreSpacing.radiusInputOf(ctx),
                              ),
                            ),
                          ),
                          items: [
                            for (final c in categories)
                              DropdownMenuItem(
                                value: c.id,
                                child: Text(isAr ? c.nameAr : c.nameEn),
                              ),
                          ],
                          onChanged: (v) {
                            if (v != null) setSheet(() => categoryId = v);
                          },
                        ),
                        SizedBox(height: CoreSpacing.sm(ctx)),
                        WidgetsAppTextField(
                          controller: nameEn,
                          label: l10n.catalogCrudNameEn,
                        ),
                        SizedBox(height: CoreSpacing.sm(ctx)),
                        WidgetsAppTextField(
                          controller: nameAr,
                          label: l10n.catalogCrudNameAr,
                        ),
                        SizedBox(height: CoreSpacing.sm(ctx)),
                        WidgetsAppTextField(
                          controller: descEn,
                          label: l10n.catalogCrudDescriptionEn,
                          maxLines: 2,
                        ),
                        SizedBox(height: CoreSpacing.sm(ctx)),
                        WidgetsAppTextField(
                          controller: descAr,
                          label: l10n.catalogCrudDescriptionAr,
                          maxLines: 2,
                        ),
                        SizedBox(height: CoreSpacing.sm(ctx)),
                        WidgetsAppTextField(
                          controller: price,
                          label: l10n.catalogCrudPrice,
                          keyboardType: TextInputType.number,
                        ),
                        SizedBox(height: CoreSpacing.xs(ctx)),
                        Text(
                          '${l10n.menuCatalogRewardPointsLabel}: '
                          '${((double.tryParse(price.text) ?? item.priceJod) * 10).round()}',
                          style: CoreTypography.caption(
                            ctx,
                            Theme.of(ctx).colorScheme.onSurfaceVariant,
                          ),
                        ),
                        SizedBox(height: CoreSpacing.sm(ctx)),
                        WidgetsCatalogImageEditor(
                          imageUrls: images,
                          onChanged: (urls) => setSheet(() => images = urls),
                          isAr: isAr,
                          minImages: 1,
                          maxImages: CatalogImageLimits.maxProductImages,
                        ),
                        SizedBox(height: CoreSpacing.md(ctx)),
                        WidgetsAppButton(
                          label: l10n.actionSave,
                          onPressed: () {
                            if (images.isEmpty) {
                              UtilityMockFeedback.showWarning(
                                ctx,
                                l10n.catalogCrudMinOneImage,
                              );
                              return;
                            }
                            final next = item.copyWith(
                              categoryId: categoryId,
                              nameEn: nameEn.text,
                              nameAr: nameAr.text,
                              descriptionEn: descEn.text,
                              descriptionAr: descAr.text,
                              priceJod:
                                  double.tryParse(price.text) ?? item.priceJod,
                              imageUrls: images.take(5).toList(),
                            );
                            final updated = ref
                                .read(adminMenuProvider.notifier)
                                .updateAddedMenuItem(next);
                            if (!updated) {
                              ref
                                  .read(adminMenuProvider.notifier)
                                  .upsertCatalogItemOverride(next);
                            }
                            Navigator.pop(ctx);
                            UtilityMockFeedback.showSuccess(
                              context,
                              l10n.catalogCrudUpdated,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
          ),
    );
  }

  Future<void> _openManageSheet(
    BuildContext context,
    WidgetRef ref,
    ModelMenuItem item,
  ) {
    final l10n = AppLocalizations.of(context)!;
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder:
          (ctx) => DraggableScrollableSheet(
            expand: false,
            initialChildSize: 0.85,
            minChildSize: 0.5,
            maxChildSize: 0.95,
            builder:
                (_, scrollController) => DefaultTabController(
                  length: 3,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: CoreSpacing.lg(ctx),
                        ),
                        child: Text(
                          isAr ? item.nameAr : item.nameEn,
                          style: CoreTypography.titleMedium(context, Theme.of(context).colorScheme.onSurface).copyWith(fontWeight: FontWeight.w900),
                        ),
                      ),
                      TabBar(
                        tabs: [
                          Tab(text: l10n.menuCatalogTabAddons),
                          Tab(text: l10n.menuCatalogTabRelated),
                          Tab(text: l10n.menuCatalogTabReward),
                        ],
                      ),
                      Expanded(
                        child: TabBarView(
                          children: [
                            _ProductAddonsAttachPane(
                              productId: item.id,
                              isAr: isAr,
                              scrollController: scrollController,
                            ),
                            _ProductRelatedPane(
                              productId: item.id,
                              isAr: isAr,
                              scrollController: scrollController,
                            ),
                            _ProductRewardPane(
                              item: item,
                              isAr: isAr,
                              scrollController: scrollController,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
          ),
    );
  }
}

class _ProductAddonsAttachPane extends ConsumerStatefulWidget {
  const _ProductAddonsAttachPane({
    required this.productId,
    required this.isAr,
    required this.scrollController,
  });

  final String productId;
  final bool isAr;
  final ScrollController scrollController;

  @override
  ConsumerState<_ProductAddonsAttachPane> createState() =>
      _ProductAddonsAttachPaneState();
}

class _ProductAddonsAttachPaneState
    extends ConsumerState<_ProductAddonsAttachPane> {
  late Map<String, ModelProductAddonAttachment> _draft;

  @override
  void initState() {
    super.initState();
    final existing =
        ref.read(adminCatalogProvider).productAddonAttachments[widget.productId];
    _draft = {
      for (final a in existing ?? const <ModelProductAddonAttachment>[])
        a.addonId: a,
    };
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final library = ref.watch(visibleAddonsProvider);

    final children = <Widget>[
        Text(
          l10n.menuCatalogAttachAddonsHint,
          style: CoreTypography.caption(
            context,
            Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
        SizedBox(height: CoreSpacing.md(context)),
        for (final addon in library) ...[
          CheckboxListTile(
            value: _draft.containsKey(addon.id),
            title: Text(widget.isAr ? addon.labelAr : addon.labelEn),
            subtitle: Text(
              UtilityFormatJod.format(
                addon.priceDeltaJod,
                suffix: l10n.currencyJod,
              ),
            ),
            onChanged: (checked) {
              setState(() {
                if (checked == true) {
                  _draft[addon.id] = ModelProductAddonAttachment(
                    addonId: addon.id,
                  );
                } else {
                  _draft.remove(addon.id);
                }
              });
            },
          ),
          if (_draft.containsKey(addon.id))
            Padding(
              padding: EdgeInsetsDirectional.only(
                start: CoreSpacing.lg(context),
                end: CoreSpacing.md(context),
                bottom: CoreSpacing.sm(context),
              ),
              child: Row(
                children: [
                  FilterChip(
                    label: Text(l10n.productFree),
                    selected: _draft[addon.id]!.isFree,
                    onSelected: (v) {
                      setState(() {
                        _draft[addon.id] = _draft[addon.id]!.copyWith(
                          isFree: v,
                          clearPriceOverride: v,
                        );
                      });
                    },
                  ),
                  SizedBox(width: CoreSpacing.sm(context)),
                  if (!_draft[addon.id]!.isFree)
                    Expanded(
                      child: WidgetsAppTextField(
                        key: ValueKey('ovr_${addon.id}'),
                        initialValue:
                            _draft[addon.id]!.priceOverrideJod?.toString() ??
                            '',
                        label: l10n.menuCatalogAddonPriceOverride,
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          final parsed = double.tryParse(value);
                          setState(() {
                            _draft[addon.id] = _draft[addon.id]!.copyWith(
                              priceOverrideJod: parsed,
                              clearPriceOverride: value.trim().isEmpty,
                            );
                          });
                        },
                      ),
                    ),
                ],
              ),
            ),
        ],
        SizedBox(height: CoreSpacing.md(context)),
        WidgetsAppButton(
          label: l10n.actionSave,
          onPressed: () {
            ref.read(adminCatalogProvider.notifier).setProductAddonAttachments(
              widget.productId,
              _draft.values.toList(),
            );
            UtilityMockFeedback.showSuccess(context, l10n.catalogCrudUpdated);
          },
        ),
    ];
    return ListView.builder(
      controller: widget.scrollController,
      padding: EdgeInsets.all(CoreSpacing.lg(context)),
      itemCount: children.length,
      itemBuilder: (context, index) => children[index],
    );
  }
}

class _ProductRelatedPane extends ConsumerStatefulWidget {
  const _ProductRelatedPane({
    required this.productId,
    required this.isAr,
    required this.scrollController,
  });

  final String productId;
  final bool isAr;
  final ScrollController scrollController;

  @override
  ConsumerState<_ProductRelatedPane> createState() =>
      _ProductRelatedPaneState();
}

class _ProductRelatedPaneState extends ConsumerState<_ProductRelatedPane> {
  late Set<String> _selected;

  @override
  void initState() {
    super.initState();
    final existing = ref.read(relatedProductsForItemProvider(widget.productId));
    _selected = {...existing};
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final itemsAsync = ref.watch(menuAllItemsProvider);

    return itemsAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (_, __) => const SizedBox.shrink(),
      data: (items) {
        final others =
            items.where((i) => i.id != widget.productId).toList();
        final children = <Widget>[
            Text(
              l10n.menuCatalogRelatedMultiSelectHint,
              style: CoreTypography.caption(
                context,
                Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            SizedBox(height: CoreSpacing.md(context)),
            for (final item in others)
              CheckboxListTile(
                value: _selected.contains(item.id),
                title: Text(widget.isAr ? item.nameAr : item.nameEn),
                onChanged: (checked) {
                  setState(() {
                    if (checked == true) {
                      _selected.add(item.id);
                    } else {
                      _selected.remove(item.id);
                    }
                  });
                },
              ),
            SizedBox(height: CoreSpacing.md(context)),
            WidgetsAppButton(
              label: l10n.menuCatalogSaveLink,
              onPressed: () {
                ref.read(adminCatalogProvider.notifier).upsertRelatedLink(
                  ModelRelatedProductLink(
                    productId: widget.productId,
                    relatedProductIds: _selected.toList(),
                  ),
                );
                UtilityMockFeedback.showSuccess(
                  context,
                  l10n.menuCatalogSaved,
                );
              },
            ),
        ];
        return ListView.builder(
          controller: widget.scrollController,
          padding: EdgeInsets.all(CoreSpacing.lg(context)),
          itemCount: children.length,
          itemBuilder: (context, index) => children[index],
        );
      },
    );
  }
}

class _ProductRewardPane extends ConsumerStatefulWidget {
  const _ProductRewardPane({
    required this.item,
    required this.isAr,
    required this.scrollController,
  });

  final ModelMenuItem item;
  final bool isAr;
  final ScrollController scrollController;

  @override
  ConsumerState<_ProductRewardPane> createState() => _ProductRewardPaneState();
}

class _ProductRewardPaneState extends ConsumerState<_ProductRewardPane> {
  late String _selected;

  @override
  void initState() {
    super.initState();
    _selected = widget.item.rewardId ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final rewards = ref.watch(rewardsCatalogProvider).rewards;

    final children = <Widget>[
        Text(
          l10n.marketingLinkedRewardTitle,
          style: CoreTypography.titleMedium(context, Theme.of(context).colorScheme.onSurface).copyWith(fontWeight: FontWeight.w900),
        ),
        SizedBox(height: CoreSpacing.md(context)),
        RadioListTile<String>(
          value: '',
          groupValue: _selected,
          title: Text(l10n.marketingLinkedRewardNone),
          onChanged: (v) => setState(() => _selected = v ?? ''),
        ),
        for (final ModelCustomerReward reward in rewards)
          RadioListTile<String>(
            value: reward.id,
            groupValue: _selected,
            title: Text(widget.isAr ? reward.titleAr : reward.titleEn),
            subtitle: Text(l10n.loyaltyPointsShort('${reward.points}')),
            onChanged: (v) => setState(() => _selected = v ?? ''),
          ),
        SizedBox(height: CoreSpacing.md(context)),
        WidgetsAppButton(
          label: l10n.actionSave,
          onPressed: () {
            final rewardId = _selected.isEmpty ? null : _selected;
            final next = widget.item.copyWith(
              rewardId: rewardId,
              clearRewardId: rewardId == null,
            );
            final updated = ref
                .read(adminMenuProvider.notifier)
                .updateAddedMenuItem(next);
            if (!updated) {
              ref
                  .read(adminMenuProvider.notifier)
                  .upsertCatalogItemOverride(next);
            }
            UtilityMockFeedback.showSuccess(context, l10n.catalogCrudUpdated);
          },
        ),
    ];
    return ListView.builder(
      controller: widget.scrollController,
      padding: EdgeInsets.all(CoreSpacing.lg(context)),
      itemCount: children.length,
      itemBuilder: (context, index) => children[index],
    );
  }
}

class _AddFormCard extends StatelessWidget {
  const _AddFormCard({
    required this.title,
    required this.isAr,
    required this.onSubmit,
    required this.fields,
  });

  final String title;
  final bool isAr;
  final VoidCallback onSubmit;
  final List<Widget> fields;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return WidgetsAppCard(
      title: title,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ...fields,
          SizedBox(height: CoreSpacing.md(context)),
          WidgetsAppButton(
            label: l10n.actionAdd,
            icon: Icons.add_outlined,
            onPressed: onSubmit,
          ),
          SizedBox(height: CoreSpacing.lg(context)),
        ],
      ),
    );
  }
}

class _CatalogListTile extends StatelessWidget {
  const _CatalogListTile({
    required this.title,
    required this.subtitle,
    required this.isAr,
    required this.onEdit,
    required this.onDelete,
  });

  final String title;
  final String subtitle;
  final bool isAr;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: CoreSpacing.sm(context)),
      child: WidgetsAppCard(
        variant: WidgetsAppCardVariant.form,
        padding: EdgeInsets.all(CoreSpacing.md(context)),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: CoreTypography.titleMedium(
                      context,
                      Theme.of(context).colorScheme.onSurface,
                    ).copyWith(fontWeight: FontWeight.w900),
                  ),
                  Text(
                    subtitle,
                    style: CoreTypography.caption(
                      context,
                      Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: onEdit,
              icon: const Icon(Icons.edit_outlined),
            ),
            IconButton(
              onPressed: onDelete,
              icon: const Icon(Icons.delete_outline),
              color: CoreColors.semanticError,
            ),
          ],
        ),
      ),
    );
  }
}

enum _HubScopedKind { addons, related }

/// Addons / Related hub tabs: pick a product, then edit attachments.
class _ProductScopedHubTab extends ConsumerStatefulWidget {
  const _ProductScopedHubTab({
    required this.isAr,
    required this.kind,
    this.lockProductId,
  });

  final bool isAr;
  final _HubScopedKind kind;
  final String? lockProductId;

  @override
  ConsumerState<_ProductScopedHubTab> createState() =>
      _ProductScopedHubTabState();
}

class _ProductScopedHubTabState extends ConsumerState<_ProductScopedHubTab> {
  String? _productId;
  final _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final itemsAsync = ref.watch(menuAllItemsProvider);
    final locked = widget.lockProductId;

    return itemsAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (_, __) => Center(child: Text(l10n.catalogCrudCheckFields)),
      data: (items) {
        if (locked != null && locked.isNotEmpty) {
          return widget.kind == _HubScopedKind.addons
              ? _ProductAddonsAttachPane(
                productId: locked,
                isAr: widget.isAr,
                scrollController: _scrollController,
              )
              : _ProductRelatedPane(
                productId: locked,
                isAr: widget.isAr,
                scrollController: _scrollController,
              );
        }
        if (items.isEmpty) {
          return Center(child: Text(l10n.menuCatalogNoProducts));
        }
        final selectedId =
            _productId != null && items.any((i) => i.id == _productId)
                ? _productId
                : items.first.id;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.all(CoreSpacing.md(context)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    l10n.menuCatalogPickProductHint,
                    style: CoreTypography.caption(
                      context,
                      Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                  SizedBox(height: CoreSpacing.sm(context)),
                  DropdownButtonFormField<String>(
                    initialValue: selectedId,
                    decoration: InputDecoration(
                      labelText: l10n.menuCatalogPickProduct,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          CoreSpacing.radiusInputOf(context),
                        ),
                      ),
                    ),
                    items: [
                      for (final item in items)
                        DropdownMenuItem(
                          value: item.id,
                          child: Text(
                            widget.isAr ? item.nameAr : item.nameEn,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                    ],
                    onChanged: (id) {
                      if (id != null) setState(() => _productId = id);
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child:
                  widget.kind == _HubScopedKind.addons
                      ? _ProductAddonsAttachPane(
                        productId: selectedId!,
                        isAr: widget.isAr,
                        scrollController: _scrollController,
                      )
                      : _ProductRelatedPane(
                        productId: selectedId!,
                        isAr: widget.isAr,
                        scrollController: _scrollController,
                      ),
            ),
          ],
        );
      },
    );
  }
}

class _MarketingRatingsTab extends ConsumerWidget {
  const _MarketingRatingsTab({required this.isAr, this.lockProductId});

  final bool isAr;
  final String? lockProductId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final all = ref.watch(reviewsModerationProvider).reviews;
    final reviews =
        (lockProductId == null || lockProductId!.isEmpty)
            ? all
            : all
                .where(
                  (r) =>
                      r.menuItemId == lockProductId || r.menuItemId == null,
                )
                .toList();
    final scheme = Theme.of(context).colorScheme;

    if (reviews.isEmpty) {
      return Center(child: Text(l10n.catalogBrowseEmpty));
    }

    return ListView.separated(
      padding: EdgeInsets.all(CoreSpacing.md(context)),
      itemCount: reviews.length,
      separatorBuilder: (_, __) => SizedBox(height: CoreSpacing.md(context)),
      itemBuilder: (context, index) {
        final review = reviews[index];
        return WidgetsAppCard(
          variant: WidgetsAppCardVariant.form,
          padding: EdgeInsets.all(CoreSpacing.md(context)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      isAr ? review.productNameAr : review.productNameEn,
                      style: CoreTypography.titleMedium(
                        context,
                        scheme.onSurface,
                      ).copyWith(fontWeight: FontWeight.w900),
                    ),
                  ),
                  WidgetsStatusPill(
                    label: switch (review.status) {
                      ReviewModerationStatus.pending =>
                        l10n.reviewModerationStatusPending,
                      ReviewModerationStatus.approved =>
                        l10n.reviewModerationStatusApproved,
                      ReviewModerationStatus.rejected =>
                        l10n.reviewModerationStatusRejected,
                      ReviewModerationStatus.flagged =>
                        l10n.reviewModerationStatusFlagged,
                    },
                    color: switch (review.status) {
                      ReviewModerationStatus.pending => CoreColors.brandGold,
                      ReviewModerationStatus.approved =>
                        CoreColors.semanticSuccess,
                      ReviewModerationStatus.rejected =>
                        CoreColors.semanticError,
                      ReviewModerationStatus.flagged => CoreColors.brandOrange,
                    },
                  ),
                ],
              ),
              SizedBox(height: CoreSpacing.xs(context)),
              Text(
                '${review.customerName} • ${'★' * review.rating}',
                style: CoreTypography.caption(
                  context,
                  scheme.onSurfaceVariant,
                ),
              ),
              SizedBox(height: CoreSpacing.sm(context)),
              Text(
                isAr ? review.commentAr : review.commentEn,
                style: CoreTypography.bodyMedium(
                  context,
                  scheme.onSurfaceVariant,
                ),
              ),
              if (review.adminNote != null && review.adminNote!.isNotEmpty) ...[
                SizedBox(height: CoreSpacing.xs(context)),
                Text(
                  review.adminNote!,
                  style: CoreTypography.caption(
                    context,
                    CoreColors.brandBrown,
                  ).copyWith(fontWeight: FontWeight.w700),
                ),
              ],
              SizedBox(height: CoreSpacing.md(context)),
              WidgetsAppButton(
                label: l10n.menuCatalogEditRating,
                variant: WidgetsAppButtonVariant.outline,
                icon: Icons.rate_review_outlined,
                onPressed: () => _editRating(context, ref, review),
              ),
              if (review.status == ReviewModerationStatus.pending) ...[
                SizedBox(height: CoreSpacing.sm(context)),
                Wrap(
                  spacing: CoreSpacing.sm(context),
                  runSpacing: CoreSpacing.sm(context),
                  children: [
                    WidgetsAppButton(
                      label: l10n.rbacApprove,
                      onPressed: () {
                        ref
                            .read(reviewsModerationProvider.notifier)
                            .moderate(
                              review.id,
                              ReviewModerationStatus.approved,
                            );
                        UtilityMockFeedback.showSuccess(
                          context,
                          l10n.reviewModerationUpdated,
                        );
                      },
                    ),
                    WidgetsAppButton(
                      label: l10n.reviewModerationReject,
                      variant: WidgetsAppButtonVariant.outline,
                      onPressed: () {
                        ref
                            .read(reviewsModerationProvider.notifier)
                            .moderate(
                              review.id,
                              ReviewModerationStatus.rejected,
                            );
                        UtilityMockFeedback.showSuccess(
                          context,
                          l10n.reviewModerationUpdated,
                        );
                      },
                    ),
                  ],
                ),
              ],
            ],
          ),
        );
      },
    );
  }

  Future<void> _editRating(
    BuildContext context,
    WidgetRef ref,
    ProductReviewRecord review,
  ) async {
    final l10n = AppLocalizations.of(context)!;
    final commentEn = TextEditingController(text: review.commentEn);
    final commentAr = TextEditingController(text: review.commentAr);
    final note = TextEditingController(text: review.adminNote ?? '');
    var rating = review.rating;

    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder:
          (ctx) => StatefulBuilder(
            builder:
                (ctx, setSheet) => Padding(
                  padding: EdgeInsets.only(
                    left: CoreSpacing.lg(ctx),
                    right: CoreSpacing.lg(ctx),
                    top: CoreSpacing.lg(ctx),
                    bottom:
                        MediaQuery.viewInsetsOf(ctx).bottom +
                        CoreSpacing.lg(ctx),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          l10n.menuCatalogEditRating,
                          style: CoreTypography.titleMedium(
                            ctx,
                            Theme.of(ctx).colorScheme.onSurface,
                          ).copyWith(fontWeight: FontWeight.w900),
                        ),
                        SizedBox(height: CoreSpacing.md(ctx)),
                        Text(
                          l10n.staffCustomerRating,
                          style: CoreTypography.caption(
                            ctx,
                            Theme.of(ctx).colorScheme.onSurfaceVariant,
                          ),
                        ),
                        SizedBox(height: CoreSpacing.xs(ctx)),
                        Wrap(
                          spacing: CoreSpacing.xs(ctx),
                          children: [
                            for (var star = 1; star <= 5; star++)
                              IconButton(
                                onPressed:
                                    () => setSheet(() => rating = star),
                                icon: Icon(
                                  star <= rating
                                      ? Icons.star_rounded
                                      : Icons.star_outline_rounded,
                                  color: CoreColors.brandGold,
                                ),
                              ),
                          ],
                        ),
                        WidgetsAppTextField(
                          controller: commentEn,
                          label: l10n.catalogCrudDescriptionEn,
                          maxLines: 3,
                        ),
                        SizedBox(height: CoreSpacing.sm(ctx)),
                        WidgetsAppTextField(
                          controller: commentAr,
                          label: l10n.catalogCrudDescriptionAr,
                          maxLines: 3,
                        ),
                        SizedBox(height: CoreSpacing.sm(ctx)),
                        WidgetsAppTextField(
                          controller: note,
                          label: l10n.adminReviewAction,
                          maxLines: 2,
                        ),
                        SizedBox(height: CoreSpacing.md(ctx)),
                        WidgetsAppButton(
                          label: l10n.actionSave,
                          onPressed: () {
                            final ok = ref
                                .read(reviewsModerationProvider.notifier)
                                .updateReview(
                                  id: review.id,
                                  rating: rating,
                                  commentEn: commentEn.text,
                                  commentAr: commentAr.text,
                                  adminNote: note.text,
                                );
                            Navigator.pop(ctx);
                            if (ok) {
                              UtilityMockFeedback.showSuccess(
                                context,
                                l10n.menuCatalogRatingSaved,
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
          ),
    );
  }
}

class _CustomerProductPreviewTab extends ConsumerWidget {
  const _CustomerProductPreviewTab({required this.isAr});

  final bool isAr;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final item = ref.watch(selectedMenuItemProvider);
    if (item == null) {
      return Center(
        child: Text(
          l10n.catalogBrowseEmpty,
          style: CoreTypography.bodyMedium(
            context,
            Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
      );
    }
    final title = isAr ? item.nameAr : item.nameEn;
    final body = isAr ? item.descriptionAr : item.descriptionEn;
    final children = <Widget>[
        WidgetsAppCard(
          variant: WidgetsAppCardVariant.food,
          padding: EdgeInsets.zero,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AspectRatio(
                aspectRatio: 16 / 9,
                child: WidgetsMockFoodImage(
                  imageUrl: item.imageUrls.isNotEmpty ? item.imageUrls.first : null,
                  fit: BoxFit.cover,
                  fallback: ColoredBox(
                    color: CoreColors.brandOlive.withValues(alpha: 0.12),
                    child: const Icon(Icons.restaurant_outlined),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(CoreSpacing.lg(context)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: CoreTypography.titleMedium(
                        context,
                        Theme.of(context).colorScheme.onSurface,
                      ).copyWith(fontWeight: FontWeight.w900),
                    ),
                    SizedBox(height: CoreSpacing.xs(context)),
                    Text(
                      UtilityFormatJod.format(item.priceJod),
                      style: CoreTypography.titleMedium(
                        context,
                        CoreColors.brandOrange,
                      ).copyWith(fontWeight: FontWeight.w800),
                    ),
                    SizedBox(height: CoreSpacing.sm(context)),
                    Text(
                      body,
                      style: CoreTypography.bodyMedium(
                        context,
                        Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                    SizedBox(height: CoreSpacing.sm(context)),
                    WidgetsStatusPill(
                      label: l10n.loyaltyPointsShort('${item.rewardPoints}'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
    ];
    return ListView.builder(
      padding: EdgeInsets.all(CoreSpacing.lg(context)),
      itemCount: children.length,
      itemBuilder: (context, index) => children[index],
    );
  }
}

/// Product create/edit form tab (not a product list).
class _ProductFormTab extends ConsumerStatefulWidget {
  const _ProductFormTab({
    required this.isAr,
    required this.productId,
    required this.isCreate,
  });

  final bool isAr;
  final String productId;
  final bool isCreate;

  @override
  ConsumerState<_ProductFormTab> createState() => _ProductFormTabState();
}

class _ProductFormTabState extends ConsumerState<_ProductFormTab> {
  late final TextEditingController _nameEn;
  late final TextEditingController _nameAr;
  late final TextEditingController _descEn;
  late final TextEditingController _descAr;
  late final TextEditingController _price;
  late List<String> _images;
  late String _categoryId;
  var _ready = false;

  @override
  void initState() {
    super.initState();
    _nameEn = TextEditingController();
    _nameAr = TextEditingController();
    _descEn = TextEditingController();
    _descAr = TextEditingController();
    _price = TextEditingController(text: '1');
    _images = [];
    _categoryId = 'shawarma';
    WidgetsBinding.instance.addPostFrameCallback((_) => _load());
  }

  void _load() {
    final item = ref.read(menuItemByIdProvider(widget.productId));
    final categories = ref.read(visibleCategoriesProvider);
    if (item != null) {
      _nameEn.text = item.nameEn;
      _nameAr.text = item.nameAr;
      _descEn.text = item.descriptionEn;
      _descAr.text = item.descriptionAr;
      _price.text = item.priceJod.toString();
      _images = List<String>.from(item.resolvedImageUrls);
      _categoryId = item.categoryId;
    } else if (categories.isNotEmpty) {
      _categoryId = categories.first.id;
    }
    if (mounted) setState(() => _ready = true);
  }

  @override
  void dispose() {
    _nameEn.dispose();
    _nameAr.dispose();
    _descEn.dispose();
    _descAr.dispose();
    _price.dispose();
    super.dispose();
  }

  void _persistDraft() {
    final price = double.tryParse(_price.text) ?? 1;
    final next = ModelMenuItem(
      id: widget.productId,
      categoryId: _categoryId,
      nameEn: _nameEn.text.trim().isEmpty ? 'New product' : _nameEn.text.trim(),
      nameAr: _nameAr.text.trim().isEmpty ? 'منتج جديد' : _nameAr.text.trim(),
      descriptionEn: _descEn.text,
      descriptionAr: _descAr.text,
      priceJod: price <= 0 ? 1 : price,
      imageUrls: _images.take(5).toList(),
      imageUrl: _images.isNotEmpty ? _images.first : null,
    );
    final updated =
        ref.read(adminMenuProvider.notifier).updateAddedMenuItem(next);
    if (!updated) {
      ref.read(adminMenuProvider.notifier).upsertCatalogItemOverride(next);
    }
    ref.read(selectedMenuItemIdProvider.notifier).state = widget.productId;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final categories = ref.watch(visibleCategoriesProvider);
    if (!_ready) {
      return const Center(child: CircularProgressIndicator());
    }

    final children = <Widget>[
        DropdownButtonFormField<String>(
          initialValue:
              categories.any((c) => c.id == _categoryId)
                  ? _categoryId
                  : (categories.isEmpty ? null : categories.first.id),
          decoration: InputDecoration(
            labelText: l10n.menuCatalogTabCategories,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                CoreSpacing.radiusInputOf(context),
              ),
            ),
          ),
          items: [
            for (final c in categories)
              DropdownMenuItem(
                value: c.id,
                child: Text(widget.isAr ? c.nameAr : c.nameEn),
              ),
          ],
          onChanged: (v) {
            if (v == null) return;
            setState(() => _categoryId = v);
            _persistDraft();
          },
        ),
        SizedBox(height: CoreSpacing.sm(context)),
        WidgetsAppTextField(
          controller: _nameEn,
          label: l10n.catalogCrudNameEn,
          onChanged: (_) => _persistDraft(),
        ),
        SizedBox(height: CoreSpacing.sm(context)),
        WidgetsAppTextField(
          controller: _nameAr,
          label: l10n.catalogCrudNameAr,
          onChanged: (_) => _persistDraft(),
        ),
        SizedBox(height: CoreSpacing.sm(context)),
        WidgetsAppTextField(
          controller: _descEn,
          label: l10n.catalogCrudDescriptionEn,
          maxLines: 2,
          onChanged: (_) => _persistDraft(),
        ),
        SizedBox(height: CoreSpacing.sm(context)),
        WidgetsAppTextField(
          controller: _descAr,
          label: l10n.catalogCrudDescriptionAr,
          maxLines: 2,
          onChanged: (_) => _persistDraft(),
        ),
        SizedBox(height: CoreSpacing.sm(context)),
        WidgetsAppTextField(
          controller: _price,
          label: l10n.catalogCrudPrice,
          keyboardType: TextInputType.number,
          onChanged: (_) {
            setState(() {});
            _persistDraft();
          },
        ),
        SizedBox(height: CoreSpacing.xs(context)),
        Text(
          '${l10n.menuCatalogRewardPointsLabel}: '
          '${((double.tryParse(_price.text) ?? 1) * 10).round()}',
          style: CoreTypography.caption(
            context,
            Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
        SizedBox(height: CoreSpacing.sm(context)),
        WidgetsCatalogImageEditor(
          imageUrls: _images,
          onChanged: (urls) {
            setState(() => _images = urls);
            _persistDraft();
          },
          isAr: widget.isAr,
          minImages: 0,
          maxImages: CatalogImageLimits.maxProductImages,
        ),
        SizedBox(height: CoreSpacing.lg(context)),
        WidgetsAppButton(
          label: widget.isCreate ? l10n.actionSave : l10n.actionSave,
          icon: Icons.check_outlined,
          onPressed: () {
            if (_nameEn.text.trim().isEmpty) {
              UtilityMockFeedback.showWarning(
                context,
                l10n.catalogCrudCheckFields,
              );
              return;
            }
            _persistDraft();
            UtilityMockFeedback.showSuccess(
              context,
              widget.isCreate ? l10n.catalogCrudAdded : l10n.catalogCrudUpdated,
            );
            if (widget.isCreate && context.canPop()) {
              context.pop();
            }
          },
        ),
    ];
    return ListView.builder(
      padding: EdgeInsets.all(CoreSpacing.lg(context)),
      itemCount: children.length,
      itemBuilder: (context, index) => children[index],
    );
  }
}

import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/data/models/model_menu_category.dart';
import 'package:ayletna_restaurant_app/data/models/model_menu_item.dart';
import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:ayletna_restaurant_app/navigation/app_route_paths.dart';
import 'package:ayletna_restaurant_app/providers/admin_catalog_providers.dart';
import 'package:ayletna_restaurant_app/providers/customer_action_providers.dart';
import 'package:ayletna_restaurant_app/providers/menu_providers.dart';
import 'package:ayletna_restaurant_app/utilities/utility_format_jod.dart';
import 'package:ayletna_restaurant_app/utilities/utility_mock_feedback.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_cart_customization_sheet.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_search_field.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_search_result_row.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_refresh_list.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_scaffold_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Customer menu search · Stitch v2 customer-1.
class CustomerSearchScreen extends ConsumerStatefulWidget {
  const CustomerSearchScreen({this.initialQuery = '', super.key});

  final String initialQuery;

  @override
  ConsumerState<CustomerSearchScreen> createState() =>
      _CustomerSearchScreenState();
}

class _CustomerSearchScreenState extends ConsumerState<CustomerSearchScreen> {
  late final TextEditingController _controller;
  late String _query;
  List<String> _recentSearches = const [];
  bool _recentInitialized = false;

  @override
  void initState() {
    super.initState();
    _query = widget.initialQuery.trim();
    _controller = TextEditingController(text: _query);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_recentInitialized) {
      return;
    }
    final l10n = AppLocalizations.of(context)!;
    final isAr = Localizations.localeOf(context).languageCode == 'ar';
    final categories = ref.read(visibleCategoriesProvider);
    _recentSearches = _defaultRecentSearches(l10n, categories, isAr);
    _recentInitialized = true;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isAr = Localizations.localeOf(context).languageCode == 'ar';
    final menuAsync = ref.watch(menuAllItemsProvider);
    final categories = ref.watch(visibleCategoriesProvider);

    final allItems = menuAsync.maybeWhen(
      data: (items) => items,
      orElse: () => const <ModelMenuItem>[],
    );
    final results = _resultsFor(_query, allItems, categories);
    final favoriteIds = ref.watch(favoriteMenuIdsProvider);

    return WidgetsScaffoldPage(
      title: l10n.screenSearch,
      child: WidgetsRefreshList(
        onRefresh: () async {
          ref.invalidate(menuAllItemsProvider);
          if (context.mounted) {
            UtilityMockFeedback.showInfo(context, l10n.searchRefreshed);
          }
        },
        child: ListView(
          children: [
            SizedBox(height: CoreSpacing.md(context)),
            WidgetsSearchField(
              controller: _controller,
              hintText: l10n.searchMenuHint,
              onChanged: (value) => setState(() => _query = value.trim()),
              onSubmitted: _submit,
            ),
            SizedBox(height: CoreSpacing.lg(context)),
            _RecentSearchesSection(
              searches: _recentSearches,
              onSelected: _useSuggestion,
              onClear:
                  () => setState(() {
                    _recentSearches = const [];
                  }),
            ),
            SizedBox(height: CoreSpacing.xl(context)),
            _ResultsHeader(count: results.length),
            SizedBox(height: CoreSpacing.md(context)),
            if (results.isEmpty)
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: CoreSpacing.xl(context),
                ),
                child: Text(
                  l10n.searchEmptyBody,
                  textAlign: TextAlign.center,
                  style: CoreTypography.bodyMedium(
                    context,
                    Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              )
            else
              for (var index = 0; index < results.length; index++) ...[
                WidgetsSearchResultRow(
                  title: isAr ? results[index].nameAr : results[index].nameEn,
                  description:
                      isAr
                          ? results[index].descriptionAr
                          : results[index].descriptionEn,
                  priceLabel: UtilityFormatJod.format(
                    results[index].priceJod,
                    suffix: l10n.currencyJod,
                  ),
                  imageUrl: results[index].primaryImageUrl,
                  actionLabel: l10n.searchAddShort,
                  index: index,
                  isFavorite: favoriteIds.contains(results[index].id),
                  onAdd: () => _addItem(results[index]),
                  onTap: () => _openItem(results[index]),
                  onFavorite: () {
                    final saved = ref
                        .read(favoriteMenuIdsProvider.notifier)
                        .toggle(results[index].id);
                    UtilityMockFeedback.showSuccess(
                      context,
                      saved ? l10n.favoritesSaved : l10n.favoritesRemoved,
                    );
                  },
                ),
                if (index != results.length - 1)
                  SizedBox(height: CoreSpacing.md(context)),
              ],
            SizedBox(height: CoreSpacing.xxl(context)),
          ],
        ),
      ),
    );
  }

  List<String> _defaultRecentSearches(
    AppLocalizations l10n,
    List<ModelMenuCategory> categories,
    bool isAr,
  ) {
    final fromCategories =
        categories.take(3).map((c) => isAr ? c.nameAr : c.nameEn).toList();
    if (fromCategories.length >= 3) {
      return fromCategories;
    }
    return fromCategories;
  }

  void _submit(String value) {
    final normalized = value.trim();
    if (normalized.isEmpty) {
      setState(() => _query = '');
      return;
    }
    setState(() {
      _query = normalized;
      _recentSearches =
          [
            normalized,
            ..._recentSearches.where((term) => term != normalized),
          ].take(6).toList();
    });
  }

  void _useSuggestion(String value) {
    _controller.text = value;
    _submit(value);
  }

  void _openItem(ModelMenuItem item) {
    ref.read(selectedMenuItemIdProvider.notifier).state = item.id;
    context.push(AppRoutePaths.productDetail);
  }

  void _addItem(ModelMenuItem item) {
    showWidgetsCartCustomizationSheet(context: context, item: item);
  }

  List<ModelMenuItem> _resultsFor(
    String query,
    List<ModelMenuItem> items,
    List<ModelMenuCategory> categories,
  ) {
    final normalizedQuery = query.toLowerCase();
    if (normalizedQuery.isEmpty) {
      return items.take(12).toList();
    }

    return items.where((item) {
      if (!item.isAvailable) return false;
      final category = categories.firstWhere(
        (candidate) => candidate.id == item.categoryId,
        orElse:
            () =>
                categories.isNotEmpty
                    ? categories.first
                    : const ModelMenuCategory(
                      id: '',
                      nameAr: '',
                      nameEn: '',
                      iconKey: 'restaurant',
                    ),
      );
      final searchable =
          [
            item.nameAr,
            item.nameEn,
            item.descriptionAr,
            item.descriptionEn,
            category.nameAr,
            category.nameEn,
          ].join(' ').toLowerCase();
      return searchable.contains(normalizedQuery);
    }).toList();
  }
}

class _RecentSearchesSection extends StatelessWidget {
  const _RecentSearchesSection({
    required this.searches,
    required this.onSelected,
    required this.onClear,
  });

  final List<String> searches;
  final ValueChanged<String> onSelected;
  final VoidCallback onClear;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;

    if (searches.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                l10n.searchRecentTitle,
                style: CoreTypography.titleMedium(
                  context,
                  scheme.onSurface,
                ).copyWith(fontWeight: FontWeight.w900),
              ),
            ),
            TextButton(onPressed: onClear, child: Text(l10n.searchClearAll)),
          ],
        ),
        SizedBox(height: CoreSpacing.sm(context)),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              for (var index = 0; index < searches.length; index++) ...[
                if (index > 0) SizedBox(width: CoreSpacing.sm(context)),
                ActionChip(
                  avatar: Icon(
                    Icons.history,
                    size: CoreContentSizes.orderTypeIcon(context),
                    color: scheme.onSurfaceVariant,
                  ),
                  label: Text(searches[index]),
                  onPressed: () => onSelected(searches[index]),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _ResultsHeader extends StatelessWidget {
  const _ResultsHeader({required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;

    return Row(
      children: [
        Expanded(
          child: Text(
            l10n.searchTopResults,
            style: CoreTypography.titleMedium(
              context,
              scheme.onSurface,
            ).copyWith(fontWeight: FontWeight.w900),
          ),
        ),
        Text(
          l10n.searchItemsFound(count),
          style: CoreTypography.caption(context, scheme.onSurfaceVariant),
        ),
      ],
    );
  }
}

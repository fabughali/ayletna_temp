import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/providers/admin_catalog_providers.dart';
import 'package:ayletna_restaurant_app/providers/menu_providers.dart';
import 'package:ayletna_restaurant_app/data/models/model_menu_category.dart';
import 'package:ayletna_restaurant_app/data/models/model_menu_item.dart';
import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:ayletna_restaurant_app/navigation/app_route_paths.dart';
import 'package:ayletna_restaurant_app/utilities/utility_format_jod.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_cart_customization_sheet.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_text_field.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_food_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_mock_food_image.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_scaffold_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Customer menu search screen for mockup-only catalog discovery.
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

  @override
  void initState() {
    super.initState();
    _query = widget.initialQuery.trim();
    _controller = TextEditingController(text: _query);
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
    final results = menuAsync.maybeWhen(
      data: (items) => _resultsFor(_query, items, categories),
      orElse: () => const <ModelMenuItem>[],
    );

    return WidgetsScaffoldPage(
      title: l10n.screenSearch,
      child: ListView(
        children: [
          SizedBox(height: CoreSpacing.md(context)),
          _SearchHero(
            controller: _controller,
            onSubmitted: _submit,
            onChanged: (value) => setState(() => _query = value.trim()),
          ),
          SizedBox(height: CoreSpacing.lg(context)),
          _SuggestionChips(onSelected: _useSuggestion),
          SizedBox(height: CoreSpacing.xl(context)),
          if (_query.isEmpty)
            _SearchStateCard(
              icon: Icons.search_outlined,
              title: l10n.searchStartTitle,
              body: l10n.searchStartBody,
              actionLabel: l10n.searchBrowseMenu,
              onAction: () => context.push(AppRoutePaths.category),
            )
          else if (results.isEmpty)
            _SearchStateCard(
              icon: Icons.no_meals_outlined,
              title: l10n.searchEmptyTitle,
              body: l10n.searchEmptyBody,
              actionLabel: l10n.searchBrowseMenu,
              onAction: () => context.push(AppRoutePaths.category),
            )
          else ...[
            _ResultsHeader(count: results.length),
            SizedBox(height: CoreSpacing.md(context)),
            for (var index = 0; index < results.length; index++) ...[
              _SearchResultCard(
                item: results[index],
                isAr: isAr,
                index: index,
                onOpen: () => _openItem(results[index]),
                onAdd: () => _addItem(results[index]),
              ),
              if (index != results.length - 1)
                SizedBox(height: CoreSpacing.md(context)),
            ],
          ],
          SizedBox(height: CoreSpacing.xxl(context)),
        ],
      ),
    );
  }

  void _submit(String value) {
    final normalized = value.trim();
    if (normalized.isEmpty) {
      return;
    }
    setState(() => _query = normalized);
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
      return const [];
    }

    return items.where((item) {
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

class _SearchHero extends StatelessWidget {
  const _SearchHero({
    required this.controller,
    required this.onSubmitted,
    required this.onChanged,
  });

  final TextEditingController controller;
  final ValueChanged<String> onSubmitted;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;

    return WidgetsAppCard(
      variant: WidgetsAppCardVariant.food,
      padding: EdgeInsets.all(CoreSpacing.lg(context)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            l10n.searchTitle,
            style: CoreTypography.headlineSmall(
              context,
              scheme.onSurface,
            ).copyWith(fontWeight: FontWeight.w900),
          ),
          SizedBox(height: CoreSpacing.sm(context)),
          Text(
            l10n.searchSubtitle,
            style: CoreTypography.bodyMedium(context, scheme.onSurfaceVariant),
          ),
          SizedBox(height: CoreSpacing.lg(context)),
          WidgetsAppTextField(
            controller: controller,
            label: l10n.screenSearch,
            hintText: l10n.homeSearchHint,
            prefixIcon: Icons.search,
            textInputAction: TextInputAction.search,
            onChanged: onChanged,
            onSubmitted: onSubmitted,
            suffixIcon: IconButton(
              onPressed: () => onSubmitted(controller.text),
              icon: const Icon(Icons.search),
              tooltip: l10n.screenSearch,
            ),
          ),
        ],
      ),
    );
  }
}

class _SuggestionChips extends ConsumerWidget {
  const _SuggestionChips({required this.onSelected});

  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final isAr = Localizations.localeOf(context).languageCode == 'ar';
    final suggestions =
        ref.watch(visibleCategoriesProvider).take(5).map((category) {
          return isAr ? category.nameAr : category.nameEn;
        }).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.searchPopularSuggestions,
          style: CoreTypography.titleMedium(
            context,
            Theme.of(context).colorScheme.onSurface,
          ).copyWith(fontWeight: FontWeight.w900),
        ),
        SizedBox(height: CoreSpacing.sm(context)),
        Wrap(
          spacing: CoreSpacing.sm(context),
          runSpacing: CoreSpacing.sm(context),
          children: [
            for (final suggestion in suggestions)
              ActionChip(
                label: Text(suggestion),
                avatar: const Icon(Icons.restaurant_menu_outlined),
                onPressed: () => onSelected(suggestion),
              ),
          ],
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
            l10n.searchResultsCount(count),
            style: CoreTypography.titleMedium(
              context,
              scheme.onSurface,
            ).copyWith(fontWeight: FontWeight.w900),
          ),
        ),
        Icon(Icons.restaurant_menu_outlined, color: scheme.primary),
      ],
    );
  }
}

class _SearchResultCard extends StatelessWidget {
  const _SearchResultCard({
    required this.item,
    required this.isAr,
    required this.index,
    required this.onOpen,
    required this.onAdd,
  });

  final ModelMenuItem item;
  final bool isAr;
  final int index;
  final VoidCallback onOpen;
  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final name = isAr ? item.nameAr : item.nameEn;
    final description = isAr ? item.descriptionAr : item.descriptionEn;

    return WidgetsFoodCard(
      title: name,
      description: description,
      priceLabel: UtilityFormatJod.format(
        item.priceJod,
        suffix: l10n.currencyJod,
      ),
      media: WidgetsMockFoodImage(
        imageUrl: item.imageUrl,
        fallback: _DishFallback(index: index),
      ),
      actionLabel: l10n.actionAddToCart,
      onAction: onAdd,
      onTap: onOpen,
      loyaltyLabel: l10n.loyaltyPointsShort(item.rewardPoints.toString()),
    );
  }
}

class _SearchStateCard extends StatelessWidget {
  const _SearchStateCard({
    required this.icon,
    required this.title,
    required this.body,
    required this.actionLabel,
    required this.onAction,
  });

  final IconData icon;
  final String title;
  final String body;
  final String actionLabel;
  final VoidCallback onAction;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return WidgetsAppCard(
      variant: WidgetsAppCardVariant.food,
      padding: EdgeInsets.all(CoreSpacing.xl(context)),
      child: Column(
        children: [
          Icon(
            icon,
            color: scheme.primary,
            size: CoreContentSizes.productHeroIcon(context) * 0.42,
          ),
          SizedBox(height: CoreSpacing.md(context)),
          Text(
            title,
            textAlign: TextAlign.center,
            style: CoreTypography.headlineSmall(
              context,
              scheme.onSurface,
            ).copyWith(fontWeight: FontWeight.w900),
          ),
          SizedBox(height: CoreSpacing.sm(context)),
          Text(
            body,
            textAlign: TextAlign.center,
            style: CoreTypography.bodyMedium(context, scheme.onSurfaceVariant),
          ),
          SizedBox(height: CoreSpacing.lg(context)),
          WidgetsAppButton(
            label: actionLabel,
            onPressed: onAction,
            icon: Icons.restaurant_menu_outlined,
            variant: WidgetsAppButtonVariant.secondary,
          ),
        ],
      ),
    );
  }
}

class _DishFallback extends StatelessWidget {
  const _DishFallback({required this.index});

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

    return DecoratedBox(
      decoration: BoxDecoration(color: color.withValues(alpha: 0.10)),
      child: Center(
        child: Icon(
          Icons.restaurant_outlined,
          color: color,
          size: CoreContentSizes.categoryMenuImageIcon(context),
        ),
      ),
    );
  }
}

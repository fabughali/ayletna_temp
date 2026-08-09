import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/data/mockup/mockup_catalog.dart';
import 'package:ayletna_restaurant_app/data/models/model_admin_catalog.dart';
import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:ayletna_restaurant_app/navigation/app_route_paths.dart';
import 'package:ayletna_restaurant_app/providers/admin_catalog_providers.dart';
import 'package:ayletna_restaurant_app/providers/marketing_campaign_providers.dart';
import 'package:ayletna_restaurant_app/providers/menu_providers.dart';
import 'package:ayletna_restaurant_app/utilities/utility_confirm_dialog.dart';
import 'package:ayletna_restaurant_app/utilities/utility_mock_feedback.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_text_field.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_campaign_create_fields.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_campaign_schedule_sheet.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_icon_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_info_banner.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_catalog_product_cards.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_scaffold_page.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_subscription_day_map.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

/// Marketing subscriptions — day meal plans, savings, campaign visibility.
class AdminSubscriptionsManagementScreen extends ConsumerWidget {
  const AdminSubscriptionsManagementScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final isAr = Localizations.localeOf(context).languageCode == 'ar';

    return WidgetsScaffoldPage(
      title: l10n.marketingTabSubscriptions,
      actions: [
        WidgetsIconButton(
          onPressed: () => context.push(AppRoutePaths.subscriptions),
          icon: Icons.calendar_month_outlined,
          tooltip: l10n.homeSubscriptions,
        ),
      ],
      child: ListView(
        padding: EdgeInsets.all(CoreSpacing.md(context)),
        children: [
          WidgetsInfoBanner(
            message: l10n.marketingSubscriptionContentOnly,
            icon: Icons.info_outline,
          ),
          SizedBox(height: CoreSpacing.md(context)),
          _AddSubscriptionSection(isAr: isAr),
          SizedBox(height: CoreSpacing.lg(context)),
          _SubscriptionsListSection(isAr: isAr),
        ],
      ),
    );
  }
}

class _AddSubscriptionSection extends ConsumerStatefulWidget {
  const _AddSubscriptionSection({required this.isAr});
  final bool isAr;

  @override
  ConsumerState<_AddSubscriptionSection> createState() =>
      _AddSubscriptionSectionState();
}

class _AddSubscriptionSectionState
    extends ConsumerState<_AddSubscriptionSection> {
  bool _expanded = false;
  final _titleEn = TextEditingController();
  final _titleAr = TextEditingController();
  final _price = TextEditingController(text: '45');
  var _period = 'monthly';
  var _freeDelivery = false;
  String? _campaignId;
  late Map<int, List<String>> _dayMeals;

  @override
  void initState() {
    super.initState();
    _dayMeals = _emptyDays(30);
  }

  Map<int, List<String>> _emptyDays(int count) => {
        for (var d = 1; d <= count; d++) d: <String>[],
      };

  @override
  void dispose() {
    _titleEn.dispose();
    _titleAr.dispose();
    _price.dispose();
    super.dispose();
  }

  void _setPeriod(String period) {
    final days = period == 'weekly' ? 7 : 30;
    setState(() {
      _period = period;
      final next = _emptyDays(days);
      for (final e in _dayMeals.entries) {
        if (e.key <= days) next[e.key] = List<String>.from(e.value);
      }
      _dayMeals = next;
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    final menuAsync = ref.watch(menuAllItemsProvider);
    final menuItems = menuAsync.valueOrNull ?? const [];

    return WidgetsAppCard(
      variant: WidgetsAppCardVariant.food,
      padding: EdgeInsets.all(CoreSpacing.lg(context)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InkWell(
            onTap: () => setState(() => _expanded = !_expanded),
            borderRadius: BorderRadius.circular(CoreSpacing.radiusButtonOf(context)),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    l10n.promoMgmtSubscriptionMeal,
                    style: CoreTypography.titleMedium(
                      context,
                      scheme.onSurface,
                    ).copyWith(fontWeight: FontWeight.w900),
                  ),
                ),
                Icon(
                  _expanded
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  color: scheme.onSurfaceVariant,
                ),
              ],
            ),
          ),
          if (_expanded) ...[
            SizedBox(height: CoreSpacing.md(context)),
            WidgetsAppTextField(
              controller: _titleEn,
              label: l10n.catalogCrudNameEn,
            ),
            SizedBox(height: CoreSpacing.sm(context)),
            WidgetsAppTextField(
              controller: _titleAr,
              label: l10n.catalogCrudNameAr,
            ),
            SizedBox(height: CoreSpacing.sm(context)),
            WidgetsAppTextField(
              controller: _price,
              label: l10n.marketingSubscriptionValue,
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: CoreSpacing.sm(context)),
            DropdownButtonFormField<String>(
              initialValue: _period,
              decoration: InputDecoration(
                labelText: l10n.billingPeriodMonthly,
              ),
              items: [
                DropdownMenuItem(
                  value: 'weekly',
                  child: Text(l10n.billingPeriodWeekly),
                ),
                DropdownMenuItem(
                  value: 'monthly',
                  child: Text(l10n.billingPeriodMonthly),
                ),
              ],
              onChanged: (v) {
                if (v != null) _setPeriod(v);
              },
            ),
            SizedBox(height: CoreSpacing.sm(context)),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(l10n.marketingSubscriptionFreeDelivery),
              value: _freeDelivery,
              onChanged: (v) => setState(() => _freeDelivery = v),
            ),
            SizedBox(height: CoreSpacing.sm(context)),
            Text(
              l10n.marketingSubscriptionCoverage,
              style: CoreTypography.titleMedium(
                context,
                scheme.onSurface,
              ).copyWith(fontWeight: FontWeight.w800),
            ),
            SizedBox(height: CoreSpacing.xs(context)),
            for (final day in _dayMeals.keys.toList()..sort())
              ExpansionTile(
                tilePadding: EdgeInsets.zero,
                title: Text(
                  l10n.marketingSubscriptionEditDay(day),
                  style: CoreTypography.bodyMedium(context, scheme.onSurface)
                      .copyWith(fontWeight: FontWeight.w700),
                ),
                subtitle: Text(
                  l10n.marketingSubscriptionDayMeals(
                    day,
                    _dayMeals[day]?.length ?? 0,
                  ),
                ),
                children: [
                  Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: Text(
                      l10n.marketingSubscriptionPickMeals,
                      style: CoreTypography.caption(
                        context,
                        scheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                  Wrap(
                    spacing: CoreSpacing.xs(context),
                    runSpacing: CoreSpacing.xs(context),
                    children: [
                      for (final item in menuItems)
                        FilterChip(
                          label: Text(
                            widget.isAr ? item.nameAr : item.nameEn,
                            overflow: TextOverflow.ellipsis,
                          ),
                          selected:
                              _dayMeals[day]?.contains(item.id) ?? false,
                          onSelected: (selected) {
                            setState(() {
                              final list = List<String>.from(
                                _dayMeals[day] ?? const [],
                              );
                              if (selected) {
                                if (!list.contains(item.id)) list.add(item.id);
                              } else {
                                list.remove(item.id);
                              }
                              _dayMeals[day] = list;
                            });
                          },
                        ),
                    ],
                  ),
                  SizedBox(height: CoreSpacing.sm(context)),
                ],
              ),
            SizedBox(height: CoreSpacing.md(context)),
            WidgetsCampaignCreateFields(
              kind: CampaignEntityKind.subscription,
              campaignId: _campaignId,
              onCampaignIdChanged: (id) => setState(() => _campaignId = id),
            ),
            SizedBox(height: CoreSpacing.md(context)),
            WidgetsAppButton(
              label: l10n.actionAdd,
              icon: Icons.add_outlined,
              onPressed: _submit,
            ),
          ],
        ],
      ),
    );
  }

  void _submit() {
    final l10n = AppLocalizations.of(context)!;
    final dayPlans = [
      for (final e in _dayMeals.entries)
        ModelSubscriptionDayPlan(dayIndex: e.key, menuItemIds: e.value),
    ];
    final allIds = dayPlans.expand((d) => d.menuItemIds).toList();
    final firstItem = allIds.isEmpty ? null : allIds.first;
    final subId = nextCatalogId('sub');
    final campaignId = _campaignId;
    final ok = ref.read(adminCatalogProvider.notifier).addSubscription(
          ModelSubscriptionMeal(
            id: subId,
            titleEn: _titleEn.text,
            titleAr: _titleAr.text,
            priceJod: double.tryParse(_price.text) ?? 0,
            billingPeriod: _period,
            menuItemId: firstItem ?? '',
            dayPlans: dayPlans,
            freeDelivery: _freeDelivery,
            isAvailable: false,
            campaignId: campaignId,
            imageUrls: firstItem == null
                ? const []
                : [MockupCatalog.promoImageUrlFor(firstItem)],
          ),
        );
    if (!mounted) return;
    if (ok) {
      if (campaignId != null && campaignId.isNotEmpty) {
        attachEntityToCampaign(
          ref: ref,
          campaignId: campaignId,
          kind: CampaignEntityKind.subscription,
          entityId: subId,
        );
      }
      _titleEn.clear();
      _titleAr.clear();
      _price.text = '45';
      setState(() {
        _freeDelivery = false;
        _campaignId = null;
        _period = 'monthly';
        _dayMeals = _emptyDays(30);
        _expanded = false;
      });
      UtilityMockFeedback.showSuccess(context, l10n.catalogCrudAdded);
    } else {
      UtilityMockFeedback.showWarning(context, l10n.catalogCrudCheckFields);
    }
  }
}

class _SubscriptionsListSection extends ConsumerWidget {
  const _SubscriptionsListSection({required this.isAr});
  final bool isAr;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final meals = ref.watch(adminCatalogProvider).resolvedSubscriptions;

    if (meals.isEmpty) {
      return WidgetsAppCard(
        variant: WidgetsAppCardVariant.food,
        padding: EdgeInsets.all(CoreSpacing.lg(context)),
        child: Text(
          l10n.catalogBrowseEmpty,
          textAlign: TextAlign.center,
          style: CoreTypography.bodyMedium(
            context,
            Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
      );
    }

    return Column(
      children: [
        for (var i = 0; i < meals.length; i++) ...[
          _SubscriptionCard(meal: meals[i], isAr: isAr, index: i),
          if (i < meals.length - 1)
            SizedBox(height: CoreSpacing.md(context)),
        ],
      ],
    );
  }
}

class _SubscriptionCard extends ConsumerWidget {
  const _SubscriptionCard({
    required this.meal,
    required this.isAr,
    required this.index,
  });

  final ModelSubscriptionMeal meal;
  final bool isAr;
  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    final linked = ref.watch(menuItemByIdProvider(meal.menuItemId));
    final campaignLabel = _campaignLabel(ref, meal, isAr, l10n);

    return WidgetsAppCard(
      variant: WidgetsAppCardVariant.food,
      padding: EdgeInsets.all(CoreSpacing.md(context)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: CoreContentSizes.productDetailHeroHeight(context),
            child: Stack(
              fit: StackFit.expand,
              children: [
                WidgetsSubscriptionCard(
                  meal: meal,
                  isAr: isAr,
                  l10n: l10n,
                  index: index,
                  imageUrl: meal.primaryImageUrl ?? linked?.primaryImageUrl,
                  actionLabel: l10n.actionEdit,
                  onAction: () {},
                  onTap: () {},
                ),
                Positioned(
                  top: CoreSpacing.sm(context),
                  right: CoreSpacing.sm(context),
                  child: Material(
                    color: Colors.black45,
                    shape: const CircleBorder(),
                    child: PopupMenuButton<String>(
                      icon: const Icon(Icons.more_vert, color: Colors.white),
                      onSelected: (value) async {
                        if (value == 'campaign') {
                          await _scheduleCampaign(context, ref, meal);
                        } else if (value == 'delete') {
                          confirmAdminDelete(
                            context,
                            isAr: isAr,
                            onConfirmed:
                                () => ref
                                    .read(adminCatalogProvider.notifier)
                                    .deleteSubscription(meal.id),
                          );
                        }
                      },
                      itemBuilder:
                          (_) => [
                            PopupMenuItem(
                              value: 'campaign',
                              child: Text(l10n.marketingCampaignAdjust),
                            ),
                            PopupMenuItem(
                              value: 'delete',
                              child: Text(l10n.addressesDelete),
                            ),
                          ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: CoreSpacing.sm(context)),
          WidgetsSubscriptionDayMap(meal: meal, compact: true),
          SizedBox(height: CoreSpacing.xs(context)),
          Text(
            campaignLabel,
            style: CoreTypography.caption(context, scheme.onSurfaceVariant),
          ),
          Row(
            children: [
              Text(
                meal.isAvailable
                    ? l10n.marketingOfferActiveOn
                    : l10n.marketingOfferActiveOff,
                style: CoreTypography.caption(
                  context,
                  meal.isAvailable
                      ? CoreColors.semanticSuccess
                      : scheme.onSurfaceVariant,
                ).copyWith(fontWeight: FontWeight.w700),
              ),
              const Spacer(),
              Switch.adaptive(
                value: meal.isAvailable,
                onChanged:
                    (value) => _onVisibilityChanged(context, ref, meal, value),
              ),
            ],
          ),
        ],
      ),
    );
  }

    String _campaignLabel(
    WidgetRef ref,
    ModelSubscriptionMeal meal,
    bool isAr,
    AppLocalizations l10n,
  ) {
    final events = ref.watch(marketingCampaignEventsProvider);
    final fmt = DateFormat.MMMd(l10n.localeName).add_jm();
    if (meal.campaignId != null) {
      for (final e in events) {
        if (e.id == meal.campaignId) {
          return '${e.title(isAr)} · ${fmt.format(e.startAt)} → ${fmt.format(e.endAt)}';
        }
      }
    }
    for (final e in events) {
      if (e.subscriptionIds.contains(meal.id)) {
        return '${e.title(isAr)} · ${fmt.format(e.startAt)} → ${fmt.format(e.endAt)}';
      }
    }
    return l10n.marketingVisibilityNeedsSchedule;
  }

  Future<void> _onVisibilityChanged(
    BuildContext context,
    WidgetRef ref,
    ModelSubscriptionMeal meal,
    bool show,
  ) async {
    final l10n = AppLocalizations.of(context)!;
    if (!show) {
      ref.read(adminCatalogProvider.notifier).updateSubscription(
            meal.copyWith(isAvailable: false),
          );
      return;
    }
    final campaignId = await showCampaignScheduleSheet(
      context: context,
      ref: ref,
      kind: CampaignEntityKind.subscription,
      entityId: meal.id,
      currentCampaignId: meal.campaignId,
    );
    if (!context.mounted) return;
    if (campaignId == null) {
      UtilityMockFeedback.showWarning(
        context,
        l10n.marketingVisibilityNeedsSchedule,
      );
      return;
    }
    ref.read(adminCatalogProvider.notifier).updateSubscription(
          meal.copyWith(isAvailable: true, campaignId: campaignId),
        );
    UtilityMockFeedback.showSuccess(context, l10n.catalogCrudUpdated);
  }

  Future<void> _scheduleCampaign(
    BuildContext context,
    WidgetRef ref,
    ModelSubscriptionMeal meal,
  ) async {
    final l10n = AppLocalizations.of(context)!;
    final campaignId = await showCampaignScheduleSheet(
      context: context,
      ref: ref,
      kind: CampaignEntityKind.subscription,
      entityId: meal.id,
      currentCampaignId: meal.campaignId,
    );
    if (!context.mounted || campaignId == null) return;
    ref.read(adminCatalogProvider.notifier).updateSubscription(
          meal.copyWith(campaignId: campaignId),
        );
    UtilityMockFeedback.showSuccess(context, l10n.catalogCrudUpdated);
  }
}

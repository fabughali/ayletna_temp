import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/data/mockup/mockup_catalog.dart';
import 'package:ayletna_restaurant_app/data/models/model_admin_catalog.dart';
import 'package:ayletna_restaurant_app/data/models/model_menu_item.dart';
import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
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
import 'package:ayletna_restaurant_app/widgets/widgets_mock_food_image.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_points_image_badge.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_catalog_product_cards.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_food_catalog_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_scaffold_page.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_status_pill.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

/// Marketing discounts — campaign-gated visibility, points-only reward value.
class AdminDiscountsManagementScreen extends ConsumerStatefulWidget {
  const AdminDiscountsManagementScreen({super.key});

  @override
  ConsumerState<AdminDiscountsManagementScreen> createState() =>
      _AdminDiscountsManagementScreenState();
}

class _AdminDiscountsManagementScreenState
    extends ConsumerState<AdminDiscountsManagementScreen> {
  final _percent = TextEditingController(text: '10');
  final _labelAr = TextEditingController();
  final _labelEn = TextEditingController();
  final _productSearch = TextEditingController();
  bool _expanded = false;
  String? _campaignId;
  String? _selectedItemId;

  @override
  void dispose() {
    _percent.dispose();
    _labelAr.dispose();
    _labelEn.dispose();
    _productSearch.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isAr = Localizations.localeOf(context).languageCode == 'ar';
    final discounts = ref.watch(adminCatalogProvider).resolvedDiscounts;

    return WidgetsScaffoldPage(
      title: l10n.screenDiscountsManagement,
      child: ListView(
        padding: EdgeInsets.all(CoreSpacing.md(context)),
        children: [
          WidgetsAppCard(
            variant: WidgetsAppCardVariant.food,
            padding: EdgeInsets.all(CoreSpacing.lg(context)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                InkWell(
                  onTap: () => setState(() => _expanded = !_expanded),
                  borderRadius:
                      BorderRadius.circular(CoreSpacing.radiusButtonOf(context)),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          l10n.promoMgmtDiscountProduct,
                          style: CoreTypography.titleMedium(
                            context,
                            Theme.of(context).colorScheme.onSurface,
                          ).copyWith(fontWeight: FontWeight.w900),
                        ),
                      ),
                      Icon(
                        _expanded
                            ? Icons.keyboard_arrow_up
                            : Icons.keyboard_arrow_down,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ],
                  ),
                ),
                if (_expanded) ...[
                  SizedBox(height: CoreSpacing.md(context)),
                  WidgetsAppTextField(
                    controller: _productSearch,
                    label: l10n.marketingProductSearchHint,
                    onChanged: (_) => setState(() {}),
                  ),
                  SizedBox(height: CoreSpacing.sm(context)),
                  ..._productChoices(isAr).map(
                    (item) => RadioListTile<String>(
                      dense: true,
                      value: item.id,
                      groupValue: _selectedItemId,
                      title: Text(isAr ? item.nameAr : item.nameEn),
                      subtitle: Text(
                        l10n.marketingDiscountProductPoints +
                            ': ${item.rewardPoints}',
                      ),
                      onChanged: (v) => setState(() => _selectedItemId = v),
                    ),
                  ),
                  SizedBox(height: CoreSpacing.sm(context)),
                  WidgetsAppTextField(
                    controller: _percent,
                    label: l10n.promoMgmtDiscountPercent,
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: CoreSpacing.sm(context)),
                  WidgetsAppTextField(
                    controller: _labelEn,
                    label: l10n.marketingDiscountLabelEn,
                  ),
                  SizedBox(height: CoreSpacing.sm(context)),
                  WidgetsAppTextField(
                    controller: _labelAr,
                    label: l10n.marketingDiscountLabelAr,
                  ),
                  SizedBox(height: CoreSpacing.md(context)),
                  WidgetsCampaignCreateFields(
                    kind: CampaignEntityKind.discount,
                    campaignId: _campaignId,
                    onCampaignIdChanged:
                        (id) => setState(() => _campaignId = id),
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
          ),
          SizedBox(height: CoreSpacing.lg(context)),
          if (discounts.isEmpty)
            WidgetsAppCard(
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
            )
          else
            WidgetsFoodCatalogGrid(
              children: [
                for (var i = 0; i < discounts.length; i++)
                  _DiscountCard(
                    discount: discounts[i],
                    isAr: isAr,
                    index: i,
                    itemTitle: _itemTitle(discounts[i].menuItemId, isAr),
                    onEdit: () => _editDiscount(discounts[i]),
                  ),
              ],
            ),
        ],
      ),
    );
  }

  String _itemTitle(String menuItemId, bool isAr) {
    final item = ref.read(menuItemByIdProvider(menuItemId));
    if (item == null) return menuItemId;
    return isAr ? item.nameAr : item.nameEn;
  }

  List<ModelMenuItem> _productChoices(bool isAr) {
    final q = _productSearch.text.trim().toLowerCase();
    final items =
        ref.watch(menuAllItemsProvider).maybeWhen(
          data: (list) => list,
          orElse: () => MockupCatalog.items,
        );
    if (q.isEmpty) return items.take(8).toList();
    return items
        .where((item) {
          final name = (isAr ? item.nameAr : item.nameEn).toLowerCase();
          return name.contains(q) || item.id.toLowerCase().contains(q);
        })
        .take(12)
        .toList();
  }

  void _submit() {
    final l10n = AppLocalizations.of(context)!;
    final selectedId = _selectedItemId;
    if (selectedId == null || selectedId.isEmpty) {
      UtilityMockFeedback.showWarning(context, l10n.catalogCrudCheckFields);
      return;
    }
    final product = ref.read(menuItemByIdProvider(selectedId));
    final discountId = nextCatalogId('disc');
    final campaignId = _campaignId;
    final ok = ref.read(adminCatalogProvider.notifier).addDiscount(
          ModelCatalogDiscount(
            id: discountId,
            menuItemId: selectedId,
            percentOff: double.tryParse(_percent.text) ?? 10,
            labelAr: _labelAr.text.isNotEmpty ? _labelAr.text : null,
            labelEn: _labelEn.text.isNotEmpty ? _labelEn.text : null,
            rewardPoints: product?.rewardPoints ?? 0,
            active: false,
            campaignId: campaignId,
          ),
        );
    if (!mounted) return;
    if (ok) {
      if (campaignId != null && campaignId.isNotEmpty) {
        attachEntityToCampaign(
          ref: ref,
          campaignId: campaignId,
          kind: CampaignEntityKind.discount,
          entityId: discountId,
        );
      }
      _labelAr.clear();
      _labelEn.clear();
      _productSearch.clear();
      setState(() {
        _campaignId = null;
        _selectedItemId = null;
        _expanded = false;
      });
      UtilityMockFeedback.showSuccess(context, l10n.catalogCrudAdded);
    } else {
      UtilityMockFeedback.showWarning(context, l10n.catalogCrudCheckFields);
    }
  }

  void _editDiscount(ModelCatalogDiscount discount) {
    final l10n = AppLocalizations.of(context)!;
    final itemId = TextEditingController(text: discount.menuItemId);
    final percent = TextEditingController(text: discount.percentOff.toString());
    final labelAr = TextEditingController(text: discount.labelAr ?? '');
    final labelEn = TextEditingController(text: discount.labelEn ?? '');
    final rewardPoints = TextEditingController(
      text: '${discount.rewardPoints}',
    );

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder:
          (ctx) => Padding(
            padding: EdgeInsets.only(
              left: CoreSpacing.lg(ctx),
              right: CoreSpacing.lg(ctx),
              top: CoreSpacing.lg(ctx),
              bottom: MediaQuery.viewInsetsOf(ctx).bottom + CoreSpacing.lg(ctx),
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  WidgetsAppTextField(
                    controller: itemId,
                    label: l10n.promoMgmtMenuItemId,
                  ),
                  SizedBox(height: CoreSpacing.sm(ctx)),
                  WidgetsAppTextField(
                    controller: percent,
                    label: l10n.promoMgmtDiscountPercent,
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: CoreSpacing.sm(ctx)),
                  WidgetsAppTextField(
                    controller: labelAr,
                    label: l10n.marketingDiscountLabelAr,
                  ),
                  SizedBox(height: CoreSpacing.sm(ctx)),
                  WidgetsAppTextField(
                    controller: labelEn,
                    label: l10n.marketingDiscountLabelEn,
                  ),
                  SizedBox(height: CoreSpacing.sm(ctx)),
                  WidgetsAppTextField(
                    controller: rewardPoints,
                    label: l10n.marketingRewardPointsLabel,
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: CoreSpacing.md(ctx)),
                  WidgetsAppButton(
                    label: l10n.marketingCampaignAdjust,
                    variant: WidgetsAppButtonVariant.outline,
                    onPressed: () async {
                      Navigator.pop(ctx);
                      await _scheduleCampaign(discount);
                    },
                  ),
                  SizedBox(height: CoreSpacing.sm(ctx)),
                  WidgetsAppButton(
                    label: l10n.actionSave,
                    onPressed: () {
                      final ok = ref
                          .read(adminCatalogProvider.notifier)
                          .updateDiscount(
                            discount.copyWith(
                              menuItemId: itemId.text.trim(),
                              percentOff:
                                  double.tryParse(percent.text) ??
                                  discount.percentOff,
                              labelAr:
                                  labelAr.text.isNotEmpty ? labelAr.text : null,
                              labelEn:
                                  labelEn.text.isNotEmpty ? labelEn.text : null,
                              rewardPoints:
                                  int.tryParse(rewardPoints.text) ??
                                  discount.rewardPoints,
                            ),
                          );
                      if (ok) {
                        Navigator.pop(ctx);
                        UtilityMockFeedback.showSuccess(
                          context,
                          l10n.catalogCrudUpdated,
                        );
                      } else {
                        UtilityMockFeedback.showWarning(
                          ctx,
                          l10n.catalogCrudUpdateFailed,
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
    );
  }

  Future<void> _scheduleCampaign(ModelCatalogDiscount discount) async {
    final l10n = AppLocalizations.of(context)!;
    final campaignId = await showCampaignScheduleSheet(
      context: context,
      ref: ref,
      kind: CampaignEntityKind.discount,
      entityId: discount.id,
      currentCampaignId: discount.campaignId,
    );
    if (!mounted || campaignId == null) return;
    ref.read(adminCatalogProvider.notifier).updateDiscount(
          discount.copyWith(campaignId: campaignId),
        );
    UtilityMockFeedback.showSuccess(context, l10n.catalogCrudUpdated);
  }
}

class _DiscountCard extends ConsumerWidget {
  const _DiscountCard({
    required this.discount,
    required this.isAr,
    required this.index,
    required this.itemTitle,
    required this.onEdit,
  });

  final ModelCatalogDiscount discount;
  final bool isAr;
  final int index;
  final String itemTitle;
  final VoidCallback onEdit;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final item = ref.watch(menuItemByIdProvider(discount.menuItemId));
    final badge = l10n.comboDiscountOff(discount.percentOff.toStringAsFixed(0));

    if (item == null) {
      return WidgetsAppCard(
        variant: WidgetsAppCardVariant.food,
        padding: EdgeInsets.all(CoreSpacing.md(context)),
        child: Text(itemTitle),
      );
    }

    return Stack(
      fit: StackFit.expand,
      children: [
        WidgetsDiscountProductCard(
          item: item,
          isAr: isAr,
          l10n: l10n,
          index: index,
          badgeLabel: badge,
          actionLabel: l10n.actionEdit,
          actionIcon: Icons.edit_outlined,
          onAction: onEdit,
          onTap: onEdit,
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
                if (value == 'edit') {
                  onEdit();
                } else if (value == 'campaign') {
                  await _scheduleCampaign(context, ref, discount);
                } else if (value == 'delete') {
                  confirmAdminDelete(
                    context,
                    isAr: isAr,
                    onConfirmed:
                        () => ref
                            .read(adminCatalogProvider.notifier)
                            .deleteDiscount(discount.id),
                  );
                }
              },
              itemBuilder:
                  (_) => [
                    PopupMenuItem(
                      value: 'edit',
                      child: Text(l10n.actionEdit),
                    ),
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
    );
  }

    String _campaignLabel(
    WidgetRef ref,
    String? campaignId,
    bool isAr,
    AppLocalizations l10n,
  ) {
    final events = ref.watch(marketingCampaignEventsProvider);
    final fmt = DateFormat.MMMd(l10n.localeName).add_jm();
    if (campaignId != null) {
      for (final e in events) {
        if (e.id == campaignId) {
          return '${e.title(isAr)} · ${fmt.format(e.startAt)} → ${fmt.format(e.endAt)}';
        }
      }
    }
    for (final e in events) {
      if (e.discountIds.contains(discount.id)) {
        return '${e.title(isAr)} · ${fmt.format(e.startAt)} → ${fmt.format(e.endAt)}';
      }
    }
    return l10n.marketingVisibilityNeedsSchedule;
  }

  Future<void> _onVisibilityChanged(
    BuildContext context,
    WidgetRef ref,
    ModelCatalogDiscount discount,
    bool show,
  ) async {
    final l10n = AppLocalizations.of(context)!;
    if (!show) {
      ref.read(adminCatalogProvider.notifier).updateDiscount(
            discount.copyWith(active: false),
          );
      return;
    }
    final campaignId = await showCampaignScheduleSheet(
      context: context,
      ref: ref,
      kind: CampaignEntityKind.discount,
      entityId: discount.id,
      currentCampaignId: discount.campaignId,
    );
    if (!context.mounted) return;
    if (campaignId == null) {
      UtilityMockFeedback.showWarning(
        context,
        l10n.marketingVisibilityNeedsSchedule,
      );
      return;
    }
    ref.read(adminCatalogProvider.notifier).updateDiscount(
          discount.copyWith(active: true, campaignId: campaignId),
        );
    UtilityMockFeedback.showSuccess(context, l10n.catalogCrudUpdated);
  }

  Future<void> _scheduleCampaign(
    BuildContext context,
    WidgetRef ref,
    ModelCatalogDiscount discount,
  ) async {
    final l10n = AppLocalizations.of(context)!;
    final campaignId = await showCampaignScheduleSheet(
      context: context,
      ref: ref,
      kind: CampaignEntityKind.discount,
      entityId: discount.id,
      currentCampaignId: discount.campaignId,
    );
    if (!context.mounted || campaignId == null) return;
    ref.read(adminCatalogProvider.notifier).updateDiscount(
          discount.copyWith(campaignId: campaignId),
        );
    UtilityMockFeedback.showSuccess(context, l10n.catalogCrudUpdated);
  }
}

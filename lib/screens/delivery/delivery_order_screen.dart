import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/data/mockup/mockup_catalog.dart';
import 'package:ayletna_restaurant_app/data/models/model_delivery_pickup_item.dart';
import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:ayletna_restaurant_app/navigation/app_route_paths.dart';
import 'package:ayletna_restaurant_app/providers/delivery_session_providers.dart';
import 'package:ayletna_restaurant_app/utilities/utility_format_jod.dart';
import 'package:ayletna_restaurant_app/utilities/utility_mock_feedback.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_icon_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_price_badge.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_refresh_list.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_scaffold_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// PRD DeliveryOrderScreen — pickup, package seal, and cash handoff.
class DeliveryOrderScreen extends ConsumerStatefulWidget {
  const DeliveryOrderScreen({super.key});

  @override
  ConsumerState<DeliveryOrderScreen> createState() =>
      _DeliveryOrderScreenState();
}

class _DeliveryOrderScreenState extends ConsumerState<DeliveryOrderScreen> {
  final Set<int> _checkedIndexes = {};

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final items = MockupCatalog.deliveryPickupItems;
    final allChecked = _checkedIndexes.length == items.length;

    return WidgetsScaffoldPage(
      title: l10n.deliveryOrderTitle(MockupCatalog.deliveryPickupOrderId),
      actions: [
        WidgetsIconButton(
          onPressed:
              () => UtilityMockFeedback.showInfo(
                context,
                l10n.screenNotifications,
              ),
          icon: Icons.notifications_outlined,
          tooltip: l10n.screenNotifications,
        ),
      ],
      child: WidgetsRefreshList(
        onRefresh:
            () async => UtilityMockFeedback.showInfo(
              context,
              l10n.deliveryOrderTitle(MockupCatalog.deliveryPickupOrderId),
            ),
        child: ListView(
          children: [
            _PickupHero(checked: _checkedIndexes.length, total: items.length),
            SizedBox(height: CoreSpacing.lg(context)),
            LayoutBuilder(
              builder: (context, constraints) {
                final isWide = constraints.maxWidth >= 940;
                final checklist = _PackageChecklist(
                  items: items,
                  checkedIndexes: _checkedIndexes,
                  onChanged: _toggleItem,
                );
                final side = Column(
                  children: [
                    const _PackageSeparationCard(),
                    SizedBox(height: CoreSpacing.lg(context)),
                    _CashToCollectCard(
                      allChecked: allChecked,
                      onConfirm: _confirmPickup,
                    ),
                    SizedBox(height: CoreSpacing.lg(context)),
                    const _MissingItemCard(),
                  ],
                );

                if (isWide) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(flex: 3, child: checklist),
                      SizedBox(width: CoreSpacing.lg(context)),
                      Expanded(flex: 2, child: side),
                    ],
                  );
                }

                return Column(
                  children: [
                    checklist,
                    SizedBox(height: CoreSpacing.lg(context)),
                    side,
                  ],
                );
              },
            ),
            SizedBox(height: CoreSpacing.xxl(context)),
          ],
        ),
      ),
    );
  }

  void _toggleItem(int index, bool checked) {
    setState(() {
      if (checked) {
        _checkedIndexes.add(index);
      } else {
        _checkedIndexes.remove(index);
      }
    });
  }

  void _confirmPickup() {
    final l10n = AppLocalizations.of(context)!;
    final items = MockupCatalog.deliveryPickupItems;
    if (_checkedIndexes.length != items.length) {
      UtilityMockFeedback.showError(
        context,
        l10n.deliveryVerifyAllItems(items.length),
      );
      return;
    }

    final totalToCollect =
        MockupCatalog.deliveryPickupOrderTotalJod +
        MockupCatalog.deliveryPickupBagDepositJod;
    ref
        .read(deliverySessionRunsProvider.notifier)
        .recordPickup(
          orderId: MockupCatalog.deliveryPickupOrderId,
          totalJod: totalToCollect,
        );
    ref.read(deliveryShiftEarningsProvider.notifier).recordDelivery(totalToCollect);
    ref.read(deliveryOrderNoteProvider.notifier).state = '';

    UtilityMockFeedback.showSuccess(context, l10n.deliveryConfirmPickup);
    context.go(AppRoutePaths.delivery);
  }
}

class _PickupHero extends StatelessWidget {
  const _PickupHero({required this.checked, required this.total});

  final int checked;
  final int total;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    final progress = total == 0 ? 0.0 : checked / total;

    return WidgetsAppCard(
      variant: WidgetsAppCardVariant.dashboard,
      padding: EdgeInsets.all(CoreSpacing.lg(context)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _IconBubble(
                icon: Icons.storefront_outlined,
                color: CoreColors.orderTypeTakeaway,
                large: true,
              ),
              SizedBox(width: CoreSpacing.md(context)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.deliveryKitchenStationB,
                      style: CoreTypography.headlineSmall(
                        context,
                        scheme.onSurface,
                      ).copyWith(fontWeight: FontWeight.w900),
                    ),
                    SizedBox(height: CoreSpacing.xs(context)),
                    Text(
                      '${l10n.deliveryCollectionPoint} • ${l10n.deliveryPickupCustomer('Marcus Thorne')}',
                      style: CoreTypography.bodyMedium(
                        context,
                        scheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              _SoftBadge(
                label: l10n.deliveryReadyForPickup,
                color: CoreColors.semanticSuccess,
                icon: Icons.check_circle_outline,
              ),
            ],
          ),
          SizedBox(height: CoreSpacing.lg(context)),
          Wrap(
            spacing: CoreSpacing.sm(context),
            runSpacing: CoreSpacing.sm(context),
            children: [
              _SoftBadge(
                label: l10n.deliveryBagCount,
                color: CoreColors.orderTypeTakeaway,
                icon: Icons.shopping_bag_outlined,
              ),
              _SoftBadge(
                label: l10n.deliveryReusableBagDeposit,
                color: CoreColors.orderTypePlated,
                icon: Icons.recycling_outlined,
              ),
              _SoftBadge(
                label: '$checked / $total',
                color: scheme.primary,
                icon: Icons.checklist_rtl_outlined,
              ),
            ],
          ),
          SizedBox(height: CoreSpacing.lg(context)),
          ClipRRect(
            borderRadius: BorderRadius.circular(CoreSpacing.radiusChip),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: CoreSpacing.xs(context),
              backgroundColor: scheme.surfaceContainerHighest,
              valueColor: AlwaysStoppedAnimation<Color>(
                CoreColors.orderTypeTakeaway,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PackageChecklist extends StatelessWidget {
  const _PackageChecklist({
    required this.items,
    required this.checkedIndexes,
    required this.onChanged,
  });

  final List<ModelDeliveryPickupItem> items;
  final Set<int> checkedIndexes;
  final void Function(int index, bool checked) onChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;

    return WidgetsAppCard(
      variant: WidgetsAppCardVariant.form,
      padding: EdgeInsets.all(CoreSpacing.lg(context)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              _IconBubble(
                icon: Icons.inventory_2_outlined,
                color: scheme.primary,
              ),
              SizedBox(width: CoreSpacing.sm(context)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.deliveryVerifyAllItems(items.length),
                      style: CoreTypography.titleMedium(
                        context,
                        scheme.onSurface,
                      ).copyWith(fontWeight: FontWeight.w900),
                    ),
                    Text(
                      l10n.deliveryBagCount,
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
          SizedBox(height: CoreSpacing.md(context)),
          for (final entry in items.indexed) ...[
            _PickupTargetCard(
              item: entry.$2,
              checked: checkedIndexes.contains(entry.$1),
              zone:
                  entry.$1 == items.length - 1
                      ? _PackageZone.cold
                      : _PackageZone.hot,
              onTap:
                  () => onChanged(entry.$1, !checkedIndexes.contains(entry.$1)),
            ),
            SizedBox(height: CoreSpacing.sm(context)),
          ],
        ],
      ),
    );
  }
}

enum _PackageZone { hot, cold }

class _PickupTargetCard extends StatelessWidget {
  const _PickupTargetCard({
    required this.item,
    required this.checked,
    required this.zone,
    required this.onTap,
  });

  final ModelDeliveryPickupItem item;
  final bool checked;
  final _PackageZone zone;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isAr = Localizations.localeOf(context).languageCode == 'ar';
    final color =
        checked ? CoreColors.semanticSuccess : _zoneColor(context, zone);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(CoreSpacing.radiusCard),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: color.withValues(alpha: checked ? 0.10 : 0.06),
          borderRadius: BorderRadius.circular(CoreSpacing.radiusCard),
          border: Border.all(
            color: color.withValues(alpha: checked ? 0.28 : 0.18),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(CoreSpacing.md(context)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Checkbox(value: checked, onChanged: (_) => onTap()),
              SizedBox(width: CoreSpacing.sm(context)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            isAr ? item.titleAr : item.titleEn,
                            style: CoreTypography.titleMedium(
                              context,
                              scheme.onSurface,
                            ).copyWith(fontWeight: FontWeight.w900),
                          ),
                        ),
                        _SoftBadge(
                          label: 'x${item.quantity}',
                          color: color,
                          icon: Icons.close,
                        ),
                      ],
                    ),
                    SizedBox(height: CoreSpacing.xs(context)),
                    Text(
                      isAr ? item.subtitleAr : item.subtitleEn,
                      style: CoreTypography.bodyMedium(
                        context,
                        scheme.onSurfaceVariant,
                      ),
                    ),
                    SizedBox(height: CoreSpacing.sm(context)),
                    _SoftBadge(
                      label: zone == _PackageZone.hot ? 'Hot bag' : 'Cold bag',
                      color: _zoneColor(context, zone),
                      icon:
                          zone == _PackageZone.hot
                              ? Icons.local_fire_department_outlined
                              : Icons.ac_unit_outlined,
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

  Color _zoneColor(BuildContext context, _PackageZone zone) {
    return zone == _PackageZone.hot
        ? CoreColors.brandOrange
        : Theme.of(context).colorScheme.secondary;
  }
}

class _PackageSeparationCard extends StatelessWidget {
  const _PackageSeparationCard();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;

    return WidgetsAppCard(
      variant: WidgetsAppCardVariant.food,
      padding: EdgeInsets.all(CoreSpacing.lg(context)),
      accentColor: CoreColors.brandOrange,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _IconBubble(
                icon: Icons.thermostat_outlined,
                color: CoreColors.brandOrange,
              ),
              SizedBox(width: CoreSpacing.sm(context)),
              Expanded(
                child: Text(
                  'Packaging separation',
                  style: CoreTypography.titleMedium(
                    context,
                    scheme.onSurface,
                  ).copyWith(fontWeight: FontWeight.w900),
                ),
              ),
            ],
          ),
          SizedBox(height: CoreSpacing.md(context)),
          _CheckRow(
            label: 'Hot food sealed in insulated bag',
            color: CoreColors.brandOrange,
            icon: Icons.local_fire_department_outlined,
          ),
          _CheckRow(
            label: 'Cold drink kept separate',
            color: scheme.secondary,
            icon: Icons.ac_unit_outlined,
          ),
          _CheckRow(
            label: l10n.deliveryBagCount,
            color: CoreColors.orderTypeTakeaway,
            icon: Icons.qr_code_2_outlined,
          ),
        ],
      ),
    );
  }
}

class _CashToCollectCard extends StatelessWidget {
  const _CashToCollectCard({required this.allChecked, required this.onConfirm});

  final bool allChecked;
  final VoidCallback onConfirm;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    final totalToCollect =
        MockupCatalog.deliveryPickupOrderTotalJod +
        MockupCatalog.deliveryPickupBagDepositJod;

    return WidgetsAppCard(
      variant: WidgetsAppCardVariant.dashboard,
      padding: EdgeInsets.all(CoreSpacing.lg(context)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _IconBubble(
                icon: Icons.payments_outlined,
                color: CoreColors.orderTypeTakeaway,
              ),
              SizedBox(width: CoreSpacing.sm(context)),
              Expanded(
                child: Text(
                  l10n.deliveryCashOnDelivery,
                  style: CoreTypography.titleMedium(
                    context,
                    scheme.onSurface,
                  ).copyWith(fontWeight: FontWeight.w900),
                ),
              ),
            ],
          ),
          SizedBox(height: CoreSpacing.md(context)),
          _AmountLine(
            label: l10n.deliveryOrderTotal,
            value: UtilityFormatJod.format(
              MockupCatalog.deliveryPickupOrderTotalJod,
              suffix: l10n.currencyJod,
            ),
          ),
          _AmountLine(
            label: l10n.deliveryReusableBagDeposit,
            value: UtilityFormatJod.format(
              MockupCatalog.deliveryPickupBagDepositJod,
              suffix: l10n.currencyJod,
            ),
          ),
          Divider(
            height: CoreSpacing.lg(context),
            color: scheme.outlineVariant,
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  l10n.deliveryTotalToCollect,
                  style: CoreTypography.titleMedium(
                    context,
                    scheme.onSurface,
                  ).copyWith(fontWeight: FontWeight.w900),
                ),
              ),
              WidgetsPriceBadge(
                priceLabel: UtilityFormatJod.format(
                  totalToCollect,
                  suffix: l10n.currencyJod,
                ),
              ),
            ],
          ),
          SizedBox(height: CoreSpacing.md(context)),
          WidgetsAppButton(
            label: l10n.deliveryConfirmPickup,
            onPressed: allChecked ? onConfirm : null,
            icon: Icons.verified_user_outlined,
            fullWidth: true,
          ),
        ],
      ),
    );
  }
}

class _MissingItemCard extends ConsumerWidget {
  const _MissingItemCard();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;

    return WidgetsAppCard(
      variant: WidgetsAppCardVariant.plain,
      padding: EdgeInsets.all(CoreSpacing.lg(context)),
      child: WidgetsAppButton(
        label: l10n.deliveryReportMissingItem,
        onPressed: () async {
          final confirmed = await UtilityMockFeedback.confirm(
            context: context,
            title: l10n.deliveryReportMissingItem,
            message: l10n.deliveryVerifyAllItems(
              MockupCatalog.deliveryPickupItems.length,
            ),
            confirmLabel: l10n.deliveryReportMissingItem,
            cancelLabel: MaterialLocalizations.of(context).cancelButtonLabel,
            icon: Icons.help_outline,
          );
          if (confirmed && context.mounted) {
            UtilityMockFeedback.showWarning(
              context,
              l10n.deliveryReportMissingItem,
            );
          }
        },
        icon: Icons.help_outline,
        variant: WidgetsAppButtonVariant.outline,
        fullWidth: true,
      ),
    );
  }
}

class _CheckRow extends StatelessWidget {
  const _CheckRow({
    required this.label,
    required this.color,
    required this.icon,
  });

  final String label;
  final Color color;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: EdgeInsets.only(bottom: CoreSpacing.sm(context)),
      child: Row(
        children: [
          Icon(
            icon,
            color: color,
            size: CoreContentSizes.orderTypeIcon(context),
          ),
          SizedBox(width: CoreSpacing.sm(context)),
          Expanded(
            child: Text(
              label,
              style: CoreTypography.bodyMedium(context, scheme.onSurface),
            ),
          ),
          Icon(
            Icons.check_circle_outline,
            color: CoreColors.semanticSuccess,
            size: CoreContentSizes.buttonIcon(context),
          ),
        ],
      ),
    );
  }
}

class _AmountLine extends StatelessWidget {
  const _AmountLine({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: EdgeInsets.only(bottom: CoreSpacing.sm(context)),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: CoreTypography.bodyMedium(
                context,
                scheme.onSurfaceVariant,
              ),
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
      ),
    );
  }
}

class _SoftBadge extends StatelessWidget {
  const _SoftBadge({
    required this.label,
    required this.color,
    required this.icon,
  });

  final String label;
  final Color color;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
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
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: CoreContentSizes.orderTypeIcon(context),
              color: color,
            ),
            SizedBox(width: CoreSpacing.xs(context)),
            Text(
              label,
              style: CoreTypography.caption(
                context,
                color,
              ).copyWith(fontWeight: FontWeight.w900),
            ),
          ],
        ),
      ),
    );
  }
}

class _IconBubble extends StatelessWidget {
  const _IconBubble({
    required this.icon,
    required this.color,
    this.large = false,
  });

  final IconData icon;
  final Color color;
  final bool large;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(CoreSpacing.radiusButton),
      ),
      child: Padding(
        padding: EdgeInsets.all(CoreSpacing.sm(context)),
        child: Icon(
          icon,
          color: color,
          size:
              large
                  ? CoreContentSizes.logoCard(context) * 0.52
                  : CoreContentSizes.orderTypeIcon(context),
        ),
      ),
    );
  }
}

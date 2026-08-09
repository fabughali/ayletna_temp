import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/utilities/utility_sizer.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_card.dart';
import 'package:flutter/material.dart';

/// Shared kitchen ticket card for order-prep and station boards.
class WidgetsKitchenTicket extends StatelessWidget {
  const WidgetsKitchenTicket({
    required this.orderLabel,
    required this.stationLabel,
    required this.timeLabel,
    required this.items,
    this.note,
    this.accentColor = CoreColors.brandOlive,
    this.onTap,
    super.key,
  });

  final String orderLabel;
  final String stationLabel;
  final String timeLabel;
  final List<String> items;
  final String? note;
  final Color accentColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return WidgetsAppCard(
      onTap: onTap,
      accentColor: accentColor,
      variant: WidgetsAppCardVariant.dashboard,
      padding: EdgeInsets.all(CoreSpacing.md(context)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _OperationsIconBubble(
                icon: Icons.receipt_long_outlined,
                color: accentColor,
              ),
              SizedBox(width: CoreSpacing.sm(context)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      orderLabel,
                      style: CoreTypography.titleMedium(
                        context,
                        Theme.of(context).colorScheme.onSurface,
                      ).copyWith(fontWeight: FontWeight.w900),
                    ),
                    Text(
                      stationLabel,
                      style: CoreTypography.caption(
                        context,
                        Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              _OperationsBadge(label: timeLabel, color: accentColor),
            ],
          ),
          SizedBox(height: CoreSpacing.md(context)),
          ...items.map(
            (item) => Padding(
              padding: EdgeInsets.only(bottom: CoreSpacing.xs(context)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.drag_indicator,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                    size: CoreContentSizes.orderTypeIcon(context),
                  ),
                  SizedBox(width: CoreSpacing.xs(context)),
                  Expanded(
                    child: Text(
                      item,
                      style: CoreTypography.bodyMedium(
                        context,
                        Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (note != null) ...[
            SizedBox(height: CoreSpacing.sm(context)),
            _OperationsNote(label: note!, color: CoreColors.semanticWarning),
          ],
        ],
      ),
    );
  }
}

/// Shared lane card for kitchen, packing, delivery, and inventory stations.
class WidgetsStationLane extends StatelessWidget {
  const WidgetsStationLane({
    required this.title,
    required this.subtitle,
    required this.countLabel,
    required this.children,
    this.icon = Icons.room_service_outlined,
    this.accentColor = CoreColors.brandOlive,
    super.key,
  });

  final String title;
  final String subtitle;
  final String countLabel;
  final List<Widget> children;
  final IconData icon;
  final Color accentColor;

  @override
  Widget build(BuildContext context) {
    return WidgetsAppCard(
      title: title,
      subtitle: subtitle,
      leading: _OperationsIconBubble(icon: icon, color: accentColor),
      trailing: _OperationsBadge(label: countLabel, color: accentColor),
      accentColor: accentColor,
      variant: WidgetsAppCardVariant.dashboard,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (final child in children) ...[
            child,
            SizedBox(height: CoreSpacing.sm(context)),
          ],
        ],
      ),
    );
  }
}

/// Shared packing checklist row for delivery and takeaway handoff.
class WidgetsPackageChecklistRow extends StatelessWidget {
  const WidgetsPackageChecklistRow({
    required this.label,
    required this.checked,
    required this.onChanged,
    this.detail,
    this.icon = Icons.inventory_2_outlined,
    super.key,
  });

  final String label;
  final String? detail;
  final bool checked;
  final ValueChanged<bool> onChanged;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final color =
        checked ? CoreColors.semanticSuccess : CoreColors.semanticWarning;
    return Container(
      padding: EdgeInsets.all(CoreSpacing.md(context)),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(CoreSpacing.radiusCardOf(context)),
        border: Border.all(color: color.withValues(alpha: 0.18)),
      ),
      child: Row(
        children: [
          Checkbox(
            value: checked,
            onChanged: (value) => onChanged(value ?? false),
          ),
          SizedBox(width: CoreSpacing.xs(context)),
          _OperationsIconBubble(icon: icon, color: color, compact: true),
          SizedBox(width: CoreSpacing.sm(context)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: CoreTypography.titleMedium(
                    context,
                    Theme.of(context).colorScheme.onSurface,
                  ).copyWith(fontWeight: FontWeight.w900),
                ),
                if (detail != null)
                  Text(
                    detail!,
                    style: CoreTypography.caption(
                      context,
                      Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Shared ingredient freshness card for inventory and kitchen prep.
class WidgetsIngredientFreshnessCard extends StatelessWidget {
  const WidgetsIngredientFreshnessCard({
    required this.name,
    required this.storageLabel,
    required this.freshnessLabel,
    required this.progress,
    this.warning,
    this.reviewLabel,
    this.onReview,
    super.key,
  });

  final String name;
  final String storageLabel;
  final String freshnessLabel;
  final double progress;
  final String? warning;
  final String? reviewLabel;
  final VoidCallback? onReview;

  @override
  Widget build(BuildContext context) {
    final clamped = progress.clamp(0, 1).toDouble();
    final color =
        clamped >= 0.66
            ? CoreColors.semanticSuccess
            : clamped >= 0.34
            ? CoreColors.semanticWarning
            : CoreColors.semanticError;

    return WidgetsAppCard(
      title: name,
      subtitle: storageLabel,
      leading: _OperationsIconBubble(icon: Icons.spa_outlined, color: color),
      accentColor: color,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  freshnessLabel,
                  style: CoreTypography.titleMedium(
                    context,
                    Theme.of(context).colorScheme.onSurface,
                  ).copyWith(fontWeight: FontWeight.w900),
                ),
              ),
              _OperationsBadge(
                label: '${(clamped * 100).round()}%',
                color: color,
              ),
            ],
          ),
          SizedBox(height: CoreSpacing.sm(context)),
          ClipRRect(
            borderRadius: BorderRadius.circular(CoreSpacing.radiusChipOf(context)),
            child: LinearProgressIndicator(
              minHeight: UtilitySizer.of(context, 8),
              value: clamped,
              color: color,
              backgroundColor: color.withValues(alpha: 0.12),
            ),
          ),
          if (warning != null) ...[
            SizedBox(height: CoreSpacing.sm(context)),
            _OperationsNote(label: warning!, color: CoreColors.semanticWarning),
          ],
          if (onReview != null) ...[
            SizedBox(height: CoreSpacing.md(context)),
            WidgetsAppButton(
              label: reviewLabel ?? 'Review',
              onPressed: onReview,
              icon: Icons.fact_check_outlined,
              variant: WidgetsAppButtonVariant.outline,
              fullWidth: true,
            ),
          ],
        ],
      ),
    );
  }
}

/// Shared physical plate/tray condition card for plated delivery returns.
class WidgetsPlateConditionCard extends StatelessWidget {
  const WidgetsPlateConditionCard({
    required this.assetLabel,
    required this.conditionLabel,
    required this.depositLabel,
    required this.condition,
    this.refundLabel = 'Refund',
    this.chargeLabel = 'Charge',
    this.onRefund,
    this.onCharge,
    super.key,
  });

  final String assetLabel;
  final String conditionLabel;
  final String depositLabel;
  final WidgetsPlateCondition condition;
  final String refundLabel;
  final String chargeLabel;
  final VoidCallback? onRefund;
  final VoidCallback? onCharge;

  @override
  Widget build(BuildContext context) {
    final color = switch (condition) {
      WidgetsPlateCondition.clean => CoreColors.semanticSuccess,
      WidgetsPlateCondition.needsWash => CoreColors.semanticWarning,
      WidgetsPlateCondition.damaged => CoreColors.semanticError,
    };

    return WidgetsAppCard(
      title: assetLabel,
      subtitle: conditionLabel,
      leading: _OperationsIconBubble(
        icon: Icons.room_service_outlined,
        color: color,
      ),
      trailing: _OperationsBadge(label: depositLabel, color: color),
      accentColor: color,
      child: Row(
        children: [
          Expanded(
            child: WidgetsAppButton(
              label: refundLabel,
              onPressed: onRefund,
              icon: Icons.replay_outlined,
              variant: WidgetsAppButtonVariant.outline,
            ),
          ),
          SizedBox(width: CoreSpacing.sm(context)),
          Expanded(
            child: WidgetsAppButton(
              label: chargeLabel,
              onPressed: onCharge,
              icon: Icons.warning_amber_outlined,
              variant:
                  condition == WidgetsPlateCondition.damaged
                      ? WidgetsAppButtonVariant.danger
                      : WidgetsAppButtonVariant.ghost,
            ),
          ),
        ],
      ),
    );
  }
}

enum WidgetsPlateCondition { clean, needsWash, damaged }

class _OperationsIconBubble extends StatelessWidget {
  const _OperationsIconBubble({
    required this.icon,
    required this.color,
    this.compact = false,
  });

  final IconData icon;
  final Color color;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final size = compact ? 34.0 : 42.0;
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(CoreSpacing.radiusCardOf(context)),
      ),
      child: Icon(icon, color: color, size: compact ? 18 : 22),
    );
  }
}

class _OperationsBadge extends StatelessWidget {
  const _OperationsBadge({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: CoreSpacing.sm(context),
        vertical: CoreSpacing.xs(context),
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(CoreSpacing.radiusChipOf(context)),
      ),
      child: Text(
        label,
        style: CoreTypography.caption(
          context,
          color,
        ).copyWith(fontWeight: FontWeight.w900),
      ),
    );
  }
}

class _OperationsNote extends StatelessWidget {
  const _OperationsNote({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(CoreSpacing.sm(context)),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(CoreSpacing.radiusCardOf(context)),
      ),
      child: Text(
        label,
        style: CoreTypography.caption(
          context,
          Theme.of(context).colorScheme.onSurface,
        ).copyWith(fontWeight: FontWeight.w800),
      ),
    );
  }
}

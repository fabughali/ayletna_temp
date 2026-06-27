import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:ayletna_restaurant_app/utilities/utility_mock_feedback.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_filter_chip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:ayletna_restaurant_app/providers/admin_session_providers.dart';

/// Reusable report filter panel for the admin analytics hub and filter route.
class WidgetsReportFilterSheet extends ConsumerStatefulWidget {
  const WidgetsReportFilterSheet({
    this.embedded = false,
    this.dismissOnApply = true,
    super.key,
  });

  final bool embedded;
  final bool dismissOnApply;

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder:
          (_) => ProviderScope(
            child: const SafeArea(
              top: false,
              child: WidgetsReportFilterSheet(),
            ),
          ),
    );
  }

  @override
  ConsumerState<WidgetsReportFilterSheet> createState() =>
      _WidgetsReportFilterSheetState();
}

class _WidgetsReportFilterSheetState
    extends ConsumerState<WidgetsReportFilterSheet> {
  _ReportFilterPeriod _period = _ReportFilterPeriod.today;
  _ReportFilterChannel _channel = _ReportFilterChannel.all;
  final Set<_ReportFilterModule> _modules = {
    _ReportFilterModule.sales,
    _ReportFilterModule.tips,
    _ReportFilterModule.inventory,
  };

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;

    final content = Column(
      mainAxisSize: widget.embedded ? MainAxisSize.max : MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.screenReportFilter,
          style: CoreTypography.headlineSmall(
            context,
            scheme.onSurface,
          ).copyWith(fontWeight: FontWeight.w900),
        ),
        SizedBox(height: CoreSpacing.xs(context)),
        Text(
          l10n.reportFilterIntro,
          style: CoreTypography.bodyMedium(context, scheme.onSurfaceVariant),
        ),
        SizedBox(height: CoreSpacing.lg(context)),
        _SectionTitle(label: l10n.reportFilterPeriod),
        SizedBox(height: CoreSpacing.sm(context)),
        Wrap(
          spacing: CoreSpacing.sm(context),
          runSpacing: CoreSpacing.sm(context),
          children:
              _ReportFilterPeriod.values.map((period) {
                return WidgetsFilterChip(
                  label: _periodLabel(period, l10n),
                  selected: _period == period,
                  onSelected: (_) => setState(() => _period = period),
                );
              }).toList(),
        ),
        SizedBox(height: CoreSpacing.lg(context)),
        _SectionTitle(label: l10n.reportFilterChannel),
        SizedBox(height: CoreSpacing.sm(context)),
        Wrap(
          spacing: CoreSpacing.sm(context),
          runSpacing: CoreSpacing.sm(context),
          children:
              _ReportFilterChannel.values.map((channel) {
                return WidgetsFilterChip(
                  label: _channelLabel(channel, l10n),
                  selected: _channel == channel,
                  onSelected: (_) => setState(() => _channel = channel),
                );
              }).toList(),
        ),
        SizedBox(height: CoreSpacing.lg(context)),
        _SectionTitle(label: l10n.reportFilterModules),
        SizedBox(height: CoreSpacing.sm(context)),
        Wrap(
          spacing: CoreSpacing.sm(context),
          runSpacing: CoreSpacing.sm(context),
          children:
              _ReportFilterModule.values.map((module) {
                final selected = _modules.contains(module);
                return WidgetsFilterChip(
                  label: _moduleLabel(module, l10n),
                  selected: selected,
                  onSelected:
                      (_) => setState(() {
                        if (selected && _modules.length > 1) {
                          _modules.remove(module);
                        } else {
                          _modules.add(module);
                        }
                      }),
                );
              }).toList(),
        ),
        SizedBox(height: CoreSpacing.lg(context)),
        _FilterSummary(
          label: l10n.reportFilterSummary,
          value:
              '${_periodLabel(_period, l10n)} • ${_channelLabel(_channel, l10n)} • ${l10n.reportFilterModuleCount(_modules.length)}',
        ),
        SizedBox(height: CoreSpacing.lg(context)),
        Row(
          children: [
            Expanded(
              child: WidgetsAppButton(
                label: l10n.reportFilterReset,
                onPressed: _reset,
                icon: Icons.restart_alt,
                variant: WidgetsAppButtonVariant.outline,
              ),
            ),
            SizedBox(width: CoreSpacing.sm(context)),
            Expanded(
              child: WidgetsAppButton(
                label: l10n.reportFilterApply,
                onPressed: () => _apply(context),
                icon: Icons.check,
              ),
            ),
          ],
        ),
      ],
    );

    if (widget.embedded) {
      return content;
    }

    return Padding(
      padding: EdgeInsets.fromLTRB(
        CoreSpacing.lg(context),
        0,
        CoreSpacing.lg(context),
        MediaQuery.viewInsetsOf(context).bottom + CoreSpacing.xl(context),
      ),
      child: SingleChildScrollView(child: content),
    );
  }

  void _reset() {
    setState(() {
      _period = _ReportFilterPeriod.today;
      _channel = _ReportFilterChannel.all;
      _modules
        ..clear()
        ..addAll({
          _ReportFilterModule.sales,
          _ReportFilterModule.tips,
          _ReportFilterModule.inventory,
        });
    });
    ref.read(adminReportFilterProvider.notifier).reset();
  }

  void _apply(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    ref.read(adminReportFilterProvider.notifier).apply(
      period: _period.name,
      channel: _channel.name,
      modules: _modules.map((module) => module.name).toSet(),
    );
    UtilityMockFeedback.showSuccess(context, l10n.reportFilterApplied);
    if (widget.dismissOnApply) {
      Navigator.of(context).pop();
    }
  }

  String _periodLabel(_ReportFilterPeriod period, AppLocalizations l10n) {
    return switch (period) {
      _ReportFilterPeriod.today => l10n.reportsDaily,
      _ReportFilterPeriod.week => l10n.reportsWeekly,
      _ReportFilterPeriod.month => l10n.reportsMonthly,
      _ReportFilterPeriod.shift => l10n.reportFilterShift,
    };
  }

  String _channelLabel(_ReportFilterChannel channel, AppLocalizations l10n) {
    return switch (channel) {
      _ReportFilterChannel.all => l10n.reportFilterAllChannels,
      _ReportFilterChannel.dineIn => l10n.reportFilterDineIn,
      _ReportFilterChannel.takeaway => l10n.reportFilterTakeaway,
      _ReportFilterChannel.delivery => l10n.reportFilterDelivery,
      _ReportFilterChannel.plated => l10n.reportFilterPlated,
    };
  }

  String _moduleLabel(_ReportFilterModule module, AppLocalizations l10n) {
    return switch (module) {
      _ReportFilterModule.sales => l10n.reportsSalesRevenue,
      _ReportFilterModule.tips => l10n.reportsStaffTips,
      _ReportFilterModule.inventory => l10n.reportsInventoryWastage,
      _ReportFilterModule.plates => l10n.reportFilterPlatesDeposits,
      _ReportFilterModule.audit => l10n.screenAuditLog,
    };
  }
}

enum _ReportFilterPeriod { today, week, month, shift }

enum _ReportFilterChannel { all, dineIn, takeaway, delivery, plated }

enum _ReportFilterModule { sales, tips, inventory, plates, audit }

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: CoreTypography.titleMedium(
        context,
        Theme.of(context).colorScheme.onSurface,
      ).copyWith(fontWeight: FontWeight.w900),
    );
  }
}

class _FilterSummary extends StatelessWidget {
  const _FilterSummary({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(CoreSpacing.md(context)),
      decoration: BoxDecoration(
        color: CoreColors.brandOlive.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(CoreSpacing.radiusCard),
        border: Border.all(
          color: CoreColors.brandOlive.withValues(alpha: 0.18),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: CoreTypography.caption(
              context,
              Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          SizedBox(height: CoreSpacing.xs(context)),
          Text(
            value,
            style: CoreTypography.titleMedium(
              context,
              Theme.of(context).colorScheme.onSurface,
            ).copyWith(fontWeight: FontWeight.w900),
          ),
        ],
      ),
    );
  }
}

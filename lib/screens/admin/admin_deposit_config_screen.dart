import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:ayletna_restaurant_app/navigation/app_route_paths.dart';
import 'package:ayletna_restaurant_app/providers/admin_session_providers.dart';
import 'package:ayletna_restaurant_app/utilities/utility_format_jod.dart';
import 'package:ayletna_restaurant_app/utilities/utility_mock_feedback.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_text_field.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_icon_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_info_banner.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_list_item.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_refresh_list.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_scaffold_page.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_status_pill.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// PRD [DepositConfigScreen].
class AdminDepositConfigScreen extends ConsumerWidget {
  const AdminDepositConfigScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final config = ref.watch(adminDepositConfigProvider);

    return WidgetsScaffoldPage(
      title: l10n.screenDepositConfig,
      actions: [
        WidgetsIconButton(
          onPressed: () => context.push(AppRoutePaths.profile),
          icon: Icons.person_outline,
          tooltip: l10n.screenProfile,
        ),
      ],
      child: WidgetsRefreshList(
        onRefresh: () async {
          await Future<void>.delayed(const Duration(milliseconds: 300));
        },
        child: ListView(
          children: [
            _Header(l10n: l10n),
            SizedBox(height: CoreSpacing.xl(context)),
            _GlobalDepositCard(
              depositJod: config.globalDepositJod,
              onDepositChanged:
                  (value) =>
                      ref
                          .read(adminDepositConfigProvider.notifier)
                          .setGlobalDepositJod(value),
            ),
            SizedBox(height: CoreSpacing.lg(context)),
            _ReturnWindowCard(
              hours: config.returnWindowHours,
              automatedReminders: config.automatedReminders,
              onHoursChanged:
                  (value) =>
                      ref
                          .read(adminDepositConfigProvider.notifier)
                          .setReturnWindowHours(value),
              onReminderChanged:
                  (value) =>
                      ref
                          .read(adminDepositConfigProvider.notifier)
                          .setAutomatedReminders(value),
            ),
            SizedBox(height: CoreSpacing.xl(context)),
            Row(
              children: [
                Expanded(
                  child: WidgetsAppButton(
                    label: l10n.depositSave,
                    onPressed: () {
                      ref.read(adminDepositConfigProvider.notifier).save();
                      UtilityMockFeedback.showSuccess(context, l10n.depositSave);
                    },
                    icon: Icons.save_outlined,
                  ),
                ),
                SizedBox(width: CoreSpacing.md(context)),
                Expanded(
                  child: WidgetsAppButton(
                    label: l10n.actionCancel,
                    onPressed: () => context.pop(),
                    variant: WidgetsAppButtonVariant.outline,
                  ),
                ),
              ],
            ),
            SizedBox(height: CoreSpacing.xl(context)),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.l10n});

  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return WidgetsAppCard(
      title: l10n.depositTrayConfiguration,
      subtitle: l10n.depositConfigurationSubtitle,
      leading: Icon(Icons.settings_outlined, color: scheme.primary),
      accentColor: CoreColors.semanticDeposit,
      child: Wrap(
        spacing: CoreSpacing.xs(context),
        runSpacing: CoreSpacing.xs(context),
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          WidgetsStatusPill(
            label: l10n.depositBreadcrumbSettings,
            color: scheme.onSurfaceVariant,
            compact: true,
          ),
          Icon(Icons.chevron_right, size: CoreContentSizes.orderTypeIcon(context), color: scheme.onSurfaceVariant),
          WidgetsStatusPill(
            label: l10n.depositBreadcrumbLogistics,
            color: scheme.onSurfaceVariant,
            compact: true,
          ),
          Icon(Icons.chevron_right, size: CoreContentSizes.orderTypeIcon(context), color: scheme.onSurfaceVariant),
          WidgetsStatusPill(
            label: l10n.depositBreadcrumbTrayReturns,
            color: CoreColors.semanticDeposit,
            compact: true,
          ),
        ],
      ),
    );
  }
}

class _GlobalDepositCard extends StatefulWidget {
  const _GlobalDepositCard({
    required this.depositJod,
    required this.onDepositChanged,
  });

  final double depositJod;
  final ValueChanged<double> onDepositChanged;

  @override
  State<_GlobalDepositCard> createState() => _GlobalDepositCardState();
}

class _GlobalDepositCardState extends State<_GlobalDepositCard> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text: widget.depositJod.toStringAsFixed(2),
    );
  }

  @override
  void didUpdateWidget(_GlobalDepositCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.depositJod != widget.depositJod) {
      _controller.text = widget.depositJod.toStringAsFixed(2);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _commitAmount(String raw) {
    final parsed = double.tryParse(raw.replaceAll(',', '').trim());
    if (parsed == null || parsed <= 0) return;
    widget.onDepositChanged(parsed);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return WidgetsAppCard(
      title: l10n.depositGlobalTitle,
      subtitle: l10n.depositGlobalHelp,
      leading: Icon(Icons.payments_outlined, color: CoreColors.semanticDeposit),
      accentColor: CoreColors.semanticDeposit,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          WidgetsAppTextField(
            label: l10n.depositGlobalAmountLabel,
            controller: _controller,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            prefixIcon: Icons.account_balance_wallet_outlined,
            onSubmitted: _commitAmount,
            onChanged: (value) {
              if (value.endsWith('\n')) _commitAmount(value);
            },
            suffixIcon: TextButton(
              onPressed: () => _commitAmount(_controller.text),
              child: Text(l10n.actionApply),
            ),
          ),
          SizedBox(height: CoreSpacing.sm(context)),
          Text(
            UtilityFormatJod.format(
              widget.depositJod,
              suffix: l10n.currencyJod,
            ),
            style: CoreTypography.caption(
              context,
              Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          SizedBox(height: CoreSpacing.lg(context)),
          _WarningBox(message: l10n.depositWarning),
        ],
      ),
    );
  }
}

class _WarningBox extends StatelessWidget {
  const _WarningBox({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return WidgetsInfoBanner(
      message: message,
      icon: Icons.info_outline,
      tone: WidgetsInfoBannerTone.info,
    );
  }
}

class _ReturnWindowCard extends StatelessWidget {
  const _ReturnWindowCard({
    required this.hours,
    required this.automatedReminders,
    required this.onHoursChanged,
    required this.onReminderChanged,
  });

  final double hours;
  final bool automatedReminders;
  final ValueChanged<double> onHoursChanged;
  final ValueChanged<bool> onReminderChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;

    return WidgetsAppCard(
      title: l10n.depositReturnWindow,
      leading: Icon(Icons.schedule_outlined, color: scheme.tertiary),
      accentColor: scheme.tertiary,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          WidgetsListItem(
            title: l10n.depositMaxReturnWindow,
            trailing: WidgetsStatusPill(
              label: l10n.depositHours(hours.round()),
              color: scheme.tertiary,
              compact: true,
            ),
            dense: true,
          ),
          Slider(
            value: hours,
            min: 1,
            max: 168,
            divisions: 167,
            onChanged: onHoursChanged,
          ),
          Row(
            children: [
              Text(
                l10n.depositOneHour,
                style: CoreTypography.caption(context, scheme.onSurfaceVariant),
              ),
              const Spacer(),
              Text(
                l10n.depositSevenDays,
                style: CoreTypography.caption(context, scheme.onSurfaceVariant),
              ),
            ],
          ),
          SizedBox(height: CoreSpacing.xl(context)),
          WidgetsListItem(
            title: l10n.depositAutomatedReminders,
            subtitle: l10n.depositReminderChannel,
            leading: Icon(
              Icons.notifications_active_outlined,
              color: scheme.tertiary,
            ),
            trailing: WidgetsAppSwitch(
              value: automatedReminders,
              onChanged: onReminderChanged,
            ),
          ),
        ],
      ),
    );
  }
}

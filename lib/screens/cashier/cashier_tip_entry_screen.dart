import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/data/mockup/mockup_catalog.dart';
import 'package:ayletna_restaurant_app/data/models/model_list_entry.dart';
import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:ayletna_restaurant_app/providers/cashier_session_providers.dart';
import 'package:ayletna_restaurant_app/utilities/utility_format_jod.dart';
import 'package:ayletna_restaurant_app/utilities/utility_mock_feedback.dart';
import 'package:ayletna_restaurant_app/utilities/utility_responsive_breakpoints.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_avatar.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_icon_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_metric_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_refresh_list.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_scaffold_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// PRD [CashierTipEntryScreen] — manual/cash tips.
class CashierTipEntryScreen extends ConsumerStatefulWidget {
  const CashierTipEntryScreen({super.key});

  @override
  ConsumerState<CashierTipEntryScreen> createState() =>
      _CashierTipEntryScreenState();
}

class _CashierTipEntryScreenState extends ConsumerState<CashierTipEntryScreen> {
  int _amountCents = 0;
  var _sharedPool = true;
  String _selectedStaffId = MockupCatalog.staffOnShift.first.id;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return WidgetsScaffoldPage(
      title: l10n.screenCashierTipEntry,
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
              l10n.screenCashierTipEntry,
            ),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            _ShiftTipsCard(l10n: l10n, totalJod: ref.watch(cashierShiftTipsProvider)),
            SizedBox(height: CoreSpacing.md(context)),
            _AmountDisplay(amount: _amount, l10n: l10n),
            SizedBox(height: CoreSpacing.lg(context)),
            _AssignmentHeader(
              l10n: l10n,
              sharedPool: _sharedPool,
              onChanged: (value) => setState(() => _sharedPool = value),
            ),
            SizedBox(height: CoreSpacing.sm(context)),
            _StaffGrid(
              selectedStaffId: _selectedStaffId,
              onSelected: (id) => setState(() => _selectedStaffId = id),
            ),
            SizedBox(height: CoreSpacing.lg(context)),
            _Keypad(
              onDigit: _appendDigit,
              onClear: () => setState(() => _amountCents = 0),
              onBackspace: () => setState(() => _amountCents ~/= 10),
            ),
            SizedBox(height: CoreSpacing.lg(context)),
            _PresetRow(onAdd: _addPreset),
            SizedBox(height: CoreSpacing.lg(context)),
            WidgetsAppButton(
              label: l10n.cashierLogTipEntry,
              icon: Icons.check_circle_outline,
              fullWidth: true,
              onPressed:
                  _amountCents > 0
                      ? () {
                        ref
                            .read(cashierShiftTipsProvider.notifier)
                            .logTip(_amount);
                        UtilityMockFeedback.showSuccess(
                          context,
                          l10n.cashierLogTipEntry,
                        );
                        setState(() => _amountCents = 0);
                      }
                      : null,
            ),
          ],
        ),
      ),
    );
  }

  double get _amount => _amountCents / 100;

  void _appendDigit(int digit) {
    setState(() => _amountCents = (_amountCents * 10) + digit);
  }

  void _addPreset(int cents) {
    setState(() => _amountCents += cents);
  }
}

class _ShiftTipsCard extends StatelessWidget {
  const _ShiftTipsCard({required this.l10n, required this.totalJod});

  final AppLocalizations l10n;
  final double totalJod;

  @override
  Widget build(BuildContext context) {
    return WidgetsMetricCard(
      label: l10n.cashierCurrentShiftTips,
      value: UtilityFormatJod.format(
        totalJod,
        suffix: l10n.currencyJod,
      ),
      icon: Icons.payments_outlined,
      accentColor: CoreColors.brandBrown,
    );
  }
}

class _AmountDisplay extends StatelessWidget {
  const _AmountDisplay({required this.amount, required this.l10n});

  final double amount;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return WidgetsAppCard(
      accentColor: amount > 0 ? CoreColors.brandBrown : null,
      child: Column(
        children: [
          Text(
            l10n.cashierEnterAmount,
            style: CoreTypography.bodyMedium(context, scheme.onSurface),
          ),
          SizedBox(height: CoreSpacing.sm(context)),
          Text(
            '${l10n.currencyJod} ${amount.toStringAsFixed(2)}',
            style: CoreTypography.headlineLarge(
              context,
              amount > 0 ? CoreColors.brandBrown : scheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

class _AssignmentHeader extends StatelessWidget {
  const _AssignmentHeader({
    required this.l10n,
    required this.sharedPool,
    required this.onChanged,
  });

  final AppLocalizations l10n;
  final bool sharedPool;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            l10n.cashierAssignTipTo,
            style: CoreTypography.headlineSmall(
              context,
              Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ),
        Text(l10n.cashierSharedPool),
        SizedBox(width: CoreSpacing.xs(context)),
        Switch(value: sharedPool, onChanged: onChanged),
      ],
    );
  }
}

class _StaffGrid extends StatelessWidget {
  const _StaffGrid({required this.selectedStaffId, required this.onSelected});

  final String selectedStaffId;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    final staff = MockupCatalog.staffOnShift;
    final band = UtilityResponsiveBreakpoints.contentBandOf(context);
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: staff.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: band == ContentBand.mobile ? 2 : 4,
        crossAxisSpacing: CoreSpacing.sm(context),
        mainAxisSpacing: CoreSpacing.sm(context),
        childAspectRatio: 2.6,
      ),
      itemBuilder: (context, index) {
        final entry = staff[index];
        return _StaffTipCard(
          entry: entry,
          selected: entry.id == selectedStaffId,
          onTap: () => onSelected(entry.id),
        );
      },
    );
  }
}

class _StaffTipCard extends StatelessWidget {
  const _StaffTipCard({
    required this.entry,
    required this.selected,
    required this.onTap,
  });

  final ModelListEntry entry;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isAr = Localizations.localeOf(context).languageCode == 'ar';
    final scheme = Theme.of(context).colorScheme;
    final name = isAr ? entry.titleAr : entry.titleEn;
    final role = isAr ? entry.subtitleAr : entry.subtitleEn;
    return WidgetsAppCard(
      onTap: onTap,
      accentColor: selected ? CoreColors.brandBrown : null,
      variant:
          selected
              ? WidgetsAppCardVariant.filled
              : WidgetsAppCardVariant.outlined,
      padding: EdgeInsets.all(CoreSpacing.sm(context)),
      child: Row(
        children: [
          WidgetsAvatar(
            initials: name.characters.first,
            color: selected ? CoreColors.brandBrown : scheme.primary,
          ),
          SizedBox(width: CoreSpacing.sm(context)),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: CoreTypography.bodyMedium(context, scheme.onSurface),
                ),
                if (role != null)
                  Text(
                    role,
                    style: CoreTypography.caption(
                      context,
                      scheme.onSurfaceVariant,
                    ),
                  ),
              ],
            ),
          ),
          if (selected) Icon(Icons.check_circle, color: CoreColors.brandBrown),
        ],
      ),
    );
  }
}

class _Keypad extends StatelessWidget {
  const _Keypad({
    required this.onDigit,
    required this.onClear,
    required this.onBackspace,
  });

  final ValueChanged<int> onDigit;
  final VoidCallback onClear;
  final VoidCallback onBackspace;

  @override
  Widget build(BuildContext context) {
    final keys = [
      _KeypadKey.digit(1),
      _KeypadKey.digit(2),
      _KeypadKey.digit(3),
      _KeypadKey.digit(4),
      _KeypadKey.digit(5),
      _KeypadKey.digit(6),
      _KeypadKey.digit(7),
      _KeypadKey.digit(8),
      _KeypadKey.digit(9),
      const _KeypadKey.clear(),
      _KeypadKey.digit(0),
      const _KeypadKey.backspace(),
    ];
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: keys.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: CoreSpacing.sm(context),
        mainAxisSpacing: CoreSpacing.sm(context),
        childAspectRatio: 1.8,
      ),
      itemBuilder: (context, index) {
        final key = keys[index];
        return WidgetsAppButton(
          label: key.label.isEmpty ? ' ' : key.label,
          icon: key.icon,
          variant: WidgetsAppButtonVariant.secondary,
          onPressed: () {
            switch (key.type) {
              case _KeypadKeyType.digit:
                onDigit(key.value);
              case _KeypadKeyType.clear:
                onClear();
              case _KeypadKeyType.backspace:
                onBackspace();
            }
          },
        );
      },
    );
  }
}

enum _KeypadKeyType { digit, clear, backspace }

class _KeypadKey {
  const _KeypadKey._({
    required this.type,
    required this.label,
    this.value = 0,
    this.icon,
  });

  _KeypadKey.digit(int value)
    : this._(type: _KeypadKeyType.digit, label: value.toString(), value: value);

  const _KeypadKey.clear() : this._(type: _KeypadKeyType.clear, label: 'C');

  const _KeypadKey.backspace()
    : this._(
        type: _KeypadKeyType.backspace,
        label: '',
        icon: Icons.backspace_outlined,
      );

  final _KeypadKeyType type;
  final String label;
  final int value;
  final IconData? icon;
}

class _PresetRow extends StatelessWidget {
  const _PresetRow({required this.onAdd});

  final ValueChanged<int> onAdd;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _PresetButton(label: '+1.00', cents: 100, onAdd: onAdd),
        ),
        SizedBox(width: CoreSpacing.sm(context)),
        Expanded(
          child: _PresetButton(label: '+5.00', cents: 500, onAdd: onAdd),
        ),
        SizedBox(width: CoreSpacing.sm(context)),
        Expanded(
          child: _PresetButton(label: '+10.00', cents: 1000, onAdd: onAdd),
        ),
      ],
    );
  }
}

class _PresetButton extends StatelessWidget {
  const _PresetButton({
    required this.label,
    required this.cents,
    required this.onAdd,
  });

  final String label;
  final int cents;
  final ValueChanged<int> onAdd;

  @override
  Widget build(BuildContext context) {
    return WidgetsAppButton(
      label: label,
      onPressed: () => onAdd(cents),
      variant: WidgetsAppButtonVariant.secondary,
    );
  }
}

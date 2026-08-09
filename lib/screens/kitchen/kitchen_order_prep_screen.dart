import 'dart:async';

import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/data/models/model_kitchen_prep_item.dart';
import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:ayletna_restaurant_app/navigation/app_route_paths.dart';
import 'package:ayletna_restaurant_app/providers/kitchen_session_providers.dart';
import 'package:ayletna_restaurant_app/utilities/utility_demo_actions.dart';
import 'package:ayletna_restaurant_app/utilities/utility_mock_feedback.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_async_state_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_icon_bubble.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_icon_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_ops_glance_chip.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_refresh_list.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_scaffold_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// PRD OrderPrepScreen — readable kitchen station workflow.
class KitchenOrderPrepScreen extends ConsumerWidget {
  const KitchenOrderPrepScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final board = ref.watch(kitchenBoardProvider);
    final orderId = board.activePrepOrderId;

    return WidgetsScaffoldPage(
      title: l10n.screenOrderPrep,
      actions: [
        const _ElapsedTimerBadge(),
        WidgetsIconButton(
          onPressed: () => context.push(AppRoutePaths.notifications),
          icon: Icons.notifications_outlined,
          tooltip: l10n.screenNotifications,
        ),
      ],
      child: WidgetsRefreshList(
        onRefresh:
            () async => UtilityMockFeedback.showInfo(
              context,
              orderId == null ? l10n.kitchenView : l10n.prepTitle(orderId),
            ),
        child:
            orderId == null
                ? Builder(
                  builder: (context) {
                    final children = <Widget>[
                      WidgetsAsyncStateCard.empty(
                        title: l10n.kitchenPreparing,
                        message: l10n.screenKitchenDashboardDesc,
                        actionLabel: l10n.prepBack,
                        onAction: () => context.go(AppRoutePaths.kitchen),
                      ),
                    ];
                    return ListView.builder(
                      itemCount: children.length,
                      itemBuilder: (context, index) => children[index],
                    );
                  },
                )
                : _ActivePrepBody(orderId: orderId, board: board, ref: ref),
      ),
    );
  }
}

class _ActivePrepBody extends StatelessWidget {
  const _ActivePrepBody({
    required this.orderId,
    required this.board,
    required this.ref,
  });

  final String orderId;
  final KitchenBoardState board;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final items = board.prepItems;
    final checkedCount = board.checkedPrepIndexes.length;
    final progress = checkedCount / items.length;

    void toggleItem(int index, bool value) {
      ref.read(kitchenBoardProvider.notifier).togglePrepItem(index, value);
    }

    Future<void> showIssueSheet() async {
      final confirmed = await UtilityMockFeedback.confirm(
        context: context,
        title: l10n.prepIssue,
        message: l10n.prepKitchenNoteBody,
        confirmLabel: l10n.prepUrgent,
        cancelLabel: l10n.prepBack,
        confirmVariant: WidgetsAppButtonVariant.danger,
        icon: Icons.report_outlined,
      );
      if (!context.mounted || !confirmed) return;
      ref.read(kitchenBoardProvider.notifier).reportIssue();
      UtilityMockFeedback.showWarning(context, l10n.prepIssue);
    }

    Future<void> markReady() async {
      if (!board.prepComplete) {
        UtilityMockFeedback.showError(
          context,
          l10n.prepItemsChecked(checkedCount, items.length),
        );
        return;
      }
      final confirmed = await UtilityMockFeedback.confirm(
        context: context,
        title: l10n.prepMarkReady,
        message: l10n.prepTitle(orderId),
        confirmLabel: l10n.prepMarkReady,
        cancelLabel: l10n.prepBack,
        icon: Icons.check_circle_outline,
      );
      if (!context.mounted || !confirmed) return;
      final ok = ref.read(kitchenBoardProvider.notifier).markReady();
      if (!context.mounted) return;
      if (ok) {
        UtilityDemoActions.complete(context, successMessage: l10n.prepMarkReady);
        context.go(AppRoutePaths.kitchen);
      } else {
        UtilityMockFeedback.showError(
          context,
          l10n.prepItemsChecked(checkedCount, items.length),
        );
      }
    }

    final children = <Widget>[
        _PrepHero(
          orderId: orderId,
          progress: progress,
          checked: checkedCount,
          total: items.length,
        ),
        SizedBox(height: CoreSpacing.lg(context)),
        LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth >= 940;
            final checklist = _StationChecklist(
              items: items,
              checked: board.checkedPrepIndexes,
              onChanged: toggleItem,
            );
            final side = Column(
              children: [
                _KitchenNotesPanel(onIssue: showIssueSheet),
                SizedBox(height: CoreSpacing.lg(context)),
                _PrepTimeline(prepStartedAt: board.prepStartedAt),
                SizedBox(height: CoreSpacing.lg(context)),
                _StationActions(
                  checked: checkedCount,
                  total: items.length,
                  onIssue: showIssueSheet,
                  onMarkReady: markReady,
                ),
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
    ];
    return ListView.builder(
      itemCount: children.length,
      itemBuilder: (context, index) => children[index],
    );
  }
}

class _PrepHero extends StatelessWidget {
  const _PrepHero({
    required this.orderId,
    required this.progress,
    required this.checked,
    required this.total,
  });

  final String orderId;
  final double progress;
  final int checked;
  final int total;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;

    return WidgetsAppCard(
      variant: WidgetsAppCardVariant.plain,
      padding: EdgeInsets.all(CoreSpacing.lg(context)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              WidgetsIconBubble(borderRadius: BorderRadius.circular(CoreSpacing.radiusButtonOf(context)), 
                icon: Icons.soup_kitchen_outlined,
                color: scheme.tertiary,
                size: CoreContentSizes.emptyStateIcon(context), iconSize: CoreContentSizes.kpiIcon(context),
              ),
              SizedBox(width: CoreSpacing.md(context)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.prepTitle(orderId),
                      style: CoreTypography.headlineSmall(
                        context,
                        scheme.onSurface,
                      ).copyWith(fontWeight: FontWeight.w900),
                    ),
                    SizedBox(height: CoreSpacing.xs(context)),
                    Text(
                      '${l10n.prepTable14} • ${l10n.prepGuestName}',
                      style: CoreTypography.bodyMedium(
                        context,
                        scheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              WidgetsOpsGlanceChip(
                label: l10n.prepPlated,
                color: CoreColors.orderTypePlated,
                icon: Icons.room_service_outlined,
                emphasized: true,
              ),
            ],
          ),
          SizedBox(height: CoreSpacing.lg(context)),
          Wrap(
            spacing: CoreSpacing.sm(context),
            runSpacing: CoreSpacing.sm(context),
            children: [
              WidgetsOpsGlanceChip(
                label: l10n.prepCovers,
                color: CoreColors.orderTypeDineIn,
                icon: Icons.groups_outlined,
              ),
              WidgetsOpsGlanceChip(
                label: l10n.prepReceived,
                color: scheme.tertiary,
                icon: Icons.schedule_outlined,
              ),
              WidgetsOpsGlanceChip(
                label: l10n.prepItemsChecked(checked, total),
                color: CoreColors.semanticSuccess,
                icon: Icons.checklist_rtl_outlined,
                emphasized: progress >= 1,
              ),
              WidgetsOpsGlanceChip(
                label: l10n.prepUrgent,
                color: CoreColors.semanticError,
                icon: Icons.warning_amber_rounded,
                emphasized: true,
              ),
            ],
          ),
          SizedBox(height: CoreSpacing.lg(context)),
          ClipRRect(
            borderRadius: BorderRadius.circular(CoreSpacing.radiusChipOf(context)),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: CoreSpacing.sm(context) + CoreSpacing.xs(context),
              backgroundColor: scheme.surfaceContainerHighest,
              valueColor: AlwaysStoppedAnimation<Color>(
                progress >= 1
                    ? CoreColors.semanticSuccess
                    : CoreColors.semanticError,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StationChecklist extends StatelessWidget {
  const _StationChecklist({
    required this.items,
    required this.checked,
    required this.onChanged,
  });

  final List<ModelKitchenPrepItem> items;
  final Set<int> checked;
  final void Function(int index, bool value) onChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;

    return WidgetsAppCard(
      variant: WidgetsAppCardVariant.plain,
      padding: EdgeInsets.all(CoreSpacing.lg(context)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              WidgetsIconBubble(borderRadius: BorderRadius.circular(CoreSpacing.radiusButtonOf(context)), 
                icon: Icons.restaurant_menu_outlined,
                color: scheme.tertiary,
              ),
              SizedBox(width: CoreSpacing.sm(context)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.prepOrderItems,
                      style: CoreTypography.titleMedium(
                        context,
                        scheme.onSurface,
                      ).copyWith(fontWeight: FontWeight.w900),
                    ),
                    Text(
                      l10n.prepItemsTotal,
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
            _PrepTargetCard(
              item: entry.$2,
              checked: checked.contains(entry.$1),
              onTap: () => onChanged(entry.$1, !checked.contains(entry.$1)),
            ),
            SizedBox(height: CoreSpacing.sm(context)),
          ],
        ],
      ),
    );
  }
}

class _PrepTargetCard extends StatelessWidget {
  const _PrepTargetCard({
    required this.item,
    required this.checked,
    required this.onTap,
  });

  final ModelKitchenPrepItem item;
  final bool checked;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    final isAr = Localizations.localeOf(context).languageCode == 'ar';
    final name = isAr ? item.nameAr : item.nameEn;
    final specs = isAr ? item.specsAr : item.specsEn;
    final warning = isAr ? item.warningAr : item.warningEn;
    final color = checked ? CoreColors.semanticSuccess : scheme.tertiary;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(CoreSpacing.radiusCardOf(context)),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: color.withValues(alpha: checked ? 0.10 : 0.06),
          borderRadius: BorderRadius.circular(CoreSpacing.radiusCardOf(context)),
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
                      children: [
                        Expanded(
                          child: Text(
                            name,
                            style: CoreTypography.titleMedium(
                              context,
                              scheme.onSurface,
                            ).copyWith(fontWeight: FontWeight.w900),
                          ),
                        ),
                        WidgetsOpsGlanceChip(
                          label: l10n.prepQuantity(item.quantity),
                          color: color,
                          icon: Icons.close,
                        ),
                      ],
                    ),
                    SizedBox(height: CoreSpacing.xs(context)),
                    Text(
                      specs,
                      style: CoreTypography.bodyMedium(
                        context,
                        scheme.onSurfaceVariant,
                      ),
                    ),
                    if (warning != null) ...[
                      SizedBox(height: CoreSpacing.sm(context)),
                      _WarningStrip(message: warning),
                    ],
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

class _KitchenNotesPanel extends StatelessWidget {
  const _KitchenNotesPanel({required this.onIssue});

  final VoidCallback onIssue;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;

    return WidgetsAppCard(
      variant: WidgetsAppCardVariant.food,
      padding: EdgeInsets.all(CoreSpacing.lg(context)),
      accentColor: CoreColors.semanticError,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              WidgetsIconBubble(borderRadius: BorderRadius.circular(CoreSpacing.radiusButtonOf(context)), 
                icon: Icons.notification_important_outlined,
                color: CoreColors.semanticError,
              ),
              SizedBox(width: CoreSpacing.sm(context)),
              Expanded(
                child: Text(
                  l10n.prepKitchenNotes,
                  style: CoreTypography.titleMedium(
                    context,
                    scheme.onSurface,
                  ).copyWith(fontWeight: FontWeight.w900),
                ),
              ),
              WidgetsOpsGlanceChip(
                label: l10n.prepUrgent,
                color: CoreColors.semanticError,
                icon: Icons.priority_high_outlined,
                emphasized: true,
              ),
            ],
          ),
          SizedBox(height: CoreSpacing.md(context)),
          Text(
            l10n.prepKitchenNoteBody,
            style: CoreTypography.bodyMedium(context, scheme.onSurface),
          ),
          SizedBox(height: CoreSpacing.md(context)),
          Text(
            l10n.prepServer,
            style: CoreTypography.caption(context, scheme.onSurfaceVariant),
          ),
          SizedBox(height: CoreSpacing.md(context)),
          WidgetsAppButton(
            label: l10n.prepIssue,
            onPressed: onIssue,
            icon: Icons.report_outlined,
            variant: WidgetsAppButtonVariant.danger,
            fullWidth: true,
          ),
        ],
      ),
    );
  }
}

class _PrepTimeline extends StatelessWidget {
  const _PrepTimeline({this.prepStartedAt});

  final DateTime? prepStartedAt;

  _StageState _stageFor(int index) {
    if (prepStartedAt == null) return _StageState.pending;
    final elapsed = DateTime.now().difference(prepStartedAt!);
    if (elapsed.inMinutes >= 1) {
      return switch (index) {
        0 => _StageState.done,
        1 => _StageState.done,
        2 => _StageState.current,
        _ => _StageState.pending,
      };
    }
    return switch (index) {
      0 => _StageState.done,
      _ => _StageState.pending,
    };
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    final stages = [
      _Stage(l10n.prepOrderReceived, _stageFor(0)),
      _Stage(l10n.prepStarted, _stageFor(1)),
      _Stage(l10n.prepAssemblyProgress, _stageFor(2)),
      _Stage(l10n.prepFinalPlating, _stageFor(3)),
    ];

    return WidgetsAppCard(
      variant: WidgetsAppCardVariant.form,
      padding: EdgeInsets.all(CoreSpacing.lg(context)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              WidgetsIconBubble(borderRadius: BorderRadius.circular(CoreSpacing.radiusButtonOf(context)), icon: Icons.timeline_outlined, color: scheme.primary),
              SizedBox(width: CoreSpacing.sm(context)),
              Text(
                l10n.prepStages,
                style: CoreTypography.titleMedium(
                  context,
                  scheme.onSurface,
                ).copyWith(fontWeight: FontWeight.w900),
              ),
            ],
          ),
          SizedBox(height: CoreSpacing.md(context)),
          for (final stage in stages) _StageRow(stage: stage),
        ],
      ),
    );
  }
}

class _StationActions extends StatelessWidget {
  const _StationActions({
    required this.checked,
    required this.total,
    required this.onIssue,
    required this.onMarkReady,
  });

  final int checked;
  final int total;
  final VoidCallback onIssue;
  final Future<void> Function() onMarkReady;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return WidgetsAppCard(
      variant: WidgetsAppCardVariant.dashboard,
      padding: EdgeInsets.all(CoreSpacing.lg(context)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          WidgetsOpsGlanceChip(
            label: l10n.prepItemsChecked(checked, total),
            color:
                checked == total
                    ? CoreColors.semanticSuccess
                    : CoreColors.orderTypePlated,
            icon: Icons.checklist_rtl_outlined,
          ),
          SizedBox(height: CoreSpacing.md(context)),
          WidgetsAppButton(
            label: l10n.prepMarkReady,
            onPressed: onMarkReady,
            icon: Icons.check_circle_outline,
            fullWidth: true,
          ),
          SizedBox(height: CoreSpacing.sm(context)),
          Row(
            children: [
              Expanded(
                child: WidgetsAppButton(
                  label: l10n.prepBack,
                  onPressed: () => context.pop(),
                  icon: Icons.arrow_back,
                  variant: WidgetsAppButtonVariant.outline,
                ),
              ),
              SizedBox(width: CoreSpacing.sm(context)),
              Expanded(
                child: WidgetsAppButton(
                  label: l10n.prepIssue,
                  onPressed: onIssue,
                  icon: Icons.report_outlined,
                  variant: WidgetsAppButtonVariant.danger,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

enum _StageState { done, current, pending }

class _Stage {
  const _Stage(this.label, this.state);

  final String label;
  final _StageState state;
}

class _StageRow extends StatelessWidget {
  const _StageRow({required this.stage});

  final _Stage stage;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final color = switch (stage.state) {
      _StageState.done => CoreColors.semanticSuccess,
      _StageState.current => scheme.primary,
      _StageState.pending => scheme.onSurfaceVariant,
    };
    final icon = switch (stage.state) {
      _StageState.done => Icons.check_circle,
      _StageState.current => Icons.radio_button_checked,
      _StageState.pending => Icons.radio_button_unchecked,
    };

    return Padding(
      padding: EdgeInsets.only(bottom: CoreSpacing.sm(context)),
      child: Row(
        children: [
          Icon(icon, color: color, size: CoreContentSizes.buttonIcon(context)),
          SizedBox(width: CoreSpacing.sm(context)),
          Expanded(
            child: Text(
              stage.label,
              style: CoreTypography.bodyMedium(
                context,
                scheme.onSurface,
              ).copyWith(
                fontWeight:
                    stage.state == _StageState.current
                        ? FontWeight.w900
                        : FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _WarningStrip extends StatelessWidget {
  const _WarningStrip({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: CoreColors.semanticError.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(CoreSpacing.radiusButtonOf(context)),
        border: Border.all(
          color: CoreColors.semanticError.withValues(alpha: 0.24),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(CoreSpacing.sm(context)),
        child: Row(
          children: [
            Icon(
              Icons.warning_amber_rounded,
              color: CoreColors.semanticError,
              size: CoreContentSizes.orderTypeIcon(context),
            ),
            SizedBox(width: CoreSpacing.xs(context)),
            Expanded(
              child: Text(
                message,
                style: CoreTypography.caption(context, scheme.onSurface),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ElapsedTimerBadge extends ConsumerStatefulWidget {
  const _ElapsedTimerBadge();

  @override
  ConsumerState<_ElapsedTimerBadge> createState() => _ElapsedTimerBadgeState();
}

class _ElapsedTimerBadgeState extends ConsumerState<_ElapsedTimerBadge> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final elapsed = ref.watch(kitchenBoardProvider.select((b) => b.formattedElapsedTime));
    return Padding(
      padding: EdgeInsets.symmetric(vertical: CoreSpacing.sm(context)),
      child: WidgetsOpsGlanceChip(
        label: elapsed,
        color: CoreColors.orderTypePlated,
        icon: Icons.timer_outlined,
        emphasized: true,
      ),
    );
  }
}



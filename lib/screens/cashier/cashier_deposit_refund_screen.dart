import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/data/models/model_order_summary.dart';
import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:ayletna_restaurant_app/navigation/app_route_paths.dart';
import 'package:ayletna_restaurant_app/providers/cashier_session_providers.dart';
import 'package:ayletna_restaurant_app/utilities/utility_demo_actions.dart';
import 'package:ayletna_restaurant_app/utilities/utility_mock_feedback.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_action_bar.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_avatar.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_choice_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_financial_summary.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_icon_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_info_banner.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_list_item.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_phone_text.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_progress_bar.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_refresh_list.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_scaffold_page.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_status_pill.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// PRD [CashierDepositRefundScreen].
class CashierDepositRefundScreen extends ConsumerStatefulWidget {
  const CashierDepositRefundScreen({super.key});

  @override
  ConsumerState<CashierDepositRefundScreen> createState() =>
      _CashierDepositRefundScreenState();
}

class _CashierDepositRefundScreenState
    extends ConsumerState<CashierDepositRefundScreen> {
  bool _showSettlement = false;
  final Set<_RefundItemKind> _damagedItems = {_RefundItemKind.tray};

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return PopScope(
      canPop: !_showSettlement,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop && _showSettlement) {
          setState(() => _showSettlement = false);
        }
      },
      child: WidgetsScaffoldPage(
        title: _showSettlement ? l10n.refundStep3Title : l10n.refundStep2Title,
        actions: [
          WidgetsIconButton(
            onPressed: () => context.push(AppRoutePaths.notifications),
            icon: Icons.notifications_outlined,
            tooltip: l10n.screenNotifications,
          ),
        ],
        child: WidgetsRefreshList(
          onRefresh: () async {
            await Future<void>.delayed(const Duration(milliseconds: 300));
            if (!context.mounted) return;
            UtilityMockFeedback.showInfo(context, l10n.refundStep2Title);
          },
          child: ListView(
            padding: EdgeInsetsDirectional.only(
              top: CoreSpacing.lg(context),
              bottom: CoreSpacing.xxl(context),
            ),
            children: [
              if (_showSettlement)
                _RefundSettlementView(
                  onModify: () => setState(() => _showSettlement = false),
                )
              else
                _RefundAssessmentView(
                  damagedItems: _damagedItems,
                  onChanged:
                      (item, damaged) => setState(() {
                        if (damaged) {
                          _damagedItems.add(item);
                        } else {
                          _damagedItems.remove(item);
                        }
                      }),
                ),
              if (!_showSettlement) ...[
                SizedBox(height: CoreSpacing.lg(context)),
                _RefundAssessmentActions(
                  onCancel: () => context.go(AppRoutePaths.cashier),
                  onReview: () => setState(() => _showSettlement = true),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

enum _RefundItemKind { plate, tray, pot }

class _RefundAssessmentView extends StatelessWidget {
  const _RefundAssessmentView({
    required this.damagedItems,
    required this.onChanged,
  });

  final Set<_RefundItemKind> damagedItems;
  final void Function(_RefundItemKind item, bool damaged) onChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Column(
      children: [
        _InstructionCard(
          title: l10n.refundStep2Header,
          body: l10n.refundStep2Body,
        ),
        SizedBox(height: CoreSpacing.xl(context)),
        _RefundItemCard(
          item: _RefundItemKind.plate,
          title: l10n.refundCeramicPlate,
          asset: l10n.refundCeramicPlateAsset,
          badge: l10n.orderTypeDineIn,
          accent: CoreColors.orderTypeDineIn,
          icon: Icons.flatware_outlined,
          damaged: damagedItems.contains(_RefundItemKind.plate),
          onChanged: onChanged,
        ),
        SizedBox(height: CoreSpacing.lg(context)),
        _RefundItemCard(
          item: _RefundItemKind.tray,
          title: l10n.refundWoodenTray,
          asset: l10n.refundWoodenTrayAsset,
          badge: l10n.orderTypePlated,
          accent: CoreColors.brandOrange,
          icon: Icons.room_service_outlined,
          damaged: damagedItems.contains(_RefundItemKind.tray),
          onChanged: onChanged,
        ),
        SizedBox(height: CoreSpacing.lg(context)),
        _RefundItemCard(
          item: _RefundItemKind.pot,
          title: l10n.refundCoffeePot,
          asset: l10n.refundCoffeePotAsset,
          badge: l10n.orderTypeTakeaway,
          accent: CoreColors.orderTypeDelivery,
          icon: Icons.coffee_outlined,
          damaged: damagedItems.contains(_RefundItemKind.pot),
          onChanged: onChanged,
        ),
        SizedBox(height: CoreSpacing.xl(context)),
        const _DepositSummaryCard(),
      ],
    );
  }
}

class _InstructionCard extends StatelessWidget {
  const _InstructionCard({required this.title, required this.body});

  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return WidgetsInfoBanner(
      title: title,
      message: body,
      icon: Icons.assignment_turned_in_outlined,
      tone: WidgetsInfoBannerTone.success,
    );
  }
}

class _RefundItemCard extends StatelessWidget {
  const _RefundItemCard({
    required this.item,
    required this.title,
    required this.asset,
    required this.badge,
    required this.accent,
    required this.icon,
    required this.damaged,
    required this.onChanged,
  });

  final _RefundItemKind item;
  final String title;
  final String asset;
  final String badge;
  final Color accent;
  final IconData icon;
  final bool damaged;
  final void Function(_RefundItemKind item, bool damaged) onChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return WidgetsAppCard(
      title: title,
      subtitle: asset,
      leading: Icon(icon, color: CoreColors.brandBrown),
      trailing: WidgetsStatusPill(label: badge, color: accent, compact: true),
      accentColor: accent,
      child: Row(
        children: [
          Expanded(
            child: WidgetsChoiceCard(
              title: l10n.refundReturned,
              selected: !damaged,
              onTap: () => onChanged(item, false),
              icon: Icons.check_circle_outline,
              accentColor: CoreColors.semanticSuccess,
            ),
          ),
          SizedBox(width: CoreSpacing.md(context)),
          Expanded(
            child: WidgetsChoiceCard(
              title: l10n.refundDamaged,
              selected: damaged,
              onTap: () => onChanged(item, true),
              icon: Icons.error_outline,
              accentColor: CoreColors.semanticError,
            ),
          ),
        ],
      ),
    );
  }
}

class _DepositSummaryCard extends StatelessWidget {
  const _DepositSummaryCard();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return WidgetsFinancialSummary(
      title: l10n.refundDepositSummary,
      subtitle: l10n.refundEstimateBody,
      accentColor: CoreColors.brandBrown,
      lines: [
        WidgetsFinancialSummaryLine(
          label: l10n.refundHeldFunds,
          value: l10n.refundDepositAmount,
          valueColor: CoreColors.brandBrown,
          accentColor: CoreColors.brandBrown,
        ),
      ],
      totalLabel: l10n.refundDepositSummary,
      totalValue: '${l10n.refundDepositAmount} ${l10n.currencyJod}',
      totalColor: CoreColors.brandBrown,
    );
  }
}

class _RefundAssessmentActions extends StatelessWidget {
  const _RefundAssessmentActions({
    required this.onCancel,
    required this.onReview,
  });

  final VoidCallback onCancel;
  final VoidCallback onReview;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return WidgetsActionBar(
      progress: 0.66,
      secondary: WidgetsAppButton(
        label: l10n.refundCancelFlow,
        onPressed: onCancel,
        variant: WidgetsAppButtonVariant.outline,
      ),
      primary: WidgetsAppButton(
        label: l10n.refundReviewRefund,
        onPressed: onReview,
        icon: Icons.arrow_forward,
        iconAlignment: IconAlignment.end,
        fullWidth: true,
      ),
    );
  }
}

class _RefundSettlementView extends ConsumerWidget {
  const _RefundSettlementView({required this.onModify});

  final VoidCallback onModify;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;

    return Column(
      children: [
        WidgetsFinancialSummary(
          title: l10n.refundSettlementSummary,
          subtitle: l10n.refundCreditingWallet,
          accentColor: CoreColors.semanticSuccess,
          lines: [
            WidgetsFinancialSummaryLine(
              label:
                  '${l10n.refundOriginalDeposit} - ${l10n.refundReceivedAtTable}',
              value: l10n.refundOriginalDepositAmount,
            ),
            WidgetsFinancialSummaryLine(
              label:
                  '${l10n.refundBreakageFees} - ${l10n.refundBreakageDetails}',
              value: l10n.refundBreakageAmount,
              valueColor: CoreColors.semanticError,
              accentColor: CoreColors.semanticError,
            ),
          ],
          totalLabel: l10n.refundNetRefund,
          totalValue: l10n.refundNetRefundAmount,
          totalColor: CoreColors.brandBrown,
          footer: Align(
            alignment: AlignmentDirectional.centerStart,
            child: WidgetsStatusPill(
              label: l10n.refundReadyForPayout,
              color: CoreColors.semanticSuccess,
              icon: Icons.verified_outlined,
            ),
          ),
        ),
        SizedBox(height: CoreSpacing.lg(context)),
        _NoticeCard(text: l10n.refundImmediateNotice),
        SizedBox(height: CoreSpacing.lg(context)),
        const _CustomerInfoCard(),
        SizedBox(height: CoreSpacing.lg(context)),
        const _TerminalCard(),
        SizedBox(height: CoreSpacing.lg(context)),
        const _VerifiedTransactionArt(),
        SizedBox(height: CoreSpacing.lg(context)),
        WidgetsAppButton(
          label: l10n.refundConfirmProcess,
          onPressed: () async {
            final confirmed = await UtilityMockFeedback.confirm(
              context: context,
              title: l10n.refundConfirmProcess,
              message: l10n.refundSettlementSummary,
              confirmLabel: l10n.refundConfirmProcess,
              cancelLabel: MaterialLocalizations.of(context).cancelButtonLabel,
              icon: Icons.keyboard_return_outlined,
            );
            if (confirmed && context.mounted) {
              final sessions = ref.read(cashierSessionOrdersProvider);
              ModelOrderSummary? plated;
              for (final order in sessions) {
                if (order.isPlated && order.statusKey != 'refunded') {
                  plated = order;
                  break;
                }
              }
              if (plated != null) {
                ref
                    .read(cashierSessionOrdersProvider.notifier)
                    .markRefunded(plated.id);
              } else {
                ref.read(cashierSessionOrdersProvider.notifier).recordOrder(
                  ModelOrderSummary(
                    id:
                        'DEP-${DateTime.now().millisecondsSinceEpoch % 100000}',
                    orderType: OrderType.platedDelivery,
                    customerLabel: l10n.cashierWalkIn,
                    totalJod: 0,
                    depositJod: 15,
                    statusKey: 'refunded',
                    isPlated: true,
                  ),
                );
              }
              UtilityDemoActions.complete(context, successMessage: l10n.refundReadyForPayout);
              context.go(AppRoutePaths.cashierOrderHistory);
            }
          },
          icon: Icons.check_circle_outline,
          iconAlignment: IconAlignment.end,
          fullWidth: true,
        ),
        SizedBox(height: CoreSpacing.md(context)),
        WidgetsAppButton(
          label: l10n.refundModifyAssessment,
          onPressed: onModify,
          icon: Icons.edit_outlined,
          variant: WidgetsAppButtonVariant.ghost,
        ),
        SizedBox(height: CoreSpacing.xl(context)),
        const _StepLabels(),
      ],
    );
  }
}

class _NoticeCard extends StatelessWidget {
  const _NoticeCard({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final phone = _extractPhone(text);

    if (phone == null) {
      return WidgetsInfoBanner(
        message: text,
        icon: Icons.info_outline,
        tone: WidgetsInfoBannerTone.info,
      );
    }

    final parts = _splitAround(text, phone);
    return WidgetsAppCard(
      variant: WidgetsAppCardVariant.outlined,
      accentColor: scheme.primary,
      padding: EdgeInsets.all(CoreSpacing.md(context)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.info_outline, color: scheme.primary),
          SizedBox(width: CoreSpacing.md(context)),
          Expanded(
            child: WidgetsMixedPhoneText(
              prefix: parts.prefix,
              phone: phone,
              suffix: parts.suffix,
              textAlign: TextAlign.start,
              style: CoreTypography.bodyMedium(
                context,
                scheme.onSurfaceVariant,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String? _extractPhone(String value) {
    final match = RegExp(r'\+962[\d\s*]+').firstMatch(value);
    return match?.group(0);
  }

  ({String prefix, String suffix}) _splitAround(String value, String phone) {
    final index = value.indexOf(phone);
    if (index == -1) {
      return (prefix: value, suffix: '');
    }
    return (
      prefix: value.substring(0, index),
      suffix: value.substring(index + phone.length),
    );
  }
}

class _CustomerInfoCard extends StatelessWidget {
  const _CustomerInfoCard();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;

    return WidgetsAppCard(
      title: l10n.refundCustomerInfo,
      subtitle: l10n.refundCustomerTier,
      leading: const WidgetsAvatar(icon: Icons.account_circle_outlined),
      accentColor: CoreColors.semanticSuccess,
      child: Column(
        children: [
          WidgetsListItem(
            title: l10n.refundCustomerName,
            subtitle: l10n.refundCustomerTier,
            leading: Icon(Icons.person_outline, color: scheme.primary),
          ),
          SizedBox(height: CoreSpacing.sm(context)),
          _WalletComparisonLine(
            label: l10n.refundCurrentWallet,
            value: l10n.refundCurrentWalletAmount,
            color: scheme.onSurface,
          ),
          _WalletComparisonLine(
            label: l10n.refundPostRefund,
            value: l10n.refundPostRefundAmount,
            color: CoreColors.semanticSuccess,
          ),
        ],
      ),
    );
  }
}

class _WalletComparisonLine extends StatelessWidget {
  const _WalletComparisonLine({
    required this.label,
    required this.value,
    required this.color,
  });

  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(top: CoreSpacing.xs(context)),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: CoreTypography.caption(
                context,
                Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          Text(
            value,
            style: CoreTypography.caption(
              context,
              color,
            ).copyWith(fontWeight: FontWeight.w900),
          ),
        ],
      ),
    );
  }
}

class _TerminalCard extends StatelessWidget {
  const _TerminalCard();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return WidgetsAppCard(
      title: l10n.refundTerminalId,
      subtitle: l10n.refundAuthorizedCashier,
      leading: Icon(Icons.point_of_sale_outlined, color: CoreColors.brandBrown),
      accentColor: CoreColors.brandBrown,
      child: WidgetsStatusPill(
        label: l10n.refundTerminalCode,
        color: CoreColors.brandBrown,
        icon: Icons.verified_user_outlined,
      ),
    );
  }
}

class _VerifiedTransactionArt extends StatelessWidget {
  const _VerifiedTransactionArt();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return ClipRRect(
      borderRadius: BorderRadius.circular(CoreSpacing.radiusCardOf(context)),
      child: SizedBox(
        height: CoreContentSizes.heroImageHeight(context) * 0.62,
        child: CustomPaint(
          painter: _TerminalPainter(color: CoreColors.brandBrown),
          child: Align(
            alignment: AlignmentDirectional.bottomStart,
            child: Padding(
              padding: EdgeInsets.all(CoreSpacing.md(context)),
              child: Text(
                l10n.refundVerifiedTransaction.toUpperCase(),
                style: CoreTypography.caption(
                  context,
                  CoreColors.surfaceLight,
                ).copyWith(letterSpacing: 1.2, fontWeight: FontWeight.w900),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _StepLabels extends StatelessWidget {
  const _StepLabels();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Column(
      children: [
        const WidgetsProgressBar(value: 1, color: CoreColors.brandBrown),
        SizedBox(height: CoreSpacing.sm(context)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              l10n.refundIdentification.toUpperCase(),
              style: CoreTypography.caption(
                context,
                Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            Text(
              l10n.refundAssessment.toUpperCase(),
              style: CoreTypography.caption(
                context,
                Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            Text(
              l10n.refundSettlement.toUpperCase(),
              style: CoreTypography.caption(
                context,
                CoreColors.brandBrown,
              ).copyWith(fontWeight: FontWeight.w900),
            ),
          ],
        ),
      ],
    );
  }
}

class _TerminalPainter extends CustomPainter {
  const _TerminalPainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final bg =
        Paint()
          ..shader = LinearGradient(
            colors: [color, CoreColors.brandOrange],
            begin: AlignmentDirectional.topStart,
            end: AlignmentDirectional.bottomEnd,
          ).createShader(Offset.zero & size);
    canvas.drawRect(Offset.zero & size, bg);
    final device = RRect.fromRectAndRadius(
      Rect.fromLTWH(
        size.width * 0.42,
        size.height * 0.18,
        size.width * 0.42,
        size.height * 0.58,
      ),
      Radius.circular(CoreSpacing.radiusButton),
    );
    canvas.drawRRect(
      device,
      Paint()..color = CoreColors.surfaceDark.withValues(alpha: 0.75),
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(
          size.width * 0.50,
          size.height * 0.27,
          size.width * 0.22,
          size.height * 0.20,
        ),
        Radius.circular(CoreSpacing.radiusChip),
      ),
      Paint()..color = CoreColors.semanticSuccess.withValues(alpha: 0.85),
    );
    final check =
        Path()
          ..moveTo(size.width * 0.56, size.height * 0.38)
          ..lineTo(size.width * 0.61, size.height * 0.43)
          ..lineTo(size.width * 0.68, size.height * 0.32);
    canvas.drawPath(
      check,
      Paint()
        ..color = CoreColors.surfaceLight
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3,
    );
  }

  @override
  bool shouldRepaint(covariant _TerminalPainter oldDelegate) {
    return oldDelegate.color != color;
  }
}

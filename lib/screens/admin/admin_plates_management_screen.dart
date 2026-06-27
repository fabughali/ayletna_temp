import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/data/mockup/mockup_catalog.dart';
import 'package:ayletna_restaurant_app/data/models/model_admin_mock.dart';
import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:ayletna_restaurant_app/navigation/app_route_paths.dart';
import 'package:ayletna_restaurant_app/providers/admin_plates_providers.dart';
import 'package:ayletna_restaurant_app/utilities/utility_format_jod.dart';
import 'package:ayletna_restaurant_app/utilities/utility_mock_feedback.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_icon_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_refresh_list.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_scaffold_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// PRD [PlatesManagementScreen].
class AdminPlatesManagementScreen extends ConsumerWidget {
  const AdminPlatesManagementScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final isAr = Localizations.localeOf(context).languageCode == 'ar';
    final assets = MockupCatalog.adminPlateAssets;

    return WidgetsScaffoldPage(
      title: l10n.screenPlatesManagement,
      actions: [
        WidgetsIconButton(
          onPressed: () => context.push(AppRoutePaths.notifications),
          icon: Icons.notifications_outlined,
          tooltip: l10n.screenNotifications,
        ),
        WidgetsIconButton(
          onPressed: () => context.push(AppRoutePaths.adminDepositConfig),
          icon: Icons.payments_outlined,
          tooltip: l10n.screenDepositConfig,
        ),
      ],
      child: WidgetsRefreshList(
        onRefresh: () async {
          ref.invalidate(adminPlatesProvider);
        },
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth >= 860;
            return ListView(
              padding: EdgeInsetsDirectional.only(
                top: CoreSpacing.md(context),
                bottom: CoreSpacing.xxl(context),
              ),
              children: [
                _PlateOpsHero(l10n: l10n, isAr: isAr, assets: assets),
                SizedBox(height: CoreSpacing.lg(context)),
                if (isWide)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(flex: 6, child: _AssetCatalog(assets: assets)),
                      SizedBox(width: CoreSpacing.lg(context)),
                      Expanded(
                        flex: 4,
                        child: Column(
                          children: [
                            _DepositPolicyCard(l10n: l10n, isAr: isAr),
                            SizedBox(height: CoreSpacing.lg(context)),
                            _BreakageBoard(l10n: l10n, isAr: isAr),
                            SizedBox(height: CoreSpacing.lg(context)),
                            _RestockBoard(l10n: l10n, isAr: isAr),
                          ],
                        ),
                      ),
                    ],
                  )
                else ...[
                  _AssetCatalog(assets: assets),
                  SizedBox(height: CoreSpacing.lg(context)),
                  _DepositPolicyCard(l10n: l10n, isAr: isAr),
                  SizedBox(height: CoreSpacing.lg(context)),
                  _BreakageBoard(l10n: l10n, isAr: isAr),
                  SizedBox(height: CoreSpacing.lg(context)),
                  _RestockBoard(l10n: l10n, isAr: isAr),
                ],
              ],
            );
          },
        ),
      ),
    );
  }
}

class _PlateOpsHero extends StatelessWidget {
  const _PlateOpsHero({
    required this.l10n,
    required this.isAr,
    required this.assets,
  });

  final AppLocalizations l10n;
  final bool isAr;
  final List<ModelAdminPlateAsset> assets;

  @override
  Widget build(BuildContext context) {
    final totalStock = assets.fold<int>(0, (sum, asset) => sum + asset.stock);
    final circulating = assets.fold<int>(
      0,
      (sum, asset) => sum + asset.circulating,
    );
    final totalValue = assets.fold<double>(
      0,
      (sum, asset) => sum + asset.priceJod * asset.stock,
    );

    return Container(
      padding: EdgeInsets.all(CoreSpacing.lg(context)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(CoreSpacing.radiusCard),
        gradient: const LinearGradient(
          colors: [CoreColors.orderTypePlated, CoreColors.brandBrown],
          begin: AlignmentDirectional.topStart,
          end: AlignmentDirectional.bottomEnd,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SoftBadge(
            label:
                isAr ? 'إدارة الصواني والعربون' : 'Plate Asset & Deposit Ops',
            color: CoreColors.surfaceLight,
            foreground: CoreColors.brandBrown,
          ),
          SizedBox(height: CoreSpacing.md(context)),
          Text(
            isAr
                ? 'تابع الصواني، الأوعية، الكسر، العربون، والإرجاع من مكان واحد.'
                : 'Track trays, bowls, breakage, deposits, and returns from one board.',
            style: CoreTypography.headlineSmall(
              context,
              CoreColors.surfaceLight,
            ).copyWith(fontWeight: FontWeight.w900),
          ),
          SizedBox(height: CoreSpacing.lg(context)),
          Wrap(
            spacing: CoreSpacing.sm(context),
            runSpacing: CoreSpacing.sm(context),
            children: [
              _HeroStat(
                label: isAr ? 'في المخزون' : 'In stock',
                value: '$totalStock',
                icon: Icons.inventory_2_outlined,
              ),
              _HeroStat(
                label: isAr ? 'متداول' : 'Circulating',
                value: '$circulating',
                icon: Icons.sync_alt_outlined,
              ),
              _HeroStat(
                label: isAr ? 'قيمة الأصول' : 'Asset value',
                value: UtilityFormatJod.format(
                  totalValue,
                  suffix: l10n.currencyJod,
                ),
                icon: Icons.payments_outlined,
              ),
            ],
          ),
          SizedBox(height: CoreSpacing.lg(context)),
          Wrap(
            spacing: CoreSpacing.sm(context),
            runSpacing: CoreSpacing.sm(context),
            children: [
              WidgetsAppButton(
                label: l10n.platesNewComponent,
                onPressed: () => context.push(AppRoutePaths.adminPlateEditor),
                icon: Icons.add,
              ),
              WidgetsAppButton(
                label: l10n.screenDepositConfig,
                onPressed: () => context.push(AppRoutePaths.adminDepositConfig),
                icon: Icons.tune_outlined,
                variant: WidgetsAppButtonVariant.secondary,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _AssetCatalog extends StatelessWidget {
  const _AssetCatalog({required this.assets});

  final List<ModelAdminPlateAsset> assets;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isAr = Localizations.localeOf(context).languageCode == 'ar';
    return WidgetsAppCard(
      title: l10n.platesCatalogTitle,
      subtitle:
          isAr
              ? 'أصول فعلية لها كود، قيمة، مخزون، وتداول.'
              : 'Physical assets with SKU, value, stock, and circulation.',
      leading: const _IconBubble(
        icon: Icons.room_service_outlined,
        color: CoreColors.orderTypePlated,
      ),
      child: Column(
        children: [
          for (final asset in assets)
            _AssetRow(asset: asset, l10n: l10n, isAr: isAr),
        ],
      ),
    );
  }
}

class _AssetRow extends StatelessWidget {
  const _AssetRow({
    required this.asset,
    required this.l10n,
    required this.isAr,
  });

  final ModelAdminPlateAsset asset;
  final AppLocalizations l10n;
  final bool isAr;

  @override
  Widget build(BuildContext context) {
    final color = _assetColor(asset.badgeKey);
    return Container(
      margin: EdgeInsets.only(bottom: CoreSpacing.md(context)),
      padding: EdgeInsets.all(CoreSpacing.md(context)),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(CoreSpacing.radiusCard),
        border: Border.all(color: color.withValues(alpha: 0.18)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              _PlateSketch(kind: asset.painterKey, color: color),
              SizedBox(width: CoreSpacing.md(context)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isAr ? asset.titleAr : asset.titleEn,
                      style: CoreTypography.titleMedium(
                        context,
                        Theme.of(context).colorScheme.onSurface,
                      ).copyWith(fontWeight: FontWeight.w900),
                    ),
                    Text(
                      asset.sku,
                      style: CoreTypography.caption(
                        context,
                        Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              _SoftBadge(
                label: _assetBadge(l10n, asset.badgeKey),
                color: color,
              ),
            ],
          ),
          SizedBox(height: CoreSpacing.md(context)),
          Row(
            children: [
              Expanded(
                child: _MiniStat(
                  label: l10n.platesInStock,
                  value: '${asset.stock}',
                  color: color,
                ),
              ),
              SizedBox(width: CoreSpacing.sm(context)),
              Expanded(
                child: _MiniStat(
                  label: l10n.platesCirculating,
                  value: '${asset.circulating}',
                  color: CoreColors.brandOlive,
                ),
              ),
              SizedBox(width: CoreSpacing.sm(context)),
              Expanded(
                child: _MiniStat(
                  label: l10n.platesPerUnit,
                  value: UtilityFormatJod.format(
                    asset.priceJod,
                    suffix: l10n.currencyJod,
                  ),
                  color: CoreColors.semanticDeposit,
                ),
              ),
            ],
          ),
          SizedBox(height: CoreSpacing.md(context)),
          Row(
            children: [
              Expanded(
                child: Text(
                  l10n.platesReplacementCost(
                    UtilityFormatJod.format(
                      asset.priceJod,
                      suffix: l10n.currencyJod,
                    ),
                  ),
                  style: CoreTypography.caption(
                    context,
                    Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
              WidgetsAppButton(
                label: l10n.platesDetails,
                onPressed: () => context.push(AppRoutePaths.adminPlateEditor),
                variant: WidgetsAppButtonVariant.ghost,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DepositPolicyCard extends StatelessWidget {
  const _DepositPolicyCard({required this.l10n, required this.isAr});

  final AppLocalizations l10n;
  final bool isAr;

  @override
  Widget build(BuildContext context) {
    return WidgetsAppCard(
      title: l10n.depositTrayConfiguration,
      subtitle: l10n.depositConfigurationSubtitle,
      leading: const _IconBubble(
        icon: Icons.account_balance_wallet_outlined,
        color: CoreColors.semanticDeposit,
      ),
      child: Column(
        children: [
          _PolicyLine(
            label: l10n.depositGlobalAmountLabel,
            value: UtilityFormatJod.format(
              MockupCatalog.checkoutPlatedDepositJod,
              suffix: l10n.currencyJod,
            ),
          ),
          _PolicyLine(
            label: l10n.depositReturnWindow,
            value: isAr ? '٤٨ ساعة' : '48 hours',
          ),
          _PolicyLine(
            label: isAr ? 'رسائل تذكير' : 'Return reminders',
            value: l10n.platesEnabled,
          ),
          SizedBox(height: CoreSpacing.md(context)),
          WidgetsAppButton(
            label: l10n.screenDepositConfig,
            onPressed: () => context.push(AppRoutePaths.adminDepositConfig),
            icon: Icons.settings_outlined,
            fullWidth: true,
          ),
        ],
      ),
    );
  }
}

class _BreakageBoard extends ConsumerWidget {
  const _BreakageBoard({required this.l10n, required this.isAr});

  final AppLocalizations l10n;
  final bool isAr;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final plates = ref.watch(adminPlatesProvider);
    return WidgetsAppCard(
      title: l10n.platesRecentBreakage,
      subtitle:
          isAr
              ? 'تتبع الكسر والنقص قبل التسوية.'
              : 'Track breakage and missing items before settlement.',
      leading: const _IconBubble(
        icon: Icons.heart_broken_outlined,
        color: CoreColors.semanticError,
      ),
      child: Column(
        children: [
          for (final report in plates.breakageReports)
            _BreakageRow(report: report, l10n: l10n, isAr: isAr),
          SizedBox(height: CoreSpacing.md(context)),
          WidgetsAppButton(
            label: l10n.platesViewBreakageLog,
            onPressed: () => _showBreakageDialog(context, ref, isAr, l10n),
            variant: WidgetsAppButtonVariant.outline,
            icon: Icons.fact_check_outlined,
            fullWidth: true,
          ),
        ],
      ),
    );
  }

  Future<void> _showBreakageDialog(
    BuildContext context,
    WidgetRef ref,
    bool isAr,
    AppLocalizations l10n,
  ) async {
    final title = TextEditingController(
      text: isAr ? 'كسر صحن' : 'Plate breakage',
    );
    final loss = TextEditingController(text: '24');
    final logged = await showDialog<bool>(
      context: context,
      builder:
          (dialogContext) => AlertDialog(
            title: Text(l10n.platesViewBreakageLog),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: title,
                  decoration: InputDecoration(
                    labelText: isAr ? 'الوصف' : 'Description',
                  ),
                ),
                TextField(
                  controller: loss,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: isAr ? 'الخسارة (د.أ)' : 'Loss (JOD)',
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(dialogContext, false),
                child: Text(isAr ? 'إلغاء' : 'Cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(dialogContext, true),
                child: Text(l10n.actionConfirm),
              ),
            ],
          ),
    );
    if (logged != true) {
      title.dispose();
      loss.dispose();
      return;
    }
    if (!context.mounted) {
      title.dispose();
      loss.dispose();
      return;
    }
    final titleText = title.text;
    final lossJod = double.tryParse(loss.text) ?? 24;
    title.dispose();
    loss.dispose();
    ref.read(adminPlatesProvider.notifier).logBreakage(
      titleEn: titleText,
      titleAr: titleText,
      metaEn: 'Logged from plates board',
      metaAr: 'مسجل من لوحة الصواني',
      lossJod: lossJod,
    );
    UtilityMockFeedback.showSuccess(context, l10n.platesViewBreakageLog);
  }
}

class _RestockBoard extends ConsumerWidget {
  const _RestockBoard({required this.l10n, required this.isAr});

  final AppLocalizations l10n;
  final bool isAr;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final plates = ref.watch(adminPlatesProvider);
    return WidgetsAppCard(
      title: l10n.platesRestockAlert,
      subtitle: l10n.platesRestockBody,
      leading: const _IconBubble(
        icon: Icons.inventory_2_outlined,
        color: CoreColors.brandOlive,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(CoreSpacing.radiusChip),
            child: LinearProgressIndicator(
              value: plates.stockRatio,
              minHeight: 10,
              backgroundColor: const Color(0xFFE9E0CE),
              valueColor: const AlwaysStoppedAnimation<Color>(CoreColors.brandOlive),
            ),
          ),
          SizedBox(height: CoreSpacing.sm(context)),
          Text(
            l10n.platesUnitsProgress(plates.stockUnits, plates.stockCapacity),
            style: CoreTypography.caption(
              context,
              Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          SizedBox(height: CoreSpacing.md(context)),
          WidgetsAppButton(
            label: l10n.platesOrderNow,
            onPressed: () {
              final next = ref.read(adminPlatesProvider.notifier).restock(units: 20);
              UtilityMockFeedback.showSuccess(
                context,
                isAr ? 'المخزون الآن $next' : 'Stock now $next units',
              );
            },
            icon: Icons.shopping_cart_checkout_outlined,
            fullWidth: true,
          ),
        ],
      ),
    );
  }
}

class _BreakageRow extends StatelessWidget {
  const _BreakageRow({
    required this.report,
    required this.l10n,
    required this.isAr,
  });

  final ModelAdminBreakageReport report;
  final AppLocalizations l10n;
  final bool isAr;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: CoreSpacing.sm(context)),
      padding: EdgeInsets.all(CoreSpacing.md(context)),
      decoration: BoxDecoration(
        color: CoreColors.semanticError.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(CoreSpacing.radiusCard),
      ),
      child: Row(
        children: [
          const _IconBubble(
            icon: Icons.broken_image_outlined,
            color: CoreColors.semanticError,
          ),
          SizedBox(width: CoreSpacing.sm(context)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isAr ? report.titleAr : report.titleEn,
                  style: CoreTypography.titleMedium(
                    context,
                    Theme.of(context).colorScheme.onSurface,
                  ).copyWith(fontWeight: FontWeight.w900),
                ),
                Text(
                  '${isAr ? report.metaAr : report.metaEn} · ${isAr ? report.timeAr : report.timeEn}',
                  style: CoreTypography.caption(
                    context,
                    Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          Text(
            UtilityFormatJod.format(report.lossJod, suffix: l10n.currencyJod),
            style: CoreTypography.titleMedium(
              context,
              CoreColors.semanticError,
            ).copyWith(fontWeight: FontWeight.w900),
          ),
        ],
      ),
    );
  }
}

class _MiniStat extends StatelessWidget {
  const _MiniStat({
    required this.label,
    required this.value,
    required this.color,
  });

  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(CoreSpacing.sm(context)),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(CoreSpacing.radiusCard),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: CoreTypography.titleMedium(
              context,
              color,
            ).copyWith(fontWeight: FontWeight.w900),
          ),
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: CoreTypography.caption(
              context,
              Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

class _PolicyLine extends StatelessWidget {
  const _PolicyLine({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: CoreSpacing.sm(context)),
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

class _HeroStat extends StatelessWidget {
  const _HeroStat({
    required this.label,
    required this.value,
    required this.icon,
  });

  final String label;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 172,
      padding: EdgeInsets.all(CoreSpacing.md(context)),
      decoration: BoxDecoration(
        color: CoreColors.surfaceLight.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(CoreSpacing.radiusCard),
        border: Border.all(
          color: CoreColors.surfaceLight.withValues(alpha: 0.30),
        ),
      ),
      child: Row(
        children: [
          Icon(icon, color: CoreColors.surfaceLight),
          SizedBox(width: CoreSpacing.sm(context)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: CoreTypography.titleMedium(
                    context,
                    CoreColors.surfaceLight,
                  ).copyWith(fontWeight: FontWeight.w900),
                ),
                Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: CoreTypography.caption(
                    context,
                    CoreColors.surfaceLight.withValues(alpha: 0.84),
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

class _PlateSketch extends StatelessWidget {
  const _PlateSketch({required this.kind, required this.color});

  final String kind;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 58,
      height: 58,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(CoreSpacing.radiusCard),
      ),
      child: CustomPaint(
        painter: _PlateSketchPainter(kind: kind, color: color),
      ),
    );
  }
}

class _IconBubble extends StatelessWidget {
  const _IconBubble({required this.icon, required this.color});

  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(CoreSpacing.radiusCard),
      ),
      child: Icon(icon, color: color, size: 21),
    );
  }
}

class _SoftBadge extends StatelessWidget {
  const _SoftBadge({required this.label, required this.color, this.foreground});

  final String label;
  final Color color;
  final Color? foreground;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: CoreSpacing.sm(context),
        vertical: CoreSpacing.xs(context),
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: foreground == null ? 0.12 : 1),
        borderRadius: BorderRadius.circular(CoreSpacing.radiusChip),
      ),
      child: Text(
        label,
        style: CoreTypography.caption(
          context,
          foreground ?? color,
        ).copyWith(fontWeight: FontWeight.w900),
      ),
    );
  }
}

class _PlateSketchPainter extends CustomPainter {
  const _PlateSketchPainter({required this.kind, required this.color});

  final String kind;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = CoreColors.surfaceLight
          ..style = PaintingStyle.fill;
    final stroke =
        Paint()
          ..color = color
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2;
    final center = Offset(size.width / 2, size.height / 2);
    if (kind == 'bowl') {
      canvas.drawArc(
        Rect.fromCenter(center: center, width: 34, height: 28),
        0,
        3.14,
        false,
        stroke,
      );
      canvas.drawOval(
        Rect.fromCenter(center: center.translate(0, -4), width: 34, height: 14),
        paint,
      );
      canvas.drawOval(
        Rect.fromCenter(center: center.translate(0, -4), width: 34, height: 14),
        stroke,
      );
      return;
    }
    if (kind == 'mezze') {
      for (final offset in const [
        Offset(-9, -7),
        Offset(10, -5),
        Offset(0, 10),
      ]) {
        canvas.drawCircle(center + offset, 8, paint);
        canvas.drawCircle(center + offset, 8, stroke);
      }
      return;
    }
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(center: center, width: 38, height: 28),
        const Radius.circular(10),
      ),
      paint,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(center: center, width: 38, height: 28),
        const Radius.circular(10),
      ),
      stroke,
    );
  }

  @override
  bool shouldRepaint(covariant _PlateSketchPainter oldDelegate) {
    return oldDelegate.kind != kind || oldDelegate.color != color;
  }
}

String _assetBadge(AppLocalizations l10n, String key) {
  return switch (key) {
    'dineIn' => l10n.orderTypeDineIn,
    'takeaway' => l10n.orderTypeTakeaway,
    _ => l10n.badgePlated,
  };
}

Color _assetColor(String key) {
  return switch (key) {
    'dineIn' => CoreColors.orderTypeDineIn,
    'takeaway' => CoreColors.orderTypeTakeaway,
    _ => CoreColors.orderTypePlated,
  };
}

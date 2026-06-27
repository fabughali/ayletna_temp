import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/data/models/model_saved_address.dart';
import 'package:ayletna_restaurant_app/data/repositories/repository_providers.dart';
import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:ayletna_restaurant_app/navigation/app_route_paths.dart';
import 'package:ayletna_restaurant_app/utilities/utility_mock_feedback.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_bar.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_async_state_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_icon_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_illustration_panel.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_refresh_list.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_screen_layout.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_status_pill.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// PRD [AddressesScreen].
class CustomerAddressesScreen extends ConsumerWidget {
  const CustomerAddressesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    final addressesAsync = ref.watch(savedAddressesProvider);

    return Scaffold(
      appBar: WidgetsAppBar(
        title: l10n.addressesTitle,
        leading: WidgetsIconButton(
          onPressed:
              () =>
                  context.canPop()
                      ? context.pop()
                      : context.go(AppRoutePaths.profile),
          icon: Icons.arrow_back,
          tooltip: MaterialLocalizations.of(context).backButtonTooltip,
        ),
        actions: [
          WidgetsIconButton(
            onPressed: () => context.push(AppRoutePaths.notifications),
            icon: Icons.notifications_outlined,
            tooltip: l10n.screenNotifications,
          ),
        ],
      ),
      body: SafeArea(
        child: WidgetsScreenLayout(
          child: addressesAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error:
                (error, _) => WidgetsAsyncStateCard.error(
                  title: l10n.addressesTitle,
                  message: error.toString(),
                  actionLabel: l10n.actionSave,
                  onAction: () => ref.invalidate(savedAddressesProvider),
                ),
            data:
                (addresses) => WidgetsRefreshList(
                  onRefresh: () async {
                    ref.invalidate(savedAddressesProvider);
                    await ref.read(savedAddressesProvider.future);
                  },
                  child: ListView(
                    children: [
                      SizedBox(height: CoreSpacing.md(context)),
                      WidgetsAppButton(
                        label: l10n.addressesAddNew,
                        onPressed:
                            () => context.push(
                              '${AppRoutePaths.mapPicker}?return=${AppRoutePaths.addresses}',
                            ),
                        icon: Icons.add_location_alt_outlined,
                        fullWidth: true,
                      ),
                      SizedBox(height: CoreSpacing.lg(context)),
                      if (addresses.isEmpty)
                        WidgetsAsyncStateCard.empty(
                          title: l10n.addressesTitle,
                          message: l10n.mapRequiredFields,
                          actionLabel: l10n.addressesAddNew,
                          onAction:
                              () => context.push(
                                '${AppRoutePaths.mapPicker}?return=${AppRoutePaths.addresses}',
                              ),
                        )
                      else
                        for (final address in addresses) ...[
                          _AddressCard(
                            address: address,
                            onDelete: () => _deleteAddress(context, ref, address),
                          ),
                          SizedBox(height: CoreSpacing.md(context)),
                        ],
                      SizedBox(height: CoreSpacing.xxl(context)),
                      const _MapIllustrationCard(),
                      SizedBox(height: CoreSpacing.md(context)),
                      Text(
                        l10n.addressesHelper,
                        textAlign: TextAlign.center,
                        style: CoreTypography.bodyMedium(
                          context,
                          scheme.onSurfaceVariant.withValues(alpha: 0.58),
                        ),
                      ),
                      SizedBox(height: CoreSpacing.xxl(context)),
                    ],
                  ),
                ),
          ),
        ),
      ),
    );
  }

  Future<void> _deleteAddress(
    BuildContext context,
    WidgetRef ref,
    ModelSavedAddress address,
  ) async {
    final l10n = AppLocalizations.of(context)!;
    final isAr = Localizations.localeOf(context).languageCode == 'ar';
    final title = isAr ? address.labelAr : address.labelEn;
    final confirmed = await UtilityMockFeedback.confirm(
      context: context,
      title: l10n.profileDeleteAddressTitle,
      message: '$title\n${l10n.profileDeleteAddressBody}',
      confirmLabel: l10n.addressesDelete,
      cancelLabel: l10n.actionCancel,
      confirmVariant: WidgetsAppButtonVariant.danger,
      icon: Icons.delete_outline,
    );

    if (!confirmed || !context.mounted) return;

    try {
      await ref.read(repositoryAddressProvider).deleteAddress(address.id);
      ref.invalidate(savedAddressesProvider);
      if (!context.mounted) return;
      UtilityMockFeedback.showSuccess(context, l10n.addressesDelete);
    } catch (error) {
      if (!context.mounted) return;
      UtilityMockFeedback.showError(context, l10n.comingSoon);
    }
  }
}

class _AddressCard extends StatelessWidget {
  const _AddressCard({required this.address, required this.onDelete});

  final ModelSavedAddress address;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    final isAr = Localizations.localeOf(context).languageCode == 'ar';
    final title = isAr ? address.labelAr : address.labelEn;
    final body = isAr ? address.addressAr : address.addressEn;
    final isDefault = address.isSelected;

    return WidgetsAppCard(
      accentColor: isDefault ? scheme.secondary : null,
      leading: Icon(
        _addressIcon(address.iconKey),
        color: _addressColor(scheme),
      ),
      title: title,
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          WidgetsIconButton(
            onPressed:
                () => context.push(
                  '${AppRoutePaths.mapPicker}?return=${AppRoutePaths.addresses}',
                ),
            icon: Icons.edit_outlined,
            tooltip: l10n.deliveryEdit,
            variant: WidgetsIconButtonVariant.tonal,
          ),
          SizedBox(width: CoreSpacing.xs(context)),
          WidgetsIconButton(
            onPressed: address.canRemove ? onDelete : null,
            icon: Icons.delete_outline,
            tooltip: l10n.addressesDelete,
            variant: WidgetsIconButtonVariant.tonal,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            body,
            style: CoreTypography.bodyMedium(context, scheme.onSurfaceVariant),
          ),
          if (isDefault) ...[
            SizedBox(height: CoreSpacing.md(context)),
            WidgetsStatusPill(
              label: l10n.addressesDefault,
              color: scheme.secondary,
              compact: true,
            ),
          ],
        ],
      ),
    );
  }

  IconData _addressIcon(String key) {
    return switch (key) {
      'work' => Icons.work_outline,
      'gym' => Icons.location_on_outlined,
      _ => Icons.home_outlined,
    };
  }

  Color _addressColor(ColorScheme scheme) => scheme.primary;
}

class _MapIllustrationCard extends StatelessWidget {
  const _MapIllustrationCard();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return WidgetsIllustrationPanel(
      height: CoreContentSizes.categoryHeroHeight(context) * 0.55,
      child: CustomPaint(
        painter: _AddressMapPainter(
          background: scheme.surfaceContainerHighest,
          road: scheme.surface.withValues(alpha: 0.72),
          roadStrong: scheme.surface.withValues(alpha: 0.92),
          block: scheme.primary.withValues(alpha: 0.08),
        ),
        child: const SizedBox.expand(),
      ),
    );
  }
}

class _AddressMapPainter extends CustomPainter {
  const _AddressMapPainter({
    required this.background,
    required this.road,
    required this.roadStrong,
    required this.block,
  });

  final Color background;
  final Color road;
  final Color roadStrong;
  final Color block;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(Offset.zero & size, Paint()..color = background);

    final blockPaint = Paint()..color = block;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width * 0.32, size.height),
        Radius.circular(CoreSpacing.radiusImage),
      ),
      blockPaint,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(size.width * 0.72, 0, size.width * 0.28, size.height),
        Radius.circular(CoreSpacing.radiusImage),
      ),
      blockPaint,
    );

    final roadPaint =
        Paint()
          ..color = road
          ..strokeWidth = 3;
    final strongRoadPaint =
        Paint()
          ..color = roadStrong
          ..strokeWidth = 5;

    for (var x = -size.width * 0.4; x < size.width * 1.3; x += size.width / 5) {
      canvas.drawLine(
        Offset(x, 0),
        Offset(x + size.width * 0.5, size.height),
        roadPaint,
      );
    }
    for (var x = -size.width * 0.2; x < size.width * 1.2; x += size.width / 4) {
      canvas.drawLine(
        Offset(x, size.height),
        Offset(x + size.width * 0.5, 0),
        roadPaint,
      );
    }
    canvas.drawLine(
      Offset(size.width * 0.12, size.height * 0.18),
      Offset(size.width * 0.88, size.height * 0.82),
      strongRoadPaint,
    );
    canvas.drawLine(
      Offset(size.width * 0.22, size.height * 0.78),
      Offset(size.width * 0.86, size.height * 0.26),
      strongRoadPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _AddressMapPainter oldDelegate) {
    return oldDelegate.background != background ||
        oldDelegate.road != road ||
        oldDelegate.roadStrong != roadStrong ||
        oldDelegate.block != block;
  }
}

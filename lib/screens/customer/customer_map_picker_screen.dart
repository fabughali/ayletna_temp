import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/data/models/model_create_address_request.dart';
import 'package:ayletna_restaurant_app/data/repositories/repository_providers.dart';
import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:ayletna_restaurant_app/navigation/app_route_paths.dart';
import 'package:ayletna_restaurant_app/utilities/utility_mock_feedback.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_bar.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_text_field.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_async_state_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_icon_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_screen_layout.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_status_pill.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// PRD [MapPickerScreen].
class CustomerMapPickerScreen extends ConsumerStatefulWidget {
  const CustomerMapPickerScreen({
    this.returnRoute = AppRoutePaths.cart,
    super.key,
  });

  final String returnRoute;

  @override
  ConsumerState<CustomerMapPickerScreen> createState() =>
      _CustomerMapPickerScreenState();
}

class _CustomerMapPickerScreenState extends ConsumerState<CustomerMapPickerScreen> {
  var _isSaving = false;
  final _titleController = TextEditingController(text: 'Home');
  final _addressController = TextEditingController(
    text: '123 Gastronomy Lane, Central Hub, Amman',
  );
  var _mapSelected = false;

  bool get _canSave =>
      _mapSelected &&
      _titleController.text.trim().isNotEmpty &&
      _addressController.text.trim().isNotEmpty;

  @override
  void dispose() {
    _titleController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: WidgetsAppBar(
        title: l10n.screenMapPicker,
        leading: WidgetsIconButton(
          onPressed:
              () =>
                  context.canPop()
                      ? context.pop()
                      : context.go(widget.returnRoute),
          icon: Icons.arrow_back,
          tooltip: MaterialLocalizations.of(context).backButtonTooltip,
        ),
      ),
      body: SafeArea(
        child: WidgetsScreenLayout(
          child: ListView(
            children: [
              SizedBox(height: CoreSpacing.md(context)),
              WidgetsAppCard(
                variant: WidgetsAppCardVariant.food,
                padding: EdgeInsets.all(CoreSpacing.lg(context)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _CompactMapPreview(
                      selected: _mapSelected,
                      onSelect:
                          () => setState(() {
                            _mapSelected = true;
                          }),
                    ),
                    SizedBox(height: CoreSpacing.lg(context)),
                    WidgetsAppTextField(
                      controller: _titleController,
                      label: l10n.mapAddressTitle,
                      hintText: l10n.mapAddressTitleHint,
                      prefixIcon: Icons.bookmark_border,
                      onChanged: (_) => setState(() {}),
                    ),
                    SizedBox(height: CoreSpacing.md(context)),
                    WidgetsAppTextField(
                      controller: _addressController,
                      label: l10n.mapAddressText,
                      hintText: l10n.mapAddressTextHint,
                      prefixIcon: Icons.edit_location_alt_outlined,
                      maxLines: 3,
                      textInputAction: TextInputAction.newline,
                      onChanged: (_) => setState(() {}),
                    ),
                    SizedBox(height: CoreSpacing.md(context)),
                    WidgetsAppButton(
                      label:
                          _mapSelected
                              ? l10n.mapLocationSelected
                              : l10n.mapSelectOnMap,
                      onPressed: () => setState(() => _mapSelected = true),
                      icon:
                          _mapSelected
                              ? Icons.check_circle_outline
                              : Icons.add_location_alt_outlined,
                      variant: WidgetsAppButtonVariant.outline,
                      fullWidth: true,
                    ),
                    SizedBox(height: CoreSpacing.sm(context)),
                    Text(
                      l10n.mapRequiredFields,
                      style: CoreTypography.caption(
                        context,
                        scheme.onSurfaceVariant,
                      ),
                    ),
                    SizedBox(height: CoreSpacing.lg(context)),
                    WidgetsAppButton(
                      label: l10n.mapSaveAddress,
                      onPressed:
                          _canSave && !_isSaving
                              ? () => _saveAddress(context)
                              : null,
                      icon: Icons.save_outlined,
                      fullWidth: true,
                    ),
                  ],
                ),
              ),
              SizedBox(height: CoreSpacing.xxl(context)),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _saveAddress(BuildContext context) async {
    final l10n = AppLocalizations.of(context)!;
    setState(() => _isSaving = true);
    try {
      await ref.read(repositoryAddressProvider).createAddress(
        ModelCreateAddressRequest(
          label: _titleController.text.trim(),
          addressLine: _addressController.text.trim(),
          setAsDefault: true,
        ),
      );
      ref.invalidate(savedAddressesProvider);
      if (!context.mounted) return;
      UtilityMockFeedback.showSuccess(context, l10n.mapSaveAddress);
      context.go(widget.returnRoute);
    } catch (error) {
      if (!context.mounted) return;
      UtilityMockFeedback.showError(
        context,
        addressActionErrorMessage(l10n, error),
      );
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }
}

class _CompactMapPreview extends StatelessWidget {
  const _CompactMapPreview({required this.selected, required this.onSelect});

  final bool selected;
  final VoidCallback onSelect;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;

    return InkWell(
      borderRadius: BorderRadius.circular(CoreSpacing.radiusImage),
      onTap: onSelect,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(CoreSpacing.radiusImage),
        child: SizedBox(
          height: CoreContentSizes.categoryHeroHeight(context) * 0.72,
          child: Stack(
            fit: StackFit.expand,
            children: [
              CustomPaint(
                painter: _MapGridPainter(
                  background: scheme.secondaryContainer,
                  road: scheme.surface.withValues(alpha: 0.56),
                  roadStrong: scheme.surface.withValues(alpha: 0.78),
                  park: scheme.primaryContainer.withValues(alpha: 0.28),
                ),
              ),
              Center(child: _DeliveryPin(label: l10n.mapDeliveryPin)),
              PositionedDirectional(
                top: CoreSpacing.md(context),
                end: CoreSpacing.md(context),
                child: WidgetsStatusPill(
                  label:
                      selected ? l10n.mapLocationSelected : l10n.mapSelectOnMap,
                  icon:
                      selected
                          ? Icons.check_circle_outline
                          : Icons.touch_app_outlined,
                  color: selected ? CoreColors.semanticSuccess : scheme.primary,
                  compact: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DeliveryPin extends StatelessWidget {
  const _DeliveryPin({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            color: scheme.primary,
            borderRadius: BorderRadius.circular(CoreSpacing.radiusChip),
            border: Border.all(color: scheme.surface, width: 2),
            boxShadow: [
              BoxShadow(
                color: scheme.shadow.withValues(alpha: 0.22),
                blurRadius: CoreSpacing.md(context),
                offset: Offset(0, CoreSpacing.xs(context)),
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: CoreSpacing.md(context),
              vertical: CoreSpacing.xs(context),
            ),
            child: Text(
              label,
              style: CoreTypography.bodyMedium(
                context,
                scheme.onPrimary,
              ).copyWith(fontWeight: FontWeight.w800),
            ),
          ),
        ),
        SizedBox(height: CoreSpacing.sm(context)),
        Icon(
          Icons.location_on,
          color: scheme.primary,
          size: CoreContentSizes.successIcon(context) * 0.72,
        ),
        DecoratedBox(
          decoration: BoxDecoration(
            color: scheme.shadow.withValues(alpha: 0.20),
            borderRadius: BorderRadius.circular(CoreSpacing.radiusChip),
          ),
          child: SizedBox(
            width: CoreSpacing.xl(context),
            height: CoreSpacing.xs(context),
          ),
        ),
      ],
    );
  }
}

class _MapGridPainter extends CustomPainter {
  const _MapGridPainter({
    required this.background,
    required this.road,
    required this.roadStrong,
    required this.park,
  });

  final Color background;
  final Color road;
  final Color roadStrong;
  final Color park;

  @override
  void paint(Canvas canvas, Size size) {
    final bgPaint =
        Paint()
          ..shader = LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [background.withValues(alpha: 0.72), park],
          ).createShader(Offset.zero & size);
    canvas.drawRect(Offset.zero & size, bgPaint);

    final roadPaint =
        Paint()
          ..color = road
          ..strokeWidth = 1.4;
    final strongRoadPaint =
        Paint()
          ..color = roadStrong
          ..strokeWidth = 2.4;

    for (var x = -size.width; x < size.width * 1.6; x += size.width / 9) {
      canvas.drawLine(
        Offset(x, 0),
        Offset(x + size.width * 0.62, size.height),
        roadPaint,
      );
    }
    for (var x = -size.width * 0.5; x < size.width * 1.3; x += size.width / 7) {
      canvas.drawLine(
        Offset(x, size.height),
        Offset(x + size.width * 0.82, 0),
        roadPaint,
      );
    }
    for (var y = size.height * 0.12; y < size.height; y += size.height / 8) {
      canvas.drawLine(
        Offset(0, y),
        Offset(size.width, y - size.height * 0.22),
        strongRoadPaint,
      );
    }

    final blockPaint = Paint()..color = park.withValues(alpha: 0.20);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(
          size.width * 0.05,
          size.height * 0.24,
          size.width * 0.26,
          size.height * 0.18,
        ),
        Radius.circular(CoreSpacing.radiusImage),
      ),
      blockPaint,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(
          size.width * 0.62,
          size.height * 0.12,
          size.width * 0.28,
          size.height * 0.22,
        ),
        Radius.circular(CoreSpacing.radiusImage),
      ),
      blockPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _MapGridPainter oldDelegate) {
    return oldDelegate.background != background ||
        oldDelegate.road != road ||
        oldDelegate.roadStrong != roadStrong ||
        oldDelegate.park != park;
  }
}

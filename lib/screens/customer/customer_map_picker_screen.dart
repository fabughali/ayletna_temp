import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/data/models/model_create_address_request.dart';
import 'package:ayletna_restaurant_app/data/models/model_saved_address.dart';
import 'package:ayletna_restaurant_app/data/repositories/repository_providers.dart';
import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:ayletna_restaurant_app/navigation/app_route_paths.dart';
import 'package:ayletna_restaurant_app/utilities/utility_mock_feedback.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_text_field.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_async_state_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_page_header.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_refresh_list.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_scaffold_page.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_status_pill.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// PRD [MapPickerScreen].
class CustomerMapPickerScreen extends ConsumerStatefulWidget {
  const CustomerMapPickerScreen({
    this.returnRoute = AppRoutePaths.cart,
    this.addressId,
    super.key,
  });

  final String returnRoute;

  /// When set, the screen edits that saved address and prefills its values.
  final String? addressId;

  @override
  ConsumerState<CustomerMapPickerScreen> createState() =>
      _CustomerMapPickerScreenState();
}

class _CustomerMapPickerScreenState
    extends ConsumerState<CustomerMapPickerScreen> {
  var _isSaving = false;
  final _titleController = TextEditingController();
  final _addressController = TextEditingController();
  var _mapSelected = false;
  var _editInitialized = false;
  ModelSavedAddress? _editingAddress;

  bool get _isEditing => widget.addressId != null;

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

  Future<void> _ensureEditPrefill(bool isAr) async {
    final addressId = widget.addressId;
    if (!_isEditing || _editInitialized || addressId == null) return;
    _editInitialized = true;

    final addresses =
        await ref.read(repositoryAddressProvider).fetchSavedAddresses();
    if (!mounted) return;

    ModelSavedAddress? match;
    for (final address in addresses) {
      if (address.id == addressId) {
        match = address;
        break;
      }
    }
    if (match == null) return;

    _editingAddress = match;
    _titleController.text = match.labelForLocale(isAr);
    _addressController.text = match.addressForLocale(isAr);
    setState(() => _mapSelected = true);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    final isAr = Localizations.localeOf(context).languageCode == 'ar';

    if (_isEditing && !_editInitialized) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _ensureEditPrefill(isAr);
      });
    }

    return PopScope(
      canPop: context.canPop(),
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) context.go(widget.returnRoute);
      },
      child: WidgetsScaffoldPage(
        title: l10n.screenMapPicker,
        child: WidgetsRefreshList(
          onRefresh: () async {
            UtilityMockFeedback.showInfo(context, l10n.screenMapPicker);
          },
          child: ListView(
            children: [
              SizedBox(height: CoreSpacing.md(context)),
              WidgetsPageHeader(
                title: l10n.screenMapPicker,
                subtitle: l10n.mapSelectHint,
              ),
              SizedBox(height: CoreSpacing.lg(context)),
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
    final request = ModelCreateAddressRequest(
      label: _titleController.text.trim(),
      addressLine: _addressController.text.trim(),
      iconKey: _editingAddress?.iconKey ?? 'home',
      setAsDefault: _editingAddress?.isSelected ?? true,
      contactName: _editingAddress?.contactName,
      phone: _editingAddress?.phone,
      building: _editingAddress?.building,
      floor: _editingAddress?.floor,
      accessCode: _editingAddress?.accessCode,
      customerAccountId: _editingAddress?.customerAccountId,
    );
    try {
      final repo = ref.read(repositoryAddressProvider);
      final addressId = widget.addressId;
      if (addressId != null) {
        await repo.updateAddress(addressId, request);
      } else {
        await repo.createAddress(request);
      }
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

    return AspectRatio(
      aspectRatio: 16 / 10,
      child: Material(
        color: scheme.surfaceContainerHighest.withValues(alpha: 0.55),
        borderRadius: BorderRadius.circular(CoreSpacing.radiusCardOf(context)),
        child: InkWell(
          onTap: onSelect,
          borderRadius: BorderRadius.circular(CoreSpacing.radiusCardOf(context)),
          child: Stack(
            children: [
              Center(child: _DeliveryPin(label: l10n.mapDeliveryPin)),
              PositionedDirectional(
                start: CoreSpacing.md(context),
                bottom: CoreSpacing.md(context),
                child: WidgetsStatusPill(
                  label:
                      selected
                          ? l10n.mapLocationSelected
                          : l10n.mapSelectOnMap,
                  color: selected ? scheme.secondary : scheme.primary,
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
            shape: BoxShape.circle,
          ),
          child: Padding(
            padding: EdgeInsets.all(CoreSpacing.md(context)),
            child: Icon(
              Icons.location_on,
              color: scheme.onPrimary,
              size: CoreContentSizes.buttonIcon(context),
            ),
          ),
        ),
        SizedBox(height: CoreSpacing.xs(context)),
        Text(
          label,
          style: CoreTypography.caption(
            context,
            scheme.onSurfaceVariant,
          ).copyWith(fontWeight: FontWeight.w700),
        ),
      ],
    );
  }
}

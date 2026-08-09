import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/utilities/utility_sizer.dart';
import 'package:ayletna_restaurant_app/data/models/model_admin_catalog.dart';
import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:ayletna_restaurant_app/providers/admin_catalog_providers.dart';
import 'package:ayletna_restaurant_app/utilities/utility_catalog_images.dart';
import 'package:ayletna_restaurant_app/utilities/utility_confirm_dialog.dart';
import 'package:ayletna_restaurant_app/utilities/utility_format_jod.dart';
import 'package:ayletna_restaurant_app/utilities/utility_mock_feedback.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_text_field.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_catalog_image_editor.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_mock_food_image.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_addon_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_scaffold_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Dedicated marketing add-ons library — max 1 image per add-on.
class AdminAddonsManagementScreen extends ConsumerWidget {
  const AdminAddonsManagementScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final isAr = Localizations.localeOf(context).languageCode == 'ar';

    return WidgetsScaffoldPage(
      title: l10n.screenAddonsManagement,
      child: _AddonsBody(isAr: isAr),
    );
  }
}

class _AddonsBody extends ConsumerStatefulWidget {
  const _AddonsBody({required this.isAr});

  final bool isAr;

  @override
  ConsumerState<_AddonsBody> createState() => _AddonsBodyState();
}

class _AddonsBodyState extends ConsumerState<_AddonsBody> {
  final _key = TextEditingController();
  final _labelAr = TextEditingController();
  final _labelEn = TextEditingController();
  final _price = TextEditingController(text: '0.50');
  List<String> _addonImage = const [];
  bool _expanded = false;

  @override
  void dispose() {
    _key.dispose();
    _labelAr.dispose();
    _labelEn.dispose();
    _price.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    final addons = ref.watch(visibleAddonsProvider);

    return ListView(
      padding: EdgeInsets.all(CoreSpacing.md(context)),
      children: [
        WidgetsAppCard(
          title: l10n.menuCatalogAddAddon,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              WidgetsAppButton(
                label:
                    _expanded
                        ? l10n.actionCancel
                        : l10n.menuCatalogAddAddon,
                variant:
                    _expanded
                        ? WidgetsAppButtonVariant.outline
                        : WidgetsAppButtonVariant.primary,
                icon: _expanded ? Icons.close : Icons.add_outlined,
                onPressed: () => setState(() => _expanded = !_expanded),
              ),
              if (_expanded) ...[
                SizedBox(height: CoreSpacing.md(context)),
                WidgetsAppTextField(
                  controller: _key,
                  label: l10n.catalogCrudAddonKey,
                ),
                SizedBox(height: CoreSpacing.sm(context)),
                WidgetsAppTextField(
                  controller: _labelEn,
                  label: l10n.catalogCrudLabelEn,
                ),
                SizedBox(height: CoreSpacing.sm(context)),
                WidgetsAppTextField(
                  controller: _labelAr,
                  label: l10n.catalogCrudLabelAr,
                ),
                SizedBox(height: CoreSpacing.sm(context)),
                WidgetsAppTextField(
                  controller: _price,
                  label: l10n.catalogCrudPrice,
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: CoreSpacing.sm(context)),
                WidgetsCatalogImageEditor(
                  imageUrls: _addonImage,
                  onChanged: (urls) => setState(() => _addonImage = urls),
                  isAr: widget.isAr,
                  minImages: CatalogImageLimits.addonImages,
                  maxImages: CatalogImageLimits.addonImages,
                ),
                SizedBox(height: CoreSpacing.md(context)),
                WidgetsAppButton(
                  label: l10n.actionAdd,
                  icon: Icons.add_outlined,
                  onPressed: () {
                    if (_addonImage.isEmpty) {
                      UtilityMockFeedback.showWarning(
                        context,
                        l10n.menuCatalogAddonImageRequired,
                      );
                      return;
                    }
                    final ok = ref.read(adminCatalogProvider.notifier).addAddon(
                      ModelMenuAddon(
                        id: nextCatalogId('addon'),
                        key: _key.text,
                        labelAr: _labelAr.text,
                        labelEn: _labelEn.text,
                        priceDeltaJod: double.tryParse(_price.text) ?? 0,
                        imageUrl: _addonImage.first,
                      ),
                    );
                    if (ok) {
                      _key.clear();
                      _labelAr.clear();
                      _labelEn.clear();
                      setState(() {
                        _addonImage = const [];
                        _expanded = false;
                      });
                      UtilityMockFeedback.showSuccess(
                        context,
                        l10n.catalogCrudAdded,
                      );
                    } else {
                      UtilityMockFeedback.showWarning(
                        context,
                        l10n.catalogCrudCheckFields,
                      );
                    }
                  },
                ),
              ],
            ],
          ),
        ),
        SizedBox(height: CoreSpacing.lg(context)),
        for (var i = 0; i < addons.length; i++) ...[
          Stack(
            children: [
              WidgetsAddonCard.fromAddon(
                addon: addons[i],
                title: widget.isAr ? addons[i].labelAr : addons[i].labelEn,
                priceLabel:
                    '${addons[i].key} · ${UtilityFormatJod.format(addons[i].priceDeltaJod, suffix: l10n.currencyJod)}',
                selected: false,
                index: i,
                onTap: () => _editAddon(context, addons[i]),
              ),
              Positioned(
                top: CoreSpacing.sm(context),
                right: CoreSpacing.sm(context),
                child: PopupMenuButton<String>(
                  icon: const Icon(Icons.more_vert),
                  onSelected: (value) {
                    if (value == 'edit') {
                      _editAddon(context, addons[i]);
                    } else if (value == 'delete') {
                      confirmAdminDelete(
                        context,
                        isAr: widget.isAr,
                        onConfirmed: () {
                          ref
                              .read(adminCatalogProvider.notifier)
                              .deleteAddon(addons[i].id);
                          UtilityMockFeedback.showInfo(
                            context,
                            l10n.catalogCrudDeleted,
                          );
                        },
                      );
                    }
                  },
                  itemBuilder:
                      (_) => [
                        PopupMenuItem(
                          value: 'edit',
                          child: Text(l10n.actionEdit),
                        ),
                        PopupMenuItem(
                          value: 'delete',
                          child: Text(l10n.addressesDelete),
                        ),
                      ],
                ),
              ),
            ],
          ),
          SizedBox(height: CoreSpacing.md(context)),
        ],
      ],
    );
  }

  void _editAddon(BuildContext context, ModelMenuAddon addon) {
    final l10n = AppLocalizations.of(context)!;
    final key = TextEditingController(text: addon.key);
    final labelAr = TextEditingController(text: addon.labelAr);
    final labelEn = TextEditingController(text: addon.labelEn);
    final price = TextEditingController(text: addon.priceDeltaJod.toString());
    var imageUrls =
        addon.imageUrl != null && addon.imageUrl!.isNotEmpty
            ? [addon.imageUrl!]
            : <String>[];
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder:
          (ctx) => StatefulBuilder(
            builder:
                (ctx, setSheetState) => Padding(
                  padding: EdgeInsets.only(
                    left: CoreSpacing.lg(ctx),
                    right: CoreSpacing.lg(ctx),
                    top: CoreSpacing.lg(ctx),
                    bottom:
                        MediaQuery.viewInsetsOf(ctx).bottom +
                        CoreSpacing.lg(ctx),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        WidgetsAppTextField(
                          controller: key,
                          label: l10n.catalogCrudAddonKey,
                        ),
                        SizedBox(height: CoreSpacing.sm(ctx)),
                        WidgetsAppTextField(
                          controller: labelEn,
                          label: l10n.catalogCrudLabelEn,
                        ),
                        SizedBox(height: CoreSpacing.sm(ctx)),
                        WidgetsAppTextField(
                          controller: labelAr,
                          label: l10n.catalogCrudLabelAr,
                        ),
                        SizedBox(height: CoreSpacing.sm(ctx)),
                        WidgetsAppTextField(
                          controller: price,
                          label: l10n.catalogCrudPrice,
                          keyboardType: TextInputType.number,
                        ),
                        SizedBox(height: CoreSpacing.sm(ctx)),
                        WidgetsCatalogImageEditor(
                          imageUrls: imageUrls,
                          onChanged:
                              (urls) => setSheetState(() => imageUrls = urls),
                          isAr: widget.isAr,
                          minImages: CatalogImageLimits.addonImages,
                          maxImages: CatalogImageLimits.addonImages,
                        ),
                        SizedBox(height: CoreSpacing.md(ctx)),
                        WidgetsAppButton(
                          label: l10n.actionSave,
                          onPressed: () {
                            if (imageUrls.isEmpty) {
                              UtilityMockFeedback.showWarning(
                                ctx,
                                l10n.menuCatalogAddonImageRequired,
                              );
                              return;
                            }
                            ref.read(adminCatalogProvider.notifier).updateAddon(
                              addon.copyWith(
                                key: key.text,
                                labelAr: labelAr.text,
                                labelEn: labelEn.text,
                                priceDeltaJod:
                                    double.tryParse(price.text) ??
                                    addon.priceDeltaJod,
                                imageUrl: imageUrls.first,
                              ),
                            );
                            Navigator.pop(ctx);
                            UtilityMockFeedback.showSuccess(
                              context,
                              l10n.catalogCrudUpdated,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
          ),
    );
  }
}

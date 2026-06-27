import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/data/mockup/mockup_catalog.dart';
import 'package:ayletna_restaurant_app/data/models/model_menu_item.dart';
import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:ayletna_restaurant_app/navigation/app_route_paths.dart';
import 'package:ayletna_restaurant_app/data/models/model_cart_customization_option.dart';
import 'package:ayletna_restaurant_app/providers/admin_catalog_providers.dart';
import 'package:ayletna_restaurant_app/providers/admin_session_providers.dart';
import 'package:ayletna_restaurant_app/providers/menu_providers.dart';
import 'package:ayletna_restaurant_app/utilities/utility_cart_option_labels.dart';
import 'package:ayletna_restaurant_app/utilities/utility_format_jod.dart';
import 'package:ayletna_restaurant_app/utilities/utility_mock_feedback.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_text_field.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_icon_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_refresh_list.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_scaffold_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// PRD [ProductEditorScreen].
class AdminProductEditorScreen extends ConsumerStatefulWidget {
  const AdminProductEditorScreen({
    super.key,
    this.createMode = false,
    this.productId,
  });

  final bool createMode;
  final String? productId;

  @override
  ConsumerState<AdminProductEditorScreen> createState() =>
      _AdminProductEditorScreenState();
}

class _AdminProductEditorScreenState
    extends ConsumerState<AdminProductEditorScreen> {
  var _available = true;
  var _featured = true;
  var _selectedStation = _PrepStation.shawarma;
  final _selectedModifiers = <String>{};
  String? _imageUrl;
  late final TextEditingController _nameAr;
  late final TextEditingController _nameEn;
  late final TextEditingController _descAr;
  late final TextEditingController _descEn;
  late final TextEditingController _price;

  @override
  void initState() {
    super.initState();
    _nameAr = TextEditingController();
    _nameEn = TextEditingController();
    _descAr = TextEditingController();
    _descEn = TextEditingController();
    _price = TextEditingController(text: widget.createMode ? '5.00' : '');
    if (!widget.createMode && widget.productId != null) {
      final overrides = ref.read(adminMenuProvider).catalogItemOverrides;
      final override = overrides[widget.productId!];
      final item =
          override ??
          MockupCatalog.itemById(widget.productId!) ??
          MockupCatalog.items.first;
      _nameAr.text = item.nameAr;
      _nameEn.text = item.nameEn;
      _descAr.text = item.descriptionAr;
      _descEn.text = item.descriptionEn;
      _price.text = item.priceJod.toStringAsFixed(2);
      _imageUrl = item.imageUrl;
    } else if (!widget.createMode) {
      final item = MockupCatalog.items.firstWhere(
        (candidate) => candidate.id == 'shawarma_meal_super',
        orElse: () => MockupCatalog.items.first,
      );
      _nameAr.text = item.nameAr;
      _nameEn.text = item.nameEn;
      _descAr.text = item.descriptionAr;
      _descEn.text = item.descriptionEn;
      _price.text = item.priceJod.toStringAsFixed(2);
      _imageUrl = item.imageUrl;
    }
  }

  @override
  void dispose() {
    _nameAr.dispose();
    _nameEn.dispose();
    _descAr.dispose();
    _descEn.dispose();
    _price.dispose();
    super.dispose();
  }

  ModelMenuItem _resolveItem() {
    if (widget.createMode) {
      return ModelMenuItem(
        id: 'draft_new',
        categoryId: 'custom',
        nameAr: _nameAr.text,
        nameEn: _nameEn.text,
        priceJod: double.tryParse(_price.text) ?? 0,
        descriptionAr: _descAr.text,
        descriptionEn: _descEn.text,
        imageUrl: _imageUrl,
      );
    }
    final editId = widget.productId;
    if (editId != null) {
      final adminItems = ref.read(adminMenuProvider).addedMenuItems;
      for (final adminItem in adminItems) {
        if (adminItem.id == editId) return adminItem;
      }
      final override = ref.read(adminMenuProvider).catalogItemOverrides[editId];
      if (override != null) return override;
      return MockupCatalog.itemById(editId) ??
          MockupCatalog.items.first;
    }
    return MockupCatalog.items.firstWhere(
      (candidate) => candidate.id == 'shawarma_meal_super',
      orElse: () => MockupCatalog.items.first,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isAr = Localizations.localeOf(context).languageCode == 'ar';
    final item = _resolveItem();

    return WidgetsScaffoldPage(
      title:
          widget.createMode
              ? (isAr ? 'إضافة عنصر منيو' : 'Add menu item')
              : l10n.screenProductEditor,
      actions: [
        WidgetsIconButton(
          onPressed: () => context.push(AppRoutePaths.adminMenu),
          icon: Icons.restaurant_menu_outlined,
          tooltip: l10n.screenMenuManagement,
        ),
        WidgetsIconButton(
          onPressed: () {
            if (widget.createMode) {
              UtilityMockFeedback.showInfo(
                context,
                isAr ? 'احفظ العنصر أولاً' : 'Save the item first',
              );
              return;
            }
            final previewId = widget.productId ?? item.id;
            ref.read(selectedMenuItemIdProvider.notifier).state = previewId;
            context.push(AppRoutePaths.productDetail);
          },
          icon: Icons.visibility_outlined,
          tooltip: isAr ? 'معاينة' : 'Preview',
        ),
      ],
      child: WidgetsRefreshList(
        onRefresh: () async {
          ref.invalidate(menuAllItemsProvider);
          ref.invalidate(visiblePortionOptionsProvider);
        },
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth >= 860;
            final editor = Column(
              children: [
                _IdentityCard(
                  item: item,
                  isAr: isAr,
                  nameAr: _nameAr,
                  nameEn: _nameEn,
                  descAr: _descAr,
                  descEn: _descEn,
                  editable: widget.createMode || widget.productId != null,
                ),
                SizedBox(height: CoreSpacing.lg(context)),
                _PricingAndVariantsCard(
                  item: item,
                  l10n: l10n,
                  isAr: isAr,
                  priceController: _price,
                  editable: widget.createMode || widget.productId != null,
                ),
                SizedBox(height: CoreSpacing.lg(context)),
                _ModifiersCard(
                  selectedModifiers: _selectedModifiers,
                  onChanged:
                      (id, selected) => setState(() {
                        if (selected) {
                          _selectedModifiers.add(id);
                        } else {
                          _selectedModifiers.remove(id);
                        }
                      }),
                  isAr: isAr,
                  l10n: l10n,
                ),
              ],
            );
            final operations = Column(
              children: [
                _MediaCard(
                  item: item,
                  isAr: isAr,
                  imageUrl: _imageUrl ?? item.imageUrl,
                  onUpload: () => _pickImage(context, isAr),
                ),
                SizedBox(height: CoreSpacing.lg(context)),
                _StationCard(
                  selectedStation: _selectedStation,
                  onChanged:
                      (station) => setState(() => _selectedStation = station),
                  isAr: isAr,
                ),
                SizedBox(height: CoreSpacing.lg(context)),
                _AvailabilityCard(
                  available: _available,
                  featured: _featured,
                  onAvailableChanged:
                      (value) => setState(() => _available = value),
                  onFeaturedChanged:
                      (value) => setState(() => _featured = value),
                  isAr: isAr,
                ),
                SizedBox(height: CoreSpacing.lg(context)),
                _SavePanel(
                  l10n: l10n,
                  isAr: isAr,
                  createMode: widget.createMode,
                  nameAr: _nameAr.text,
                  nameEn: _nameEn.text,
                  descAr: _descAr.text,
                  descEn: _descEn.text,
                  priceJod: double.tryParse(_price.text) ?? 0,
                  productId: item.id,
                  imageUrl: _imageUrl,
                ),
              ],
            );

            return ListView(
              padding: EdgeInsetsDirectional.only(
                top: CoreSpacing.md(context),
                bottom: CoreSpacing.xxl(context),
              ),
              children: [
                _EditorHero(item: item, l10n: l10n, isAr: isAr),
                SizedBox(height: CoreSpacing.lg(context)),
                if (isWide)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(flex: 6, child: editor),
                      SizedBox(width: CoreSpacing.lg(context)),
                      Expanded(flex: 4, child: operations),
                    ],
                  )
                else ...[
                  editor,
                  SizedBox(height: CoreSpacing.lg(context)),
                  operations,
                ],
              ],
            );
          },
        ),
      ),
    );
  }

  Future<void> _pickImage(BuildContext context, bool isAr) async {
    final urlController = TextEditingController(text: _imageUrl ?? '');
    final presets =
        MockupCatalog.items
            .map((item) => item.imageUrl)
            .whereType<String>()
            .toSet()
            .take(6)
            .toList();
    final picked = await showDialog<String>(
      context: context,
      builder:
          (dialogContext) => AlertDialog(
            title: Text(isAr ? 'صورة العنصر' : 'Item image'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  WidgetsAppTextField(
                    controller: urlController,
                    label: isAr ? 'رابط الصورة' : 'Image URL',
                    prefixIcon: Icons.link,
                  ),
                  if (presets.isNotEmpty) ...[
                    SizedBox(height: CoreSpacing.md(context)),
                    Text(
                      isAr ? 'صور جاهزة' : 'Preset photos',
                      style: CoreTypography.caption(
                        context,
                        Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                    SizedBox(height: CoreSpacing.sm(context)),
                    Wrap(
                      spacing: CoreSpacing.sm(context),
                      runSpacing: CoreSpacing.sm(context),
                      children: [
                        for (final url in presets)
                          ActionChip(
                            label: Text(url.split('/').last),
                            onPressed: () => Navigator.pop(dialogContext, url),
                          ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(dialogContext),
                child: Text(isAr ? 'إلغاء' : 'Cancel'),
              ),
              TextButton(
                onPressed:
                    () => Navigator.pop(dialogContext, urlController.text.trim()),
                child: Text(isAr ? 'تطبيق' : 'Apply'),
              ),
            ],
          ),
    );
    urlController.dispose();
    if (picked == null || !mounted) return;
    setState(() => _imageUrl = picked.isEmpty ? null : picked);
    if (!context.mounted) return;
    UtilityMockFeedback.showSuccess(
      context,
      isAr ? 'تم تحديث الصورة' : 'Image updated',
    );
  }
}

class _EditorHero extends StatelessWidget {
  const _EditorHero({
    required this.item,
    required this.l10n,
    required this.isAr,
  });

  final ModelMenuItem item;
  final AppLocalizations l10n;
  final bool isAr;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(CoreSpacing.lg(context)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(CoreSpacing.radiusCard),
        gradient: const LinearGradient(
          colors: [CoreColors.brandOlive, CoreColors.brandBrown],
          begin: AlignmentDirectional.topStart,
          end: AlignmentDirectional.bottomEnd,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _SoftBadge(
                  label: isAr ? 'محرر عنصر منيو' : 'Menu Item Editor',
                  color: CoreColors.surfaceLight,
                  foreground: CoreColors.brandBrown,
                ),
                SizedBox(height: CoreSpacing.md(context)),
                Text(
                  isAr
                      ? 'حرر الاسم العربي والإنجليزي، السعر، الأحجام، الإضافات، ومحطة التحضير.'
                      : 'Edit bilingual naming, pricing, variants, modifiers, prep routing, and availability.',
                  style: CoreTypography.headlineSmall(
                    context,
                    CoreColors.surfaceLight,
                  ).copyWith(fontWeight: FontWeight.w900),
                ),
                SizedBox(height: CoreSpacing.sm(context)),
                Text(
                  isAr ? item.nameAr : item.nameEn,
                  style: CoreTypography.bodyMedium(
                    context,
                    CoreColors.surfaceLight.withValues(alpha: 0.86),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: CoreSpacing.md(context)),
          _FoodPreview(color: CoreColors.surfaceLight, compact: true),
        ],
      ),
    );
  }
}

class _IdentityCard extends StatelessWidget {
  const _IdentityCard({
    required this.item,
    required this.isAr,
    this.nameAr,
    this.nameEn,
    this.descAr,
    this.descEn,
    this.editable = false,
  });

  final ModelMenuItem item;
  final bool isAr;
  final TextEditingController? nameAr;
  final TextEditingController? nameEn;
  final TextEditingController? descAr;
  final TextEditingController? descEn;
  final bool editable;

  @override
  Widget build(BuildContext context) {
    return WidgetsAppCard(
      title: isAr ? 'الاسم والوصف' : 'Name & Description',
      subtitle:
          isAr
              ? 'النصوص التي تظهر للعميل في المنيو.'
              : 'Customer-facing copy shown in the menu.',
      leading: const _IconBubble(
        icon: Icons.translate_outlined,
        color: CoreColors.brandOlive,
      ),
      child: Column(
        children: [
          WidgetsAppTextField(
            label: isAr ? 'الاسم بالعربية' : 'Arabic name',
            controller: editable ? nameAr : null,
            initialValue: editable ? null : item.nameAr,
            prefixIcon: Icons.language_outlined,
          ),
          SizedBox(height: CoreSpacing.md(context)),
          WidgetsAppTextField(
            label: isAr ? 'الاسم بالإنجليزية' : 'English name',
            controller: editable ? nameEn : null,
            initialValue: editable ? null : item.nameEn,
            prefixIcon: Icons.abc_outlined,
          ),
          SizedBox(height: CoreSpacing.md(context)),
          WidgetsAppTextField(
            label: isAr ? 'الوصف بالعربية' : 'Arabic description',
            controller: editable ? descAr : null,
            initialValue: editable ? null : item.descriptionAr,
            prefixIcon: Icons.notes_outlined,
            maxLines: 3,
          ),
          SizedBox(height: CoreSpacing.md(context)),
          WidgetsAppTextField(
            label: isAr ? 'الوصف بالإنجليزية' : 'English description',
            controller: editable ? descEn : null,
            initialValue: editable ? null : item.descriptionEn,
            prefixIcon: Icons.notes_outlined,
            maxLines: 3,
          ),
        ],
      ),
    );
  }
}

class _PricingAndVariantsCard extends ConsumerWidget {
  const _PricingAndVariantsCard({
    required this.item,
    required this.l10n,
    required this.isAr,
    this.priceController,
    this.editable = false,
  });

  final ModelMenuItem item;
  final AppLocalizations l10n;
  final bool isAr;
  final TextEditingController? priceController;
  final bool editable;

  static const _variantColors = [
    CoreColors.brandOlive,
    CoreColors.brandOrange,
    CoreColors.orderTypeDelivery,
    CoreColors.brandGold,
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final portions = ref.watch(visiblePortionOptionsProvider);

    return WidgetsAppCard(
      title: isAr ? 'السعر والأحجام' : 'Pricing & Variants',
      subtitle:
          isAr
              ? 'أحجام الحصة من الكatalog — تظهر للعميل في التفاصيل والسلة.'
              : 'Portion sizes from catalog — shown on detail and cart sheets.',
      leading: const _IconBubble(
        icon: Icons.sell_outlined,
        color: CoreColors.semanticRevenue,
      ),
      child: Column(
        children: [
          WidgetsAppTextField(
            label: isAr ? 'السعر الأساسي' : 'Base price',
            controller: editable ? priceController : null,
            initialValue:
                editable
                    ? null
                    : UtilityFormatJod.format(
                      item.priceJod,
                      suffix: l10n.currencyJod,
                    ),
            prefixIcon: Icons.payments_outlined,
            keyboardType: TextInputType.number,
          ),
          SizedBox(height: CoreSpacing.md(context)),
          for (var index = 0; index < portions.length; index++)
            _VariantRow(
              label: cartOptionLabel(portions[index].key, l10n),
              price: UtilityFormatJod.format(
                item.priceJod + portions[index].priceDeltaJod,
                suffix: l10n.currencyJod,
              ),
              color: _variantColors[index % _variantColors.length],
            ),
          SizedBox(height: CoreSpacing.sm(context)),
          WidgetsAppButton(
            label: isAr ? 'إضافة حجم / نوع' : 'Add variant',
            onPressed: () => _showAddVariantDialog(context, ref),
            variant: WidgetsAppButtonVariant.outline,
            icon: Icons.add,
            fullWidth: true,
          ),
        ],
      ),
    );
  }

  Future<void> _showAddVariantDialog(BuildContext context, WidgetRef ref) async {
    final keyController = TextEditingController();
    final priceController = TextEditingController(text: '0');
    final added = await showDialog<bool>(
      context: context,
      builder:
          (dialogContext) => AlertDialog(
            title: Text(isAr ? 'إضافة حجم' : 'Add portion size'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                WidgetsAppTextField(
                  controller: keyController,
                  label: isAr ? 'المفتاح (مثل super)' : 'Key (e.g. super)',
                ),
                SizedBox(height: CoreSpacing.md(context)),
                WidgetsAppTextField(
                  controller: priceController,
                  label: isAr ? 'فرق السعر (د.أ)' : 'Price delta (JOD)',
                  keyboardType: TextInputType.number,
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
    if (added != true || !context.mounted) {
      keyController.dispose();
      priceController.dispose();
      return;
    }
    final key = keyController.text.trim().toLowerCase().replaceAll(' ', '_');
    final delta = double.tryParse(priceController.text.trim()) ?? 0;
    keyController.dispose();
    priceController.dispose();
    if (key.isEmpty) {
      UtilityMockFeedback.showWarning(
        context,
        isAr ? 'أدخل مفتاحاً للحجم' : 'Enter a portion key',
      );
      return;
    }
    final ok = ref
        .read(adminCatalogProvider.notifier)
        .addPortionOption(
          ModelCartCustomizationOption(key: key, priceDeltaJod: delta),
        );
    if (!context.mounted) return;
    UtilityMockFeedback.showSuccess(
      context,
      ok
          ? (isAr ? 'تمت إضافة الحجم' : 'Portion added')
          : (isAr ? 'المفتاح موجود مسبقاً' : 'Key already exists'),
    );
  }
}

class _ModifiersCard extends ConsumerWidget {
  const _ModifiersCard({
    required this.selectedModifiers,
    required this.onChanged,
    required this.isAr,
    required this.l10n,
  });

  final Set<String> selectedModifiers;
  final void Function(String id, bool selected) onChanged;
  final bool isAr;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final addons = ref.watch(visibleAddonsProvider);
    return WidgetsAppCard(
      title: isAr ? 'الإضافات والتعديلات' : 'Modifiers',
      subtitle:
          isAr
              ? 'إضافات اختيارية تظهر في الكاشير والعميل.'
              : 'Optional choices shown to cashier and guest.',
      leading: const _IconBubble(
        icon: Icons.tune_outlined,
        color: CoreColors.orderTypeTakeaway,
      ),
      child: Column(
        children: [
          if (addons.isEmpty)
            Text(
              isAr ? 'لا توجد إضافات بعد.' : 'No catalog addons yet.',
              style: CoreTypography.bodyMedium(
                context,
                Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            )
          else
            for (final addon in addons)
              _ModifierRow(
                data: _ModifierData(
                  id: addon.key,
                  labelAr: addon.labelAr,
                  labelEn: addon.labelEn,
                  priceJod: addon.priceDeltaJod,
                ),
                selected: selectedModifiers.contains(addon.key),
                onChanged: (value) => onChanged(addon.key, value),
                isAr: isAr,
                l10n: l10n,
              ),
        ],
      ),
    );
  }
}

class _MediaCard extends StatelessWidget {
  const _MediaCard({
    required this.item,
    required this.isAr,
    required this.imageUrl,
    required this.onUpload,
  });

  final ModelMenuItem item;
  final bool isAr;
  final String? imageUrl;
  final VoidCallback onUpload;

  @override
  Widget build(BuildContext context) {
    return WidgetsAppCard(
      title: isAr ? 'الصورة والعرض' : 'Media & Display',
      subtitle:
          isAr
              ? 'صورة طعام دافئة بدل بطاقة إخبارية.'
              : 'Warm food media, not a generic card.',
      leading: const _IconBubble(
        icon: Icons.image_outlined,
        color: CoreColors.brandOrange,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (imageUrl != null && imageUrl!.isNotEmpty)
            ClipRRect(
              borderRadius: BorderRadius.circular(CoreSpacing.radiusCard),
              child: Image.network(
                imageUrl!,
                height: CoreContentSizes.heroImageHeight(context) * 0.45,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => _FoodPreview(color: CoreColors.brandOrange),
              ),
            )
          else
            _FoodPreview(color: CoreColors.brandOrange),
          SizedBox(height: CoreSpacing.md(context)),
          Text(
            isAr ? item.nameAr : item.nameEn,
            style: CoreTypography.titleMedium(
              context,
              Theme.of(context).colorScheme.onSurface,
            ).copyWith(fontWeight: FontWeight.w900),
          ),
          SizedBox(height: CoreSpacing.xs(context)),
          Text(
            isAr
                ? 'صورة رئيسية • بطاقة المنيو • نقطة البيع'
                : 'Hero image • menu card • POS tile',
            style: CoreTypography.caption(
              context,
              Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          SizedBox(height: CoreSpacing.md(context)),
          WidgetsAppButton(
            label: isAr ? 'رفع / تغيير الصورة' : 'Upload / change image',
            onPressed: onUpload,
            icon: Icons.cloud_upload_outlined,
            variant: WidgetsAppButtonVariant.outline,
          ),
        ],
      ),
    );
  }
}

class _StationCard extends StatelessWidget {
  const _StationCard({
    required this.selectedStation,
    required this.onChanged,
    required this.isAr,
  });

  final _PrepStation selectedStation;
  final ValueChanged<_PrepStation> onChanged;
  final bool isAr;

  @override
  Widget build(BuildContext context) {
    return WidgetsAppCard(
      title: isAr ? 'محطة التحضير' : 'Prep Station',
      subtitle:
          isAr
              ? 'تحدد أين تظهر التذكرة في المطبخ.'
              : 'Controls where the kitchen ticket appears.',
      leading: const _IconBubble(
        icon: Icons.soup_kitchen_outlined,
        color: CoreColors.brandBrown,
      ),
      child: Column(
        children: [
          for (final station in _PrepStation.values)
            _StationOption(
              station: station,
              selected: station == selectedStation,
              onTap: () => onChanged(station),
              isAr: isAr,
            ),
        ],
      ),
    );
  }
}

class _AvailabilityCard extends StatelessWidget {
  const _AvailabilityCard({
    required this.available,
    required this.featured,
    required this.onAvailableChanged,
    required this.onFeaturedChanged,
    required this.isAr,
  });

  final bool available;
  final bool featured;
  final ValueChanged<bool> onAvailableChanged;
  final ValueChanged<bool> onFeaturedChanged;
  final bool isAr;

  @override
  Widget build(BuildContext context) {
    return WidgetsAppCard(
      title: isAr ? 'التوفر والقنوات' : 'Availability & Channels',
      subtitle:
          isAr
              ? 'تحكم في ظهور العنصر حسب القناة.'
              : 'Control where this item is visible.',
      leading: const _IconBubble(
        icon: Icons.toggle_on_outlined,
        color: CoreColors.semanticSuccess,
      ),
      child: Column(
        children: [
          _SwitchLine(
            label: isAr ? 'متاح للبيع الآن' : 'Available now',
            value: available,
            onChanged: onAvailableChanged,
          ),
          _SwitchLine(
            label: isAr ? 'مميز في المنيو' : 'Featured in menu',
            value: featured,
            onChanged: onFeaturedChanged,
          ),
          SizedBox(height: CoreSpacing.sm(context)),
          Wrap(
            spacing: CoreSpacing.xs(context),
            runSpacing: CoreSpacing.xs(context),
            children: [
              _SoftBadge(
                label: isAr ? 'صالة' : 'Dine-in',
                color: CoreColors.orderTypeDineIn,
              ),
              _SoftBadge(
                label: isAr ? 'سفري' : 'Takeaway',
                color: CoreColors.orderTypeTakeaway,
              ),
              _SoftBadge(
                label: isAr ? 'توصيل' : 'Delivery',
                color: CoreColors.orderTypeDelivery,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SavePanel extends ConsumerWidget {
  const _SavePanel({
    required this.l10n,
    required this.isAr,
    required this.createMode,
    required this.nameAr,
    required this.nameEn,
    required this.descAr,
    required this.descEn,
    required this.priceJod,
    required this.productId,
    this.imageUrl,
  });

  final AppLocalizations l10n;
  final bool isAr;
  final bool createMode;
  final String nameAr;
  final String nameEn;
  final String descAr;
  final String descEn;
  final double priceJod;
  final String productId;
  final String? imageUrl;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return WidgetsAppCard(
      title: isAr ? 'حفظ ونشر' : 'Save & Publish',
      subtitle:
          createMode
              ? (isAr ? 'أنشئ العنصر ثم انشره على المنيو.' : 'Create then publish to the menu.')
              : (isAr
                  ? 'يحفظ التعديلات على عناصر الكatalog والعناصر المخصصة.'
                  : 'Persists edits to catalog and custom menu items.'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          WidgetsAppButton(
            label: l10n.actionSave,
            onPressed: () {
              final savedItem = ModelMenuItem(
                id: productId,
                categoryId: 'custom',
                nameAr: nameAr,
                nameEn: nameEn,
                priceJod: priceJod,
                descriptionAr: descAr,
                descriptionEn: descEn,
                imageUrl: imageUrl,
              );
              var ok = false;
              if (productId.startsWith('menu_custom_')) {
                ok = ref.read(adminMenuProvider.notifier).updateAddedMenuItem(savedItem);
              } else if (!createMode && productId.isNotEmpty && productId != 'draft_new') {
                ok = ref.read(adminMenuProvider.notifier).upsertCatalogItemOverride(savedItem);
              } else if (createMode) {
                ok = nameEn.trim().isNotEmpty && priceJod > 0;
              }
              if (!ok) {
                UtilityMockFeedback.showWarning(
                  context,
                  isAr ? 'تحقق من الحقول' : 'Check required fields',
                );
                return;
              }
              UtilityMockFeedback.showSuccess(
                context,
                isAr ? 'تم حفظ عنصر المنيو' : 'Menu item saved',
              );
            },
            icon: Icons.save_outlined,
          ),
          SizedBox(height: CoreSpacing.sm(context)),
          WidgetsAppButton(
            label: isAr ? 'نشر على المنيو' : 'Publish to menu',
            onPressed:
                () => UtilityMockFeedback.showActionSheet(
                  context: context,
                  title: isAr ? 'نشر عنصر المنيو' : 'Publish menu item',
                  message:
                      isAr
                          ? 'سيظهر العنصر في قنوات البيع المحددة.'
                          : 'The item will appear in selected sales channels.',
                  actions: [
                    MockSheetAction(
                      label: l10n.actionConfirm,
                      icon: Icons.publish_outlined,
                      onSelected: () {
                        if (createMode) {
                          final created = ref
                              .read(adminMenuProvider.notifier)
                              .addMenuItem(
                                nameAr: nameAr,
                                nameEn: nameEn,
                                descriptionAr: descAr,
                                descriptionEn: descEn,
                                priceJod: priceJod,
                              );
                          if (created == null) {
                            UtilityMockFeedback.showWarning(
                              context,
                              isAr ? 'تحقق من الاسم والسعر' : 'Check name and price',
                            );
                            return;
                          }
                        } else {
                          ref
                              .read(adminMenuProvider.notifier)
                              .publishProduct(
                                productId.startsWith('menu_custom_')
                                    ? productId
                                    : productId,
                              );
                        }
                        UtilityMockFeedback.showSuccess(
                          context,
                          isAr ? 'تم النشر' : 'Published',
                        );
                        context.push(AppRoutePaths.adminMenu);
                      },
                    ),
                  ],
                ),
            icon: Icons.publish_outlined,
            variant: WidgetsAppButtonVariant.secondary,
          ),
          SizedBox(height: CoreSpacing.sm(context)),
          WidgetsAppButton(
            label: isAr ? 'رجوع لإدارة المنيو' : 'Back to menu management',
            onPressed: () => context.push(AppRoutePaths.adminMenu),
            icon: Icons.arrow_back,
            variant: WidgetsAppButtonVariant.outline,
          ),
        ],
      ),
    );
  }
}

class _VariantRow extends StatelessWidget {
  const _VariantRow({
    required this.label,
    required this.price,
    required this.color,
  });

  final String label;
  final String price;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: CoreSpacing.sm(context)),
      padding: EdgeInsets.all(CoreSpacing.md(context)),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(CoreSpacing.radiusCard),
      ),
      child: Row(
        children: [
          _SoftBadge(label: label, color: color),
          SizedBox(width: CoreSpacing.sm(context)),
          Expanded(
            child: Text(
              price,
              textAlign: TextAlign.end,
              style: CoreTypography.titleMedium(
                context,
                Theme.of(context).colorScheme.onSurface,
              ).copyWith(fontWeight: FontWeight.w900),
            ),
          ),
        ],
      ),
    );
  }
}

class _ModifierRow extends StatelessWidget {
  const _ModifierRow({
    required this.data,
    required this.selected,
    required this.onChanged,
    required this.isAr,
    required this.l10n,
  });

  final _ModifierData data;
  final bool selected;
  final ValueChanged<bool> onChanged;
  final bool isAr;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      value: selected,
      onChanged: (value) => onChanged(value ?? false),
      contentPadding: EdgeInsets.zero,
      title: Text(isAr ? data.labelAr : data.labelEn),
      subtitle: Text(
        UtilityFormatJod.format(data.priceJod, suffix: l10n.currencyJod),
      ),
    );
  }
}

class _StationOption extends StatelessWidget {
  const _StationOption({
    required this.station,
    required this.selected,
    required this.onTap,
    required this.isAr,
  });

  final _PrepStation station;
  final bool selected;
  final VoidCallback onTap;
  final bool isAr;

  @override
  Widget build(BuildContext context) {
    final color = selected ? CoreColors.brandOlive : CoreColors.brandBrown;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(CoreSpacing.radiusCard),
      child: Container(
        margin: EdgeInsets.only(bottom: CoreSpacing.sm(context)),
        padding: EdgeInsets.all(CoreSpacing.md(context)),
        decoration: BoxDecoration(
          color: color.withValues(alpha: selected ? 0.12 : 0.06),
          borderRadius: BorderRadius.circular(CoreSpacing.radiusCard),
          border: Border.all(
            color: color.withValues(alpha: selected ? 0.35 : 0.14),
          ),
        ),
        child: Row(
          children: [
            Icon(
              selected ? Icons.radio_button_checked : Icons.radio_button_off,
              color: color,
            ),
            SizedBox(width: CoreSpacing.sm(context)),
            Expanded(
              child: Text(
                station.label(isAr),
                style: CoreTypography.titleMedium(
                  context,
                  Theme.of(context).colorScheme.onSurface,
                ).copyWith(fontWeight: FontWeight.w800),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SwitchLine extends StatelessWidget {
  const _SwitchLine({
    required this.label,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(
        label,
        style: CoreTypography.titleMedium(
          context,
          Theme.of(context).colorScheme.onSurface,
        ).copyWith(fontWeight: FontWeight.w800),
      ),
      value: value,
      activeColor: CoreColors.brandOlive,
      onChanged: onChanged,
    );
  }
}

class _FoodPreview extends StatelessWidget {
  const _FoodPreview({required this.color, this.compact = false});

  final Color color;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(CoreSpacing.radiusCard),
      child: SizedBox(
        width: compact ? 96 : double.infinity,
        height: compact ? 96 : CoreContentSizes.heroImageHeight(context) * 0.58,
        child: CustomPaint(
          painter: _MenuItemPainter(color: color),
          child: Align(
            alignment: AlignmentDirectional.bottomStart,
            child: Padding(
              padding: EdgeInsets.all(CoreSpacing.md(context)),
              child: Icon(
                Icons.restaurant_menu_outlined,
                color:
                    compact ? CoreColors.brandBrown : CoreColors.surfaceLight,
                size: compact ? 28 : 42,
              ),
            ),
          ),
        ),
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
      width: 42,
      height: 42,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(CoreSpacing.radiusCard),
      ),
      child: Icon(icon, color: color, size: 22),
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

class _MenuItemPainter extends CustomPainter {
  const _MenuItemPainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final bg =
        Paint()
          ..shader = LinearGradient(
            colors: [color.withValues(alpha: 0.28), CoreColors.brandBrown],
            begin: AlignmentDirectional.topStart,
            end: AlignmentDirectional.bottomEnd,
          ).createShader(Offset.zero & size);
    canvas.drawRect(Offset.zero & size, bg);

    final plate =
        Paint()
          ..color = CoreColors.surfaceLight.withValues(alpha: 0.92)
          ..style = PaintingStyle.fill;
    final center = Offset(size.width * 0.58, size.height * 0.46);
    canvas.drawOval(
      Rect.fromCenter(
        center: center,
        width: size.width * 0.52,
        height: size.height * 0.32,
      ),
      plate,
    );

    final garnish =
        Paint()
          ..color = CoreColors.brandOlive.withValues(alpha: 0.86)
          ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(center.dx - 18, center.dy - 2), 9, garnish);
    canvas.drawCircle(
      Offset(center.dx + 14, center.dy + 4),
      11,
      Paint()..color = CoreColors.brandOrange.withValues(alpha: 0.90),
    );
  }

  @override
  bool shouldRepaint(covariant _MenuItemPainter oldDelegate) {
    return oldDelegate.color != color;
  }
}

class _ModifierData {
  const _ModifierData({
    required this.id,
    required this.labelAr,
    required this.labelEn,
    required this.priceJod,
  });

  final String id;
  final String labelAr;
  final String labelEn;
  final double priceJod;
}

enum _PrepStation {
  shawarma,
  fryer,
  coldPrep,
  drinks;

  String label(bool isAr) {
    return switch (this) {
      _PrepStation.shawarma => isAr ? 'محطة الشاورما' : 'Shawarma station',
      _PrepStation.fryer => isAr ? 'محطة المقالي' : 'Fryer station',
      _PrepStation.coldPrep => isAr ? 'تحضير بارد' : 'Cold prep',
      _PrepStation.drinks => isAr ? 'المشروبات' : 'Drinks',
    };
  }
}

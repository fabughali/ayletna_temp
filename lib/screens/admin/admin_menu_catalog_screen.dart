import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/data/mockup/mockup_catalog.dart';
import 'package:ayletna_restaurant_app/data/models/model_admin_catalog.dart';
import 'package:ayletna_restaurant_app/data/models/model_menu_category.dart';
import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:ayletna_restaurant_app/navigation/app_route_paths.dart';
import 'package:ayletna_restaurant_app/providers/admin_catalog_providers.dart';
import 'package:ayletna_restaurant_app/utilities/utility_confirm_dialog.dart';
import 'package:ayletna_restaurant_app/utilities/utility_mock_feedback.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_text_field.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_icon_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_scaffold_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Admin CRUD for menu categories, addons, and related products.
class AdminMenuCatalogScreen extends ConsumerWidget {
  const AdminMenuCatalogScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final isAr = Localizations.localeOf(context).languageCode == 'ar';

    return DefaultTabController(
      length: 3,
      child: WidgetsScaffoldPage(
        title: isAr ? 'فهرس المنيو' : 'Menu Catalog',
        actions: [
          WidgetsIconButton(
            onPressed: () => context.push(AppRoutePaths.adminMenu),
            icon: Icons.restaurant_menu_outlined,
            tooltip: l10n.screenMenuManagement,
          ),
        ],
        child: Column(
          children: [
            TabBar(
              tabs: [
                Tab(text: isAr ? 'الفئات' : 'Categories'),
                Tab(text: isAr ? 'الإضافات' : 'Addons'),
                Tab(text: isAr ? 'منتجات مرتبطة' : 'Related'),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  _CategoriesTab(isAr: isAr),
                  _AddonsTab(isAr: isAr),
                  _RelatedProductsTab(isAr: isAr),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CategoriesTab extends ConsumerStatefulWidget {
  const _CategoriesTab({required this.isAr});

  final bool isAr;

  @override
  ConsumerState<_CategoriesTab> createState() => _CategoriesTabState();
}

class _CategoriesTabState extends ConsumerState<_CategoriesTab> {
  final _nameAr = TextEditingController();
  final _nameEn = TextEditingController();
  final _iconKey = TextEditingController(text: 'custom');

  @override
  void dispose() {
    _nameAr.dispose();
    _nameEn.dispose();
    _iconKey.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final categories = ref.watch(visibleCategoriesProvider);

    return ListView(
      padding: EdgeInsets.all(CoreSpacing.lg(context)),
      children: [
        _AddFormCard(
          title: widget.isAr ? 'إضافة فئة' : 'Add category',
          isAr: widget.isAr,
          onSubmit: () {
            final ok = ref.read(adminCatalogProvider.notifier).addCategory(
              ModelMenuCategory(
                id: nextCatalogId('cat'),
                nameAr: _nameAr.text,
                nameEn: _nameEn.text,
                iconKey: _iconKey.text,
              ),
            );
            if (ok) {
              _nameAr.clear();
              _nameEn.clear();
              UtilityMockFeedback.showSuccess(context, widget.isAr ? 'تمت الإضافة' : 'Added');
            } else {
              UtilityMockFeedback.showWarning(
                context,
                widget.isAr ? 'تحقق من الحقول' : 'Check required fields',
              );
            }
          },
          fields: [
            WidgetsAppTextField(controller: _nameEn, label: widget.isAr ? 'الاسم EN' : 'Name EN'),
            SizedBox(height: CoreSpacing.sm(context)),
            WidgetsAppTextField(controller: _nameAr, label: widget.isAr ? 'الاسم AR' : 'Name AR'),
            SizedBox(height: CoreSpacing.sm(context)),
            WidgetsAppTextField(controller: _iconKey, label: widget.isAr ? 'مفتاح الأيقونة' : 'Icon key'),
          ],
        ),
        for (final category in categories)
          _CatalogListTile(
            title: widget.isAr ? category.nameAr : category.nameEn,
            subtitle: category.id,
            isAr: widget.isAr,
            onEdit: () => _editCategory(context, category),
            onDelete: () {
              confirmAdminDelete(
                context,
                isAr: widget.isAr,
                onConfirmed: () {
                  ref.read(adminCatalogProvider.notifier).deleteCategory(category.id);
                  UtilityMockFeedback.showInfo(context, widget.isAr ? 'تم الحذف' : 'Deleted');
                },
              );
            },
          ),
      ],
    );
  }

  void _editCategory(BuildContext context, ModelMenuCategory category) {
    final nameAr = TextEditingController(text: category.nameAr);
    final nameEn = TextEditingController(text: category.nameEn);
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder:
          (ctx) => Padding(
            padding: EdgeInsets.all(CoreSpacing.lg(ctx)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                WidgetsAppTextField(controller: nameEn, label: 'Name EN'),
                SizedBox(height: CoreSpacing.sm(ctx)),
                WidgetsAppTextField(controller: nameAr, label: 'Name AR'),
                SizedBox(height: CoreSpacing.md(ctx)),
                WidgetsAppButton(
                  label: widget.isAr ? 'حفظ' : 'Save',
                  onPressed: () {
                    ref.read(adminCatalogProvider.notifier).updateCategory(
                      category.copyWith(nameAr: nameAr.text, nameEn: nameEn.text),
                    );
                    Navigator.pop(ctx);
                  },
                ),
              ],
            ),
          ),
    );
  }
}

class _AddonsTab extends ConsumerStatefulWidget {
  const _AddonsTab({required this.isAr});

  final bool isAr;

  @override
  ConsumerState<_AddonsTab> createState() => _AddonsTabState();
}

class _AddonsTabState extends ConsumerState<_AddonsTab> {
  final _key = TextEditingController();
  final _labelAr = TextEditingController();
  final _labelEn = TextEditingController();
  final _price = TextEditingController(text: '0.50');

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
    final addons = ref.watch(visibleAddonsProvider);

    return ListView(
      padding: EdgeInsets.all(CoreSpacing.lg(context)),
      children: [
        _AddFormCard(
          title: widget.isAr ? 'إضافة addon' : 'Add addon',
          isAr: widget.isAr,
          onSubmit: () {
            final ok = ref.read(adminCatalogProvider.notifier).addAddon(
              ModelMenuAddon(
                id: nextCatalogId('addon'),
                key: _key.text,
                labelAr: _labelAr.text,
                labelEn: _labelEn.text,
                priceDeltaJod: double.tryParse(_price.text) ?? 0,
              ),
            );
            if (ok) {
              _key.clear();
              _labelAr.clear();
              _labelEn.clear();
              UtilityMockFeedback.showSuccess(context, widget.isAr ? 'تمت الإضافة' : 'Added');
            } else {
              UtilityMockFeedback.showWarning(
                context,
                widget.isAr ? 'تحقق من الحقول' : 'Check required fields',
              );
            }
          },
          fields: [
            WidgetsAppTextField(controller: _key, label: 'Key'),
            SizedBox(height: CoreSpacing.sm(context)),
            WidgetsAppTextField(controller: _labelEn, label: 'Label EN'),
            SizedBox(height: CoreSpacing.sm(context)),
            WidgetsAppTextField(controller: _labelAr, label: 'Label AR'),
            SizedBox(height: CoreSpacing.sm(context)),
            WidgetsAppTextField(controller: _price, label: widget.isAr ? 'السعر' : 'Price', keyboardType: TextInputType.number),
          ],
        ),
        for (final addon in addons)
          _CatalogListTile(
            title: widget.isAr ? addon.labelAr : addon.labelEn,
            subtitle: '${addon.key} • +${addon.priceDeltaJod} JOD',
            isAr: widget.isAr,
            onEdit: () => _editAddon(context, addon),
            onDelete: () {
              confirmAdminDelete(
                context,
                isAr: widget.isAr,
                onConfirmed: () {
                  ref.read(adminCatalogProvider.notifier).deleteAddon(addon.id);
                  UtilityMockFeedback.showInfo(context, widget.isAr ? 'تم الحذف' : 'Deleted');
                },
              );
            },
          ),
      ],
    );
  }

  void _editAddon(BuildContext context, ModelMenuAddon addon) {
    final price = TextEditingController(text: addon.priceDeltaJod.toString());
    final labelEn = TextEditingController(text: addon.labelEn);
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder:
          (ctx) => Padding(
            padding: EdgeInsets.all(CoreSpacing.lg(ctx)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                WidgetsAppTextField(controller: labelEn, label: 'Label EN'),
                SizedBox(height: CoreSpacing.sm(ctx)),
                WidgetsAppTextField(controller: price, label: 'Price', keyboardType: TextInputType.number),
                SizedBox(height: CoreSpacing.md(ctx)),
                WidgetsAppButton(
                  label: widget.isAr ? 'حفظ' : 'Save',
                  onPressed: () {
                    ref.read(adminCatalogProvider.notifier).updateAddon(
                      addon.copyWith(
                        labelEn: labelEn.text,
                        priceDeltaJod: double.tryParse(price.text) ?? addon.priceDeltaJod,
                      ),
                    );
                    Navigator.pop(ctx);
                  },
                ),
              ],
            ),
          ),
    );
  }
}

class _RelatedProductsTab extends ConsumerStatefulWidget {
  const _RelatedProductsTab({required this.isAr});

  final bool isAr;

  @override
  ConsumerState<_RelatedProductsTab> createState() => _RelatedProductsTabState();
}

class _RelatedProductsTabState extends ConsumerState<_RelatedProductsTab> {
  final _productId = TextEditingController();
  final _relatedIds = TextEditingController();

  @override
  void dispose() {
    _productId.dispose();
    _relatedIds.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final links = ref.watch(adminCatalogProvider).resolvedRelatedLinks;
    final sampleIds = MockupCatalog.items.take(5).map((i) => i.id).join(', ');

    return ListView(
      padding: EdgeInsets.all(CoreSpacing.lg(context)),
      children: [
        WidgetsAppCard(
          title: widget.isAr ? 'ربط منتجات' : 'Link related products',
          subtitle: widget.isAr ? 'مثال IDs: $sampleIds' : 'Example IDs: $sampleIds',
          child: Column(
            children: [
              WidgetsAppTextField(controller: _productId, label: widget.isAr ? 'معرف المنتج' : 'Product ID'),
              SizedBox(height: CoreSpacing.sm(context)),
              WidgetsAppTextField(
                controller: _relatedIds,
                label: widget.isAr ? 'معرفات مرتبطة (فاصلة)' : 'Related IDs (comma-separated)',
                maxLines: 2,
              ),
              SizedBox(height: CoreSpacing.md(context)),
              WidgetsAppButton(
                label: widget.isAr ? 'حفظ الربط' : 'Save link',
                icon: Icons.link_outlined,
                onPressed: () {
                  final ids =
                      _relatedIds.text
                          .split(',')
                          .map((s) => s.trim())
                          .where((s) => s.isNotEmpty)
                          .toList();
                  final ok = ref.read(adminCatalogProvider.notifier).upsertRelatedLink(
                    ModelRelatedProductLink(
                      productId: _productId.text.trim(),
                      relatedProductIds: ids,
                    ),
                  );
                  if (ok) {
                    _productId.clear();
                    _relatedIds.clear();
                    UtilityMockFeedback.showSuccess(context, widget.isAr ? 'تم الحفظ' : 'Saved');
                  } else {
                    UtilityMockFeedback.showWarning(
                      context,
                      widget.isAr ? 'أدخل معرف المنتج' : 'Enter a product ID',
                    );
                  }
                },
              ),
            ],
          ),
        ),
        for (final link in links)
          _CatalogListTile(
            title: link.productId,
            subtitle: link.relatedProductIds.join(', '),
            isAr: widget.isAr,
            onEdit: () {
              _productId.text = link.productId;
              _relatedIds.text = link.relatedProductIds.join(', ');
            },
            onDelete: () {
              confirmAdminDelete(
                context,
                isAr: widget.isAr,
                onConfirmed: () {
                  ref.read(adminCatalogProvider.notifier).deleteRelatedLink(link.productId);
                  UtilityMockFeedback.showInfo(context, widget.isAr ? 'تم الحذف' : 'Deleted');
                },
              );
            },
          ),
      ],
    );
  }
}

class _AddFormCard extends StatelessWidget {
  const _AddFormCard({
    required this.title,
    required this.isAr,
    required this.onSubmit,
    required this.fields,
  });

  final String title;
  final bool isAr;
  final VoidCallback onSubmit;
  final List<Widget> fields;

  @override
  Widget build(BuildContext context) {
    return WidgetsAppCard(
      title: title,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ...fields,
          SizedBox(height: CoreSpacing.md(context)),
          WidgetsAppButton(label: isAr ? 'إضافة' : 'Add', icon: Icons.add_outlined, onPressed: onSubmit),
          SizedBox(height: CoreSpacing.lg(context)),
        ],
      ),
    );
  }
}

class _CatalogListTile extends StatelessWidget {
  const _CatalogListTile({
    required this.title,
    required this.subtitle,
    required this.isAr,
    required this.onEdit,
    required this.onDelete,
  });

  final String title;
  final String subtitle;
  final bool isAr;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: CoreSpacing.sm(context)),
      child: WidgetsAppCard(
        variant: WidgetsAppCardVariant.form,
        padding: EdgeInsets.all(CoreSpacing.md(context)),
        child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: CoreTypography.titleMedium(context, Theme.of(context).colorScheme.onSurface).copyWith(fontWeight: FontWeight.w900)),
                Text(subtitle, style: CoreTypography.caption(context, Theme.of(context).colorScheme.onSurfaceVariant)),
              ],
            ),
          ),
          IconButton(onPressed: onEdit, icon: const Icon(Icons.edit_outlined)),
          IconButton(onPressed: onDelete, icon: const Icon(Icons.delete_outline), color: CoreColors.semanticError),
        ],
        ),
      ),
    );
  }
}

extension on ModelMenuCategory {
  ModelMenuCategory copyWith({String? nameAr, String? nameEn, String? iconKey}) {
    return ModelMenuCategory(
      id: id,
      nameAr: nameAr ?? this.nameAr,
      nameEn: nameEn ?? this.nameEn,
      iconKey: iconKey ?? this.iconKey,
    );
  }
}

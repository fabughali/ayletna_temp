import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/data/mockup/mockup_catalog.dart';
import 'package:ayletna_restaurant_app/data/models/model_admin_catalog.dart';
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

/// Admin CRUD for combos, discounts, offers, and subscription meals.
class AdminPromotionsManagementScreen extends ConsumerWidget {
  const AdminPromotionsManagementScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final isAr = Localizations.localeOf(context).languageCode == 'ar';

    return DefaultTabController(
      length: 4,
      child: WidgetsScaffoldPage(
        title: l10n.screenOffersManagement,
        actions: [
          WidgetsIconButton(
            onPressed: () => context.push(AppRoutePaths.offers),
            icon: Icons.local_offer_outlined,
            tooltip: l10n.screenOffers,
          ),
        ],
        child: Column(
          children: [
            TabBar(
              isScrollable: true,
              tabs: [
                Tab(text: isAr ? 'كومبو' : 'Combos'),
                Tab(text: isAr ? 'خصومات' : 'Discounts'),
                Tab(text: isAr ? 'عروض' : 'Offers'),
                Tab(text: isAr ? 'اشتراكات' : 'Subscriptions'),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  _CombosTab(isAr: isAr),
                  _DiscountsTab(isAr: isAr),
                  _OffersTab(isAr: isAr),
                  _SubscriptionsTab(isAr: isAr),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CombosTab extends ConsumerStatefulWidget {
  const _CombosTab({required this.isAr});
  final bool isAr;
  @override
  ConsumerState<_CombosTab> createState() => _CombosTabState();
}

class _CombosTabState extends ConsumerState<_CombosTab> {
  final _titleEn = TextEditingController();
  final _titleAr = TextEditingController();
  final _subtitleEn = TextEditingController();
  final _price = TextEditingController(text: '18.5');
  final _discount = TextEditingController(text: '12');

  @override
  void dispose() {
    _titleEn.dispose();
    _titleAr.dispose();
    _subtitleEn.dispose();
    _price.dispose();
    _discount.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final combos = ref.watch(visibleCombosProvider);
    return _PromoList(
      isAr: widget.isAr,
      form: _PromoForm(
        isAr: widget.isAr,
        title: widget.isAr ? 'إنشاء كومبو' : 'Create combo',
        onSubmit: () {
          final ok = ref.read(adminCatalogProvider.notifier).addCombo(
            ModelCatalogCombo(
              id: nextCatalogId('combo'),
              titleEn: _titleEn.text,
              titleAr: _titleAr.text,
              subtitleEn: _subtitleEn.text,
              priceJod: double.tryParse(_price.text) ?? 0,
              discountPercent: double.tryParse(_discount.text) ?? 12,
            ),
          );
          if (!mounted) return;
          if (ok) {
            _titleEn.clear();
            _titleAr.clear();
            _subtitleEn.clear();
            UtilityMockFeedback.showSuccess(context, widget.isAr ? 'تم' : 'Added');
          } else {
            UtilityMockFeedback.showWarning(
              context,
              widget.isAr ? 'تحقق من الحقول' : 'Check required fields',
            );
          }
        },
        fields: [
          WidgetsAppTextField(controller: _titleEn, label: 'Title EN'),
          SizedBox(height: CoreSpacing.sm(context)),
          WidgetsAppTextField(controller: _titleAr, label: 'Title AR'),
          SizedBox(height: CoreSpacing.sm(context)),
          WidgetsAppTextField(controller: _subtitleEn, label: 'Subtitle EN', maxLines: 2),
          SizedBox(height: CoreSpacing.sm(context)),
          WidgetsAppTextField(controller: _price, label: 'Price JOD', keyboardType: TextInputType.number),
          SizedBox(height: CoreSpacing.sm(context)),
          WidgetsAppTextField(controller: _discount, label: widget.isAr ? 'خصم %' : 'Discount %', keyboardType: TextInputType.number),
        ],
      ),
      items:
          combos
              .map(
                (c) => _PromoItem(
                  title: widget.isAr ? c.titleAr : c.titleEn,
                  subtitle: '${c.priceJod} JOD • ${c.discountPercent}%',
                  onEdit: () => _editCombo(context, c),
                  onDelete: () {
                    confirmAdminDelete(
                      context,
                      isAr: widget.isAr,
                      onConfirmed:
                          () => ref.read(adminCatalogProvider.notifier).deleteCombo(c.id),
                    );
                  },
                ),
              )
              .toList(),
    );
  }

  void _editCombo(BuildContext context, ModelCatalogCombo combo) {
    final titleEn = TextEditingController(text: combo.titleEn);
    final titleAr = TextEditingController(text: combo.titleAr);
    final subtitleEn = TextEditingController(text: combo.subtitleEn);
    final price = TextEditingController(text: combo.priceJod.toString());
    final discount = TextEditingController(text: combo.discountPercent.toString());

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder:
          (ctx) => Padding(
            padding: EdgeInsets.all(CoreSpacing.lg(ctx)),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  WidgetsAppTextField(controller: titleEn, label: 'Title EN'),
                  SizedBox(height: CoreSpacing.sm(ctx)),
                  WidgetsAppTextField(controller: titleAr, label: 'Title AR'),
                  SizedBox(height: CoreSpacing.sm(ctx)),
                  WidgetsAppTextField(controller: subtitleEn, label: 'Subtitle EN', maxLines: 2),
                  SizedBox(height: CoreSpacing.sm(ctx)),
                  WidgetsAppTextField(controller: price, label: 'Price JOD', keyboardType: TextInputType.number),
                  SizedBox(height: CoreSpacing.sm(ctx)),
                  WidgetsAppTextField(controller: discount, label: 'Discount %', keyboardType: TextInputType.number),
                  SizedBox(height: CoreSpacing.md(ctx)),
                  WidgetsAppButton(
                    label: widget.isAr ? 'حفظ' : 'Save',
                    onPressed: () {
                      final ok = ref.read(adminCatalogProvider.notifier).updateCombo(
                        combo.copyWith(
                          titleEn: titleEn.text,
                          titleAr: titleAr.text,
                          subtitleEn: subtitleEn.text,
                          priceJod: double.tryParse(price.text) ?? combo.priceJod,
                          discountPercent: double.tryParse(discount.text) ?? combo.discountPercent,
                        ),
                      );
                      if (ok) {
                        Navigator.pop(ctx);
                        UtilityMockFeedback.showSuccess(
                          context,
                          widget.isAr ? 'تم التحديث' : 'Updated',
                        );
                      } else {
                        UtilityMockFeedback.showWarning(
                          ctx,
                          widget.isAr ? 'تعذر التحديث' : 'Update failed',
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
    );
  }
}

class _DiscountsTab extends ConsumerStatefulWidget {
  const _DiscountsTab({required this.isAr});
  final bool isAr;
  @override
  ConsumerState<_DiscountsTab> createState() => _DiscountsTabState();
}

class _DiscountsTabState extends ConsumerState<_DiscountsTab> {
  final _itemId = TextEditingController();
  final _percent = TextEditingController(text: '10');

  @override
  void dispose() {
    _itemId.dispose();
    _percent.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final discounts = ref.watch(visibleDiscountsProvider);
    return _PromoList(
      isAr: widget.isAr,
      form: _PromoForm(
        isAr: widget.isAr,
        title: widget.isAr ? 'خصم على منتج' : 'Discount product',
        onSubmit: () {
          final ok = ref.read(adminCatalogProvider.notifier).addDiscount(
            ModelCatalogDiscount(
              id: nextCatalogId('disc'),
              menuItemId: _itemId.text.trim(),
              percentOff: double.tryParse(_percent.text) ?? 10,
            ),
          );
          if (!mounted) return;
          if (ok) {
            _itemId.clear();
            UtilityMockFeedback.showSuccess(context, widget.isAr ? 'تم' : 'Added');
          } else {
            UtilityMockFeedback.showWarning(
              context,
              widget.isAr ? 'تحقق من الحقول' : 'Check required fields',
            );
          }
        },
        fields: [
          WidgetsAppTextField(
            controller: _itemId,
            label: widget.isAr ? 'معرف المنتج' : 'Menu item ID',
            hintText: MockupCatalog.items.first.id,
          ),
          SizedBox(height: CoreSpacing.sm(context)),
          WidgetsAppTextField(controller: _percent, label: '% off', keyboardType: TextInputType.number),
        ],
      ),
      items:
          discounts
              .map(
                (d) => _PromoItem(
                  title: d.menuItemId,
                  subtitle: '${d.percentOff}% off',
                  onEdit: () => _editDiscount(context, d),
                  onDelete: () {
                    confirmAdminDelete(
                      context,
                      isAr: widget.isAr,
                      onConfirmed:
                          () => ref.read(adminCatalogProvider.notifier).deleteDiscount(d.id),
                    );
                  },
                ),
              )
              .toList(),
    );
  }

  void _editDiscount(BuildContext context, ModelCatalogDiscount discount) {
    final itemId = TextEditingController(text: discount.menuItemId);
    final percent = TextEditingController(text: discount.percentOff.toString());

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
                WidgetsAppTextField(controller: itemId, label: 'Menu item ID'),
                SizedBox(height: CoreSpacing.sm(ctx)),
                WidgetsAppTextField(controller: percent, label: '% off', keyboardType: TextInputType.number),
                SizedBox(height: CoreSpacing.md(ctx)),
                WidgetsAppButton(
                  label: widget.isAr ? 'حفظ' : 'Save',
                  onPressed: () {
                    final ok = ref.read(adminCatalogProvider.notifier).updateDiscount(
                      discount.copyWith(
                        menuItemId: itemId.text.trim(),
                        percentOff: double.tryParse(percent.text) ?? discount.percentOff,
                      ),
                    );
                    if (ok) {
                      Navigator.pop(ctx);
                      UtilityMockFeedback.showSuccess(
                        context,
                        widget.isAr ? 'تم التحديث' : 'Updated',
                      );
                    } else {
                      UtilityMockFeedback.showWarning(
                        ctx,
                        widget.isAr ? 'تعذر التحديث' : 'Update failed',
                      );
                    }
                  },
                ),
              ],
            ),
          ),
    );
  }
}

class _OffersTab extends ConsumerStatefulWidget {
  const _OffersTab({required this.isAr});
  final bool isAr;
  @override
  ConsumerState<_OffersTab> createState() => _OffersTabState();
}

class _OffersTabState extends ConsumerState<_OffersTab> {
  final _titleEn = TextEditingController();
  final _titleAr = TextEditingController();
  final _subtitleEn = TextEditingController();

  @override
  void dispose() {
    _titleEn.dispose();
    _titleAr.dispose();
    _subtitleEn.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final offers = ref.watch(adminCatalogProvider).resolvedOffers;
    return _PromoList(
      isAr: widget.isAr,
      form: _PromoForm(
        isAr: widget.isAr,
        title: widget.isAr ? 'عرض جديد' : 'New offer',
        onSubmit: () {
          final ok = ref.read(adminCatalogProvider.notifier).addOffer(
            ModelCatalogOffer(
              id: nextCatalogId('offer'),
              titleEn: _titleEn.text,
              titleAr: _titleAr.text,
              subtitleEn: _subtitleEn.text,
            ),
          );
          if (!mounted) return;
          if (ok) {
            _titleEn.clear();
            _titleAr.clear();
            _subtitleEn.clear();
            UtilityMockFeedback.showSuccess(context, widget.isAr ? 'تم' : 'Added');
          } else {
            UtilityMockFeedback.showWarning(
              context,
              widget.isAr ? 'تحقق من الحقول' : 'Check required fields',
            );
          }
        },
        fields: [
          WidgetsAppTextField(controller: _titleEn, label: 'Title EN'),
          SizedBox(height: CoreSpacing.sm(context)),
          WidgetsAppTextField(controller: _titleAr, label: 'Title AR'),
          SizedBox(height: CoreSpacing.sm(context)),
          WidgetsAppTextField(controller: _subtitleEn, label: 'Subtitle EN', maxLines: 2),
        ],
      ),
      items:
          offers
              .map(
                (o) => _PromoItem(
                  title: widget.isAr ? o.titleAr : o.titleEn,
                  subtitle: o.subtitleEn ?? '',
                  onEdit: () => _editOffer(context, o),
                  onDelete: () {
                    confirmAdminDelete(
                      context,
                      isAr: widget.isAr,
                      onConfirmed:
                          () => ref.read(adminCatalogProvider.notifier).deleteOffer(o.id),
                    );
                  },
                ),
              )
              .toList(),
    );
  }

  void _editOffer(BuildContext context, ModelCatalogOffer offer) {
    final titleEn = TextEditingController(text: offer.titleEn);
    final titleAr = TextEditingController(text: offer.titleAr);
    final subtitleEn = TextEditingController(text: offer.subtitleEn);

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
                WidgetsAppTextField(controller: titleEn, label: 'Title EN'),
                SizedBox(height: CoreSpacing.sm(ctx)),
                WidgetsAppTextField(controller: titleAr, label: 'Title AR'),
                SizedBox(height: CoreSpacing.sm(ctx)),
                WidgetsAppTextField(controller: subtitleEn, label: 'Subtitle EN', maxLines: 2),
                SizedBox(height: CoreSpacing.md(ctx)),
                WidgetsAppButton(
                  label: widget.isAr ? 'حفظ' : 'Save',
                  onPressed: () {
                    final ok = ref.read(adminCatalogProvider.notifier).updateOffer(
                      offer.copyWith(
                        titleEn: titleEn.text,
                        titleAr: titleAr.text,
                        subtitleEn: subtitleEn.text,
                      ),
                    );
                    if (ok) {
                      Navigator.pop(ctx);
                      UtilityMockFeedback.showSuccess(
                        context,
                        widget.isAr ? 'تم التحديث' : 'Updated',
                      );
                    } else {
                      UtilityMockFeedback.showWarning(
                        ctx,
                        widget.isAr ? 'تعذر التحديث' : 'Update failed',
                      );
                    }
                  },
                ),
              ],
            ),
          ),
    );
  }
}

class _SubscriptionsTab extends ConsumerStatefulWidget {
  const _SubscriptionsTab({required this.isAr});
  final bool isAr;
  @override
  ConsumerState<_SubscriptionsTab> createState() => _SubscriptionsTabState();
}

class _SubscriptionsTabState extends ConsumerState<_SubscriptionsTab> {
  final _itemId = TextEditingController();
  final _titleEn = TextEditingController();
  final _titleAr = TextEditingController();
  final _price = TextEditingController(text: '25');
  var _period = 'monthly';

  @override
  void dispose() {
    _itemId.dispose();
    _titleEn.dispose();
    _titleAr.dispose();
    _price.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final subs = ref.watch(visibleSubscriptionsProvider);
    return _PromoList(
      isAr: widget.isAr,
      form: _PromoForm(
        isAr: widget.isAr,
        title: widget.isAr ? 'وجبة اشتراك' : 'Subscription meal',
        onSubmit: () {
          final ok = ref.read(adminCatalogProvider.notifier).addSubscription(
            ModelSubscriptionMeal(
              id: nextCatalogId('sub'),
              menuItemId: _itemId.text.trim(),
              titleEn: _titleEn.text,
              titleAr: _titleAr.text,
              priceJod: double.tryParse(_price.text) ?? 0,
              billingPeriod: _period,
            ),
          );
          if (!mounted) return;
          if (ok) {
            _itemId.clear();
            _titleEn.clear();
            _titleAr.clear();
            UtilityMockFeedback.showSuccess(context, widget.isAr ? 'تم' : 'Added');
          } else {
            UtilityMockFeedback.showWarning(
              context,
              widget.isAr ? 'تحقق من الحقول' : 'Check required fields',
            );
          }
        },
        fields: [
          WidgetsAppTextField(controller: _itemId, label: 'Menu item ID'),
          SizedBox(height: CoreSpacing.sm(context)),
          WidgetsAppTextField(controller: _titleEn, label: 'Title EN'),
          SizedBox(height: CoreSpacing.sm(context)),
          WidgetsAppTextField(controller: _titleAr, label: 'Title AR'),
          SizedBox(height: CoreSpacing.sm(context)),
          WidgetsAppTextField(controller: _price, label: 'Price JOD', keyboardType: TextInputType.number),
          SizedBox(height: CoreSpacing.sm(context)),
          DropdownButtonFormField<String>(
            value: _period,
            items: const [
              DropdownMenuItem(value: 'weekly', child: Text('Weekly')),
              DropdownMenuItem(value: 'monthly', child: Text('Monthly')),
            ],
            onChanged: (v) => setState(() => _period = v ?? 'monthly'),
            decoration: const InputDecoration(labelText: 'Billing period', border: OutlineInputBorder()),
          ),
        ],
      ),
      items:
          subs
              .map(
                (s) => _PromoItem(
                  title: widget.isAr ? s.titleAr : s.titleEn,
                  subtitle: '${s.billingPeriod} • ${s.priceJod} JOD',
                  onEdit: () => _editSubscription(context, s),
                  onDelete: () {
                    confirmAdminDelete(
                      context,
                      isAr: widget.isAr,
                      onConfirmed:
                          () =>
                              ref.read(adminCatalogProvider.notifier).deleteSubscription(s.id),
                    );
                  },
                ),
              )
              .toList(),
    );
  }

  void _editSubscription(BuildContext context, ModelSubscriptionMeal meal) {
    final itemId = TextEditingController(text: meal.menuItemId);
    final titleEn = TextEditingController(text: meal.titleEn);
    final titleAr = TextEditingController(text: meal.titleAr);
    final price = TextEditingController(text: meal.priceJod.toString());
    var period = meal.billingPeriod;

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder:
          (ctx) => StatefulBuilder(
            builder:
                (ctx, setSheetState) => Padding(
                  padding: EdgeInsets.all(CoreSpacing.lg(ctx)),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        WidgetsAppTextField(controller: itemId, label: 'Menu item ID'),
                        SizedBox(height: CoreSpacing.sm(ctx)),
                        WidgetsAppTextField(controller: titleEn, label: 'Title EN'),
                        SizedBox(height: CoreSpacing.sm(ctx)),
                        WidgetsAppTextField(controller: titleAr, label: 'Title AR'),
                        SizedBox(height: CoreSpacing.sm(ctx)),
                        WidgetsAppTextField(controller: price, label: 'Price JOD', keyboardType: TextInputType.number),
                        SizedBox(height: CoreSpacing.sm(ctx)),
                        DropdownButtonFormField<String>(
                          value: period,
                          items: const [
                            DropdownMenuItem(value: 'weekly', child: Text('Weekly')),
                            DropdownMenuItem(value: 'monthly', child: Text('Monthly')),
                          ],
                          onChanged: (v) => setSheetState(() => period = v ?? period),
                          decoration: const InputDecoration(labelText: 'Billing period', border: OutlineInputBorder()),
                        ),
                        SizedBox(height: CoreSpacing.md(ctx)),
                        WidgetsAppButton(
                          label: widget.isAr ? 'حفظ' : 'Save',
                          onPressed: () {
                            final ok = ref.read(adminCatalogProvider.notifier).updateSubscription(
                              meal.copyWith(
                                menuItemId: itemId.text.trim(),
                                titleEn: titleEn.text,
                                titleAr: titleAr.text,
                                priceJod: double.tryParse(price.text) ?? meal.priceJod,
                                billingPeriod: period,
                              ),
                            );
                            if (ok) {
                              Navigator.pop(ctx);
                              UtilityMockFeedback.showSuccess(
                                context,
                                widget.isAr ? 'تم التحديث' : 'Updated',
                              );
                            } else {
                              UtilityMockFeedback.showWarning(
                                ctx,
                                widget.isAr ? 'تعذر التحديث' : 'Update failed',
                              );
                            }
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

class _PromoList extends StatelessWidget {
  const _PromoList({required this.isAr, required this.form, required this.items});

  final bool isAr;
  final Widget form;
  final List<_PromoItem> items;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(CoreSpacing.lg(context)),
      children: [
        form,
        SizedBox(height: CoreSpacing.lg(context)),
        for (final item in items) item,
      ],
    );
  }
}

class _PromoForm extends StatelessWidget {
  const _PromoForm({
    required this.isAr,
    required this.title,
    required this.onSubmit,
    required this.fields,
  });

  final bool isAr;
  final String title;
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
        ],
      ),
    );
  }
}

class _PromoItem extends StatelessWidget {
  const _PromoItem({
    required this.title,
    required this.subtitle,
    required this.onDelete,
    this.onEdit,
  });

  final String title;
  final String subtitle;
  final VoidCallback onDelete;
  final VoidCallback? onEdit;

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
                  if (subtitle.isNotEmpty)
                    Text(subtitle, style: CoreTypography.caption(context, Theme.of(context).colorScheme.onSurfaceVariant)),
                ],
              ),
            ),
            if (onEdit != null)
              IconButton(onPressed: onEdit, icon: const Icon(Icons.edit_outlined)),
            IconButton(onPressed: onDelete, icon: const Icon(Icons.delete_outline), color: CoreColors.semanticError),
          ],
        ),
      ),
    );
  }
}

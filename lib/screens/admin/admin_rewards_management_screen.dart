import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/data/models/model_customer_reward.dart';
import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:ayletna_restaurant_app/navigation/app_route_paths.dart';
import 'package:ayletna_restaurant_app/providers/rewards_admin_providers.dart';
import 'package:ayletna_restaurant_app/utilities/utility_confirm_dialog.dart';
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

/// Admin rewards catalog setup — points rules and reward CRUD.
class AdminRewardsManagementScreen extends ConsumerStatefulWidget {
  const AdminRewardsManagementScreen({super.key});

  @override
  ConsumerState<AdminRewardsManagementScreen> createState() =>
      _AdminRewardsManagementScreenState();
}

class _AdminRewardsManagementScreenState
    extends ConsumerState<AdminRewardsManagementScreen> {
  final _titleAr = TextEditingController();
  final _titleEn = TextEditingController();
  final _descAr = TextEditingController();
  final _descEn = TextEditingController();
  final _points = TextEditingController(text: '500');
  var _categoryKey = 'drinks';

  @override
  void dispose() {
    _titleAr.dispose();
    _titleEn.dispose();
    _descAr.dispose();
    _descEn.dispose();
    _points.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isAr = Localizations.localeOf(context).languageCode == 'ar';
    final catalog = ref.watch(rewardsCatalogProvider);

    return WidgetsScaffoldPage(
      title: isAr ? 'إعداد المكافآت' : 'Rewards Setup',
      actions: [
        WidgetsIconButton(
          onPressed: () => context.push(AppRoutePaths.rewards),
          icon: Icons.card_giftcard_outlined,
          tooltip: l10n.rewardsCatalogTitle,
        ),
      ],
      child: WidgetsRefreshList(
        onRefresh: () async {
          await Future<void>.delayed(const Duration(milliseconds: 300));
        },
        child: ListView(
          children: [
            SizedBox(height: CoreSpacing.md(context)),
            WidgetsAppCard(
              title: isAr ? 'قواعد النقاط' : 'Points rules',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    isAr
                        ? '${catalog.pointsPerJod} نقطة لكل دينار'
                        : '${catalog.pointsPerJod} points per JOD spent',
                    style: CoreTypography.bodyMedium(
                      context,
                      Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  Slider(
                    value: catalog.pointsPerJod,
                    min: 0.5,
                    max: 3,
                    divisions: 5,
                    label: catalog.pointsPerJod.toStringAsFixed(1),
                    onChanged:
                        (v) =>
                            ref.read(rewardsCatalogProvider.notifier).setPointsPerJod(v),
                  ),
                ],
              ),
            ),
            SizedBox(height: CoreSpacing.lg(context)),
            WidgetsAppCard(
              title: isAr ? 'إضافة مكافأة' : 'Add reward',
              child: Column(
                children: [
                  WidgetsAppTextField(
                    controller: _titleAr,
                    label: isAr ? 'العنوان بالعربية' : 'Arabic title',
                  ),
                  SizedBox(height: CoreSpacing.sm(context)),
                  WidgetsAppTextField(
                    controller: _titleEn,
                    label: isAr ? 'العنوان بالإنجليزية' : 'English title',
                  ),
                  SizedBox(height: CoreSpacing.sm(context)),
                  WidgetsAppTextField(
                    controller: _descAr,
                    label: isAr ? 'الوصف بالعربية' : 'Arabic description',
                    maxLines: 2,
                  ),
                  SizedBox(height: CoreSpacing.sm(context)),
                  WidgetsAppTextField(
                    controller: _descEn,
                    label: isAr ? 'الوصف بالإنجليزية' : 'English description',
                    maxLines: 2,
                  ),
                  SizedBox(height: CoreSpacing.sm(context)),
                  WidgetsAppTextField(
                    controller: _points,
                    label: isAr ? 'النقاط المطلوبة' : 'Points required',
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: CoreSpacing.sm(context)),
                  DropdownButtonFormField<String>(
                    value: _categoryKey,
                    decoration: InputDecoration(
                      labelText: isAr ? 'الفئة' : 'Category',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(CoreSpacing.radiusChip),
                      ),
                    ),
                    items: const [
                      DropdownMenuItem(value: 'drinks', child: Text('Drinks')),
                      DropdownMenuItem(value: 'sides', child: Text('Sides')),
                      DropdownMenuItem(value: 'main', child: Text('Main')),
                    ],
                    onChanged: (v) => setState(() => _categoryKey = v ?? 'drinks'),
                  ),
                  SizedBox(height: CoreSpacing.md(context)),
                  WidgetsAppButton(
                    label: isAr ? 'إضافة للكتalog' : 'Add to catalog',
                    icon: Icons.add_outlined,
                    onPressed: () => _addReward(isAr),
                  ),
                ],
              ),
            ),
            SizedBox(height: CoreSpacing.lg(context)),
            Text(
              isAr ? 'المكافآت النشطة' : 'Active rewards',
              style: CoreTypography.titleMedium(
                context,
                Theme.of(context).colorScheme.onSurface,
              ).copyWith(fontWeight: FontWeight.w900),
            ),
            SizedBox(height: CoreSpacing.md(context)),
            for (final reward in catalog.rewards) ...[
              _RewardAdminTile(reward: reward, isAr: isAr),
              SizedBox(height: CoreSpacing.sm(context)),
            ],
            SizedBox(height: CoreSpacing.xxl(context)),
          ],
        ),
      ),
    );
  }

  void _addReward(bool isAr) {
    final pts = int.tryParse(_points.text) ?? 0;
    final reward = ModelCustomerReward(
      id: 'reward_${DateTime.now().millisecondsSinceEpoch}',
      titleAr: _titleAr.text,
      titleEn: _titleEn.text,
      descriptionAr: _descAr.text,
      descriptionEn: _descEn.text,
      points: pts,
      categoryKey: _categoryKey,
      artKey: 'generic',
      colorKey: 'gold',
    );
    final ok = ref.read(rewardsCatalogProvider.notifier).addReward(reward);
    if (!mounted) return;
    if (ok) {
      UtilityMockFeedback.showSuccess(
        context,
        isAr ? 'تمت إضافة المكافأة' : 'Reward added',
      );
      _titleAr.clear();
      _titleEn.clear();
      _descAr.clear();
      _descEn.clear();
    } else {
      UtilityMockFeedback.showWarning(
        context,
        isAr ? 'تحقق من الحقول' : 'Check required fields',
      );
    }
  }
}

class _RewardAdminTile extends ConsumerWidget {
  const _RewardAdminTile({required this.reward, required this.isAr});

  final ModelCustomerReward reward;
  final bool isAr;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheme = Theme.of(context).colorScheme;

    return WidgetsAppCard(
      variant: WidgetsAppCardVariant.form,
      padding: EdgeInsets.all(CoreSpacing.md(context)),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isAr ? reward.titleAr : reward.titleEn,
                  style: CoreTypography.titleMedium(
                    context,
                    scheme.onSurface,
                  ).copyWith(fontWeight: FontWeight.w900),
                ),
                Text(
                  '${reward.points} pts • ${reward.categoryKey}',
                  style: CoreTypography.caption(context, scheme.onSurfaceVariant),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () => _editReward(context, ref, reward),
            icon: const Icon(Icons.edit_outlined),
          ),
          IconButton(
            onPressed: () {
              confirmAdminDelete(
                context,
                isAr: isAr,
                onConfirmed: () {
                  ref.read(rewardsCatalogProvider.notifier).removeReward(reward.id);
                  UtilityMockFeedback.showInfo(
                    context,
                    isAr ? 'تم الحذف' : 'Removed',
                  );
                },
              );
            },
            icon: const Icon(Icons.delete_outline),
            color: CoreColors.semanticError,
          ),
        ],
      ),
    );
  }
}

void _editReward(BuildContext context, WidgetRef ref, ModelCustomerReward reward) {
  final isAr = Localizations.localeOf(context).languageCode == 'ar';
  final titleAr = TextEditingController(text: reward.titleAr);
  final titleEn = TextEditingController(text: reward.titleEn);
  final descAr = TextEditingController(text: reward.descriptionAr);
  final descEn = TextEditingController(text: reward.descriptionEn);
  final points = TextEditingController(text: reward.points.toString());
  var categoryKey = reward.categoryKey;

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
                      WidgetsAppTextField(controller: titleAr, label: 'Title AR'),
                      SizedBox(height: CoreSpacing.sm(ctx)),
                      WidgetsAppTextField(controller: titleEn, label: 'Title EN'),
                      SizedBox(height: CoreSpacing.sm(ctx)),
                      WidgetsAppTextField(controller: descAr, label: 'Description AR', maxLines: 2),
                      SizedBox(height: CoreSpacing.sm(ctx)),
                      WidgetsAppTextField(controller: descEn, label: 'Description EN', maxLines: 2),
                      SizedBox(height: CoreSpacing.sm(ctx)),
                      WidgetsAppTextField(controller: points, label: 'Points', keyboardType: TextInputType.number),
                      SizedBox(height: CoreSpacing.sm(ctx)),
                      DropdownButtonFormField<String>(
                        value: categoryKey,
                        decoration: InputDecoration(
                          labelText: isAr ? 'الفئة' : 'Category',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(CoreSpacing.radiusChip),
                          ),
                        ),
                        items: const [
                          DropdownMenuItem(value: 'drinks', child: Text('Drinks')),
                          DropdownMenuItem(value: 'sides', child: Text('Sides')),
                          DropdownMenuItem(value: 'main', child: Text('Main')),
                        ],
                        onChanged: (v) => setSheetState(() => categoryKey = v ?? categoryKey),
                      ),
                      SizedBox(height: CoreSpacing.md(ctx)),
                      WidgetsAppButton(
                        label: isAr ? 'حفظ' : 'Save',
                        onPressed: () {
                          final ok = ref.read(rewardsCatalogProvider.notifier).updateReward(
                            ModelCustomerReward(
                              id: reward.id,
                              titleAr: titleAr.text,
                              titleEn: titleEn.text,
                              descriptionAr: descAr.text,
                              descriptionEn: descEn.text,
                              points: int.tryParse(points.text) ?? reward.points,
                              categoryKey: categoryKey,
                              artKey: reward.artKey,
                              colorKey: reward.colorKey,
                              isPopular: reward.isPopular,
                              isLocked: reward.isLocked,
                            ),
                          );
                          if (ok) {
                            Navigator.pop(ctx);
                            UtilityMockFeedback.showSuccess(
                              context,
                              isAr ? 'تم التحديث' : 'Updated',
                            );
                          } else {
                            UtilityMockFeedback.showWarning(
                              ctx,
                              isAr ? 'تعذر التحديث' : 'Update failed',
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

import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/data/models/model_faq_entry.dart';
import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:ayletna_restaurant_app/providers/support_faq_providers.dart';
import 'package:ayletna_restaurant_app/utilities/utility_mock_feedback.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_text_field.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_hub_nav_actions.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_scaffold_page.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_status_pill.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Support staff FAQ editor — mock CRUD (no backend).
class SupportFaqEditorScreen extends ConsumerStatefulWidget {
  const SupportFaqEditorScreen({super.key});

  @override
  ConsumerState<SupportFaqEditorScreen> createState() =>
      _SupportFaqEditorScreenState();
}

class _SupportFaqEditorScreenState
    extends ConsumerState<SupportFaqEditorScreen> {
  final _titleAr = TextEditingController();
  final _titleEn = TextEditingController();
  final _bodyAr = TextEditingController();
  final _bodyEn = TextEditingController();

  @override
  void dispose() {
    _titleAr.dispose();
    _titleEn.dispose();
    _bodyAr.dispose();
    _bodyEn.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isAr = Localizations.localeOf(context).languageCode == 'ar';
    final entries = ref.watch(supportFaqProvider);

    return WidgetsScaffoldPage(
      title: l10n.supportFaqEditorTitle,
      actions: WidgetsHubNavActions.forContext(context),
      child: ListView.builder(
        padding: EdgeInsetsDirectional.only(bottom: CoreSpacing.xxl(context)),
        itemCount: entries.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                WidgetsAppCard(
                  child: Padding(
                    padding: EdgeInsets.all(CoreSpacing.lg(context)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.supportFaqAddTitle,
                          style: CoreTypography.titleMedium(
                            context,
                            Theme.of(context).colorScheme.onSurface,
                          ).copyWith(fontWeight: FontWeight.w900),
                        ),
                        SizedBox(height: CoreSpacing.md(context)),
                        WidgetsAppTextField(
                          controller: _titleEn,
                          label: '${l10n.faqDeliveryTitle} (EN)',
                        ),
                        SizedBox(height: CoreSpacing.sm(context)),
                        WidgetsAppTextField(
                          controller: _titleAr,
                          label: '${l10n.faqDeliveryTitle} (AR)',
                        ),
                        SizedBox(height: CoreSpacing.sm(context)),
                        WidgetsAppTextField(
                          controller: _bodyEn,
                          label: l10n.supportFaqBodyLabelEn,
                          maxLines: 3,
                        ),
                        SizedBox(height: CoreSpacing.sm(context)),
                        WidgetsAppTextField(
                          controller: _bodyAr,
                          label: l10n.supportFaqBodyLabelAr,
                          maxLines: 3,
                        ),
                        SizedBox(height: CoreSpacing.md(context)),
                        WidgetsAppButton(
                          label: l10n.supportFaqAddAction,
                          icon: Icons.add_outlined,
                          onPressed: () => _saveNew(l10n),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: CoreSpacing.lg(context)),
              ],
            );
          }
          final entry = entries[index - 1];
          return Padding(
            padding: EdgeInsets.only(bottom: CoreSpacing.sm(context)),
            child: _FaqEntryCard(
              entry: entry,
              isAr: isAr,
              l10n: l10n,
              onEdit: () => _editEntry(context, ref, entry, l10n),
              onTogglePublished:
                  () => _togglePublished(context, ref, entry, l10n),
              onDelete: () => _deleteEntry(context, ref, entry, l10n),
            ),
          );
        },
      ),
    );
  }

  void _saveNew(AppLocalizations l10n) {
    if (_titleEn.text.trim().isEmpty || _bodyEn.text.trim().isEmpty) {
      UtilityMockFeedback.showWarning(context, l10n.supportFaqValidation);
      return;
    }
    ref
        .read(supportFaqProvider.notifier)
        .upsert(
          FaqEntry(
            id: 'faq-${DateTime.now().millisecondsSinceEpoch}',
            titleAr:
                _titleAr.text.trim().isEmpty
                    ? _titleEn.text.trim()
                    : _titleAr.text.trim(),
            titleEn: _titleEn.text.trim(),
            bodyAr:
                _bodyAr.text.trim().isEmpty
                    ? _bodyEn.text.trim()
                    : _bodyAr.text.trim(),
            bodyEn: _bodyEn.text.trim(),
            sortOrder: ref.read(supportFaqProvider).length,
          ),
        );
    _titleAr.clear();
    _titleEn.clear();
    _bodyAr.clear();
    _bodyEn.clear();
    UtilityMockFeedback.showSuccess(context, l10n.supportFaqSavedMock);
  }

  Future<void> _deleteEntry(
    BuildContext context,
    WidgetRef ref,
    FaqEntry entry,
    AppLocalizations l10n,
  ) async {
    if (ref.read(supportFaqProvider).length <= 1) {
      UtilityMockFeedback.showWarning(context, l10n.supportFaqDeleteBlocked);
      return;
    }

    final confirmed = await UtilityMockFeedback.confirm(
      context: context,
      title: l10n.supportFaqDeleteConfirmTitle,
      message: l10n.supportFaqDeleteConfirmMessage,
      confirmLabel: l10n.actionRemove,
      cancelLabel: l10n.actionCancel,
      confirmVariant: WidgetsAppButtonVariant.danger,
      icon: Icons.delete_outline,
    );
    if (!context.mounted || !confirmed) return;

    ref.read(supportFaqProvider.notifier).remove(entry.id);
    UtilityMockFeedback.showSuccess(context, l10n.supportFaqDeleted);
  }

  void _editEntry(
    BuildContext context,
    WidgetRef ref,
    FaqEntry entry,
    AppLocalizations l10n,
  ) {
    final titleAr = TextEditingController(text: entry.titleAr);
    final titleEn = TextEditingController(text: entry.titleEn);
    final bodyAr = TextEditingController(text: entry.bodyAr);
    final bodyEn = TextEditingController(text: entry.bodyEn);
    final sortOrder = TextEditingController(text: entry.sortOrder.toString());

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder:
          (ctx) => Padding(
            padding: EdgeInsets.only(
              left: CoreSpacing.lg(ctx),
              right: CoreSpacing.lg(ctx),
              top: CoreSpacing.lg(ctx),
              bottom:
                  MediaQuery.viewInsetsOf(ctx).bottom + CoreSpacing.lg(ctx),
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  WidgetsAppTextField(controller: titleAr, label: 'Title AR'),
                  SizedBox(height: CoreSpacing.sm(ctx)),
                  WidgetsAppTextField(controller: titleEn, label: 'Title EN'),
                  SizedBox(height: CoreSpacing.sm(ctx)),
                  WidgetsAppTextField(
                    controller: bodyAr,
                    label: 'Body AR',
                    maxLines: 3,
                  ),
                  SizedBox(height: CoreSpacing.sm(ctx)),
                  WidgetsAppTextField(
                    controller: bodyEn,
                    label: 'Body EN',
                    maxLines: 3,
                  ),
                  SizedBox(height: CoreSpacing.sm(ctx)),
                  WidgetsAppTextField(
                    controller: sortOrder,
                    label: 'Sort order',
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: CoreSpacing.md(ctx)),
                  WidgetsAppButton(
                    label: l10n.actionSave,
                    onPressed: () {
                      ref.read(supportFaqProvider.notifier).upsert(
                        entry.copyWith(
                          titleAr: titleAr.text,
                          titleEn: titleEn.text,
                          bodyAr: bodyAr.text,
                          bodyEn: bodyEn.text,
                          sortOrder: int.tryParse(sortOrder.text) ?? entry.sortOrder,
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
    );
  }

  void _togglePublished(
    BuildContext context,
    WidgetRef ref,
    FaqEntry entry,
    AppLocalizations l10n,
  ) {
    if (entry.published &&
        entry.titleEn.trim().isEmpty &&
        entry.titleAr.trim().isEmpty) {
      UtilityMockFeedback.showWarning(context, l10n.supportFaqValidation);
      return;
    }
    ref.read(supportFaqProvider.notifier).togglePublished(entry.id);
    UtilityMockFeedback.showSuccess(context, l10n.supportFaqSavedMock);
  }
}

class _FaqEntryCard extends StatelessWidget {
  const _FaqEntryCard({
    required this.entry,
    required this.isAr,
    required this.l10n,
    required this.onEdit,
    required this.onTogglePublished,
    required this.onDelete,
  });

  final FaqEntry entry;
  final bool isAr;
  final AppLocalizations l10n;
  final VoidCallback onEdit;
  final VoidCallback onTogglePublished;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return WidgetsAppCard(
      child: Padding(
        padding: EdgeInsets.all(CoreSpacing.lg(context)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    entry.title(isAr),
                    style: CoreTypography.titleMedium(context, Theme.of(context).colorScheme.onSurface).copyWith(fontWeight: FontWeight.w900),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.edit_outlined, size: CoreContentSizes.buttonIcon(context)),
                  onPressed: onEdit,
                ),
                WidgetsStatusPill(
                  label:
                      entry.published
                          ? l10n.supportFaqPublished
                          : l10n.supportFaqDraft,
                  color:
                      entry.published
                          ? CoreColors.semanticSuccess
                          : CoreColors.brandGold,
                ),
              ],
            ),
            SizedBox(height: CoreSpacing.sm(context)),
            Text(entry.body(isAr)),
            SizedBox(height: CoreSpacing.md(context)),
            Row(
              children: [
                TextButton(
                  onPressed: onTogglePublished,
                  child: Text(
                    entry.published
                        ? l10n.supportFaqUnpublish
                        : l10n.supportFaqPublish,
                  ),
                ),
                TextButton(onPressed: onDelete, child: Text(l10n.actionRemove)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

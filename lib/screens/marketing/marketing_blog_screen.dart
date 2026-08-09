import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/data/models/model_blog_post.dart';
import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:ayletna_restaurant_app/providers/marketing_blog_providers.dart';
import 'package:ayletna_restaurant_app/utilities/utility_mock_feedback.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_text_field.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_scaffold_page.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_status_pill.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class MarketingBlogScreen extends ConsumerWidget {
  const MarketingBlogScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final isAr = Localizations.localeOf(context).languageCode == 'ar';
    final posts = ref.watch(marketingBlogProvider);
    final notifier = ref.read(marketingBlogProvider.notifier);

    return WidgetsScaffoldPage(
      title: l10n.marketingBlogTitle,
      child: ListView.builder(
        padding: EdgeInsetsDirectional.only(bottom: CoreSpacing.xxl(context)),
        itemCount: posts.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                WidgetsAppButton(
                  label: l10n.marketingBlogAddPost,
                  icon: Icons.add_outlined,
                  onPressed: () {
                    notifier.addDraft(
                      titleAr: l10n.marketingBlogNewDraftAr,
                      titleEn: l10n.marketingBlogNewDraftEn,
                    );
                    UtilityMockFeedback.showSuccess(
                      context,
                      l10n.marketingBlogDraftAdded,
                    );
                  },
                ),
                SizedBox(height: CoreSpacing.lg(context)),
              ],
            );
          }
          final post = posts[index - 1];
          return Padding(
              padding: EdgeInsets.only(bottom: CoreSpacing.sm(context)),
              child: WidgetsAppCard(
                child: ListTile(
                  title: Text(
                    post.title(isAr),
                    style: CoreTypography.titleMedium(context, Theme.of(context).colorScheme.onSurface).copyWith(fontWeight: FontWeight.w800),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: CoreSpacing.sm(context)),
                      Text(post.excerpt(isAr)),
                      SizedBox(height: CoreSpacing.sm(context)),
                      if (post.socialPlatforms.isNotEmpty)
                        Wrap(
                          spacing: CoreSpacing.sm(context),
                          children: [
                            for (final p in post.socialPlatforms)
                              Icon(
                                p == 'instagram'
                                    ? Icons.camera_alt_outlined
                                    : Icons.facebook,
                                size: CoreContentSizes.buttonIcon(context),
                                color: CoreColors.hubMarketingAccent,
                              ),
                          ],
                        ),
                      SizedBox(height: CoreSpacing.sm(context)),
                      Text(
                        DateFormat.yMMMd(isAr ? 'ar' : 'en').format(post.updatedAt),
                        style: CoreTypography.caption(
                          context,
                          Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit_outlined, size: CoreContentSizes.buttonIcon(context)),
                        onPressed: () => _editPost(context, ref, post),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete_outline, size: CoreContentSizes.buttonIcon(context)),
                        onPressed: () async {
                          final confirmed = await UtilityMockFeedback.confirm(
                            context: context,
                            title: l10n.marketingBlogDeleteConfirmTitle,
                            message: l10n.marketingBlogDeleteConfirmMessage,
                            confirmLabel: l10n.addressesDelete,
                            cancelLabel: l10n.actionCancel,
                            icon: Icons.delete_outline,
                          );
                          if (!context.mounted || !confirmed) return;
                          final deleted = notifier.deletePost(post.id);
                          if (!context.mounted) return;
                          if (deleted) {
                            UtilityMockFeedback.showSuccess(
                              context,
                              l10n.catalogCrudDeleted,
                            );
                          }
                        },
                      ),
                      WidgetsStatusPill(
                        label: post.status == BlogPostStatus.published
                            ? l10n.marketingBlogPublished
                            : l10n.marketingBlogDraft,
                        color: post.status == BlogPostStatus.published
                            ? CoreColors.semanticSuccess
                            : CoreColors.brandGold,
                      ),
                    ],
                  ),
                  onTap: () async {
                    if (post.status == BlogPostStatus.published) {
                      final confirmed = await UtilityMockFeedback.confirm(
                        context: context,
                        title: l10n.marketingBlogUnpublishConfirmTitle,
                        message: l10n.marketingBlogUnpublishConfirmMessage,
                        confirmLabel: l10n.marketingBlogDraft,
                        cancelLabel: l10n.actionCancel,
                        icon: Icons.article_outlined,
                      );
                      if (!context.mounted || !confirmed) return;
                    } else if (post.titleEn.trim().isEmpty &&
                        post.titleAr.trim().isEmpty) {
                      UtilityMockFeedback.showWarning(
                        context,
                        l10n.marketingBlogDraftNeedsTitle,
                      );
                      return;
                    }
                    notifier.toggleStatus(post.id);
                    UtilityMockFeedback.showSuccess(
                      context,
                      l10n.marketingBlogStatusToggled,
                    );
                  },
                ),
              ),
            );
        },
      ),
    );
  }
}

void _editPost(BuildContext context, WidgetRef ref, BlogPost post) {
  final l10n = AppLocalizations.of(context)!;
  final titleAr = TextEditingController(text: post.titleAr);
  final titleEn = TextEditingController(text: post.titleEn);
  final excerptAr = TextEditingController(text: post.excerptAr);
  final excerptEn = TextEditingController(text: post.excerptEn);
  final bodyAr = TextEditingController(text: post.bodyAr);
  final bodyEn = TextEditingController(text: post.bodyEn);
  final coverImageUrl = TextEditingController(text: post.coverImageUrl ?? '');
  final author = TextEditingController(text: post.author);
  var tags = TextEditingController(text: post.tags.join(', '));
  final platforms = <String>{...post.socialPlatforms};

  showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    builder:
        (ctx) => StatefulBuilder(
          builder: (ctx, setModalState) => Padding(
          padding: EdgeInsets.only(
            left: CoreSpacing.lg(ctx),
            right: CoreSpacing.lg(ctx),
            top: CoreSpacing.lg(ctx),
            bottom: MediaQuery.viewInsetsOf(ctx).bottom + CoreSpacing.lg(ctx),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                WidgetsAppTextField(controller: titleAr, label: 'Title AR'),
                SizedBox(height: CoreSpacing.sm(ctx)),
                WidgetsAppTextField(controller: titleEn, label: 'Title EN'),
                SizedBox(height: CoreSpacing.sm(ctx)),
                WidgetsAppTextField(controller: excerptAr, label: 'Excerpt AR', maxLines: 2),
                SizedBox(height: CoreSpacing.sm(ctx)),
                WidgetsAppTextField(controller: excerptEn, label: 'Excerpt EN', maxLines: 2),
                SizedBox(height: CoreSpacing.sm(ctx)),
                WidgetsAppTextField(controller: bodyAr, label: 'Body AR', maxLines: 4),
                SizedBox(height: CoreSpacing.sm(ctx)),
                WidgetsAppTextField(controller: bodyEn, label: 'Body EN', maxLines: 4),
                SizedBox(height: CoreSpacing.sm(ctx)),
                WidgetsAppTextField(controller: coverImageUrl, label: 'Cover image URL'),
                SizedBox(height: CoreSpacing.sm(ctx)),
                WidgetsAppTextField(controller: author, label: 'Author'),
                SizedBox(height: CoreSpacing.sm(ctx)),
                WidgetsAppTextField(controller: tags, label: 'Tags (comma-separated)'),
                SizedBox(height: CoreSpacing.sm(ctx)),
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text(l10n.marketingBlogPickPlatforms),
                ),
                Wrap(
                  spacing: CoreSpacing.sm(ctx),
                  children: [
                    for (final p in const ['meta', 'instagram'])
                      FilterChip(
                        label: Text(p),
                        selected: platforms.contains(p),
                        onSelected: (selected) {
                          setModalState(() {
                            if (selected) {
                              platforms.add(p);
                            } else {
                              platforms.remove(p);
                            }
                          });
                        },
                      ),
                  ],
                ),
                SizedBox(height: CoreSpacing.md(ctx)),
                WidgetsAppButton(
                  label: l10n.actionSave,
                  onPressed: () {
                    final tagList = tags.text
                        .split(',')
                        .map((t) => t.trim())
                        .where((t) => t.isNotEmpty)
                        .toList();
                    ref.read(marketingBlogProvider.notifier).updatePost(
                      post.copyWith(
                        titleAr: titleAr.text,
                        titleEn: titleEn.text,
                        excerptAr: excerptAr.text,
                        excerptEn: excerptEn.text,
                        bodyAr: bodyAr.text,
                        bodyEn: bodyEn.text,
                        coverImageUrl: coverImageUrl.text.isNotEmpty
                            ? coverImageUrl.text
                            : null,
                        author: author.text,
                        tags: tagList,
                        socialPlatforms: platforms.toList(),
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

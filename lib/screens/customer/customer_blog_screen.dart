import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/data/models/model_blog_post.dart';
import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:ayletna_restaurant_app/providers/marketing_blog_providers.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_empty_state.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_page_header.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_scaffold_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Customer-facing published blog list (fed by marketing publish toggles).
class CustomerBlogScreen extends ConsumerWidget {
  const CustomerBlogScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final isAr = Localizations.localeOf(context).languageCode == 'ar';
    final scheme = Theme.of(context).colorScheme;
    final posts = ref.watch(publishedBlogPostsProvider);

    return WidgetsScaffoldPage(
      title: l10n.marketingBlogTitle,
      child: ListView(
        padding: EdgeInsetsDirectional.only(bottom: CoreSpacing.xxl(context)),
        children: [
          WidgetsPageHeader(
            title: l10n.marketingBlogTitle,
            subtitle: l10n.marketingBlogPublished,
          ),
          SizedBox(height: CoreSpacing.lg(context)),
          if (posts.isEmpty)
            WidgetsEmptyState(
              message: l10n.marketingCalendarNoEvents,
              icon: Icons.article_outlined,
            )
          else
            for (final post in posts) ...[
              _BlogPostCard(post: post, isAr: isAr, scheme: scheme),
              SizedBox(height: CoreSpacing.md(context)),
            ],
        ],
      ),
    );
  }
}

class _BlogPostCard extends StatelessWidget {
  const _BlogPostCard({
    required this.post,
    required this.isAr,
    required this.scheme,
  });

  final BlogPost post;
  final bool isAr;
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    final title = isAr ? post.titleAr : post.titleEn;
    final excerpt = isAr ? post.excerptAr : post.excerptEn;
    final body = isAr ? post.bodyAr : post.bodyEn;

    return WidgetsAppCard(
      title: title,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (excerpt.trim().isNotEmpty)
            Text(
              excerpt,
              style: CoreTypography.bodyMedium(context, scheme.onSurfaceVariant),
            ),
          if (body.trim().isNotEmpty) ...[
            SizedBox(height: CoreSpacing.sm(context)),
            Text(
              body,
              style: CoreTypography.bodyMedium(context, scheme.onSurface),
            ),
          ],
          if (post.author.trim().isNotEmpty) ...[
            SizedBox(height: CoreSpacing.sm(context)),
            Text(
              post.author,
              style: CoreTypography.caption(context, scheme.primary),
            ),
          ],
        ],
      ),
    );
  }
}

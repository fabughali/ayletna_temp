import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:ayletna_restaurant_app/navigation/app_route_paths.dart';
import 'package:ayletna_restaurant_app/providers/menu_providers.dart';
import 'package:ayletna_restaurant_app/providers/reviews_admin_providers.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_cart_icon_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_icon_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_scaffold_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Full review list for the selected customer menu item (approved only).
class CustomerProductReviewsScreen extends ConsumerWidget {
  const CustomerProductReviewsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final isAr = Localizations.localeOf(context).languageCode == 'ar';
    final item = ref.watch(selectedMenuItemProvider);
    final title =
        item == null
            ? (isAr ? 'تقييمات المنتج' : 'Product reviews')
            : (isAr ? item.nameAr : item.nameEn);
    final reviews = ref.watch(approvedReviewsForProductProvider(item?.id));

    return WidgetsScaffoldPage(
      title: title,
      actions: [
        WidgetsIconButton(
          onPressed: () => context.push(AppRoutePaths.notifications),
          icon: Icons.notifications_outlined,
          tooltip: l10n.screenNotifications,
        ),
        const WidgetsCartIconButton(),
      ],
      child: ListView(
        children: [
          SizedBox(height: CoreSpacing.md(context)),
          _ReviewsHero(title: title, isAr: isAr, count: reviews.length),
          SizedBox(height: CoreSpacing.lg(context)),
          if (reviews.isEmpty)
            WidgetsAppCard(
              padding: EdgeInsets.all(CoreSpacing.lg(context)),
              child: Text(
                isAr
                    ? 'لا توجد تقييمات معتمدة بعد. قيّم طلبك بعد التوصيل.'
                    : 'No approved reviews yet. Rate your order after delivery.',
                style: CoreTypography.bodyMedium(
                  context,
                  Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            )
          else
            for (var index = 0; index < reviews.length; index++) ...[
              _ReviewListCard(review: reviews[index], isAr: isAr),
              if (index != reviews.length - 1)
                SizedBox(height: CoreSpacing.md(context)),
            ],
          SizedBox(height: CoreSpacing.xxl(context)),
        ],
      ),
    );
  }
}

class _ReviewsHero extends StatelessWidget {
  const _ReviewsHero({
    required this.title,
    required this.isAr,
    required this.count,
  });

  final String title;
  final bool isAr;
  final int count;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return WidgetsAppCard(
      variant: WidgetsAppCardVariant.food,
      padding: EdgeInsets.all(CoreSpacing.lg(context)),
      child: Row(
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              color: CoreColors.brandGold.withValues(alpha: 0.16),
              shape: BoxShape.circle,
            ),
            child: Padding(
              padding: EdgeInsets.all(CoreSpacing.md(context)),
              child: const Icon(
                Icons.rate_review_outlined,
                color: CoreColors.brandGold,
              ),
            ),
          ),
          SizedBox(width: CoreSpacing.md(context)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isAr ? 'تقييمات معتمدة' : 'Approved reviews',
                  style: CoreTypography.headlineSmall(
                    context,
                    scheme.onSurface,
                  ).copyWith(fontWeight: FontWeight.w900),
                ),
                SizedBox(height: CoreSpacing.xs(context)),
                Text(
                  isAr ? '$count تقييم لـ $title' : '$count reviews for $title',
                  style: CoreTypography.caption(
                    context,
                    scheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ReviewListCard extends StatelessWidget {
  const _ReviewListCard({required this.review, required this.isAr});

  final ProductReviewRecord review;
  final bool isAr;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return WidgetsAppCard(
      variant: WidgetsAppCardVariant.form,
      padding: EdgeInsets.all(CoreSpacing.lg(context)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                review.customerName,
                style: CoreTypography.titleMedium(
                  context,
                  scheme.onSurface,
                ).copyWith(fontWeight: FontWeight.w900),
              ),
              const Spacer(),
              Text('★' * review.rating),
            ],
          ),
          SizedBox(height: CoreSpacing.sm(context)),
          Text(
            isAr ? review.commentAr : review.commentEn,
            style: CoreTypography.bodyMedium(context, scheme.onSurfaceVariant),
          ),
        ],
      ),
    );
  }
}

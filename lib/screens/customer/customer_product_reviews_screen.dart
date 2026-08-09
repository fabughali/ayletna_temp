import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:ayletna_restaurant_app/navigation/app_route_paths.dart';
import 'package:ayletna_restaurant_app/providers/menu_providers.dart';
import 'package:ayletna_restaurant_app/providers/reviews_admin_providers.dart';
import 'package:ayletna_restaurant_app/utilities/utility_mock_feedback.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_cart_icon_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_icon_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_page_header.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_refresh_list.dart';
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
            ? l10n.productReviewsTitle
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
      child: WidgetsRefreshList(
        onRefresh: () async {
          ref.invalidate(approvedReviewsForProductProvider(item?.id));
          if (context.mounted) {
            UtilityMockFeedback.showInfo(context, l10n.productReviewsTitle);
          }
        },
        child: ListView(
        children: [
          SizedBox(height: CoreSpacing.md(context)),
          WidgetsPageHeader(
            title: l10n.productReviewsApprovedTitle,
            subtitle: l10n.productReviewsCountFor(reviews.length, title),
          ),
          if (reviews.isEmpty)
            WidgetsAppCard(
              padding: EdgeInsets.all(CoreSpacing.lg(context)),
              child: Text(
                l10n.productReviewsEmptyPrompt,
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

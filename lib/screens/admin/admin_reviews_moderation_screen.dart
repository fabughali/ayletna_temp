import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:ayletna_restaurant_app/navigation/app_route_paths.dart';
import 'package:ayletna_restaurant_app/providers/reviews_admin_providers.dart';
import 'package:ayletna_restaurant_app/utilities/utility_mock_feedback.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_icon_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_refresh_list.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_scaffold_page.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_status_pill.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Admin review moderation — approve, reject, or flag customer ratings.
class AdminReviewsModerationScreen extends ConsumerWidget {
  const AdminReviewsModerationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final isAr = Localizations.localeOf(context).languageCode == 'ar';
    final state = ref.watch(reviewsModerationProvider);
    final pending = state.pendingReviews;

    return WidgetsScaffoldPage(
      title: isAr ? 'مراجعة التقييمات' : 'Review Moderation',
      actions: [
        WidgetsIconButton(
          onPressed: () => context.push(AppRoutePaths.productReviews),
          icon: Icons.rate_review_outlined,
          tooltip: l10n.screenRatingReview,
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
              variant: WidgetsAppCardVariant.food,
              padding: EdgeInsets.all(CoreSpacing.lg(context)),
              child: Text(
                isAr
                    ? '${pending.length} تقييم بانتظار المراجعة — وافق لعرضها للعملاء أو ارفض/علّم للمتابعة.'
                    : '${pending.length} reviews awaiting moderation — approve to publish, reject or flag for follow-up.',
                style: CoreTypography.bodyMedium(
                  context,
                  Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ),
            SizedBox(height: CoreSpacing.lg(context)),
            for (final review in state.reviews) ...[
              _ReviewTile(review: review, isAr: isAr),
              SizedBox(height: CoreSpacing.md(context)),
            ],
            SizedBox(height: CoreSpacing.xxl(context)),
          ],
        ),
      ),
    );
  }
}

class _ReviewTile extends ConsumerWidget {
  const _ReviewTile({required this.review, required this.isAr});

  final ProductReviewRecord review;
  final bool isAr;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheme = Theme.of(context).colorScheme;

    return WidgetsAppCard(
      variant: WidgetsAppCardVariant.form,
      padding: EdgeInsets.all(CoreSpacing.lg(context)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  isAr ? review.productNameAr : review.productNameEn,
                  style: CoreTypography.titleMedium(
                    context,
                    scheme.onSurface,
                  ).copyWith(fontWeight: FontWeight.w900),
                ),
              ),
              WidgetsStatusPill(
                label: _statusLabel(review.status, isAr),
                color: _statusColor(review.status),
              ),
            ],
          ),
          SizedBox(height: CoreSpacing.xs(context)),
          Text(
            '${review.customerName} • ${'★' * review.rating}',
            style: CoreTypography.caption(context, scheme.onSurfaceVariant),
          ),
          SizedBox(height: CoreSpacing.sm(context)),
          Text(
            isAr ? review.commentAr : review.commentEn,
            style: CoreTypography.bodyMedium(context, scheme.onSurfaceVariant),
          ),
          if (review.status == ReviewModerationStatus.pending) ...[
            SizedBox(height: CoreSpacing.md(context)),
            Wrap(
              spacing: CoreSpacing.sm(context),
              runSpacing: CoreSpacing.sm(context),
              children: [
                WidgetsAppButton(
                  label: isAr ? 'موافقة' : 'Approve',
                  icon: Icons.check_outlined,
                  onPressed: () => _moderate(ref, context, ReviewModerationStatus.approved, isAr),
                ),
                WidgetsAppButton(
                  label: isAr ? 'رفض' : 'Reject',
                  icon: Icons.close_outlined,
                  variant: WidgetsAppButtonVariant.outline,
                  onPressed: () => _moderate(ref, context, ReviewModerationStatus.rejected, isAr),
                ),
                WidgetsAppButton(
                  label: isAr ? 'تعليم' : 'Flag',
                  icon: Icons.flag_outlined,
                  variant: WidgetsAppButtonVariant.secondary,
                  onPressed: () => _moderate(ref, context, ReviewModerationStatus.flagged, isAr),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  void _moderate(
    WidgetRef ref,
    BuildContext context,
    ReviewModerationStatus status,
    bool isAr,
  ) {
    ref.read(reviewsModerationProvider.notifier).moderate(review.id, status);
    UtilityMockFeedback.showSuccess(
      context,
      isAr ? 'تم تحديث التقييم' : 'Review updated',
    );
  }

  String _statusLabel(ReviewModerationStatus status, bool isAr) => switch (status) {
    ReviewModerationStatus.pending => isAr ? 'معلق' : 'Pending',
    ReviewModerationStatus.approved => isAr ? 'معتمد' : 'Approved',
    ReviewModerationStatus.rejected => isAr ? 'مرفوض' : 'Rejected',
    ReviewModerationStatus.flagged => isAr ? 'مُعلّم' : 'Flagged',
  };

  Color _statusColor(ReviewModerationStatus status) => switch (status) {
    ReviewModerationStatus.pending => CoreColors.brandGold,
    ReviewModerationStatus.approved => CoreColors.semanticSuccess,
    ReviewModerationStatus.rejected => CoreColors.semanticError,
    ReviewModerationStatus.flagged => CoreColors.brandOrange,
  };
}

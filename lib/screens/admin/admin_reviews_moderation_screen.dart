import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:ayletna_restaurant_app/navigation/app_route_paths.dart';
import 'package:ayletna_restaurant_app/providers/reviews_admin_providers.dart';
import 'package:ayletna_restaurant_app/utilities/utility_mock_feedback.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_hub_nav_actions.dart';
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
      title: l10n.reviewModerationTitle,
      actions: WidgetsHubNavActions.forContext(
        context,
        leading: [
          WidgetsIconButton(
            onPressed: () => context.push(AppRoutePaths.productReviews),
            icon: Icons.rate_review_outlined,
            tooltip: l10n.screenRatingReview,
          ),
        ],
      ),
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
                l10n.reviewModerationHeroBody(pending.length),
                style: CoreTypography.bodyMedium(
                  context,
                  Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ),
            SizedBox(height: CoreSpacing.lg(context)),
            for (final review in state.reviews) ...[
              _ReviewTile(review: review, l10n: l10n, isAr: isAr),
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
  const _ReviewTile({
    required this.review,
    required this.l10n,
    required this.isAr,
  });

  final ProductReviewRecord review;
  final AppLocalizations l10n;
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
                label: _statusLabel(review.status, l10n),
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
                  label: l10n.rbacApprove,
                  icon: Icons.check_outlined,
                  onPressed:
                      () => _moderate(
                        ref,
                        context,
                        ReviewModerationStatus.approved,
                        l10n,
                      ),
                ),
                WidgetsAppButton(
                  label: l10n.reviewModerationReject,
                  icon: Icons.close_outlined,
                  variant: WidgetsAppButtonVariant.outline,
                  onPressed:
                      () => _moderate(
                        ref,
                        context,
                        ReviewModerationStatus.rejected,
                        l10n,
                        confirmTitle: l10n.reviewModerationRejectConfirmTitle,
                        confirmMessage: l10n.reviewModerationRejectConfirmMessage,
                      ),
                ),
                WidgetsAppButton(
                  label: l10n.reviewModerationFlag,
                  icon: Icons.flag_outlined,
                  variant: WidgetsAppButtonVariant.secondary,
                  onPressed:
                      () => _moderate(
                        ref,
                        context,
                        ReviewModerationStatus.flagged,
                        l10n,
                        confirmTitle: l10n.reviewModerationFlagConfirmTitle,
                        confirmMessage: l10n.reviewModerationFlagConfirmMessage,
                      ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Future<void> _moderate(
    WidgetRef ref,
    BuildContext context,
    ReviewModerationStatus status,
    AppLocalizations l10n, {
    String? confirmTitle,
    String? confirmMessage,
  }) async {
    if (review.status != ReviewModerationStatus.pending) {
      UtilityMockFeedback.showError(context, l10n.reviewModerationAlreadyProcessed);
      return;
    }

    if (confirmTitle != null && confirmMessage != null) {
      final confirmed = await UtilityMockFeedback.confirm(
        context: context,
        title: confirmTitle,
        message: confirmMessage,
        confirmLabel: l10n.actionConfirm,
        cancelLabel: l10n.actionCancel,
        icon: Icons.rate_review_outlined,
      );
      if (!context.mounted || !confirmed) return;
    }

    ref.read(reviewsModerationProvider.notifier).moderate(review.id, status);
    UtilityMockFeedback.showSuccess(context, l10n.reviewModerationUpdated);
  }

  String _statusLabel(ReviewModerationStatus status, AppLocalizations l10n) =>
      switch (status) {
        ReviewModerationStatus.pending => l10n.reviewModerationStatusPending,
        ReviewModerationStatus.approved => l10n.reviewModerationStatusApproved,
        ReviewModerationStatus.rejected => l10n.reviewModerationStatusRejected,
        ReviewModerationStatus.flagged => l10n.reviewModerationStatusFlagged,
      };

  Color _statusColor(ReviewModerationStatus status) => switch (status) {
    ReviewModerationStatus.pending => CoreColors.brandGold,
    ReviewModerationStatus.approved => CoreColors.semanticSuccess,
    ReviewModerationStatus.rejected => CoreColors.semanticError,
    ReviewModerationStatus.flagged => CoreColors.brandOrange,
  };
}

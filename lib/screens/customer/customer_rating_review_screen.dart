import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/data/repositories/repository_providers.dart';
import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:ayletna_restaurant_app/navigation/app_route_paths.dart';
import 'package:ayletna_restaurant_app/providers/customer_action_providers.dart';
import 'package:ayletna_restaurant_app/providers/menu_providers.dart';
import 'package:ayletna_restaurant_app/providers/reviews_admin_providers.dart';
import 'package:ayletna_restaurant_app/providers/user_profile_providers.dart';
import 'package:ayletna_restaurant_app/utilities/utility_mock_feedback.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_text_field.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_food_media_panel.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_icon_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_scaffold_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Post-delivery customer rating loop for food quality and hospitality.
class CustomerRatingReviewScreen extends ConsumerStatefulWidget {
  const CustomerRatingReviewScreen({super.key});

  @override
  ConsumerState<CustomerRatingReviewScreen> createState() =>
      _CustomerRatingReviewScreenState();
}

class _CustomerRatingReviewScreenState
    extends ConsumerState<CustomerRatingReviewScreen> {
  int _rating = 5;
  final Set<_RatingFocus> _focus = {
    _RatingFocus.kitchen,
    _RatingFocus.delivery,
  };
  final _comment = TextEditingController();

  @override
  void dispose() {
    _comment.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return WidgetsScaffoldPage(
      title: l10n.screenRatingReview,
      actions: [
        WidgetsIconButton(
          onPressed: () => context.push(AppRoutePaths.notifications),
          icon: Icons.notifications_outlined,
          tooltip: l10n.screenNotifications,
        ),
      ],
      child: ListView(
        children: [
          SizedBox(height: CoreSpacing.md(context)),
          _RatingHero(
            rating: _rating,
            onChanged: (value) => setState(() => _rating = value),
          ),
          SizedBox(height: CoreSpacing.lg(context)),
          _OrderSnapshotCard(rating: _rating),
          SizedBox(height: CoreSpacing.lg(context)),
          _FocusCard(
            selected: _focus,
            onToggle: (focus) {
              setState(() {
                if (_focus.contains(focus)) {
                  _focus.remove(focus);
                } else {
                  _focus.add(focus);
                }
              });
            },
          ),
          SizedBox(height: CoreSpacing.lg(context)),
          _CommentCard(controller: _comment),
          SizedBox(height: CoreSpacing.lg(context)),
          WidgetsAppButton(
            label: l10n.ratingSubmit,
            onPressed: () async {
              final orderDetail = await ref.read(ratingOrderDetailProvider.future);
              if (!context.mounted || orderDetail.lines.isEmpty) return;
              final line = orderDetail.lines.first;
              final isAr = Localizations.localeOf(context).languageCode == 'ar';
              final profile = ref.read(userProfileProvider);
              final menuItemId =
                  ref.read(selectedMenuItemIdProvider) ?? line.itemId;
              final ok = ref.read(reviewsModerationProvider.notifier).submitReview(
                ProductReviewRecord(
                  id: nextReviewId(),
                  productNameEn: line.nameEn,
                  productNameAr: line.nameAr,
                  customerName:
                      isAr ? profile.displayNameAr : profile.displayNameEn,
                  rating: _rating,
                  commentEn:
                      _comment.text.isEmpty ? 'Great experience' : _comment.text,
                  commentAr:
                      _comment.text.isEmpty ? 'تجربة رائعة' : _comment.text,
                  status: ReviewModerationStatus.pending,
                  submittedAt: DateTime.now(),
                  orderId: orderDetail.id,
                  menuItemId: menuItemId,
                ),
              );
              if (!context.mounted) return;
              if (!ok) {
                UtilityMockFeedback.showWarning(context, l10n.ratingCommentLabel);
                return;
              }
              ref.read(ratingOrderIdProvider.notifier).state = null;
              UtilityMockFeedback.showSuccess(context, l10n.ratingSuccess);
              context.go(AppRoutePaths.loyalty);
            },
            icon: Icons.stars_outlined,
            fullWidth: true,
          ),
          SizedBox(height: CoreSpacing.md(context)),
          WidgetsAppButton(
            label: l10n.ratingReviewLater,
            onPressed: () => context.go(AppRoutePaths.orderHistory),
            icon: Icons.history_outlined,
            variant: WidgetsAppButtonVariant.outline,
            fullWidth: true,
          ),
          SizedBox(height: CoreSpacing.xxl(context)),
        ],
      ),
    );
  }
}

enum _RatingFocus { kitchen, delivery, packaging }

class _RatingHero extends StatelessWidget {
  const _RatingHero({required this.rating, required this.onChanged});

  final int rating;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;

    return WidgetsAppCard(
      variant: WidgetsAppCardVariant.food,
      padding: EdgeInsets.all(CoreSpacing.lg(context)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          WidgetsFoodMediaPanel(
            height: CoreContentSizes.heroImageHeight(context),
            badge: _FoodTag(
              label: l10n.ratingRewardLoop,
              color: CoreColors.brandGold,
            ),
            child: CustomPaint(
              painter: _RatingDishPainter(
                color: scheme.primary,
                accent: CoreColors.brandGold,
              ),
              child: Center(
                child: Icon(
                  Icons.rate_review_outlined,
                  color: scheme.primary,
                  size: CoreContentSizes.categoryMenuImageIcon(context),
                ),
              ),
            ),
          ),
          SizedBox(height: CoreSpacing.lg(context)),
          Text(
            l10n.ratingHeroTitle,
            style: CoreTypography.headlineLarge(
              context,
              scheme.onSurface,
            ).copyWith(fontWeight: FontWeight.w900),
          ),
          SizedBox(height: CoreSpacing.sm(context)),
          Text(
            l10n.ratingHeroSubtitle,
            style: CoreTypography.bodyMedium(context, scheme.onSurfaceVariant),
          ),
          SizedBox(height: CoreSpacing.md(context)),
          _StarSelector(rating: rating, onChanged: onChanged),
        ],
      ),
    );
  }
}

class _StarSelector extends StatelessWidget {
  const _StarSelector({required this.rating, required this.onChanged});

  final int rating;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (var index = 1; index <= 5; index++)
          IconButton(
            onPressed: () => onChanged(index),
            icon: Icon(
              index <= rating ? Icons.star_rounded : Icons.star_outline_rounded,
            ),
            color: CoreColors.brandGold,
            iconSize: CoreContentSizes.orderTypeIcon(context) * 1.55,
          ),
      ],
    );
  }
}

class _OrderSnapshotCard extends ConsumerWidget {
  const _OrderSnapshotCard({required this.rating});

  final int rating;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    final orderAsync = ref.watch(ratingOrderDetailProvider);

    return orderAsync.when(
      loading:
          () => WidgetsAppCard(
            variant: WidgetsAppCardVariant.form,
            padding: EdgeInsets.all(CoreSpacing.lg(context)),
            child: const Center(child: CircularProgressIndicator()),
          ),
      error:
          (_, __) => WidgetsAppCard(
            variant: WidgetsAppCardVariant.form,
            padding: EdgeInsets.all(CoreSpacing.lg(context)),
            child: Text(l10n.comingSoon),
          ),
      data:
          (order) => WidgetsAppCard(
            variant: WidgetsAppCardVariant.form,
            padding: EdgeInsets.all(CoreSpacing.lg(context)),
            child: Row(
              children: [
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: scheme.primary.withValues(alpha: 0.12),
                    shape: BoxShape.circle,
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(CoreSpacing.md(context)),
                    child: Icon(Icons.room_service_outlined, color: scheme.primary),
                  ),
                ),
                SizedBox(width: CoreSpacing.md(context)),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.ratingOrderLabel,
                        style: CoreTypography.caption(
                          context,
                          scheme.onSurfaceVariant,
                        ),
                      ),
                      SizedBox(height: CoreSpacing.xs(context)),
                      Text(
                        order.reference,
                        style: CoreTypography.titleMedium(
                          context,
                          scheme.onSurface,
                        ).copyWith(fontWeight: FontWeight.w900),
                      ),
                    ],
                  ),
                ),
                _FoodTag(label: '$rating/5', color: CoreColors.brandGold),
              ],
            ),
          ),
    );
  }
}

class _FocusCard extends StatelessWidget {
  const _FocusCard({required this.selected, required this.onToggle});

  final Set<_RatingFocus> selected;
  final ValueChanged<_RatingFocus> onToggle;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return WidgetsAppCard(
      variant: WidgetsAppCardVariant.food,
      padding: EdgeInsets.all(CoreSpacing.lg(context)),
      child: Wrap(
        spacing: CoreSpacing.sm(context),
        runSpacing: CoreSpacing.sm(context),
        children: [
          _FocusChip(
            label: l10n.ratingKitchenTitle,
            icon: Icons.soup_kitchen_outlined,
            selected: selected.contains(_RatingFocus.kitchen),
            onTap: () => onToggle(_RatingFocus.kitchen),
          ),
          _FocusChip(
            label: l10n.ratingDeliveryTitle,
            icon: Icons.delivery_dining_outlined,
            selected: selected.contains(_RatingFocus.delivery),
            onTap: () => onToggle(_RatingFocus.delivery),
          ),
          _FocusChip(
            label: l10n.ratingPackagingTitle,
            icon: Icons.inventory_2_outlined,
            selected: selected.contains(_RatingFocus.packaging),
            onTap: () => onToggle(_RatingFocus.packaging),
          ),
        ],
      ),
    );
  }
}

class _FocusChip extends StatelessWidget {
  const _FocusChip({
    required this.label,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final color = selected ? scheme.primary : scheme.onSurfaceVariant;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(CoreSpacing.radiusChip),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: color.withValues(alpha: selected ? 0.14 : 0.08),
          borderRadius: BorderRadius.circular(CoreSpacing.radiusChip),
          border: Border.all(color: color.withValues(alpha: 0.22)),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: CoreSpacing.md(context),
            vertical: CoreSpacing.sm(context),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                color: color,
                size: CoreContentSizes.orderTypeIcon(context),
              ),
              SizedBox(width: CoreSpacing.xs(context)),
              Text(
                label,
                style: CoreTypography.caption(
                  context,
                  color,
                ).copyWith(fontWeight: FontWeight.w900),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CommentCard extends StatelessWidget {
  const _CommentCard({required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return WidgetsAppCard(
      variant: WidgetsAppCardVariant.form,
      padding: EdgeInsets.all(CoreSpacing.lg(context)),
      child: WidgetsAppTextField(
        controller: controller,
        label: l10n.ratingCommentLabel,
        hintText: l10n.ratingCommentHint,
        prefixIcon: Icons.chat_bubble_outline,
        maxLines: 3,
      ),
    );
  }
}

class _FoodTag extends StatelessWidget {
  const _FoodTag({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(CoreSpacing.radiusChip),
        border: Border.all(color: color.withValues(alpha: 0.24)),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: CoreSpacing.sm(context),
          vertical: CoreSpacing.xs(context),
        ),
        child: Text(
          label,
          style: CoreTypography.caption(
            context,
            scheme.onSurface,
          ).copyWith(fontWeight: FontWeight.w800),
        ),
      ),
    );
  }
}

class _RatingDishPainter extends CustomPainter {
  const _RatingDishPainter({required this.color, required this.accent});

  final Color color;
  final Color accent;

  @override
  void paint(Canvas canvas, Size size) {
    final plate = Paint()..color = color.withValues(alpha: 0.12);
    final rim =
        Paint()
          ..color = color.withValues(alpha: 0.25)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2.2;
    final garnish = Paint()..color = accent.withValues(alpha: 0.34);
    final center = Offset(size.width * 0.5, size.height * 0.56);
    final radius = size.shortestSide * 0.30;
    canvas.drawCircle(center, radius, plate);
    canvas.drawCircle(center, radius, rim);
    canvas.drawCircle(
      Offset(size.width * 0.36, size.height * 0.42),
      radius * 0.15,
      garnish,
    );
    canvas.drawCircle(
      Offset(size.width * 0.62, size.height * 0.43),
      radius * 0.13,
      garnish,
    );
    canvas.drawCircle(
      Offset(size.width * 0.52, size.height * 0.68),
      radius * 0.15,
      garnish,
    );
  }

  @override
  bool shouldRepaint(covariant _RatingDishPainter oldDelegate) {
    return oldDelegate.color != color || oldDelegate.accent != accent;
  }
}

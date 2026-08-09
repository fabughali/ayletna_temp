import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/data/mockup/mockup_catalog.dart';
import 'package:ayletna_restaurant_app/data/models/model_admin_catalog.dart';
import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:ayletna_restaurant_app/navigation/app_route_paths.dart';
import 'package:ayletna_restaurant_app/providers/admin_catalog_providers.dart';
import 'package:ayletna_restaurant_app/providers/marketing_campaign_providers.dart';
import 'package:ayletna_restaurant_app/providers/marketing_publish_providers.dart';
import 'package:ayletna_restaurant_app/utilities/utility_catalog_images.dart';
import 'package:ayletna_restaurant_app/utilities/utility_confirm_dialog.dart';
import 'package:ayletna_restaurant_app/utilities/utility_mock_feedback.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_text_field.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_campaign_create_fields.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_campaign_schedule_sheet.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_catalog_image_editor.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_icon_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_mock_food_image.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_points_image_badge.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_catalog_product_cards.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_food_catalog_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_scaffold_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

/// Marketing offers — campaign-gated visibility, points-only reward value.
class AdminOffersManagementScreen extends ConsumerWidget {
  const AdminOffersManagementScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final isAr = Localizations.localeOf(context).languageCode == 'ar';

    return WidgetsScaffoldPage(
      title: l10n.screenOffersManagement,
      actions: [
        WidgetsIconButton(
          onPressed: () => context.push(AppRoutePaths.offers),
          icon: Icons.local_offer_outlined,
          tooltip: l10n.screenOffers,
        ),
      ],
      child: ListView(
        padding: EdgeInsets.all(CoreSpacing.md(context)),
        children: [
          _AddOfferSection(isAr: isAr),
          SizedBox(height: CoreSpacing.lg(context)),
          _OffersListSection(isAr: isAr),
        ],
      ),
    );
  }
}

class _AddOfferSection extends ConsumerStatefulWidget {
  const _AddOfferSection({required this.isAr});
  final bool isAr;

  @override
  ConsumerState<_AddOfferSection> createState() => _AddOfferSectionState();
}

class _AddOfferSectionState extends ConsumerState<_AddOfferSection> {
  bool _expanded = false;
  final _titleEn = TextEditingController();
  final _titleAr = TextEditingController();
  final _subtitleEn = TextEditingController();
  final _subtitleAr = TextEditingController();
  final _badgeEn = TextEditingController();
  final _badgeAr = TextEditingController();
  final _rewardPoints = TextEditingController(text: '0');
  List<String> _offerImages = const [];
  String? _campaignId;

  @override
  void dispose() {
    _titleEn.dispose();
    _titleAr.dispose();
    _subtitleEn.dispose();
    _subtitleAr.dispose();
    _badgeEn.dispose();
    _badgeAr.dispose();
    _rewardPoints.dispose();
    super.dispose();
  }

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
          InkWell(
            onTap: () => setState(() => _expanded = !_expanded),
            borderRadius: BorderRadius.circular(CoreSpacing.radiusButtonOf(context)),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: CoreSpacing.xs(context)),
              child: Row(
                children: [
                  DecoratedBox(
                    decoration: BoxDecoration(
                      color: CoreColors.brandGold.withValues(alpha: 0.14),
                      borderRadius:
                          BorderRadius.circular(CoreSpacing.radiusButtonOf(context)),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(CoreSpacing.md(context)),
                      child: Icon(
                        Icons.add_outlined,
                        color: CoreColors.brandGold,
                      ),
                    ),
                  ),
                  SizedBox(width: CoreSpacing.md(context)),
                  Expanded(
                    child: Text(
                      l10n.promoMgmtNewOffer,
                      style: CoreTypography.titleMedium(
                        context,
                        scheme.onSurface,
                      ).copyWith(fontWeight: FontWeight.w900),
                    ),
                  ),
                  Icon(
                    _expanded
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: scheme.onSurfaceVariant,
                  ),
                ],
              ),
            ),
          ),
          if (_expanded) ...[
            SizedBox(height: CoreSpacing.md(context)),
            WidgetsAppTextField(
              controller: _titleEn,
              label: l10n.catalogCrudNameEn,
            ),
            SizedBox(height: CoreSpacing.sm(context)),
            WidgetsAppTextField(
              controller: _titleAr,
              label: l10n.catalogCrudNameAr,
            ),
            SizedBox(height: CoreSpacing.sm(context)),
            WidgetsAppTextField(
              controller: _subtitleEn,
              label: l10n.catalogCrudDescriptionEn,
              maxLines: 2,
            ),
            SizedBox(height: CoreSpacing.sm(context)),
            WidgetsAppTextField(
              controller: _subtitleAr,
              label: l10n.catalogCrudDescriptionAr,
              maxLines: 2,
            ),
            SizedBox(height: CoreSpacing.sm(context)),
            WidgetsAppTextField(
              controller: _badgeEn,
              label: l10n.marketingBadgeEn,
            ),
            SizedBox(height: CoreSpacing.sm(context)),
            WidgetsAppTextField(
              controller: _badgeAr,
              label: l10n.marketingBadgeAr,
            ),
            SizedBox(height: CoreSpacing.sm(context)),
            WidgetsAppTextField(
              controller: _rewardPoints,
              label: l10n.marketingRewardPointsLabel,
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: CoreSpacing.sm(context)),
            WidgetsCatalogImageEditor(
              imageUrls: _offerImages,
              onChanged: (urls) => setState(() => _offerImages = urls),
              isAr: widget.isAr,
            ),
            SizedBox(height: CoreSpacing.md(context)),
            WidgetsCampaignCreateFields(
              kind: CampaignEntityKind.offer,
              campaignId: _campaignId,
              onCampaignIdChanged: (id) => setState(() => _campaignId = id),
            ),
            SizedBox(height: CoreSpacing.md(context)),
            WidgetsAppButton(
              label: l10n.actionAdd,
              icon: Icons.add_outlined,
              onPressed: _submit,
            ),
          ],
        ],
      ),
    );
  }

  void _submit() {
    final l10n = AppLocalizations.of(context)!;
    if (_offerImages.length < CatalogImageLimits.minProductImages) {
      UtilityMockFeedback.showWarning(
        context,
        l10n.productEditorAddMinImages,
      );
      return;
    }
    final offerId = nextCatalogId('offer');
    final campaignId = _campaignId;
    final ok = ref.read(adminCatalogProvider.notifier).addOffer(
      ModelCatalogOffer(
        id: offerId,
        titleEn: _titleEn.text,
        titleAr: _titleAr.text,
        subtitleEn: _subtitleEn.text,
        subtitleAr: _subtitleAr.text.isNotEmpty ? _subtitleAr.text : null,
        badgeEn: _badgeEn.text.isNotEmpty ? _badgeEn.text : null,
        badgeAr: _badgeAr.text.isNotEmpty ? _badgeAr.text : null,
        rewardPoints: int.tryParse(_rewardPoints.text) ?? 0,
        imageUrls: _offerImages,
        active: false,
        campaignId: campaignId,
      ),
    );
    if (!mounted) return;
    if (ok) {
      if (campaignId != null && campaignId.isNotEmpty) {
        attachEntityToCampaign(
          ref: ref,
          campaignId: campaignId,
          kind: CampaignEntityKind.offer,
          entityId: offerId,
        );
      }
      ref.read(marketingPublishProvider.notifier).submitForApproval(
            kindKey: 'offer',
            titleEn: _titleEn.text,
            titleAr: _titleAr.text,
            entityId: offerId,
          );
      _titleEn.clear();
      _titleAr.clear();
      _subtitleEn.clear();
      _subtitleAr.clear();
      _badgeEn.clear();
      _badgeAr.clear();
      _rewardPoints.text = '0';
      setState(() {
        _offerImages = const [];
        _campaignId = null;
        _expanded = false;
      });
      UtilityMockFeedback.showSuccess(context, l10n.marketingPublishSubmitted);
    } else {
      UtilityMockFeedback.showWarning(context, l10n.catalogCrudCheckFields);
    }
  }
}

class _OffersListSection extends ConsumerWidget {
  const _OffersListSection({required this.isAr});
  final bool isAr;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final offers = ref.watch(adminCatalogProvider).resolvedOffers;

    if (offers.isEmpty) {
      return WidgetsAppCard(
        variant: WidgetsAppCardVariant.food,
        padding: EdgeInsets.all(CoreSpacing.lg(context)),
        child: Text(
          l10n.catalogBrowseEmpty,
          textAlign: TextAlign.center,
          style: CoreTypography.bodyMedium(
            context,
            Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
      );
    }

    return WidgetsFoodCatalogGrid(
      children: [
        for (var i = 0; i < offers.length; i++)
          _MarketingOfferCard(offer: offers[i], isAr: isAr, index: i),
      ],
    );
  }
}

class _MarketingOfferCard extends ConsumerWidget {
  const _MarketingOfferCard({
    required this.offer,
    required this.isAr,
    required this.index,
  });

  final ModelCatalogOffer offer;
  final bool isAr;
  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;

    return Stack(
      fit: StackFit.expand,
      children: [
        WidgetsOfferProductCard.fromOffer(
          offer: offer,
          isAr: isAr,
          l10n: l10n,
          index: index,
          actionLabel: l10n.actionEdit,
          actionIcon: Icons.edit_outlined,
          onAction: () => _editOffer(context, ref, offer),
          onTap: () => _editOffer(context, ref, offer),
        ),
        Positioned(
          top: CoreSpacing.sm(context),
          right: CoreSpacing.sm(context),
          child: Material(
            color: Colors.black45,
            shape: const CircleBorder(),
            child: PopupMenuButton<String>(
              icon: const Icon(Icons.more_vert, color: Colors.white),
              onSelected: (value) async {
                if (value == 'edit') {
                  _editOffer(context, ref, offer);
                } else if (value == 'campaign') {
                  await _scheduleCampaign(context, ref, offer);
                } else if (value == 'delete') {
                  confirmAdminDelete(
                    context,
                    isAr: isAr,
                    onConfirmed:
                        () => ref
                            .read(adminCatalogProvider.notifier)
                            .deleteOffer(offer.id),
                  );
                }
              },
              itemBuilder:
                  (_) => [
                    PopupMenuItem(
                      value: 'edit',
                      child: Text(l10n.actionEdit),
                    ),
                    PopupMenuItem(
                      value: 'campaign',
                      child: Text(l10n.marketingCampaignAdjust),
                    ),
                    PopupMenuItem(
                      value: 'delete',
                      child: Text(l10n.addressesDelete),
                    ),
                  ],
            ),
          ),
        ),
      ],
    );
  }

    String _campaignLabel(
    WidgetRef ref,
    String? campaignId,
    bool isAr,
    AppLocalizations l10n,
  ) {
    final events = ref.watch(marketingCampaignEventsProvider);
    final fmt = DateFormat.MMMd(l10n.localeName).add_jm();
    if (campaignId != null) {
      for (final e in events) {
        if (e.id == campaignId) {
          return '${e.title(isAr)} · ${fmt.format(e.startAt)} → ${fmt.format(e.endAt)}';
        }
      }
    }
    for (final e in events) {
      if (e.offerIds.contains(offer.id)) {
        return '${e.title(isAr)} · ${fmt.format(e.startAt)} → ${fmt.format(e.endAt)}';
      }
    }
    return l10n.marketingVisibilityNeedsSchedule;
  }

  Future<void> _onVisibilityChanged(
    BuildContext context,
    WidgetRef ref,
    ModelCatalogOffer offer,
    bool show,
  ) async {
    final l10n = AppLocalizations.of(context)!;
    if (!show) {
      ref.read(adminCatalogProvider.notifier).updateOffer(
            offer.copyWith(active: false),
          );
      return;
    }
    final campaignId = await showCampaignScheduleSheet(
      context: context,
      ref: ref,
      kind: CampaignEntityKind.offer,
      entityId: offer.id,
      currentCampaignId: offer.campaignId,
    );
    if (!context.mounted) return;
    if (campaignId == null) {
      UtilityMockFeedback.showWarning(
        context,
        l10n.marketingVisibilityNeedsSchedule,
      );
      return;
    }
    ref.read(adminCatalogProvider.notifier).updateOffer(
          offer.copyWith(active: true, campaignId: campaignId),
        );
    UtilityMockFeedback.showSuccess(context, l10n.catalogCrudUpdated);
  }

  Future<void> _scheduleCampaign(
    BuildContext context,
    WidgetRef ref,
    ModelCatalogOffer offer,
  ) async {
    final l10n = AppLocalizations.of(context)!;
    final campaignId = await showCampaignScheduleSheet(
      context: context,
      ref: ref,
      kind: CampaignEntityKind.offer,
      entityId: offer.id,
      currentCampaignId: offer.campaignId,
    );
    if (!context.mounted || campaignId == null) return;
    ref.read(adminCatalogProvider.notifier).updateOffer(
          offer.copyWith(campaignId: campaignId),
        );
    UtilityMockFeedback.showSuccess(context, l10n.catalogCrudUpdated);
  }

  void _editOffer(
    BuildContext context,
    WidgetRef ref,
    ModelCatalogOffer offer,
  ) {
    final l10n = AppLocalizations.of(context)!;
    final titleEn = TextEditingController(text: offer.titleEn);
    final titleAr = TextEditingController(text: offer.titleAr);
    final subtitleEn = TextEditingController(text: offer.subtitleEn);
    final subtitleAr = TextEditingController(text: offer.subtitleAr);
    final badgeEn = TextEditingController(text: offer.badgeEn);
    final badgeAr = TextEditingController(text: offer.badgeAr);
    final rewardPoints = TextEditingController(
      text: '${offer.rewardPoints}',
    );
    var imageUrls = [...offer.imageUrls];

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder:
          (ctx) => StatefulBuilder(
            builder:
                (ctx, setSheetState) => Padding(
                  padding: EdgeInsets.only(
                    left: CoreSpacing.lg(ctx),
                    right: CoreSpacing.lg(ctx),
                    top: CoreSpacing.lg(ctx),
                    bottom:
                        MediaQuery.viewInsetsOf(ctx).bottom +
                        CoreSpacing.lg(ctx),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        WidgetsAppTextField(
                          controller: titleEn,
                          label: l10n.catalogCrudNameEn,
                        ),
                        SizedBox(height: CoreSpacing.sm(ctx)),
                        WidgetsAppTextField(
                          controller: titleAr,
                          label: l10n.catalogCrudNameAr,
                        ),
                        SizedBox(height: CoreSpacing.sm(ctx)),
                        WidgetsAppTextField(
                          controller: subtitleEn,
                          label: l10n.catalogCrudDescriptionEn,
                          maxLines: 2,
                        ),
                        SizedBox(height: CoreSpacing.sm(ctx)),
                        WidgetsAppTextField(
                          controller: subtitleAr,
                          label: l10n.catalogCrudDescriptionAr,
                          maxLines: 2,
                        ),
                        SizedBox(height: CoreSpacing.sm(ctx)),
                        WidgetsAppTextField(
                          controller: badgeEn,
                          label: l10n.marketingBadgeEn,
                        ),
                        SizedBox(height: CoreSpacing.sm(ctx)),
                        WidgetsAppTextField(
                          controller: badgeAr,
                          label: l10n.marketingBadgeAr,
                        ),
                        SizedBox(height: CoreSpacing.sm(ctx)),
                        WidgetsAppTextField(
                          controller: rewardPoints,
                          label: l10n.marketingRewardPointsLabel,
                          keyboardType: TextInputType.number,
                        ),
                        SizedBox(height: CoreSpacing.sm(ctx)),
                        WidgetsCatalogImageEditor(
                          imageUrls: imageUrls,
                          onChanged:
                              (urls) => setSheetState(() => imageUrls = urls),
                          isAr: isAr,
                        ),
                        SizedBox(height: CoreSpacing.md(ctx)),
                        WidgetsAppButton(
                          label: l10n.marketingCampaignAdjust,
                          variant: WidgetsAppButtonVariant.outline,
                          onPressed: () async {
                            Navigator.pop(ctx);
                            await _scheduleCampaign(context, ref, offer);
                          },
                        ),
                        SizedBox(height: CoreSpacing.sm(ctx)),
                        WidgetsAppButton(
                          label: l10n.actionSave,
                          onPressed: () {
                            if (imageUrls.length <
                                CatalogImageLimits.minProductImages) {
                              UtilityMockFeedback.showWarning(
                                ctx,
                                l10n.catalogCrudMinOneImage,
                              );
                              return;
                            }
                            final ok = ref
                                .read(adminCatalogProvider.notifier)
                                .updateOffer(
                                  offer.copyWith(
                                    titleEn: titleEn.text,
                                    titleAr: titleAr.text,
                                    subtitleEn: subtitleEn.text,
                                    subtitleAr:
                                        subtitleAr.text.isNotEmpty
                                            ? subtitleAr.text
                                            : null,
                                    badgeEn:
                                        badgeEn.text.isNotEmpty
                                            ? badgeEn.text
                                            : null,
                                    badgeAr:
                                        badgeAr.text.isNotEmpty
                                            ? badgeAr.text
                                            : null,
                                    rewardPoints:
                                        int.tryParse(rewardPoints.text) ??
                                        offer.rewardPoints,
                                    imageUrls: imageUrls,
                                    clearPromoCode: true,
                                    clearDiscountPercent: true,
                                  ),
                                );
                            if (ok) {
                              Navigator.pop(ctx);
                              UtilityMockFeedback.showSuccess(
                                context,
                                l10n.catalogCrudUpdated,
                              );
                            } else {
                              UtilityMockFeedback.showWarning(
                                ctx,
                                l10n.catalogCrudUpdateFailed,
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

class _OfferTag extends StatelessWidget {
  const _OfferTag({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(CoreSpacing.radiusChipOf(context)),
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

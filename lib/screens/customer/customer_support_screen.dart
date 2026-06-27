import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/data/mockup/mockup_catalog.dart';
import 'package:ayletna_restaurant_app/data/models/model_support_ticket_record.dart';
import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:ayletna_restaurant_app/navigation/app_route_paths.dart';
import 'package:ayletna_restaurant_app/providers/support_session_providers.dart';
import 'package:ayletna_restaurant_app/utilities/utility_mock_feedback.dart';
import 'package:ayletna_restaurant_app/utilities/utility_url_actions.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_text_field.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_icon_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_scaffold_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Customer support destination for cart and order-help actions.
class CustomerSupportScreen extends ConsumerStatefulWidget {
  const CustomerSupportScreen({super.key});

  @override
  ConsumerState<CustomerSupportScreen> createState() =>
      _CustomerSupportScreenState();
}

class _CustomerSupportScreenState extends ConsumerState<CustomerSupportScreen> {
  final _titleEn = TextEditingController();
  final _titleAr = TextEditingController();
  final _bodyEn = TextEditingController();
  final _bodyAr = TextEditingController();

  @override
  void dispose() {
    _titleEn.dispose();
    _titleAr.dispose();
    _bodyEn.dispose();
    _bodyAr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    final isAr = Localizations.localeOf(context).languageCode == 'ar';
    final tickets = ref.watch(supportTicketsProvider).tickets;

    return WidgetsScaffoldPage(
      title: l10n.screenSupport,
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
          WidgetsAppCard(
            variant: WidgetsAppCardVariant.food,
            padding: EdgeInsets.all(CoreSpacing.lg(context)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: scheme.primary.withValues(alpha: 0.12),
                    shape: BoxShape.circle,
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(CoreSpacing.md(context)),
                    child: Icon(
                      Icons.support_agent_outlined,
                      color: scheme.primary,
                    ),
                  ),
                ),
                SizedBox(height: CoreSpacing.lg(context)),
                Text(
                  l10n.supportHeroTitle,
                  style: CoreTypography.headlineLarge(
                    context,
                    scheme.onSurface,
                  ).copyWith(fontWeight: FontWeight.w900),
                ),
                SizedBox(height: CoreSpacing.sm(context)),
                Text(
                  l10n.supportHeroBody,
                  style: CoreTypography.bodyMedium(
                    context,
                    scheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: CoreSpacing.lg(context)),
          _SupportActionGrid(
            actions: [
              _SupportActionData(
                title: l10n.supportLiveChatTitle,
                body: l10n.supportLiveChatBody,
                icon: Icons.chat_bubble_outline,
                color: scheme.primary,
                onTap: () => context.push(AppRoutePaths.supportChat),
              ),
              _SupportActionData(
                title: l10n.supportCallTitle,
                body: l10n.supportCallBody,
                icon: Icons.call_outlined,
                color: CoreColors.orderTypeDineIn,
                onTap:
                    () => _launchContact(
                      context,
                      Uri(
                        scheme: 'tel',
                        path: MockupCatalog.restaurantPhoneNumber,
                      ),
                      MockupCatalog.restaurantPhoneNumber,
                    ),
              ),
              _SupportActionData(
                title: l10n.supportWhatsappTitle,
                body: l10n.supportWhatsappBody,
                icon: Icons.mark_unread_chat_alt_outlined,
                color: CoreColors.brandOlive,
                onTap:
                    () => _launchContact(
                      context,
                      Uri.https(
                        'wa.me',
                        '/${MockupCatalog.restaurantWhatsappNumber}',
                        {'text': l10n.supportWhatsappBody},
                      ),
                      '+${MockupCatalog.restaurantWhatsappNumber}',
                    ),
              ),
              _SupportActionData(
                title: l10n.supportFaqTitle,
                body: l10n.supportFaqBody,
                icon: Icons.help_outline,
                color: CoreColors.brandGold,
                onTap: () => context.push(AppRoutePaths.faq),
              ),
            ],
          ),
          SizedBox(height: CoreSpacing.lg(context)),
          _CreateTicketCard(
            isAr: isAr,
            titleEn: _titleEn,
            titleAr: _titleAr,
            bodyEn: _bodyEn,
            bodyAr: _bodyAr,
            onSubmit: () {
              final ticket = ref.read(supportTicketsProvider.notifier).createTicket(
                titleAr: _titleAr.text,
                titleEn: _titleEn.text,
                bodyAr: _bodyAr.text,
                bodyEn: _bodyEn.text,
              );
              if (ticket == null) {
                UtilityMockFeedback.showWarning(
                  context,
                  isAr ? 'أدخل العنوان والوصف' : 'Enter title and description',
                );
                return;
              }
              _titleEn.clear();
              _titleAr.clear();
              _bodyEn.clear();
              _bodyAr.clear();
              UtilityMockFeedback.showSuccess(context, l10n.supportTicketOpened);
            },
          ),
          SizedBox(height: CoreSpacing.lg(context)),
          _SupportTicketsCard(tickets: tickets, ref: ref),
          SizedBox(height: CoreSpacing.md(context)),
          WidgetsAppCard(
            variant: WidgetsAppCardVariant.form,
            padding: EdgeInsets.all(CoreSpacing.lg(context)),
            child: Row(
              children: [
                Icon(
                  Icons.admin_panel_settings_outlined,
                  color: scheme.primary,
                ),
                SizedBox(width: CoreSpacing.md(context)),
                Expanded(
                  child: Text(
                    l10n.supportAdminSetupNote,
                    style: CoreTypography.caption(
                      context,
                      scheme.onSurfaceVariant,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: CoreSpacing.xxl(context)),
        ],
      ),
    );
  }

  Future<void> _launchContact(
    BuildContext context,
    Uri uri,
    String fallback,
  ) async {
    final l10n = AppLocalizations.of(context)!;
    final launched = await UtilityUrlActions.launchExternalUri(uri);
    if (!launched && context.mounted) {
      UtilityMockFeedback.showWarning(
        context,
        '${l10n.supportExternalActionFallback} $fallback',
      );
    }
  }
}

class _SupportActionGrid extends StatelessWidget {
  const _SupportActionGrid({required this.actions});

  final List<_SupportActionData> actions;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final spacing = CoreSpacing.md(context);
        final useTwoColumns = constraints.maxWidth >= 720;
        final itemWidth =
            useTwoColumns
                ? (constraints.maxWidth - spacing) / 2
                : constraints.maxWidth;

        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: [
            for (final action in actions)
              SizedBox(
                width: itemWidth,
                child: _SupportActionCard(action: action),
              ),
          ],
        );
      },
    );
  }
}

class _SupportActionData {
  const _SupportActionData({
    required this.title,
    required this.body,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  final String title;
  final String body;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;
}

class _SupportActionCard extends StatelessWidget {
  const _SupportActionCard({required this.action});

  final _SupportActionData action;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return WidgetsAppCard(
      variant: WidgetsAppCardVariant.form,
      padding: EdgeInsets.all(CoreSpacing.lg(context)),
      onTap: action.onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              color: action.color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(CoreSpacing.radiusCard),
              border: Border.all(color: action.color.withValues(alpha: 0.20)),
            ),
            child: Padding(
              padding: EdgeInsets.all(CoreSpacing.md(context)),
              child: Icon(action.icon, color: action.color),
            ),
          ),
          SizedBox(height: CoreSpacing.lg(context)),
          Text(
            action.title,
            style: CoreTypography.titleMedium(
              context,
              scheme.onSurface,
            ).copyWith(fontWeight: FontWeight.w900),
          ),
          SizedBox(height: CoreSpacing.xs(context)),
          Text(
            action.body,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: CoreTypography.caption(context, scheme.onSurfaceVariant),
          ),
          SizedBox(height: CoreSpacing.md(context)),
          Align(
            alignment: AlignmentDirectional.centerEnd,
            child: Icon(Icons.arrow_forward, color: action.color),
          ),
        ],
      ),
    );
  }
}

class _CreateTicketCard extends StatelessWidget {
  const _CreateTicketCard({
    required this.isAr,
    required this.titleEn,
    required this.titleAr,
    required this.bodyEn,
    required this.bodyAr,
    required this.onSubmit,
  });

  final bool isAr;
  final TextEditingController titleEn;
  final TextEditingController titleAr;
  final TextEditingController bodyEn;
  final TextEditingController bodyAr;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    return WidgetsAppCard(
      variant: WidgetsAppCardVariant.form,
      padding: EdgeInsets.all(CoreSpacing.lg(context)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            isAr ? 'فتح تذكرة دعم' : 'Open support ticket',
            style: CoreTypography.titleMedium(
              context,
              Theme.of(context).colorScheme.onSurface,
            ).copyWith(fontWeight: FontWeight.w900),
          ),
          SizedBox(height: CoreSpacing.md(context)),
          WidgetsAppTextField(
            controller: titleEn,
            label: isAr ? 'العنوان (EN)' : 'Title (EN)',
          ),
          SizedBox(height: CoreSpacing.sm(context)),
          WidgetsAppTextField(
            controller: titleAr,
            label: isAr ? 'العنوان (AR)' : 'Title (AR)',
          ),
          SizedBox(height: CoreSpacing.sm(context)),
          WidgetsAppTextField(
            controller: bodyEn,
            label: isAr ? 'الوصف (EN)' : 'Description (EN)',
            maxLines: 3,
          ),
          SizedBox(height: CoreSpacing.sm(context)),
          WidgetsAppTextField(
            controller: bodyAr,
            label: isAr ? 'الوصف (AR)' : 'Description (AR)',
            maxLines: 3,
          ),
          SizedBox(height: CoreSpacing.md(context)),
          WidgetsAppButton(
            label: isAr ? 'إرسال التذكرة' : 'Submit ticket',
            icon: Icons.send_outlined,
            onPressed: onSubmit,
          ),
        ],
      ),
    );
  }
}

class _SupportTicketsCard extends StatelessWidget {
  const _SupportTicketsCard({required this.tickets, required this.ref});

  final List<ModelSupportTicketRecord> tickets;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    final isAr = Localizations.localeOf(context).languageCode == 'ar';

    return WidgetsAppCard(
      variant: WidgetsAppCardVariant.food,
      padding: EdgeInsets.all(CoreSpacing.lg(context)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            l10n.supportTicketsTitle,
            style: CoreTypography.titleMedium(
              context,
              scheme.onSurface,
            ).copyWith(fontWeight: FontWeight.w900),
          ),
          SizedBox(height: CoreSpacing.xs(context)),
          Text(
            l10n.supportTicketsSubtitle,
            style: CoreTypography.caption(context, scheme.onSurfaceVariant),
          ),
          SizedBox(height: CoreSpacing.md(context)),
          if (tickets.isEmpty)
            Padding(
              padding: EdgeInsets.symmetric(vertical: CoreSpacing.md(context)),
              child: Text(
                isAr
                    ? 'لا توجد تذاكر بعد. أنشئ تذكرة جديدة أعلاه.'
                    : 'No tickets yet. Create one using the form above.',
                style: CoreTypography.bodyMedium(
                  context,
                  scheme.onSurfaceVariant,
                ),
              ),
            )
          else
            for (final ticket in tickets) ...[
            _SupportTicketTile(
              ticket: ticket,
              isAr: isAr,
              onTap: () => _showTicketDetails(context, ticket, isAr, ref),
            ),
            if (ticket != tickets.last)
              SizedBox(height: CoreSpacing.sm(context)),
          ],
        ],
      ),
    );
  }

  void _showTicketDetails(
    BuildContext context,
    ModelSupportTicketRecord ticket,
    bool isAr,
    WidgetRef ref,
  ) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      showDragHandle: true,
      builder:
          (_) => ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.sizeOf(context).height * 0.82,
            ),
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(
                CoreSpacing.lg(context),
                0,
                CoreSpacing.lg(context),
                CoreSpacing.lg(context) +
                    MediaQuery.viewInsetsOf(context).bottom,
              ),
              child: Consumer(
                builder: (context, ref, _) {
                  final live =
                      ref.watch(supportTicketByIdProvider(ticket.id)) ?? ticket;
                  return _SupportTicketDetails(
                    ticket: live,
                    isAr: isAr,
                    ref: ref,
                  );
                },
              ),
            ),
          ),
    );
  }
}

String _formatUpdated(DateTime updatedAt, bool isAr) {
  final diff = DateTime.now().difference(updatedAt);
  if (diff.inMinutes < 60) {
    return isAr ? 'منذ ${diff.inMinutes} د' : '${diff.inMinutes}m ago';
  }
  if (diff.inHours < 24) {
    return isAr ? 'منذ ${diff.inHours} س' : '${diff.inHours}h ago';
  }
  return isAr ? 'منذ ${diff.inDays} ي' : '${diff.inDays}d ago';
}

class _SupportTicketTile extends StatelessWidget {
  const _SupportTicketTile({
    required this.ticket,
    required this.isAr,
    required this.onTap,
  });

  final ModelSupportTicketRecord ticket;
  final bool isAr;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return WidgetsAppCard(
      variant: WidgetsAppCardVariant.form,
      padding: EdgeInsets.all(CoreSpacing.md(context)),
      onTap: onTap,
      child: Row(
        children: [
          Icon(Icons.confirmation_number_outlined, color: scheme.primary),
          SizedBox(width: CoreSpacing.md(context)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${ticket.id} • ${isAr ? ticket.titleAr : ticket.titleEn}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: CoreTypography.caption(
                    context,
                    scheme.onSurface,
                  ).copyWith(fontWeight: FontWeight.w900),
                ),
                SizedBox(height: CoreSpacing.xs(context)),
                Text(
                  isAr ? ticket.bodyAr : ticket.bodyEn,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: CoreTypography.caption(
                    context,
                    scheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: CoreSpacing.sm(context)),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                isAr ? ticket.statusLabelAr() : ticket.statusLabelEn(),
                style: CoreTypography.caption(
                  context,
                  scheme.primary,
                ).copyWith(fontWeight: FontWeight.w900),
              ),
              Text(
                _formatUpdated(ticket.updatedAt, isAr),
                style: CoreTypography.caption(context, scheme.onSurfaceVariant),
              ),
            ],
          ),
          SizedBox(width: CoreSpacing.xs(context)),
          Icon(Icons.chevron_right, color: scheme.onSurfaceVariant),
        ],
      ),
    );
  }
}

class _SupportTicketDetails extends StatefulWidget {
  const _SupportTicketDetails({
    required this.ticket,
    required this.isAr,
    required this.ref,
  });

  final ModelSupportTicketRecord ticket;
  final bool isAr;
  final WidgetRef ref;

  @override
  State<_SupportTicketDetails> createState() => _SupportTicketDetailsState();
}

class _SupportTicketDetailsState extends State<_SupportTicketDetails> {
  var _rating = 0;
  final _remark = TextEditingController();
  final _reply = TextEditingController();

  @override
  void dispose() {
    _remark.dispose();
    _reply.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    final ticket = widget.ticket;
    final isAr = widget.isAr;
    final canRate = ticket.canCustomerRate;

    return WidgetsAppCard(
      variant: WidgetsAppCardVariant.food,
      padding: EdgeInsets.all(CoreSpacing.lg(context)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            '${ticket.id} • ${isAr ? ticket.statusLabelAr() : ticket.statusLabelEn()}',
            style: CoreTypography.titleMedium(
              context,
              scheme.onSurface,
            ).copyWith(fontWeight: FontWeight.w900),
          ),
          SizedBox(height: CoreSpacing.sm(context)),
          Text(
            isAr ? ticket.titleAr : ticket.titleEn,
            style: CoreTypography.bodyMedium(
              context,
              scheme.onSurface,
            ).copyWith(fontWeight: FontWeight.w900),
          ),
          SizedBox(height: CoreSpacing.sm(context)),
          Text(
            isAr ? ticket.bodyAr : ticket.bodyEn,
            style: CoreTypography.bodyMedium(context, scheme.onSurfaceVariant),
          ),
          if (ticket.messages.length > 1) ...[
            SizedBox(height: CoreSpacing.md(context)),
            for (final msg in ticket.messages.skip(1))
              Padding(
                padding: EdgeInsets.only(bottom: CoreSpacing.sm(context)),
                child: Text(
                  '${msg.isStaff ? (isAr ? 'الدعم: ' : 'Support: ') : ''}${isAr ? msg.bodyAr : msg.bodyEn}',
                  style: CoreTypography.caption(context, scheme.onSurfaceVariant),
                ),
              ),
          ],
          SizedBox(height: CoreSpacing.sm(context)),
          Text(
            _formatUpdated(ticket.updatedAt, isAr),
            style: CoreTypography.caption(
              context,
              scheme.primary,
            ).copyWith(fontWeight: FontWeight.w900),
          ),
          SizedBox(height: CoreSpacing.lg(context)),
          if (canRate)
            _ClosedTicketFeedback(
              rating: _rating,
              remark: _remark,
              onRatingChanged: (value) => setState(() => _rating = value),
              onSubmit: () {
                if (_rating < 1) return;
                final ok = widget.ref
                    .read(supportTicketsProvider.notifier)
                    .submitCustomerFeedback(
                      ticketId: ticket.id,
                      rating: _rating,
                      feedback: _remark.text,
                    );
                if (!ok) {
                  UtilityMockFeedback.showWarning(
                    context,
                    isAr
                        ? 'لا يمكن التقييم حتى يتم حل التذكرة'
                        : 'Rate only after ticket is resolved',
                  );
                  return;
                }
                UtilityMockFeedback.showSuccess(
                  context,
                  l10n.supportTicketRatingSaved,
                );
                Navigator.pop(context);
              },
            )
          else if (ticket.customerRating != null)
            Text(
              '${isAr ? 'تقييمك' : 'Your rating'}: ${ticket.customerRating}/5',
              style: CoreTypography.bodyMedium(context, scheme.onSurface),
            )
          else if (ticket.status == SupportTicketStatus.waitingCustomer)
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                WidgetsAppTextField(
                  controller: _reply,
                  label: isAr ? 'ردك' : 'Your reply',
                  maxLines: 2,
                ),
                SizedBox(height: CoreSpacing.md(context)),
                WidgetsAppButton(
                  label: isAr ? 'إرسال الرد' : 'Send reply',
                  icon: Icons.send_outlined,
                  onPressed: () {
                    final ok = widget.ref
                        .read(supportTicketsProvider.notifier)
                        .addCustomerReply(
                          ticketId: ticket.id,
                          bodyAr: _reply.text,
                          bodyEn: _reply.text,
                        );
                    if (!ok) return;
                    _reply.clear();
                    UtilityMockFeedback.showSuccess(
                      context,
                      l10n.supportTicketActionSent,
                    );
                  },
                ),
              ],
            )
          else
            _ActiveTicketActions(
              ticketId: ticket.id,
              ref: widget.ref,
              isAr: isAr,
            ),
        ],
      ),
    );
  }
}

class _ActiveTicketActions extends StatelessWidget {
  const _ActiveTicketActions({
    required this.ticketId,
    required this.ref,
    required this.isAr,
  });

  final String ticketId;
  final WidgetRef ref;
  final bool isAr;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final notifier = ref.read(supportTicketsProvider.notifier);

    return Wrap(
      spacing: CoreSpacing.sm(context),
      runSpacing: CoreSpacing.sm(context),
      children: [
        WidgetsAppButton(
          label: l10n.supportTicketRequestFollowUp,
          onPressed: () {
            if (notifier.requestFollowUp(ticketId)) {
              UtilityMockFeedback.showSuccess(context, l10n.supportTicketActionSent);
            }
          },
          icon: Icons.update_outlined,
          variant: WidgetsAppButtonVariant.secondary,
        ),
        WidgetsAppButton(
          label: l10n.supportTicketUrgent,
          onPressed: () {
            if (notifier.markUrgent(ticketId)) {
              UtilityMockFeedback.showSuccess(context, l10n.supportTicketActionSent);
            }
          },
          icon: Icons.priority_high_outlined,
          variant: WidgetsAppButtonVariant.outline,
        ),
        WidgetsAppButton(
          label: l10n.supportTicketCancel,
          onPressed: () {
            if (notifier.cancelTicket(ticketId)) {
              UtilityMockFeedback.showSuccess(context, l10n.supportTicketActionSent);
              Navigator.pop(context);
            }
          },
          icon: Icons.cancel_outlined,
          variant: WidgetsAppButtonVariant.danger,
        ),
      ],
    );
  }
}

class _ClosedTicketFeedback extends StatelessWidget {
  const _ClosedTicketFeedback({
    required this.rating,
    required this.remark,
    required this.onRatingChanged,
    required this.onSubmit,
  });

  final int rating;
  final TextEditingController remark;
  final ValueChanged<int> onRatingChanged;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          l10n.supportTicketRateResponse,
          style: CoreTypography.bodyMedium(
            context,
            scheme.onSurface,
          ).copyWith(fontWeight: FontWeight.w900),
        ),
        SizedBox(height: CoreSpacing.sm(context)),
        Wrap(
          spacing: CoreSpacing.xs(context),
          runSpacing: CoreSpacing.xs(context),
          children: [
            for (var index = 1; index <= 5; index++)
              SizedBox.square(
                dimension: 42,
                child: IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () => onRatingChanged(index),
                  icon: Icon(
                    index <= rating ? Icons.star_rounded : Icons.star_outline,
                    color:
                        index <= rating
                            ? CoreColors.brandGold
                            : scheme.onSurfaceVariant,
                  ),
                ),
              ),
          ],
        ),
        SizedBox(height: CoreSpacing.md(context)),
        WidgetsAppTextField(
          controller: remark,
          label: l10n.supportTicketRemarkLabel,
          hintText: l10n.supportTicketRemarkHint,
          prefixIcon: Icons.rate_review_outlined,
          maxLines: 3,
        ),
        SizedBox(height: CoreSpacing.md(context)),
        WidgetsAppButton(
          label: l10n.supportTicketSubmitRating,
          onPressed: onSubmit,
          icon: Icons.check_circle_outline,
          fullWidth: true,
        ),
      ],
    );
  }
}

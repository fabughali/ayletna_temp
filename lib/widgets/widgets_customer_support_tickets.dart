import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/data/models/model_support_ticket_record.dart';
import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:ayletna_restaurant_app/providers/support_session_providers.dart';
import 'package:ayletna_restaurant_app/utilities/utility_mock_feedback.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Shared customer ticket list helpers (view / reply / rate — no create).
abstract final class UtilityCustomerSupportTickets {
  static String formatUpdated(DateTime updatedAt, AppLocalizations l10n) {
    final diff = DateTime.now().difference(updatedAt);
    if (diff.inMinutes < 60) {
      return l10n.timeAgoMinutes(diff.inMinutes);
    }
    if (diff.inHours < 24) {
      return l10n.timeAgoHours(diff.inHours);
    }
    return l10n.timeAgoDays(diff.inDays);
  }

  static Future<void> showTicketDetails({
    required BuildContext context,
    required ModelSupportTicketRecord ticket,
    required bool isAr,
  }) {
    final l10n = AppLocalizations.of(context)!;
    return showModalBottomSheet<void>(
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
                  return _TicketDetails(
                    ticket: live,
                    isAr: isAr,
                    ref: ref,
                    l10n: l10n,
                  );
                },
              ),
            ),
          ),
    );
  }
}

class WidgetsCustomerSupportTicketTile extends StatelessWidget {
  const WidgetsCustomerSupportTicketTile({
    required this.ticket,
    required this.isAr,
    required this.onTap,
    super.key,
  });

  final ModelSupportTicketRecord ticket;
  final bool isAr;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context)!;

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
                UtilityCustomerSupportTickets.formatUpdated(
                  ticket.updatedAt,
                  l10n,
                ),
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

class _TicketDetails extends StatefulWidget {
  const _TicketDetails({
    required this.ticket,
    required this.isAr,
    required this.ref,
    required this.l10n,
  });

  final ModelSupportTicketRecord ticket;
  final bool isAr;
  final WidgetRef ref;
  final AppLocalizations l10n;

  @override
  State<_TicketDetails> createState() => _TicketDetailsState();
}

class _TicketDetailsState extends State<_TicketDetails> {
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
    final l10n = widget.l10n;
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
                  '${msg.isStaff ? l10n.supportMessageStaffPrefix : ''}${isAr ? msg.bodyAr : msg.bodyEn}',
                  style: CoreTypography.caption(
                    context,
                    scheme.onSurfaceVariant,
                  ),
                ),
              ),
          ],
          SizedBox(height: CoreSpacing.sm(context)),
          Text(
            UtilityCustomerSupportTickets.formatUpdated(ticket.updatedAt, l10n),
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
                    l10n.supportRateAfterResolved,
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
              '${l10n.supportYourRating}: ${ticket.customerRating}/5',
              style: CoreTypography.bodyMedium(context, scheme.onSurface),
            )
          else if (ticket.status == SupportTicketStatus.waitingCustomer)
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                WidgetsAppTextField(
                  controller: _reply,
                  label: l10n.supportYourReply,
                  maxLines: 2,
                ),
                SizedBox(height: CoreSpacing.md(context)),
                WidgetsAppButton(
                  label: l10n.supportSendReply,
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
  });

  final String ticketId;
  final WidgetRef ref;

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
              UtilityMockFeedback.showSuccess(
                context,
                l10n.supportTicketActionSent,
              );
            }
          },
          icon: Icons.update_outlined,
          variant: WidgetsAppButtonVariant.secondary,
        ),
        WidgetsAppButton(
          label: l10n.supportTicketUrgent,
          onPressed: () {
            if (notifier.markUrgent(ticketId)) {
              UtilityMockFeedback.showSuccess(
                context,
                l10n.supportTicketActionSent,
              );
            }
          },
          icon: Icons.priority_high_outlined,
          variant: WidgetsAppButtonVariant.outline,
        ),
        WidgetsAppButton(
          label: l10n.supportTicketCancel,
          onPressed: () {
            if (notifier.cancelTicket(ticketId)) {
              UtilityMockFeedback.showSuccess(
                context,
                l10n.supportTicketActionSent,
              );
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

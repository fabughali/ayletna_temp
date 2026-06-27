import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:ayletna_restaurant_app/navigation/app_route_paths.dart';
import 'package:ayletna_restaurant_app/providers/support_session_providers.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_text_field.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_icon_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_scaffold_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

/// Live chat that can escalate into a tracked support ticket.
class CustomerSupportChatScreen extends ConsumerStatefulWidget {
  const CustomerSupportChatScreen({super.key});

  @override
  ConsumerState<CustomerSupportChatScreen> createState() =>
      _CustomerSupportChatScreenState();
}

class _CustomerSupportChatScreenState extends ConsumerState<CustomerSupportChatScreen> {
  final _message = TextEditingController();

  @override
  void dispose() {
    _message.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    final isAr = Localizations.localeOf(context).languageCode == 'ar';
    final chat = ref.watch(supportChatProvider);
    final linkedId = chat.linkedTicketId;
    final linkedTicket =
        linkedId == null ? null : ref.watch(supportTicketByIdProvider(linkedId));

    return WidgetsScaffoldPage(
      title: l10n.supportLiveChatTitle,
      actions: [
        WidgetsIconButton(
          onPressed: () => context.push(AppRoutePaths.support),
          icon: Icons.confirmation_number_outlined,
          tooltip: l10n.supportTicketsTitle,
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
                Icon(Icons.support_agent_outlined, color: scheme.primary),
                SizedBox(height: CoreSpacing.md(context)),
                Text(
                  l10n.supportChatHeroTitle,
                  style: CoreTypography.headlineLarge(
                    context,
                    scheme.onSurface,
                  ).copyWith(fontWeight: FontWeight.w900),
                ),
                SizedBox(height: CoreSpacing.sm(context)),
                Text(
                  linkedTicket == null
                      ? l10n.supportChatHeroBody
                      : (isAr
                          ? 'تذكرة مرتبطة: ${linkedTicket.id}'
                          : 'Linked ticket: ${linkedTicket.id}'),
                  style: CoreTypography.bodyMedium(
                    context,
                    scheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: CoreSpacing.lg(context)),
          _ChatBubble(
            text: l10n.supportChatAgentGreeting,
            senderName: l10n.supportChatAgentName,
            timestamp: _formatTime(DateTime.now(), isAr),
            fromAgent: true,
            status: _ChatMessageStatus.sent,
          ),
          if (linkedTicket == null)
            for (final entry in chat.messages) ...[
              SizedBox(height: CoreSpacing.sm(context)),
              _ChatBubble(
                text: entry.text,
                senderName:
                    entry.fromAgent
                        ? l10n.supportChatAgentName
                        : (isAr ? 'أنت' : 'You'),
                timestamp: _formatTime(entry.sentAt, isAr),
                fromAgent: entry.fromAgent,
                status: _ChatMessageStatus.sent,
              ),
            ],
          if (linkedTicket != null)
            for (final msg in linkedTicket.messages) ...[
              SizedBox(height: CoreSpacing.sm(context)),
              _ChatBubble(
                text: isAr ? msg.bodyAr : msg.bodyEn,
                senderName:
                    msg.isStaff
                        ? l10n.supportChatAgentName
                        : (isAr ? 'أنت' : 'You'),
                timestamp: _formatTime(msg.sentAt, isAr),
                fromAgent: msg.isStaff,
                status: _ChatMessageStatus.delivered,
              ),
            ],
          SizedBox(height: CoreSpacing.lg(context)),
          WidgetsAppCard(
            variant: WidgetsAppCardVariant.form,
            padding: EdgeInsets.all(CoreSpacing.lg(context)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                WidgetsAppTextField(
                  controller: _message,
                  label: l10n.supportChatMessageLabel,
                  hintText: l10n.supportChatMessageHint,
                  prefixIcon: Icons.chat_bubble_outline,
                  maxLines: 3,
                ),
                SizedBox(height: CoreSpacing.md(context)),
                WidgetsAppButton(
                  label: l10n.supportChatSend,
                  onPressed: () => _sendMessage(isAr, l10n),
                  icon: Icons.send_outlined,
                  fullWidth: true,
                ),
                if (linkedId == null) ...[
                  SizedBox(height: CoreSpacing.sm(context)),
                  WidgetsAppButton(
                    label: isAr ? 'فتح تذكرة دعم' : 'Open support ticket',
                    onPressed: () => _openTicket(isAr, l10n),
                    icon: Icons.confirmation_number_outlined,
                    variant: WidgetsAppButtonVariant.secondary,
                    fullWidth: true,
                  ),
                ],
              ],
            ),
          ),
          SizedBox(height: CoreSpacing.xxl(context)),
        ],
      ),
    );
  }

  String _formatTime(DateTime time, bool isAr) {
    final locale = isAr ? 'ar' : 'en';
    return DateFormat.jm(locale).format(time);
  }

  void _sendMessage(bool isAr, AppLocalizations l10n) {
    if (_message.text.trim().isEmpty) return;
    final text = _message.text.trim();
    final linkedId = ref.read(supportChatProvider).linkedTicketId;
    if (linkedId != null) {
      ref.read(supportTicketsProvider.notifier).addCustomerReply(
        ticketId: linkedId,
        bodyAr: text,
        bodyEn: text,
      );
    } else {
      ref.read(supportChatProvider.notifier).sendCustomerMessage(text, isAr: isAr);
    }
    _message.clear();
  }

  void _openTicket(bool isAr, AppLocalizations l10n) {
    final chat = ref.read(supportChatProvider);
    final draft = _message.text.trim();
    final customerLines =
        chat.messages.where((m) => !m.fromAgent).map((m) => m.text).toList();
    if (draft.isNotEmpty) customerLines.add(draft);
    final body =
        customerLines.isEmpty
            ? (isAr ? 'طلب مساعدة من الدردشة المباشرة' : 'Help request from live chat')
            : customerLines.join('\n');
    final ticket = ref.read(supportTicketsProvider.notifier).createTicket(
      titleAr: isAr ? 'دردشة مباشرة' : 'Live chat',
      titleEn: 'Live chat',
      bodyAr: body,
      bodyEn: body,
    );
    if (ticket == null) return;
    for (final line in customerLines.skip(1)) {
      ref.read(supportTicketsProvider.notifier).addCustomerReply(
        ticketId: ticket.id,
        bodyAr: line,
        bodyEn: line,
      );
    }
    ref.read(supportChatProvider.notifier).linkTicket(ticket.id);
    _message.clear();
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(l10n.supportTicketOpened)),
    );
  }
}

enum _ChatMessageStatus { sent, delivered }

class _ChatBubble extends StatelessWidget {
  const _ChatBubble({
    required this.text,
    required this.senderName,
    required this.timestamp,
    required this.fromAgent,
    required this.status,
  });

  final String text;
  final String senderName;
  final String timestamp;
  final bool fromAgent;
  final _ChatMessageStatus status;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final color = fromAgent ? scheme.primary : CoreColors.brandOlive;

    return Align(
      alignment:
          fromAgent ? AlignmentDirectional.centerStart : AlignmentDirectional.centerEnd,
      child: Container(
        constraints: BoxConstraints(maxWidth: MediaQuery.sizeOf(context).width * 0.78),
        margin: EdgeInsets.symmetric(horizontal: CoreSpacing.lg(context)),
        padding: EdgeInsets.all(CoreSpacing.md(context)),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.10),
          borderRadius: BorderRadius.circular(CoreSpacing.radiusCard),
          border: Border.all(color: color.withValues(alpha: 0.22)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              senderName,
              style: CoreTypography.caption(context, color).copyWith(
                fontWeight: FontWeight.w900,
              ),
            ),
            SizedBox(height: CoreSpacing.xs(context)),
            Text(text, style: CoreTypography.bodyMedium(context, scheme.onSurface)),
            SizedBox(height: CoreSpacing.xs(context)),
            Text(timestamp, style: CoreTypography.caption(context, scheme.onSurfaceVariant)),
          ],
        ),
      ),
    );
  }
}

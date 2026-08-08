import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:ayletna_restaurant_app/navigation/app_route_paths.dart';
import 'package:ayletna_restaurant_app/providers/support_session_providers.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_text_field.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_icon_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_page_header.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_scaffold_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

/// Customer live chat — messaging only; tickets are created by support staff.
class CustomerSupportChatScreen extends ConsumerStatefulWidget {
  const CustomerSupportChatScreen({super.key});

  @override
  ConsumerState<CustomerSupportChatScreen> createState() =>
      _CustomerSupportChatScreenState();
}

class _CustomerSupportChatScreenState
    extends ConsumerState<CustomerSupportChatScreen> {
  final _message = TextEditingController();
  final _scrollController = ScrollController();
  int _lastMessageCount = -1;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToLatest(animate: false);
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _message.dispose();
    super.dispose();
  }

  void _scrollToLatest({bool animate = true}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || !_scrollController.hasClients) return;
      final max = _scrollController.position.maxScrollExtent;
      if (animate) {
        _scrollController.animateTo(
          max,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
        );
      } else {
        _scrollController.jumpTo(max);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isAr = Localizations.localeOf(context).languageCode == 'ar';
    final chat = ref.watch(supportChatProvider);
    final linkedId = chat.linkedTicketId;
    final linkedTicket =
        linkedId == null
            ? null
            : ref.watch(supportTicketByIdProvider(linkedId));

    final scheme = Theme.of(context).colorScheme;
    final messageCount =
        linkedTicket == null
            ? chat.messages.length
            : linkedTicket.messages.length;
    // Greeting bubble is always present (+1). Scroll when thread grows or opens.
    final threadLength = messageCount + 1;
    if (threadLength != _lastMessageCount) {
      final firstPaint = _lastMessageCount < 0;
      _lastMessageCount = threadLength;
      _scrollToLatest(animate: !firstPaint);
    }

    return WidgetsScaffoldPage(
      title: l10n.supportLiveChatTitle,
      actions: [
        WidgetsIconButton(
          onPressed: () => context.push(AppRoutePaths.supportTickets),
          icon: Icons.confirmation_number_outlined,
          tooltip: l10n.supportTicketsTitle,
        ),
      ],
      child: SizedBox.expand(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                controller: _scrollController,
                primary: false,
                padding: EdgeInsetsDirectional.only(
                  bottom: CoreSpacing.md(context),
                ),
                children: [
                  SizedBox(height: CoreSpacing.md(context)),
                  WidgetsPageHeader(
                    title: l10n.supportChatHeroTitle,
                    subtitle:
                        linkedTicket == null
                            ? l10n.supportChatHeroBody
                            : l10n.supportChatLinkedTicket(linkedTicket.id),
                    eyebrow: l10n.supportLiveChatTitle,
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
                                : l10n.supportChatYou,
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
                                : l10n.supportChatYou,
                        timestamp: _formatTime(msg.sentAt, isAr),
                        fromAgent: msg.isStaff,
                        status: _ChatMessageStatus.delivered,
                      ),
                    ],
                  SizedBox(height: CoreSpacing.lg(context)),
                ],
              ),
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                color: scheme.surface,
                border: Border(top: BorderSide(color: scheme.outlineVariant)),
              ),
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                  CoreSpacing.md(context),
                  CoreSpacing.sm(context),
                  CoreSpacing.md(context),
                  CoreSpacing.sm(context),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: WidgetsAppTextField(
                        controller: _message,
                        label: l10n.supportChatMessageLabel,
                        hintText: l10n.supportChatMessageHint,
                        prefixIcon: Icons.chat_bubble_outline,
                        showLabel: false,
                        minLines: 1,
                        maxLines: 5,
                        textInputAction: TextInputAction.send,
                        onSubmitted: (_) => _sendMessage(isAr, l10n),
                      ),
                    ),
                    SizedBox(width: CoreSpacing.sm(context)),
                    WidgetsIconButton(
                      onPressed: () => _sendMessage(isAr, l10n),
                      icon: Icons.send_rounded,
                      tooltip: l10n.supportChatSend,
                      variant: WidgetsIconButtonVariant.filled,
                      buttonSize: context.coreTheme.buttonMinHeight,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatTime(DateTime time, bool isAr) {
    final locale = isAr ? 'ar' : 'en';
    final date = DateFormat('dd.MM.yyyy', locale).format(time);
    final clock = DateFormat.jm(locale).format(time);
    return '$date · $clock';
  }

  void _sendMessage(bool isAr, AppLocalizations l10n) {
    if (_message.text.trim().isEmpty) return;
    final text = _message.text.trim();
    final linkedId = ref.read(supportChatProvider).linkedTicketId;
    if (linkedId != null) {
      ref
          .read(supportTicketsProvider.notifier)
          .addCustomerReply(ticketId: linkedId, bodyAr: text, bodyEn: text);
    } else {
      ref
          .read(supportChatProvider.notifier)
          .sendCustomerMessage(text, isAr: isAr);
    }
    _message.clear();
    _scrollToLatest();
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
          fromAgent
              ? AlignmentDirectional.centerStart
              : AlignmentDirectional.centerEnd,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.sizeOf(context).width * 0.78,
        ),
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
              style: CoreTypography.caption(
                context,
                color,
              ).copyWith(fontWeight: FontWeight.w900),
            ),
            SizedBox(height: CoreSpacing.xs(context)),
            Text(
              text,
              style: CoreTypography.bodyMedium(context, scheme.onSurface),
            ),
            SizedBox(height: CoreSpacing.xs(context)),
            Text(
              timestamp,
              style: CoreTypography.caption(context, scheme.onSurfaceVariant),
            ),
          ],
        ),
      ),
    );
  }
}

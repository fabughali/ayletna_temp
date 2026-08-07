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
import 'package:ayletna_restaurant_app/widgets/widgets_customer_support_tickets.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_icon_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_page_header.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_scaffold_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Customer support destination — chat/contact/FAQ + view existing tickets.
class CustomerSupportScreen extends ConsumerWidget {
  const CustomerSupportScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
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
          WidgetsPageHeader(
            title: l10n.supportHeroTitle,
            subtitle: l10n.supportHeroBody,
          ),
          WidgetsAppCard(
            variant: WidgetsAppCardVariant.food,
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
                    child: Icon(
                      Icons.support_agent_outlined,
                      color: scheme.primary,
                    ),
                  ),
                ),
                SizedBox(width: CoreSpacing.md(context)),
                Expanded(
                  child: Text(
                    l10n.screenSupport,
                    style: CoreTypography.titleMedium(
                      context,
                      scheme.onSurface,
                    ).copyWith(fontWeight: FontWeight.w900),
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
          _SupportTicketsCard(tickets: tickets),
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
              borderRadius: BorderRadius.circular(CoreSpacing.radiusCardOf(context)),
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

class _SupportTicketsCard extends StatelessWidget {
  const _SupportTicketsCard({required this.tickets});

  static const _previewLimit = 3;

  final List<ModelSupportTicketRecord> tickets;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    final isAr = Localizations.localeOf(context).languageCode == 'ar';
    final preview = tickets.take(_previewLimit).toList();

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
                l10n.supportTicketsEmpty,
                style: CoreTypography.bodyMedium(
                  context,
                  scheme.onSurfaceVariant,
                ),
              ),
            )
          else
            for (final ticket in preview) ...[
              WidgetsCustomerSupportTicketTile(
                ticket: ticket,
                isAr: isAr,
                onTap:
                    () => UtilityCustomerSupportTickets.showTicketDetails(
                      context: context,
                      ticket: ticket,
                      isAr: isAr,
                    ),
              ),
              if (ticket != preview.last)
                SizedBox(height: CoreSpacing.sm(context)),
            ],
          SizedBox(height: CoreSpacing.md(context)),
          WidgetsAppButton(
            label: l10n.supportViewMoreTickets,
            onPressed: () => context.push(AppRoutePaths.supportTickets),
            icon: Icons.list_alt_outlined,
            variant: WidgetsAppButtonVariant.outline,
            fullWidth: true,
          ),
        ],
      ),
    );
  }
}

import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:ayletna_restaurant_app/providers/support_session_providers.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_customer_support_tickets.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_page_header.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_refresh_list.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_scaffold_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Full customer tickets list — view existing tickets only.
class CustomerSupportTicketsScreen extends ConsumerWidget {
  const CustomerSupportTicketsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    final isAr = Localizations.localeOf(context).languageCode == 'ar';
    final tickets = ref.watch(supportTicketsProvider).tickets;

    return WidgetsScaffoldPage(
      title: l10n.supportTicketsTitle,
      child: WidgetsRefreshList(
        onRefresh: () async {
          ref.read(supportTicketsProvider.notifier).refreshQueue();
        },
        child: ListView(
          children: [
            SizedBox(height: CoreSpacing.md(context)),
            WidgetsPageHeader(
              title: l10n.supportTicketsTitle,
              subtitle: l10n.supportTicketsSubtitle,
              eyebrow: l10n.screenSupport,
            ),
            SizedBox(height: CoreSpacing.lg(context)),
            if (tickets.isEmpty)
              WidgetsAppCard(
                padding: EdgeInsets.all(CoreSpacing.lg(context)),
                child: Text(
                  l10n.supportTicketsEmpty,
                  style: CoreTypography.bodyMedium(
                    context,
                    scheme.onSurfaceVariant,
                  ),
                ),
              )
            else
              for (final ticket in tickets) ...[
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
                if (ticket != tickets.last)
                  SizedBox(height: CoreSpacing.sm(context)),
              ],
            SizedBox(height: CoreSpacing.xxl(context)),
          ],
        ),
      ),
    );
  }
}

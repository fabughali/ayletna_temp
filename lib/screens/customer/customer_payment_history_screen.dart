import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/data/models/model_customer_order_history.dart';
import 'package:ayletna_restaurant_app/data/repositories/repository_providers.dart';
import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:ayletna_restaurant_app/navigation/app_route_paths.dart';
import 'package:ayletna_restaurant_app/utilities/utility_format_jod.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_icon_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_error_message.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_page_header.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_price_badge.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_refresh_list.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_scaffold_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Customer payment history from order repository.
class CustomerPaymentHistoryScreen extends ConsumerWidget {
  const CustomerPaymentHistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    final isAr = Localizations.localeOf(context).languageCode == 'ar';
    final ordersAsync = ref.watch(customerOrderHistoryProvider);

    return WidgetsScaffoldPage(
      title: l10n.screenPaymentHistory,
      child: WidgetsRefreshList(
        onRefresh: () async {
          ref.invalidate(customerOrderHistoryProvider);
        },
        child: ordersAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error:
              (e, _) =>
                  Center(child: WidgetsErrorMessage(message: e.toString())),
          data:
              (orders) => _PaymentHistoryList(
                orders: orders.where((o) => !o.isCancelled).toList(),
                l10n: l10n,
                isAr: isAr,
                scheme: scheme,
              ),
        ),
      ),
    );
  }
}

class _PaymentHistoryList extends StatelessWidget {
  const _PaymentHistoryList({
    required this.orders,
    required this.l10n,
    required this.isAr,
    required this.scheme,
  });

  final List<ModelCustomerOrderHistory> orders;
  final AppLocalizations l10n;
  final bool isAr;
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SizedBox(height: CoreSpacing.md(context)),
        WidgetsPageHeader(
          title: l10n.profilePaymentHistory,
          subtitle: l10n.profilePaymentHistorySubtitle,
          eyebrow: l10n.screenPaymentHistory,
        ),
        SizedBox(height: CoreSpacing.lg(context)),
        if (orders.isEmpty)
          WidgetsAppCard(
            padding: EdgeInsets.all(CoreSpacing.lg(context)),
            child: Text(
              l10n.paymentHistoryEmpty,
              style: CoreTypography.bodyMedium(
                context,
                scheme.onSurfaceVariant,
              ),
            ),
          )
        else
          for (final order in orders) ...[
            WidgetsAppCard(
              variant: WidgetsAppCardVariant.form,
              padding: EdgeInsets.all(CoreSpacing.lg(context)),
              leading: Icon(Icons.receipt_long_outlined, color: scheme.primary),
              title: isAr ? order.labelAr : order.labelEn,
              trailing: WidgetsPriceBadge(
                priceLabel: UtilityFormatJod.format(
                  order.totalJod,
                  suffix: l10n.currencyJod,
                ),
                compact: true,
              ),
              child: Text(
                isAr ? order.dateAr : order.dateEn,
                style: CoreTypography.caption(context, scheme.onSurfaceVariant),
              ),
            ),
            SizedBox(height: CoreSpacing.md(context)),
          ],
        SizedBox(height: CoreSpacing.xxl(context)),
      ],
    );
  }
}

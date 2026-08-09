import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:ayletna_restaurant_app/navigation/app_route_paths.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_cart_icon_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_icon_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_page_header.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_scaffold_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Customer-facing terms and conditions screen for checkout decisions.
class CustomerTermsScreen extends StatelessWidget {
  const CustomerTermsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return WidgetsScaffoldPage(
      title: l10n.orderTypeTerms,
      actions: [
        WidgetsIconButton(
          onPressed: () => context.push(AppRoutePaths.notifications),
          icon: Icons.notifications_outlined,
          tooltip: l10n.screenNotifications,
        ),
        const WidgetsCartIconButton(),
      ],
      child: ListView(
        children: [
          SizedBox(height: CoreSpacing.md(context)),
          WidgetsPageHeader(
            title: l10n.termsHeroTitle,
            subtitle: l10n.termsHeroSubtitle,
            eyebrow: l10n.orderTypeTerms,
          ),
          SizedBox(height: CoreSpacing.lg(context)),
          _TermsCard(
            title: l10n.termsPaymentTitle,
            body: l10n.termsPaymentBody,
          ),
          SizedBox(height: CoreSpacing.md(context)),
          _TermsCard(
            title: l10n.termsGroupDeliveryTitle,
            body: l10n.termsGroupDeliveryBody,
          ),
          SizedBox(height: CoreSpacing.md(context)),
          _TermsCard(
            title: l10n.termsChangesTitle,
            body: l10n.termsChangesBody,
          ),
          SizedBox(height: CoreSpacing.xxl(context)),
        ],
      ),
    );
  }
}

class _TermsCard extends StatelessWidget {
  const _TermsCard({required this.title, required this.body});

  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return WidgetsAppCard(
      variant: WidgetsAppCardVariant.form,
      padding: EdgeInsets.all(CoreSpacing.lg(context)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: CoreTypography.titleMedium(
              context,
              scheme.onSurface,
            ).copyWith(fontWeight: FontWeight.w900),
          ),
          SizedBox(height: CoreSpacing.sm(context)),
          Text(
            body,
            style: CoreTypography.bodyMedium(context, scheme.onSurfaceVariant),
          ),
        ],
      ),
    );
  }
}

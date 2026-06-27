import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:ayletna_restaurant_app/navigation/app_route_paths.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_cart_icon_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_icon_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_scaffold_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Front-end FAQ destination for customer support.
class CustomerFaqScreen extends StatefulWidget {
  const CustomerFaqScreen({super.key});

  @override
  State<CustomerFaqScreen> createState() => _CustomerFaqScreenState();
}

class _CustomerFaqScreenState extends State<CustomerFaqScreen> {
  int? _expandedIndex;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    final items = [
      (title: l10n.faqDeliveryTitle, body: l10n.faqDeliveryBody),
      (title: l10n.faqPaymentTitle, body: l10n.faqPaymentBody),
      (title: l10n.faqPlatedTitle, body: l10n.faqPlatedBody),
    ];

    return WidgetsScaffoldPage(
      title: l10n.screenFaq,
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
          WidgetsAppCard(
            variant: WidgetsAppCardVariant.food,
            padding: EdgeInsets.all(CoreSpacing.lg(context)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.help_outline, color: scheme.primary),
                SizedBox(height: CoreSpacing.md(context)),
                Text(
                  l10n.faqHeroTitle,
                  style: CoreTypography.headlineLarge(
                    context,
                    scheme.onSurface,
                  ).copyWith(fontWeight: FontWeight.w900),
                ),
                SizedBox(height: CoreSpacing.sm(context)),
                Text(
                  l10n.faqHeroBody,
                  style: CoreTypography.bodyMedium(
                    context,
                    scheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: CoreSpacing.lg(context)),
          for (var index = 0; index < items.length; index++) ...[
            WidgetsAppCard(
              variant: WidgetsAppCardVariant.form,
              padding: EdgeInsets.all(CoreSpacing.md(context)),
              onTap:
                  () => setState(
                    () =>
                        _expandedIndex = _expandedIndex == index ? null : index,
                  ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          items[index].title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: CoreTypography.bodyMedium(
                            context,
                            scheme.onSurface,
                          ).copyWith(fontWeight: FontWeight.w900),
                        ),
                      ),
                      SizedBox(width: CoreSpacing.sm(context)),
                      Icon(
                        _expandedIndex == index
                            ? Icons.expand_less
                            : Icons.expand_more,
                        color: scheme.onSurfaceVariant,
                      ),
                    ],
                  ),
                  if (_expandedIndex == index) ...[
                    SizedBox(height: CoreSpacing.sm(context)),
                    Text(
                      items[index].body,
                      style: CoreTypography.bodyMedium(
                        context,
                        scheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            SizedBox(height: CoreSpacing.md(context)),
          ],
          SizedBox(height: CoreSpacing.xxl(context)),
        ],
      ),
    );
  }
}

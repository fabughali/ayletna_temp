import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:ayletna_restaurant_app/providers/support_faq_providers.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_page_header.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_scaffold_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Front-end FAQ destination for customer support.
class CustomerFaqScreen extends ConsumerStatefulWidget {
  const CustomerFaqScreen({super.key});

  @override
  ConsumerState<CustomerFaqScreen> createState() => _CustomerFaqScreenState();
}

class _CustomerFaqScreenState extends ConsumerState<CustomerFaqScreen> {
  int? _expandedIndex;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    final isAr = Localizations.localeOf(context).languageCode == 'ar';
    final published = ref.watch(publishedFaqProvider);
    final items =
        published.isNotEmpty
            ? published
                .map((e) => (title: e.title(isAr), body: e.body(isAr)))
                .toList()
            : [
              (title: l10n.faqDeliveryTitle, body: l10n.faqDeliveryBody),
              (title: l10n.faqPaymentTitle, body: l10n.faqPaymentBody),
              (title: l10n.faqPlatedTitle, body: l10n.faqPlatedBody),
            ];

    return WidgetsScaffoldPage(
      title: l10n.screenFaq,
      child: ListView(
        children: [
          SizedBox(height: CoreSpacing.md(context)),
          WidgetsPageHeader(
            title: l10n.faqHeroTitle,
            subtitle: l10n.faqHeroBody,
            eyebrow: l10n.screenFaq,
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

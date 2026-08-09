import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/providers/app_branding_providers.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_logo_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WidgetsBrandLockup extends ConsumerWidget {
  const WidgetsBrandLockup({
    required this.headline,
    this.motto,
    this.showLogo = true,
    this.showWordmark = true,
    this.wordmark,
    super.key,
  });

  final String headline;
  final String? motto;
  final bool showLogo;
  final bool showWordmark;
  final String? wordmark;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheme = Theme.of(context).colorScheme;
    final isAr = Localizations.localeOf(context).languageCode == 'ar';
    final branding = ref.watch(appBrandingProvider);
    final name = wordmark ?? branding.name(isAr);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (showLogo) ...[
          WidgetsLogoIcon(size: CoreContentSizes.logoWelcome(context) * 0.72),
          SizedBox(height: CoreSpacing.md(context)),
        ],
        if (showWordmark) ...[
          Text(
            name,
            textAlign: TextAlign.center,
            style: CoreTypography.headlineLarge(
              context,
              scheme.onSurface,
            ).copyWith(fontWeight: FontWeight.w900),
          ),
          SizedBox(height: CoreSpacing.sm(context)),
        ],
        Text(
          headline,
          textAlign: TextAlign.center,
          style:
              showWordmark
                  ? CoreTypography.bodyMedium(
                    context,
                    scheme.onSurfaceVariant,
                  ).copyWith(fontWeight: FontWeight.w500)
                  : CoreTypography.headlineSmall(
                    context,
                    scheme.onSurface,
                  ).copyWith(fontWeight: FontWeight.w800),
        ),
        if (motto != null) ...[
          SizedBox(height: CoreSpacing.sm(context)),
          Text(
            motto!,
            textAlign: TextAlign.center,
            style: CoreTypography.bodyMedium(
              context,
              scheme.onSurfaceVariant,
            ).copyWith(fontWeight: FontWeight.w500),
          ),
        ],
      ],
    );
  }
}

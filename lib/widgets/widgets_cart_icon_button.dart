import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:ayletna_restaurant_app/navigation/app_route_paths.dart';
import 'package:ayletna_restaurant_app/providers/cart_providers.dart';
import 'package:ayletna_restaurant_app/utilities/utility_sizer.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// App-bar cart action with a count badge only when the basket has items.
class WidgetsCartIconButton extends ConsumerWidget {
  const WidgetsCartIconButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final count = ref.watch(
      cartProvider.select(
        (lines) => lines.fold<int>(0, (sum, line) => sum + line.quantity),
      ),
    );
    final badgeLabel = count > 99 ? '99+' : count.toString();
    final base = CoreContentSizes.cartBadgeDiameter(context);
    final badgeDiameter = switch (badgeLabel.length) {
      1 => base,
      2 => base + UtilitySizer.of(context, 4),
      _ => base + UtilitySizer.of(context, 8),
    };
    final badgeFontSize = switch (badgeLabel.length) {
      1 => UtilitySizer.of(context, 10),
      2 => UtilitySizer.of(context, 9),
      _ => UtilitySizer.of(context, 8),
    };

    return Stack(
      clipBehavior: Clip.none,
      alignment: AlignmentDirectional.topEnd,
      children: [
        Semantics(
          button: true,
          label: count > 0 ? '${l10n.screenCart} ($count)' : l10n.screenCart,
          child: WidgetsIconButton(
            onPressed: () => context.go(AppRoutePaths.cart),
            icon: Icons.shopping_cart_outlined,
            tooltip: count > 0 ? '${l10n.screenCart} ($count)' : l10n.screenCart,
          ),
        ),
        if (count > 0)
          PositionedDirectional(
            top: UtilitySizer.of(context, 1),
            end: UtilitySizer.of(context, 1),
            child: ExcludeSemantics(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: CoreColors.semanticError,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Theme.of(context).colorScheme.surface,
                    width: UtilitySizer.of(context, 1.5),
                  ),
                ),
                child: SizedBox(
                  width: badgeDiameter,
                  height: badgeDiameter,
                  child: Center(
                    child: Text(
                      badgeLabel,
                      textAlign: TextAlign.center,
                      strutStyle: StrutStyle(
                        fontSize: badgeFontSize,
                        height: 1,
                        forceStrutHeight: true,
                      ),
                      textHeightBehavior: const TextHeightBehavior(
                        applyHeightToFirstAscent: false,
                        applyHeightToLastDescent: false,
                      ),
                      style: TextStyle(
                        color: CoreColors.surfaceLight,
                        fontSize: badgeFontSize,
                        fontWeight: FontWeight.w900,
                        height: 1,
                        leadingDistribution: TextLeadingDistribution.even,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

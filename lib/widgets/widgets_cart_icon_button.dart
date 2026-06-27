import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:ayletna_restaurant_app/navigation/app_route_paths.dart';
import 'package:ayletna_restaurant_app/providers/cart_providers.dart';
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
    final badgeDiameter = switch (badgeLabel.length) {
      1 => 18.0,
      2 => 22.0,
      _ => 26.0,
    };
    final badgeFontSize = switch (badgeLabel.length) {
      1 => 10.0,
      2 => 9.0,
      _ => 8.0,
    };

    return Stack(
      clipBehavior: Clip.none,
      alignment: AlignmentDirectional.topEnd,
      children: [
        WidgetsIconButton(
          onPressed: () => context.go(AppRoutePaths.cart),
          icon: Icons.shopping_cart_outlined,
          tooltip: count > 0 ? '${l10n.screenCart} ($count)' : l10n.screenCart,
        ),
        if (count > 0)
          PositionedDirectional(
            top: 1,
            end: 1,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: CoreColors.semanticError,
                shape: BoxShape.circle,
                border: Border.all(
                  color: Theme.of(context).colorScheme.surface,
                  width: 1.5,
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
      ],
    );
  }
}

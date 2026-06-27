import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:flutter/material.dart';

/// Wrap-based grid that caps card width while allowing more columns on wide
/// screens without introducing nested scroll views.
class WidgetsResponsiveCardGrid extends StatelessWidget {
  const WidgetsResponsiveCardGrid({
    required this.children,
    this.minCardWidth = 280,
    this.maxCardWidth = 360,
    this.heightRatio = 1.55,
    this.minCardHeight,
    this.maxCardHeight,
    this.maxColumns = 4,
    this.alignment = WrapAlignment.center,
    super.key,
  });

  final List<Widget> children;
  final double minCardWidth;
  final double maxCardWidth;
  final double heightRatio;
  final double? minCardHeight;
  final double? maxCardHeight;
  final int maxColumns;
  final WrapAlignment alignment;

  @override
  Widget build(BuildContext context) {
    if (children.isEmpty) {
      return const SizedBox.shrink();
    }

    final spacing = CoreSpacing.md(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        final availableWidth = constraints.maxWidth;
        final possibleColumns = ((availableWidth + spacing) /
                (minCardWidth + spacing))
            .floor()
            .clamp(1, maxColumns);
        final cardWidth =
            ((availableWidth - (spacing * (possibleColumns - 1))) /
                    possibleColumns)
                .clamp(0, maxCardWidth)
                .toDouble();
        final naturalHeight = cardWidth * heightRatio;
        final cardHeight =
            naturalHeight
                .clamp(
                  minCardHeight ?? naturalHeight,
                  maxCardHeight ?? naturalHeight,
                )
                .toDouble();

        return Wrap(
          alignment: alignment,
          spacing: spacing,
          runSpacing: spacing,
          children: [
            for (final child in children)
              SizedBox(width: cardWidth, height: cardHeight, child: child),
          ],
        );
      },
    );
  }
}

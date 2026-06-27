import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:flutter/material.dart';

/// Mockup-only online menu photo with a local illustrated fallback.
class WidgetsMockFoodImage extends StatelessWidget {
  const WidgetsMockFoodImage({
    required this.imageUrl,
    required this.fallback,
    this.fit = BoxFit.cover,
    super.key,
  });

  final String? imageUrl;
  final Widget fallback;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    final url = imageUrl;
    if (url == null || url.isEmpty) {
      return fallback;
    }

    return Image.network(
      url,
      fit: fit,
      errorBuilder: (_, _, _) => fallback,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) {
          return child;
        }

        return Stack(
          fit: StackFit.expand,
          children: [
            fallback,
            Center(
              child: SizedBox.square(
                dimension: CoreContentSizes.orderTypeIcon(context),
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

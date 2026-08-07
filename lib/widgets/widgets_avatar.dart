import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/utilities/utility_profile_photo.dart';
import 'package:flutter/material.dart';

/// Unified avatar for users, initials, icons, photos, and status accents.
class WidgetsAvatar extends StatelessWidget {
  const WidgetsAvatar({
    this.initials,
    this.icon,
    this.imageUrl,
    this.color,
    this.statusColor,
    this.radius,
    super.key,
  });

  final String? initials;
  final IconData? icon;
  final String? imageUrl;
  final Color? color;
  final Color? statusColor;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final accent = color ?? scheme.primary;
    final effectiveRadius =
        radius ?? CoreContentSizes.profileAvatarRadius(context) * 0.58;
    final backgroundImage = UtilityProfilePhoto.imageProvider(imageUrl);
    final hasImage = backgroundImage != null;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        CircleAvatar(
          radius: effectiveRadius,
          backgroundColor: accent.withValues(alpha: 0.14),
          foregroundColor: accent,
          backgroundImage: backgroundImage,
          onBackgroundImageError: hasImage ? (_, __) {} : null,
          child:
              hasImage
                  ? null
                  : initials != null
                  ? Text(
                    initials!,
                    style: CoreTypography.caption(
                      context,
                      accent,
                    ).copyWith(fontWeight: FontWeight.w900),
                  )
                  : Icon(
                    icon ?? Icons.person_outline,
                    size: CoreContentSizes.buttonIcon(context),
                  ),
        ),
        if (statusColor != null)
          PositionedDirectional(
            end: 0,
            bottom: 0,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: scheme.surface,
                shape: BoxShape.circle,
              ),
              child: Padding(
                padding: EdgeInsets.all(CoreSpacing.xs(context) * 0.5),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: statusColor,
                    shape: BoxShape.circle,
                  ),
                  child: SizedBox.square(dimension: CoreSpacing.sm(context)),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

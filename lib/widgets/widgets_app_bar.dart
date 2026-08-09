import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_avatar.dart';
import 'package:flutter/material.dart';

/// Branded role-aware app bar wrapper.
class WidgetsAppBar extends StatelessWidget implements PreferredSizeWidget {
  const WidgetsAppBar({
    required this.title,
    this.subtitle,
    this.leading,
    this.actions = const [],
    this.showAvatar = false,
    this.centerTitle = false,
    super.key,
  });

  final String title;
  final String? subtitle;
  final Widget? leading;
  final List<Widget> actions;
  final bool showAvatar;
  final bool centerTitle;

  @override
  Size get preferredSize => Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return AppBar(
      toolbarHeight: CoreContentSizes.appBarHeight(context),
      leading: leading,
      centerTitle: centerTitle,
      title: Column(
        crossAxisAlignment:
            centerTitle ? CrossAxisAlignment.center : CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: CoreTypography.titleMedium(
              context,
              scheme.primary,
            ).copyWith(fontWeight: FontWeight.w900),
          ),
          if (subtitle != null)
            Text(
              subtitle!,
              style: CoreTypography.caption(context, scheme.onSurfaceVariant),
            ),
        ],
      ),
      actions: [
        ...actions,
        if (showAvatar) ...[
          Padding(
            padding: EdgeInsetsDirectional.only(end: CoreSpacing.md(context)),
            child: const WidgetsAvatar(icon: Icons.person_outline),
          ),
        ],
      ],
    );
  }
}

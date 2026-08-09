import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_info_banner.dart';
import 'package:flutter/material.dart';

/// Banner shown on owner read-only views of operator admin screens.
class WidgetsReadOnlyHubBanner extends StatelessWidget {
  const WidgetsReadOnlyHubBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final isAr = Localizations.localeOf(context).languageCode == 'ar';
    return Padding(
      padding: EdgeInsets.only(bottom: CoreSpacing.lg(context)),
      child: WidgetsInfoBanner(
        message: isAr
            ? 'عرض المالك — للقراءة فقط'
            : 'Owner portal — read-only view',
        icon: Icons.visibility_outlined,
      ),
    );
  }
}

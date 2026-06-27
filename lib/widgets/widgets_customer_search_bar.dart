import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:ayletna_restaurant_app/navigation/app_route_paths.dart';
import 'package:ayletna_restaurant_app/utilities/utility_mock_feedback.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_text_field.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Customer-facing menu search entry.
class WidgetsCustomerSearchBar extends StatefulWidget {
  const WidgetsCustomerSearchBar({super.key});

  @override
  State<WidgetsCustomerSearchBar> createState() =>
      _WidgetsCustomerSearchBarState();
}

class _WidgetsCustomerSearchBarState extends State<WidgetsCustomerSearchBar> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Row(
      children: [
        Expanded(
          child: WidgetsAppTextField(
            controller: _controller,
            label: l10n.screenSearch,
            hintText: l10n.homeSearchHint,
            prefixIcon: Icons.search,
            textInputAction: TextInputAction.search,
            onSubmitted: _openSearch,
          ),
        ),
        SizedBox(width: CoreSpacing.sm(context)),
        WidgetsIconButton(
          onPressed: () => _openSearch(_controller.text),
          icon: Icons.search,
          tooltip: l10n.screenSearch,
          variant: WidgetsIconButtonVariant.filled,
        ),
      ],
    );
  }

  void _openSearch(String value) {
    final query = value.trim();
    if (query.isEmpty) {
      UtilityMockFeedback.showWarning(
        context,
        AppLocalizations.of(context)!.searchEmptyBody,
      );
      return;
    }
    context.push(
      Uri(path: AppRoutePaths.search, queryParameters: {'q': query}).toString(),
    );
  }
}

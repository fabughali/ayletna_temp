import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:ayletna_restaurant_app/navigation/app_route_paths.dart';
import 'package:ayletna_restaurant_app/utilities/utility_mock_feedback.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_text_field.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Canonical customer search bar — same look on home, menu, search, rewards.
class WidgetsSearchBar extends StatefulWidget {
  const WidgetsSearchBar({
    this.controller,
    this.hintText,
    this.label,
    this.onChanged,
    this.onSubmitted,
    this.navigateOnSubmit = true,
    this.showLabel = false,
    super.key,
  });

  /// Optional external controller (search results screen).
  final TextEditingController? controller;

  /// Defaults to [AppLocalizations.homeSearchHint].
  final String? hintText;

  /// Defaults to [AppLocalizations.screenSearch].
  final String? label;

  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;

  /// When true (home/menu), empty submit warns and non-empty opens `/search`.
  final bool navigateOnSubmit;

  final bool showLabel;

  @override
  State<WidgetsSearchBar> createState() => _WidgetsSearchBarState();
}

class _WidgetsSearchBarState extends State<WidgetsSearchBar> {
  TextEditingController? _ownedController;

  TextEditingController get _controller =>
      widget.controller ?? _ownedController!;

  @override
  void initState() {
    super.initState();
    if (widget.controller == null) {
      _ownedController = TextEditingController();
    }
  }

  @override
  void dispose() {
    _ownedController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final hint = widget.hintText ?? l10n.homeSearchHint;
    final label = widget.label ?? l10n.screenSearch;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: WidgetsAppTextField(
              controller: _controller,
              label: label,
              hintText: hint,
              showLabel: widget.showLabel,
              prefixIcon: Icons.search,
              textInputAction: TextInputAction.search,
              onChanged: widget.onChanged,
              onSubmitted: _handleSubmit,
            ),
          ),
          SizedBox(width: CoreSpacing.sm(context)),
          WidgetsIconButton(
            onPressed: () => _handleSubmit(_controller.text),
            icon: Icons.search,
            tooltip: l10n.screenSearch,
            variant: WidgetsIconButtonVariant.filled,
          ),
        ],
      ),
    );
  }

  void _handleSubmit(String value) {
    final query = value.trim();
    if (widget.onSubmitted != null) {
      widget.onSubmitted!(query);
      return;
    }
    if (!widget.navigateOnSubmit) {
      return;
    }
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

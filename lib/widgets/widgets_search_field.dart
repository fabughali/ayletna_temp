import 'package:ayletna_restaurant_app/widgets/widgets_search_bar.dart';
import 'package:flutter/material.dart';

/// Alias for the canonical [WidgetsSearchBar] (home-screen design).
///
/// Prefer [WidgetsSearchBar] at new call sites.
class WidgetsSearchField extends StatelessWidget {
  const WidgetsSearchField({
    required this.controller,
    required this.hintText,
    required this.onSubmitted,
    this.onChanged,
    this.label,
    this.showLabel = false,
    super.key,
  });

  final TextEditingController controller;
  final String hintText;
  final ValueChanged<String> onSubmitted;
  final ValueChanged<String>? onChanged;
  final String? label;
  final bool showLabel;

  @override
  Widget build(BuildContext context) {
    return WidgetsSearchBar(
      controller: controller,
      hintText: hintText,
      label: label,
      showLabel: showLabel,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      navigateOnSubmit: false,
    );
  }
}

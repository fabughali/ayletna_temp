import 'package:ayletna_restaurant_app/core/core_typography.dart';
import 'package:flutter/material.dart';

class WidgetsTermsCheckbox extends StatelessWidget {
  const WidgetsTermsCheckbox({
    required this.label,
    required this.value,
    required this.onChanged,
    super.key,
  });

  final String label;
  final bool value;
  final ValueChanged<bool?> onChanged;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return CheckboxListTile(
      value: value,
      onChanged: onChanged,
      contentPadding: EdgeInsets.zero,
      controlAffinity: ListTileControlAffinity.leading,
      title: Text(
        label,
        style: CoreTypography.caption(context, scheme.onSurfaceVariant),
      ),
    );
  }
}

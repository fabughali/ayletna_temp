import 'package:ayletna_restaurant_app/widgets/widgets_app_card.dart';
import 'package:flutter/material.dart';

/// Login / register form shell.
class WidgetsFormCard extends StatelessWidget {
  const WidgetsFormCard({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return WidgetsAppCard(child: child);
  }
}

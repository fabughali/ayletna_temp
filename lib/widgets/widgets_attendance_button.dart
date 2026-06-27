import 'package:ayletna_restaurant_app/widgets/widgets_button.dart';
import 'package:flutter/material.dart';

class WidgetsAttendanceButton extends StatelessWidget {
  const WidgetsAttendanceButton({
    required this.checkedIn,
    required this.checkInLabel,
    required this.checkOutLabel,
    required this.onPressed,
    super.key,
  });

  final bool checkedIn;
  final String checkInLabel;
  final String checkOutLabel;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return WidgetsButton(
      label: checkedIn ? checkOutLabel : checkInLabel,
      icon: checkedIn ? Icons.logout : Icons.login,
      onPressed: onPressed,
    );
  }
}

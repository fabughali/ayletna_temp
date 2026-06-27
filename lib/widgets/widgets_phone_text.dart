import 'package:flutter/material.dart';

/// Keeps phone numbers left-to-right inside Arabic or mixed-direction layouts.
class WidgetsPhoneText extends StatelessWidget {
  const WidgetsPhoneText({
    required this.phone,
    required this.style,
    this.textAlign,
    super.key,
  });

  final String phone;
  final TextStyle style;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      phone,
      textDirection: TextDirection.ltr,
      textAlign: textAlign,
      style: style,
    );
  }
}

class WidgetsMixedPhoneText extends StatelessWidget {
  const WidgetsMixedPhoneText({
    required this.prefix,
    required this.phone,
    required this.style,
    this.suffix = '',
    this.textAlign = TextAlign.center,
    super.key,
  });

  final String prefix;
  final String phone;
  final String suffix;
  final TextStyle style;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        style: style,
        children: [
          TextSpan(text: prefix),
          WidgetSpan(
            alignment: PlaceholderAlignment.baseline,
            baseline: TextBaseline.alphabetic,
            child: Directionality(
              textDirection: TextDirection.ltr,
              child: Text(phone, style: style),
            ),
          ),
          TextSpan(text: suffix),
        ],
      ),
      textAlign: textAlign,
    );
  }
}

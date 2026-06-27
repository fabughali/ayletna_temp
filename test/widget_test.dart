import 'package:ayletna_restaurant_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  testWidgets('Splash shows Ayletna branding', (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: AyletnaRestaurantApp()));
    await tester.pump();

    expect(find.text('طعم تقليدي، بدون هدر'), findsOneWidget);
    expect(find.text('مطعم عيلتنا'), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsNWidgets(2));

    await tester.pump(const Duration(seconds: 6));
    await tester.pumpAndSettle();
  });
}

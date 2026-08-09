import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:ayletna_restaurant_app/providers/app_providers.dart';
import 'package:ayletna_restaurant_app/providers/menu_providers.dart';
import 'package:ayletna_restaurant_app/screens/customer/customer_product_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

void main() {
  Future<void> pumpDetail(WidgetTester tester, {String? itemId}) async {
    final router = GoRouter(
      initialLocation: '/product-detail',
      routes: [
        GoRoute(
          path: '/product-detail',
          builder: (_, __) => const CustomerProductDetailScreen(),
        ),
        GoRoute(path: '/category', builder: (_, __) => const SizedBox()),
        GoRoute(path: '/cart', builder: (_, __) => const SizedBox()),
        GoRoute(path: '/product-reviews', builder: (_, __) => const SizedBox()),
        GoRoute(path: '/home', builder: (_, __) => const SizedBox()),
      ],
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          appRoleProvider.overrideWith((ref) => AppRole.customer),
          selectedMenuItemIdProvider.overrideWith((ref) => itemId),
        ],
        child: MaterialApp.router(
          locale: const Locale('ar'),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          theme: CoreTheme.themeFor(
            AppRole.customer,
            Brightness.dark,
            width: 390,
          ),
          routerConfig: router,
        ),
      ),
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));
  }

  testWidgets('product detail with selected item', (tester) async {
    await pumpDetail(tester, itemId: 'shawarma_meal_super');
    expect(tester.takeException(), isNull);
    expect(find.byType(CustomerProductDetailScreen), findsOneWidget);
  });

  testWidgets('product detail with null selection (fallback)', (tester) async {
    await pumpDetail(tester);
    expect(tester.takeException(), isNull);
    expect(find.byType(CustomerProductDetailScreen), findsOneWidget);
  });
}

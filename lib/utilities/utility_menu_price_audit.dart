import 'package:ayletna_restaurant_app/data/mockup/mockup_catalog.dart';
import 'package:ayletna_restaurant_app/data/models/model_audit_event.dart';
import 'package:ayletna_restaurant_app/data/models/model_menu_item.dart';
import 'package:ayletna_restaurant_app/providers/admin_session_providers.dart';
import 'package:ayletna_restaurant_app/providers/app_providers.dart';
import 'package:ayletna_restaurant_app/providers/audit_log_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Resolves the current mock price for [productId] before a save/publish.
double? resolveMenuItemPrice(WidgetRef ref, String productId) {
  if (productId.isEmpty || productId == 'draft_new') return null;
  final admin = ref.read(adminMenuProvider);
  final override = admin.catalogItemOverrides[productId];
  if (override != null) return override.priceJod;
  for (final item in admin.addedMenuItems) {
    if (item.id == productId) return item.priceJod;
  }
  return MockupCatalog.itemById(productId)?.priceJod;
}

/// Writes §7.3 price-change audit when [newPriceJod] differs from the prior value.
void recordMenuPriceChangeIfNeeded(
  WidgetRef ref, {
  required String productId,
  required String productNameEn,
  required double newPriceJod,
}) {
  if (productId.isEmpty || productId == 'draft_new') return;
  final previous = resolveMenuItemPrice(ref, productId);
  if (previous == null) return;
  if ((previous - newPriceJod).abs() < 0.001) return;

  final role = ref.read(appRoleProvider);
  recordAuditEvent(
    ref,
    type: AuditEventType.priceChange,
    actorRole: role,
    summaryEn:
        'Price change $productId ($productNameEn): ${previous.toStringAsFixed(2)} → ${newPriceJod.toStringAsFixed(2)} JOD',
    summaryAr:
        'تغيير سعر $productId ($productNameEn): ${previous.toStringAsFixed(2)} → ${newPriceJod.toStringAsFixed(2)} د.أ',
    entityId: productId,
    beforeValue: previous.toStringAsFixed(2),
    afterValue: newPriceJod.toStringAsFixed(2),
  );
}

ModelMenuItem? menuItemSnapshot(WidgetRef ref, String productId) {
  if (productId.isEmpty) return null;
  final admin = ref.read(adminMenuProvider);
  final override = admin.catalogItemOverrides[productId];
  if (override != null) return override;
  for (final item in admin.addedMenuItems) {
    if (item.id == productId) return item;
  }
  return MockupCatalog.itemById(productId);
}

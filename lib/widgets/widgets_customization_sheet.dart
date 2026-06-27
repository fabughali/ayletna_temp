import 'package:ayletna_restaurant_app/data/models/model_cart_line.dart';
import 'package:ayletna_restaurant_app/data/models/model_menu_item.dart';
import 'package:ayletna_restaurant_app/data/mockup/mockup_catalog.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_cart_customization_sheet.dart';
import 'package:flutter/material.dart';

/// Legacy entry point — delegates to the full cart customization sheet.
abstract final class WidgetsCustomizationSheet {
  static Future<void> show(
    BuildContext context, {
    required ModelCartLine line,
    ModelMenuItem? menuItem,
  }) {
    final item =
        menuItem ??
        MockupCatalog.itemById(line.itemId) ??
        ModelMenuItem(
          id: line.itemId,
          categoryId: 'general',
          nameAr: line.nameAr,
          nameEn: line.nameEn,
          descriptionAr: line.nameAr,
          descriptionEn: line.nameEn,
          priceJod: line.unitPriceJod,
        );

    return showWidgetsCartCustomizationSheet(
      context: context,
      item: item,
      initialLine: line,
      replaceLineKey: line.cartKey,
    );
  }
}

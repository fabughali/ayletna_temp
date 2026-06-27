import 'package:flutter/material.dart';

/// Ready order shown in kitchen handover mock queues.
class ModelKitchenReadyOrder {
  const ModelKitchenReadyOrder({
    required this.id,
    required this.destinationAr,
    required this.destinationEn,
    required this.badgeAr,
    required this.badgeEn,
    required this.typeKey,
    required this.readyTime,
    required this.actionLabelAr,
    required this.actionLabelEn,
    required this.actionIcon,
    required this.itemsAr,
    required this.itemsEn,
    this.noteAr,
    this.noteEn,
    this.isDelayed = false,
  });

  final String id;
  final String destinationAr;
  final String destinationEn;
  final String badgeAr;
  final String badgeEn;
  final String typeKey;
  final String readyTime;
  final String actionLabelAr;
  final String actionLabelEn;
  final IconData actionIcon;
  final List<ModelKitchenReadyItem> itemsAr;
  final List<ModelKitchenReadyItem> itemsEn;
  final String? noteAr;
  final String? noteEn;
  final bool isDelayed;
}

class ModelKitchenReadyItem {
  const ModelKitchenReadyItem({required this.quantity, required this.name});

  final int quantity;
  final String name;
}

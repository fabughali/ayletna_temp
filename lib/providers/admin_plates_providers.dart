import 'package:ayletna_restaurant_app/data/mockup/mockup_catalog.dart';
import 'package:ayletna_restaurant_app/data/models/model_admin_mock.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class AdminPlatesState {
  const AdminPlatesState({
    this.breakageReports = const [],
    this.stockUnits = 42,
    this.stockCapacity = 100,
    this.restockRequestCount = 0,
  });

  final List<ModelAdminBreakageReport> breakageReports;
  final int stockUnits;
  final int stockCapacity;
  final int restockRequestCount;

  double get totalBreakageLossJod =>
      breakageReports.fold(0, (sum, report) => sum + report.lossJod.abs());

  double get stockRatio => stockCapacity == 0 ? 0 : stockUnits / stockCapacity;

  AdminPlatesState copyWith({
    List<ModelAdminBreakageReport>? breakageReports,
    int? stockUnits,
    int? stockCapacity,
    int? restockRequestCount,
  }) {
    return AdminPlatesState(
      breakageReports: breakageReports ?? this.breakageReports,
      stockUnits: stockUnits ?? this.stockUnits,
      stockCapacity: stockCapacity ?? this.stockCapacity,
      restockRequestCount: restockRequestCount ?? this.restockRequestCount,
    );
  }
}

class AdminPlatesNotifier extends StateNotifier<AdminPlatesState> {
  AdminPlatesNotifier()
    : super(
        AdminPlatesState(
          breakageReports: [...MockupCatalog.adminBreakageReports],
        ),
      );

  void logBreakage({
    required String titleEn,
    required String titleAr,
    required String metaEn,
    required String metaAr,
    required double lossJod,
  }) {
    final now = DateTime.now();
    final timeEn = DateFormat.jm().format(now);
    final timeAr = timeEn;
    state = state.copyWith(
      breakageReports: [
        ModelAdminBreakageReport(
          titleEn: titleEn,
          titleAr: titleAr,
          metaEn: metaEn,
          metaAr: metaAr,
          lossJod: -lossJod.abs(),
          timeEn: timeEn,
          timeAr: timeAr,
        ),
        ...state.breakageReports,
      ],
    );
  }

  int restock({int units = 20}) {
    final next = (state.stockUnits + units).clamp(0, state.stockCapacity);
    state = state.copyWith(stockUnits: next);
    return next;
  }

  /// Plate editor "Order now" — records a restock request and bumps stock.
  int requestRestock({int units = 20}) {
    final next = restock(units: units);
    state = state.copyWith(restockRequestCount: state.restockRequestCount + 1);
    return next;
  }
}

final adminPlatesProvider =
    StateNotifierProvider<AdminPlatesNotifier, AdminPlatesState>(
      (ref) => AdminPlatesNotifier(),
    );

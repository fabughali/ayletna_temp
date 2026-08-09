import 'package:flutter_riverpod/flutter_riverpod.dart';

enum ReviewModerationStatus { pending, approved, rejected, flagged }

class ProductReviewRecord {
  const ProductReviewRecord({
    required this.id,
    required this.productNameEn,
    required this.productNameAr,
    required this.customerName,
    required this.rating,
    required this.commentEn,
    required this.commentAr,
    required this.status,
    required this.submittedAt,
    this.orderId,
    this.menuItemId,
    this.adminNote,
  });

  final String id;
  final String productNameEn;
  final String productNameAr;
  final String customerName;
  final int rating;
  final String commentEn;
  final String commentAr;
  final ReviewModerationStatus status;
  final DateTime submittedAt;
  final String? orderId;
  final String? menuItemId;
  final String? adminNote;

  ProductReviewRecord copyWith({
    ReviewModerationStatus? status,
    String? adminNote,
    int? rating,
    String? commentEn,
    String? commentAr,
  }) {
    return ProductReviewRecord(
      id: id,
      productNameEn: productNameEn,
      productNameAr: productNameAr,
      customerName: customerName,
      rating: rating ?? this.rating,
      commentEn: commentEn ?? this.commentEn,
      commentAr: commentAr ?? this.commentAr,
      status: status ?? this.status,
      submittedAt: submittedAt,
      orderId: orderId,
      menuItemId: menuItemId,
      adminNote: adminNote ?? this.adminNote,
    );
  }
}

class ReviewsModerationState {
  const ReviewsModerationState({this.reviews = const []});

  final List<ProductReviewRecord> reviews;

  List<ProductReviewRecord> get pendingReviews =>
      reviews.where((r) => r.status == ReviewModerationStatus.pending).toList();

  ReviewsModerationState copyWith({List<ProductReviewRecord>? reviews}) {
    return ReviewsModerationState(reviews: reviews ?? this.reviews);
  }
}

class ReviewsModerationNotifier extends StateNotifier<ReviewsModerationState> {
  ReviewsModerationNotifier()
    : super(
        ReviewsModerationState(
          reviews: [
            ProductReviewRecord(
              id: 'rev-001',
              productNameEn: 'Shawarma Super Meal',
              productNameAr: 'وجبة شاورما سوبر',
              customerName: 'Ahmad K.',
              rating: 5,
              commentEn: 'Perfect garlic sauce and fast delivery.',
              commentAr: 'صلصة الثوم ممتازة والتوصيل سريع.',
              status: ReviewModerationStatus.pending,
              submittedAt: DateTime.now().subtract(const Duration(hours: 3)),
              orderId: 'ORD-1001',
              menuItemId: 'shawarma_meal_super',
            ),
            ProductReviewRecord(
              id: 'rev-seed-approved',
              productNameEn: 'Shawarma Super Meal',
              productNameAr: 'وجبة شاورما سوبر',
              customerName: 'Layla H.',
              rating: 5,
              commentEn: 'Best shawarma in Amman!',
              commentAr: 'أفضل شاورما في عمان!',
              status: ReviewModerationStatus.approved,
              submittedAt: DateTime.now().subtract(const Duration(days: 3)),
              menuItemId: 'shawarma_meal_super',
            ),
            ProductReviewRecord(
              id: 'rev-002',
              productNameEn: 'Family Platter',
              productNameAr: 'طبق العائلة',
              customerName: 'Sara M.',
              rating: 2,
              commentEn: 'Order arrived late and cold.',
              commentAr: 'الطلب وصل متأخراً وبارداً.',
              status: ReviewModerationStatus.pending,
              submittedAt: DateTime.now().subtract(const Duration(hours: 5)),
            ),
          ],
        ),
      );

  bool submitReview(ProductReviewRecord review) {
    if (review.commentEn.trim().isEmpty || review.rating < 1) return false;
    state = state.copyWith(reviews: [review, ...state.reviews]);
    return true;
  }

  bool moderate(String id, ReviewModerationStatus status, {String? note}) {
    final index = state.reviews.indexWhere((r) => r.id == id);
    if (index == -1) return false;
    final updated = state.reviews[index].copyWith(
      status: status,
      adminNote: note,
    );
    final next = [...state.reviews]..[index] = updated;
    state = state.copyWith(reviews: next);
    return true;
  }

  bool updateReview({
    required String id,
    int? rating,
    String? commentEn,
    String? commentAr,
    String? adminNote,
  }) {
    final index = state.reviews.indexWhere((r) => r.id == id);
    if (index == -1) return false;
    final current = state.reviews[index];
    final nextRating = rating ?? current.rating;
    if (nextRating < 1 || nextRating > 5) return false;
    final updated = current.copyWith(
      rating: nextRating,
      commentEn: commentEn,
      commentAr: commentAr,
      adminNote: adminNote,
    );
    final next = [...state.reviews]..[index] = updated;
    state = state.copyWith(reviews: next);
    return true;
  }
}

final reviewsModerationProvider =
    StateNotifierProvider<ReviewsModerationNotifier, ReviewsModerationState>(
      (ref) => ReviewsModerationNotifier(),
    );

final approvedReviewsProvider = Provider<List<ProductReviewRecord>>((ref) {
  return ref
      .watch(reviewsModerationProvider)
      .reviews
      .where((r) => r.status == ReviewModerationStatus.approved)
      .toList();
});

final approvedReviewsForProductProvider =
    Provider.family<List<ProductReviewRecord>, String?>((ref, menuItemId) {
      final approved = ref.watch(approvedReviewsProvider);
      if (menuItemId == null) return approved;
      return approved
          .where((r) => r.menuItemId == menuItemId || r.menuItemId == null)
          .toList();
    });

int _reviewSeq = 100;

String nextReviewId() => 'rev-${_reviewSeq++}';

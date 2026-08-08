import 'package:ayletna_restaurant_app/data/models/model_blog_post.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MarketingBlogNotifier extends StateNotifier<List<BlogPost>> {
  MarketingBlogNotifier()
    : super([
        BlogPost(
          id: 'blog-1',
          titleAr: 'موسم رمضان في عيلتنا',
          titleEn: 'Ramadan season at Ayletna',
          excerptAr: 'استكشف عروض الإفطار والوجبات العائلية.',
          excerptEn: 'Explore iftar offers and family meal bundles.',
          socialPlatforms: const ['instagram', 'meta'],
          status: BlogPostStatus.published,
          updatedAt: DateTime.now().subtract(const Duration(days: 3)),
        ),
        BlogPost(
          id: 'blog-2',
          titleAr: 'قصة الشاورما التقليدية',
          titleEn: 'The story behind our shawarma',
          excerptAr: 'من المarinade إلى الطبق — رحلة النكهة.',
          excerptEn: 'From marinade to plate — a flavor journey.',
          socialPlatforms: const ['instagram'],
          status: BlogPostStatus.published,
          updatedAt: DateTime.now().subtract(const Duration(days: 8)),
        ),
        BlogPost(
          id: 'blog-3',
          titleAr: 'وراء الكواليس: فريق المطبخ',
          titleEn: 'Behind the scenes: kitchen team',
          excerptAr: 'مسودة — لم تُنشر بعد.',
          excerptEn: 'Draft — not published yet.',
          socialPlatforms: const [],
          status: BlogPostStatus.draft,
          updatedAt: DateTime.now().subtract(const Duration(days: 1)),
        ),
      ]);

  void addDraft({
    required String titleAr,
    required String titleEn,
    List<String> socialPlatforms = const [],
  }) {
    final id = 'blog-${DateTime.now().millisecondsSinceEpoch}';
    state = [
      BlogPost(
        id: id,
        titleAr: titleAr,
        titleEn: titleEn,
        excerptAr: '',
        excerptEn: '',
        socialPlatforms: socialPlatforms,
        status: BlogPostStatus.draft,
        updatedAt: DateTime.now(),
      ),
      ...state,
    ];
  }

  void updatePost(BlogPost updated) {
    state = [
      for (final post in state)
        if (post.id == updated.id)
          updated.copyWith(updatedAt: DateTime.now())
        else
          post,
    ];
  }

  void toggleStatus(String id) {
    state = [
      for (final post in state)
        if (post.id == id)
          post.copyWith(
            status:
                post.status == BlogPostStatus.published
                    ? BlogPostStatus.draft
                    : BlogPostStatus.published,
            updatedAt: DateTime.now(),
          )
        else
          post,
    ];
  }

  bool deletePost(String id) {
    final before = state.length;
    state = [for (final post in state) if (post.id != id) post];
    return state.length < before;
  }
}

final marketingBlogProvider =
    StateNotifierProvider<MarketingBlogNotifier, List<BlogPost>>(
      (ref) => MarketingBlogNotifier(),
    );

final publishedBlogPostsProvider = Provider<List<BlogPost>>((ref) {
  final posts =
      ref
          .watch(marketingBlogProvider)
          .where((post) => post.status == BlogPostStatus.published)
          .toList();
  posts.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
  return posts;
});

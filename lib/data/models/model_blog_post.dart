enum BlogPostStatus { draft, published }

class BlogPost {
  const BlogPost({
    required this.id,
    required this.titleAr,
    required this.titleEn,
    required this.excerptAr,
    required this.excerptEn,
    this.bodyAr = '',
    this.bodyEn = '',
    this.coverImageUrl,
    this.author = 'Ayletna',
    this.tags = const [],
    this.socialPlatforms = const [],
    required this.status,
    required this.updatedAt,
  });

  final String id;
  final String titleAr;
  final String titleEn;
  final String excerptAr;
  final String excerptEn;
  final String bodyAr;
  final String bodyEn;
  final String? coverImageUrl;
  final String author;
  final List<String> tags;
  /// Platform keys: meta, instagram, facebook, x, tiktok.
  final List<String> socialPlatforms;
  final BlogPostStatus status;
  final DateTime updatedAt;

  String title(bool isAr) => isAr ? titleAr : titleEn;
  String excerpt(bool isAr) => isAr ? excerptAr : excerptEn;
  String body(bool isAr) => isAr ? bodyAr : bodyEn;

  BlogPost copyWith({
    String? titleAr,
    String? titleEn,
    String? excerptAr,
    String? excerptEn,
    String? bodyAr,
    String? bodyEn,
    String? coverImageUrl,
    String? author,
    List<String>? tags,
    List<String>? socialPlatforms,
    BlogPostStatus? status,
    DateTime? updatedAt,
  }) {
    return BlogPost(
      id: id,
      titleAr: titleAr ?? this.titleAr,
      titleEn: titleEn ?? this.titleEn,
      excerptAr: excerptAr ?? this.excerptAr,
      excerptEn: excerptEn ?? this.excerptEn,
      bodyAr: bodyAr ?? this.bodyAr,
      bodyEn: bodyEn ?? this.bodyEn,
      coverImageUrl: coverImageUrl ?? this.coverImageUrl,
      author: author ?? this.author,
      tags: tags ?? this.tags,
      socialPlatforms: socialPlatforms ?? this.socialPlatforms,
      status: status ?? this.status,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

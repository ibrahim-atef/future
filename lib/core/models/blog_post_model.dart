class BlogPostModel {
  final String id;
  final String title;
  final String content;
  final String excerpt;
  final String? imageUrl;
  final String author;
  final List<String> tags;
  final int viewsCount;
  final DateTime publishedAt;
  final DateTime createdAt;
  final DateTime updatedAt;

  BlogPostModel({
    required this.id,
    required this.title,
    required this.content,
    required this.excerpt,
    this.imageUrl,
    required this.author,
    this.tags = const [],
    this.viewsCount = 0,
    required this.publishedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory BlogPostModel.fromJson(Map<String, dynamic> json) {
    return BlogPostModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      content: json['content'] ?? '',
      excerpt: json['excerpt'] ?? '',
      imageUrl: json['imageUrl'],
      author: json['author'] ?? '',
      tags: List<String>.from(json['tags'] ?? []),
      viewsCount: json['viewsCount'] ?? 0,
      publishedAt: DateTime.parse(json['publishedAt'] ?? DateTime.now().toIso8601String()),
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
      updatedAt: DateTime.parse(json['updatedAt'] ?? DateTime.now().toIso8601String()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'excerpt': excerpt,
      'imageUrl': imageUrl,
      'author': author,
      'tags': tags,
      'viewsCount': viewsCount,
      'publishedAt': publishedAt.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  String get publishedDateText {
    final now = DateTime.now();
    final difference = now.difference(publishedAt);

    if (difference.inDays > 0) {
      return 'منذ ${difference.inDays} يوم';
    } else if (difference.inHours > 0) {
      return 'منذ ${difference.inHours} ساعة';
    } else if (difference.inMinutes > 0) {
      return 'منذ ${difference.inMinutes} دقيقة';
    } else {
      return 'الآن';
    }
  }

  String get readTimeText {
    final wordCount = content.split(' ').length;
    final readTime = (wordCount / 200).ceil(); // Assuming 200 words per minute
    return '$readTime دقيقة قراءة';
  }
}



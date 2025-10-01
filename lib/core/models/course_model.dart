class CourseModel {
  final String id;
  final String title;
  final String description;
  final String teacherName;
  final String? imageUrl;
  final String level; // الفرقة
  final String language;
  final int totalHours;
  final double rating;
  final int studentsCount;
  final bool isFree;
  final double price;
  final List<String> tags;
  final DateTime createdAt;
  final DateTime updatedAt;

  CourseModel({
    required this.id,
    required this.title,
    required this.description,
    required this.teacherName,
    this.imageUrl,
    required this.level,
    required this.language,
    required this.totalHours,
    this.rating = 0.0,
    this.studentsCount = 0,
    this.isFree = false,
    this.price = 0.0,
    this.tags = const [],
    required this.createdAt,
    required this.updatedAt,
  });

  factory CourseModel.fromJson(Map<String, dynamic> json) {
    return CourseModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      teacherName: json['teacherName'] ?? '',
      imageUrl: json['imageUrl'],
      level: json['level'] ?? '',
      language: json['language'] ?? 'العربية',
      totalHours: json['totalHours'] ?? 0,
      rating: (json['rating'] ?? 0.0).toDouble(),
      studentsCount: json['studentsCount'] ?? 0,
      isFree: json['isFree'] ?? false,
      price: (json['price'] ?? 0.0).toDouble(),
      tags: List<String>.from(json['tags'] ?? []),
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
      updatedAt: DateTime.parse(json['updatedAt'] ?? DateTime.now().toIso8601String()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'teacherName': teacherName,
      'imageUrl': imageUrl,
      'level': level,
      'language': language,
      'totalHours': totalHours,
      'rating': rating,
      'studentsCount': studentsCount,
      'isFree': isFree,
      'price': price,
      'tags': tags,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  String get priceText => isFree ? 'مجانًا' : '${price.toInt()} ج.م';
  
  String get durationText => totalHours > 0 ? '$totalHours ساعة' : '';
  
  String get ratingText => rating > 0 ? rating.toStringAsFixed(1) : '';
}



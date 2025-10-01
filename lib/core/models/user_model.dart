class UserModel {
  final String id;
  final String fullName;
  final String email;
  final String? mobile;
  final String? bio;
  final String? about;
  final String? avatar;
  final String? cover;
  final String? roleName;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  UserModel({
    required this.id,
    required this.fullName,
    required this.email,
    this.mobile,
    this.bio,
    this.about,
    this.avatar,
    this.cover,
    this.roleName,
    this.createdAt,
    this.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      fullName: json['full_name'] ?? '',
      email: json['email'] ?? '',
      mobile: json['mobile'],
      bio: json['bio'],
      about: json['about'],
      avatar: json['avatar'],
      cover: json['cover'],
      roleName: json['role_name'],
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
      updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'full_name': fullName,
      'email': email,
      'mobile': mobile,
      'bio': bio,
      'about': about,
      'avatar': avatar,
      'cover': cover,
      'role_name': roleName,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  String get displayName => fullName.isNotEmpty ? fullName : email;

  UserModel copyWith({
    String? id,
    String? fullName,
    String? email,
    String? mobile,
    String? bio,
    String? about,
    String? avatar,
    String? cover,
    String? roleName,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserModel(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      mobile: mobile ?? this.mobile,
      bio: bio ?? this.bio,
      about: about ?? this.about,
      avatar: avatar ?? this.avatar,
      cover: cover ?? this.cover,
      roleName: roleName ?? this.roleName,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}



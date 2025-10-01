class Country {
  final String id;
  final String name;
  final String code;
  final String? flag;
  final bool isActive;

  Country({
    required this.id,
    required this.name,
    required this.code,
    this.flag,
    this.isActive = true,
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      code: json['code'] ?? '',
      flag: json['flag'],
      isActive: json['is_active'] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'code': code,
      'flag': flag,
      'is_active': isActive,
    };
  }
}

class Province {
  final String id;
  final String countryId;
  final String name;
  final String? code;
  final bool isActive;

  Province({
    required this.id,
    required this.countryId,
    required this.name,
    this.code,
    this.isActive = true,
  });

  factory Province.fromJson(Map<String, dynamic> json) {
    return Province(
      id: json['id'] ?? '',
      countryId: json['country_id'] ?? '',
      name: json['name'] ?? '',
      code: json['code'],
      isActive: json['is_active'] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'country_id': countryId,
      'name': name,
      'code': code,
      'is_active': isActive,
    };
  }
}

class City {
  final String id;
  final String provinceId;
  final String name;
  final String? code;
  final bool isActive;

  City({
    required this.id,
    required this.provinceId,
    required this.name,
    this.code,
    this.isActive = true,
  });

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      id: json['id'] ?? '',
      provinceId: json['province_id'] ?? '',
      name: json['name'] ?? '',
      code: json['code'],
      isActive: json['is_active'] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'province_id': provinceId,
      'name': name,
      'code': code,
      'is_active': isActive,
    };
  }
}

class District {
  final String id;
  final String cityId;
  final String name;
  final String? code;
  final bool isActive;

  District({
    required this.id,
    required this.cityId,
    required this.name,
    this.code,
    this.isActive = true,
  });

  factory District.fromJson(Map<String, dynamic> json) {
    return District(
      id: json['id'] ?? '',
      cityId: json['city_id'] ?? '',
      name: json['name'] ?? '',
      code: json['code'],
      isActive: json['is_active'] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'city_id': cityId,
      'name': name,
      'code': code,
      'is_active': isActive,
    };
  }
}

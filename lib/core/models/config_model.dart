class ConfigModel {
  final AppConfig? appConfig;
  final RegisterConfig? registerConfig;
  final List<CountryCode>? countryCodes;
  final List<Currency>? currencies;

  ConfigModel({
    this.appConfig,
    this.registerConfig,
    this.countryCodes,
    this.currencies,
  });

  factory ConfigModel.fromJson(Map<String, dynamic> json) {
    return ConfigModel(
      appConfig: json['app_config'] != null ? AppConfig.fromJson(json['app_config']) : null,
      registerConfig: json['register_config'] != null ? RegisterConfig.fromJson(json['register_config']) : null,
      countryCodes: json['country_codes'] != null 
          ? (json['country_codes'] as List).map((e) => CountryCode.fromJson(e)).toList()
          : null,
      currencies: json['currencies'] != null 
          ? (json['currencies'] as List).map((e) => Currency.fromJson(e)).toList()
          : null,
    );
  }
}

class AppConfig {
  final String? appName;
  final String? appVersion;
  final String? minVersion;
  final bool? maintenanceMode;
  final String? maintenanceMessage;

  AppConfig({
    this.appName,
    this.appVersion,
    this.minVersion,
    this.maintenanceMode,
    this.maintenanceMessage,
  });

  factory AppConfig.fromJson(Map<String, dynamic> json) {
    return AppConfig(
      appName: json['app_name'],
      appVersion: json['app_version'],
      minVersion: json['min_version'],
      maintenanceMode: json['maintenance_mode'],
      maintenanceMessage: json['maintenance_message'],
    );
  }
}

class RegisterConfig {
  final String? type;
  final List<String>? requiredFields;
  final List<String>? optionalFields;
  final Map<String, dynamic>? validation;

  RegisterConfig({
    this.type,
    this.requiredFields,
    this.optionalFields,
    this.validation,
  });

  factory RegisterConfig.fromJson(Map<String, dynamic> json) {
    return RegisterConfig(
      type: json['type'],
      requiredFields: json['required_fields'] != null 
          ? List<String>.from(json['required_fields'])
          : null,
      optionalFields: json['optional_fields'] != null 
          ? List<String>.from(json['optional_fields'])
          : null,
      validation: json['validation'],
    );
  }
}

class CountryCode {
  final String code;
  final String name;
  final String flag;

  CountryCode({
    required this.code,
    required this.name,
    required this.flag,
  });

  factory CountryCode.fromJson(Map<String, dynamic> json) {
    return CountryCode(
      code: json['code'] ?? '',
      name: json['name'] ?? '',
      flag: json['flag'] ?? '',
    );
  }
}

class Currency {
  final String code;
  final String name;
  final String symbol;
  final double rate;

  Currency({
    required this.code,
    required this.name,
    required this.symbol,
    required this.rate,
  });

  factory Currency.fromJson(Map<String, dynamic> json) {
    return Currency(
      code: json['code'] ?? '',
      name: json['name'] ?? '',
      symbol: json['symbol'] ?? '',
      rate: (json['rate'] ?? 1.0).toDouble(),
    );
  }
}

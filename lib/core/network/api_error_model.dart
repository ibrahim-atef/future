import 'package:json_annotation/json_annotation.dart';

part 'api_error_model.g.dart';

@JsonSerializable()
class ApiErrorModel {
  final bool? success;
  final String message;
  final Map<String, List<String>>? errors;
  // final int? status;
  // final String? type;
  // final dynamic error;

  ApiErrorModel({
    this.success,
    required this.message,
    this.errors,
    // this.status,
    // this.type,
    // this.error,
  });

  factory ApiErrorModel.fromJson(Map<String, dynamic> json) =>
      _$ApiErrorModelFromJson(json);

  Map<String, dynamic> toJson() => _$ApiErrorModelToJson(this);

  /// Get error message for a specific field
  String? getFieldError(String fieldName) {
    if (errors == null || errors![fieldName] == null) {
      return null;
    }
    return errors![fieldName]!.isNotEmpty ? errors![fieldName]!.first : null;
  }

  /// Get all error messages for a specific field
  List<String>? getFieldErrors(String fieldName) {
    return errors?[fieldName];
  }

  /// Get all error messages as a single string
  String getAllErrorsAsString() {
    if (errors == null || errors!.isEmpty) {
      return message;
    }

    List<String> allErrors = [];
    errors!.forEach((field, fieldErrors) {
      allErrors.addAll(fieldErrors);
    });

    return allErrors.join('\n');
  }

  /// Check if there are any field-specific errors
  bool hasFieldErrors() {
    return errors != null && errors!.isNotEmpty;
  }

  /// Get all field names that have errors
  List<String> getErrorFields() {
    if (errors == null) return [];
    return errors!.keys.toList();
  }

  /// Get display message - shows errors if they exist, otherwise shows main message
  String getDisplayMessage() {
    if (hasFieldErrors()) {
      return getAllErrorsAsString();
    }
    return message;
  }

  /// Get display message as list - useful for showing multiple errors separately
  List<String> getDisplayMessages() {
    if (hasFieldErrors()) {
      List<String> allErrors = [];
      errors!.forEach((field, fieldErrors) {
        allErrors.addAll(fieldErrors);
      });
      return allErrors;
    }
    return [message];
  }

  /// Get only errors - shows errors if they exist, empty string if no errors
  String getErrorsOnly() {
    if (hasFieldErrors()) {
      return getAllErrorsAsString();
    }
    return '';
  }

  /// Get only errors as list - shows errors if they exist, empty list if no errors
  List<String> getErrorsOnlyAsList() {
    if (hasFieldErrors()) {
      List<String> allErrors = [];
      errors!.forEach((field, fieldErrors) {
        allErrors.addAll(fieldErrors);
      });
      return allErrors;
    }
    return [];
  }

  /// Get message only when no errors exist
  String getMessageOnly() {
    if (!hasFieldErrors()) {
      return message;
    }
    return '';
  }
}

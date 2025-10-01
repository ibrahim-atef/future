import 'package:json_annotation/json_annotation.dart';

part 'register_step2_request_model.g.dart';

@JsonSerializable()
class RegisterStep2RequestModel {
  @JsonKey(name: 'code')
  final String code;

  @JsonKey(name: 'user_id')
  final int userId;

  @JsonKey(name: 'full_name')
  final String fullName;

  RegisterStep2RequestModel({
    required this.code,
    required this.userId,
    required this.fullName,
  });

  factory RegisterStep2RequestModel.fromJson(Map<String, dynamic> json) =>
      _$RegisterStep2RequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterStep2RequestModelToJson(this);
}

import 'user_model.dart';

class AuthResponseModel {
  final bool success;
  final String? token;
  final UserModel? user;
  final String? message;
  final Map<String, dynamic>? data;

  AuthResponseModel({
    required this.success,
    this.token,
    this.user,
    this.message,
    this.data,
  });

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) {
    return AuthResponseModel(
      success: json['success'] ?? false,
      token: json['token'] ?? json['access_token'],
      user: json['user'] != null ? UserModel.fromJson(json['user']) : null,
      message: json['message'],
      data: json['data'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'token': token,
      'user': user?.toJson(),
      'message': message,
      'data': data,
    };
  }
}

class RegisterStep1Request {
  final String fullName;
  final String email;
  final String mobile;
  final String password;
  final String roleName;

  RegisterStep1Request({
    required this.fullName,
    required this.email,
    required this.mobile,
    required this.password,
    this.roleName = 'user',
  });

  Map<String, dynamic> toJson() {
    return {
      'full_name': fullName,
      'email': email,
      'mobile': mobile,
      'password': password,
      'role_name': roleName,
    };
  }
}

class RegisterStep2Request {
  final String code;

  RegisterStep2Request({required this.code});

  Map<String, dynamic> toJson() {
    return {
      'code': code,
    };
  }
}

class LoginRequest {
  final String username;
  final String password;

  LoginRequest({
    required this.username,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
    };
  }
}

class ForgotPasswordRequest {
  final String email;

  ForgotPasswordRequest({required this.email});

  Map<String, dynamic> toJson() {
    return {
      'email': email,
    };
  }
}

class ResetPasswordRequest {
  final String password;
  final String passwordConfirmation;

  ResetPasswordRequest({
    required this.password,
    required this.passwordConfirmation,
  });

  Map<String, dynamic> toJson() {
    return {
      'password': password,
      'password_confirmation': passwordConfirmation,
    };
  }
}

class VerifyCodeRequest {
  final String code;

  VerifyCodeRequest({required this.code});

  Map<String, dynamic> toJson() {
    return {
      'code': code,
    };
  }
}

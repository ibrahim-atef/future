import 'package:flutter/material.dart';
import '../core/services/api_service.dart';
import '../core/services/storage_service.dart';
import '../core/models/user_model.dart';
import '../core/models/auth_response_model.dart';

class AuthProvider extends ChangeNotifier {
  UserModel? _currentUser;
  bool _isLoading = false;
  String? _error;
  bool _isAuthenticated = false;

  UserModel? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get isAuthenticated => _isAuthenticated;

  AuthProvider() {
    _initializeAuth();
  }

  Future<void> _initializeAuth() async {
    final token = StorageService.getToken();
    final userData = StorageService.getUserData();
    
    if (token != null && userData != null) {
      _currentUser = userData;
      _isAuthenticated = true;
      notifyListeners();
    }
  }

  Future<bool> login(String username, String password) async {
    _setLoading(true);
    _clearError();

    try {
      final request = LoginRequest(username: username, password: password);
      final response = await ApiService().login(request);

      if (response.success && response.data != null) {
        _currentUser = response.data!.user;
        _isAuthenticated = true;
        
        if (response.data!.user != null) {
          await StorageService.saveUserData(response.data!.user!);
        }
        
        notifyListeners();
        return true;
      } else {
        _setError(response.error ?? 'فشل في تسجيل الدخول');
        return false;
      }
    } catch (e) {
      _setError('حدث خطأ غير متوقع');
      return false;
    } finally {
      _setLoading(false);
    }
  }

  Future<bool> registerStep1(String fullName, String email, String mobile, String password) async {
    _setLoading(true);
    _clearError();

    try {
      final request = RegisterStep1Request(
        fullName: fullName,
        email: email,
        mobile: mobile,
        password: password,
      );
      
      final response = await ApiService().registerStep1(request);

      if (response.success) {
        notifyListeners();
        return true;
      } else {
        _setError(response.error ?? 'فشل في إنشاء الحساب');
        return false;
      }
    } catch (e) {
      _setError('حدث خطأ غير متوقع');
      return false;
    } finally {
      _setLoading(false);
    }
  }

  Future<bool> registerStep2(String code) async {
    _setLoading(true);
    _clearError();

    try {
      final request = RegisterStep2Request(code: code);
      final response = await ApiService().registerStep2(request);

      if (response.success && response.data != null) {
        _currentUser = response.data!.user;
        _isAuthenticated = true;
        
        if (response.data!.user != null) {
          await StorageService.saveUserData(response.data!.user!);
        }
        
        notifyListeners();
        return true;
      } else {
        _setError(response.error ?? 'فشل في التحقق من الكود');
        return false;
      }
    } catch (e) {
      _setError('حدث خطأ غير متوقع');
      return false;
    } finally {
      _setLoading(false);
    }
  }

  Future<bool> forgotPassword(String email) async {
    _setLoading(true);
    _clearError();

    try {
      final request = ForgotPasswordRequest(email: email);
      final response = await ApiService().forgotPassword(request);

      if (response.success) {
        notifyListeners();
        return true;
      } else {
        _setError(response.error ?? 'فشل في إرسال رابط إعادة تعيين كلمة المرور');
        return false;
      }
    } catch (e) {
      _setError('حدث خطأ غير متوقع');
      return false;
    } finally {
      _setLoading(false);
    }
  }

  Future<bool> resetPassword(String token, String password, String passwordConfirmation) async {
    _setLoading(true);
    _clearError();

    try {
      final request = ResetPasswordRequest(
        password: password,
        passwordConfirmation: passwordConfirmation,
      );
      
      final response = await ApiService().resetPassword(token, request);

      if (response.success) {
        notifyListeners();
        return true;
      } else {
        _setError(response.error ?? 'فشل في إعادة تعيين كلمة المرور');
        return false;
      }
    } catch (e) {
      _setError('حدث خطأ غير متوقع');
      return false;
    } finally {
      _setLoading(false);
    }
  }

  Future<bool> verifyCode(String code) async {
    _setLoading(true);
    _clearError();

    try {
      final request = VerifyCodeRequest(code: code);
      final response = await ApiService().verifyCode(request);

      if (response.success) {
        notifyListeners();
        return true;
      } else {
        _setError(response.error ?? 'فشل في التحقق من الكود');
        return false;
      }
    } catch (e) {
      _setError('حدث خطأ غير متوقع');
      return false;
    } finally {
      _setLoading(false);
    }
  }

  Future<void> logout() async {
    _setLoading(true);

    try {
      await ApiService().logout();
    } catch (e) {
      // Continue with logout even if API call fails
    }

    _currentUser = null;
    _isAuthenticated = false;
    await StorageService.clearAllData();
    
    _setLoading(false);
    notifyListeners();
  }

  Future<bool> updateProfile(Map<String, dynamic> userData) async {
    _setLoading(true);
    _clearError();

    try {
      final response = await ApiService().updateProfile(userData);

      if (response.success && response.data != null) {
        _currentUser = response.data;
        await StorageService.saveUserData(response.data!);
        notifyListeners();
        return true;
      } else {
        _setError(response.error ?? 'فشل في تحديث الملف الشخصي');
        return false;
      }
    } catch (e) {
      _setError('حدث خطأ غير متوقع');
      return false;
    } finally {
      _setLoading(false);
    }
  }

  Future<bool> updatePassword(String currentPassword, String newPassword, String confirmPassword) async {
    _setLoading(true);
    _clearError();

    try {
      final passwordData = {
        'current_password': currentPassword,
        'password': newPassword,
        'password_confirmation': confirmPassword,
      };
      
      final response = await ApiService().updatePassword(passwordData);

      if (response.success) {
        notifyListeners();
        return true;
      } else {
        _setError(response.error ?? 'فشل في تحديث كلمة المرور');
        return false;
      }
    } catch (e) {
      _setError('حدث خطأ غير متوقع');
      return false;
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setError(String error) {
    _error = error;
    notifyListeners();
  }

  void _clearError() {
    _error = null;
    notifyListeners();
  }

  void clearError() {
    _clearError();
  }
}

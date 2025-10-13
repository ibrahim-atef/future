import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:future_app/core/helper/device_info_helper.dart';
import 'package:future_app/core/helper/shared_pref_keys.dart';
import 'package:future_app/features/auth/data/models/register_request_model.dart';
import 'package:future_app/features/auth/data/models/register_response_model.dart';
import 'package:future_app/features/auth/logic/cubit/auth_cubit.dart';
import 'package:future_app/features/auth/logic/cubit/auth_state.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../providers/auth_provider.dart';
import '../../../../widgets/common/custom_button.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _mobileController = TextEditingController();
  final _universityController = TextEditingController();
  final _majorController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  String? _selectedGrade;

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _mobileController.dispose();
    _universityController.dispose();
    _majorController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listenWhen: (previous, current) {
        return current is ErrorRegisterStep1 ||
            current is LoadingRegisterStep1 ||
            current is SuccessRegisterStep1;
      },
      listener: (context, state) {
        state.whenOrNull(
          errorRegisterStep1: (error) {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(error.message ?? 'فشل في إنشاء الحساب'),
                backgroundColor: Colors.red,
              ),
            );
          },
          loadingRegisterStep1: () {
            showDialog(
              context: context,
              builder: (context) {
                return const Center(
                  child: CircularProgressIndicator(color: Color(0xFFd4af37)),
                );
              },
            );
          },
          successRegisterStep1: (RegisterResponseModel registerResponseModel) {
            Navigator.pop(context);
            Navigator.pushNamed(
              context,
              AppRoutes.verifyCode,
              arguments: {
                'email': _emailController.text.trim(),
                'type': 'register',
                'user_id': registerResponseModel.data.userId,
                'full_name': _fullNameController.text.trim(),
              },
            );
          },
        );
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF1a1a1a),
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Color(0xFFd4af37)),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text(
            AppStrings.signup,
            style: TextStyle(
              color: Color(0xFFd4af37),
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 20),

                  // Title
                  Text(
                    'إنشاء حساب جديد',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 8),

                  Text(
                    'املأ البيانات التالية لإنشاء حسابك',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Colors.grey[600],
                        ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 30),

                  // Full Name Field
                  TextFormField(
                    controller: _fullNameController,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      labelText: 'الاسم الكامل',
                      prefixIcon: const Icon(Icons.person_outlined),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.grey[300]!),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            BorderSide(color: Theme.of(context).primaryColor),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'يرجى إدخال الاسم الكامل';
                      }
                      if (value.length < 2) {
                        return 'الاسم يجب أن يكون حرفين على الأقل';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 20),

                  // Email Field
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      labelText: AppStrings.email,
                      prefixIcon: const Icon(Icons.email_outlined),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.grey[300]!),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            BorderSide(color: Theme.of(context).primaryColor),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'يرجى إدخال البريد الإلكتروني';
                      }
                      if (!value.contains('@')) {
                        return 'يرجى إدخال بريد إلكتروني صحيح';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 20),

                  // Mobile Field
                  TextFormField(
                    controller: _mobileController,
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      labelText: AppStrings.phoneNumber,
                      prefixIcon: const Icon(Icons.phone_outlined),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.grey[300]!),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            BorderSide(color: Theme.of(context).primaryColor),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'يرجى إدخال رقم الهاتف';
                      }
                      if (value.length < 10) {
                        return 'رقم الهاتف يجب أن يكون 10 أرقام على الأقل';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 20),

                  // Grade/Class Field (الفرقة)
                  DropdownButtonFormField<String>(
                    value: _selectedGrade,
                    decoration: InputDecoration(
                      labelText: 'الفرقة',
                      prefixIcon: const Icon(Icons.school_outlined),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.grey[300]!),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            BorderSide(color: Theme.of(context).primaryColor),
                      ),
                    ),
                    items: const [
                      DropdownMenuItem(
                          value: 'الفرقة الأولى', child: Text('الفرقة الأولى')),
                      DropdownMenuItem(
                          value: 'الفرقة الثانية',
                          child: Text('الفرقة الثانية')),
                      DropdownMenuItem(
                          value: 'الفرقة الثالثة',
                          child: Text('الفرقة الثالثة')),
                      DropdownMenuItem(
                          value: 'الفرقة الرابعة',
                          child: Text('الفرقة الرابعة')),
                      DropdownMenuItem(value: 'خريج', child: Text('خريج')),
                    ],
                    onChanged: (value) {
                      setState(() {
                        _selectedGrade = value;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'يرجى اختيار الفرقة';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 20),

                  // University Field (الجامعة)
                  TextFormField(
                    controller: _universityController,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      labelText: 'الجامعة',
                      prefixIcon: const Icon(Icons.account_balance_outlined),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.grey[300]!),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            BorderSide(color: Theme.of(context).primaryColor),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'يرجى إدخال اسم الجامعة';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 20),

                  // Major Field (التخصص)
                  // TextFormField(
                  //   controller: _majorController,
                  //   textInputAction: TextInputAction.next,
                  //   decoration: InputDecoration(
                  //     labelText: 'التخصص',
                  //     prefixIcon: const Icon(Icons.menu_book_outlined),
                  //     border: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(12),
                  //     ),
                  //     enabledBorder: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(12),
                  //       borderSide: BorderSide(color: Colors.grey[300]!),
                  //     ),
                  //     focusedBorder: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(12),
                  //       borderSide:
                  //           BorderSide(color: Theme.of(context).primaryColor),
                  //     ),
                  //   ),
                  //   validator: (value) {
                  //     if (value == null || value.isEmpty) {
                  //       return 'يرجى إدخال التخصص';
                  //     }
                  //     return null;
                  //   },
                  // ),

                  // const SizedBox(height: 20),

                  // Password Field
                  TextFormField(
                    controller: _passwordController,
                    obscureText: _obscurePassword,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      labelText: AppStrings.password,
                      prefixIcon: const Icon(Icons.lock_outlined),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.grey[300]!),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            BorderSide(color: Theme.of(context).primaryColor),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'يرجى إدخال كلمة المرور';
                      }
                      if (value.length < 6) {
                        return 'كلمة المرور يجب أن تكون 6 أحرف على الأقل';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 20),

                  // Confirm Password Field
                  TextFormField(
                    controller: _confirmPasswordController,
                    obscureText: _obscureConfirmPassword,
                    textInputAction: TextInputAction.done,
                    // onFieldSubmitted: (_) => _handleRegister(),
                    decoration: InputDecoration(
                      labelText: AppStrings.confirmPassword,
                      prefixIcon: const Icon(Icons.lock_outlined),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureConfirmPassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureConfirmPassword = !_obscureConfirmPassword;
                          });
                        },
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.grey[300]!),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            BorderSide(color: Theme.of(context).primaryColor),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'يرجى تأكيد كلمة المرور';
                      }
                      if (value != _passwordController.text) {
                        return 'كلمة المرور غير متطابقة';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 30),

                  CustomButton(
                    text: AppStrings.signup,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context
                            .read<AuthCubit>()
                            .registerStep1(RegisterRequestModel(
                              fullName: _fullNameController.text.trim(),
                              email: _emailController.text.trim(),
                              mobile: _mobileController.text.trim(),
                              password: _passwordController.text.trim(),
                              passwordConfirmation:
                                  _confirmPasswordController.text.trim(),
                              deviceId: UserConstant.deviceId!,
                              roleName: 'user',
                            ));
                      }
                    },
                  ),

                  const SizedBox(height: 30),

                  // Login Link
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'لديك حساب بالفعل؟ ',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          AppStrings.login,
                          style: TextStyle(
                            color: Theme.of(context).secondaryHeaderColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

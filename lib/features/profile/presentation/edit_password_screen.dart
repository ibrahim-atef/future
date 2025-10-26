import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:future_app/features/profile/logic/cubit/profile_cubit.dart';
import 'package:future_app/features/profile/logic/cubit/profile_state.dart';
import 'package:future_app/features/profile/data/models/update_password_response_model.dart';

class EditPasswordScreen extends StatefulWidget {
  const EditPasswordScreen({super.key});

  @override
  State<EditPasswordScreen> createState() => _EditPasswordScreenState();
}

class _EditPasswordScreenState extends State<EditPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _obscureCurrentPassword = true;
  bool _obscureNewPassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _updatePassword() {
    if (_formKey.currentState!.validate()) {
      final request = UpdatePasswordRequestModel(
        currentPassword: _currentPasswordController.text.trim(),
        newPassword: _newPasswordController.text.trim(),
        newPasswordConfirmation: _confirmPasswordController.text.trim(),
      );
      context.read<ProfileCubit>().updatePassword(request);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
        state.whenOrNull(
          successUpdatePassword: (data) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(data.message),
                backgroundColor: const Color(0xFFd4af37),
              ),
            );
            Navigator.pop(context);
          },
          errorUpdatePassword: (error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(error.getAllErrorsAsString()),
                backgroundColor: Colors.red,
              ),
            );
          },
        );
      },
      builder: (context, state) {
        final isLoading = state.maybeWhen(
          loadingUpdatePassword: () => true,
          orElse: () => false,
        );

        return Scaffold(
          backgroundColor: const Color(0xFF1a1a1a),
          appBar: AppBar(
            backgroundColor: const Color(0xFF1a1a1a),
            elevation: 0,
            title: const Text(
              'تعديل كلمة المرور',
              style: TextStyle(
                color: Color(0xFFd4af37),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Color(0xFFd4af37)),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 24),

                  // Password Form Container
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2a2a2a),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: const Color(0xFFd4af37).withOpacity(0.3),
                        width: 1,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'تعديل كلمة المرور',
                          style: TextStyle(
                            color: Color(0xFFd4af37),
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Current Password Field
                        _buildPasswordField(
                          controller: _currentPasswordController,
                          label: 'كلمة المرور الحالية',
                          icon: Icons.lock_outline,
                          obscureText: _obscureCurrentPassword,
                          onToggleVisibility: () {
                            setState(() {
                              _obscureCurrentPassword =
                                  !_obscureCurrentPassword;
                            });
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'يرجى إدخال كلمة المرور الحالية';
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: 16),

                        // New Password Field
                        _buildPasswordField(
                          controller: _newPasswordController,
                          label: 'كلمة المرور الجديدة',
                          icon: Icons.lock,
                          obscureText: _obscureNewPassword,
                          onToggleVisibility: () {
                            setState(() {
                              _obscureNewPassword = !_obscureNewPassword;
                            });
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'يرجى إدخال كلمة المرور الجديدة';
                            }
                            if (value.length < 6) {
                              return 'كلمة المرور يجب أن تكون 6 أحرف على الأقل';
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: 16),

                        // Confirm Password Field
                        _buildPasswordField(
                          controller: _confirmPasswordController,
                          label: 'تأكيد كلمة المرور الجديدة',
                          icon: Icons.lock_clock,
                          obscureText: _obscureConfirmPassword,
                          onToggleVisibility: () {
                            setState(() {
                              _obscureConfirmPassword =
                                  !_obscureConfirmPassword;
                            });
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'يرجى تأكيد كلمة المرور الجديدة';
                            }
                            if (value != _newPasswordController.text) {
                              return 'كلمة المرور غير متطابقة';
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: 24),

                        // Update Password Button
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: isLoading ? null : _updatePassword,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFd4af37),
                              foregroundColor: Colors.black,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: isLoading
                                ? const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          Colors.black),
                                    ),
                                  )
                                : const Text(
                                    'تحديث كلمة المرور',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                          ),
                        ),

                        const SizedBox(height: 16),

                        // Cancel Button
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed:
                                isLoading ? null : () => Navigator.pop(context),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF2a2a2a),
                              foregroundColor: const Color(0xFFd4af37),
                              side: const BorderSide(
                                color: Color(0xFFd4af37),
                                width: 1,
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text(
                              'إلغاء',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildPasswordField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required bool obscureText,
    required VoidCallback onToggleVisibility,
    required String? Function(String?) validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      validator: validator,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 16,
      ),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(
          color: Color(0xFFd4af37),
        ),
        prefixIcon: Icon(
          icon,
          color: const Color(0xFFd4af37),
        ),
        filled: true,
        fillColor: const Color(0xFF1a1a1a),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: const Color(0xFFd4af37).withOpacity(0.3),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: const Color(0xFFd4af37).withOpacity(0.3),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: Color(0xFFd4af37),
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: Colors.red,
            width: 1,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: Colors.red,
            width: 2,
          ),
        ),
        suffixIcon: IconButton(
          icon: Icon(
            obscureText ? Icons.visibility_off : Icons.visibility,
            color: const Color(0xFFd4af37),
          ),
          onPressed: onToggleVisibility,
        ),
      ),
    );
  }
}

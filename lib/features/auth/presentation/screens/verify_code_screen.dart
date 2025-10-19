import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:future_app/core/routes/app_routes.dart';
import 'package:future_app/features/auth/data/models/register_step2_request_model.dart';
import 'package:future_app/features/auth/data/models/register_step2_response_model.dart';
import 'package:future_app/features/auth/logic/cubit/auth_cubit.dart';
import 'package:future_app/features/auth/logic/cubit/auth_state.dart';
import 'package:provider/provider.dart';
import '../../../../widgets/common/custom_button.dart';

class VerifyCodeScreen extends StatefulWidget {
  final String email;
  final String type; // 'register' or 'reset'
  final int userId;
  final String fullName;

  const VerifyCodeScreen({
    super.key,
    required this.email,
    required this.type,
    required this.userId,
    required this.fullName,
  });

  @override
  State<VerifyCodeScreen> createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends State<VerifyCodeScreen> {
  final _formKey = GlobalKey<FormState>();
  final _codeController = TextEditingController();

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listenWhen: (previous, current) {
        return current is SuccessRegisterStep2 ||
            current is LoadingRegisterStep2 ||
            current is SuccessRegisterStep2;
      },
      listener: (context, state) {
        state.whenOrNull(
          errorRegisterStep2: (error) {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(error.getAllErrorsAsString() ?? 'فشل'),
                backgroundColor: Colors.red,
              ),
            );
          },
          loadingRegisterStep2: () {
            showDialog(
              context: context,
              builder: (context) {
                return const Center(
                  child: CircularProgressIndicator(color: Color(0xFFd4af37)),
                );
              },
            );
          },
          successRegisterStep2: (RegisterStep2ResponseModel data) {
            Navigator.pop(context);
            Navigator.pushNamedAndRemoveUntil(
              context,
              AppRoutes.home,
              (route) => false,
            );
          },
        );
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('التحقق من الكود'),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 40),

                  // Icon
                  Center(
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: Icon(
                        Icons.verified_user,
                        size: 40,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  // Title
                  Text(
                    'التحقق من الكود',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 16),

                  Text(
                    'أدخل الكود المرسل إلى ${widget.email}',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Colors.grey[600],
                        ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 40),

                  // Code Field
                  TextFormField(
                    controller: _codeController,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.done,
                    // onFieldSubmitted: (_) => _handleVerifyCode(),
                    decoration: InputDecoration(
                      labelText: 'كود التحقق',
                      prefixIcon: const Icon(Icons.security),
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
                        return 'يرجى إدخال كود التحقق';
                      }
                      if (value.length < 4) {
                        return 'كود التحقق يجب أن يكون 4 أرقام على الأقل';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 30),

                  CustomButton(
                    text: 'التحقق من الكود',
                    onPressed: () {
                      context.read<AuthCubit>().registerStep2(
                          RegisterStep2RequestModel(
                              code: _codeController.text,
                              userId: widget.userId,
                              fullName: widget.fullName));
                    },
                  ),

                  const SizedBox(height: 20),

                  // Resend Code
                  TextButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('تم إرسال كود جديد'),
                          backgroundColor: Colors.green,
                        ),
                      );
                    },
                    child: Text(
                      'إعادة إرسال الكود',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
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

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_constants.dart';
import '../../core/routes/app_routes.dart';
import '../../providers/auth_provider.dart';
import '../../widgets/common/custom_button.dart';

class VerifyCodeScreen extends StatefulWidget {
  final String email;
  final String type; // 'register' or 'reset'

  const VerifyCodeScreen({
    super.key,
    required this.email,
    required this.type,
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

  // Future<void> _handleVerifyCode() async {
  //   if (!_formKey.currentState!.validate()) return;

  //   final authProvider = Provider.of<AuthProvider>(context, listen: false);
  //   bool success = false;

  //   if (widget.type == 'register') {
  //     success = await authProvider.registerStep2(_codeController.text.trim());
  //   } else {
  //     success = await authProvider.verifyCode(_codeController.text.trim());
  //   }

  //   if (success && mounted) {
  //     if (widget.type == 'register') {
  //       Navigator.pushReplacementNamed(context, AppRoutes.home);
  //     } else {
  //       // Navigate to reset password screen
  //       Navigator.pushNamed(
  //         context,
  //         '/reset-password',
  //         arguments: {
  //           'token': _codeController.text.trim(),
  //         },
  //       );
  //     }
  //   } else if (mounted) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text(authProvider.error ?? 'فشل في التحقق من الكود'),
  //         backgroundColor: Colors.red,
  //       ),
  //     );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

                // Verify Button
                // Consumer<AuthProvider>(
                //   builder: (context, authProvider, child) {
                //     return CustomButton(
                //       text: 'التحقق من الكود',
                //       // onPressed:
                //       //     authProvider.isLoading ? null : _handleVerifyCode,
                //       isLoading: authProvider.isLoading,
                //     );
                //   },
                // ),

                const SizedBox(height: 20),

                // Resend Code
                TextButton(
                  onPressed: () {
                    // TODO: Implement resend code functionality
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
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:future_app/core/di/di.dart';
import 'package:future_app/features/auth/logic/cubit/auth_cubit.dart';
import 'package:future_app/features/auth/logic/cubit/auth_state.dart';
import 'package:future_app/features/auth/presentation/screens/login_screen.dart';
import 'package:future_app/features/profile/logic/cubit/profile_cubit.dart';
import 'package:future_app/features/profile/logic/cubit/profile_state.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key, required this.inHome});
  final bool inHome;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _nicknameController = TextEditingController();
  final _mobileController = TextEditingController();
  final _teamController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _nicknameController.dispose();
    _mobileController.dispose();
    _teamController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
        state.whenOrNull(
          successGetProfile: (data) {
            // Update controllers with profile data
            _nameController.text = data.data.fullName;
            _nicknameController.text =
                data.data.bio.isNotEmpty ? data.data.bio : data.data.fullName;
            _mobileController.text = data.data.mobile;
          },
          errorGetProfile: (error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(error.message),
                backgroundColor: Colors.red,
              ),
            );
          },
        );
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: const Color(0xFF1a1a1a),
          appBar: AppBar(
            backgroundColor: const Color(0xFF1a1a1a),
            elevation: 0,
            title: const Text(
              'منطقة البروفايل',
              style: TextStyle(
                color: Color(0xFFd4af37),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Color(0xFFd4af37)),
              onPressed: () {
                widget.inHome
                    ? Navigator.pop(context)
                    : context.read<AuthCubit>().logout();
              },
            ),
          ),
          body: state.maybeWhen(
            loadingGetProfile: () => const Center(
              child: CircularProgressIndicator(color: Color(0xFFd4af37)),
            ),
            orElse: () => _buildProfileBody(),
          ),
        );
      },
    );
  }

  Widget _buildProfileBody() {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Header
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFd4af37), Color(0xFFb8860b)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: state.maybeWhen(
                  successGetProfile: (data) => Column(
                    children: [
                      // Profile Avatar
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(40),
                          border: Border.all(
                            color: Colors.white,
                            width: 3,
                          ),
                        ),
                        child: data.data.avatar.isNotEmpty
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(40),
                                child: Image.network(
                                  data.data.avatar,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      const Icon(
                                    Icons.person,
                                    size: 40,
                                    color: Color(0xFFd4af37),
                                  ),
                                ),
                              )
                            : const Icon(
                                Icons.person,
                                size: 40,
                                color: Color(0xFFd4af37),
                              ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        data.data.fullName,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        data.data.email,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  orElse: () => Column(
                    children: [
                      // Profile Avatar
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(40),
                          border: Border.all(
                            color: Colors.white,
                            width: 3,
                          ),
                        ),
                        child: const Icon(
                          Icons.person,
                          size: 40,
                          color: Color(0xFFd4af37),
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'جاري التحميل...',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Profile Form
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
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'تعديل البيانات',
                        style: TextStyle(
                          color: Color(0xFFd4af37),
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Name Field
                      _buildTextField(
                        controller: _nameController,
                        label: 'الاسم',
                        icon: Icons.person,
                        enabled: false, // Name cannot be changed
                      ),

                      const SizedBox(height: 16),

                      // Nickname Field
                      _buildTextField(
                        controller: _nicknameController,
                        label: 'الاسم الثاني',
                        icon: Icons.badge,
                      ),

                      const SizedBox(height: 16),

                      // Mobile Field
                      _buildTextField(
                        controller: _mobileController,
                        label: 'رقم الموبايل',
                        icon: Icons.phone,
                        keyboardType: TextInputType.phone,
                      ),

                      const SizedBox(height: 16),

                      // Team Field
                      _buildTextField(
                        controller: _teamController,
                        label: "",
                        icon: Icons.group,
                        enabled: false, // Team cannot be changed
                      ),

                      const SizedBox(height: 24),

                      // Password Reset Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () => _showPasswordResetDialog(),
                          icon: const Icon(Icons.lock_reset),
                          label: const Text('إعادة تعين كلمة المرور'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFd4af37),
                            foregroundColor: Colors.black,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Save Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _saveProfile,
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
                            'حفظ التغييرات',
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
              ),

              const SizedBox(height: 24),

              // Quality Control Message
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF2a2a2a),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.orange.withOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: const Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: Colors.orange,
                      size: 24,
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'مراقبة الجودة: التحميل متاح فقط للطلاب المسجلين',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const LogoutListener()
            ],
          ),
        );
      },
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType? keyboardType,
    bool enabled = true,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      enabled: enabled,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 16,
      ),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          color: enabled ? const Color(0xFFd4af37) : Colors.white54,
        ),
        prefixIcon: Icon(
          icon,
          color: enabled ? const Color(0xFFd4af37) : Colors.white54,
        ),
        filled: true,
        fillColor: enabled ? const Color(0xFF1a1a1a) : const Color(0xFF2a2a2a),
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
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: Colors.white54.withOpacity(0.3),
          ),
        ),
      ),
    );
  }

  void _saveProfile() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('تم حفظ البيانات بنجاح'),
          backgroundColor: Color(0xFFd4af37),
        ),
      );
    }
  }

  void _showPasswordResetDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF2a2a2a),
        title: const Text(
          'إعادة تعين كلمة المرور',
          style: TextStyle(
            color: Color(0xFFd4af37),
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: const Text(
          'سيتم إرسال رابط إعادة تعين كلمة المرور إلى بريدك الإلكتروني المسجل.',
          style: TextStyle(
            color: Colors.white70,
            fontSize: 14,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'إلغاء',
              style: TextStyle(
                color: Colors.white70,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('تم إرسال رابط إعادة تعين كلمة المرور'),
                  backgroundColor: Color(0xFFd4af37),
                ),
              );
            },
            child: const Text(
              'إرسال',
              style: TextStyle(
                color: Color(0xFFd4af37),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class LogoutListener extends StatelessWidget {
  const LogoutListener({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listenWhen: (previous, current) =>
          current is SuccessLogout ||
          current is LoadingLogout ||
          current is ErrorLogout,
      listener: (context, state) {
        state.whenOrNull(
          errorLogout: (error) {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(error.message),
                backgroundColor: Colors.red,
              ),
            );
          },
          loadingLogout: () {
            showDialog(
              context: context,
              builder: (context) {
                return const Center(
                    child: CircularProgressIndicator(color: Color(0xFFd4af37)));
              },
            );
          },
          successLogout: () {
            Navigator.pop(context);
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
                (route) => false);
          },
        );
      },
      child: const SizedBox(),
    );
  }
}


/*

get profile flow :
1-api call : panel/profile-setting
2-create response model use json serilizable : response : {
    "success": true,
    "message": "تم جلب البيانات بنجاح.",
    "data": {
        "id": "3",
        "full_name": "ahmed",
        "email": "adel0@gmail.com",
        "mobile": "01003574672",
        "bio": "",
        "about": "",
        "avatar": "https://secure.gravatar.com/avatar/3c322ce59d5e1a9402b0875dcd99b4c2cb0adcf805bbe2df00ef14cb3714cb72?s=300&d=mm&r=g",
        "cover": ""
    }
}
3- create getProfile in ApiService and use getProfileResponseModel in return type 
4- create getProfileRepo and use ApiService in return type 
5- create getProfileCubit and use getProfileRepo in return type 
6- create getProfileState and use getProfileCubit in return type 
7 - add repo and cubit to di.dart 
8 - connect cubit to view path : lib\features\profile\profile_screen.dart


*/
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:future_app/core/helper/shared_pref_helper.dart';
import 'package:future_app/core/helper/shared_pref_keys.dart';
import 'package:future_app/core/routes/app_routes.dart';
import 'package:future_app/features/auth/logic/cubit/auth_cubit.dart';
import 'package:future_app/features/auth/logic/cubit/auth_state.dart';
import 'package:future_app/features/auth/presentation/screens/login_screen.dart';
import 'package:future_app/features/home/presentation/home_screen.dart';
import 'package:future_app/features/profile/logic/cubit/profile_cubit.dart';
import 'package:future_app/features/profile/logic/cubit/profile_state.dart';
import 'package:future_app/features/profile/data/models/update_profile_response_model.dart';
import 'package:future_app/screens/main/main_navigation_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';
import 'package:permission_handler/permission_handler.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key, required this.inHome});
  final bool inHome;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _mobileController = TextEditingController();
  final _teamController = TextEditingController();
  final _aboutController = TextEditingController();
  final ImagePicker _imagePicker = ImagePicker();
  File? _selectedImage;

  @override
  void dispose() {
    _nameController.dispose();
    _mobileController.dispose();
    _teamController.dispose();
    _aboutController.dispose();
    super.dispose();
  }

  Future<void> _showImageSourceDialog() async {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF2a2a2a),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[600],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'اختر مصدر الصورة',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: _buildImageSourceOption(
                      icon: Icons.photo_library,
                      title: 'المعرض',
                      onTap: () {
                        Navigator.pop(context);
                        _pickImage(ImageSource.gallery);
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildImageSourceOption(
                      icon: Icons.camera_alt,
                      title: 'الكاميرا',
                      onTap: () {
                        Navigator.pop(context);
                        _pickImage(ImageSource.camera);
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  Widget _buildImageSourceOption({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        decoration: BoxDecoration(
          color: const Color(0xFF1a1a1a),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: const Color(0xFFd4af37).withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: const Color(0xFFd4af37),
              size: 32,
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      // Debug permissions (remove this in production)
      await _debugPermissions();

      // Check and request permissions based on source
      String permissionMessage = '';

      if (source == ImageSource.camera) {
        // For camera access
        permissionMessage =
            'يحتاج التطبيق إلى إذن الوصول للكاميرا لالتقاط صورة';

        PermissionStatus cameraStatus = await Permission.camera.status;
        if (cameraStatus.isGranted) {
          // Camera permission is already granted, proceed
        } else if (cameraStatus.isDenied) {
          cameraStatus = await Permission.camera.request();
          if (cameraStatus.isGranted) {
            // Camera permission granted, proceed
          } else if (cameraStatus.isPermanentlyDenied) {
            _showPermissionSettingsDialog(permissionMessage);
            return;
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(permissionMessage),
                backgroundColor: Colors.red,
                duration: const Duration(seconds: 3),
              ),
            );
            return;
          }
        } else if (cameraStatus.isPermanentlyDenied) {
          _showPermissionSettingsDialog(permissionMessage);
          return;
        }
      } else {
        // For gallery access
        permissionMessage = 'يحتاج التطبيق إلى إذن الوصول للمعرض لاختيار صورة';

        bool hasPermission = await _requestGalleryPermissions();
        if (!hasPermission) {
          // Check if any permission is permanently denied
          PermissionStatus photosStatus = await Permission.photos.status;
          PermissionStatus storageStatus = await Permission.storage.status;

          if (photosStatus.isPermanentlyDenied ||
              storageStatus.isPermanentlyDenied) {
            _showPermissionSettingsDialog(permissionMessage);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(permissionMessage),
                backgroundColor: Colors.red,
                duration: const Duration(seconds: 3),
              ),
            );
          }
          return;
        }
      }

      // Permissions granted, proceed with image picking
      final XFile? image = await _imagePicker.pickImage(
        source: source,
        maxWidth: 512,
        maxHeight: 512,
        imageQuality: 80,
      );

      if (image != null) {
        setState(() {
          _selectedImage = File(image.path);
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('خطأ في اختيار الصورة: $e'),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  void _showPermissionSettingsDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF2a2a2a),
          title: const Text(
            'إذن مطلوب',
            style: TextStyle(
              color: Color(0xFFd4af37),
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            '$message\n\nيرجى السماح بالوصول من إعدادات التطبيق.',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                'إلغاء',
                style: TextStyle(color: Colors.grey),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                openAppSettings();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFd4af37),
                foregroundColor: Colors.black,
              ),
              child: const Text('فتح الإعدادات'),
            ),
          ],
        );
      },
    );
  }

  // Helper method to check if we have sufficient permissions for gallery access
  Future<bool> _hasGalleryPermissions() async {
    // Check for different permission types based on Android version
    final photosStatus = await Permission.photos.status;
    final storageStatus = await Permission.storage.status;
    final mediaLibraryStatus = await Permission.mediaLibrary.status;

    // Return true if any of the permissions are granted
    return photosStatus.isGranted ||
        storageStatus.isGranted ||
        mediaLibraryStatus.isGranted;
  }

  // Helper method to request gallery permissions with fallback
  Future<bool> _requestGalleryPermissions() async {
    // Try photos permission first (Android 13+)
    PermissionStatus photosStatus = await Permission.photos.status;
    if (photosStatus.isGranted) {
      return true;
    }

    if (photosStatus.isDenied) {
      photosStatus = await Permission.photos.request();
      if (photosStatus.isGranted) {
        return true;
      }
    }

    // Fallback to storage permission (Android 12 and below)
    PermissionStatus storageStatus = await Permission.storage.status;
    if (storageStatus.isGranted) {
      return true;
    }

    if (storageStatus.isDenied) {
      storageStatus = await Permission.storage.request();
      if (storageStatus.isGranted) {
        return true;
      }
    }

    // Try mediaLibrary permission as last resort
    PermissionStatus mediaLibraryStatus = await Permission.mediaLibrary.status;
    if (mediaLibraryStatus.isGranted) {
      return true;
    }

    if (mediaLibraryStatus.isDenied) {
      mediaLibraryStatus = await Permission.mediaLibrary.request();
      if (mediaLibraryStatus.isGranted) {
        return true;
      }
    }

    return false;
  }

  // Debug method to check all permission statuses
  Future<void> _debugPermissions() async {
    print('=== Permission Status Debug ===');
    print('Camera: ${await Permission.camera.status}');
    print('Photos: ${await Permission.photos.status}');
    print('Storage: ${await Permission.storage.status}');
    print('MediaLibrary: ${await Permission.mediaLibrary.status}');
    print('===============================');
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
        state.whenOrNull(
          successGetProfile: (data) {
            // Update controllers with profile data
            _nameController.text = data.data.fullName;
            _mobileController.text = data.data.mobile;
            _aboutController.text = data.data.about;
          },
          errorGetProfile: (error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(error.getAllErrorsAsString()),
                backgroundColor: Colors.red,
              ),
            );
          },
          successUpdateProfile: (data) {
            SharedPrefHelper.setData(
                SharedPrefKeys.userName, _nameController.text.trim());
            // Clear selected image after successful update
            setState(() {
              _selectedImage = null;
            });
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(data.message),
                backgroundColor: const Color(0xFFd4af37),
              ),
            );
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) => const MainNavigationScreen()),
                (route) => false);
          },
          errorUpdateProfile: (error) {
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
                      Stack(
                        children: [
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
                            child: _selectedImage != null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(40),
                                    child: Image.file(
                                      _selectedImage!,
                                      fit: BoxFit.cover,
                                      width: 80,
                                      height: 80,
                                    ),
                                  )
                                : data.data.avatar.isNotEmpty
                                    ? ClipRRect(
                                        borderRadius: BorderRadius.circular(40),
                                        child: Image.network(
                                          data.data.avatar,
                                          fit: BoxFit.cover,
                                          width: 80,
                                          height: 80,
                                          errorBuilder:
                                              (context, error, stackTrace) =>
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
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: GestureDetector(
                              onTap: _showImageSourceDialog,
                              child: Container(
                                width: 24,
                                height: 24,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFd4af37),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 2,
                                  ),
                                ),
                                child: const Icon(
                                  Icons.camera_alt,
                                  color: Colors.white,
                                  size: 12,
                                ),
                              ),
                            ),
                          ),
                        ],
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
                      Stack(
                        children: [
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
                            child: _selectedImage != null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(40),
                                    child: Image.file(
                                      _selectedImage!,
                                      fit: BoxFit.cover,
                                      width: 80,
                                      height: 80,
                                    ),
                                  )
                                : const Icon(
                                    Icons.person,
                                    size: 40,
                                    color: Color(0xFFd4af37),
                                  ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: GestureDetector(
                              onTap: _showImageSourceDialog,
                              child: Container(
                                width: 24,
                                height: 24,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFd4af37),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 2,
                                  ),
                                ),
                                child: const Icon(
                                  Icons.camera_alt,
                                  color: Colors.white,
                                  size: 12,
                                ),
                              ),
                            ),
                          ),
                        ],
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
                        enabled: true, // Name can be changed
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

                      // About Field
                      _buildTextField(
                        controller: _aboutController,
                        label: 'نبذة عني',
                        icon: Icons.info_outline,
                        maxLines: 3,
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
                          onPressed: () {
                            Navigator.pushNamed(
                                context, AppRoutes.editPassword);
                          },
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
    int? maxLines,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      enabled: enabled,
      maxLines: maxLines ?? 1,
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
      // Check if there's a selected image
      if (_selectedImage != null) {
        // Create FormData for profile update with image
        final formData = FormData.fromMap({
          'fullName': _nameController.text.trim(),
          'mobile': _mobileController.text.trim(),
          'bio': _nameController.text.trim(), // Use the same name for bio
          'about': _aboutController.text.trim(),
          'avatar': MultipartFile.fromFileSync(
            _selectedImage!.path,
            filename: 'avatar.jpg',
          ),
        });

        context.read<ProfileCubit>().updateProfileWithImage(formData);
      } else {
        // Update profile without image
        final request = UpdateProfileRequestModel(
          fullName: _nameController.text.trim(),
          mobile: _mobileController.text.trim(),
          bio: _nameController.text.trim(), // Use the same name for bio
          about: _aboutController.text.trim(),
        );

        context.read<ProfileCubit>().updateProfile(request);
      }
    }
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
                content: Text(error.getAllErrorsAsString()),
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

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:future_app/core/constants/app_constants.dart';
import 'package:future_app/core/services/storage_service.dart';

class AssignmentScreen extends StatefulWidget {
  final String assignmentId;
  final String assignmentTitle;
  final String? pdfUrl;
  final String? description;

  const AssignmentScreen({
    super.key,
    required this.assignmentId,
    required this.assignmentTitle,
    this.pdfUrl,
    this.description,
  });

  @override
  State<AssignmentScreen> createState() => _AssignmentScreenState();
}

class _AssignmentScreenState extends State<AssignmentScreen> {
  String? _cleanedPdfUrl;
  File? _selectedFile;
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    _cleanedPdfUrl = _extractUrlFromHtml(widget.pdfUrl ?? widget.description ?? '');
  }

  /// استخراج الرابط من النص HTML
  String _extractUrlFromHtml(String? htmlText) {
    if (htmlText == null || htmlText.isEmpty) {
      return '';
    }

    // إزالة HTML tags
    String cleaned = htmlText
        .replaceAll(RegExp(r'<[^>]*>'), '') // إزالة جميع HTML tags
        .trim();

    // البحث عن رابط HTTP أو HTTPS
    final urlRegex = RegExp(
      r'https?://[^\s<>\"]+',
      caseSensitive: false,
    );

    final match = urlRegex.firstMatch(cleaned);
    if (match != null) {
      return match.group(0) ?? cleaned;
    }

    // إذا لم نجد رابط، نعيد النص المطهر
    return cleaned;
  }


  Future<void> _pickFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.any,
        allowMultiple: false,
      );

      if (result != null && result.files.single.path != null) {
        setState(() {
          _selectedFile = File(result.files.single.path!);
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('خطأ في اختيار الملف: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _submitAssignment() async {
    if (_selectedFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('يرجى اختيار ملف للإرسال'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    try {
      final token = StorageService.getToken();
      if (token == null) {
        throw Exception('يجب تسجيل الدخول أولاً');
      }

      final dio = Dio();
      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(
          _selectedFile!.path,
          filename: _selectedFile!.path.split('/').last,
        ),
      });

      final response = await dio.post(
        '${AppConstants.baseUrl}/panel/assignments/${widget.assignmentId}/submit',
        data: formData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'x-api-key': AppConstants.apiKey,
            'X-App-Source': AppConstants.appSource,
            'Accept': 'application/json',
          },
        ),
      );

      if (mounted) {
        if (response.statusCode == 200 || response.statusCode == 201) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Row(
                children: [
                  Icon(
                    Icons.check_circle,
                    color: Colors.white,
                    size: 20,
                  ),
                  SizedBox(width: 8),
                  Text('تم إرسال الواجب بنجاح'),
                ],
              ),
              backgroundColor: Colors.green,
              duration: Duration(seconds: 3),
            ),
          );

          // Clear selected file after successful submission
          setState(() {
            _selectedFile = null;
          });

          // Optionally navigate back
          // Navigator.pop(context);
        } else {
          throw Exception('فشل إرسال الواجب');
        }
      }
    } catch (e) {
      if (mounted) {
        String errorMessage = 'خطأ في إرسال الواجب';
        if (e is DioException) {
          if (e.response != null) {
            errorMessage = e.response?.data['message'] ?? errorMessage;
          } else {
            errorMessage = 'تحقق من اتصال الإنترنت';
          }
        } else {
          errorMessage = e.toString();
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 3),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1a1a1a),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1a1a1a),
        elevation: 0,
        title: Text(
          widget.assignmentTitle,
          style: const TextStyle(
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
      body: Column(
        children: [
          // PDF Viewer Section
          Expanded(
            child: Container(
              color: Colors.black,
              child: _cleanedPdfUrl != null && _cleanedPdfUrl!.isNotEmpty
                  ? SfPdfViewer.network(_cleanedPdfUrl!)
                  : const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.picture_as_pdf_outlined,
                            color: Color(0xFFd4af37),
                            size: 64,
                          ),
                          SizedBox(height: 16),
                          Text(
                            'لا يوجد ملف PDF متاح',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
            ),
          ),

          // Submit Section
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF2a2a2a),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // File Selection Button
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF1a1a1a),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: const Color(0xFFd4af37).withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: _pickFile,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.attach_file,
                              color: Color(0xFFd4af37),
                              size: 24,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'اختر ملف للإرسال',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  if (_selectedFile != null)
                                    Padding(
                                      padding: const EdgeInsets.only(top: 4),
                                      child: Text(
                                        _selectedFile!.path.split('/').last,
                                        style: const TextStyle(
                                          color: Color(0xFFd4af37),
                                          fontSize: 12,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            if (_selectedFile != null)
                              IconButton(
                                icon: const Icon(
                                  Icons.close,
                                  color: Colors.red,
                                  size: 20,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _selectedFile = null;
                                  });
                                },
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Submit Button
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        const Color(0xFFd4af37),
                        const Color(0xFFd4af37).withOpacity(0.8),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFd4af37).withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: _isSubmitting ? null : _submitAssignment,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 16,
                          horizontal: 24,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (_isSubmitting)
                              const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.black,
                                  ),
                                ),
                              )
                            else
                              const Icon(
                                Icons.send,
                                color: Colors.black,
                                size: 24,
                              ),
                            const SizedBox(width: 12),
                            Text(
                              _isSubmitting ? 'جاري الإرسال...' : 'إرسال الواجب',
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


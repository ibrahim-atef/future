import 'dart:io';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/services/download_service.dart';

class PDFViewerWidget extends StatefulWidget {
  final String pdfUrl;
  final String title;
  final bool isDownloadable;

  const PDFViewerWidget({
    super.key,
    required this.pdfUrl,
    required this.title,
    this.isDownloadable = true,
  });

  @override
  State<PDFViewerWidget> createState() => _PDFViewerWidgetState();
}

class _PDFViewerWidgetState extends State<PDFViewerWidget> {
  final DownloadService _downloadService = DownloadService();
  bool _isDownloading = false;
  String? _cleanedPdfUrl;

  @override
  void initState() {
    super.initState();
    _cleanedPdfUrl = _extractUrlFromHtml(widget.pdfUrl);
    print('Original pdfUrl: ${widget.pdfUrl}');
    print('Cleaned pdfUrl: $_cleanedPdfUrl');
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

  Future<bool> _requestStoragePermission() async {
    print('Requesting storage permission...');

    // For Android 13+ (API 33+), we use app-specific directory (no permissions needed)
    try {
      // Test if we can access the external storage directory
      final directory = await getExternalStorageDirectory();
      if (directory != null) {
        // Try to create a test file to verify write access
        final testFile = File('${directory.path}/test_write_permission.tmp');
        try {
          await testFile.writeAsString('test');
          await testFile.delete();
          print('External storage directory accessible');
          return true;
        } catch (e) {
          print('Cannot write to external storage: $e');
        }
      }
    } catch (e) {
      print('Error accessing external storage: $e');
    }

    // Check storage permission for Android 12 and below
    var status = await Permission.storage.status;
    print('Storage permission status: $status');

    if (status.isGranted) {
      print('Storage permission already granted');
      return true;
    }

    if (status.isDenied) {
      print('Requesting storage permission...');
      status = await Permission.storage.request();
      print('Storage permission result: $status');

      if (status.isGranted) {
        return true;
      }
    }

    if (status.isPermanentlyDenied || status.isDenied) {
      // Show dialog to open app settings
      print('Showing permission dialog...');
      return await _showPermissionDialog();
    }

    print('No permission granted, but continuing with app directory');
    // Even without permissions, we can still use the app's own directory
    return true;
  }

  Future<bool> _showPermissionDialog() async {
    print('PDFViewer: Showing permission dialog...');
    return await showDialog<bool>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('إذن التخزين مطلوب'),
              content: const Text(
                  'يحتاج التطبيق إلى إذن الوصول للتخزين لتحميل الملفات. يرجى السماح بالوصول من إعدادات التطبيق.'),
              actions: [
                TextButton(
                  onPressed: () {
                    print('PDFViewer: User cancelled permission dialog');
                    Navigator.of(context).pop(false);
                  },
                  child: const Text('إلغاء'),
                ),
                TextButton(
                  onPressed: () {
                    print('PDFViewer: User chose to open app settings');
                    Navigator.of(context).pop(true);
                    openAppSettings();
                  },
                  child: const Text('فتح الإعدادات'),
                ),
              ],
            );
          },
        ) ??
        false;
  }

  Future<void> _openPDFExternally() async {
    final pdfUrl = _cleanedPdfUrl ?? '';
    if (pdfUrl.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('رابط الملف غير صحيح'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    try {
      final Uri url = Uri.parse(pdfUrl);
      if (await canLaunchUrl(url)) {
        // فتح الرابط في المتصفح فقط بدون تحميل
        await launchUrl(
          url,
        );
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('لا يمكن فتح الملف خارج التطبيق'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('خطأ في فتح الملف: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _downloadPDF() async {
    setState(() {
      _isDownloading = true;
    });

    try {
      // طلب إذن التخزين أولاً
      print('PDFViewer: Requesting storage permission...');
      final hasPermission = await _requestStoragePermission();
      print('PDFViewer: Permission result: $hasPermission');

      if (!hasPermission) {
        print('PDFViewer: Permission denied, showing error message');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
                'تحتاج إلى إذن الوصول للتخزين لتحميل الملف. يرجى السماح بالوصول من إعدادات التطبيق'),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 5),
          ),
        );
        return;
      }

      print('PDFViewer: Permission granted, proceeding with download');

      // استخراج اسم الملف من الرابط
      String fileName = widget.title.replaceAll(RegExp(r'[^\w\s-]'), '_');
      fileName = fileName.replaceAll(' ', '_');
      fileName = '$fileName.pdf';

      // التأكد من أن الـ URL صحيح
      final pdfUrl = _cleanedPdfUrl ?? '';
      if (pdfUrl.isEmpty) {
        throw Exception('رابط الملف غير صحيح');
      }

      print('Starting download for: ${widget.title}');
      print('URL: $pdfUrl');
      print('FileName: $fileName');

      // بدء التحميل مباشرة
      final result = await _downloadService.downloadFile(
        url: pdfUrl,
        fileName: fileName,
        fileType: 'PDF',
        title: widget.title,
      );

      print('Download result: $result');

      if (result != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('تم بدء تحميل الملف: ${widget.title}'),
            backgroundColor: Colors.green,
            duration: const Duration(seconds: 3),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('حدث خطأ أثناء بدء التحميل. يرجى المحاولة مرة أخرى'),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 4),
          ),
        );
      }
    } catch (e) {
      print('Download error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('خطأ في التحميل: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        _isDownloading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1a1a1a),
        title: Text(
          widget.title,
          style: const TextStyle(
            color: Color(0xFFd4af37),
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFFd4af37)),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          // زر فتح PDF خارج التطبيق
          IconButton(
            icon: const Icon(Icons.open_in_new, color: Color(0xFFd4af37)),
            onPressed: _openPDFExternally,
            tooltip: 'فتح الملف خارج التطبيق',
          ),
          // زر التحميل
          // if (widget.isDownloadable)
          //   IconButton(
          //     icon: _isDownloading
          //         ? const SizedBox(
          //             width: 20,
          //             height: 20,
          //             child: CircularProgressIndicator(
          //               strokeWidth: 2,
          //               valueColor:
          //                   AlwaysStoppedAnimation<Color>(Color(0xFFd4af37)),
          //             ),
          //           )
          //         : const Icon(Icons.download, color: Color(0xFFd4af37)),
          //     onPressed: _isDownloading ? null : _downloadPDF,
          //     tooltip: 'تحميل الملف',
          //   ),
        ],
      ),
      body: Container(
        child: _cleanedPdfUrl != null && _cleanedPdfUrl!.isNotEmpty
            ? SfPdfViewer.network(
                _cleanedPdfUrl!,
              )
            : const Center(
                child: Text('رابط الملف غير صحيح'),
              ),
      ),
    );
  }
}

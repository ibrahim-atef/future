import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
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
  bool _isDownloading = true;

  @override
  void initState() {
    print('pdfUrl: ${widget.pdfUrl}');
    super.initState();
  }

  Future<void> _downloadPDF() async {
    if (!widget.isDownloadable) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('هذا الملف غير متاح للتحميل'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    setState(() {
      _isDownloading = true;
    });

    try {
      // طلب إذن التخزين أولاً
      final hasPermission = await _downloadService.requestPermissions();
      if (!hasPermission) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('تحتاج إلى إذن الوصول للتخزين لتحميل الملف'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      // استخراج اسم الملف من الرابط
      String fileName = widget.title.replaceAll(RegExp(r'[^\w\s-]'), '_');
      fileName = fileName.replaceAll(' ', '_');
      fileName = '$fileName.pdf';

      // بدء التحميل مباشرة
      final result = await _downloadService.downloadFile(
        url: widget.pdfUrl,
        fileName: fileName,
        fileType: 'PDF',
        title: widget.title,
      );

      if (result != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('تم بدء تحميل الملف بنجاح'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('حدث خطأ أثناء بدء التحميل'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
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
        title: Text(widget.title),
        actions: widget.isDownloadable
            ? [
                IconButton(
                  icon: _isDownloading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                      : const Icon(Icons.download),
                  onPressed: _isDownloading ? null : _downloadPDF,
                  tooltip: 'تحميل الملف',
                ),
              ]
            : null,
      ),
      body: Container(
        child: SfPdfViewer.network(
            'https://future.anmka.com/wp-content/uploads/2025/10/قضاء_الالغاء_القائم_بالتدريس_د_منى_رمضان-3_transfer_٢٠٢٥-١٠-٢٠_١٩٥٩٤٩.pdf'),
      ),
    );
  }
}

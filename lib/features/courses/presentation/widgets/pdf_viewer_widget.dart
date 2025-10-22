import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

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
  @override
  void initState() {
    print('pdfUrl: ${widget.pdfUrl}');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(widget.title)),
        body: Container(child: SfPdfViewer.network(widget.pdfUrl)));
  }
}

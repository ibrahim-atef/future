import 'package:flutter/material.dart';

class QuizResultScreen extends StatelessWidget {
  final dynamic result;

  const QuizResultScreen({
    super.key,
    required this.result,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('نتيجة الاختبار'),
      ),
      body: const Center(
        child: Text('صفحة نتيجة الاختبار - قيد التطوير'),
      ),
    );
  }
}

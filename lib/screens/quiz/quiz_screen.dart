import 'package:flutter/material.dart';

class QuizScreen extends StatelessWidget {
  final String quizId;
  final String quizTitle;

  const QuizScreen({
    super.key,
    required this.quizId,
    required this.quizTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(quizTitle),
      ),
      body: Center(
        child: Text('صفحة الاختبار - قيد التطوير\nID: $quizId'),
      ),
    );
  }
}

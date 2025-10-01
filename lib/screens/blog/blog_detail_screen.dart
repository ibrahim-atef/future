import 'package:flutter/material.dart';

class BlogDetailScreen extends StatelessWidget {
  final String postId;
  final String postTitle;

  const BlogDetailScreen({
    super.key,
    required this.postId,
    required this.postTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(postTitle),
      ),
      body: Center(
        child: Text('تفاصيل المقال - قيد التطوير\nID: $postId'),
      ),
    );
  }
}

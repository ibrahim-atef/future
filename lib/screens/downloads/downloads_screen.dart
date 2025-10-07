import 'package:flutter/material.dart';

class DownloadsScreen extends StatelessWidget {
  const DownloadsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('التحميلات'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: _buildLectureList(),
        ));
  }
}

Widget _buildLectureList() {
  final lectures = [
    {
      'title': 'مقدمة في القانون المدني',
      'duration': '15:30',
      'type': 'youtube'
    },
    {'title': 'أساسيات العقود', 'duration': '22:45', 'type': 'server'},
    {'title': 'المسؤولية المدنية', 'duration': '18:20', 'type': 'youtube'},
    {'title': 'حقوق الملكية', 'duration': '25:10', 'type': 'server'},
    {'title': 'الالتزامات', 'duration': '20:15', 'type': 'youtube'},
  ];

  return ListView.builder(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemCount: lectures.length,
    itemBuilder: (context, index) {
      final lecture = lectures[index];
      return Container(
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          color: const Color(0xFF2a2a2a),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: const Color(0xFFd4af37).withOpacity(0.3),
            width: 1,
          ),
        ),
        child: ListTile(
          leading: Icon(
            lecture['type'] == 'youtube'
                ? Icons.play_circle
                : Icons.video_library,
            color: const Color(0xFFd4af37),
          ),
          title: Text(
            lecture['title']!,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          subtitle: Text(
            lecture['duration']!,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 12,
            ),
          ),
          trailing: const Icon(
            Icons.play_arrow,
            color: Color(0xFFd4af37),
          ),
          onTap: () {
            // Handle lecture tap
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('فتح ${lecture['title']}'),
                backgroundColor: const Color(0xFFd4af37),
              ),
            );
          },
        ),
      );
    },
  );
}

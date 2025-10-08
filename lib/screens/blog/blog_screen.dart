import 'package:flutter/material.dart';

class BlogScreen extends StatefulWidget {
  const BlogScreen({super.key});

  @override
  State<BlogScreen> createState() => _BlogScreenState();
}

class _BlogScreenState extends State<BlogScreen> {
  String selectedCategory = 'الكل';

  final List<Map<String, String>> categories = [
    {'name': 'الكل', 'icon': 'all'},
    {'name': 'مقالات', 'icon': 'article'},
    {'name': 'أخبار الكلية', 'icon': 'news'},
    {'name': 'امتحانات', 'icon': 'exam'},
    {'name': 'إيفنتات الكلية', 'icon': 'event'},
  ];

  final List<Map<String, String>> allPosts = [
    {
      'title': 'نصائح للنجاح في الدراسة',
      'excerpt': 'تعرف على أفضل الطرق للدراسة الفعالة والنجاح في الامتحانات',
      'date': '2024-01-15',
      'category': 'مقالات',
    },
    {
      'title': 'افتتاح مكتبة الكلية الجديدة',
      'excerpt': 'تعلن الكلية عن افتتاح المكتبة الجديدة بمرافق حديثة ومتطورة',
      'date': '2024-01-14',
      'category': 'أخبار الكلية',
    },
    {
      'title': 'جدول امتحانات الفصل الدراسي الأول',
      'excerpt':
          'تم الإعلان عن جدول امتحانات الفصل الدراسي الأول لجميع الأقسام',
      'date': '2024-01-13',
      'category': 'امتحانات',
    },
    {
      'title': 'معرض المشاريع الطلابية السنوي',
      'excerpt': 'ندعوكم لحضور معرض المشاريع الطلابية السنوي يوم الأحد القادم',
      'date': '2024-01-12',
      'category': 'إيفنتات الكلية',
    },
    {
      'title': 'كيفية إدارة الوقت أثناء الدراسة',
      'excerpt': 'طرق فعالة لتنظيم الوقت والاستفادة القصوى من ساعات الدراسة',
      'date': '2024-01-11',
      'category': 'مقالات',
    },
    {
      'title': 'فوز فريق الكلية ببطولة كرة القدم',
      'excerpt': 'حقق فريق الكلية لكرة القدم الفوز في البطولة الجامعية',
      'date': '2024-01-10',
      'category': 'أخبار الكلية',
    },
    {
      'title': 'تعليمات هامة للامتحانات النهائية',
      'excerpt': 'قائمة بالتعليمات والإجراءات الواجب اتباعها أثناء الامتحانات',
      'date': '2024-01-09',
      'category': 'امتحانات',
    },
    {
      'title': 'ندوة عن الذكاء الاصطناعي',
      'excerpt': 'ندوة علمية عن تطبيقات الذكاء الاصطناعي في التعليم',
      'date': '2024-01-08',
      'category': 'إيفنتات الكلية',
    },
  ];

  List<Map<String, String>> get filteredPosts {
    if (selectedCategory == 'الكل') {
      return allPosts;
    }
    return allPosts
        .where((post) => post['category'] == selectedCategory)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1a1a1a),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1a1a1a),
        elevation: 0,
        title: const Text(
          'المدونة - مقالات واخبار الكلية',
          style: TextStyle(
            color: Color(0xFFd4af37),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFFd4af37)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero Section
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: const LinearGradient(
                  colors: [Color(0xFF2a2a2a), Color(0xFF1a1a1a)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                border: Border.all(
                  color: const Color(0xFFd4af37).withOpacity(0.3),
                  width: 1,
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    right: 20,
                    top: 20,
                    child: Icon(
                      Icons.article,
                      size: 60,
                      color: const Color(0xFFd4af37).withOpacity(0.3),
                    ),
                  ),
                  const Positioned(
                    left: 20,
                    bottom: 20,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'المدونة',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'مقالات وأخبار ومعلومات الكلية',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Categories Horizontal List
            SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return _buildCategoryCard(
                      categories[index]['name']!, categories[index]['icon']!);
                },
              ),
            ),

            const SizedBox(height: 24),

            // Blog Posts
            Row(
              children: [
                Text(
                  selectedCategory == 'الكل'
                      ? 'جميع المنشورات'
                      : selectedCategory,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFd4af37),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '${filteredPosts.length}',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            filteredPosts.isEmpty
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: Column(
                        children: [
                          Icon(
                            Icons.inbox_outlined,
                            size: 64,
                            color: const Color(0xFFd4af37).withOpacity(0.5),
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'لا توجد منشورات في هذه الفئة',
                            style: TextStyle(
                              color: Colors.white54,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: filteredPosts.length,
                    itemBuilder: (context, index) {
                      return _buildBlogPost(context, filteredPosts[index]);
                    },
                  ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryCard(String name, String iconType) {
    final isSelected = selectedCategory == name;
    IconData icon;

    switch (iconType) {
      case 'all':
        icon = Icons.apps;
        break;
      case 'article':
        icon = Icons.article;
        break;
      case 'news':
        icon = Icons.newspaper;
        break;
      case 'exam':
        icon = Icons.assignment;
        break;
      case 'event':
        icon = Icons.event;
        break;
      default:
        icon = Icons.category;
    }

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedCategory = name;
        });
      },
      child: Container(
        width: 120,
        margin: const EdgeInsets.only(left: 12),
        decoration: BoxDecoration(
          gradient: isSelected
              ? const LinearGradient(
                  colors: [Color(0xFFd4af37), Color(0xFFb8941f)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : null,
          color: isSelected ? null : const Color(0xFF2a2a2a),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected
                ? const Color(0xFFd4af37)
                : const Color(0xFFd4af37).withOpacity(0.3),
            width: isSelected ? 2 : 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: const Color(0xFFd4af37).withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 32,
              color: isSelected ? Colors.black : const Color(0xFFd4af37),
            ),
            const SizedBox(height: 8),
            Text(
              name,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: isSelected ? Colors.black : Colors.white,
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBlogPost(BuildContext context, Map<String, String> post) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF2a2a2a),
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
          onTap: () => _showBlogDetail(context, post),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFFd4af37),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        post['category']!,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      post['date']!,
                      style: const TextStyle(
                        color: Colors.white54,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  post['title']!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  post['excerpt']!,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                    height: 1.4,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 12),
                const Row(
                  children: [
                    Icon(
                      Icons.visibility,
                      size: 16,
                      color: Color(0xFFd4af37),
                    ),
                    SizedBox(width: 4),
                    Text(
                      'اقرأ المزيد',
                      style: TextStyle(
                        color: Color(0xFFd4af37),
                        fontSize: 12,
                      ),
                    ),
                    Spacer(),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: Color(0xFFd4af37),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showBlogDetail(BuildContext context, Map<String, String> post) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF2a2a2a),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: const Color(0xFFd4af37).withOpacity(0.3),
            width: 1,
          ),
        ),
        title: Text(
          post['title']!,
          style: const TextStyle(
            color: Color(0xFFd4af37),
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFd4af37).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  post['category']!,
                  style: const TextStyle(
                    color: Color(0xFFd4af37),
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                post['excerpt']!,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'هذا مثال على محتوى المقال الكامل. في التطبيق الحقيقي، سيتم تحميل المحتوى الكامل من الخادم.',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'إغلاق',
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

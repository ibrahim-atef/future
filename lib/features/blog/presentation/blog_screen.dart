import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:future_app/core/di/di.dart';
import 'package:future_app/features/blog/logic/cubit/blog_cubit.dart';
import 'package:future_app/features/blog/logic/cubit/blog_state.dart';
import 'package:future_app/features/blog/presentation/blog_detail_screen.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:cached_network_image/cached_network_image.dart';

class BlogScreen extends StatefulWidget {
  const BlogScreen({super.key, required this.isBackButton});
  final bool isBackButton;

  @override
  State<BlogScreen> createState() => _BlogScreenState();
}

class _BlogScreenState extends State<BlogScreen> {
  String selectedCategory = 'الكل';
  final ScrollController _scrollController = ScrollController();

  final List<Map<String, String>> categories = [
    {'name': 'الكل', 'icon': 'all'},
    {'name': 'مقالات', 'icon': 'article'},
    {'name': 'أخبار الكلية', 'icon': 'news'},
    {'name': 'امتحانات', 'icon': 'exam'},
    {'name': 'إيفنتات الكلية', 'icon': 'event'},
  ];

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.9) {
      // Load more when user scrolls to 90% of the content
      final cubit = context.read<BlogCubit>();
      if (!cubit.isLoadingMore) {
        cubit.loadMorePosts();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<BlogCubit>()..getPosts(page: 1, limit: 10),
      child: Scaffold(
        backgroundColor: const Color(0xFF1a1a1a),
        appBar: AppBar(
          backgroundColor: const Color(0xFF1a1a1a),
          elevation: 0,
          title: const Text(
            'المدونة - مقالات واخبار الكلية',
            style: TextStyle(
              color: Color(0xFFd4af37),
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          leading: widget.isBackButton
              ? IconButton(
                  icon: const Icon(Icons.arrow_back, color: Color(0xFFd4af37)),
                  onPressed: () => Navigator.pop(context),
                )
              : const SizedBox.shrink(),
        ),
        body: BlocBuilder<BlogCubit, BlogState>(
          builder: (context, state) {
            return SingleChildScrollView(
              controller: _scrollController,
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
                        return _buildCategoryCard(categories[index]['name']!,
                            categories[index]['icon']!);
                      },
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Blog Posts Content
                  state.maybeWhen(
                    getPostsLoading: () => Skeletonizer(
                      enabled: true,
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return _buildSkeletonPost();
                        },
                      ),
                    ),
                    getPostsSuccess: (data) {
                      final posts = data.data;
                      if (posts.isEmpty) {
                        return Center(
                          child: Padding(
                            padding: const EdgeInsets.all(32.0),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.inbox_outlined,
                                  size: 64,
                                  color:
                                      const Color(0xFFd4af37).withOpacity(0.5),
                                ),
                                const SizedBox(height: 16),
                                const Text(
                                  'لا توجد منشورات',
                                  style: TextStyle(
                                    color: Colors.white54,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }

                      return Column(
                        children: [
                          Row(
                            children: [
                              const Text(
                                'جميع المنشورات',
                                style: TextStyle(
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
                                  data.pagination.totalItems.toString(),
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
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: posts.length,
                            itemBuilder: (context, index) {
                              final post = posts[index];
                              return _buildBlogPost(
                                  context,
                                  post.id,
                                  post.title,
                                  post.excerpt,
                                  post.publishedAt,
                                  post.author,
                                  post.imageUrl);
                            },
                          ),
                          // Loading indicator for pagination
                          if (context.read<BlogCubit>().isLoadingMore)
                            const Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Center(
                                child: CircularProgressIndicator(
                                  color: Color(0xFFd4af37),
                                ),
                              ),
                            ),
                        ],
                      );
                    },
                    getPostsError: (error) => Center(
                      child: Padding(
                        padding: const EdgeInsets.all(32.0),
                        child: Column(
                          children: [
                            Icon(
                              Icons.error_outline,
                              size: 64,
                              color: const Color(0xFFd4af37).withOpacity(0.5),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              error.getAllErrorsAsString().isNotEmpty
                                  ? error.getAllErrorsAsString()
                                  : 'حدث خطأ في تحميل المنشورات',
                              style: const TextStyle(
                                color: Colors.white54,
                                fontSize: 16,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: () {
                                context.read<BlogCubit>().refresh();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFd4af37),
                                foregroundColor: Colors.black,
                              ),
                              child: const Text('إعادة المحاولة'),
                            ),
                          ],
                        ),
                      ),
                    ),
                    orElse: () => const SizedBox.shrink(),
                  ),
                ],
              ),
            );
          },
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

  Widget _buildBlogPost(BuildContext context, String postId, String title,
      String excerpt, String publishedAt, String author, dynamic imageUrl) {
    final String? imageUrlString = imageUrl is String && imageUrl.isNotEmpty
        ? imageUrl
        : null;
    
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
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BlogDetailScreen(
                  postId: postId,
                  postTitle: title,
                ),
              ),
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Post Image (if available)
              if (imageUrlString != null)
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: imageUrlString,
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                      height: 200,
                      color: const Color(0xFF1a1a1a),
                      child: const Center(
                        child: CircularProgressIndicator(
                          color: Color(0xFFd4af37),
                        ),
                      ),
                    ),
                    errorWidget: (context, url, error) => Container(
                      height: 200,
                      color: const Color(0xFF1a1a1a),
                      child: const Icon(
                        Icons.image_not_supported,
                        color: Colors.white54,
                        size: 48,
                      ),
                    ),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: const Color(0xFFd4af37),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              author,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        const Spacer(),
                        Text(
                          _formatDate(publishedAt),
                          style: const TextStyle(
                            color: Colors.white54,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _stripHtmlTags(excerpt),
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
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSkeletonPost() {
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
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFd4af37),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Bone.text(
                    words: 1,
                    fontSize: 12,
                  ),
                ),
                const Spacer(),
                const Bone.text(
                  words: 1,
                  fontSize: 12,
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Bone.text(
              words: 5,
              fontSize: 16,
            ),
            const SizedBox(height: 8),
            const Bone.multiText(
              lines: 2,
              fontSize: 14,
            ),
            const SizedBox(height: 12),
            const Row(
              children: [
                Bone.icon(size: 16),
                SizedBox(width: 4),
                Bone.text(words: 2, fontSize: 12),
                Spacer(),
                Bone.icon(size: 16),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _stripHtmlTags(String htmlString) {
    final RegExp exp = RegExp(r'<[^>]*>', multiLine: true, caseSensitive: true);
    return htmlString.replaceAll(exp, '');
  }

  String _formatDate(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
    } catch (e) {
      return dateString;
    }
  }
}

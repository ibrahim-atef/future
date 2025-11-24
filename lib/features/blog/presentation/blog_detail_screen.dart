import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:future_app/core/di/di.dart';
import 'package:future_app/features/blog/logic/cubit/blog_cubit.dart';
import 'package:future_app/features/blog/logic/cubit/blog_state.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cached_network_image/cached_network_image.dart';

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
    return BlocProvider(
      create: (context) => getIt<BlogCubit>()..getPostDetails(postId),
      child: Scaffold(
        backgroundColor: const Color(0xFF1a1a1a),
        appBar: AppBar(
          backgroundColor: const Color(0xFF1a1a1a),
          elevation: 0,
          title: Text(
            postTitle,
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
        body: BlocBuilder<BlogCubit, BlogState>(
          builder: (context, state) {
            return state.maybeWhen(
              getPostDetailsLoading: () => Skeletonizer(
                enabled: true,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Post Header Skeleton
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xFF2a2a2a),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: const Color(0xFFd4af37).withOpacity(0.3),
                            width: 1,
                          ),
                        ),
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Bone.multiText(
                              lines: 2,
                              fontSize: 24,
                            ),
                            SizedBox(height: 16),
                            Row(
                              children: [
                                Bone.text(words: 2, fontSize: 12),
                                SizedBox(width: 12),
                                Bone.text(words: 2, fontSize: 12),
                                Spacer(),
                                Bone.text(words: 1, fontSize: 12),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      // Post Content Skeleton
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xFF2a2a2a),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: const Color(0xFFd4af37).withOpacity(0.3),
                            width: 1,
                          ),
                        ),
                        child: const Bone.multiText(
                          lines: 15,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              getPostDetailsSuccess: (data) {
                final post = data.data;
                return SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Post Header
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xFF2a2a2a),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: const Color(0xFFd4af37).withOpacity(0.3),
                            width: 1,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Title
                            Text(
                              post.title,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                height: 1.3,
                              ),
                            ),
                            const SizedBox(height: 16),
                            // Meta Info - Fixed overflow with Flexible widgets
                            Wrap(
                              spacing: 12,
                              runSpacing: 8,
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFd4af37),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(
                                        Icons.person,
                                        size: 14,
                                        color: Colors.black,
                                      ),
                                      const SizedBox(width: 4),
                                      Flexible(
                                        child: Text(
                                          post.author,
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(
                                      Icons.calendar_today,
                                      size: 14,
                                      color: Color(0xFFd4af37),
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      _formatDate(post.publishedAt),
                                      style: const TextStyle(
                                        color: Colors.white70,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(
                                      Icons.visibility,
                                      size: 14,
                                      color: Color(0xFFd4af37),
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      '${post.viewsCount}',
                                      style: const TextStyle(
                                        color: Colors.white70,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Post Content with HTML rendering
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xFF2a2a2a),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: const Color(0xFFd4af37).withOpacity(0.3),
                            width: 1,
                          ),
                        ),
                        child: _buildContent(post.content),
                      ),

                      const SizedBox(height: 24),

                      // Tags Section (if available)
                      if (post.tags.isNotEmpty)
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: const Color(0xFF2a2a2a),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: const Color(0xFFd4af37).withOpacity(0.3),
                              width: 1,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'الوسوم',
                                style: TextStyle(
                                  color: Color(0xFFd4af37),
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: post.tags.map((tag) {
                                  return Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 6,
                                    ),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFd4af37)
                                          .withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                        color: const Color(0xFFd4af37)
                                            .withOpacity(0.5),
                                      ),
                                    ),
                                    child: Text(
                                      tag.toString(),
                                      style: const TextStyle(
                                        color: Color(0xFFd4af37),
                                        fontSize: 12,
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                );
              },
              getPostDetailsError: (error) => Center(
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
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
                            : 'حدث خطأ في تحميل تفاصيل المقال',
                        style: const TextStyle(
                          color: Colors.white54,
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          context.read<BlogCubit>().getPostDetails(postId);
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
              orElse: () => const Center(
                child: CircularProgressIndicator(
                  color: Color(0xFFd4af37),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildContent(String htmlContent) {
    // Extract images from HTML
    final imageRegExp = RegExp(
      '<img[^>]+src=["\']([^"\']+)["\'][^>]*>',
      caseSensitive: false,
    );
    final images = imageRegExp.allMatches(htmlContent);

    // Extract links from HTML
    final linkRegExp = RegExp(
      '<a[^>]+href=["\']([^"\']+)["\'][^>]*>([^<]+)</a>',
      caseSensitive: false,
    );
    final links = linkRegExp.allMatches(htmlContent);

    // Extract text content with clickable links
    final textWithLinks = _buildTextWithClickableLinks(htmlContent);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Display text content with clickable links
        if (textWithLinks != null)
          textWithLinks,

        // Display images
        ...images.map((match) {
          final imageUrl = match.group(1);
          if (imageUrl == null || imageUrl.isEmpty) return const SizedBox.shrink();
          
            return Padding(
              padding: const EdgeInsets.only(top: 16),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  placeholder: (context, url) => Container(
                    height: 200,
                    decoration: BoxDecoration(
                      color: const Color(0xFF1a1a1a),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Center(
                      child: CircularProgressIndicator(
                        color: Color(0xFFd4af37),
                      ),
                    ),
                  ),
                  errorWidget: (context, url, error) => Container(
                    height: 200,
                    decoration: BoxDecoration(
                      color: const Color(0xFF1a1a1a),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.broken_image,
                        color: Colors.white54,
                        size: 48,
                      ),
                    ),
                  ),
                ),
              ),
            );
        }),

        // Display links
        if (links.isNotEmpty) ...[
          const SizedBox(height: 16),
          const Text(
            'روابط ذات صلة:',
            style: TextStyle(
              color: Color(0xFFd4af37),
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          ...links.map((match) {
            final linkUrl = match.group(1);
            final linkText = match.group(2) ?? linkUrl ?? '';
            
            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: InkWell(
                onTap: () async {
                  // Handle link tap
                  if (linkUrl != null && linkUrl.isNotEmpty) {
                    final Uri url = Uri.parse(linkUrl);
                    if (await canLaunchUrl(url)) {
                      await launchUrl(url, mode: LaunchMode.externalApplication);
                    }
                  }
                },
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1a1a1a),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: const Color(0xFFd4af37).withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.link,
                        color: Color(0xFFd4af37),
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              linkText,
                              style: const TextStyle(
                                color: Color(0xFFd4af37),
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            if (linkUrl != null && linkUrl != linkText)
                              Text(
                                linkUrl,
                                style: const TextStyle(
                                  color: Colors.white54,
                                  fontSize: 12,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                          ],
                        ),
                      ),
                      const Icon(
                        Icons.open_in_new,
                        color: Color(0xFFd4af37),
                        size: 18,
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ],
      ],
    );
  }

  Widget? _buildTextWithClickableLinks(String htmlContent) {
    // Extract all links with their positions
    final linkRegExp = RegExp(
      '<a[^>]+href=["\']([^"\']+)["\'][^>]*>([^<]+)</a>',
      caseSensitive: false,
    );
    final linkMatches = linkRegExp.allMatches(htmlContent);

    if (linkMatches.isEmpty) {
      // No links, just return plain text
      final cleanText = _stripHtmlTags(htmlContent);
      if (cleanText.trim().isEmpty) return null;
      
      return Text(
        cleanText
            .replaceAll('&hellip;', '...')
            .replaceAll('&nbsp;', ' ')
            .replaceAll('&amp;', '&')
            .replaceAll('&lt;', '<')
            .replaceAll('&gt;', '>')
            .replaceAll('&quot;', '"')
            .trim(),
        style: const TextStyle(
          color: Colors.white70,
          fontSize: 16,
          height: 1.6,
        ),
      );
    }

    // Build RichText with clickable links
    final textSpans = <TextSpan>[];
    int lastIndex = 0;
    
    // Remove link tags from HTML to get plain text positions
    String textWithoutLinks = htmlContent;
    for (final match in linkMatches) {
      final linkText = match.group(2) ?? '';
      textWithoutLinks = textWithoutLinks.replaceFirst(match.group(0) ?? '', linkText);
    }
    
    final cleanText = _stripHtmlTags(textWithoutLinks)
        .replaceAll('&hellip;', '...')
        .replaceAll('&nbsp;', ' ')
        .replaceAll('&amp;', '&')
        .replaceAll('&lt;', '<')
        .replaceAll('&gt;', '>')
        .replaceAll('&quot;', '"')
        .trim();

    if (cleanText.isEmpty) return null;

    // Find link positions in clean text
    for (final match in linkMatches) {
      final linkUrl = match.group(1);
      final linkText = match.group(2) ?? '';
      
      if (linkUrl == null || linkText.isEmpty) continue;
      
      final linkTextClean = _stripHtmlTags(linkText)
          .replaceAll('&hellip;', '...')
          .replaceAll('&nbsp;', ' ')
          .replaceAll('&amp;', '&');
      
      final linkIndex = cleanText.indexOf(linkTextClean, lastIndex);
      
      if (linkIndex != -1) {
        // Add text before link
        if (linkIndex > lastIndex) {
          textSpans.add(TextSpan(
            text: cleanText.substring(lastIndex, linkIndex),
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 16,
            ),
          ));
        }
        
        // Add clickable link
        textSpans.add(TextSpan(
          text: linkTextClean,
          style: const TextStyle(
            color: Color(0xFFd4af37),
            fontSize: 16,
            decoration: TextDecoration.underline,
            decorationColor: Color(0xFFd4af37),
          ),
          recognizer: TapGestureRecognizer()
            ..onTap = () async {
              try {
                final Uri url = Uri.parse(linkUrl);
                if (await canLaunchUrl(url)) {
                  await launchUrl(url, mode: LaunchMode.externalApplication);
                }
              } catch (e) {
                // Handle error silently
              }
            },
        ));
        
        lastIndex = linkIndex + linkTextClean.length;
      }
    }
    
    // Add remaining text
    if (lastIndex < cleanText.length) {
      textSpans.add(TextSpan(
        text: cleanText.substring(lastIndex),
        style: const TextStyle(
          color: Colors.white70,
          fontSize: 16,
        ),
      ));
    }

    return RichText(
      text: TextSpan(
        children: textSpans,
        style: const TextStyle(
          height: 1.6,
        ),
      ),
    );
  }

  String _stripHtmlTags(String htmlString) {
    final RegExp exp = RegExp(r'<[^>]*>', multiLine: true, caseSensitive: true);
    return htmlString
        .replaceAll(exp, '')
        .replaceAll('&hellip;', '...')
        .replaceAll('&nbsp;', ' ');
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

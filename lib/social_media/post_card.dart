import 'package:flutter/material.dart';

import '../app_theme.dart';
import 'post.dart';

class PostCard extends StatefulWidget {
  final Post post;
  final VoidCallback onLikeToggle;
  final ValueChanged<String> onAddComment;

  const PostCard({
    super.key,
    required this.post,
    required this.onLikeToggle,
    required this.onAddComment,
  });

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  final _commentController = TextEditingController();

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  void _submitComment() {
    final text = _commentController.text.trim();
    if (text.isEmpty) return;
    widget.onAddComment(text);
    _commentController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final post = widget.post;

    return Card(
      elevation: 1,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: AppColors.borderLight),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // 1. Author Header: Avatar, Username, Timestamp
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 18,
                  backgroundColor: AppColors.softBlush,
                  child: Text(
                    post.username.isNotEmpty
                        ? post.username.substring(0, 1).toUpperCase()
                        : '?',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryMaroon,
                      fontSize: 15,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        post.username,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14.5,
                          color: AppColors.darkCharcoal,
                        ),
                      ),
                      Text(
                        _formatTime(post.createdAt),
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.mutedSlate,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // 2. Post Caption (without repeating username)
          if (post.caption.isNotEmpty)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
              child: Text(
                post.caption,
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.darkCharcoal,
                  height: 1.35,
                ),
              ),
            ),

          // 3. Post Image with consistent aspect ratio (16:9) & sensible cropping
          AspectRatio(
            aspectRatio: 16 / 9,
            child: Image.network(
              post.imageUrl,
              fit: BoxFit.cover,
              width: double.infinity,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Container(
                  color: AppColors.softBlush,
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                        : null,
                    color: AppColors.primaryMaroon,
                  ),
                );
              },
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: AppColors.softBlush,
                  alignment: Alignment.center,
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.broken_image_outlined,
                        size: 40,
                        color: AppColors.primaryMaroon,
                      ),
                      SizedBox(height: 6),
                      Text(
                        'Image unavailable',
                        style: TextStyle(
                          fontSize: 12.5,
                          color: AppColors.mutedSlate,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          // 4. Like / Comment Controls
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(
                    post.isLiked ? Icons.favorite : Icons.favorite_border,
                    color: post.isLiked ? Colors.red : AppColors.darkCharcoal,
                    size: 24,
                  ),
                  tooltip: post.isLiked ? 'Unlike' : 'Like',
                  onPressed: widget.onLikeToggle,
                ),
                Text(
                  '${post.likes}',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: AppColors.darkCharcoal,
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(
                    Icons.chat_bubble_outline_rounded,
                    color: AppColors.darkCharcoal,
                    size: 22,
                  ),
                  tooltip: 'Comments',
                  onPressed: () {},
                ),
                Text(
                  '${post.comments.length}',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: AppColors.darkCharcoal,
                  ),
                ),
              ],
            ),
          ),

          // 5. Existing Comments (clean Instagram-style: username followed by comment text)
          if (post.comments.isNotEmpty) ...[
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 2, 16, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (final comment in post.comments)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 3),
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: '${comment.username} ',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                                color: AppColors.darkCharcoal,
                              ),
                            ),
                            TextSpan(
                              text: comment.text,
                              style: const TextStyle(
                                fontSize: 13,
                                color: AppColors.darkCharcoal,
                                height: 1.3,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],

          const Divider(height: 1, color: AppColors.borderLight),

          // 6. Compact, Accessible, Properly Aligned Comment Input
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 6, 12, 8),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.warmWhite,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppColors.borderLight),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    child: TextField(
                      controller: _commentController,
                      style: const TextStyle(
                        fontSize: 13.5,
                        color: AppColors.darkCharcoal,
                      ),
                      decoration: const InputDecoration(
                        hintText: 'Add a comment...',
                        hintStyle: TextStyle(
                          fontSize: 13,
                          color: AppColors.mutedSlate,
                        ),
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(vertical: 8),
                      ),
                      onSubmitted: (_) => _submitComment(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(
                    Icons.send_rounded,
                    color: AppColors.primaryMaroon,
                    size: 20,
                  ),
                  tooltip: 'Post comment',
                  constraints: const BoxConstraints(
                    minWidth: 44,
                    minHeight: 44,
                  ),
                  onPressed: _submitComment,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatTime(DateTime dateTime) {
    final diff = DateTime.now().difference(dateTime);
    if (diff.inMinutes < 1) return 'Just now';
    if (diff.inHours < 1) return '${diff.inMinutes}m ago';
    if (diff.inDays < 1) return '${diff.inHours}h ago';
    return '${diff.inDays}d ago';
  }
}

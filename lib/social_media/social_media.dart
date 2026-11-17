import 'package:flutter/material.dart';

import '../app_theme.dart';
import '../demo_auth.dart';
import 'create_post_sheet.dart';
import 'post.dart';
import 'post_card.dart';

class SocialMediaScreen extends StatefulWidget {
  const SocialMediaScreen({super.key});

  @override
  State<SocialMediaScreen> createState() => _SocialMediaScreenState();
}

class _SocialMediaScreenState extends State<SocialMediaScreen> {
  late final List<Post> _posts;

  @override
  void initState() {
    super.initState();
    _posts = List<Post>.from(Post.samplePosts);
  }

  void _addPost(String caption, String imageUrl) {
    final currentUsername = DemoAuth.currentUser ?? 'Student';
    setState(() {
      _posts.insert(
        0,
        Post(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          username: currentUsername,
          imageUrl: imageUrl,
          caption: caption,
          likes: 0,
          isLiked: false,
          comments: [],
        ),
      );
    });
  }

  void _toggleLike(int index) {
    setState(() {
      _posts[index].toggleLike();
    });
  }

  void _addComment(int index, String comment) {
    final currentUsername = DemoAuth.currentUser ?? 'Student';
    setState(() {
      _posts[index].addComment(currentUsername, comment);
    });
  }

  void _openCreatePostSheet() {
    CreatePostSheet.show(context, onPostCreated: _addPost);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Social Media Feed'), centerTitle: true),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: _posts.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.dynamic_feed_outlined,
                        size: 64,
                        color: AppColors.mutedSlate,
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'No posts yet.',
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.darkCharcoal,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 6),
                      TextButton.icon(
                        onPressed: _openCreatePostSheet,
                        icon: const Icon(Icons.add),
                        label: const Text('Create the first post'),
                        style: TextButton.styleFrom(
                          foregroundColor: AppColors.primaryMaroon,
                        ),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 100),
                  itemCount: _posts.length,
                  itemBuilder: (context, index) {
                    final post = _posts[index];
                    return PostCard(
                      key: ValueKey(post.id),
                      post: post,
                      onLikeToggle: () => _toggleLike(index),
                      onAddComment: (comment) => _addComment(index, comment),
                    );
                  },
                ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openCreatePostSheet,
        backgroundColor: AppColors.primaryMaroon,
        foregroundColor: Colors.white,
        tooltip: 'Create Post',
        child: const Icon(Icons.add),
      ),
    );
  }
}

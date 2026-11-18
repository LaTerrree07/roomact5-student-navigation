import 'package:flutter/material.dart';

import '../app_theme.dart';
import '../demo_auth.dart';
import 'create_post_sheet.dart';
import 'post.dart';
import 'post_card.dart';

class SocialMediaPage extends StatefulWidget {
  final String username;
  final String? currentUsername;

  const SocialMediaPage({
    super.key,
    this.username = 'Student',
    this.currentUsername,
  });

  @override
  State<SocialMediaPage> createState() => _SocialMediaPageState();
}

typedef SocialMediaScreen = SocialMediaPage;

class _SocialMediaPageState extends State<SocialMediaPage> {
  late final List<Post> _posts;

  String get _effectiveUsername {
    if (widget.currentUsername != null &&
        widget.currentUsername!.trim().isNotEmpty) {
      return widget.currentUsername!.trim();
    }
    if (widget.username.isNotEmpty && widget.username != 'Student') {
      return widget.username;
    }
    final name = DemoAuth.currentUsername ?? DemoAuth.currentUser;
    if (name != null && name.trim().isNotEmpty) {
      return name.trim();
    }
    return widget.username;
  }

  @override
  void initState() {
    super.initState();
    _posts = List<Post>.from(Post.samplePosts);
  }

  void _toggleLike(int index) {
    setState(() {
      _posts[index].toggleLike();
    });
  }

  void _addComment(int index, String comment) {
    final currentUsername = _effectiveUsername;
    setState(() {
      _posts[index].addComment(currentUsername, comment);
    });
  }

  Future<void> _openCreatePostSheet() async {
    final currentUsername = _effectiveUsername;
    final Post? newPost = await showModalBottomSheet<Post>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return CreatePostSheet(username: currentUsername);
      },
    );

    if (!mounted || newPost == null) {
      return;
    }

    setState(() {
      _posts.insert(0, newPost);
    });
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
                      key: ObjectKey(post),
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

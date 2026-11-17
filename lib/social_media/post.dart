class Comment {
  final String username;
  final String text;
  final DateTime createdAt;

  Comment({required this.username, required this.text, DateTime? createdAt})
    : createdAt = createdAt ?? DateTime.now();
}

class Post {
  final String id;
  final String username;
  final String imageUrl;
  final String caption;
  int likes;
  bool isLiked;
  final List<Comment> comments;
  final DateTime createdAt;

  Post({
    required this.id,
    required this.username,
    required this.imageUrl,
    required this.caption,
    this.likes = 0,
    this.isLiked = false,
    List<Comment>? comments,
    DateTime? createdAt,
  }) : comments = comments ?? [],
       createdAt = createdAt ?? DateTime.now();

  void toggleLike() {
    if (isLiked) {
      isLiked = false;
      likes = (likes > 0) ? likes - 1 : 0;
    } else {
      isLiked = true;
      likes++;
    }
  }

  bool addComment(String username, String text) {
    final trimmed = text.trim();
    if (trimmed.isNotEmpty) {
      comments.add(Comment(username: username, text: trimmed));
      return true;
    }
    return false;
  }

  static List<Post> get samplePosts => [
    Post(
      id: '1',
      username: 'JohnDoe',
      imageUrl: 'https://picsum.photos/id/20/600/400',
      caption: 'Enjoying the sunny weather!',
      likes: 0,
      isLiked: false,
      comments: [],
    ),
    Post(
      id: '2',
      username: 'JaneSmith',
      imageUrl: 'https://picsum.photos/id/24/600/400',
      caption: 'Just finished a great book!',
      likes: 0,
      isLiked: false,
      comments: [],
    ),
  ];
}

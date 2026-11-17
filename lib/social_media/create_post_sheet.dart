import 'package:flutter/material.dart';

import '../app_theme.dart';
import '../demo_auth.dart';

class CreatePostSheet extends StatefulWidget {
  final void Function(String caption, String imageUrl) onPostCreated;

  const CreatePostSheet({super.key, required this.onPostCreated});

  static Future<void> show(
    BuildContext context, {
    required void Function(String caption, String imageUrl) onPostCreated,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => CreatePostSheet(onPostCreated: onPostCreated),
    );
  }

  @override
  State<CreatePostSheet> createState() => _CreatePostSheetState();
}

class _CreatePostSheetState extends State<CreatePostSheet> {
  final _formKey = GlobalKey<FormState>();
  final _captionController = TextEditingController();
  final _imageUrlController = TextEditingController();

  @override
  void dispose() {
    _captionController.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    final caption = _captionController.text.trim();
    final imageUrl = _imageUrlController.text.trim();

    widget.onPostCreated(caption, imageUrl);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    final currentUser = DemoAuth.currentUser ?? 'Student';

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      padding: EdgeInsets.fromLTRB(24, 16, 24, 24 + bottomInset),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.borderSubtle,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  const CircleAvatar(
                    radius: 18,
                    backgroundColor: AppColors.softBlush,
                    child: Icon(
                      Icons.person,
                      size: 20,
                      color: AppColors.primaryMaroon,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Create New Post',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.darkCharcoal,
                          ),
                        ),
                        Text(
                          'Posting as @$currentUser',
                          style: const TextStyle(
                            fontSize: 12.5,
                            color: AppColors.mutedSlate,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              TextFormField(
                key: const Key('post_image_url_field'),
                controller: _imageUrlController,
                style: const TextStyle(color: AppColors.darkCharcoal),
                decoration: InputDecoration(
                  labelText: 'Image URL',
                  hintText: 'https://picsum.photos/id/40/600/400',
                  prefixIcon: const Icon(
                    Icons.image_outlined,
                    color: AppColors.primaryMaroon,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: AppColors.borderSubtle),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: AppColors.primaryMaroon,
                      width: 2,
                    ),
                  ),
                  filled: true,
                  fillColor: AppColors.warmWhite,
                ),
                validator: (value) {
                  final trimmed = value?.trim() ?? '';
                  if (trimmed.isEmpty) {
                    return 'Please enter an image URL.';
                  }
                  final uri = Uri.tryParse(trimmed);
                  final isHttp =
                      uri != null &&
                      (uri.scheme == 'http' || uri.scheme == 'https') &&
                      uri.hasAuthority;
                  if (!isHttp) {
                    return 'Please enter a valid HTTP/HTTPS image URL.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                key: const Key('post_caption_field'),
                controller: _captionController,
                maxLines: 3,
                style: const TextStyle(color: AppColors.darkCharcoal),
                decoration: InputDecoration(
                  labelText: 'Caption',
                  hintText: "What's on your mind?",
                  alignLabelWithHint: true,
                  prefixIcon: const Padding(
                    padding: EdgeInsets.only(bottom: 40),
                    child: Icon(
                      Icons.edit_note,
                      color: AppColors.primaryMaroon,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: AppColors.borderSubtle),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: AppColors.primaryMaroon,
                      width: 2,
                    ),
                  ),
                  filled: true,
                  fillColor: AppColors.warmWhite,
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a caption.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: _submit,
                icon: const Icon(Icons.send_rounded, size: 18),
                label: const Text(
                  'Share Post',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryMaroon,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

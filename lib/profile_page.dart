import 'package:flutter/material.dart';

import 'app_theme.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Profile')),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: ListView(
            padding: const EdgeInsets.fromLTRB(24, 28, 24, 32),
            children: [
              Center(
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.softBlush, width: 3),
                  ),
                  child: const CircleAvatar(
                    radius: 46,
                    backgroundColor: AppColors.primaryMaroon,
                    foregroundColor: Colors.white,
                    child: Text(
                      'EL',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Earth Justin Lim',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.darkCharcoal,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'BS Information Technology',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: AppColors.mutedSlate,
                ),
              ),
              const SizedBox(height: 28),
              const Text(
                'Student Details',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primaryMaroon,
                ),
              ),
              const SizedBox(height: 10),
              Card(
                elevation: 1,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: const BorderSide(color: AppColors.borderLight),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: Column(
                    children: const [
                      ListTile(
                        leading: CircleAvatar(
                          backgroundColor: AppColors.softBlush,
                          child: Icon(
                            Icons.badge_outlined,
                            color: AppColors.primaryMaroon,
                          ),
                        ),
                        title: Text(
                          'Student Number',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: AppColors.darkCharcoal,
                          ),
                        ),
                        subtitle: Text(
                          '553550',
                          style: TextStyle(color: AppColors.mutedSlate),
                        ),
                      ),
                      Divider(
                        height: 1,
                        indent: 16,
                        endIndent: 16,
                        color: AppColors.borderLight,
                      ),
                      ListTile(
                        leading: CircleAvatar(
                          backgroundColor: AppColors.softBlush,
                          child: Icon(
                            Icons.school_outlined,
                            color: AppColors.primaryMaroon,
                          ),
                        ),
                        title: Text(
                          'Year / Section',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: AppColors.darkCharcoal,
                          ),
                        ),
                        subtitle: Text(
                          '3rd Year — PS303',
                          style: TextStyle(color: AppColors.mutedSlate),
                        ),
                      ),
                      Divider(
                        height: 1,
                        indent: 16,
                        endIndent: 16,
                        color: AppColors.borderLight,
                      ),
                      ListTile(
                        leading: CircleAvatar(
                          backgroundColor: AppColors.softBlush,
                          child: Icon(
                            Icons.menu_book_outlined,
                            color: AppColors.primaryMaroon,
                          ),
                        ),
                        title: Text(
                          'Subject',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: AppColors.darkCharcoal,
                          ),
                        ),
                        subtitle: Text(
                          'CCE106L',
                          style: TextStyle(color: AppColors.mutedSlate),
                        ),
                      ),
                      Divider(
                        height: 1,
                        indent: 16,
                        endIndent: 16,
                        color: AppColors.borderLight,
                      ),
                      ListTile(
                        leading: CircleAvatar(
                          backgroundColor: AppColors.softBlush,
                          child: Icon(
                            Icons.mail_outline,
                            color: AppColors.primaryMaroon,
                          ),
                        ),
                        title: Text(
                          'Email',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: AppColors.darkCharcoal,
                          ),
                        ),
                        subtitle: Text(
                          'e.lim.553550@umindanao.edu.ph',
                          style: TextStyle(color: AppColors.mutedSlate),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 28),
              const Text(
                'About Me',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primaryMaroon,
                ),
              ),
              const SizedBox(height: 10),
              Card(
                elevation: 0,
                color: AppColors.softBlush.withValues(alpha: 0.6),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: const BorderSide(color: AppColors.softBlushBorder),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    'I am a third-year Bachelor of Science in Information Technology student. '
                    'I enjoy learning about technology and improving my programming skills. '
                    'My goal is to develop useful applications that can help people solve everyday problems.',
                    style: TextStyle(
                      fontSize: 14.5,
                      height: 1.55,
                      color: AppColors.darkCharcoal,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 28),
              const Text(
                'Hobbies and Interests',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primaryMaroon,
                ),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  Chip(
                    avatar: const Icon(
                      Icons.movie_outlined,
                      size: 18,
                      color: AppColors.primaryMaroon,
                    ),
                    label: const Text('Watching movies'),
                    backgroundColor: Colors.white,
                    side: const BorderSide(color: AppColors.borderSubtle),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  Chip(
                    avatar: const Icon(
                      Icons.sports_tennis_outlined,
                      size: 18,
                      color: AppColors.primaryMaroon,
                    ),
                    label: const Text('Playing badminton'),
                    backgroundColor: Colors.white,
                    side: const BorderSide(color: AppColors.borderSubtle),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  Chip(
                    avatar: const Icon(
                      Icons.headphones_outlined,
                      size: 18,
                      color: AppColors.primaryMaroon,
                    ),
                    label: const Text('Listening to music'),
                    backgroundColor: Colors.white,
                    side: const BorderSide(color: AppColors.borderSubtle),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

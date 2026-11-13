import 'package:flutter/material.dart';

import 'app_theme.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.home_rounded, color: Colors.white, size: 24),
            SizedBox(width: 10),
            Text('Home'),
          ],
        ),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 500),
              child: Container(
                padding: const EdgeInsets.all(24.0),
                decoration: BoxDecoration(
                  color: AppColors.cardWhite,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.borderLight),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.04),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Center(
                      child: Container(
                        width: 72,
                        height: 72,
                        decoration: const BoxDecoration(
                          color: AppColors.softBlush,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.home,
                          size: 42,
                          color: AppColors.primaryMaroon,
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),
                    const Text(
                      'Welcome, Student!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryMaroon,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Use the navigation bar below to explore the app.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14.5,
                        color: AppColors.darkCharcoal,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.warmWhite,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: AppColors.borderLight),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.check_circle_outline_rounded,
                            size: 18,
                            color: AppColors.primaryMaroon,
                          ),
                          SizedBox(width: 8),
                          Flexible(
                            child: Text(
                              'Active Session · Student Portal',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: AppColors.primaryMaroon,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'Application Overview',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primaryMaroon,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Card(
                      elevation: 0,
                      color: AppColors.warmWhite,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: const BorderSide(color: AppColors.borderLight),
                      ),
                      child: Column(
                        children: const [
                          ListTile(
                            leading: CircleAvatar(
                              radius: 18,
                              backgroundColor: AppColors.softBlush,
                              child: Icon(
                                Icons.calculate,
                                size: 20,
                                color: AppColors.primaryMaroon,
                              ),
                            ),
                            title: Text(
                              'Calculator',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14.5,
                                color: AppColors.darkCharcoal,
                              ),
                            ),
                            subtitle: Text(
                              'Perform basic arithmetic operations.',
                              style: TextStyle(
                                fontSize: 12.5,
                                color: AppColors.mutedSlate,
                              ),
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
                              radius: 18,
                              backgroundColor: AppColors.softBlush,
                              child: Icon(
                                Icons.person,
                                size: 20,
                                color: AppColors.primaryMaroon,
                              ),
                            ),
                            title: Text(
                              'Profile',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14.5,
                                color: AppColors.darkCharcoal,
                              ),
                            ),
                            subtitle: Text(
                              'View your student information.',
                              style: TextStyle(
                                fontSize: 12.5,
                                color: AppColors.mutedSlate,
                              ),
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
                              radius: 18,
                              backgroundColor: AppColors.softBlush,
                              child: Icon(
                                Icons.share,
                                size: 20,
                                color: AppColors.primaryMaroon,
                              ),
                            ),
                            title: Text(
                              'Social Media',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14.5,
                                color: AppColors.darkCharcoal,
                              ),
                            ),
                            subtitle: Text(
                              'View your sample social accounts.',
                              style: TextStyle(
                                fontSize: 12.5,
                                color: AppColors.mutedSlate,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Divider(height: 1, color: AppColors.borderLight),
                    const SizedBox(height: 14),
                    const Text(
                      'Earth Justin Lim · CCE106L (3447)',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.mutedSlate,
                        fontSize: 12.5,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

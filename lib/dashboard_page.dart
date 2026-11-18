import 'package:flutter/material.dart';

import 'app_theme.dart';
import 'demo_auth.dart';
import 'login_screen.dart';

class DashboardPage extends StatelessWidget {
  final String username;
  final String? currentUsername;
  final ValueChanged<int>? onNavigateTab;

  const DashboardPage({
    super.key,
    this.username = 'Student',
    this.currentUsername,
    this.onNavigateTab,
  });

  String get _effectiveUsername {
    if (currentUsername != null && currentUsername!.trim().isNotEmpty) {
      return currentUsername!.trim();
    }
    if (username.isNotEmpty && username != 'Student') {
      return username;
    }
    final name = DemoAuth.currentUsername ?? DemoAuth.currentUser;
    if (name != null && name.trim().isNotEmpty) {
      return name.trim();
    }
    return username;
  }

  void logout(BuildContext context) {
    DemoAuth.logout();
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const LoginScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = _effectiveUsername;

    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.dashboard_rounded, color: Colors.white, size: 24),
            SizedBox(width: 10),
            Text('Dashboard'),
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
                          Icons.dashboard_rounded,
                          size: 40,
                          color: AppColors.primaryMaroon,
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),
                    Text(
                      'Welcome, $user!',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryMaroon,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Explore your student application using the navigation bar below.',
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.check_circle_outline_rounded,
                            size: 18,
                            color: AppColors.primaryMaroon,
                          ),
                          const SizedBox(width: 8),
                          Flexible(
                            child: Text(
                              'Active Session · @$user',
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
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
                        children: [
                          ListTile(
                            leading: const CircleAvatar(
                              radius: 18,
                              backgroundColor: AppColors.softBlush,
                              child: Icon(
                                Icons.calculate,
                                size: 20,
                                color: AppColors.primaryMaroon,
                              ),
                            ),
                            title: const Text(
                              'Calculator',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14.5,
                                color: AppColors.darkCharcoal,
                              ),
                            ),
                            subtitle: const Text(
                              'Perform basic arithmetic operations.',
                              style: TextStyle(
                                fontSize: 12.5,
                                color: AppColors.mutedSlate,
                              ),
                            ),
                            trailing: const Icon(
                              Icons.chevron_right,
                              size: 20,
                              color: AppColors.mutedSlate,
                            ),
                            onTap: onNavigateTab != null
                                ? () => onNavigateTab!(1)
                                : null,
                          ),
                          const Divider(
                            height: 1,
                            indent: 16,
                            endIndent: 16,
                            color: AppColors.borderLight,
                          ),
                          ListTile(
                            leading: const CircleAvatar(
                              radius: 18,
                              backgroundColor: AppColors.softBlush,
                              child: Icon(
                                Icons.people,
                                size: 20,
                                color: AppColors.primaryMaroon,
                              ),
                            ),
                            title: const Text(
                              'Social',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14.5,
                                color: AppColors.darkCharcoal,
                              ),
                            ),
                            subtitle: const Text(
                              'Create posts, like posts, and add comments.',
                              style: TextStyle(
                                fontSize: 12.5,
                                color: AppColors.mutedSlate,
                              ),
                            ),
                            trailing: const Icon(
                              Icons.chevron_right,
                              size: 20,
                              color: AppColors.mutedSlate,
                            ),
                            onTap: onNavigateTab != null
                                ? () => onNavigateTab!(2)
                                : null,
                          ),
                          const Divider(
                            height: 1,
                            indent: 16,
                            endIndent: 16,
                            color: AppColors.borderLight,
                          ),
                          ListTile(
                            leading: const CircleAvatar(
                              radius: 18,
                              backgroundColor: AppColors.softBlush,
                              child: Icon(
                                Icons.person,
                                size: 20,
                                color: AppColors.primaryMaroon,
                              ),
                            ),
                            title: const Text(
                              'Profile',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14.5,
                                color: AppColors.darkCharcoal,
                              ),
                            ),
                            subtitle: const Text(
                              'View student information and log out.',
                              style: TextStyle(
                                fontSize: 12.5,
                                color: AppColors.mutedSlate,
                              ),
                            ),
                            trailing: const Icon(
                              Icons.chevron_right,
                              size: 20,
                              color: AppColors.mutedSlate,
                            ),
                            onTap: onNavigateTab != null
                                ? () => onNavigateTab!(3)
                                : null,
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

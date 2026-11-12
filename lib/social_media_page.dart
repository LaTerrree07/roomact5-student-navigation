import 'package:flutter/material.dart';

class SocialMediaPage extends StatelessWidget {
  const SocialMediaPage({super.key});

  void showAccount(BuildContext context, String account) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Selected account: $account')));
  }

  @override
  Widget build(BuildContext context) {
    const deepTeal = Color(0xFF0F766E);
    const softMint = Color(0xFFCCFBF1);
    const darkCharcoal = Color(0xFF1F2937);
    const mutedSlate = Color(0xFF64748B);

    final accounts = [
      (
        platform: 'Facebook',
        username: '@la.terrree',
        icon: Icons.facebook,
        iconColor: const Color(0xFF1877F2),
        badgeBg: const Color(0xFFE7F3FF),
      ),
      (
        platform: 'Instagram',
        username: '@la.terrree',
        icon: Icons.camera_alt,
        iconColor: const Color(0xFFE4405F),
        badgeBg: const Color(0xFFFDE8ED),
      ),
      (
        platform: 'Threads',
        username: '@la.terrree',
        icon: Icons.alternate_email,
        iconColor: const Color(0xFF111827),
        badgeBg: const Color(0xFFF3F4F6),
      ),
      (
        platform: 'GitHub',
        username: '@LaTerrree07',
        icon: Icons.code,
        iconColor: const Color(0xFF24292F),
        badgeBg: const Color(0xFFF1F5F9),
      ),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Social Media')),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 540),
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            children: [
              Center(
                child: Container(
                  width: 64,
                  height: 64,
                  decoration: const BoxDecoration(
                    color: softMint,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.share, size: 34, color: deepTeal),
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Connect With Me',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: darkCharcoal,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Tap an account to display its username.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 13.5, color: mutedSlate),
              ),
              const SizedBox(height: 16),
              for (final acc in accounts) ...[
                Card(
                  elevation: 1,
                  margin: EdgeInsets.zero,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                    side: const BorderSide(color: Color(0xFFE2E8F0)),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 4,
                    ),
                    leading: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: acc.badgeBg,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(acc.icon, color: acc.iconColor, size: 24),
                    ),
                    title: Text(
                      acc.platform,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                        color: darkCharcoal,
                      ),
                    ),
                    subtitle: Text(
                      acc.username,
                      style: const TextStyle(
                        fontSize: 13.5,
                        color: mutedSlate,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    trailing: const Icon(
                      Icons.chevron_right,
                      color: Color(0xFF94A3B8),
                    ),
                    onTap: () => showAccount(
                      context,
                      '${acc.platform}: ${acc.username}',
                    ),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

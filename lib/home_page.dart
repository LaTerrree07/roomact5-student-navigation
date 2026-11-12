import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    const deepTeal = Color(0xFF0F766E);
    const softMint = Color(0xFFCCFBF1);
    const darkCharcoal = Color(0xFF1F2937);
    const mutedSlate = Color(0xFF64748B);

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
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
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
                          color: softMint,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.home,
                          size: 42,
                          color: deepTeal,
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
                        color: deepTeal,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Use the navigation bar below to explore the app.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14.5,
                        color: darkCharcoal,
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
                        color: const Color(0xFFF8FAFC),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: const Color(0xFFE2E8F0)),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.check_circle_outline_rounded,
                            size: 18,
                            color: deepTeal,
                          ),
                          SizedBox(width: 8),
                          Flexible(
                            child: Text(
                              'Active Session · Student Portal',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: deepTeal,
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
                        color: deepTeal,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Card(
                      elevation: 0,
                      color: const Color(0xFFF8FAFC),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: const BorderSide(color: Color(0xFFE2E8F0)),
                      ),
                      child: Column(
                        children: const [
                          ListTile(
                            leading: CircleAvatar(
                              radius: 18,
                              backgroundColor: softMint,
                              child: Icon(
                                Icons.calculate,
                                size: 20,
                                color: deepTeal,
                              ),
                            ),
                            title: Text(
                              'Calculator',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14.5,
                              ),
                            ),
                            subtitle: Text(
                              'Perform basic arithmetic operations.',
                              style: TextStyle(fontSize: 12.5),
                            ),
                          ),
                          Divider(height: 1, indent: 16, endIndent: 16),
                          ListTile(
                            leading: CircleAvatar(
                              radius: 18,
                              backgroundColor: softMint,
                              child: Icon(
                                Icons.person,
                                size: 20,
                                color: deepTeal,
                              ),
                            ),
                            title: Text(
                              'Profile',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14.5,
                              ),
                            ),
                            subtitle: Text(
                              'View your student information.',
                              style: TextStyle(fontSize: 12.5),
                            ),
                          ),
                          Divider(height: 1, indent: 16, endIndent: 16),
                          ListTile(
                            leading: CircleAvatar(
                              radius: 18,
                              backgroundColor: softMint,
                              child: Icon(
                                Icons.share,
                                size: 20,
                                color: deepTeal,
                              ),
                            ),
                            title: Text(
                              'Social Media',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14.5,
                              ),
                            ),
                            subtitle: Text(
                              'View your sample social accounts.',
                              style: TextStyle(fontSize: 12.5),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Divider(height: 1, color: Color(0xFFE2E8F0)),
                    const SizedBox(height: 14),
                    const Text(
                      'Earth Justin Lim · CCE106L (3447)',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: mutedSlate,
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

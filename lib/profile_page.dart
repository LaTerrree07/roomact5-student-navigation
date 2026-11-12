import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    const deepTeal = Color(0xFF0F766E);
    const softMint = Color(0xFFCCFBF1);
    const darkCharcoal = Color(0xFF1F2937);
    const mutedSlate = Color(0xFF64748B);

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
                    border: Border.all(color: softMint, width: 3),
                  ),
                  child: const CircleAvatar(
                    radius: 46,
                    backgroundColor: deepTeal,
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
                  color: darkCharcoal,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'BS Information Technology',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: mutedSlate,
                ),
              ),
              const SizedBox(height: 28),
              const Text(
                'Student Details',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: deepTeal,
                ),
              ),
              const SizedBox(height: 10),
              Card(
                elevation: 1,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: const BorderSide(color: Color(0xFFE2E8F0)),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: Column(
                    children: const [
                      ListTile(
                        leading: CircleAvatar(
                          backgroundColor: softMint,
                          child: Icon(Icons.badge_outlined, color: deepTeal),
                        ),
                        title: Text(
                          'Student Number',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        subtitle: Text('553550'),
                      ),
                      Divider(height: 1, indent: 16, endIndent: 16),
                      ListTile(
                        leading: CircleAvatar(
                          backgroundColor: softMint,
                          child: Icon(Icons.school_outlined, color: deepTeal),
                        ),
                        title: Text(
                          'Year / Section',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        subtitle: Text('3rd Year — PS303'),
                      ),
                      Divider(height: 1, indent: 16, endIndent: 16),
                      ListTile(
                        leading: CircleAvatar(
                          backgroundColor: softMint,
                          child: Icon(
                            Icons.menu_book_outlined,
                            color: deepTeal,
                          ),
                        ),
                        title: Text(
                          'Subject',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        subtitle: Text('CCE106L'),
                      ),
                      Divider(height: 1, indent: 16, endIndent: 16),
                      ListTile(
                        leading: CircleAvatar(
                          backgroundColor: softMint,
                          child: Icon(Icons.mail_outline, color: deepTeal),
                        ),
                        title: Text(
                          'Email',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        subtitle: Text('e.lim.553550@umindanao.edu.ph'),
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
                  color: deepTeal,
                ),
              ),
              const SizedBox(height: 10),
              Card(
                elevation: 0,
                color: softMint.withAlpha(80),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: const BorderSide(color: Color(0xFF99F6E4)),
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
                      color: Color(0xFF334155),
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
                  color: deepTeal,
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
                      color: deepTeal,
                    ),
                    label: const Text('Watching movies'),
                    backgroundColor: Colors.white,
                    side: const BorderSide(color: Color(0xFFCBD5E1)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  Chip(
                    avatar: const Icon(
                      Icons.sports_tennis_outlined,
                      size: 18,
                      color: deepTeal,
                    ),
                    label: const Text('Playing badminton'),
                    backgroundColor: Colors.white,
                    side: const BorderSide(color: Color(0xFFCBD5E1)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  Chip(
                    avatar: const Icon(
                      Icons.headphones_outlined,
                      size: 18,
                      color: deepTeal,
                    ),
                    label: const Text('Listening to music'),
                    backgroundColor: Colors.white,
                    side: const BorderSide(color: Color(0xFFCBD5E1)),
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

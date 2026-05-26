import 'package:flutter/material.dart';

import 'settingsScreen.dart';
import 'loginScreen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return LayoutBuilder(builder: (context, constraints) {
      final isDesktop = constraints.maxWidth >= 900;
      final isTablet =
          constraints.maxWidth >= 600 && constraints.maxWidth < 900;
      final isMobile = constraints.maxWidth < 600;

      return Scaffold(
        key: _scaffoldKey,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        drawer: isDesktop ? null : _buildDrawer(context),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ================= HEADER =================
              _buildResponsiveHeader(context, isDesktop, isMobile),

              const SizedBox(height: 24),

              // ================= CONTENT =================
              Padding(
                padding: EdgeInsets.symmetric(horizontal: isMobile ? 16 : 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        border: Border.all(
                            color:
                                isDark ? Colors.grey[800]! : Colors.grey[300]!),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Daily Streak',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600)),
                              Icon(Icons.local_fire_department,
                                  color: Colors.orange),
                            ],
                          ),
                          SizedBox(height: 16),
                          Text('0 Day Streak',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.orange)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    Column(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: _statCard(context, 'Best Score', '0',
                              Icons.emoji_events_outlined, Colors.amber),
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          child: _statCard(context, 'Signs Learned', '0',
                              Icons.school_outlined, Colors.blue),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                    const Text('Practice Modes',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 16),
                    // Vertical list for practice modes
                    Column(
                      children: [
                        _modeCard(
                            context, 'Dictionary', Icons.menu_book_outlined),
                        _modeCard(
                            context, 'Freedom Mode', Icons.back_hand_outlined),
                        _modeCard(
                            context, 'Practice Mode', Icons.school_outlined),
                        _modeCard(context, 'Test Mode', Icons.quiz_outlined),
                        _modeCard(
                            context, 'Speed Challenge', Icons.timer_outlined),
                        _modeCard(context, 'Word Spelling', Icons.spellcheck),
                        _modeCard(
                            context, 'Daily Challenge', Icons.calendar_today),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 80),

              // ================= FOOTER =================
              _buildResponsiveFooter(context, isMobile, isTablet),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.purple.shade50,
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(Icons.sign_language, size: 48, color: Colors.purple),
                SizedBox(height: 12),
                Text('SASL App',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
              ],
            ),
          ),
          ListTile(
              leading: const Icon(Icons.menu_book),
              title: const Text('Lessons'),
              onTap: () {}),
          ListTile(
              leading: const Icon(Icons.library_books),
              title: const Text('Dictionary'),
              onTap: () {}),
          ListTile(
              leading: const Icon(Icons.sports_esports),
              title: const Text('Practice'),
              onTap: () {}),
          ListTile(
              leading: const Icon(Icons.forum),
              title: const Text('Community'),
              onTap: () {}),
          ListTile(
              leading: const Icon(Icons.info),
              title: const Text('About'),
              onTap: () {}),
          const Divider(),
          ListTile(
              leading: const Icon(Icons.login),
              title: const Text('Sign in'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen()));
              }),
          ListTile(
              leading: const Icon(Icons.person_add),
              title: const Text('Register'),
              onTap: () {}),
        ],
      ),
    );
  }

  Widget _buildResponsiveHeader(
      BuildContext context, bool isDesktop, bool isMobile) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      width: double.infinity,
      padding:
          EdgeInsets.symmetric(horizontal: isMobile ? 16 : 24, vertical: 18),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        border: Border(
          bottom: BorderSide(
            color: isDark ? Colors.grey[800]! : Colors.grey[300]!,
          ),
        ),
      ),
      child: Row(
        children: [
          if (!isDesktop)
            IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                _scaffoldKey.currentState?.openDrawer();
              },
            ),
          if (!isDesktop) const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.purple.shade50,
              borderRadius: BorderRadius.circular(12),
            ),
            child:
                const Icon(Icons.sign_language, size: 28, color: Colors.purple),
          ),
          const SizedBox(width: 12),
          const Text('SASL',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(width: 24),
          if (isDesktop)
            const Expanded(
              child: Wrap(
                spacing: 24,
                children: [
                  Text('Lessons',
                      style: TextStyle(fontWeight: FontWeight.w500)),
                  Text('Dictionary',
                      style: TextStyle(fontWeight: FontWeight.w500)),
                  Text('Practice',
                      style: TextStyle(fontWeight: FontWeight.w500)),
                  Text('Community',
                      style: TextStyle(fontWeight: FontWeight.w500)),
                  Text('About', style: TextStyle(fontWeight: FontWeight.w500)),
                ],
              ),
            ),
          if (!isDesktop) const Spacer(),
          if (isDesktop)
            TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()));
                },
                child: const Text('Sign in')),
          if (isDesktop) const SizedBox(width: 8),
          if (isDesktop)
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                backgroundColor: Colors.purple,
                foregroundColor: Colors.white,
              ),
              child: const Text('Register'),
            ),
          const SizedBox(width: 16),
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.blue),
            tooltip: 'Settings',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsScreen()),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _statCard(BuildContext context, String title, String value,
      IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
        color: Theme.of(context).cardColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(height: 12),
          Text(value,
              style:
                  const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          Text(title, style: TextStyle(color: Colors.grey.shade600)),
        ],
      ),
    );
  }

  Widget _modeCard(BuildContext context, String title, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: ListTile(
          leading: Icon(icon, color: Colors.purple),
          title:
              Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
          trailing: const Icon(Icons.arrow_forward_ios, size: 14),
        ),
      ),
    );
  }

  // Hàm Footer responsive
  Widget _buildResponsiveFooter(
      BuildContext context, bool isMobile, bool isTablet) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      padding:
          EdgeInsets.symmetric(horizontal: isMobile ? 24 : 40, vertical: 40),
      color: isDark ? Colors.grey[900] : Colors.grey[50],
      child: isMobile
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildFooterBrand(isDark),
                const SizedBox(height: 40),
                _footerColumn(
                    "Learn",
                    [
                      "Basic Signs",
                      "Alphabet",
                      "Numbers",
                      "Greetings",
                      "Daily Phrases",
                      "Quizzes"
                    ],
                    isDark),
                const SizedBox(height: 32),
                _footerColumn(
                    "Resources",
                    [
                      "Video Library",
                      "Articles",
                      "Sign Language Dictionary",
                      "FAQ",
                      "Support"
                    ],
                    isDark),
                const SizedBox(height: 32),
                _footerColumn(
                    "About Us",
                    [
                      "Mission",
                      "Team",
                      "Contact",
                      "Privacy Policy",
                      "Terms of Service"
                    ],
                    isDark),
              ],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 2, child: _buildFooterBrand(isDark)),
                Expanded(
                    child: _footerColumn(
                        "Learn",
                        [
                          "Basic Signs",
                          "Alphabet",
                          "Numbers",
                          "Greetings",
                          "Daily Phrases",
                          "Quizzes"
                        ],
                        isDark)),
                Expanded(
                    child: _footerColumn(
                        "Resources",
                        [
                          "Video Library",
                          "Articles",
                          "Dictionary",
                          "FAQ",
                          "Support"
                        ],
                        isDark)),
                Expanded(
                    child: _footerColumn(
                        "About Us",
                        [
                          "Mission",
                          "Team",
                          "Contact",
                          "Privacy Policy",
                          "Terms of Service"
                        ],
                        isDark)),
              ],
            ),
    );
  }

  Widget _buildFooterBrand(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.sign_language, size: 32, color: Colors.purple),
            const SizedBox(width: 8),
            Text('SASL App',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : Colors.black87)),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          'Empowering communication through accessible sign language education.',
          style: TextStyle(
              color: isDark ? Colors.grey[400] : Colors.black54, height: 1.5),
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            _socialIcon(Icons.facebook, isDark),
            const SizedBox(width: 16),
            _socialIcon(Icons.camera_alt_outlined, isDark),
            const SizedBox(width: 16),
            _socialIcon(Icons.play_circle_outline, isDark),
            const SizedBox(width: 16),
            _socialIcon(Icons.link, isDark),
          ],
        ),
      ],
    );
  }

  Widget _socialIcon(IconData icon, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isDark ? Colors.grey[800] : Colors.grey[200],
      ),
      child:
          Icon(icon, size: 20, color: isDark ? Colors.white70 : Colors.black87),
    );
  }

  Widget _footerColumn(String title, List<String> items, bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: isDark ? Colors.white : Colors.black87)),
        const SizedBox(height: 20),
        ...items.map((e) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Text(e,
                  style: TextStyle(
                      color: isDark ? Colors.grey[400] : Colors.black54,
                      fontSize: 14)),
            )),
      ],
    );
  }
}

import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  // 👉 DATA GIẢ (frontend only)
  String userName = "User";
  int bestScore = 0;
  int streak = 0;
  int learnedSigns = 0;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Welcome Back',
                style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).textTheme.bodySmall?.color)),
            Text(userName,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).textTheme.bodyLarge?.color)),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (_) => const SettingsScreen())),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// 🔥 STREAK
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                border: Border.all(
                    color: isDark ? Colors.grey[800]! : Colors.grey[300]!),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text('Daily Streak',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600)),
                      Icon(Icons.local_fire_department, color: Colors.orange),
                    ],
                  ),
                  const SizedBox(height: 16),
                  StreakIndicator(streakDays: streak),
                ],
              ),
            ),

            const SizedBox(height: 24),

            /// 🔥 STATS
            Row(
              children: [
                Expanded(
                    child: _statCard('Best Score', '$bestScore',
                        Icons.emoji_events_outlined, Colors.amber, isDark)),
                const SizedBox(width: 16),
                Expanded(
                    child: _statCard('Signs Learned', '$learnedSigns',
                        Icons.school_outlined, Colors.blue, isDark)),
              ],
            ),

            const SizedBox(height: 32),

            const Text('Practice Modes',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),

            const SizedBox(height: 16),

            _modeCard(
                'Dictionary',
                'View All Signs A-Z',
                Icons.menu_book_outlined,
                isDark,
                () => _go(context, const DictionaryScreen())),

            _modeCard(
                'Freedom Mode',
                'Explore Hand Sign Recognition',
                Icons.back_hand_outlined,
                isDark,
                () => _go(context, const FreedomModeScreen())),

            _modeCard(
                'Practice Mode',
                'Learn Step By Step',
                Icons.school_outlined,
                isDark,
                () => _go(context, const PracticeModeScreen())),

            _modeCard('Test Mode', 'Test Your Knowledge', Icons.quiz_outlined,
                isDark, () => _go(context, const TestModeScreen())),

            _modeCard('Speed Challenge', '60s Speed Test', Icons.timer_outlined,
                isDark, () => _go(context, const SpeedChallengeScreen())),

            _modeCard('Word Spelling', 'Spell Words', Icons.spellcheck, isDark,
                () => _go(context, const WordSpellingScreen())),

            _modeCard(
                'Daily Challenge',
                'Daily Tasks',
                Icons.calendar_today_outlined,
                isDark,
                () => _go(context, const DailyChallengeScreen())),
          ],
        ),
      ),
    );
  }

  /// 🔥 NAV HELPER
  void _go(BuildContext context, Widget screen) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
  }

  /// 🔥 STAT CARD
  Widget _statCard(
      String title, String value, IconData icon, Color color, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border:
            Border.all(color: isDark ? Colors.grey[800]! : Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color),
          const SizedBox(height: 12),
          Text(value,
              style:
                  const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          Text(title),
        ],
      ),
    );
  }

  Widget _modeCard(String title, String subtitle, IconData icon, bool isDark,
      VoidCallback onTap) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: onTap,
        child: ListTile(
          leading: Icon(icon),
          title: Text(title),
          subtitle: Text(subtitle),
          trailing: const Icon(Icons.arrow_forward_ios, size: 14),
        ),
      ),
    );
  }
}

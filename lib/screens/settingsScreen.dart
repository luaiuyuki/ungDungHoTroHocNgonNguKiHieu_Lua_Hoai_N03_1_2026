import 'package:flutter/material.dart';
import '../services/cacheService.dart';
import '../services/firebaseService.dart';
import '../services/soundService.dart';
import '../models/statsModel.dart';
import '../main.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});
  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final _firebase = FirebaseService();
  final _sound = SoundService();

  @override
  Widget build(BuildContext context) {
    final isDark = cacheService.isDarkMode();
    final isSoundOn = _sound.isSoundEnabled;
    final textColor = isDark ? Colors.white : Colors.black87;
    final subTextColor = isDark ? Colors.grey[400] : Colors.grey[600];
    final borderColor = isDark ? Colors.grey[800]! : Colors.grey[300]!;
    final cardColor = isDark ? const Color(0xFF1E1E1E) : Colors.white;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          // ── Preferences ───────────────────────────────────────────
          Text(
            'Preferences',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: borderColor),
              borderRadius: BorderRadius.circular(8),
              color: cardColor,
            ),
            child: Column(
              children: [
                _buildSwitchTile(
                  'Dark Mode',
                  'Toggle Dark Theme Appearance',
                  isDark ? Icons.dark_mode_outlined : Icons.light_mode_outlined,
                  isDark,
                  (val) async {
                    await cacheService.setDarkMode(val);
                    setState(() {});
                    if (context.mounted) MyApp.of(context)?.rebuildApp();
                  },
                  textColor,
                  subTextColor,
                  borderColor,
                ),
                Divider(height: 1, color: borderColor),
                _buildSwitchTile(
                  'Sound Effects',
                  'Play Sounds On Correct/Incorrect Signs',
                  isSoundOn ? Icons.volume_up_outlined : Icons.volume_off_outlined,
                  isSoundOn,
                  (val) async {
                    await _sound.setSoundEnabled(val);
                    setState(() {});
                  },
                  textColor,
                  subTextColor,
                  borderColor,
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),

          // ── Data Management ────────────────────────────────────────
          Text(
            'Data Management',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: borderColor),
              borderRadius: BorderRadius.circular(8),
              color: cardColor,
            ),
            child: _buildActionTile(
              'Reset Progress',
              'Clear All Stats & Learned Signs',
              Icons.refresh_outlined,
              Colors.redAccent,
              textColor,
              subTextColor,
              () async {
                final confirm = await showDialog<bool>(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    backgroundColor: cardColor,
                    title: Text('Reset Progress', style: TextStyle(color: textColor)),
                    content: Text(
                      'Are You Sure You Want To Reset All Progress?',
                      style: TextStyle(color: subTextColor),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(ctx, false),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(ctx, true),
                        child: const Text('Reset', style: TextStyle(color: Colors.red)),
                      ),
                    ],
                  ),
                );
                if (confirm == true) {
                  await _firebase.saveStats(StatsModel(
                    bestScore: 0,
                    currentStreak: 0,
                    lastPracticeDate: DateTime.now(),
                    learnedSigns: [],
                  ));
                  await cacheService.resetDailyChallenge();
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Progress Reset Successfully')),
                    );
                  }
                }
              },
            ),
          ),
          const SizedBox(height: 32),

          // ── Information ────────────────────────────────────────────
          Text(
            'Information',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: borderColor),
              borderRadius: BorderRadius.circular(8),
              color: cardColor,
            ),
            child: _buildActionTile(
              'About SASL',
              'Version 1.0.0',
              Icons.info_outline,
              Theme.of(context).primaryColor,
              textColor,
              subTextColor,
              () => showAboutDialog(
                context: context,
                applicationName: 'SASL',
                applicationVersion: '1.0.0',
                applicationIcon: Icon(
                  Icons.sign_language,
                  size: 50,
                  color: Theme.of(context).primaryColor,
                ),
                children: [const Text('Learn Sign Language With AI-Powered Recognition!')],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSwitchTile(
    String title,
    String subtitle,
    IconData icon,
    bool value,
    Function(bool) onChanged,
    Color titleColor,
    Color? subtitleColor,
    Color borderColor,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Icon(icon, color: Theme.of(context).primaryColor, size: 22),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: titleColor)),
                const SizedBox(height: 4),
                Text(subtitle, style: TextStyle(fontSize: 12, color: subtitleColor)),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeThumbColor: Theme.of(context).primaryColor,
          ),
        ],
      ),
    );
  }

  Widget _buildActionTile(
    String title,
    String subtitle,
    IconData icon,
    Color iconColor,
    Color titleColor,
    Color? subtitleColor,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: iconColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Icon(icon, color: iconColor, size: 22),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: titleColor)),
                  const SizedBox(height: 4),
                  Text(subtitle, style: TextStyle(fontSize: 12, color: subtitleColor)),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios, size: 14, color: subtitleColor),
          ],
        ),
      ),
    );
  }
}
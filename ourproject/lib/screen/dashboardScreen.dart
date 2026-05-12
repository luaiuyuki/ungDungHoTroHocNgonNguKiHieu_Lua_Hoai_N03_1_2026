import 'package:flutter/material.dart';
import 'settingsScreen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ================= HEADER (GIỮ NGUYÊN) =================
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
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
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.purple.shade50,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.language, size: 28),
                  ),
                  const SizedBox(width: 12),
                  const Text('SASL',
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  const SizedBox(width: 24),
                  Expanded(
                    child: Wrap(
                      spacing: 16,
                      children: const [
                        Text('Products'),
                        Text('Solutions'),
                        Text('Community'),
                        Text('Resources'),
                        Text('Pricing'),
                        Text('Contact'),
                      ],
                    ),
                  ),
                  TextButton(onPressed: () {}, child: const Text('Sign in')),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      backgroundColor: Colors.white,
                    ),
                    child: const Text('Register', style: TextStyle(color: Colors.black)),
                  ),
                  const SizedBox(width: 16),
                  IconButton(
                    icon: const Icon(Icons.settings, color: Colors.blue),
                    tooltip: 'Vào bài tập Get Value',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const SettingsScreen()),
                      );
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // ================= CONTENT (GIỮ NGUYÊN) =================
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
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
                  Row(
                    children: [
                      Expanded(
                          child: _statCard(context, 'Best Score', '0',
                              Icons.emoji_events_outlined, Colors.amber)),
                      const SizedBox(width: 16),
                      Expanded(
                          child: _statCard(context, 'Signs Learned', '0',
                              Icons.school_outlined, Colors.blue)),
                    ],
                  ),
                  const SizedBox(height: 32),
                  const Text('Practice Modes',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  _modeCard(context, 'Dictionary', Icons.menu_book_outlined),
                  _modeCard(
                      context, 'Freedom Mode', Icons.back_hand_outlined),
                  _modeCard(context, 'Practice Mode', Icons.school_outlined),
                  _modeCard(context, 'Test Mode', Icons.quiz_outlined),
                  _modeCard(
                      context, 'Speed Challenge', Icons.timer_outlined),
                  _modeCard(context, 'Word Spelling', Icons.spellcheck),
                  _modeCard(
                      context, 'Daily Challenge', Icons.calendar_today),
                ],
              ),
            ),

            const SizedBox(height: 80), // Tăng khoảng cách trước footer

            // ================= FOOTER (ĐÃ SỬA THEO MẪU) =================
            _footer(context),
          ],
        ),
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

  Widget _modeCard(BuildContext context, String title, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        trailing: const Icon(Icons.arrow_forward_ios, size: 14),
      ),
    );
  }

  // Hàm Footer mới theo style ảnh ông gửi
  Widget _footer(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 60),
      color: Colors.white, // Footer thường để nền trắng hoặc cực nhạt cho sạch
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Cột Logo và Social Icons
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.blur_on, size: 40, color: Colors.black), // Thay cho logo Figma
                const SizedBox(height: 24),
                Row(
                  children: [
                    _socialIcon(Icons.close), // X (Twitter) icon
                    const SizedBox(width: 16),
                    _socialIcon(Icons.camera_alt_outlined), // Instagram
                    const SizedBox(width: 16),
                    _socialIcon(Icons.play_circle_outline), // Youtube
                    const SizedBox(width: 16),
                   _socialIcon(Icons.account_circle),
                    // Linkedin
                  ],
                ),
              ],
            ),
          ),
          // Các cột nội dung
          Expanded(child: _footerColumn("Use cases", ["UI design", "UX design", "Wireframing", "Diagramming", "Brainstorming", "Online whiteboard", "Team collaboration"])),
          Expanded(child: _footerColumn("Explore", ["Design", "Prototyping", "Development features", "Design systems", "Collaboration features", "Design process", "FigJam"])),
          Expanded(child: _footerColumn("Resources", ["Blog", "Best practices", "Colors", "Color wheel", "Support", "Developers", "Resource library"])),
        ],
      ),
    );
  }

  Widget _socialIcon(IconData icon) {
    return Icon(icon, size: 24, color: Colors.black87);
  }

  Widget _footerColumn(String title, List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black87)),
        const SizedBox(height: 20),
        ...items.map((e) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Text(e, style: const TextStyle(color: Colors.black54, fontSize: 14)),
            )),
      ],
    );
  }
}
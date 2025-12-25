import 'package:flutter/material.dart';
import '../../../core/widgets/section_header.dart';

class SessionsPage extends StatelessWidget {
  const SessionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Session History'),
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(24.0),
          children: [
            const SectionHeader(title: 'Recent Activity'),
            const SizedBox(height: 16),
            _buildSessionCard(
              context,
              'Deep Focus',
              '25m 00s',
              'Today, 9:24 AM',
              0,
              Icons.bolt,
            ),
            const SizedBox(height: 12),
            _buildSessionCard(
              context,
              'Study Session',
              '45m 00s',
              'Today, 8:15 AM',
              3,
              Icons.menu_book_outlined,
            ),
            const SizedBox(height: 32),
            const SectionHeader(title: 'Yesterday'),
            const SizedBox(height: 16),
            _buildSessionCard(
              context,
              'Work Focus',
              '1h 20m',
              'Yesterday, 2:00 PM',
              5,
              Icons.work_outline,
            ),
            const SizedBox(height: 12),
            _buildSessionCard(
              context,
              'Meditation',
              '10m 00s',
              'Yesterday, 8:00 AM',
              0,
              Icons.spa_outlined,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSessionCard(
    BuildContext context,
    String title,
    String duration,
    String time,
    int blocks,
    IconData icon,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1D1B26),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFF322E40),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: Colors.white70, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  time,
                  style: TextStyle(color: Colors.grey[500], fontSize: 12),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                duration,
                style: const TextStyle(
                  color: Color(0xFF8B3DFF),
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              if (blocks > 0) ...[
                const SizedBox(height: 4),
                Text(
                  '$blocks blocks',
                  style: const TextStyle(
                    color: Color(0xFFE11D48),
                    fontSize: 11,
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}

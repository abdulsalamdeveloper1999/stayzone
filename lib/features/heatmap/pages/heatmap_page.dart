import 'package:flutter/material.dart';
import '../../home/widgets/heatmap_widget.dart';
import '../../home/widgets/stat_card.dart';
import '../../../core/widgets/section_header.dart';

class HeatmapPage extends StatelessWidget {
  const HeatmapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Focus Analysis'),
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SectionHeader(title: 'Overview'),
              const SizedBox(height: 20),
              Row(
                children: const [
                  Expanded(
                    child: StatCard(
                      value: '24h 15m',
                      label: 'TOTAL FOCUS',
                      icon: Icons.history_toggle_off,
                      color: Color(0xFF8B3DFF),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: StatCard(
                      value: '8.2h',
                      label: 'DAILY AVG',
                      icon: Icons.auto_graph,
                      color: Color(0xFF6366F1),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              const SectionHeader(title: 'Monthly Trends'),
              const SizedBox(height: 20),
              const HeatmapWidget(),
              const SizedBox(height: 32),
              const SectionHeader(title: 'Activity Highlights'),
              const SizedBox(height: 16),
              _buildHighlightCard(
                context,
                'Golden Hour',
                '9:00 AM - 11:00 AM',
                Icons.wb_sunny_outlined,
              ),
              const SizedBox(height: 12),
              _buildHighlightCard(
                context,
                'Most Focused Day',
                'Last Wednesday',
                Icons.calendar_today_outlined,
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHighlightCard(
    BuildContext context,
    String title,
    String subtitle,
    IconData icon,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1D1B26),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF8B3DFF).withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: const Color(0xFF8B3DFF), size: 24),
          ),
          const SizedBox(width: 16),
          Column(
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
                subtitle,
                style: TextStyle(color: Colors.grey[400], fontSize: 13),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class HeatmapWidget extends StatelessWidget {
  final Map<DateTime, int> dailyMinutes;

  const HeatmapWidget({super.key, required this.dailyMinutes});

  @override
  Widget build(BuildContext context) {
    // Generate a 4-week grid (28 days) ending today
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    // We want 4 rows of 7 days.
    // Let's find the start date (3 weeks ago Monday, or something similar)
    // To keep it simple and consistent with the dummy UI:
    // Let's show the last 28 days.
    final startDate = today.subtract(const Duration(days: 27));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Focus Heatmap',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const Icon(Icons.chevron_right, color: Colors.grey),
          ],
        ),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color(0xFF1D1B26),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Colors.white.withOpacity(0.05)),
          ),
          child: Column(
            children: [
              // Days label
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _HeatmapLabel('M'),
                  _HeatmapLabel('T'),
                  _HeatmapLabel('W'),
                  _HeatmapLabel('T'),
                  _HeatmapLabel('F'),
                  _HeatmapLabel('S'),
                  _HeatmapLabel('S'),
                ],
              ),
              const SizedBox(height: 12),
              // Dynamic Heatmap Grid (4 weeks)
              for (int week = 0; week < 4; week++) ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: List.generate(7, (day) {
                    final date = startDate.add(Duration(days: week * 7 + day));
                    final minutes = dailyMinutes[date] ?? 0;
                    return _HeatmapNode(
                      color: _getNodeColor(minutes, date, today),
                      tooltip: '${_formatDate(date)}: $minutes mins',
                    );
                  }),
                ),
                const SizedBox(height: 8),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Color _getNodeColor(int minutes, DateTime date, DateTime today) {
    if (date.isAfter(today)) return const Color(0xFF231F33);
    if (minutes == 0) return const Color(0xFF231F33);
    if (minutes < 30) return const Color(0xFF8B3DFF).withOpacity(0.3);
    if (minutes < 60) return const Color(0xFF8B3DFF).withOpacity(0.6);
    return const Color(0xFF8B3DFF); // High intensity
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}';
  }
}

class _HeatmapNode extends StatelessWidget {
  final Color color;
  final String tooltip;
  const _HeatmapNode({required this.color, required this.tooltip});

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}

class _HeatmapLabel extends StatelessWidget {
  final String label;
  const _HeatmapLabel(this.label);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 32,
      child: Center(
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

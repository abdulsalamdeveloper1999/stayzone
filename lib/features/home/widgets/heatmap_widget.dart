import 'package:flutter/material.dart';

class HeatmapWidget extends StatelessWidget {
  const HeatmapWidget({super.key});

  @override
  Widget build(BuildContext context) {
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
                children: const [
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
              // Dummy Heatmap Grid
              for (int i = 0; i < 4; i++) ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: List.generate(
                    7,
                    (j) => _HeatmapNode(
                      color: (i == 1 && j == 2)
                          ? const Color(0xFFE11D48) // Distracted (red)
                          : (j % 3 == 0)
                          ? const Color(0xFF8B3DFF) // High (purple)
                          : (j % 2 == 0)
                          ? const Color(0xFF4C1D95).withOpacity(0.5) // Low
                          : const Color(0xFF231F33), // None
                    ),
                  ),
                ),
                const SizedBox(height: 8),
              ],
            ],
          ),
        ),
      ],
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

class _HeatmapNode extends StatelessWidget {
  final Color color;
  const _HeatmapNode({required this.color});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}

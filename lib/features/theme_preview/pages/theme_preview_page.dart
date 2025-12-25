import 'package:flutter/material.dart';

class ThemePreviewPage extends StatelessWidget {
  const ThemePreviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Theme Preview')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // High-Fidelity Components Section
            _buildHeader(context, 'Live Components'),
            const SizedBox(height: 24),

            // 1. Focus Timer Layout (Screenshot 2/3)
            _buildFocusTimer(context),
            const SizedBox(height: 32),

            // Start Session Button (The pill shaped ones from screenshots)
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 56),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.play_arrow, size: 24),
                  const SizedBox(width: 8),
                  const Text('Start Focus Session'),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // 2. Stat Cards Row (Screenshot 3/4)
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    context,
                    '4h 20m',
                    'TODAY',
                    Icons.bolt,
                    const Color(0xFF8B3DFF),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildStatCard(
                    context,
                    '12',
                    'BLOCKED',
                    Icons.notifications_off,
                    const Color(0xFF6366F1),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildStatCard(
                    context,
                    '5 Days',
                    'STREAK',
                    Icons.local_fire_department,
                    const Color(0xFFF59E0B),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),

            // 3. Focus Heatmap Section (Screenshot 5)
            _buildHeatmapSection(context),
            const SizedBox(height: 32),

            // 4. Focus Insight Card (Screenshot 5 bottom)
            _buildInsightCard(context),

            const SizedBox(height: 48),

            // Original Typography Section (Simplified)
            _buildHeader(context, 'Typography'),
            const SizedBox(height: 16),
            Text(
              'Display Large',
              style: Theme.of(context).textTheme.displayLarge,
            ),
            Text(
              'Headline Large',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            Text(
              'Body Large - Focused and distraction-free.',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 48),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        const Divider(height: 24),
      ],
    );
  }

  Widget _buildFocusTimer(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Outer Glow
          Container(
            width: 280,
            height: 280,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF8B3DFF).withOpacity(0.15),
                  blurRadius: 60,
                  spreadRadius: 10,
                ),
              ],
            ),
          ),
          // Timer Track
          SizedBox(
            width: 240,
            height: 240,
            child: CircularProgressIndicator(
              value: 0.75,
              strokeWidth: 10,
              backgroundColor: const Color(0xFF231F33),
              valueColor: const AlwaysStoppedAnimation<Color>(
                Color(0xFF8B3DFF),
              ),
            ),
          ),
          // Timer Content
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.timer_outlined,
                color: Color(0xFF8B3DFF),
                size: 32,
              ),
              const SizedBox(height: 12),
              Text(
                '25:00',
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                  fontSize: 64,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Ready to Focus',
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: Colors.grey[400]),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(
    BuildContext context,
    String value,
    String label,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF1D1B26),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(height: 16),
          Text(
            value,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: Colors.grey[500],
              letterSpacing: 1,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeatmapSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Focus Heatmap',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
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

  Widget _buildInsightCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1D1B26),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFF8B3DFF).withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFF8B3DFF).withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.auto_awesome, color: Color(0xFF8B3DFF)),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Focus Insight',
                  style: TextStyle(
                    color: Color(0xFF8B3DFF),
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'You are most productive between 9am and 12pm. Try scheduling your deep work during these hours.',
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 13,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
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

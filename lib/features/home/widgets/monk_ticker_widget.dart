import 'dart:async';
import 'package:flutter/material.dart';

class MonkTickerWidget extends StatefulWidget {
  final int activeCount;
  final List<String> recentTitles;

  const MonkTickerWidget({
    super.key,
    required this.activeCount,
    required this.recentTitles,
  });

  @override
  State<MonkTickerWidget> createState() => _MonkTickerWidgetState();
}

class _MonkTickerWidgetState extends State<MonkTickerWidget> {
  late PageController _pageController;
  Timer? _timer;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _startTicker();
  }

  void _startTicker() {
    _timer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (!mounted || !_pageController.hasClients) return;

      final totalItems =
          widget.recentTitles.length + 1; // Titles + the count message
      _currentIndex = (_currentIndex + 1) % totalItems;

      _pageController.animateToPage(
        _currentIndex,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.activeCount == 0) return const SizedBox.shrink();

    final List<Widget> items = [
      _buildTickerItem(
        Icons.group_rounded,
        '${widget.activeCount} Monks are focusing right now',
        const Color(0xFF8B3DFF),
      ),
      ...widget.recentTitles.map(
        (title) => _buildTickerItem(
          Icons.bolt_rounded,
          'A Monk is focusing on: $title',
          const Color(0xFF10B981),
        ),
      ),
    ];

    return Container(
      height: 40,
      margin: const EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
        color: const Color(0xFF1D1B26).withOpacity(0.5),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFF8B3DFF).withOpacity(0.1)),
      ),
      child: PageView.builder(
        controller: _pageController,
        scrollDirection: Axis.vertical,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: items.length,
        itemBuilder: (context, index) => items[index % items.length],
      ),
    );
  }

  Widget _buildTickerItem(IconData icon, String text, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 16),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: Colors.grey[300],
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

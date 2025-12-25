import 'package:flutter/material.dart';

class FocusTimerWidget extends StatefulWidget {
  final String time;
  final String status;
  final double progress;
  final VoidCallback? onTap;
  final String? activityLabel;
  final String? microCopy;
  final String? scarcityMetric;

  const FocusTimerWidget({
    super.key,
    required this.time,
    required this.status,
    required this.progress,
    this.onTap,
    this.activityLabel,
    this.microCopy,
    this.scarcityMetric,
  });

  @override
  State<FocusTimerWidget> createState() => _FocusTimerWidgetState();
}

class _FocusTimerWidgetState extends State<FocusTimerWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4), // Box breathing rhythm
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 0.1, end: 0.3).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              // Outer Breathing Glow (280x280)
              AnimatedBuilder(
                animation: _pulseAnimation,
                builder: (context, child) {
                  return Container(
                    width: 280,
                    height: 280,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: const Color(
                            0xFF8B3DFF,
                          ).withValues(alpha: _pulseAnimation.value),
                          blurRadius: 70,
                          spreadRadius: 15,
                        ),
                      ],
                    ),
                  );
                },
              ),
              // Timer Track (240x240)
              SizedBox(
                width: 240,
                height: 240,
                child: CircularProgressIndicator(
                  value: widget.progress,
                  strokeWidth: 12,
                  backgroundColor: const Color(0xFF231F33),
                  valueColor: const AlwaysStoppedAnimation<Color>(
                    Color(0xFF8B3DFF),
                  ),
                ),
              ),
              // Core Timer Content (Inside Circle)
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 48, // Fixed height to prevent layout shift
                    child: Center(
                      child: widget.activityLabel != null
                          ? Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(
                                  0xFF8B3DFF,
                                ).withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                widget.activityLabel!.toUpperCase(),
                                style: const TextStyle(
                                  color: Color(0xFF8B3DFF),
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1,
                                ),
                              ),
                            )
                          : Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.white.withValues(alpha: 0.1),
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                'SESSION READY',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 9,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 2,
                                ),
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Icon(
                    Icons.timer_outlined,
                    color: Color(0xFF8B3DFF),
                    size: 28,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.time,
                    style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      fontSize: 64,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.status,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.grey[400],
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          // Auxiliary Information (Outside Circle)
          if (widget.scarcityMetric != null) ...[
            Text(
              widget.scarcityMetric!,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: const Color(0xFF8B3DFF).withValues(alpha: 0.8),
                fontSize: 12,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 12),
          ],
          if (widget.microCopy != null) ...[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                widget.microCopy!,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey[500],
                  fontSize: 12,
                  fontStyle: FontStyle.italic,
                  height: 1.5,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

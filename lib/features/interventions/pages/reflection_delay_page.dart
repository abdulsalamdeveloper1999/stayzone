import 'dart:async';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class ReflectionDelayPage extends StatefulWidget {
  final String appName;
  final VoidCallback onAccepted;
  final VoidCallback onRejected;

  const ReflectionDelayPage({
    super.key,
    required this.appName,
    required this.onAccepted,
    required this.onRejected,
  });

  @override
  State<ReflectionDelayPage> createState() => _ReflectionDelayPageState();
}

class _ReflectionDelayPageState extends State<ReflectionDelayPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _breathingController;
  late Animation<double> _breatheAnimation;
  int _secondsRemaining = 10;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _breathingController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);

    _breatheAnimation = Tween<double>(begin: 1.0, end: 1.5).animate(
      CurvedAnimation(parent: _breathingController, curve: Curves.easeInOut),
    );

    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() => _secondsRemaining--);
      } else {
        _timer?.cancel();
      }
    });
  }

  @override
  void dispose() {
    _breathingController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0C14),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.spa_outlined,
                color: Color(0xFF8B3DFF),
                size: 48,
              ),
              const SizedBox(height: 24),
              Text(
                'Pause and Reflect',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'You are about to open ${widget.appName}. Is this a choice or a habit?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 16,
                  height: 1.5,
                ),
              ),
              const Spacer(),

              // Breathing Animation
              Center(
                child: AnimatedBuilder(
                  animation: _breatheAnimation,
                  builder: (context, child) {
                    return Container(
                      width: 150 * _breatheAnimation.value,
                      height: 150 * _breatheAnimation.value,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xFF8B3DFF).withOpacity(0.1),
                        border: Border.all(
                          color: const Color(0xFF8B3DFF).withOpacity(0.3),
                          width: 2,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          _secondsRemaining > 0 ? '$_secondsRemaining' : 'Done',
                          style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
              Text(
                _breathingController.status == AnimationStatus.forward
                    ? 'Breathe in...'
                    : 'Breathe out...',
                style: TextStyle(
                  color: const Color(0xFF8B3DFF).withOpacity(0.7),
                  fontWeight: FontWeight.w600,
                ),
              ),

              const Spacer(),

              if (_secondsRemaining == 0) ...[
                ElevatedButton(
                  onPressed: widget.onAccepted,
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 56),
                    backgroundColor: Colors.white.withOpacity(0.05),
                    side: BorderSide(color: Colors.white.withOpacity(0.1)),
                  ),
                  child: const Text(
                    'I still want to open it',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(height: 16),
              ],

              ElevatedButton(
                onPressed: widget.onRejected,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 56),
                  backgroundColor: const Color(0xFF8B3DFF),
                ),
                child: const Text('Actually, I will stay focused'),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

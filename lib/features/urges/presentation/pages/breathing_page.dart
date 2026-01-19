import 'dart:async';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:aether_focus/features/home/presentation/cubit/home_cubit.dart';
import 'dart:ui';

@RoutePage()
class BreathingPage extends StatefulWidget {
  final String? userId;
  const BreathingPage({super.key, this.userId});

  @override
  State<BreathingPage> createState() => _BreathingPageState();
}

class _BreathingPageState extends State<BreathingPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  int _secondsRemaining = 60;
  Timer? _timer;
  bool _isFinished = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);

    _animation = Tween<double>(
      begin: 1.0,
      end: 1.5,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        if (mounted) setState(() => _secondsRemaining--);
      } else {
        if (mounted) {
          setState(() => _isFinished = true);
          if (widget.userId != null) {
            context.read<HomeCubit>().reportUrge(
              userId: widget.userId!,
              interventionType: 'breathing',
            );
          }
        }
        _timer?.cancel();
        _controller.stop();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A090F),
      body: Stack(
        children: [
          // Background Glows
          Positioned(
            top: 200,
            left: -50,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF8B3DFF).withOpacity(0.1),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
                child: Container(color: Colors.transparent),
              ),
            ),
          ),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 32.0,
                vertical: 24.0,
              ),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  const Icon(
                    Icons.spa_rounded,
                    color: Color(0xFF8B3DFF),
                    size: 48,
                  ),
                  const SizedBox(height: 24),
                  Text(
                    _isFinished ? 'Well Done' : 'Just Breathe',
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    _isFinished
                        ? 'The urge has faded. You are back in control of your time.'
                        : 'Inhale as the circle grows, exhale as it shrinks.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 16,
                      height: 1.5,
                      letterSpacing: 0.2,
                    ),
                  ),
                  const Spacer(),
                  Center(
                    child: AnimatedBuilder(
                      animation: _animation,
                      builder: (context, child) {
                        return Stack(
                          alignment: Alignment.center,
                          children: [
                            // Outer Glow
                            Container(
                              width: 220 * _animation.value,
                              height: 220 * _animation.value,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: const Color(
                                  0xFF8B3DFF,
                                ).withOpacity(0.05 * _animation.value),
                              ),
                            ),
                            // Glass Circle
                            ClipRRect(
                              borderRadius: BorderRadius.circular(200),
                              child: BackdropFilter(
                                filter: ImageFilter.blur(
                                  sigmaX: 10,
                                  sigmaY: 10,
                                ),
                                child: Container(
                                  width: 180 * _animation.value,
                                  height: 180 * _animation.value,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white.withOpacity(0.03),
                                    border: Border.all(
                                      color: const Color(
                                        0xFF8B3DFF,
                                      ).withOpacity(0.3),
                                      width: 2,
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      _isFinished ? '✓' : '$_secondsRemaining',
                                      style: const TextStyle(
                                        fontSize: 48,
                                        fontWeight: FontWeight.w300,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 48),
                  if (!_isFinished)
                    Text(
                      _controller.status == AnimationStatus.forward
                          ? 'Breathe In'
                          : 'Breathe Out',
                      style: const TextStyle(
                        fontSize: 22,
                        color: Color(0xFF8B3DFF),
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1.5,
                      ),
                    ),
                  const Spacer(),
                  if (_isFinished)
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: const LinearGradient(
                          colors: [Color(0xFF8B3DFF), Color(0xFF6366F1)],
                        ),
                      ),
                      child: ElevatedButton(
                        onPressed: () => context.router.back(),
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 64),
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: const Text(
                          'Continue My Journey',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  else
                    TextButton(
                      onPressed: () => context.router.back(),
                      child: Text(
                        'Stop Session',
                        style: TextStyle(color: Colors.grey[600], fontSize: 16),
                      ),
                    ),
                  const SizedBox(height: 12),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

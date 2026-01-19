import 'dart:ui';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/routes/app_router.dart';
import '../../../core/services/sound_service.dart';
import '../../auth/presentation/bloc/auth_bloc.dart';
import '../widgets/focus_timer_widget.dart';
import '../widgets/stat_card.dart';
import '../widgets/insight_card.dart';
import '../widgets/sos_urge_widget.dart';
import '../widgets/focus_choice_modal.dart';
import '../widgets/monk_ticker_widget.dart';
import '../presentation/cubit/home_cubit.dart';
import '../presentation/cubit/home_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    // Load stats on init
    final authState = context.read<AuthBloc>().state;
    if (authState is AuthAuthenticated) {
      context.read<HomeCubit>().loadStats(authState.user.id);
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      final authState = context.read<AuthBloc>().state;
      if (authState is AuthAuthenticated) {
        context.read<HomeCubit>().loadStats(authState.user.id);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final bool isFocused = state.isRunning || state.isPaused;

        // Use a persistent sound toggle visibility check
        final bool showSoundButton =
            (state.isRunning || state.isPaused) &&
            SoundService().currentActivity != null;

        return Scaffold(
          body: SafeArea(
            child: isFocused
                ? _buildFocusedLayout(context, state, showSoundButton)
                : _buildRegularLayout(context, state),
          ),
        );
      },
    );
  }

  Widget _buildFocusedLayout(
    BuildContext context,
    HomeState state,
    bool showSoundButton,
  ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        children: [
          const Spacer(flex: 2),
          // Centered Timer
          FocusTimerWidget(
            time: _formatSeconds(state.remainingSeconds),
            status: state.isPaused ? 'Paused' : 'Deep Work in Progress',
            progress: state.remainingSeconds / state.totalSeconds,
            activityLabel: state.currentActivity,
            microCopy: _getTimerMicroCopy(state),
            scarcityMetric: _getScarcityMetric(),
            onTap: () {}, // No dialog during session
          ),

          const SizedBox(height: 24),

          // Monk Squad Ticker
          MonkTickerWidget(
            activeCount: state.monkActiveCount,
            recentTitles: state.monkRecentTitles,
          ),

          if (showSoundButton) ...[
            const SizedBox(height: 24),
            _buildSoundToggle(),
          ],

          const Spacer(flex: 3),

          // Control Buttons at Bottom
          Padding(
            padding: const EdgeInsets.only(bottom: 40.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildFocusedButton(
                  onPressed: () {
                    if (state.isPaused) {
                      context.read<HomeCubit>().resumeTimer();
                    } else {
                      context.read<HomeCubit>().pauseTimer();
                    }
                  },
                  icon: state.isPaused ? Icons.play_arrow : Icons.pause,
                  label: state.isPaused ? 'Resume' : 'Pause',
                  color: state.isPaused
                      ? const Color(0xFF10B981)
                      : const Color(0xFFFFA500),
                ),
                const SizedBox(width: 16),
                _buildFocusedButton(
                  onPressed: () => _confirmStopSession(context),
                  icon: Icons.stop,
                  label: 'Stop',
                  color: const Color(0xFFE11D48),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSoundToggle() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1D1B26),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFF8B3DFF).withValues(alpha: 0.3),
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            setState(() {
              SoundService().toggleMute();
            });
          },
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  SoundService().isMuted ? Icons.volume_off : Icons.volume_up,
                  color: const Color(0xFF8B3DFF),
                  size: 18,
                ),
                const SizedBox(width: 8),
                Text(
                  SoundService().isMuted ? 'Sound Off' : 'Sound On',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFocusedButton({
    required VoidCallback onPressed,
    required IconData icon,
    required String label,
    required Color color,
  }) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 20, color: color),
      label: Text(
        label,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: color.withValues(alpha: 0.1),
        foregroundColor: color,
        elevation: 0,
        side: BorderSide(color: color, width: 2),
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }

  Widget _buildRegularLayout(BuildContext context, HomeState state) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header
          BlocBuilder<AuthBloc, AuthState>(
            builder: (context, authState) {
              final name = _getUserName(authState);
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            name,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              letterSpacing: -0.5,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(
                                0xFF8B3DFF,
                              ).withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Text(
                              'THE MONK',
                              style: TextStyle(
                                color: Color(0xFF8B3DFF),
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  _buildProfileButton(context),
                ],
              );
            },
          ),
          const SizedBox(height: 32),

          // SOS Widget
          SosUrgeWidget(
            onTap: () {
              final authState = context.read<AuthBloc>().state;
              if (authState is AuthAuthenticated) {
                _showUrgeOptions(context, authState.user.id);
              }
            },
          ),
          const SizedBox(height: 32),

          // Monk Squad Ticker
          MonkTickerWidget(
            activeCount: state.monkActiveCount,
            recentTitles: state.monkRecentTitles,
          ),

          // Timer (Pre-session)
          FocusTimerWidget(
            time: _formatSeconds(state.remainingSeconds),
            status: 'Ready to Focus',
            progress: state.remainingSeconds / state.totalSeconds,
            activityLabel: null,
            microCopy: _getTimerMicroCopy(state),
            scarcityMetric: _getScarcityMetric(),
            onTap: () => _showFocusSetup(context),
          ),
          const SizedBox(height: 32),

          // Stats Row
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: StatCard(
                    icon: Icons.timer,
                    value: _formatMinutesToHoursMinutes(
                      state.todayTotalMinutes,
                    ),
                    label: "Today's Focus",
                    color: const Color(0xFF8B3DFF),
                    onTap: () => _showStatInfo(
                      context,
                      "Today's Focus",
                      "Total active time you've spent in focus mode today. Every minute counts toward building your deep work habit.",
                      Icons.timer,
                      const Color(0xFF8B3DFF),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: StatCard(
                    icon: Icons.block,
                    value: state.todayUrgesCount.toString(),
                    label: 'Blocked',
                    color: const Color(0xFF6366F1),
                    onTap: () => _showStatInfo(
                      context,
                      "Urges Blocked",
                      "Number of times you resisted a distraction. This includes using SOS tools and completing breathing exercises.",
                      Icons.block,
                      const Color(0xFF6366F1),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: StatCard(
                    icon: Icons.local_fire_department,
                    value: state.userStreak.toString(),
                    label: 'Streak',
                    color: const Color(0xFFE11D48),
                    onTap: () => _showStatInfo(
                      context,
                      "Focus Streak",
                      "Number of consecutive days you've completed at least one focus session. Don't break the chain!",
                      Icons.local_fire_department,
                      const Color(0xFFE11D48),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          // Analytics Badges
          if (state.goldenHour != null || state.dangerZone != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  if (state.goldenHour != null)
                    _buildInsightBadge(
                      context,
                      'Golden Hour: ${state.goldenHour}',
                      Icons.star_rounded,
                      const Color(0xFFFACC15),
                    ),
                  if (state.dangerZone != null)
                    _buildInsightBadge(
                      context,
                      'Danger Zone: ${state.dangerZone}',
                      Icons.warning_rounded,
                      const Color(0xFFFB7185),
                    ),
                ],
              ),
            ),

          // Insight Card
          _buildDailyInsight(state),
        ],
      ),
    );
  }

  Widget _buildInsightBadge(
    BuildContext context,
    String label,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 14),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 11,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDailyInsight(HomeState state) {
    return InsightCard(
      title: 'Smart Insight',
      message: state.dailyInsight,
      icon: Icons.auto_awesome_rounded,
    );
  }

  void _showStatInfo(
    BuildContext context,
    String title,
    String description,
    IconData icon,
    Color color,
  ) {
    showDialog(
      context: context,
      builder: (context) => BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.symmetric(horizontal: 40),
          child: Container(
            padding: const EdgeInsets.all(28),
            decoration: BoxDecoration(
              color: const Color(0xFF14111C),
              borderRadius: BorderRadius.circular(32),
              border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
              boxShadow: [
                BoxShadow(
                  color: color.withValues(alpha: 0.1),
                  blurRadius: 30,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: color, size: 36),
                ),
                const SizedBox(height: 24),
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  description,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 15,
                    height: 1.5,
                    letterSpacing: 0.2,
                  ),
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: color,
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 56),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Got it',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // --- Helper Methods ---

  String _formatSeconds(int seconds) {
    final minutes = seconds ~/ 60;
    final secs = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  String _formatMinutesToHoursMinutes(int totalMinutes) {
    if (totalMinutes < 60) return '${totalMinutes}m';
    final hours = totalMinutes ~/ 60;
    final minutes = totalMinutes % 60;
    return minutes == 0 ? '${hours}h' : '${hours}h ${minutes}m';
  }

  String _getScarcityMetric() {
    final now = DateTime.now();
    final remainingHours = 24 - now.hour;
    return '$remainingHours hours left today';
  }

  String _getTimerMicroCopy(HomeState state) {
    if (state.isPaused) return 'Session paused';
    if (state.isRunning) return 'Deep work in progress';
    return 'Tap to begin your focused session';
  }

  void _showFocusSetup(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (modalContext) => FocusChoiceModal(
        onSelected: (activity, duration, title) async {
          final messenger = ScaffoldMessenger.of(context);
          try {
            await SoundService().playForActivity(activity);

            if (!mounted) return;

            final authState = context.read<AuthBloc>().state;
            if (authState is AuthAuthenticated) {
              await context.read<HomeCubit>().startTimer(
                userId: authState.user.id,
                activityType: activity.label,
                durationMinutes: duration,
                title: title,
              );
            }
          } catch (e) {
            messenger.showSnackBar(SnackBar(content: Text('Error: $e')));
          }
        },
      ),
    );
  }

  void _confirmStopSession(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: const Color(0xFF1A1625),
        title: const Text(
          'Stop Session?',
          style: TextStyle(color: Colors.white),
        ),
        content: const Text(
          'Are you sure you want to stop this focus session? Only completed minutes will be recorded.',
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              context.read<HomeCubit>().stopTimer();
            },
            child: const Text(
              'Stop',
              style: TextStyle(
                color: Color(0xFFE11D48),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showUrgeOptions(BuildContext context, String userId) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(40)),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(
            padding: const EdgeInsets.fromLTRB(24, 12, 24, 32),
            decoration: BoxDecoration(
              color: const Color(0xFF14111C).withOpacity(0.85),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(40),
              ),
              border: Border.all(
                color: Colors.white.withOpacity(0.1),
                width: 1,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Urge Intervention',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    letterSpacing: -0.5,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  "Choose your path to stay in control",
                  style: TextStyle(color: Colors.grey[400], fontSize: 15),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                _buildOptionCard(
                  context,
                  'Take a timed break',
                  'Step away with a safety net',
                  Icons.timer_rounded,
                  const Color(0xFF10B981),
                  () {
                    final router = context.router;
                    Navigator.pop(context);
                    router.push(
                      ReflectionDelayRoute(
                        appName: 'a break session',
                        onAccepted: () {
                          router.replace(
                            ControlledBreakRoute(appName: 'StayZone'),
                          );
                        },
                        onRejected: () {
                          context.read<HomeCubit>().reportUrge(
                            userId: userId,
                            interventionType: 'reflection_before_break',
                          );
                          router.back();
                        },
                      ),
                    );
                  },
                ),
                const SizedBox(height: 12),
                _buildOptionCard(
                  context,
                  'Log my achievements',
                  'Focus on your wins today',
                  Icons.stars_rounded,
                  const Color(0xFF6366F1),
                  () {
                    final router = context.router;
                    Navigator.pop(context);
                    router.push(const AchievementsRoute());
                  },
                ),
                const SizedBox(height: 12),
                _buildOptionCard(
                  context,
                  '1-Minute Breathing',
                  'Calm your mind and reset',
                  Icons.spa_rounded,
                  const Color(0xFF8B3DFF),
                  () {
                    final router = context.router;
                    Navigator.pop(context);
                    router.push(BreathingRoute(userId: userId));
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOptionCard(
    BuildContext context,
    String title,
    String subtitle,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: const Color(0xFF1D1B26),
        borderRadius: BorderRadius.circular(24),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(24),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: Colors.white.withOpacity(0.05)),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(icon, color: color, size: 28),
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
                          fontWeight: FontWeight.w600,
                          fontSize: 17,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        subtitle,
                        style: TextStyle(color: Colors.grey[500], fontSize: 13),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Colors.white.withOpacity(0.2),
                  size: 16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileButton(BuildContext context) {
    return CircleAvatar(
      backgroundColor: const Color(0xFF8B3DFF).withValues(alpha: 0.2),
      child: const Icon(Icons.person, color: Color(0xFF8B3DFF)),
    );
  }

  String _getUserName(AuthState authState) {
    if (authState is AuthAuthenticated) {
      String? name = authState.user.name;
      if (name != null && name.trim().isNotEmpty) {
        name = name.trim().split(' ')[0];
      } else {
        final email = authState.user.email;
        if (email.contains('@')) {
          name = email.split('@')[0];
        }
      }

      if (name != null && name.isNotEmpty) {
        return name[0].toUpperCase() + name.substring(1);
      }
    }
    return 'Monk'; // Fallback name
  }
}

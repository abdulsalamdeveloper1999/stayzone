import 'package:flutter/material.dart';
import '../widgets/focus_timer_widget.dart';
import '../widgets/stat_card.dart';
import '../widgets/insight_card.dart';
import '../widgets/sos_urge_widget.dart';
import '../../interventions/pages/reflection_delay_page.dart';
import '../../interventions/pages/controlled_break_page.dart';
import '../../../core/services/notification_service.dart';
import '../../../core/services/break_service.dart';
import '../../../core/services/sound_service.dart';
import '../widgets/focus_choice_modal.dart';
import 'dart:async';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  Timer? _timer;
  int _remainingSeconds = 25 * 60; // 25 minutes default
  int _totalSeconds = 25 * 60;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    _timer?.cancel();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // User returned, cancel everything
      NotificationService().cancelAll();

      // Calculate break duration if they were on a controlled break
      if (BreakService().isOnControlledBreak) {
        setState(() {
          BreakService().endControlledBreak();
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Alex • ',
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(color: Colors.grey[400]),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(
                                0xFF8B3DFF,
                              ).withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const Text(
                              'THE MONK',
                              style: TextStyle(
                                color: Color(0xFF8B3DFF),
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Ready for focus?',
                        style: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                      ),
                    ],
                  ),
                  CircleAvatar(
                    backgroundColor: const Color(
                      0xFF8B3DFF,
                    ).withValues(alpha: 0.2),
                    child: const Icon(Icons.person, color: Color(0xFF8B3DFF)),
                  ),
                ],
              ),
              const SizedBox(height: 32),

              // SOS Widget
              SosUrgeWidget(onTap: () => _showUrgeOptions(context)),
              const SizedBox(height: 32),

              // Timer
              FocusTimerWidget(
                time: _formatSeconds(_remainingSeconds),
                status: _timer != null
                    ? 'Deep Work in Progress'
                    : 'Ready to Focus',
                progress: _remainingSeconds / _totalSeconds,
                activityLabel: SoundService().currentActivity?.label,
                microCopy: _getTimerMicroCopy(),
                scarcityMetric: _getScarcityMetric(),
                onTap: () => _showFocusSetup(context),
              ),
              const SizedBox(height: 32),

              // Stats Row
              IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: const [
                    Expanded(
                      child: StatCard(
                        label: 'Today\'s Focus',
                        value: '4h 20m',
                        icon: Icons.timer_outlined,
                        color: Color(0xFF8B3DFF),
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: StatCard(
                        label: 'Blocked',
                        value: '12',
                        icon: Icons.block_outlined,
                        color: Color(0xFF6366F1),
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: StatCard(
                        label: 'Streak',
                        value: '5',
                        icon: Icons.local_fire_department_outlined,
                        color: Color(0xFFE11D48),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // Break Analytics Info
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF1D1B26),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: const Color(0xFF6366F1).withValues(alpha: 0.1),
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: const Color(
                              0xFF6366F1,
                            ).withValues(alpha: 0.1),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.history_toggle_off,
                            color: Color(0xFF6366F1),
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Daily Break Stats',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                BreakService().totalBreakDuration >
                                        Duration.zero
                                    ? 'Total: ${_formatDuration(BreakService().totalBreakDuration)} (${BreakService().totalBreakSessions} sessions)'
                                    : 'No breaks taken today - Keep it up!',
                                style: TextStyle(
                                  color: Colors.grey[400],
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    if (BreakService().lastBreakDuration != null) ...[
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        child: Divider(color: Color(0xFF231F33), height: 1),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Last Session',
                            style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: 13,
                            ),
                          ),
                          Text(
                            _formatDuration(BreakService().lastBreakDuration!),
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // Insight
              const InsightCard(
                title: 'Focus Insight',
                message:
                    'You are most productive between 9am and 12pm. Try scheduling your deep work during these hours.',
                icon: Icons.auto_awesome,
              ),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }

  void _showFocusSetup(BuildContext context) {
    if (_timer != null) {
      // If already focusing, show a stop option
      _showStopFocusDialog(context);
      return;
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (modalContext) => FocusChoiceModal(
        onSelected: (activity) async {
          final messenger = ScaffoldMessenger.of(context);
          try {
            await SoundService().playForActivity(activity);
            if (!mounted) return;
            setState(() {
              _startTimer();
            });
          } catch (e) {
            if (!mounted) return;
            messenger.showSnackBar(
              SnackBar(
                content: Text(
                  'Focus sound failed to load. Please check your connection and try again.',
                ),
                backgroundColor: Colors.red[900],
              ),
            );
          }
        },
      ),
    );
  }

  void _startTimer() {
    _timer?.cancel();
    _remainingSeconds = 25 * 60;
    _totalSeconds = 25 * 60;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        setState(() {
          _remainingSeconds--;
        });
      } else {
        _stopTimer();
        // Maybe play a completion sound
      }
    });
  }

  void _stopTimer() {
    _timer?.cancel();
    _timer = null;
    setState(() {
      _remainingSeconds = 25 * 60; // Reset or keep at 0? Let's reset for now.
    });
  }

  void _showStopFocusDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1D1B26),
        title: const Text(
          'End Focus Session?',
          style: TextStyle(color: Colors.white),
        ),
        content: Text(
          SoundService().currentActivity != null
              ? 'Do you want to stop the ${SoundService().currentActivity?.label} sounds?'
              : 'Do you want to end your focus session?',
          style: TextStyle(color: Colors.grey[400]),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Keep Focusing'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                SoundService().stop();
                _stopTimer();
              });
              Navigator.pop(context);
            },
            child: const Text(
              'Stop',
              style: TextStyle(color: Color(0xFFE11D48)),
            ),
          ),
        ],
      ),
    );
  }

  void _showUrgeOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF14111C),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (sheetContext) => Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Choose your path',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'How can we support you right now?',
              style: TextStyle(color: Colors.grey[400], fontSize: 14),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            _buildOptionCard(
              context,
              'Reflect & Breathe',
              'Break the habit with 10 seconds of pause.',
              Icons.spa_outlined,
              const Color(0xFF8B3DFF),
              () {
                Navigator.pop(sheetContext);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (routeContext) => ReflectionDelayPage(
                      appName: _getRandomReflectionPrompt(),
                      onAccepted: () {
                        Navigator.pop(routeContext);
                        // Chain into a Controlled Break automatically for safety
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const ControlledBreakPage(
                              appName: 'Social Media',
                            ),
                          ),
                        );
                      },
                      onRejected: () {
                        Navigator.pop(routeContext);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(_getRandomVictoryMessage()),
                            backgroundColor: const Color(0xFF8B3DFF),
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            _buildOptionCard(
              context,
              'Controlled Break',
              'Set a timer for a quick, nagging-assisted visit.',
              Icons.timer_outlined,
              const Color(0xFF6366F1),
              () {
                Navigator.pop(sheetContext);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        const ControlledBreakPage(appName: 'Distractions'),
                  ),
                );
              },
            ),
            const SizedBox(height: 24),
          ],
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
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF1D1B26),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withValues(alpha: 0.3)),
        ),
        child: Row(
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
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
            const Icon(Icons.chevron_right, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${duration.inHours > 0 ? '${duration.inHours}:' : ''}$twoDigitMinutes:$twoDigitSeconds";
  }

  String _formatSeconds(int totalSeconds) {
    int minutes = totalSeconds ~/ 60;
    int seconds = totalSeconds % 60;
    String minStr = minutes.toString().padLeft(2, '0');
    String secStr = seconds.toString().padLeft(2, '0');
    return '$minStr:$secStr';
  }

  String _getRandomVictoryMessage() {
    final messages = [
      'Identity Boost: The Monk chose wisdom over habit! +1 Focus',
      'The urge was strong, but your purpose was stronger. Stay sharp.',
      'Victory! You just reclaimed 15 minutes of your future self\'s time.',
      'That deep work muscle just got a little bit stronger. Keep going!',
      'Level Up: Discipline is a choice, and you just made the right one.',
      'Silence the noise. Reclaim your focus. Great job, Monk.',
      'Habit broken. Focus restored. This is how you win the day.',
    ];
    return (messages..shuffle()).first;
  }

  String _getRandomReflectionPrompt() {
    final prompts = [
      'Is this a choice or a habit?',
      'Will this help you become the person you want to be?',
      'Are you opening this to solve a problem or to escape one?',
      'If you open this, will you regret it in 15 minutes?',
      'Your focus is your most valuable asset. Don\'t trade it for cheap dopamine.',
    ];
    return (prompts..shuffle()).first;
  }

  String _getScarcityMetric() {
    if (_timer == null) {
      return 'Ready to reclaim your time';
    }
    // Assume 16 hour waking day = 57600 seconds
    final percent = (_remainingSeconds / 57600) * 100;
    return 'This session is ${percent.toStringAsFixed(1)}% of your waking day';
  }

  String _getTimerMicroCopy() {
    if (_timer == null) {
      return 'The average person checks their phone 58 times a day. Break the cycle.';
    }
    final messages = [
      'Protecting your future self...',
      'Every second here is a second invested in your excellence.',
      'The cost of distraction is a life unlived. Stay grounded.',
      'You are building a monk-like mind, one heartbeat at a time.',
      'Silence the noise. Your purpose is louder.',
      'Deep work is not a task. It is a state of being.',
    ];
    // We can use the remaining seconds to rotate message every 5 minutes
    final index = (_remainingSeconds ~/ (5 * 60)) % messages.length;
    return messages[index];
  }
}

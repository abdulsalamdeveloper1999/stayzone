import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import '../../../core/di/injection.dart';
import '../../../core/services/notification_service.dart';

@RoutePage()
class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  bool _naggingEnabled = false;
  final _notificationService = getIt<NotificationService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0C14),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D0C14),
        title: const Text(
          'Notifications',
          style: TextStyle(color: Colors.white),
        ),
        leading: const AutoLeadingButton(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildSettingsGroup(
              children: [
                _buildSwitchTile(
                  title: 'Focus Nags',
                  subtitle: 'Get reminders to stay focused when distracted',
                  value: _naggingEnabled,
                  onChanged: (value) {
                    setState(() {
                      _naggingEnabled = value;
                    });
                    if (value) {
                      _notificationService.scheduleNaggingNotifications(
                        appName: 'StayZone',
                        delayMinutes: 2,
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Focus Nags enabled (starts in 2m)'),
                        ),
                      );
                    } else {
                      _notificationService.cancelAll();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Focus Nags disabled')),
                      );
                    }
                  },
                  icon: CupertinoIcons.bell_fill,
                  iconColor: Colors.orange,
                ),
              ],
            ),
            const SizedBox(height: 24),
            _buildSettingsGroup(
              children: [
                _buildActionTile(
                  title: 'Test Notification',
                  onTap: () async {
                    await _notificationService.showImmediateNotification(
                      title: 'Test Notification',
                      body: 'This is a test to verify notifications work.',
                    );
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Notification sent!')),
                      );
                    }
                  },
                  icon: CupertinoIcons.play_fill,
                  iconColor: Colors.blue,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsGroup({required List<Widget> children}) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1D1B26),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(children: children),
    );
  }

  Widget _buildSwitchTile({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
    required IconData icon,
    required Color iconColor,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: iconColor,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Center(child: Icon(icon, color: Colors.white, size: 20)),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
          ),
          CupertinoSwitch(
            value: value,
            onChanged: onChanged,
            activeColor: const Color(0xFF8B3DFF),
          ),
        ],
      ),
    );
  }

  Widget _buildActionTile({
    required String title,
    required VoidCallback onTap,
    required IconData icon,
    required Color iconColor,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: iconColor,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Center(child: Icon(icon, color: Colors.white, size: 20)),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
              const Icon(
                CupertinoIcons.chevron_right,
                color: Colors.grey,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

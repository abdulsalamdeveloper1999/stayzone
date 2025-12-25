import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/services/notification_service.dart';
import '../../../core/services/break_service.dart';

class ControlledBreakPage extends StatefulWidget {
  final String appName;
  final String? appPackage; // For Android
  final String? appUrlScheme; // For iOS

  const ControlledBreakPage({
    super.key,
    required this.appName,
    this.appPackage,
    this.appUrlScheme,
  });

  @override
  State<ControlledBreakPage> createState() => _ControlledBreakPageState();
}

class _ControlledBreakPageState extends State<ControlledBreakPage> {
  int _selectedMinutes = 5;
  final List<int> _durations = [1, 5, 10, 15, 20];

  String? _selectedApp;

  final Map<String, String> _appSchemes = {
    'Instagram': 'instagram://',
    'Facebook': 'fb://',
    'YouTube': 'youtube://',
    'Gmail': 'googlegmail://',
    'TikTok': 'tiktok://',
    'X (Twitter)': 'twitter://',
  };

  final Map<String, IconData> _appIcons = {
    'Instagram': Icons.camera_alt_outlined,
    'Facebook': Icons.facebook,
    'YouTube': Icons.play_circle_outline,
    'Gmail': Icons.mail_outline,
    'TikTok': Icons.music_note_outlined,
    'X (Twitter)': Icons.close,
  };

  Future<void> _startBreak() async {
    final appName = _selectedApp ?? widget.appName;

    // Schedule nagging notifications
    await NotificationService().scheduleNaggingNotifications(
      appName: appName,
      delayMinutes: _selectedMinutes,
    );

    // Track the break
    BreakService().startControlledBreak();

    // Try to launch the specific app
    try {
      if (_selectedApp != null && _appSchemes.containsKey(_selectedApp)) {
        final url = Uri.parse(_appSchemes[_selectedApp]!);
        if (await canLaunchUrl(url)) {
          await launchUrl(url);
        } else {
          // Fallback for some common apps or just show message
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Could not launch $appName. Please open it manually.',
              ),
            ),
          );
        }
      }
    } catch (e) {
      // Ignored
    }

    if (!mounted) return;
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Break Mode'),
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(
                Icons.timer_outlined,
                color: Color(0xFF8B3DFF),
                size: 64,
              ),
              const SizedBox(height: 24),
              Text(
                'Ready for a break?',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'We will send nagging notifications to pull you back after your selected time expires.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 14,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 48),
              Text(
                'Where are you going?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 100,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: _appSchemes.keys.map((app) {
                    final isSelected = _selectedApp == app;
                    return GestureDetector(
                      onTap: () => setState(() => _selectedApp = app),
                      child: Container(
                        width: 80,
                        margin: const EdgeInsets.only(right: 12),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? const Color(0xFF8B3DFF).withOpacity(0.2)
                              : const Color(0xFF1D1B26),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: isSelected
                                ? const Color(0xFF8B3DFF)
                                : Colors.white.withOpacity(0.05),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              _appIcons[app],
                              color: isSelected
                                  ? const Color(0xFF8B3DFF)
                                  : Colors.grey[400],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              app.split(' ')[0],
                              style: TextStyle(
                                fontSize: 10,
                                color: isSelected
                                    ? Colors.white
                                    : Colors.grey[500],
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 48),
              Text(
                'For how long?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 16),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 12,
                runSpacing: 12,
                children: _durations.map((mins) {
                  final isSelected = _selectedMinutes == mins;
                  return GestureDetector(
                    onTap: () => setState(() => _selectedMinutes = mins),
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color(0xFF8B3DFF)
                            : const Color(0xFF1D1B26),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isSelected
                              ? const Color(0xFF8B3DFF)
                              : Colors.white.withOpacity(0.05),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          '$mins',
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.grey[400],
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: _selectedApp == null ? null : _startBreak,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 56),
                ),
                child: Text(
                  _selectedApp == null
                      ? 'Select an app'
                      : 'Launch $_selectedApp',
                ),
              ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'Maybe not now',
                  style: TextStyle(color: Colors.grey[500]),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

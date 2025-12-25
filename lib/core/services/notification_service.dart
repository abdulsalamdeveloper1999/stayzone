import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    tz.initializeTimeZones();

    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings iosSettings =
        DarwinInitializationSettings(
          requestAlertPermission: true,
          requestBadgePermission: true,
          requestSoundPermission: true,
        );

    const InitializationSettings initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _notificationsPlugin.initialize(
      initSettings,
      onDidReceiveNotificationResponse: (details) {
        // Handle notification tap
      },
    );
  }

  Future<void> scheduleNaggingNotifications({
    required String appName,
    required int delayMinutes,
  }) async {
    // Clear any existing nags
    await _notificationsPlugin.cancelAll();

    final List<Map<String, String>> nagMessages = [
      {
        'title': 'The Steve Jobs Rule',
        'body': '"Focusing is about saying NO to a hundred other good ideas."',
      },
      {
        'title': 'Bill Gates\' Secret',
        'body': '"Focus. It\'s the one word behind every great success."',
      },
      {
        'title': 'The Naval Superpower',
        'body':
            '"A focused mind is one of the greatest superpowers in the world."',
      },
      {
        'title': 'Sam Altman\'s Tolerance',
        'body':
            '"The most successful people have a high tolerance for boredom."',
      },
      {
        'title': 'Greg McKeown\'s Law',
        'body': '"If you don\'t prioritize your life, someone else will."',
      },
    ];

    // Schedule a few nags at intervals
    for (int i = 0; i < nagMessages.length; i++) {
      final scheduleTime = tz.TZDateTime.now(tz.local).add(
        Duration(minutes: delayMinutes + (i * 2)), // Progressive interval
      );

      await _notificationsPlugin.zonedSchedule(
        i,
        nagMessages[i]['title']!,
        nagMessages[i]['body']!,
        scheduleTime,
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'nag_channel',
            'Nagging Notifications',
            importance: Importance.max,
            priority: Priority.high,
            fullScreenIntent: true,
            playSound: true,
            enableVibration: true,
          ),
          iOS: DarwinNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
          ),
        ),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      );
    }
  }

  Future<void> cancelAll() async {
    await _notificationsPlugin.cancelAll();
  }
}

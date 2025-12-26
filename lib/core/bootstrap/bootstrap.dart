import 'package:flutter/material.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../app/app.dart';
import '../di/injection.dart';
import '../services/notification_service.dart';

Future<void> bootstrap() async {
  WidgetsFlutterBinding.ensureInitialized();

  await _initializeDependencies();
  await _initializeEnv();
  await _initializeSupabase();
  await NotificationService().init();

  runApp(const App());
}

Future<void> _initializeDependencies() async {
  await configureDependencies();
}

Future<void> _initializeEnv() async {
  await dotenv.load(fileName: ".env");
}

Future<void> _initializeSupabase() async {
  final url = dotenv.env['SUPABASE_URL'];
  final anonKey = dotenv.env['SUPABASE_ANON_KEY'];

  if (url == null || anonKey == null) {
    debugPrint('Supabase credentials not found in .env file');
    return;
  }

  await Supabase.initialize(url: url, anonKey: anonKey);
}

import 'package:flutter/material.dart';

import '../../app/app.dart';
import '../di/injection.dart';
import '../services/notification_service.dart';

Future<void> bootstrap() async {
  WidgetsFlutterBinding.ensureInitialized();

  await _initializeDependencies();
  await _initializeSupabase();
  await NotificationService().init();

  runApp(const App());
}

Future<void> _initializeDependencies() async {
  await configureDependencies();
}

Future<void> _initializeSupabase() async {
  // TODO: Add your Supabase URL and anon key
  // import 'package:supabase_flutter/supabase_flutter.dart';
  // await Supabase.initialize(
  //   url: 'YOUR_SUPABASE_URL',
  //   anonKey: 'YOUR_SUPABASE_ANON_KEY',
  // );
}

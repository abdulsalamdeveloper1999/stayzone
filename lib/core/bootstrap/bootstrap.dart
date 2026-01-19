import 'dart:io';
import 'package:flutter/material.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../app/app.dart';
import '../di/injection.dart';
import '../services/notification_service.dart';

Future<void> bootstrap() async {
  WidgetsFlutterBinding.ensureInitialized();

  await _initializeDependencies();
  await _initializeEnv();
  await _initializeSupabase();
  await _initializeRevenueCat();
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

Future<void> _initializeRevenueCat() async {
  final apiKey = Platform.isIOS
      ? dotenv.env['REVENUECAT_API_KEY_IOS']
      : dotenv.env['REVENUECAT_API_KEY_ANDROID'];

  if (apiKey == null ||
      apiKey == 'your_ios_key_here' ||
      apiKey == 'your_android_key_here') {
    debugPrint('RevenueCat API key not configured in .env file');
    return;
  }

  await Purchases.setLogLevel(LogLevel.debug);
  final config = PurchasesConfiguration(apiKey);
  await Purchases.configure(config);
}

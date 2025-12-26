import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/signup_page.dart';
import '../../features/main/pages/main_page.dart';
import '../../features/settings/pages/edit_profile_page.dart';
import '../../features/settings/pages/notifications_page.dart';
import 'auth_guard.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends _$AppRouter {
  final SupabaseClient supabaseClient;

  AppRouter(this.supabaseClient);

  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      page: MainRoute.page,
      path: '/',
      guards: [AuthGuard(supabaseClient)],
      initial: true,
    ),
    AutoRoute(page: LoginRoute.page, path: '/login'),
    AutoRoute(page: SignUpRoute.page, path: '/signup'),
    AutoRoute(page: EditProfileRoute.page, path: '/edit-profile'),
    AutoRoute(page: NotificationsRoute.page, path: '/notifications'),
  ];
}

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:aether_focus/features/sessions/pages/sessions_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/signup_page.dart';
import '../../features/onboarding/pages/welcome_onboarding_page.dart';
import '../../features/onboarding/pages/preferences_setup_page.dart';
import '../../features/main/pages/main_page.dart';
import '../../features/settings/pages/edit_profile_page.dart';
import '../../features/settings/pages/notifications_page.dart';
import '../../features/interventions/pages/controlled_break_page.dart';
import '../../features/interventions/pages/reflection_delay_page.dart';
import '../../features/urges/presentation/pages/achievements_page.dart';
import '../../features/urges/presentation/pages/breathing_page.dart';
import '../../features/heatmap/pages/heatmap_page.dart';
import '../../features/subscription/domain/usecases/has_premium_access.dart';
import '../../features/subscription/presentation/pages/paywall_page.dart';
import 'auth_guard.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends _$AppRouter {
  final SupabaseClient supabaseClient;
  final SharedPreferences prefs;
  final HasPremiumAccess hasPremiumAccess;

  AppRouter(this.supabaseClient, this.prefs, this.hasPremiumAccess);

  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      page: MainRoute.page,
      path: '/',
      guards: [AuthGuard(supabaseClient, prefs, hasPremiumAccess)],
      initial: true,
    ),
    AutoRoute(page: WelcomeOnboardingRoute.page, path: '/welcome'),
    AutoRoute(page: PreferencesSetupRoute.page, path: '/preferences-setup'),
    AutoRoute(page: LoginRoute.page, path: '/login'),
    AutoRoute(page: SignUpRoute.page, path: '/signup'),
    AutoRoute(page: PaywallRoute.page, path: '/paywall'),
    AutoRoute(page: EditProfileRoute.page, path: '/edit-profile'),
    AutoRoute(page: NotificationsRoute.page, path: '/notifications'),
    AutoRoute(page: ControlledBreakRoute.page, path: '/controlled-break'),
    AutoRoute(page: ReflectionDelayRoute.page, path: '/reflection-delay'),
    AutoRoute(page: AchievementsRoute.page, path: '/achievements'),
    AutoRoute(page: BreathingRoute.page, path: '/breathing'),
    AutoRoute(page: HeatmapRoute.page, path: '/heatmap'),
  ];
}

import 'package:auto_route/auto_route.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:aether_focus/core/routes/app_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:aether_focus/core/usecases/usecase.dart';
import '../../features/subscription/domain/usecases/has_premium_access.dart';

class AuthGuard extends AutoRouteGuard {
  final SupabaseClient client;
  final SharedPreferences prefs;
  final HasPremiumAccess hasPremiumAccess;

  AuthGuard(this.client, this.prefs, this.hasPremiumAccess);

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) async {
    bool welcomeSeen = prefs.getBool('welcome_seen') ?? false;

    if (!welcomeSeen) {
      resolver.redirect(const WelcomeOnboardingRoute());
      return;
    }

    if (client.auth.currentSession == null) {
      resolver.redirect(const LoginRoute());
      return;
    }

    // User is logged in. Check specific entitlement if not already going to Paywall.
    if (resolver.route.name == PaywallRoute.name) {
      resolver.next(true);
      return;
    }

    // Check Entitlement
    final result = await hasPremiumAccess(NoParams());
    final isPremium = result.fold((_) => false, (isPremium) => isPremium);

    if (isPremium) {
      resolver.next(true);
    } else {
      // Allow 7-day trial users logic?
      // RevenueCat SHOULD return isPremium=true if they are in trial and it's active entitlement.
      // So simple check is enough.
      resolver.redirect(const PaywallRoute());
    }
  }
}

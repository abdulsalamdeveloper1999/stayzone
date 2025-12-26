import 'package:auto_route/auto_route.dart';
import 'package:stayzone/core/routes/app_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthGuard extends AutoRouteGuard {
  final SupabaseClient client;

  AuthGuard(this.client);

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    if (client.auth.currentSession != null) {
      resolver.next(true);
    } else {
      resolver.redirect(const LoginRoute());
    }
  }
}

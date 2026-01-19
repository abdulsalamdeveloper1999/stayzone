import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../core/routes/app_router.dart';
import '../core/di/injection.dart';
import '../features/auth/presentation/bloc/auth_bloc.dart';
import '../features/home/presentation/cubit/home_cubit.dart';
import '../features/subscription/domain/usecases/has_premium_access.dart';
import '../features/subscription/presentation/cubit/subscription_cubit.dart';
import '../core/theme/app_theme.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late final AppRouter _appRouter;

  @override
  void initState() {
    super.initState();
    // SupabaseClient is registered in injection.dart, which is bootstrapped before App runs.
    _appRouter = AppRouter(
      getIt<SupabaseClient>(),
      getIt<SharedPreferences>(),
      getIt<HasPremiumAccess>(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => getIt<AuthBloc>()..add(AuthCheckRequested()),
            ),
            BlocProvider(create: (context) => getIt<HomeCubit>()),
            BlocProvider(create: (context) => getIt<SubscriptionCubit>()),
          ],
          child: MaterialApp.router(
            title: 'StayZone',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.deepBlackTheme,
            darkTheme: AppTheme.deepBlackTheme,
            themeMode: ThemeMode.dark,
            routerConfig: _appRouter.config(),
          ),
        );
      },
    );
  }
}

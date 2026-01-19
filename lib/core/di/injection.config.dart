// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;
import 'package:aether_focus/core/di/register_module.dart' as _i485;
import 'package:aether_focus/core/services/insight_service.dart' as _i908;
import 'package:aether_focus/core/services/notification_service.dart' as _i621;
import 'package:aether_focus/features/auth/data/datasources/auth_remote_data_source.dart'
    as _i3;
import 'package:aether_focus/features/auth/data/repositories/auth_repository_impl.dart'
    as _i234;
import 'package:aether_focus/features/auth/domain/repositories/auth_repository.dart'
    as _i685;
import 'package:aether_focus/features/auth/domain/usecases/delete_account_usecase.dart'
    as _i384;
import 'package:aether_focus/features/auth/domain/usecases/get_current_user_usecase.dart'
    as _i1072;
import 'package:aether_focus/features/auth/domain/usecases/sign_in_usecase.dart'
    as _i877;
import 'package:aether_focus/features/auth/domain/usecases/sign_out_usecase.dart'
    as _i855;
import 'package:aether_focus/features/auth/domain/usecases/sign_up_usecase.dart'
    as _i831;
import 'package:aether_focus/features/auth/presentation/bloc/auth_bloc.dart'
    as _i944;
import 'package:aether_focus/features/focus/data/datasources/focus_remote_data_source.dart'
    as _i186;
import 'package:aether_focus/features/focus/data/repositories/focus_repository_impl.dart'
    as _i673;
import 'package:aether_focus/features/focus/domain/repositories/focus_repository.dart'
    as _i114;
import 'package:aether_focus/features/focus/domain/usecases/complete_focus_session.dart'
    as _i811;
import 'package:aether_focus/features/focus/domain/usecases/create_focus_session.dart'
    as _i891;
import 'package:aether_focus/features/focus/domain/usecases/get_focus_history.dart'
    as _i768;
import 'package:aether_focus/features/focus/domain/usecases/get_monk_stats.dart'
    as _i1025;
import 'package:aether_focus/features/focus/domain/usecases/get_today_stats.dart'
    as _i1053;
import 'package:aether_focus/features/focus/domain/usecases/get_user_streak.dart'
    as _i663;
import 'package:aether_focus/features/heatmap/presentation/cubit/heatmap_cubit.dart'
    as _i511;
import 'package:aether_focus/features/home/presentation/cubit/home_cubit.dart'
    as _i47;
import 'package:aether_focus/features/sessions/presentation/cubit/sessions_cubit.dart'
    as _i171;
import 'package:aether_focus/features/settings/domain/usecases/update_user_usecase.dart'
    as _i889;
import 'package:aether_focus/features/subscription/data/datasources/subscription_remote_data_source.dart'
    as _i706;
import 'package:aether_focus/features/subscription/data/repositories/subscription_repository_impl.dart'
    as _i538;
import 'package:aether_focus/features/subscription/domain/repositories/subscription_repository.dart'
    as _i16;
import 'package:aether_focus/features/subscription/domain/usecases/get_subscription_status.dart'
    as _i753;
import 'package:aether_focus/features/subscription/domain/usecases/has_premium_access.dart'
    as _i882;
import 'package:aether_focus/features/subscription/domain/usecases/purchase_subscription.dart'
    as _i995;
import 'package:aether_focus/features/subscription/domain/usecases/restore_purchases.dart'
    as _i246;
import 'package:aether_focus/features/subscription/presentation/cubit/subscription_cubit.dart'
    as _i156;
import 'package:aether_focus/features/urges/data/datasources/urge_remote_data_source.dart'
    as _i172;
import 'package:aether_focus/features/urges/data/repositories/urge_repository_impl.dart'
    as _i996;
import 'package:aether_focus/features/urges/domain/repositories/urge_repository.dart'
    as _i777;
import 'package:aether_focus/features/urges/domain/usecases/get_today_urges_count.dart'
    as _i348;
import 'package:aether_focus/features/urges/domain/usecases/get_urge_history.dart'
    as _i353;
import 'package:aether_focus/features/urges/domain/usecases/report_urge.dart'
    as _i485;
import 'package:supabase_flutter/supabase_flutter.dart' as _i454;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => registerModule.prefs,
      preResolve: true,
    );
    gh.lazySingleton<_i454.SupabaseClient>(() => registerModule.supabaseClient);
    gh.lazySingleton<_i621.NotificationService>(
      () => registerModule.notificationService,
    );
    gh.lazySingleton<_i908.InsightService>(() => _i908.InsightService());
    gh.lazySingleton<_i3.AuthRemoteDataSource>(
      () => _i3.AuthRemoteDataSourceImpl(gh<_i454.SupabaseClient>()),
    );
    gh.lazySingleton<_i186.FocusRemoteDataSource>(
      () => _i186.FocusRemoteDataSourceImpl(gh<_i454.SupabaseClient>()),
    );
    gh.lazySingleton<_i172.UrgeRemoteDataSource>(
      () => _i172.UrgeRemoteDataSourceImpl(gh<_i454.SupabaseClient>()),
    );
    gh.lazySingleton<_i706.SubscriptionRemoteDataSource>(
      () => _i706.SubscriptionRemoteDataSourceImpl(gh<_i454.SupabaseClient>()),
    );
    gh.lazySingleton<_i114.FocusRepository>(
      () => _i673.FocusRepositoryImpl(gh<_i186.FocusRemoteDataSource>()),
    );
    gh.lazySingleton<_i685.AuthRepository>(
      () => _i234.AuthRepositoryImpl(gh<_i3.AuthRemoteDataSource>()),
    );
    gh.lazySingleton<_i811.CompleteFocusSession>(
      () => _i811.CompleteFocusSession(gh<_i114.FocusRepository>()),
    );
    gh.lazySingleton<_i891.CreateFocusSession>(
      () => _i891.CreateFocusSession(gh<_i114.FocusRepository>()),
    );
    gh.lazySingleton<_i768.GetFocusHistory>(
      () => _i768.GetFocusHistory(gh<_i114.FocusRepository>()),
    );
    gh.lazySingleton<_i1025.GetMonkStats>(
      () => _i1025.GetMonkStats(gh<_i114.FocusRepository>()),
    );
    gh.lazySingleton<_i1053.GetTodayStats>(
      () => _i1053.GetTodayStats(gh<_i114.FocusRepository>()),
    );
    gh.lazySingleton<_i663.GetUserStreak>(
      () => _i663.GetUserStreak(gh<_i114.FocusRepository>()),
    );
    gh.lazySingleton<_i777.UrgeRepository>(
      () => _i996.UrgeRepositoryImpl(gh<_i172.UrgeRemoteDataSource>()),
    );
    gh.lazySingleton<_i16.SubscriptionRepository>(
      () => _i538.SubscriptionRepositoryImpl(
        gh<_i706.SubscriptionRemoteDataSource>(),
      ),
    );
    gh.factory<_i511.HeatmapCubit>(
      () => _i511.HeatmapCubit(gh<_i768.GetFocusHistory>()),
    );
    gh.factory<_i171.SessionsCubit>(
      () => _i171.SessionsCubit(gh<_i768.GetFocusHistory>()),
    );
    gh.lazySingleton<_i348.GetTodayUrgesCount>(
      () => _i348.GetTodayUrgesCount(gh<_i777.UrgeRepository>()),
    );
    gh.lazySingleton<_i353.GetUrgeHistory>(
      () => _i353.GetUrgeHistory(gh<_i777.UrgeRepository>()),
    );
    gh.lazySingleton<_i485.ReportUrge>(
      () => _i485.ReportUrge(gh<_i777.UrgeRepository>()),
    );
    gh.lazySingleton<_i384.DeleteAccount>(
      () => _i384.DeleteAccount(gh<_i685.AuthRepository>()),
    );
    gh.lazySingleton<_i1072.GetCurrentUser>(
      () => _i1072.GetCurrentUser(gh<_i685.AuthRepository>()),
    );
    gh.lazySingleton<_i877.SignInUsingEmail>(
      () => _i877.SignInUsingEmail(gh<_i685.AuthRepository>()),
    );
    gh.lazySingleton<_i855.SignOut>(
      () => _i855.SignOut(gh<_i685.AuthRepository>()),
    );
    gh.lazySingleton<_i831.SignUpUsingEmail>(
      () => _i831.SignUpUsingEmail(gh<_i685.AuthRepository>()),
    );
    gh.lazySingleton<_i889.UpdateUser>(
      () => _i889.UpdateUser(gh<_i685.AuthRepository>()),
    );
    gh.factory<_i753.GetSubscriptionStatus>(
      () => _i753.GetSubscriptionStatus(gh<_i16.SubscriptionRepository>()),
    );
    gh.factory<_i882.HasPremiumAccess>(
      () => _i882.HasPremiumAccess(gh<_i16.SubscriptionRepository>()),
    );
    gh.factory<_i995.PurchaseSubscription>(
      () => _i995.PurchaseSubscription(gh<_i16.SubscriptionRepository>()),
    );
    gh.factory<_i246.RestorePurchases>(
      () => _i246.RestorePurchases(gh<_i16.SubscriptionRepository>()),
    );
    gh.factory<_i156.SubscriptionCubit>(
      () => _i156.SubscriptionCubit(
        gh<_i753.GetSubscriptionStatus>(),
        gh<_i882.HasPremiumAccess>(),
        gh<_i995.PurchaseSubscription>(),
        gh<_i246.RestorePurchases>(),
        gh<_i16.SubscriptionRepository>(),
      ),
    );
    gh.factory<_i47.HomeCubit>(
      () => _i47.HomeCubit(
        gh<_i891.CreateFocusSession>(),
        gh<_i811.CompleteFocusSession>(),
        gh<_i1053.GetTodayStats>(),
        gh<_i663.GetUserStreak>(),
        gh<_i348.GetTodayUrgesCount>(),
        gh<_i768.GetFocusHistory>(),
        gh<_i353.GetUrgeHistory>(),
        gh<_i1025.GetMonkStats>(),
        gh<_i485.ReportUrge>(),
        gh<_i908.InsightService>(),
      ),
    );
    gh.lazySingleton<_i944.AuthBloc>(
      () => _i944.AuthBloc(
        signInUsingEmail: gh<_i877.SignInUsingEmail>(),
        signUpUsingEmail: gh<_i831.SignUpUsingEmail>(),
        signOut: gh<_i855.SignOut>(),
        getCurrentUser: gh<_i1072.GetCurrentUser>(),
        updateUser: gh<_i889.UpdateUser>(),
        deleteAccount: gh<_i384.DeleteAccount>(),
      ),
    );
    return this;
  }
}

class _$RegisterModule extends _i485.RegisterModule {}

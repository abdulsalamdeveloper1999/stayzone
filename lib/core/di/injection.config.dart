// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:stayzone/core/di/register_module.dart' as _i485;
import 'package:stayzone/core/services/notification_service.dart' as _i621;
import 'package:stayzone/features/auth/data/datasources/auth_remote_data_source.dart'
    as _i3;
import 'package:stayzone/features/auth/data/repositories/auth_repository_impl.dart'
    as _i234;
import 'package:stayzone/features/auth/domain/repositories/auth_repository.dart'
    as _i685;
import 'package:stayzone/features/auth/domain/usecases/delete_account_usecase.dart'
    as _i384;
import 'package:stayzone/features/auth/domain/usecases/get_current_user_usecase.dart'
    as _i1072;
import 'package:stayzone/features/auth/domain/usecases/sign_in_usecase.dart'
    as _i877;
import 'package:stayzone/features/auth/domain/usecases/sign_out_usecase.dart'
    as _i855;
import 'package:stayzone/features/auth/domain/usecases/sign_up_usecase.dart'
    as _i831;
import 'package:stayzone/features/auth/presentation/bloc/auth_bloc.dart'
    as _i944;
import 'package:stayzone/features/focus/data/datasources/focus_remote_data_source.dart'
    as _i186;
import 'package:stayzone/features/focus/data/repositories/focus_repository_impl.dart'
    as _i673;
import 'package:stayzone/features/focus/domain/repositories/focus_repository.dart'
    as _i114;
import 'package:stayzone/features/focus/domain/usecases/complete_focus_session.dart'
    as _i811;
import 'package:stayzone/features/focus/domain/usecases/create_focus_session.dart'
    as _i891;
import 'package:stayzone/features/focus/domain/usecases/get_today_stats.dart'
    as _i1053;
import 'package:stayzone/features/focus/domain/usecases/get_user_streak.dart'
    as _i663;
import 'package:stayzone/features/settings/domain/usecases/update_user_usecase.dart'
    as _i889;
import 'package:stayzone/features/urges/data/datasources/urge_remote_data_source.dart'
    as _i172;
import 'package:stayzone/features/urges/data/repositories/urge_repository_impl.dart'
    as _i996;
import 'package:stayzone/features/urges/domain/repositories/urge_repository.dart'
    as _i777;
import 'package:stayzone/features/urges/domain/usecases/get_today_urges_count.dart'
    as _i348;
import 'package:stayzone/features/urges/domain/usecases/report_urge.dart'
    as _i485;
import 'package:supabase_flutter/supabase_flutter.dart' as _i454;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final registerModule = _$RegisterModule();
    gh.lazySingleton<_i454.SupabaseClient>(() => registerModule.supabaseClient);
    gh.lazySingleton<_i621.NotificationService>(
        () => registerModule.notificationService);
    gh.lazySingleton<_i3.AuthRemoteDataSource>(
        () => _i3.AuthRemoteDataSourceImpl(gh<_i454.SupabaseClient>()));
    gh.lazySingleton<_i186.FocusRemoteDataSource>(
        () => _i186.FocusRemoteDataSourceImpl(gh<_i454.SupabaseClient>()));
    gh.lazySingleton<_i172.UrgeRemoteDataSource>(
        () => _i172.UrgeRemoteDataSourceImpl(gh<_i454.SupabaseClient>()));
    gh.lazySingleton<_i114.FocusRepository>(
        () => _i673.FocusRepositoryImpl(gh<_i186.FocusRemoteDataSource>()));
    gh.lazySingleton<_i685.AuthRepository>(
        () => _i234.AuthRepositoryImpl(gh<_i3.AuthRemoteDataSource>()));
    gh.lazySingleton<_i811.CompleteFocusSession>(
        () => _i811.CompleteFocusSession(gh<_i114.FocusRepository>()));
    gh.lazySingleton<_i891.CreateFocusSession>(
        () => _i891.CreateFocusSession(gh<_i114.FocusRepository>()));
    gh.lazySingleton<_i1053.GetTodayStats>(
        () => _i1053.GetTodayStats(gh<_i114.FocusRepository>()));
    gh.lazySingleton<_i663.GetUserStreak>(
        () => _i663.GetUserStreak(gh<_i114.FocusRepository>()));
    gh.lazySingleton<_i777.UrgeRepository>(
        () => _i996.UrgeRepositoryImpl(gh<_i172.UrgeRemoteDataSource>()));
    gh.lazySingleton<_i348.GetTodayUrgesCount>(
        () => _i348.GetTodayUrgesCount(gh<_i777.UrgeRepository>()));
    gh.lazySingleton<_i485.ReportUrge>(
        () => _i485.ReportUrge(gh<_i777.UrgeRepository>()));
    gh.lazySingleton<_i1072.GetCurrentUser>(
        () => _i1072.GetCurrentUser(gh<_i685.AuthRepository>()));
    gh.lazySingleton<_i877.SignInUsingEmail>(
        () => _i877.SignInUsingEmail(gh<_i685.AuthRepository>()));
    gh.lazySingleton<_i855.SignOut>(
        () => _i855.SignOut(gh<_i685.AuthRepository>()));
    gh.lazySingleton<_i831.SignUpUsingEmail>(
        () => _i831.SignUpUsingEmail(gh<_i685.AuthRepository>()));
    gh.lazySingleton<_i889.UpdateUser>(
        () => _i889.UpdateUser(gh<_i685.AuthRepository>()));
    gh.lazySingleton<_i384.DeleteAccount>(
        () => _i384.DeleteAccount(gh<_i685.AuthRepository>()));
    gh.factory<_i944.AuthBloc>(() => _i944.AuthBloc(
          signInUsingEmail: gh<_i877.SignInUsingEmail>(),
          signUpUsingEmail: gh<_i831.SignUpUsingEmail>(),
          signOut: gh<_i855.SignOut>(),
          getCurrentUser: gh<_i1072.GetCurrentUser>(),
          updateUser: gh<_i889.UpdateUser>(),
          deleteAccount: gh<_i384.DeleteAccount>(),
        ));
    return this;
  }
}

class _$RegisterModule extends _i485.RegisterModule {}

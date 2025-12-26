import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import '../../domain/entities/user.dart';
import '../../domain/usecases/get_current_user_usecase.dart';
import '../../domain/usecases/sign_in_usecase.dart';
import '../../domain/usecases/sign_out_usecase.dart';
import '../../domain/usecases/sign_up_usecase.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../settings/domain/usecases/update_user_usecase.dart';

import 'package:injectable/injectable.dart';

import '../../domain/usecases/delete_account_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignInUsingEmail _signInUsingEmail;
  final SignUpUsingEmail _signUpUsingEmail;
  final SignOut _signOut;
  final GetCurrentUser _getCurrentUser;
  final UpdateUser _updateUser;
  final DeleteAccount _deleteAccount;

  AuthBloc({
    required SignInUsingEmail signInUsingEmail,
    required SignUpUsingEmail signUpUsingEmail,
    required SignOut signOut,
    required GetCurrentUser getCurrentUser,
    required UpdateUser updateUser,
    required DeleteAccount deleteAccount,
  }) : _signInUsingEmail = signInUsingEmail,
       _signUpUsingEmail = signUpUsingEmail,
       _signOut = signOut,
       _getCurrentUser = getCurrentUser,
       _updateUser = updateUser,
       _deleteAccount = deleteAccount,
       super(AuthInitial()) {
    on<AuthCheckRequested>(_onAuthCheckRequested);
    on<AuthLoginRequested>(_onAuthLoginRequested);
    on<AuthLogoutRequested>(_onAuthLogoutRequested);
    on<AuthSignUpRequested>(_onAuthSignUpRequested);
    on<AuthUpdateProfileRequested>(_onAuthUpdateProfileRequested);
    on<AuthDeleteAccountRequested>(_onAuthDeleteAccountRequested);
  }

  Future<void> _onAuthDeleteAccountRequested(
    AuthDeleteAccountRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    final res = await _deleteAccount(NoParams());
    res.fold(
      (l) => emit(AuthError(l.message)),
      (r) => emit(AuthUnauthenticated()),
    );
  }

  Future<void> _onAuthCheckRequested(
    AuthCheckRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    final res = await _getCurrentUser(NoParams());
    res.fold(
      (l) => emit(AuthUnauthenticated()),
      (r) =>
          r != null ? emit(AuthAuthenticated(r)) : emit(AuthUnauthenticated()),
    );
  }

  Future<void> _onAuthLoginRequested(
    AuthLoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    final res = await _signInUsingEmail(
      SignInParams(email: event.email, password: event.password),
    );
    res.fold(
      (l) => emit(AuthError(l.message)),
      (r) => emit(AuthAuthenticated(r)),
    );
  }

  Future<void> _onAuthSignUpRequested(
    AuthSignUpRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    final res = await _signUpUsingEmail(
      SignUpParams(
        email: event.email,
        password: event.password,
        name: event.name,
      ),
    );
    res.fold(
      (l) => emit(AuthError(l.message)),
      (r) => emit(AuthAuthenticated(r)),
    );
  }

  Future<void> _onAuthLogoutRequested(
    AuthLogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    final res = await _signOut(NoParams());
    res.fold(
      (l) => emit(AuthError(l.message)),
      (r) => emit(AuthUnauthenticated()),
    );
  }

  Future<void> _onAuthUpdateProfileRequested(
    AuthUpdateProfileRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    final res = await _updateUser(event.user);
    res.fold(
      (l) => emit(AuthError(l.message)),
      (_) => emit(AuthAuthenticated(event.user)),
    );
  }
}

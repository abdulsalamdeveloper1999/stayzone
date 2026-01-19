import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../focus/domain/usecases/get_focus_history.dart';
import 'sessions_state.dart';

@injectable
class SessionsCubit extends Cubit<SessionsState> {
  final GetFocusHistory _getFocusHistory;

  SessionsCubit(this._getFocusHistory) : super(const SessionsState());

  Future<void> loadSessions(String userId) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    final result = await _getFocusHistory(userId);

    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, errorMessage: failure.message)),
      (sessions) => emit(state.copyWith(isLoading: false, sessions: sessions)),
    );
  }

  Future<void> refreshSessions(String userId) async {
    await loadSessions(userId);
  }
}

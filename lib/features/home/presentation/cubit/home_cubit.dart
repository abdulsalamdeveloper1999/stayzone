import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/failures.dart';
import '../../../focus/domain/entities/focus_session.dart';
import '../../../focus/domain/usecases/create_focus_session.dart';
import '../../../focus/domain/usecases/complete_focus_session.dart';
import '../../../focus/domain/usecases/get_today_stats.dart';
import '../../../focus/domain/usecases/get_user_streak.dart';
import '../../../focus/domain/usecases/get_focus_history.dart';
import '../../../urges/domain/usecases/get_today_urges_count.dart';
import '../../../urges/domain/usecases/get_urge_history.dart';
import '../../../focus/domain/usecases/get_monk_stats.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../urges/domain/usecases/report_urge.dart';
import '../../../urges/domain/entities/urge_report.dart';
import '../../../../core/services/sound_service.dart';
import '../../../../core/services/insight_service.dart';
import 'home_state.dart';

@injectable
class HomeCubit extends Cubit<HomeState> {
  final CreateFocusSession _createFocusSession;
  final CompleteFocusSession _completeFocusSession;
  final GetTodayStats _getTodayStats;
  final GetUserStreak _getUserStreak;
  final GetTodayUrgesCount _getTodayUrgesCount;
  final GetFocusHistory _getFocusHistory;
  final GetUrgeHistory _getUrgeHistory;
  final GetMonkStats _getMonkStats;
  final ReportUrge _reportUrge;
  final InsightService _insightService;

  Timer? _timer;
  Timer? _statsTimer;
  String? _userId;

  HomeCubit(
    this._createFocusSession,
    this._completeFocusSession,
    this._getTodayStats,
    this._getUserStreak,
    this._getTodayUrgesCount,
    this._getFocusHistory,
    this._getUrgeHistory,
    this._getMonkStats,
    this._reportUrge,
    this._insightService,
  ) : super(const HomeState());

  @override
  Future<void> close() {
    _timer?.cancel();
    _statsTimer?.cancel();
    return super.close();
  }

  // Load all stats on initialization
  Future<void> loadStats(String userId) async {
    _userId = userId;
    await Future.wait([
      _loadTodayStats(userId),
      _loadStreak(userId),
      _loadUrgesCount(userId),
    ]);
    // Load insights after basic stats are available
    await _loadInsights(userId);
    await _loadMonkStats();

    // Refresh social stats periodically
    _statsTimer?.cancel();
    _statsTimer = Timer.periodic(const Duration(seconds: 60), (_) {
      _loadMonkStats();
    });
  }

  Future<void> _loadTodayStats(String userId) async {
    final result = await _getTodayStats(userId);
    result.fold((failure) {}, (minutes) {
      emit(state.copyWith(todayTotalMinutes: minutes));
    });
  }

  Future<void> _loadStreak(String userId) async {
    final result = await _getUserStreak(userId);
    result.fold((failure) {}, (streak) {
      emit(state.copyWith(userStreak: streak));
    });
  }

  Future<void> _loadUrgesCount(String userId) async {
    final result = await _getTodayUrgesCount(userId);
    result.fold((failure) {}, (count) {
      emit(state.copyWith(todayUrgesCount: count));
    });
  }

  Future<void> _loadInsights(String userId) async {
    final results = await Future.wait([
      _getFocusHistory(userId),
      _getUrgeHistory(userId),
    ]);

    final focusResult = results[0] as Either<Failure, List<FocusSessionEntity>>;
    final urgeResult = results[1] as Either<Failure, List<UrgeReportEntity>>;

    focusResult.fold((_) {}, (sessions) {
      urgeResult.fold((_) {}, (reports) {
        final goldenHour = _insightService.calculateGoldenHour(sessions);
        final dangerZone = _insightService.calculateDangerZone(reports);
        final efficiency = _insightService.calculateEfficiency(sessions);

        final insight = _insightService.generateInsight(
          goldenHour: goldenHour,
          dangerZone: dangerZone,
          efficiency: efficiency,
          todayMinutes: state.todayTotalMinutes,
          todayUrges: state.todayUrgesCount,
        );

        emit(
          state.copyWith(
            dailyInsight: insight,
            goldenHour: goldenHour != null
                ? _insightService.formatHour(goldenHour)
                : null,
            dangerZone: dangerZone != null
                ? _insightService.formatHour(dangerZone)
                : null,
          ),
        );
      });
    });
  }

  // Start timer and create session
  Future<void> startTimer({
    required String userId,
    required String activityType,
    required int durationMinutes,
    String? title,
  }) async {
    // Create session in database
    final result = await _createFocusSession(
      CreateFocusSessionParams(
        userId: userId,
        activityType: activityType,
        durationMinutes: durationMinutes,
        title: title,
      ),
    );

    result.fold(
      (failure) {
        // Handle failure
      },
      (session) {
        _userId = userId;
        final totalSeconds = durationMinutes * 60;
        emit(
          state.copyWith(
            currentSessionId: session.id,
            currentActivity: activityType,
            totalSeconds: totalSeconds,
            remainingSeconds: totalSeconds,
            isRunning: true,
            isPaused: false,
          ),
        );

        _startTimerTick();
      },
    );
  }

  void _startTimerTick() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      if (state.remainingSeconds > 0 && !state.isPaused) {
        emit(state.copyWith(remainingSeconds: state.remainingSeconds - 1));
      } else if (state.remainingSeconds == 0) {
        _timer?.cancel();
        await _onSessionFinished();
      }
    });
  }

  Future<void> _onSessionFinished() async {
    if (state.currentSessionId != null) {
      final completedMinutes = state.totalSeconds ~/ 60;
      await _completeFocusSession(
        CompleteFocusSessionParams(
          sessionId: state.currentSessionId!,
          completedMinutes: completedMinutes,
        ),
      );

      if (_userId != null) {
        await loadStats(_userId!);
      }
    }

    emit(
      state.copyWith(
        isRunning: false,
        isPaused: false,
        currentSessionId: null,
        currentActivity: null,
        remainingSeconds: 25 * 60,
        totalSeconds: 25 * 60,
      ),
    );
  }

  void pauseTimer() {
    if (state.isRunning && !state.isPaused) {
      emit(state.copyWith(isPaused: true));
      SoundService().setVolume(0.0);
    }
  }

  void resumeTimer() {
    if (state.isPaused) {
      emit(state.copyWith(isPaused: false));
      SoundService().setVolume(1.0);
    }
  }

  Future<void> stopTimer() async {
    _timer?.cancel();
    SoundService().stop();

    if (state.isRunning && state.currentSessionId != null) {
      final elapsedSeconds = state.totalSeconds - state.remainingSeconds;
      final completedMinutes = elapsedSeconds ~/ 60;

      await _completeFocusSession(
        CompleteFocusSessionParams(
          sessionId: state.currentSessionId!,
          completedMinutes: completedMinutes,
        ),
      );

      if (_userId != null) {
        await loadStats(_userId!);
      }
    }

    emit(
      state.copyWith(
        remainingSeconds: 25 * 60,
        totalSeconds: 25 * 60,
        isRunning: false,
        isPaused: false,
        currentSessionId: null,
        currentActivity: null,
      ),
    );
  }

  Future<void> refreshStats(String userId) async {
    await loadStats(userId);
  }

  Future<void> reportUrge({
    required String userId,
    required String interventionType,
    String? content,
  }) async {
    final result = await _reportUrge(
      ReportUrgeParams(
        userId: userId,
        interventionType: interventionType,
        content: content,
      ),
    );

    await result.fold((failure) async {}, (report) async {
      await loadStats(userId);
    });
  }

  Future<void> _loadMonkStats() async {
    final result = await _getMonkStats(NoParams());
    result.fold((failure) {}, (stats) {
      emit(
        state.copyWith(
          monkActiveCount: stats.totalActive,
          monkRecentTitles: stats.recentTitles,
        ),
      );
    });
  }
}

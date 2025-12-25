class BreakService {
  static final BreakService _instance = BreakService._internal();
  factory BreakService() => _instance;
  BreakService._internal();

  DateTime? _breakStartTime;
  Duration? _lastBreakDuration;
  Duration _totalBreakDuration = Duration.zero;
  int _totalBreakSessions = 0;
  bool _isOnControlledBreak = false;

  bool get isOnControlledBreak => _isOnControlledBreak;
  Duration? get lastBreakDuration => _lastBreakDuration;
  Duration get totalBreakDuration => _totalBreakDuration;
  int get totalBreakSessions => _totalBreakSessions;

  void startControlledBreak() {
    _isOnControlledBreak = true;
    _breakStartTime = DateTime.now();
  }

  void endControlledBreak() {
    if (_isOnControlledBreak && _breakStartTime != null) {
      final duration = DateTime.now().difference(_breakStartTime!);
      _lastBreakDuration = duration;
      _totalBreakDuration += duration;
      _totalBreakSessions++;
      _isOnControlledBreak = false;
      _breakStartTime = null;
    }
  }

  void reset() {
    _lastBreakDuration = null;
    _totalBreakDuration = Duration.zero;
    _totalBreakSessions = 0;
    _isOnControlledBreak = false;
    _breakStartTime = null;
  }
}

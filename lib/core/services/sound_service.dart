import 'package:audioplayers/audioplayers.dart';

enum FocusActivity {
  homework('Homework', 'Homework Sound', 'sounds/Homework.mp3'),
  presentation('Presentation', 'Presentation Sound', 'sounds/Presentation.mp3'),
  project('Core Project', 'Project Sound', 'sounds/Project.mp3'),
  leetcode('LeetCode/Logic', 'LeetCode Sound', 'sounds/leetcode.mp3');

  final String label;
  final String soundLabel;
  final String soundUrl;
  const FocusActivity(this.label, this.soundLabel, this.soundUrl);
}

class SoundService {
  static final SoundService _instance = SoundService._internal();
  factory SoundService() => _instance;

  SoundService._internal() {
    _init();
  }

  final AudioPlayer _player = AudioPlayer();
  FocusActivity? _currentActivity;
  bool _isMuted = false;

  bool get isMuted => _isMuted;

  Future<void> _init() async {
    try {
      // Basic configuration for cross-platform background audio
      final context = AudioContext(
        iOS: AudioContextIOS(
          category: AVAudioSessionCategory.playback,
          options: {AVAudioSessionOptions.mixWithOthers},
        ),
        android: AudioContextAndroid(
          contentType: AndroidContentType.music,
          usageType: AndroidUsageType.assistanceSonification,
        ),
      );
      await AudioPlayer.global.setAudioContext(context);
    } catch (e) {
      print('SoundService Initialized with defaults (Error: $e)');
    }
  }

  FocusActivity? get currentActivity => _currentActivity;

  Future<void> playForActivity(FocusActivity activity) async {
    try {
      await stop();
      _currentActivity = activity;

      // Set release mode to loop for ambient sounds
      await _player.setReleaseMode(ReleaseMode.loop);

      // Use Source to play
      final source = AssetSource(activity.soundUrl);
      await _player.play(source);

      print('Playing sound for ${activity.label}: ${activity.soundUrl}');
    } catch (e) {
      print('Error playing focus sound: $e');
      _currentActivity = null;
      rethrow;
    }
  }

  Future<void> stop() async {
    try {
      await _player.stop();
    } catch (e) {
      print('Error stopping sound: $e');
    }
    _currentActivity = null;
  }

  Future<void> setVolume(double volume) async {
    await _player.setVolume(volume);
  }

  Future<void> toggleMute() async {
    _isMuted = !_isMuted;
    await _player.setVolume(_isMuted ? 0.0 : 1.0);
  }
}

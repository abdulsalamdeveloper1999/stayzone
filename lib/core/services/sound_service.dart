import 'package:audioplayers/audioplayers.dart';

enum FocusActivity {
  homework(
    'Homework',
    'Zen Forest',
    'https://cdn.pixabay.com/audio/2022/10/16/audio_24a66a1615.mp3',
  ),
  presentation(
    'Presentation',
    'Soft Rain',
    'https://cdn.pixabay.com/audio/2022/03/10/audio_291079313b.mp3',
  ),
  project(
    'Core Project',
    'Meditative Lo-fi',
    'https://cdn.pixabay.com/audio/2022/02/07/audio_83a510d947.mp3',
  ),
  leetcode(
    'LeetCode/Logic',
    'Deep Brown Noise',
    'https://cdn.pixabay.com/audio/2024/02/06/audio_55a29f8f7c.mp3',
  );

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
      final source = UrlSource(activity.soundUrl);
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
}

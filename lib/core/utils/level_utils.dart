class LevelUtils {
  static String getTitle(int totalMinutes) {
    if (totalMinutes < 60) return 'Novice';
    if (totalMinutes < 300) return 'Apprentice';
    if (totalMinutes < 1000) return 'Adept';
    return 'The Monk';
  }
}

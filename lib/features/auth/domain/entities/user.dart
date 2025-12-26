class UserEntity {
  final String id;
  final String email;
  final String? name;

  final int totalFocusMinutes;

  const UserEntity({
    required this.id,
    required this.email,
    this.name,
    this.totalFocusMinutes = 0,
  });
}

class UserProfile {
  final String id;
  final String email;
  final String username;
  final String avatar;
  final int level;

  UserProfile({
    required this.id,
    required this.email,
    required this.username,
    required this.avatar,
    required this.level,
  });
  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['id'],
      email: json['email'],
      username: json['username'],
      avatar: json['avatar'],
      level: json['level'],
    );
  }
}

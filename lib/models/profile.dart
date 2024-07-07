class Profile {
  final String avatarUrl;
  final String bio;

  Profile({
    required this.avatarUrl,
    required this.bio,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      avatarUrl: json['avatarUrl'],
      bio: json['bio'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'avatarUrl': avatarUrl,
      'bio': bio,
    };
  }
}
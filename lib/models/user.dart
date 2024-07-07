import 'package:project_community_flutter/models/profile.dart';

class User {
  final String id;
  final String username;
  final Profile profile;

  User({
    required this.id,
    required this.username,
    required this.profile,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      username: json['username'],
      profile: Profile.fromJson(json['profile']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'username': username,
      'profile': profile.toJson(),
    };
  }
}
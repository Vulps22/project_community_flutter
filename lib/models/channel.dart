import 'package:project_community_flutter/enum/channel_type.dart';

class Channel {
  final String id;
  final String name;
  final ChannelType type;
  final DateTime createdAt;

  Channel({
    required this.id,
    required this.name,
    required this.type,
    required this.createdAt,
  });

  factory Channel.fromJson(Map<String, dynamic> json) {
    return Channel(
      id: json['_id'],
      name: json['name'],
      type: ChannelTypeExtension.fromValue(json['type']),
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'type': type.value,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}

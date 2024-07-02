import 'package:project_community_flutter/models/channel.dart';

class Server {
  final String id;
  final String name;
  final String description;
  final List<Channel> channels;
  final String ownerId;
  final DateTime createdAt;

  Server({
    required this.id,
    required this.name,
    required this.description,
    required this.channels,
    required this.ownerId,
    required this.createdAt,
  });

  factory Server.fromJson(Map<String, dynamic> json) {
    var channelList = json['channels'] as List;
    List<Channel> channelObjs = channelList.map((channelJson) => Channel.fromJson(channelJson)).toList();

    return Server(
      id: json['_id'],
      name: json['name'],
      description: json['description'],
      channels: channelObjs,
      ownerId: json['ownerId']['_id'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'description': description,
      'channels': channels.map((channel) => channel.toJson()).toList(),
      'ownerId': ownerId,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}

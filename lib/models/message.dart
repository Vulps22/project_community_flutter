import 'package:project_community_flutter/models/user.dart';
import 'package:project_community_flutter/enum/message_status.dart';

class Message {
  final String? id;
  final String content;
  final User sender;
  final MessageStatus status;
  final String channelId;
  final String serverId;
  final DateTime timestamp;

  Message({
    this.id,
    required this.content,
    required this.sender,
    required this.status,
    required this.channelId,
    required this.serverId,
    required this.timestamp,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['_id'],
      content: json['content'],
      sender: User.fromJson(json['sender']),
      status: MessageStatus.values[json['status'] ?? MessageStatus.delivered.index],
      channelId: json['channelId'],
      serverId: json['serverId'],
      timestamp: DateTime.parse(json['timestamp']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'content': content,
      'sender': sender.toJson(),
      'status': status.index,
      'channelId': channelId,
      'serverId': serverId,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  Message copyWith({
    String? id,
    String? content,
    User? sender,
    MessageStatus? status,
    String? channelId,
    String? serverId,
    DateTime? timestamp,
  }) {
    return Message(
      id: id ?? this.id,
      content: content ?? this.content,
      sender: sender ?? this.sender,
      status: status ?? this.status,
      channelId: channelId ?? this.channelId,
      serverId: serverId ?? this.serverId,
      timestamp: timestamp ?? this.timestamp,
    );
  }
}

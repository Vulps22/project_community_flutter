import 'package:flutter/material.dart';
import 'package:project_community_flutter/enum/message_status.dart';

class ChatMessage extends StatelessWidget {
  final String username;
  final String message;
  final MessageStatus status;

  const ChatMessage({super.key, required this.username, required this.message, required this.status});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          CircleAvatar(
            child: Text(username[0]),
          ),
          const SizedBox(width: 8.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                username,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                message,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
              if (status == MessageStatus.sending) const CircularProgressIndicator(),
              if (status == MessageStatus.failed) const Icon(Icons.error, color: Colors.red),
            ],
          ),
        ],
      ),
    );
  }
}

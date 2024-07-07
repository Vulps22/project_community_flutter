import 'package:flutter/material.dart';
import 'package:project_community_flutter/providers/state_manager_provider.dart';
import 'package:provider/provider.dart';

class ChatInput extends StatefulWidget {
  final Function(String) onSendMessage;

  const ChatInput({super.key, required this.onSendMessage});

  @override
  ChatInputState createState() => ChatInputState();
}

class ChatInputState extends State<ChatInput> {
  final TextEditingController _controller = TextEditingController();

  void _handleSend() {
    final text = _controller.text.trim();
    if (text.isNotEmpty) {
      final user = Provider.of<StateManagerProvider>(context, listen: false).currentUser;
      if (user != null) {
        print('Sending message from: ${user.username}');
        // Add your logic to send the message here
        widget.onSendMessage(text);
      } else {
        print('User is not logged in');
      }
      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      color: Colors.grey[800],
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration(
                hintText: "Type a message",
                hintStyle: TextStyle(color: Colors.white54),
              ),
              style: const TextStyle(color: Colors.white),
              onSubmitted: (_) => _handleSend(),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            color: Colors.white,
            onPressed: _handleSend,
          ),
        ],
      ),
    );
  }
}

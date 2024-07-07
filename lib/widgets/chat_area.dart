import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project_community_flutter/managers/state_manager.dart';
import 'package:project_community_flutter/providers/state_manager_provider.dart';
import 'package:project_community_flutter/services/api_service.dart';
import 'package:provider/provider.dart';
import 'package:project_community_flutter/enum/message_status.dart';
import 'package:project_community_flutter/models/message.dart';
import 'package:project_community_flutter/widgets/chat_input.dart';
import 'package:project_community_flutter/widgets/chat_message.dart';

class ChatArea extends StatefulWidget {
  final List<Message> initialMessages;

  const ChatArea({super.key, required this.initialMessages});

  @override
  _ChatAreaState createState() => _ChatAreaState();
}

class _ChatAreaState extends State<ChatArea> {
  List<Message> _messages = [];

  @override
  void initState() {
    super.initState();
    StateManagerProvider manager = Provider.of<StateManagerProvider>(context, listen: false);
    if(manager.messages.isNotEmpty) {
      _messages = manager.messages;
    }
  }

  void _sendMessage(String content) async {
    final manager = Provider.of<StateManagerProvider>(context, listen: false);
    var didSend = await sendMessage(content, manager);
    if (didSend) {
      print("booom bitch!");
    } else {
      print("get tae fuck wae this shite");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[800],
      child: Column(
        children: <Widget>[
          Expanded(
            child: Consumer<StateManagerProvider>(
              builder: (context, manager, child) {
                return ListView.builder(
                  reverse: true,
                  padding: const EdgeInsets.all(8.0),
                  itemCount: manager.messages.length,
                  itemBuilder: (context, index) {
                    return ChatMessage(
                      username: manager.messages[index].sender.username,
                      message: manager.messages[index].content,
                      status: manager.messages[index].status,
                    );
                  },
                );
              },
            ),
          ),
          ChatInput(onSendMessage: _sendMessage),
        ],
      ),
    );
  }
}

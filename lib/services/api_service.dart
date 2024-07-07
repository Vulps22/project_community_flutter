import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:project_community_flutter/enum/message_status.dart';
import 'package:project_community_flutter/models/message.dart';
import 'package:project_community_flutter/models/server_list_item.dart';
import 'package:project_community_flutter/providers/state_manager_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/server.dart'; // Adjust the path according to your project structure

Future<Server> getServer(String serverId) async {
  var token = await _getToken();
  final response = await http.get(
    Uri.parse('http://localhost:3000/server/get?serverId=$serverId'),
    headers: {
      'Authorization': 'Bearer $token',
    },
  );
  if (response.statusCode == 200) {
    return Server.fromJson(json.decode(response.body));
  } else if (response.statusCode == 401) {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
    throw Exception('Token Rejected');
  } else {
    throw Exception('Failed to load server');
  }
}

Future<List<ServerListItem>> getServers() async {
  var token = await _getToken();

  final response =
      await http.get(Uri.parse('http://localhost:3000/server/list'), headers: {
    'Authorization': 'Bearer $token',
  });

  if (response.statusCode == 200) {
    List<dynamic> jsonResponse = json.decode(response.body);
    return jsonResponse.map((server) => ServerListItem.fromJson(server)).toList();
  } else if (response.statusCode == 401) {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
    throw Exception('Token Rejected');
  } else {
    throw Exception("Failed to load Servers");
  }
}

Future<List<Message>> getMessages(String serverId, String channelId) async {
  var token = await _getToken();
  final response = await http.get(
    Uri.parse(
        'http://localhost:3000/message/list?serverId=$serverId&channelId=$channelId'), // Update URL as needed
    headers: {
      'Authorization': 'Bearer $token',
    },
  );

  if (response.statusCode == 200) {
    List<dynamic> jsonResponse = json.decode(response.body);
    return jsonResponse.map((message) => Message.fromJson(message)).toList();
  } else if (response.statusCode == 401) {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
    print('401: Token Rejected');
    throw Exception('Token Rejected');
  } else {
    throw Exception('Failed to load messages');
  }
}

Future<bool> sendMessage(String content, StateManagerProvider manager) async {
  final user = manager.currentUser;
  final channel = manager.selectedChannel;
  final server = manager.selectedServer;
  final token = await _getToken();

  if (user == null || channel == null || server == null) {
    print('User, channel, or server, is not set.');
    return false;
  }

  final newMessage = Message(
    content: content,
    sender: user,
    status: MessageStatus.sending,
    channelId: channel.id,
    serverId: server.id,
    timestamp: DateTime.now(),
  );

  try {
    final response = await http.post(
      Uri.parse('http://localhost:3000/messages/create'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'content': content,
        'channelId': channel.id,
        'serverId': server.id,
        'message': newMessage.toJson(),
      }),
    );

    if (response.statusCode == 200) {
      // Optionally handle the response, update message status, etc.
      return true;
    } else {
      print('Failed to send message: ${response.body}');
      return false;
    }
  } catch (e) {
    print('Error sending message: $e');
    return false;
  }
}

Future<String?> _getToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('auth_token');
}

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/server.dart'; // Adjust the path according to your project structure

Future<Server> getServer(String serverId) async {
  print('Get Server: $serverId');
  var token = await _getToken();
  final response = await http.get(
    Uri.parse('http://localhost:3000/server/get?serverId=$serverId'),
    headers: {
      'Authorization': 'Bearer $token',
    },
    );
  print("requestSent");
  print(response.statusCode);
  print(response.body);
  if (response.statusCode == 200) {
    print("success");
    print(json.decode(response.body));
    return Server.fromJson(json.decode(response.body));
  } else if (response.statusCode == 401) {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
    print('401: Token Rejected');
    throw Exception('Token Rejected');
  } else {
    throw Exception('Failed to load server');
  }
}



Future<String?> _getToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
}
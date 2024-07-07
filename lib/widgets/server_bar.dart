import 'package:flutter/material.dart';
import 'package:project_community_flutter/models/server_list_item.dart';
import 'package:project_community_flutter/providers/state_manager_provider.dart';
import 'package:provider/provider.dart';

class ServerBar extends StatelessWidget {
  const ServerBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      color: Colors.grey[900],
      child: Consumer<StateManagerProvider>(
        builder: (context, manager, child) {
          return ListView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: manager.servers.length,
            itemBuilder: (context, index) {
              return ServerCircle(
                server: manager.servers[index],
                onTap: () => selectServer(context, manager.servers[index].id),
              );
            },
          );
        },
      ),
    );
  }

  void selectServer(BuildContext context, String serverId) {
    final stateManager = Provider.of<StateManagerProvider>(context, listen: false);
    stateManager.selectAndLoadServer(serverId);
  }
}

class ServerCircle extends StatelessWidget {
  final ServerListItem server;
  final VoidCallback onTap;

  const ServerCircle({super.key, required this.server, required this.onTap});

  String getInitials(String name) {
    List<String> words = name.split(' ');
    if (words.length > 1) {
      return words[0][0] + words[1][0];
    }
    return name[0];
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: Colors.blue,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(
            getInitials(server.name),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

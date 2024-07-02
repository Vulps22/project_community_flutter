import 'package:flutter/material.dart';
import '../models/channel.dart';
import '../models/server.dart';
import '../services/api_service.dart'; // Adjust the path according to your project structure

class Sidebar extends StatefulWidget {
  final String serverId;

  const Sidebar({super.key, required this.serverId});

  @override
  SidebarState createState() => SidebarState();
}

class SidebarState extends State<Sidebar> {
  late Future<Server> futureServer;

  @override
  void initState() {
    super.initState();
    futureServer = getServer(widget.serverId);
  }

  void selectChannel(String id) {
    // Handle channel selection
    print('Selected channel: $id');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      color: Colors.grey[900],
      child: FutureBuilder<Server>(
        future: futureServer,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.channels.isEmpty) {
            return const Center(child: Text('No channels available'));
          } else {
            List<Channel> channels = snapshot.data!.channels;
            return ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: channels.length,
              itemBuilder: (context, index) {
                return SidebarItem(
                  name: channels[index].name,
                  onTap: () => selectChannel(channels[index].id),
                );
              },
            );
          }
        },
      ),
    );
  }
}

class SidebarItem extends StatelessWidget {
  final String name;
  final VoidCallback onTap;

  const SidebarItem({super.key, required this.name, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Text(
          name,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18.0,
          ),
        ),
      ),
    );
  }
}

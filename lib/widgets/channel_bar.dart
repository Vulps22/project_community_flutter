import 'package:flutter/material.dart';
import 'package:project_community_flutter/helpers/custom_color.dart';
import 'package:project_community_flutter/providers/state_manager_provider.dart';
import 'package:project_community_flutter/states/channel_state.dart';
import 'package:provider/provider.dart';
import '../models/channel.dart';
import '../models/server.dart';

class ChannelBar extends StatefulWidget {
  const ChannelBar({super.key});

  @override
  ChannelBarState createState() => ChannelBarState();
}

class ChannelBarState extends State<ChannelBar> {
  @override
  Widget build(BuildContext context) {
    return Consumer<StateManagerProvider>(
      builder: (context, manager, child) {
        if (manager.selectedServer == null) {
          print("No Server when loading channels");
          return Container(
            width: 250,
            color: CustomColors
                .grey850, // This represents a grey shade similar to 850
            child: const Center(child: Text('No server selected')),
          );
        }

        List<Channel> channels = manager.selectedServer!.channels;
        if (channels.isEmpty) {
          print("No channels to list");
          return Container(
            width: 250,
            color: CustomColors
                .grey850, // This represents a grey shade similar to 850
            child: const Center(child: Text('No channels available')),
          );
        }

        return Container(
          width: 250,
          color: CustomColors
              .grey850, // This represents a grey shade similar to 850
          child: ListView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: channels.length,
            itemBuilder: (context, index) {
              return Expanded(
                child: ChannelBarItem(
                  name: channels[index].name,
                  onTap: () =>
                      Provider.of<StateManagerProvider>(context, listen: false)
                          .selectChannel(channels[index]),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class ChannelBarItem extends StatelessWidget {
  final String name;
  final VoidCallback onTap;

  const ChannelBarItem({super.key, required this.name, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                name,
                style: const TextStyle(color: Colors.white),
                ),
            ),
          ),
        ],
      ),
    );
  }
}

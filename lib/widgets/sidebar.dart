import 'package:flutter/material.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      color: Colors.grey[900],
      child: ListView(
        padding: const EdgeInsets.all(8.0),
        children: const <Widget>[
          SidebarItem(name: "General"),
          SidebarItem(name: "Random"),
          SidebarItem(name: "Help"),
        ],
      ),
    );
  }
}

class SidebarItem extends StatelessWidget {
  final String name;

  const SidebarItem({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        name,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18.0,
        ),
      ),
    );
  }
}
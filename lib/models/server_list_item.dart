
class ServerListItem {
  final String id;
  final String name;

  ServerListItem({
    required this.id,
    required this.name,
 
  });

  factory ServerListItem.fromJson(Map<String, dynamic> json) {
    return ServerListItem(
      id: json['_id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
    };
  }
}

class NetworkChannel {
  final String id;
  final String type;
  final List<String> members;
  final String? description;
  final String? image;
  final String? createdAt;
  final String? createdBy;

  NetworkChannel({
    required this.id,
    required this.type,
    required this.members,
    this.description,
    this.image,
    this.createdAt,
    this.createdBy,
  });

  factory NetworkChannel.fromMap(Map<String, dynamic> map) {
    return NetworkChannel(
      id: map['uid'] ?? "0",
      type: map['type'],
      members: List<String>.from(map['members']),
      description: map['description'],
      image: map['image'],
      createdAt: map['createdDate'],
      createdBy: map['createdBy'],
    );
  }
}

import 'dart:convert';

enum ChatType {
  private,
  group;

  static ChatType fromString(String value) => switch (value) {
        'private' => ChatType.private,
        'group' => ChatType.group,
        _ => throw Exception("Invalid chat type for: $value")
      };
}

class ChatModel {
  final ChatType type;
  final List<String> members;
  final String? description;
  final String? image;
  final String? createdDate;
  final String? createdBy;

  ChatModel({
    required this.type,
    required this.members,
    this.description,
    this.image,
    this.createdDate,
    this.createdBy,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'type': type.name});
    result.addAll({'members': members});

    if (description != null) {
      result.addAll({'description': description});
    }

    if (image != null) {
      result.addAll({'image': image});
    }

    if (createdDate != null) {
      result.addAll({'createdDate': createdDate});
    }

    if (createdBy != null) {
      result.addAll({'createdBy': createdBy});
    }

    return result;
  }

  factory ChatModel.fromMap(Map<String, dynamic> map) {
    return ChatModel(
      type: ChatType.fromString(map['type']),
      members: List<String>.from(map['members']),
      description: map['description'],
      image: map['image'],
      createdDate: map['createdDate'],
      createdBy: map['createdBy'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatModel.fromJson(String source) =>
      ChatModel.fromMap(json.decode(source));
}

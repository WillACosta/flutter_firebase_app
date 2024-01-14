class NetWorkUser {
  final String uid;
  final String name;
  final String email;

  NetWorkUser({
    required this.uid,
    required this.name,
    required this.email,
  });

  factory NetWorkUser.fromMap(Map<String, dynamic> map) {
    return NetWorkUser(
      uid: map['uid'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
    );
  }
}

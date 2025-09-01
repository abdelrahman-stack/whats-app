class UserModel {
  final String id;
  final String name;
  final String phoneNumber;
  final List<String> groupId;
  final String photoUrl;
  final bool isOnline;

  UserModel({
    required this.isOnline,
    required this.phoneNumber,
    required this.groupId,
    required this.id,
    required this.name,
    required this.photoUrl,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'phoneNumber': phoneNumber,
      'groupId': groupId,
      'photoUrl': photoUrl,
      'isOnline': isOnline,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      isOnline: map['isOnline'] ?? false,
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      phoneNumber: map['email'] ?? '',
      groupId: List<String>.from(map['groupId']),
      photoUrl: map['photoUrl'] ?? '',
    );
  }
}

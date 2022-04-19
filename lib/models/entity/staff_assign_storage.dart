import 'dart:convert';

class StaffAssignStorage {
  final String id;
  final String userId;
  final String storageId;
  StaffAssignStorage({
    required this.id,
    required this.userId,
    required this.storageId,
  });

  StaffAssignStorage copyWith({
    String? id,
    String? userId,
    String? storageId,
  }) {
    return StaffAssignStorage(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      storageId: storageId ?? this.storageId,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'id': id});
    result.addAll({'userId': userId});
    result.addAll({'storageId': storageId});
  
    return result;
  }

  factory StaffAssignStorage.fromMap(Map<String, dynamic> map) {
    return StaffAssignStorage(
      id: map['id'] ?? '',
      userId: map['userId'] ?? '',
      storageId: map['storageId'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory StaffAssignStorage.fromJson(String source) => StaffAssignStorage.fromMap(json.decode(source));

  @override
  String toString() => 'StaffAssignStorage(id: $id, userId: $userId, storageId: $storageId)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is StaffAssignStorage &&
      other.id == id &&
      other.userId == userId &&
      other.storageId == storageId;
  }

  @override
  int get hashCode => id.hashCode ^ userId.hashCode ^ storageId.hashCode;
}
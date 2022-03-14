import 'dart:convert';

class NotificationEntity {
  final String id;
  final String orderId;
  final String requestId;
  final String description;
  final int type;
  final bool isOwn;
  final bool isRead;
  NotificationEntity({
    required this.id,
    required this.orderId,
    required this.requestId,
    required this.description,
    required this.type,
    required this.isOwn,
    required this.isRead,
  });

  NotificationEntity copyWith({
    String? id,
    String? orderId,
    String? requestId,
    String? description,
    int? type,
    bool? isOwn,
    bool? isRead,
  }) {
    return NotificationEntity(
      id: id ?? this.id,
      orderId: orderId ?? this.orderId,
      requestId: requestId ?? this.requestId,
      description: description ?? this.description,
      type: type ?? this.type,
      isOwn: isOwn ?? this.isOwn,
      isRead: isRead ?? this.isRead,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'orderId': orderId,
      'requestId': requestId,
      'description': description,
      'type': type,
      'isOwn': isOwn,
      'isRead': isRead,
    };
  }

  factory NotificationEntity.fromMap(Map<String, dynamic> map) {
    return NotificationEntity(
      id: map['id'] ?? '',
      orderId: map['orderId'] ?? '',
      requestId: map['requestId'] ?? '',
      description: map['description'] ?? '',
      type: map['type']?.toInt() ?? 0,
      isOwn: map['isOwn'] ?? false,
      isRead: map['isRead'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory NotificationEntity.fromJson(String source) =>
      NotificationEntity.fromMap(json.decode(source));

  @override
  String toString() {
    return 'NotificationEntity(id: $id, orderId: $orderId, requestId: $requestId, description: $description, type: $type, isOwn: $isOwn, isRead: $isRead)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NotificationEntity &&
        other.id == id &&
        other.orderId == orderId &&
        other.requestId == requestId &&
        other.description == description &&
        other.type == type &&
        other.isOwn == isOwn &&
        other.isRead == isRead;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        orderId.hashCode ^
        requestId.hashCode ^
        description.hashCode ^
        type.hashCode ^
        isOwn.hashCode ^
        isRead.hashCode;
  }
}

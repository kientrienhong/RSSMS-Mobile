import 'dart:convert';

class Timeline {
  final String id;
  final String orderId;
  final String requestId;
  final String datetime;
  final String name;
  final String description;
  Timeline({
    required this.id,
    required this.orderId,
    required this.requestId,
    required this.datetime,
    required this.name,
    required this.description,
  });

  Timeline copyWith({
    String? id,
    String? orderId,
    String? requestId,
    String? datetime,
    String? name,
    String? description,
  }) {
    return Timeline(
      id: id ?? this.id,
      orderId: orderId ?? this.orderId,
      requestId: requestId ?? this.requestId,
      datetime: datetime ?? this.datetime,
      name: name ?? this.name,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'orderId': orderId,
      'requestId': requestId,
      'datetime': datetime,
      'name': name,
      'description': description,
    };
  }

  factory Timeline.fromMap(Map<String, dynamic> map) {
    return Timeline(
      id: map['id'] ?? '',
      orderId: map['orderId'] ?? '',
      requestId: map['requestId'] ?? '',
      datetime: map['datetime'] ?? '',
      name: map['name'] ?? '',
      description: map['description'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Timeline.fromJson(String source) =>
      Timeline.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Timeline(id: $id, orderId: $orderId, requestId: $requestId, datetime: $datetime, name: $name, description: $description)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Timeline &&
        other.id == id &&
        other.orderId == orderId &&
        other.requestId == requestId &&
        other.datetime == datetime &&
        other.name == name &&
        other.description == description;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        orderId.hashCode ^
        requestId.hashCode ^
        datetime.hashCode ^
        name.hashCode ^
        description.hashCode;
  }
}

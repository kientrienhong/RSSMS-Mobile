import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'request_detail.dart';

class Request {
  final int id;
  final int orderId;
  final int userId;
  final int type;
  final int status;
  final String note;
  final List<RequestDetail> requestDetails;
  Request({
    required this.id,
    required this.orderId,
    required this.userId,
    required this.type,
    required this.status,
    required this.note,
    required this.requestDetails,
  });

  Request copyWith({
    int? id,
    int? orderId,
    int? userId,
    int? type,
    int? status,
    String? note,
    List<RequestDetail>? requestDetails,
  }) {
    return Request(
      id: id ?? this.id,
      orderId: orderId ?? this.orderId,
      userId: userId ?? this.userId,
      type: type ?? this.type,
      status: status ?? this.status,
      note: note ?? this.note,
      requestDetails: requestDetails ?? this.requestDetails,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'orderId': orderId,
      'userId': userId,
      'type': type,
      'status': status,
      'note': note,
      'requestDetails': requestDetails.map((x) => x.toMap()).toList(),
    };
  }

  factory Request.fromMap(Map<String, dynamic> map) {
    return Request(
      id: map['id']?.toInt() ?? 0,
      orderId: map['orderId']?.toInt() ?? 0,
      userId: map['userId']?.toInt() ?? 0,
      type: map['type']?.toInt() ?? 0,
      status: map['status']?.toInt() ?? 0,
      note: map['note'] ?? '',
      requestDetails: List<RequestDetail>.from(map['requestDetails']?.map((x) => RequestDetail.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory Request.fromJson(String source) => Request.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Request(id: $id, orderId: $orderId, userId: $userId, type: $type, status: $status, note: $note, requestDetails: $requestDetails)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Request &&
      other.id == id &&
      other.orderId == orderId &&
      other.userId == userId &&
      other.type == type &&
      other.status == status &&
      other.note == note &&
      listEquals(other.requestDetails, requestDetails);
  }

  @override
  int get hashCode {
    return id.hashCode ^
      orderId.hashCode ^
      userId.hashCode ^
      type.hashCode ^
      status.hashCode ^
      note.hashCode ^
      requestDetails.hashCode;
  }
}
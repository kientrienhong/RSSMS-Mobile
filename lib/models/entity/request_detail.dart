import 'dart:convert';

class RequestDetail {
  final int boxId;
  RequestDetail({
    required this.boxId,
  });

  RequestDetail copyWith({
    int? boxId,
  }) {
    return RequestDetail(
      boxId: boxId ?? this.boxId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'boxId': boxId,
    };
  }

  factory RequestDetail.fromMap(Map<String, dynamic> map) {
    return RequestDetail(
      boxId: map['boxId']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory RequestDetail.fromJson(String source) => RequestDetail.fromMap(json.decode(source));

  @override
  String toString() => 'RequestDetail(boxId: $boxId)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is RequestDetail &&
      other.boxId == boxId;
  }

  @override
  int get hashCode => boxId.hashCode;
}
import 'dart:convert';

class Image {
  final int id;
  final String url;
  Image({
    required this.id,
    required this.url,
  });

  Image copyWith({
    int? id,
    String? url,
  }) {
    return Image(
      id: id ?? this.id,
      url: url ?? this.url,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'url': url,
    };
  }

  factory Image.fromMap(Map<String, dynamic> map) {
    return Image(
      id: map['id']?.toInt() ?? 0,
      url: map['url'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Image.fromJson(String source) => Image.fromMap(json.decode(source));

  @override
  String toString() => 'Image(id: $id, url: $url)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Image &&
      other.id == id &&
      other.url == url;
  }

  @override
  int get hashCode => id.hashCode ^ url.hashCode;
}
import 'dart:convert';

class ImageEnitity {
  final int id;
  final String url;
  ImageEnitity({
    required this.id,
    required this.url,
  });

  ImageEnitity copyWith({
    int? id,
    String? url,
  }) {
    return ImageEnitity(
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

  factory ImageEnitity.fromMap(Map<String, dynamic> map) {
    return ImageEnitity(
      id: map['id']?.toInt(),
      url: map['url'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ImageEnitity.fromJson(String source) =>
      ImageEnitity.fromMap(json.decode(source));

  @override
  String toString() => 'ImageEnitity(id: $id, url: $url)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ImageEnitity && other.id == id && other.url == url;
  }

  @override
  int get hashCode => id.hashCode ^ url.hashCode;
}

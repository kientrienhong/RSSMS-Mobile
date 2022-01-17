import 'dart:convert';

import 'dart:io';

class ImageEntity {
  final int? id;
  final String? url;
  final String? note;
  final String? name;
  final File? file;
  ImageEntity({this.id, this.url, this.name, this.note, this.file});

  ImageEntity copyWith(
      {int? id, String? url, String? name, String? note, File? file}) {
    return ImageEntity(
        id: id ?? this.id,
        url: url ?? this.url,
        file: file ?? this.file,
        name: name ?? this.name,
        note: note ?? this.note);
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'url': url, 'note': note, 'name': name};
  }

  factory ImageEntity.fromMap(Map<String, dynamic> map) {
    return ImageEntity(
        id: map['id']?.toInt() ?? 0,
        url: map['url'] ?? '',
        note: map['note'] ?? '',
        name: map['name'] ?? '');
  }

  String toJson() => json.encode(toMap());

  factory ImageEntity.fromJson(String source) =>
      ImageEntity.fromMap(json.decode(source));

  @override
  String toString() => 'ImageEntity(id: $id, url: $url, name: $name)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ImageEntity && other.id == id && other.url == url;
  }

  @override
  int get hashCode => id.hashCode ^ url.hashCode;
}
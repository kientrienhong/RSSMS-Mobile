import 'dart:convert' as convert;

import 'dart:io';

class ImageEntity {
  final String? id;
  final String? url;
  final String? note;
  final String? name;
  final File? file;
  final String? base64;
  ImageEntity(
      {this.id, this.url, this.name, this.note, this.file, this.base64});

  ImageEntity copyWith(
      {String? id,
      String? url,
      String? name,
      String? note,
      File? file,
      String? base64}) {
    return ImageEntity(
        id: id ?? this.id,
        url: url ?? this.url,
        file: file ?? this.file,
        name: name ?? this.name,
        base64: base64 ?? this.base64,
        note: note ?? this.note);
  }

  Map<String, dynamic> toMap() {
    if (id == '') {
      return {'url': url, 'note': note, 'name': name, 'file': base64};
    }
    return {'id': id, 'url': url, 'note': note, 'name': name, 'file': base64};
  }

  factory ImageEntity.fromMap(Map<String, dynamic> map) {
    return ImageEntity(
        id: map['id'] ?? '',
        url: map['url'] ?? '',
        note: map['note'] ?? '',
        name: map['name'] ?? '');
  }

  String toJson() => convert.json.encode(toMap());

  factory ImageEntity.fromJson(String source) =>
      ImageEntity.fromMap(convert.json.decode(source));

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

import 'dart:convert';

class Image {
  final int id;
  final String file;
  final String url;
  final String note;
  final String name;
  Image({
    required this.id,
    required this.file,
    required this.url,
    required this.note,
    required this.name,
  });

  Image copyWith({
    int? id,
    String? file,
    String? url,
    String? note,
    String? name,
  }) {
    return Image(
      id: id ?? this.id,
      file: file ?? this.file,
      url: url ?? this.url,
      note: note ?? this.note,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'file': file,
      'url': url,
      'note': note,
      'name': name,
    };
  }

  factory Image.fromMap(Map<String, dynamic> map) {
    return Image(
      id: map['id']?.toInt() ?? 0,
      file: map['file'] ?? '',
      url: map['url'] ?? '',
      note: map['note'] ?? '',
      name: map['name'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Image.fromJson(String source) => Image.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Image(id: $id, file: $file, url: $url, note: $note, name: $name)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Image &&
      other.id == id &&
      other.file == file &&
      other.url == url &&
      other.note == note &&
      other.name == name;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      file.hashCode ^
      url.hashCode ^
      note.hashCode ^
      name.hashCode;
  }
}
import 'dart:convert';

import 'package:floor/floor.dart';

@entity
class Country {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final String name;
  @ColumnInfo(name: 'is_banned')
  final bool isBanned;
  Country({
    this.id,
    required this.name,
    required this.isBanned,
  });

  Country copyWith({
    int? id,
    String? name,
    bool? isBanned,
  }) {
    return Country(
      id: id ?? this.id,
      name: name ?? this.name,
      isBanned: isBanned ?? this.isBanned,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'isBanned': isBanned,
    };
  }

  factory Country.fromMap(Map<String, dynamic> map) {
    return Country(
      id: map['id']?.toInt(),
      name: map['name'] ?? '',
      isBanned: map['isBanned'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory Country.fromJson(String source) =>
      Country.fromMap(json.decode(source));

  @override
  String toString() => 'Country(id: $id, name: $name, isBanned: $isBanned)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Country &&
        other.id == id &&
        other.name == name &&
        other.isBanned == isBanned;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ isBanned.hashCode;
}

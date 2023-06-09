import 'dart:convert';

import 'package:floor/floor.dart';

@entity
class CreditCard {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final String number;
  final String type;
  final String cvv;
  @ColumnInfo(name: 'issuing_country')
  final String issuingCountry;
  CreditCard({
    this.id,
    required this.number,
    required this.type,
    required this.cvv,
    required this.issuingCountry,
  });

  CreditCard copyWith({
    int? id,
    String? number,
    String? type,
    String? cvv,
    String? issuingCountry,
  }) {
    return CreditCard(
      id: id ?? this.id,
      number: number ?? this.number,
      type: type ?? this.type,
      cvv: cvv ?? this.cvv,
      issuingCountry: issuingCountry ?? this.issuingCountry,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'number': number,
      'type': type,
      'cvv': cvv,
      'issuingCountry': issuingCountry,
    };
  }

  factory CreditCard.fromMap(Map<String, dynamic> map) {
    return CreditCard(
      id: map['id']?.toInt(),
      number: map['number'] ?? '',
      type: map['type'] ?? '',
      cvv: map['cvv'] ?? '',
      issuingCountry: map['issuingCountry'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory CreditCard.fromJson(String source) => CreditCard.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CreditCard(id: $id, number: $number, type: $type, cvv: $cvv, issuingCountry: $issuingCountry)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is CreditCard &&
      other.id == id &&
      other.number == number &&
      other.type == type &&
      other.cvv == cvv &&
      other.issuingCountry == issuingCountry;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      number.hashCode ^
      type.hashCode ^
      cvv.hashCode ^
      issuingCountry.hashCode;
  }
}

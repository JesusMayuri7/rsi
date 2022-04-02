import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'grid_entity.dart';

class ResumenEntity extends Equatable {
  final String dni;
  final String nombres;
  final List<GridEntity> conceptos;
  ResumenEntity({
    required this.dni,
    required this.nombres,
    required this.conceptos,
  });

  Map<String, dynamic> toMap() {
    return {
      'dni': dni,
      'nombres': nombres,
      'conceptos': conceptos.map((x) => x.toMap()).toList(),
    };
  }

  factory ResumenEntity.fromMap(Map<String, dynamic> map) {
    return ResumenEntity(
      dni: map['libEle'] ?? '',
      nombres: map['nombre'] ?? '',
      conceptos: [],
    );
  }

  static ResumenEntity empty() {
    return ResumenEntity(dni: '', nombres: '', conceptos: []);
  }

  String toJson() => json.encode(toMap());

  factory ResumenEntity.fromJson(String source) =>
      ResumenEntity.fromMap(json.decode(source));

  ResumenEntity copyWith({
    String? dni,
    String? nombres,
    List<GridEntity>? conceptos,
  }) {
    return ResumenEntity(
      dni: dni ?? this.dni,
      nombres: nombres ?? this.nombres,
      conceptos: conceptos ?? this.conceptos,
    );
  }

  @override
  String toString() =>
      'ResumenEntity(dni: $dni, nombres: $nombres, conceptos: $conceptos)';

  @override
  // TODO: implement props
  List<Object?> get props => [dni, nombres, conceptos];
}

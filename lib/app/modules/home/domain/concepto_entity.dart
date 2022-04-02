import 'dart:convert';

class ConceptoEntity {
  final int id;
  final int modalidad;
  final String codigo;
  final String naturaleza;
  final String abreviatura;
  final String descripcion;
  final String tipo;
  ConceptoEntity({
    required this.id,
    required this.modalidad,
    required this.codigo,
    required this.naturaleza,
    required this.abreviatura,
    required this.descripcion,
    required this.tipo,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'modalidad': modalidad,
      'codigo': codigo,
      'naturaleza': naturaleza,
      'abreviatura': abreviatura,
      'descripcion': descripcion,
      'tipo': tipo,
    };
  }

  factory ConceptoEntity.fromMap(Map<String, dynamic> map) {
    return ConceptoEntity(
      id: map['id']?.toInt() ?? 0,
      modalidad: map['modalidad']?.toInt() ?? 0,
      codigo: map['codigo'] ?? '',
      naturaleza: map['naturaleza'] ?? '',
      abreviatura: map['abreviatura'] ?? '',
      descripcion: map['descripcion'] ?? '',
      tipo: map['tipo'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ConceptoEntity.fromJson(String source) =>
      ConceptoEntity.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ConceptoEntity(id: $id, modalidad: $modalidad, codigo: $codigo, naturaleza: $naturaleza, abreviatura: $abreviatura, descripcion: $descripcion, tipo: $tipo)';
  }
}

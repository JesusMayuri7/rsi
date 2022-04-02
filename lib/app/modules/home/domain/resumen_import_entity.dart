import 'dart:convert';

class ResumenImportEntity {
  final double ingresos;
  final double descuentos;
  final double aportes;
  ResumenImportEntity({
    required this.ingresos,
    required this.descuentos,
    required this.aportes,
  });

  Map<String, dynamic> toMap() {
    return {
      'ingresos': ingresos,
      'descuentos': descuentos,
      'aportes': aportes,
    };
  }

  factory ResumenImportEntity.fromMap(Map<String, dynamic> map) {
    return ResumenImportEntity(
      ingresos: map['ingresos']?.toDouble() ?? 0.0,
      descuentos: map['descuentos']?.toDouble() ?? 0.0,
      aportes: map['aportes']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory ResumenImportEntity.fromJson(String source) =>
      ResumenImportEntity.fromMap(json.decode(source));
}

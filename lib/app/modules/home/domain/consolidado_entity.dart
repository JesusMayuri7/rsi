import 'dart:convert';

import 'package:equatable/equatable.dart';

class ConsolidadoEntity extends Equatable {
  final int anio;
  final String tipo;
  final double enero;
  final double febrero;
  final double marzo;
  final double abril;
  final double mayo;
  final double junio;
  final double julio;
  final double agosto;
  final double setiembre;
  final double octubre;
  final double noviembre;
  final double diciembre;
  const ConsolidadoEntity({
    required this.anio,
    required this.tipo,
    required this.enero,
    required this.febrero,
    required this.marzo,
    required this.abril,
    required this.mayo,
    required this.junio,
    required this.julio,
    required this.agosto,
    required this.setiembre,
    required this.octubre,
    required this.noviembre,
    required this.diciembre,
  });

  @override
  List<Object> get props {
    return [
      anio,
      tipo,
      enero,
      febrero,
      marzo,
      abril,
      mayo,
      junio,
      julio,
      agosto,
      setiembre,
      octubre,
      noviembre,
      diciembre,
    ];
  }

  ConsolidadoEntity copyWith({
    int? anio,
    String? tipo,
    double? enero,
    double? febrero,
    double? marzo,
    double? abril,
    double? mayo,
    double? junio,
    double? julio,
    double? agosto,
    double? setiembre,
    double? octubre,
    double? noviembre,
    double? diciembre,
  }) {
    return ConsolidadoEntity(
      anio: anio ?? this.anio,
      tipo: tipo ?? this.tipo,
      enero: enero ?? this.enero,
      febrero: febrero ?? this.febrero,
      marzo: marzo ?? this.marzo,
      abril: abril ?? this.abril,
      mayo: mayo ?? this.mayo,
      junio: junio ?? this.junio,
      julio: julio ?? this.julio,
      agosto: agosto ?? this.agosto,
      setiembre: setiembre ?? this.setiembre,
      octubre: octubre ?? this.octubre,
      noviembre: noviembre ?? this.noviembre,
      diciembre: diciembre ?? this.diciembre,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'anio': anio,
      'tipo': tipo,
      'enero': enero,
      'febrero': febrero,
      'marzo': marzo,
      'abril': abril,
      'mayo': mayo,
      'junio': junio,
      'julio': julio,
      'agosto': agosto,
      'setiembre': setiembre,
      'octubre': octubre,
      'noviembre': noviembre,
      'diciembre': diciembre,
    };
  }

  factory ConsolidadoEntity.fromMap(Map<String, dynamic> map) {
    return ConsolidadoEntity(
      anio: map['anio'] ?? 0,
      tipo: map['tipo'] ?? '',
      enero: map['enero']?.toDouble() ?? 0.0,
      febrero: map['febrero']?.toDouble() ?? 0.0,
      marzo: map['marzo']?.toDouble() ?? 0.0,
      abril: map['abril']?.toDouble() ?? 0.0,
      mayo: map['mayo']?.toDouble() ?? 0.0,
      junio: map['junio']?.toDouble() ?? 0.0,
      julio: map['julio']?.toDouble() ?? 0.0,
      agosto: map['agosto']?.toDouble() ?? 0.0,
      setiembre: map['setiembre']?.toDouble() ?? 0.0,
      octubre: map['octubre']?.toDouble() ?? 0.0,
      noviembre: map['noviembre']?.toDouble() ?? 0.0,
      diciembre: map['diciembre']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory ConsolidadoEntity.fromJson(String source) =>
      ConsolidadoEntity.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ConsolidadoEntity(anio: $anio, tipo: $tipo, enero: $enero, febrero: $febrero, marzo: $marzo, abril: $abril, mayo: $mayo, junio: $junio, julio: $julio, agosto: $agosto, setiembre: $setiembre, octubre: $octubre, noviembre: $noviembre, diciembre: $diciembre)';
  }
}

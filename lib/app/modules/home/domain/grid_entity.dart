import 'dart:convert';

import 'package:equatable/equatable.dart';

class GridEntity extends Equatable {
  final int anio;

  final String concepto;
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
  final double total;
  GridEntity({
    required this.anio,
    required this.concepto,
    this.enero = 0,
    this.febrero = 0,
    this.marzo = 0,
    this.abril = 0,
    this.mayo = 0,
    this.junio = 0,
    this.julio = 0,
    this.agosto = 0,
    this.setiembre = 0,
    this.octubre = 0,
    this.noviembre = 0,
    this.diciembre = 0,
    this.total = 0,
  });

  @override
  String toString() {
    return 'GridEntity(anio: $anio, concepto: $concepto, enero: $enero, febrero: $febrero, marzo: $marzo, abril: $abril, mayo: $mayo, junio: $junio, julio: $julio, agosto: $agosto, setiembre: $setiembre, octubre: $octubre, noviembre: $noviembre, diciembre: $diciembre, total: $total)';
  }

  Map<String, dynamic> toMap() {
    return {
      'anio': anio,
      'concepto': concepto,
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
      'total': total,
    };
  }

  factory GridEntity.fromMap(Map<String, dynamic> map) {
    return GridEntity(
      anio: map['anio'] ?? 0,
      concepto: map['concepto'] ?? '',
      enero: (map['enero'] ?? 0).toDouble(),
      febrero: (map['febrero'] ?? 0).toDouble(),
      marzo: (map['marzo'] ?? 0).toDouble(),
      abril: (map['abril'] ?? 0).toDouble(),
      mayo: (map['mayo'] ?? 0).toDouble(),
      junio: (map['junio'] ?? 0).toDouble(),
      julio: (map['julio'] ?? 0).toDouble(),
      agosto: (map['agosto'] ?? 0).toDouble(),
      setiembre: (map['setiembre'] ?? 0).toDouble(),
      octubre: (map['octubre'] ?? 0).toDouble(),
      noviembre: (map['noviembre'] ?? 0).toDouble(),
      diciembre: (map['diciembre'] ?? 0).toDouble(),
      total: (map['total'] ?? 0).toDouble(),
    );
  }

  String toJson() => json.encode(toMap());

  factory GridEntity.fromJson(String source) =>
      GridEntity.fromMap(json.decode(source));

  GridEntity copyWith({
    int? anio,
    String? codigo,
    String? concepto,
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
    double? total,
  }) {
    return GridEntity(
      anio: anio ?? this.anio,
      concepto: concepto ?? this.concepto,
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
      total: total ?? this.total,
    );
  }

  @override
  List<Object> get props {
    return [
      anio,
      concepto,
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
      total,
    ];
  }
}

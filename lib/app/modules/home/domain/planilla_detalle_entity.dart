import 'dart:convert';

import 'package:equatable/equatable.dart';

class PlanillaDetalleEntity {
  int? planillaId;
  int? anio;
  int? mes;
  String? dni;
  String? codigo;
  num? monto;
  PlanillaDetalleEntity({
    this.planillaId,
    this.anio,
    this.mes,
    this.dni,
    this.codigo,
    this.monto,
  });

  @override
  String toString() {
    return 'PlanillaDetalleEntity(planillaId: $planillaId, anio: $anio, mes: $mes, dni: $dni, codigo: $codigo, monto: $monto)';
  }

  PlanillaDetalleEntity copyWith({
    int? planillaId,
    int? anio,
    int? mes,
    String? dni,
    String? codigo,
    num? monto,
  }) {
    return PlanillaDetalleEntity(
      planillaId: planillaId ?? this.planillaId,
      anio: anio ?? this.anio,
      mes: mes ?? this.mes,
      dni: dni ?? this.dni,
      codigo: codigo ?? this.codigo,
      monto: monto ?? this.monto,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'planilla_id': planillaId,
      'anio': anio,
      'mes': mes,
      'dni': dni,
      'codigo': codigo,
      'monto': monto,
    };
  }

  factory PlanillaDetalleEntity.fromMap(Map<String, dynamic> map) {
    return PlanillaDetalleEntity(
      planillaId: map['planillaId']?.toInt(),
      anio: map['anio']?.toInt(),
      mes: map['mes']?.toInt(),
      dni: map['dni'],
      codigo: map['codigo'],
      monto: map['monto'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PlanillaDetalleEntity.fromJson(String source) =>
      PlanillaDetalleEntity.fromMap(json.decode(source));
}

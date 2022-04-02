import 'dart:convert';

import 'package:salud_ilo/app/modules/home/domain/planilla_detalle_entity.dart';

class PlanillaEntity {
  int? anio;
  int? mes;
  String? codEje;
  String? codFun;
  String? plaza;
  String? nombre;
  String? codCar;
  int? tipoPla;
  String? codEst;
  String? libEle;
  String? regim;
  String? codNiv;
  String? codSiaf;
  int? condic;
  List<PlanillaDetalleEntity> planilla_detalle = [];

  @override
  String toString() {
    return 'PersonalEntity(anio: $anio, mes: $mes, codEje: $codEje, codFun: $codFun, plaza: $plaza, nombre: $nombre, codCar: $codCar, tipoPla: $tipoPla, codEst: $codEst, libEle: $libEle, regim: $regim, codNiv: $codNiv, codSiaf: $codSiaf, condic: $condic, conceptos: $planilla_detalle)';
  }

  Map<String, dynamic> toMap() {
    return {
      'anio': anio,
      'mes': mes,
      'codEje': codEje,
      'codFun': codFun,
      'plaza': plaza,
      'nombre': nombre,
      'codCar': codCar,
      'tipoPla': tipoPla,
      'codEst': codEst,
      'libEle': libEle,
      'regim': regim,
      'codNiv': codNiv,
      'codSiaf': codSiaf,
      'condic': condic
    };
  }

  String toJson() => json.encode(toMap());
}

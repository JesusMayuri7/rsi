import 'dart:io';

import 'package:path/path.dart';
import 'package:salud_ilo/app/modules/home/domain/concepto_entity.dart';
import 'package:salud_ilo/app/modules/home/domain/planilla_detalle_entity.dart';
import 'package:salud_ilo/app/modules/home/domain/planilla_entity.dart';
import 'package:salud_ilo/app/modules/home/domain/resumenEntity.dart';
import 'package:salud_ilo/app/modules/home/domain/grid_entity.dart';
import 'package:salud_ilo/app/modules/home/domain/consolidado_entity.dart';
import 'package:salud_ilo/app/modules/home/presenter/conceptos/cubit/conceptos_cubit.dart';
//import 'package:sqlite3/sqlite3.dart';
import 'package:sqflite_common/sqlite_api.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'insert_multiple.dart';
//import 'package:agenda/src/models/detalle_model.dart';

//import 'package:agenda/src/models/tarea_model.dart';
//export 'package:agenda/src/models/tarea_model.dart';

class DBProvider {
  static Database? _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDB();
    return _database!;
  }

  initDB() async {
    sqfliteFfiInit();

    String pathApplication = Directory.current.absolute.path;
    //if (kReleaseMode) {}

    //Directory documentsDirectory1 = Directory(pathApplication);
    String path1 = join(pathApplication, "SaludILO.db");
    print(path1);
    if (FileSystemEntity.typeSync(path1) == FileSystemEntityType.notFound) {
      print('Error al cargar la base de datos');
    }

    var databaseFactory = databaseFactoryFfi;
    var db = await databaseFactory.openDatabase(path1);

    return db;
  }

/*
  // CREAR Registros
  nuevaTareaRaw(TareaModel nuevaTarea) async {
    final db = await database;

    final res = await db.rawInsert("INSERT Into Scans (id, tipo, valor) "
        "VALUES ( ${nuevaTarea.id}, '${nuevaTarea.estado}', '${nuevaTarea.nivel}' )");
    return res;
  }

  nuevoDetalleRaw(DetalleModel nuevoDetalle) async {
    final db = await database;

    final res = await db.rawInsert(
        "INSERT Into detalle (desc_detalle, tarea_id, created_at) "
        "VALUES ( '${nuevoDetalle.descDetalle}', ${nuevoDetalle.tareaId}, datetime('now') )");
    return res;
  }



  filtrarTarea(TareaModel nuevaTarea) async {
    final db = await database;
    // final res = await db.rawQuery("SELECT * FROM tarea WHERE id=2");
    final res = await db.query('tarea',
        where: 'estado = ? and nivel = ? and area =?',
        whereArgs: [nuevaTarea.estado, nuevaTarea.nivel, nuevaTarea.area]);
    List<TareaModel> list =
        res.isNotEmpty ? res.map((c) => TareaModel.fromJson(c)).toList() : [];
    //      print('$list');
    return list;
  }

  // SELECT - Obtener información
  Future<TareaModel> getTareaId(int id) async {
    final db = await database;
    final res = await db.query('tarea', where: 'id = ?', whereArgs: [id]);
    return res.isNotEmpty ? TareaModel.fromJson(res.first) : null;
  }

  Future<List<DetalleModel>> getDetalleAll(int id) async {
    final db = await database;
    final res =
        await db.query('detalle', where: 'tarea_id = ?', whereArgs: [id]);
    List<DetalleModel> list =
        res.isNotEmpty ? res.map((c) => DetalleModel.fromJson(c)).toList() : [];
    return list;
  }





  // Actualizar Registros
  Future<int> updateTarea(TareaModel nuevoScan) async {
    final db = await database;
    final res = await db.update('tarea', nuevoScan.toJson(),
        where: 'id = ?', whereArgs: [nuevoScan.id]);
    return res;
  }



  Future<int> deleteDetalle(int id) async {
    final db = await database;
    final res = await db.delete('detalle', where: 'id = ?', whereArgs: [id]);
    return res;
  }
*/

  Future<Map> resumenImport(int anio, int mes) async {
    final db = await database;
    //print(conceptoEntity.toString());
    final res = await db.rawQuery(queryResumenImport(anio, mes));

    //print(res);
    return res[0];
  }

  Future<int> newConcepto(ParamConcepto conceptoEntity) async {
    final db = await database;
    //print(conceptoEntity.toString());
    final res = await db.insert('conceptos', conceptoEntity.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    //print(res);
    return res;
  }

  // Eliminar registros
  Future<int> deletePlanillaByAnioMes(int anio, int mes) async {
    print(anio.toString() + ' -  ' + mes.toString());
    final db = await database;
    await db.delete('planilla',
        where: 'anio = ? AND mes= ?', whereArgs: [anio, mes]);

    final detalle = await db.delete('planilla_detalle',
        where: 'anio = ? AND mes= ?', whereArgs: [anio, mes]);
    return detalle;
  }

  Future<List<ConceptoEntity>> getConceptos() async {
    final db = await database;
    final res = await db.query('conceptos', orderBy: 'modalidad');
    List<ConceptoEntity> list = res.isNotEmpty
        ? res.map((c) => ConceptoEntity.fromMap(c)).toList()
        : [];
    return list;
  }

  Future<List<ConsolidadoEntity>> getConsolidadoByAnioAndMes() async {
    final db = await database;
    final res = await db.rawQuery(queryResumenByAnioAndMes());
    List<ConsolidadoEntity> resumenGridEntityList = res.isNotEmpty
        ? res.map((c) => ConsolidadoEntity.fromMap(c)).toList()
        : [];
    return resumenGridEntityList;

    // error en la C
  }

  Future<ResumenEntity> getPlanillaDetalleByAnioAndDni(
      int anioDesde, int anioA, String dni) async {
    final db = await database;

    final planilla = await db.query('planilla_unica',
        where: 'libEle = ?', whereArgs: [dni], limit: 1);

    if (planilla.isEmpty) return ResumenEntity.empty();

    //print('planilla ' + planilla.toString());
    final res = await db.rawQuery(queryByAnioAndDni(anioDesde, anioA, dni));
    List<GridEntity> list =
        res.isNotEmpty ? res.map((c) => GridEntity.fromMap(c)).toList() : [];

    ResumenEntity resumen = ResumenEntity.fromMap(planilla[0]);

    // JUNTAR DNI, NOMBRES Y CONCEPTOS EN RESUMEN ENTITY

    resumen.conceptos.addAll(list);
    //print('resumen ' + resumen.toString());
    return resumen;
  }

  Future<void> insertPlanillaDetalle(
      List<PlanillaDetalleEntity> data, int planillaId) async {
    List<Map<String, Object?>> planillaDetalleList =
        planillaDetalleModelFromMap(data);

    List<Map<String, Object?>> temp = planillaDetalleList.map((e) {
      e['planilla_id'] = planillaId;
      return e;
    }).toList();
    final db = await database;
    final res = await db.insertMultiple(
      'planilla_detalle',
      temp,
    );
  }

  Future<int> nuevaPlanilla(PlanillaEntity planilla) async {
    final db = await database;
    final res = await db.insert('planilla', planilla.toMap());
    return res;
  }

  // SELECT - Obtener información
  Future<dynamic> getTareaId(int id) async {
    final db = await database;
    final res = await db.query('tarea', where: 'id = ?', whereArgs: [id]);
    return res;
  }
}

// To parse this JSON data, do
//
//     final planillaDetalleModel = planillaDetalleModelFromMap(jsonString);

List<Map<String, Object?>> planillaDetalleModelFromMap(
        List<PlanillaDetalleEntity> conceptos) =>
    List<Map<String, Object?>>.from(conceptos.map((e) => e.toMap()));

String queryResumenImport(int anio, int mes) {
  return '''
          SELECT anio,mes,ROUND(SUM(CASE WHEN SUBSTR(codigo,1,2)='C1' THEN monto else 0 end),2) as ingresos,
          ROUND(SUM(CASE WHEN SUBSTR(codigo,1,2)='C2' THEN monto else 0 end),2) as descuentos,
          ROUND(SUM(CASE WHEN SUBSTR(codigo,1,2)='C3' THEN monto else 0 end),2) as aportes
          FROM planilla_detalle
          where anio=$anio and mes=$mes
          GROUP BY anio,mes
          ''';
}

String queryByAnioAndDni(int anioDesde, int anioA, String dni) {
  return '''
      SELECT t.* FROM (
      SELECT p.anio,
      IfNULL(c.abreviatura,pd.codigo) as concepto,
      ROUND(sum(case when pd.mes=1 then monto else 0 end ),2) as "enero",
      ROUND(sum(case when pd.mes=2 then monto else 0 end ),2) as "febrero",
      ROUND(sum(case when pd.mes=3 then monto else 0 end ),2) as "marzo",
      ROUND(sum(case when pd.mes=4 then monto else 0 end ),2) as "abril",
      ROUND(sum(case when pd.mes=5 then monto else 0 end ),2) as "mayo",
      ROUND(sum(case when pd.mes=6 then monto else 0 end ),2) as "junio",
      ROUND(sum(case when pd.mes=7 then monto else 0 end ),2) as "julio",
      ROUND(sum(case when pd.mes=8 then monto else 0 end ),2) as "agosto",
      ROUND(sum(case when pd.mes=9 then monto else 0 end ),2) as "setiembre",
      ROUND(sum(case when pd.mes=10 then monto else 0 end ),2) as "octubre",
      ROUND(sum(case when pd.mes=11 then monto else 0 end ),2) as "noviembre",
      ROUND(sum(case when pd.mes=12 then monto else 0 end ),2) as "diciembre",
      ROUND(sum(monto),2) as "total"
      FROM planilla_unica p INNER JOIN planilla_detalle pd ON p.anio = pd.anio and p.mes = pd.mes and p.libEle = pd.dni
			LEFT JOIN conceptos c ON pd.codigo = c.codigo
			and (CASE WHEN p.tipoPla in (1,2)  and p.condic= 1 THEN 4 
						WHEN p.tipoPla in (1,2)  and p.condic= 2 THEN 1
			      when p.tipoPla in (3,4)  and p.condic = 1 THEN 4 
						when p.tipoPla in (3,4)  and p.condic = 2 THEN 2 ELSE 3 end) = c.modalidad 
			WHERE SUBSTR(pd.codigo,1,2)='C1' AND (p.anio BETWEEN $anioDesde and $anioA) and p.libEle = '$dni' GROUP BY p.anio,pd.codigo
			UNION ALL
SELECT p.anio,
      'Ingresos' as concepto,
      ROUND(sum(case when pd.mes=1 then monto else 0 end ),2) as "enero",
      ROUND(sum(case when pd.mes=2 then monto else 0 end ),2) as "febrero",
      ROUND(sum(case when pd.mes=3 then monto else 0 end ),2) as "marzo",
      ROUND(sum(case when pd.mes=4 then monto else 0 end ),2) as "abril",
      ROUND(sum(case when pd.mes=5 then monto else 0 end ),2) as "mayo",
      ROUND(sum(case when pd.mes=6 then monto else 0 end ),2) as "junio",
      ROUND(sum(case when pd.mes=7 then monto else 0 end ),2) as "julio",
      ROUND(sum(case when pd.mes=8 then monto else 0 end ),2) as "agosto",
      ROUND(sum(case when pd.mes=9 then monto else 0 end ),2) as "setiembre",
      ROUND(sum(case when pd.mes=10 then monto else 0 end ),2)  as "octubre",
      ROUND(sum(case when pd.mes=11 then monto else 0 end ),2)  as "noviembre",
      ROUND(sum(case when pd.mes=12 then monto else 0 end ),2)  as "diciembre",
      ROUND(sum(monto),2) as "total"
      FROM planilla_unica p INNER JOIN planilla_detalle pd ON p.anio = pd.anio and p.mes = pd.mes and p.libEle = pd.dni
			LEFT JOIN conceptos c ON pd.codigo = c.codigo
			and (CASE WHEN p.tipoPla in (1,2)  and p.condic= 1 THEN 4 
						WHEN p.tipoPla in (1,2)  and p.condic= 2 THEN 1
			      when p.tipoPla in (3,4)  and p.condic = 1 THEN 4 
						when p.tipoPla in (3,4)  and p.condic = 2 THEN 2 ELSE 3 end) = c.modalidad 
			WHERE SUBSTR(pd.codigo,1,2)='C1' AND (p.anio BETWEEN $anioDesde and $anioA) and p.libEle = '$dni'
      GROUP BY p.anio
			UNION ALL
      SELECT p.anio,
      IfNULL(c.abreviatura,pd.codigo) as concepto,
      ROUND(sum(case when pd.mes=1 then monto else 0 end ),2) as "enero",
      ROUND(sum(case when pd.mes=2 then monto else 0 end ),2) as "febrero",
      ROUND(sum(case when pd.mes=3 then monto else 0 end ),2) as "marzo",
      ROUND(sum(case when pd.mes=4 then monto else 0 end ),2) as "abril",
      ROUND(sum(case when pd.mes=5 then monto else 0 end ),2) as "mayo",
      ROUND(sum(case when pd.mes=6 then monto else 0 end ),2) as "junio",
      ROUND(sum(case when pd.mes=7 then monto else 0 end ),2) as "julio",
      ROUND(sum(case when pd.mes=8 then monto else 0 end ),2) as "agosto",
      ROUND(sum(case when pd.mes=9 then monto else 0 end ),2) as "setiembre",
      ROUND(sum(case when pd.mes=10 then monto else 0 end ),2)  as "octubre",
      ROUND(sum(case when pd.mes=11 then monto else 0 end ),2)  as "noviembre",
      ROUND(sum(case when pd.mes=12 then monto else 0 end ),2)  as "diciembre",
      ROUND(sum(monto),2) as "total"
      FROM planilla_unica p INNER JOIN planilla_detalle pd ON p.anio = pd.anio and p.mes = pd.mes and p.libEle = pd.dni
			LEFT JOIN conceptos c ON pd.codigo = c.codigo
			and (CASE WHEN p.tipoPla in (1,2)  and p.condic= 1 THEN 4 
						WHEN p.tipoPla in (1,2)  and p.condic= 2 THEN 1
			      when p.tipoPla in (3,4)  and p.condic = 1 THEN 4 
						when p.tipoPla in (3,4)  and p.condic = 2 THEN 2 ELSE 3 end) = c.modalidad 
			WHERE SUBSTR(pd.codigo,1,2)='C2' AND (p.anio BETWEEN $anioDesde and $anioA) and p.libEle = '$dni' 
      GROUP BY p.anio,pd.codigo
			UNION ALL
      SELECT p.anio,
      'Descuentos' as concepto,
      ROUND(sum(case when pd.mes=1 then monto else 0 end ),2) as "enero",
      ROUND(sum(case when pd.mes=2 then monto else 0 end ),2) as "febrero",
      ROUND(sum(case when pd.mes=3 then monto else 0 end ),2) as "marzo",
      ROUND(sum(case when pd.mes=4 then monto else 0 end ),2) as "abril",
      ROUND(sum(case when pd.mes=5 then monto else 0 end ),2) as "mayo",
      ROUND(sum(case when pd.mes=6 then monto else 0 end ),2) as "junio",
      ROUND(sum(case when pd.mes=7 then monto else 0 end ),2) as "julio",
      ROUND(sum(case when pd.mes=8 then monto else 0 end ),2) as "agosto",
      ROUND(sum(case when pd.mes=9 then monto else 0 end ),2) as "setiembre",
      ROUND(sum(case when pd.mes=10 then monto else 0 end ),2)  as "octubre",
      ROUND(sum(case when pd.mes=11 then monto else 0 end ),2)  as "noviembre",
      ROUND(sum(case when pd.mes=12 then monto else 0 end ),2)  as "diciembre",
      ROUND(monto) as "total"
      FROM planilla_unica p INNER JOIN planilla_detalle pd ON p.anio = pd.anio and p.mes = pd.mes and p.libEle = pd.dni
			LEFT JOIN conceptos c ON pd.codigo = c.codigo
			and (CASE WHEN p.tipoPla in (1,2)  and p.condic= 1 THEN 4 
						WHEN p.tipoPla in (1,2)  and p.condic= 2 THEN 1
			      when p.tipoPla in (3,4)  and p.condic = 1 THEN 4 
						when p.tipoPla in (3,4)  and p.condic = 2 THEN 2 ELSE 3 end) = c.modalidad 
			WHERE SUBSTR(pd.codigo,1,2)='C2' AND (p.anio BETWEEN $anioDesde and $anioA) and p.libEle = '$dni' 
      GROUP BY p.anio
			union ALL
SELECT p.anio,
      IfNULL(c.abreviatura,pd.codigo) as concepto,
      ROUND(sum(case when pd.mes=1 then monto else 0 end ),2) as "enero",
      ROUND(sum(case when pd.mes=2 then monto else 0 end ),2) as "febrero",
      ROUND(sum(case when pd.mes=3 then monto else 0 end ),2) as "marzo",
      ROUND(sum(case when pd.mes=4 then monto else 0 end ),2) as "abril",
      ROUND(sum(case when pd.mes=5 then monto else 0 end ),2) as "mayo",
      ROUND(sum(case when pd.mes=6 then monto else 0 end ),2) as "junio",
      ROUND(sum(case when pd.mes=7 then monto else 0 end ),2) as "julio",
      ROUND(sum(case when pd.mes=8 then monto else 0 end ),2) as "agosto",
      ROUND(sum(case when pd.mes=9 then monto else 0 end ),2) as "setiembre",
      ROUND(sum(case when pd.mes=10 then monto else 0 end ),2)  as "octubre",
      ROUND(sum(case when pd.mes=11 then monto else 0 end ),2)  as "noviembre",
      ROUND(sum(case when pd.mes=12 then monto else 0 end ),2)  as "diciembre",
      ROUND(sum(monto),2) as "total"
      FROM planilla_unica p INNER JOIN planilla_detalle pd ON p.anio = pd.anio and p.mes = pd.mes and p.libEle = pd.dni
			LEFT JOIN conceptos c ON pd.codigo = c.codigo
			and (CASE WHEN p.tipoPla in (1,2)  and p.condic= 1 THEN 4 
						WHEN p.tipoPla in (1,2)  and p.condic= 2 THEN 1
			      when p.tipoPla in (3,4)  and p.condic = 1 THEN 4 
						when p.tipoPla in (3,4)  and p.condic = 2 THEN 2 ELSE 3 end) = c.modalidad 
			WHERE SUBSTR(pd.codigo,1,2)='C3' AND (p.anio BETWEEN $anioDesde and $anioA) and p.libEle = '$dni' 
      GROUP BY p.anio,pd.codigo
			UNION ALL
      SELECT p.anio,
      'Aportes' as concepto,
      ROUND(sum(case when pd.mes=1 then monto else 0 end),2) as "enero",
      ROUND(sum(case when pd.mes=2 then monto else 0 end ),2) as "febrero",
      ROUND(sum(case when pd.mes=3 then monto else 0 end ),2) as "marzo",
      ROUND(sum(case when pd.mes=4 then monto else 0 end ),2) as "abril",
      ROUND(sum(case when pd.mes=5 then monto else 0 end ),2) as "mayo",
      ROUND(sum(case when pd.mes=6 then monto else 0 end ),2) as "junio",
      ROUND(sum(case when pd.mes=7 then monto else 0 end ),2) as "julio",
      ROUND(sum(case when pd.mes=8 then monto else 0 end ),2) as "agosto",
      ROUND(sum(case when pd.mes=9 then monto else 0 end ),2) as "setiembre",
      ROUND(sum(case when pd.mes=10 then monto else 0 end ),2)  as "octubre",
      ROUND(sum(case when pd.mes=11 then monto else 0 end ),2)  as "noviembre",
      ROUND(sum(case when pd.mes=12 then monto else 0 end ),2)  as "diciembre",
      ROUND(sum(monto),2) as "total"
      FROM planilla_unica p INNER JOIN planilla_detalle pd ON p.anio = pd.anio and p.mes = pd.mes and p.libEle = pd.dni
			LEFT JOIN conceptos c ON pd.codigo = c.codigo
			and (CASE WHEN p.tipoPla in (1,2)  and p.condic= 1 THEN 4 
						WHEN p.tipoPla in (1,2)  and p.condic= 2 THEN 1
			      when p.tipoPla in (3,4)  and p.condic = 1 THEN 4 
						when p.tipoPla in (3,4)  and p.condic = 2 THEN 2 ELSE 3 end) = c.modalidad 
			WHERE SUBSTR(pd.codigo,1,2)='C3' AND (p.anio BETWEEN $anioDesde and $anioA) and p.libEle = '$dni' 
      GROUP BY p.anio ) as t ORDER BY t.anio     
 ''';
}

String queryResumenByAnioAndMes() {
  return '''select t.* from (
SELECT pd.anio,'Ingresos' as tipo,
round(SUM(case when pd.mes=1 then monto else 0 end),2) as 'enero',
round(SUM(case when pd.mes=2 then monto else 0 end),2) 'febrero',
round(SUM(case when pd.mes=3 then monto else 0 end),2) 'marzo',
round(SUM(case when pd.mes=4 then monto else 0 end),2) 'abril',
round(SUM(case when pd.mes=5 then monto else 0 end),2) 'mayo',
round(SUM(case when pd.mes=6 then monto else 0 end),2) 'junio',
round(SUM(case when pd.mes=7 then monto else 0 end),2) 'julio',
round(SUM(case when pd.mes=8 then monto else 0 end),2) 'agosto',
round(SUM(case when pd.mes=9 then monto else 0 end),2) 'setiembre',
round(SUM(case when pd.mes=10 then monto else 0 end),2) 'octubre',
round(SUM(case when pd.mes=11 then monto else 0 end),2) 'noviembre',
round(SUM(case when pd.mes=12 then monto else 0 end),2) 'diciembre'
FROM planilla_detalle pd
where SUBSTR(pd.codigo,1,2)='C1'
GROUP BY pd.anio
UNION ALL
SELECT pd.anio,'Descuentos',
round(SUM(case when pd.mes=1 then monto else 0 end),2) as 'enero',
round(SUM(case when pd.mes=2 then monto else 0 end),2) 'febrero',
round(SUM(case when pd.mes=3 then monto else 0 end),2) 'marzo',
round(SUM(case when pd.mes=4 then monto else 0 end),2) 'abril',
round(SUM(case when pd.mes=5 then monto else 0 end),2) 'mayo',
round(SUM(case when pd.mes=6 then monto else 0 end),2) 'junio',
round(SUM(case when pd.mes=7 then monto else 0 end),2) 'julio',
round(SUM(case when pd.mes=8 then monto else 0 end),2) 'agosto',
round(SUM(case when pd.mes=9 then monto else 0 end),2) 'setiembre',
round(SUM(case when pd.mes=10 then monto else 0 end),2) 'octubre',
round(SUM(case when pd.mes=11 then monto else 0 end),2) 'noviembre',
round(SUM(case when pd.mes=12 then monto else 0 end),2) 'diciembre'
FROM planilla_detalle pd
where SUBSTR(pd.codigo,1,2)='C2'
GROUP BY pd.anio
UNION ALL
SELECT pd.anio,'Aportes',
round(SUM(case when pd.mes=1 then monto else 0 end),2) 'enero',
round(SUM(case when pd.mes=2 then monto else 0 end),2) 'febrero',
round(SUM(case when pd.mes=3 then monto else 0 end),2) 'marzo',
round(SUM(case when pd.mes=4 then monto else 0 end),2) 'abril',
round(SUM(case when pd.mes=5 then monto else 0 end),2) 'mayo',
round(SUM(case when pd.mes=6 then monto else 0 end),2) 'junio',
round(SUM(case when pd.mes=7 then monto else 0 end),2) 'julio',
round(SUM(case when pd.mes=8 then monto else 0 end),2) 'agosto',
round(SUM(case when pd.mes=9 then monto else 0 end),2) 'setiembre',
round(SUM(case when pd.mes=10 then monto else 0 end),2) 'octubre',
round(SUM(case when pd.mes=11 then monto else 0 end),2) 'noviembre',
round(SUM(case when pd.mes=12 then monto else 0 end),2) 'diciembre'
FROM planilla_detalle pd
where SUBSTR(pd.codigo,1,2)='C3'
group By pd.anio) as t ORDER BY t.anio ASC''';
}

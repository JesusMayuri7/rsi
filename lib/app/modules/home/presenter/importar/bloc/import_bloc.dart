import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:salud_ilo/app/modules/home/domain/resumen_import_entity.dart';
import 'package:salud_ilo/core/uitls/db_provider.dart';
import 'package:salud_ilo/core/uitls/import_file.dart';

import '../../../domain/planilla_entity.dart';

part 'import_state.dart';

class ImportBloc extends Cubit<ImportState> {
  ImportBloc() : super(ImportInitial());

  insertPlanillaDetalle(int _anio, int _mes) async {
    emit(LoadingImportState());
    int registrosPlanilla = 0;
    PlanillaEntity? planillaEntity;
    double aportes = 0;
    double descuentos = 0;
    double ingresos = 0;
    try {
      //final db = await DBProvider.db.database;
      //await db.transaction((txn) async {
      //await txn. .deletePlanillaByAnioMes(anio, mes);
      deletePLanillaByAnioMes(_anio, _mes);
      List<PlanillaEntity> personalEntity = openPlanilla(_anio, _mes);
      for (int i = 0; i < personalEntity.length; i++) {
        if (personalEntity[i].planilla_detalle.isNotEmpty) {
          planillaEntity = personalEntity[i];
          int planillaId = await DBProvider.db.nuevaPlanilla(planillaEntity);
          registrosPlanilla++;
          //print(personalEntity[i].conceptos);
          await DBProvider.db.insertPlanillaDetalle(
              personalEntity[i].planilla_detalle, planillaId);
        }
      }
      if (registrosPlanilla > 0) {
        final Map resumenImport =
            await DBProvider.db.resumenImport(_anio, _mes);
        aportes = resumenImport['aportes'];
        descuentos = resumenImport['descuentos'];
        ingresos = resumenImport['ingresos'];
      }

      emit(ImportedPlanillaState(
          anio: _anio,
          mes: _mes,
          registros: registrosPlanilla,
          resumenImportEntity: ResumenImportEntity(
              aportes: aportes, descuentos: descuentos, ingresos: ingresos)));
      //});
    } catch (e) {
      emit(ErrorImportState(
          message: e.toString(), nombres: planillaEntity!.nombre!));
    }
  }

  List<PlanillaEntity> openPlanilla(int anio, int mes) {
    return openFile(anio, mes);
  }

  deletePLanillaByAnioMes(int anio, int mes) async {
    await DBProvider.db.deletePlanillaByAnioMes(anio, mes);
  }
}

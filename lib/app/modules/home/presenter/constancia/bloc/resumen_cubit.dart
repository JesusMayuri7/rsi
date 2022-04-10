import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:salud_ilo/app/modules/home/domain/resumenEntity.dart';
import 'package:salud_ilo/core/uitls/db_provider.dart';

import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:excel/excel.dart';
import 'package:equatable/equatable.dart';

import 'package:salud_ilo/core/uitls/universal_file/save_file_mobile.dart'
    if (dart.library.html) 'package:salud_ilo/core/uitls/universal_file/save_file_web.dart';

import 'generar_pdf.dart';

part 'resumen_state.dart';

class ResumenCubit extends Cubit<ResumenState> {
  ResumenCubit() : super(InitialResumenState());

  _generarPdf(ResumenEntity resumen) {
    // Create a new PDF document.
    final PdfDocument document = PdfDocument();
    document.pageSettings.size = PdfPageSize.a4;
    document.pageSettings.margins.all = 10.0;

    int rowMaxHoja = 40;
    num hojas = 1;
    if (resumen.conceptos.length > rowMaxHoja) {
      hojas = (resumen.conceptos.length ~/ rowMaxHoja) + 1;
    }
    int rowPrint = 0;

    String anioActual = resumen.conceptos[0].anio.toString();

    for (int h = 1; h <= hojas; h++) {
      PdfPage page = document.pages.add();
      //PdfGraphics graphics = page.graphics;
      //waterText(graphics);

      PdfLayoutResult? layoutResult = generarHeader(resumen, page, anioActual);

      final PdfGrid grid = PdfGrid();

      generarGridHeader(grid);
      int rowCount = 1;

      for (int conceptoIndex = rowPrint;
          conceptoIndex < resumen.conceptos.length;
          conceptoIndex++) {
        if (rowCount > rowMaxHoja) {
          rowPrint = conceptoIndex;
          rowCount = 1;
          anioActual = resumen.conceptos[conceptoIndex].anio.toString();
          break;
        }
        if (anioActual != resumen.conceptos[conceptoIndex].anio.toString()) {
          rowPrint = conceptoIndex;
          rowCount = 1;
          ;
          anioActual = resumen.conceptos[conceptoIndex].anio.toString();
          hojas += 1;

          break;
        }
        generarGridRow(grid, resumen.conceptos[conceptoIndex]);
        rowCount += 1;
      }
      layoutResult = printGrid(page, layoutResult, grid);
      footerPage(document, page, layoutResult);
    }

    generarNumberPage(document);

    datePrint(document);

    exportarPdf(document, resumen);
  }

  getPlanillaDetalle(int anioDesde, int anioA, String dni) async {
    emit(LoadingResumenState());
    try {
      var result = await DBProvider.db
          .getPlanillaDetalleByAnioAndDni(anioDesde, anioA, dni);
      if (result == ResumenEntity.empty()) print('igual');
      emit(LoadedResumenState(resumenEntity: result));
    } catch (e) {
      emit(ErrorResumenState(message: e.toString()));
    }

    //_generarPdf(ResumenEntity(dni: result.dni, nombres: result.nombres, conceptos: result.conceptos));
  }

  printConstancia() {
    if (state is LoadedResumenState) {
      if ((state as LoadedResumenState).resumenEntity.conceptos.isNotEmpty) {
        _generarPdf((state as LoadedResumenState).resumenEntity);
      }
    }
  }

  exportConstancia() {
    if (state is LoadedResumenState) {
      if ((state as LoadedResumenState).resumenEntity.conceptos.isNotEmpty) {
        _exportXLS((state as LoadedResumenState).resumenEntity);
      }
    }
  }

  _exportXLS(ResumenEntity resumenEntity) {
    var excel = Excel.createExcel();
    Sheet sheetObject = excel['Sheet1'];

    sheetObject.appendRow(['Dni : ' + resumenEntity.dni]);
    sheetObject.appendRow(['Nombres : ' + resumenEntity.nombres]);
    sheetObject.appendRow([
      'Año',
      'Concepto',
      'Enero',
      'Febrero',
      'Marzo',
      'Abril',
      'Mayo',
      'Junio',
      'Julio',
      'Agosto',
      'Setiembre',
      'Octubre',
      'Noviembre',
      'Diciembre',
      'Total'
    ]);
    for (int i = 0; i <= resumenEntity.conceptos.length - 1; i++) {
      sheetObject.appendRow([
        resumenEntity.conceptos[i].anio,
        resumenEntity.conceptos[i].concepto,
        resumenEntity.conceptos[i].enero,
        resumenEntity.conceptos[i].febrero,
        resumenEntity.conceptos[i].marzo,
        resumenEntity.conceptos[i].abril,
        resumenEntity.conceptos[i].mayo,
        resumenEntity.conceptos[i].junio,
        resumenEntity.conceptos[i].julio,
        resumenEntity.conceptos[i].agosto,
        resumenEntity.conceptos[i].setiembre,
        resumenEntity.conceptos[i].octubre,
        resumenEntity.conceptos[i].noviembre,
        resumenEntity.conceptos[i].diciembre,
        resumenEntity.conceptos[i].total,
      ]);
/*
      sheetObject
          .cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: i))
          .value = resumenEntity.conceptos[i].enero;
      sheetObject
          .cell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: i))
          .value = resumenEntity.conceptos[i].febrero;
          */
    }
    List<int>? fileBytes = excel.save();

    String outputFile = "${resumenEntity.dni}-${resumenEntity.nombres}.xlsx"
        .replaceAll(' ', '_');
    FileSaveHelper.saveAndLaunchFile(fileBytes!, outputFile);
  }
}

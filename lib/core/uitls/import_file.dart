import 'dart:io';
import 'package:excel/excel.dart';
import 'package:filepicker_windows/filepicker_windows.dart';
import 'package:salud_ilo/app/modules/home/domain/planilla_detalle_entity.dart';
import 'package:salud_ilo/app/modules/home/domain/planilla_entity.dart';

// USAR ARCHIVO XLSX
List<PlanillaEntity> openFile(int anio, int mes) {
  List<PlanillaEntity> excelEntityList = [];
  if (Platform.isWindows) {
    List<List<Object>> dataList = [];
    List<String> headings = [];
    final file = OpenFilePicker()
      ..filterSpecification = {
        'All Files': '*.*',
        'Xlsx Excel (*.xlsx)': '*.xlsx',
        'Xls (97-2003) (*.xls)': '*.xls',
      }
      ..defaultFilterIndex = 0
      ..defaultExtension = 'xls'
      ..title = 'Select a document';

    final result = file.getFile();
    if (result != null) {
      //result.readAsBytes();
      var bytes = result.readAsBytesSync();

      var excel = Excel.decodeBytes(bytes);

      for (var table in excel.tables.keys) {
        var header = excel.tables[table]!.rows[0];

        for (var row in excel.tables[table]!.rows
            .sublist(1, excel.tables[table]?.maxRows)) {
          PlanillaEntity excelEntity = PlanillaEntity();

          for (var i = 0; i < row.length; i++) {
            if (header.indexWhere((e) => e?.value == 'CODEJE') == i) {
              excelEntity.codEje = row[i]?.value;
            }
            if (header.indexWhere((e) => e?.value == 'CODFUN') == i) {
              excelEntity.codFun = row[i]?.value;
            }
            if (header.indexWhere((e) => e?.value == 'PLAZA') == i) {
              excelEntity.plaza = row[i]?.value;
            }
            if (header.indexWhere((e) => e?.value == 'NOMBRE') == i) {
              excelEntity.nombre = row[i]?.value;
            }
            if (header.indexWhere((e) => e?.value == 'CODCAR') == i) {
              excelEntity.codCar = row[i]?.value;
            }
            if (header.indexWhere((e) => e?.value == 'TIPOPLA') == i) {
              excelEntity.tipoPla = int.parse(row[i]?.value);
            }
            if (header.indexWhere((e) => e?.value == 'CODEST') == i) {
              excelEntity.codEst = row[i]?.value;
            }
            if (header.indexWhere((e) => e?.value == 'LIBELE') == i) {
              if (row[i]?.value == null ||
                  (row[i]?.value as String).length != 8) {
                break;
              }
              excelEntity.libEle = row[i]?.value;
            }
            if (header.indexWhere((e) => e?.value == 'REGIM') == i) {
              excelEntity.regim = row[i]?.value;
            }
            if (header.indexWhere((e) => e?.value == 'CODNIV') == i) {
              excelEntity.codNiv = row[i]?.value;
            }
            if (header.indexWhere((e) => e?.value == 'CODSIAF') == i) {
              excelEntity.codSiaf = row[i]?.value;
            }
            if (header.indexWhere((e) => e?.value == 'CONDIC') == i) {
              if (row[i]?.value is int) {
                excelEntity.condic = row[i]?.value;
              } else {
                excelEntity.condic = int.tryParse(row[i]?.value);
              }
            }
            excelEntity.anio = anio;
            excelEntity.mes = mes;
            //List<ConceptoEntity> conceptos = [];
            if (isConcepto(header[i]?.value)) {
              for (var item = i; item < row.length; item++) {
                if (row[item]?.value != null) {
                  if (row[item]?.value > 0) {
                    PlanillaDetalleEntity conceptoEntity =
                        PlanillaDetalleEntity(
                            anio: anio,
                            mes: mes,
                            dni: excelEntity.libEle,
                            codigo: header[item]?.value,
                            monto: double.parse(
                                row[item]?.value.toStringAsFixed(2)));
                    excelEntity.planilla_detalle.add(conceptoEntity);
                  }
                }
              }
              excelEntityList.add(excelEntity);
              break;
            }
          }
        }
        //print('data ' + excelEntityList.toString());
      }
    }
  }
  return excelEntityList;
}

bool isConcepto(String concepto) {
  final regExp = RegExp(r'^C([0-9]{4})$');
  return regExp.hasMatch(concepto.toUpperCase());
}

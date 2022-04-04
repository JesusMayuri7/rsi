import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as m;
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:salud_ilo/app/modules/home/domain/consolidado_entity.dart';
import 'package:salud_ilo/app/modules/home/presenter/importar/bloc/consolidado/consolidado_cubit.dart';

class ConsolidadoPage extends StatefulWidget {
  const ConsolidadoPage({Key? key}) : super(key: key);

  @override
  State<ConsolidadoPage> createState() => _ConsolidadoPageState();
}

class _ConsolidadoPageState extends State<ConsolidadoPage> {
  //final List<ConsolidadoEntity> consolidadoEntityList;
  @override
  Widget build(BuildContext context) {
//    BlocProvider.of<ConsolidadoCubit>(context, listen: false).getConsolidado();
    final List<PlutoColumn> columns = <PlutoColumn>[
      PlutoColumn(
          title: 'Año',
          field: 'anio',
          width: 55,
          enableFilterMenuItem: false,
          enableContextMenu: false,
          enableSorting: false,
          type: PlutoColumnType.text(),
          textAlign: PlutoColumnTextAlign.center,
          frozen: PlutoColumnFrozen.left),
      PlutoColumn(
          title: 'Tipo',
          field: 'tipo',
          width: 100,
          enableFilterMenuItem: false,
          enableContextMenu: false,
          enableSorting: false,
          type: PlutoColumnType.text(),
          textAlign: PlutoColumnTextAlign.left,
          frozen: PlutoColumnFrozen.left),
      PlutoColumn(
          title: 'Enero',
          field: 'enero',
          width: 100,
          enableFilterMenuItem: false,
          enableContextMenu: false,
          enableSorting: false,
          type: PlutoColumnType.number(format: '#,##0.00'),
          textAlign: PlutoColumnTextAlign.right),
      PlutoColumn(
          title: 'Febrero',
          field: 'febrero',
          width: 100,
          enableFilterMenuItem: false,
          enableContextMenu: false,
          enableSorting: false,
          type: PlutoColumnType.number(format: '#,##0.00'),
          textAlign: PlutoColumnTextAlign.right),
      PlutoColumn(
          title: 'Marzo',
          field: 'marzo',
          width: 100,
          enableFilterMenuItem: false,
          enableContextMenu: false,
          enableSorting: false,
          type: PlutoColumnType.number(format: '#,##0.00'),
          textAlign: PlutoColumnTextAlign.right),
      PlutoColumn(
          title: 'Abril',
          field: 'abril',
          width: 100,
          enableFilterMenuItem: false,
          enableContextMenu: false,
          enableSorting: false,
          type: PlutoColumnType.number(format: '#,##0.00'),
          textAlign: PlutoColumnTextAlign.right),
      PlutoColumn(
          title: 'Mayo',
          field: 'mayo',
          width: 100,
          enableFilterMenuItem: false,
          enableContextMenu: false,
          enableSorting: false,
          type: PlutoColumnType.number(format: '#,##0.00'),
          textAlign: PlutoColumnTextAlign.right),
      PlutoColumn(
          title: 'Junio',
          field: 'junio',
          width: 100,
          enableFilterMenuItem: false,
          enableContextMenu: false,
          enableSorting: false,
          type: PlutoColumnType.number(format: '#,##0.00'),
          textAlign: PlutoColumnTextAlign.right),
      PlutoColumn(
          title: 'Julio',
          field: 'julio',
          width: 100,
          enableFilterMenuItem: false,
          enableContextMenu: false,
          enableSorting: false,
          type: PlutoColumnType.number(format: '#,##0.00'),
          textAlign: PlutoColumnTextAlign.right),
      PlutoColumn(
          title: 'Agosto',
          field: 'agosto',
          width: 100,
          enableFilterMenuItem: false,
          enableContextMenu: false,
          enableSorting: false,
          type: PlutoColumnType.number(format: '#,##0.00'),
          textAlign: PlutoColumnTextAlign.right),
      PlutoColumn(
          title: 'Setiembre',
          field: 'setiembre',
          width: 100,
          enableFilterMenuItem: false,
          enableContextMenu: false,
          enableSorting: false,
          type: PlutoColumnType.number(format: '#,##0.00'),
          textAlign: PlutoColumnTextAlign.right),
      PlutoColumn(
          title: 'Noviembre',
          field: 'noviembre',
          width: 100,
          enableFilterMenuItem: false,
          enableContextMenu: false,
          enableSorting: false,
          type: PlutoColumnType.number(format: '#,##0.00'),
          textAlign: PlutoColumnTextAlign.right),
      PlutoColumn(
          title: 'Diciembre',
          field: 'diciembre',
          width: 100,
          enableFilterMenuItem: false,
          enableContextMenu: false,
          enableSorting: false,
          type: PlutoColumnType.number(format: '#,##0.00'),
          textAlign: PlutoColumnTextAlign.right),
    ];
    return Expanded(
      child: BlocBuilder<ConsolidadoCubit, ConsolidadoState>(
        builder: (context, state) {
          if (state is ConsolidadoLoaded) {
            return m.Material(
              child: Center(
                child: Column(
                  children: [
                    const Text('Planillas Importadas'),
                    Expanded(
                      child: PlutoGrid(
                        configuration: const PlutoGridConfiguration(
                          rowHeight: 25,
                        ),
                        columns: columns,
                        rows: rowsByColumns(
                            consolidadoEntityList: (state as ConsolidadoLoaded)
                                .consolidadoEntityList,
                            columns: columns),
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Center(child: m.CircularProgressIndicator());
          }
        },
      ),
    );
  }

  List<PlutoRow> rowsByColumns(
      {required List<ConsolidadoEntity> consolidadoEntityList,
      List<PlutoColumn>? columns}) {
    return List.generate(consolidadoEntityList.length,
            (index) => rowByColumns(columns!, index, consolidadoEntityList))
        .toList();
  }

  PlutoRow rowByColumns(List<PlutoColumn> columns, rowIndex,
      List<ConsolidadoEntity> _consolidadoEntityList) {
    final cells = <String, PlutoCell>{};
    cells['anio'] =
        PlutoCell(value: _consolidadoEntityList[rowIndex].anio.toString());
    cells['tipo'] = PlutoCell(value: _consolidadoEntityList[rowIndex].tipo);
    cells['enero'] = PlutoCell(value: _consolidadoEntityList[rowIndex].enero);
    cells['febrero'] =
        PlutoCell(value: _consolidadoEntityList[rowIndex].febrero);
    cells['marzo'] = PlutoCell(value: _consolidadoEntityList[rowIndex].marzo);
    cells['abril'] = PlutoCell(value: _consolidadoEntityList[rowIndex].abril);
    cells['mayo'] = PlutoCell(value: _consolidadoEntityList[rowIndex].mayo);
    cells['junio'] = PlutoCell(value: _consolidadoEntityList[rowIndex].junio);
    cells['julio'] = PlutoCell(value: _consolidadoEntityList[rowIndex].julio);
    cells['agosto'] = PlutoCell(value: _consolidadoEntityList[rowIndex].agosto);
    cells['setiembre'] =
        PlutoCell(value: _consolidadoEntityList[rowIndex].setiembre);
    cells['octubre'] =
        PlutoCell(value: _consolidadoEntityList[rowIndex].octubre);
    cells['noviembre'] =
        PlutoCell(value: _consolidadoEntityList[rowIndex].noviembre);
    cells['diciembre'] =
        PlutoCell(value: _consolidadoEntityList[rowIndex].diciembre);

    /*  for (var column in columns) {
      cells[column.field] = PlutoCell(
        value: (PlutoColumn element) {
          print(_consolidadoEntityList[rowIndex].toString());
          _consolidadoEntityList[rowIndex].toMap().values;
        }(column),
      );*/

    return PlutoRow(cells: cells);
  }
}

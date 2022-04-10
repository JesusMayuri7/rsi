import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as m;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../../domain/grid_entity.dart';
import '../../domain/resumenEntity.dart';
import 'bloc/resumen_cubit.dart';

class ConstanciaGridPage extends StatefulWidget {
  const ConstanciaGridPage({Key? key}) : super(key: key);

  @override
  State<ConstanciaGridPage> createState() => _ConstanciaGridPageState();
}

class _ConstanciaGridPageState extends State<ConstanciaGridPage> {
  //final List<ResumenEntity> resumenEntityList;
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
          title: 'Concepto',
          field: 'concepto',
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
      PlutoColumn(
          title: 'Total',
          field: 'total',
          width: 100,
          enableFilterMenuItem: false,
          enableContextMenu: false,
          enableSorting: false,
          type: PlutoColumnType.number(format: '#,##0.00'),
          textAlign: PlutoColumnTextAlign.right),
    ];
    return Expanded(
      child: BlocBuilder<ResumenCubit, ResumenState>(
        builder: (context, state) {
          if (state is LoadedResumenState) {
            return m.Material(
              child: Center(
                child: Column(
                  children: [
                    const Text('Planilla'),
                    Expanded(
                      child: PlutoGrid(
                        configuration: const PlutoGridConfiguration(
                          rowHeight: 25,
                        ),
                        columns: columns,
                        rows: (state as LoadedResumenState)
                                .resumenEntity
                                .conceptos
                                .isEmpty
                            ? []
                            : rowsByColumns(
                                resumenEntityList:
                                    (state as LoadedResumenState).resumenEntity,
                                columns: columns),
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else if (state is LoadingResumenState) {
            return Center(child: m.CircularProgressIndicator());
          } else
            return Center(
              child: Container(
                child: Text('Sin datos'),
              ),
            );
        },
      ),
    );
  }

  List<PlutoRow> rowsByColumns(
      {required ResumenEntity resumenEntityList, List<PlutoColumn>? columns}) {
    return List.generate(
            resumenEntityList.conceptos.length,
            (index) =>
                rowByColumns(columns!, index, resumenEntityList.conceptos))
        .toList();
  }

  PlutoRow rowByColumns(List<PlutoColumn> columns, rowIndex,
      List<GridEntity> _conceptoEntityList) {
    final cells = <String, PlutoCell>{};
    cells['anio'] =
        PlutoCell(value: _conceptoEntityList[rowIndex].anio.toString());
    cells['concepto'] =
        PlutoCell(value: _conceptoEntityList[rowIndex].concepto);
    cells['enero'] = PlutoCell(value: _conceptoEntityList[rowIndex].enero);
    cells['febrero'] = PlutoCell(value: _conceptoEntityList[rowIndex].febrero);
    cells['marzo'] = PlutoCell(value: _conceptoEntityList[rowIndex].marzo);
    cells['abril'] = PlutoCell(value: _conceptoEntityList[rowIndex].abril);
    cells['mayo'] = PlutoCell(value: _conceptoEntityList[rowIndex].mayo);
    cells['junio'] = PlutoCell(value: _conceptoEntityList[rowIndex].junio);
    cells['julio'] = PlutoCell(value: _conceptoEntityList[rowIndex].julio);
    cells['agosto'] = PlutoCell(value: _conceptoEntityList[rowIndex].agosto);
    cells['setiembre'] =
        PlutoCell(value: _conceptoEntityList[rowIndex].setiembre);
    cells['octubre'] = PlutoCell(value: _conceptoEntityList[rowIndex].octubre);
    cells['noviembre'] =
        PlutoCell(value: _conceptoEntityList[rowIndex].noviembre);
    cells['diciembre'] =
        PlutoCell(value: _conceptoEntityList[rowIndex].diciembre);
    cells['total'] = PlutoCell(value: _conceptoEntityList[rowIndex].diciembre);

    /*  for (var column in columns) {
      cells[column.field] = PlutoCell(
        value: (PlutoColumn element) {
          print(_conceptoEntityList[rowIndex].toString());
          _conceptoEntityList[rowIndex].toMap().values;
        }(column),
      );*/

    return PlutoRow(cells: cells);
  }
}

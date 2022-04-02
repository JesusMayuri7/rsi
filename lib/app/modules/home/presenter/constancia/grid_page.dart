//import 'package:fluent_ui/fluent_ui.dart' as fluent_ui;
import 'package:collection/collection.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:salud_ilo/app/modules/home/domain/resumenEntity.dart';

import '../../domain/grid_entity.dart';
import 'bloc/resumen_cubit.dart';

class GridPage extends StatefulWidget {
  GridPage({Key? key}) : super(key: key);

  @override
  State<GridPage> createState() => _GridPageState();
}

class _GridPageState extends State<GridPage> {
  final List<Map> _books = [
    {'id': 100, 'title': 'Flutter Basics', 'author': 'David John'},
    {'id': 101, 'title': 'Flutter Basics', 'author': 'David John'},
    {'id': 102, 'title': 'Git and GitHub', 'author': 'Merlin Nick'}
  ];
  // final bloc = sl.ge

  @override
  Widget build(BuildContext context) {
    return Material(child: _createDataTable());
  }

  Widget _createDataTable() {
    return BlocBuilder<ResumenCubit, ResumenState>(
      builder: (context, state) {
        if (state is LoadingResumenState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ErrorResumenState) {
          return Center(child: Text(state.message));
        } else {
          if (state is LoadedResumenState) {
            ResumenEntity resumenEntity = state.resumenEntity;

            if ((state).resumenEntity.conceptos.isEmpty) {
              return Center(
                  child: Container(
                      child: const Text(
                          'No hay datos para el rango seleccionado')));
            }
            return Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: Column(
                children: [
                  Container(
                      alignment: Alignment.center,
                      child: Text(
                          resumenEntity.dni + ' - ' + resumenEntity.nombres)),
                  Expanded(
                    child: ScrollConfiguration(
                      behavior: ScrollConfiguration.of(context)
                          .copyWith(dragDevices: {
                        PointerDeviceKind.touch,
                        PointerDeviceKind.mouse,
                      }),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: DataTable(
                              key: const ValueKey('contanciaKey'),
                              /*border: const TableBorder(
                            verticalInside: BorderSide(color: Colors.black)),*/
                              //headingRowColor: MaterialStateColor.resolveWith((states) => Colors.amber[100]!),
                              columnSpacing: 30.0,
                              showCheckboxColumn: false,
                              headingRowHeight: 20,
                              dataRowHeight: 20,
                              columns: resumenEntity.conceptos.isEmpty
                                  ? []
                                  : _createColumns(),
                              rows: resumenEntity.conceptos.isEmpty
                                  ? []
                                  : _createRows(resumenEntity.conceptos)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
          return Container(child: const Text('NO hay datos'));
        }
      },
    );
  }

  List<DataColumn> _createColumns() {
    return const [
      DataColumn(label: Text('Año', style: TextStyle(fontSize: 12))),
      DataColumn(label: Text('Concepto', style: TextStyle(fontSize: 12))),
      DataColumn(label: Text('Enero', style: TextStyle(fontSize: 12))),
      DataColumn(label: Text('Febrero', style: TextStyle(fontSize: 12))),
      DataColumn(label: Text('Marzo', style: TextStyle(fontSize: 12))),
      DataColumn(label: Text('Abril', style: TextStyle(fontSize: 12))),
      DataColumn(label: Text('Mayo', style: TextStyle(fontSize: 12))),
      DataColumn(label: Text('Junio', style: TextStyle(fontSize: 12))),
      DataColumn(label: Text('Julio', style: TextStyle(fontSize: 12))),
      DataColumn(label: Text('Agosto', style: TextStyle(fontSize: 12))),
      DataColumn(label: Text('Setiembre', style: TextStyle(fontSize: 12))),
      DataColumn(label: Text('Octubre', style: TextStyle(fontSize: 12))),
      DataColumn(label: Text('Noviembre', style: TextStyle(fontSize: 12))),
      DataColumn(label: Text('Diciembre', style: TextStyle(fontSize: 12))),
      DataColumn(label: Text('Total', style: TextStyle(fontSize: 12)))
    ];
  }

  List<DataRow> _createRows(List<GridEntity> _resumenEntity) {
    return _resumenEntity
        .mapIndexed((index, book) => DataRow(
            color: MaterialStateColor.resolveWith((states) {
              return book.concepto == 'Ingresos' ||
                      book.concepto == 'Descuentos' ||
                      book.concepto == 'Aportes'
                  ? Colors.grey[200]!
                  : Colors.transparent; //make tha magic!
            }),
            cells: [
              (index == 0)
                  ? DataCell(Container(
                      decoration: const BoxDecoration(
                          border: Border(
                              bottom:
                                  BorderSide(color: Colors.blue, width: 2.0))),
                      child: Text(book.anio.toString()),
                      // color: Colors.green,
                    ))
                  : (_resumenEntity[index].anio !=
                          _resumenEntity[index - 1].anio)
                      ? DataCell(Container(
                          decoration: const BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      color: Colors.blue, width: 2.0))),
                          child: Text(book.anio.toString()),
                        ))
                      : DataCell(Text(book.anio.toString())),
              //DataCell(Text(book.anio.toString())),
              DataCell(Text(
                book.concepto,
              )),
              DataCell(Container(
                  alignment: Alignment.centerRight,
                  child: Text(
                      NumberFormat('#,##0.00', 'en_US').format(book.enero)))),
              DataCell(Container(
                  alignment: Alignment.centerRight,
                  child: Text(
                      NumberFormat('#,##0.00', 'en_US').format(book.febrero)))),
              DataCell(Container(
                  alignment: Alignment.centerRight,
                  child: Text(
                      NumberFormat('#,##0.00', 'en_US').format(book.marzo)))),
              DataCell(Container(
                  alignment: Alignment.centerRight,
                  child: Text(
                      NumberFormat('#,##0.00', 'en_US').format(book.abril)))),
              DataCell(Container(
                  alignment: Alignment.centerRight,
                  child: Text(
                      NumberFormat('#,##0.00', 'en_US').format(book.mayo)))),
              DataCell(Container(
                  alignment: Alignment.centerRight,
                  child: Text(
                      NumberFormat('#,##0.00', 'en_US').format(book.junio)))),
              DataCell(Container(
                  alignment: Alignment.centerRight,
                  child: Text(
                      NumberFormat('#,##0.00', 'en_US').format(book.julio)))),
              DataCell(Container(
                  alignment: Alignment.centerRight,
                  child: Text(
                      NumberFormat('#,##0.00', 'en_US').format(book.agosto)))),
              DataCell(Container(
                  alignment: Alignment.centerRight,
                  child: Text(NumberFormat('#,##0.00', 'en_US')
                      .format(book.setiembre)))),
              DataCell(Container(
                  alignment: Alignment.centerRight,
                  child: Text(
                      NumberFormat('#,##0.00', 'en_US').format(book.octubre)))),
              DataCell(Container(
                  alignment: Alignment.centerRight,
                  child: Text(NumberFormat('#,##0.00', 'en_US')
                      .format(book.noviembre)))),
              DataCell(Container(
                  alignment: Alignment.centerRight,
                  child: Text(NumberFormat('#,##0.00', 'en_US')
                      .format(book.diciembre)))),
              DataCell(Container(
                  alignment: Alignment.centerRight,
                  child: Text(
                      NumberFormat('#,##0.00', 'en_US').format(book.total))))
            ],
            onSelectChanged: (bool? selected) {
              setState(() {});
            }))
        .toList();
  }
}

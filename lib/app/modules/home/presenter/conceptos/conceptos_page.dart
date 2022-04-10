//import 'package:fluent_ui/fluent_ui.dart' as fluent_ui;
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:collection/collection.dart';
import 'package:excel/excel.dart';
import 'package:fluent_ui/fluent_ui.dart' as f;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/concepto_entity.dart';

import 'concepto_detalle_page.dart';
import 'cubit/conceptos_cubit.dart';

class ConceptosPage extends StatefulWidget {
  const ConceptosPage({Key? key}) : super(key: key);

  @override
  State<ConceptosPage> createState() => _GridPageState();
}

class _GridPageState extends State<ConceptosPage> {
  @override
  Widget build(BuildContext context) {
    appWindow.title = 'Conceptos';
    return Material(child: _createDataTable());
  }

  Widget _createDataTable() {
    return BlocConsumer<ConceptosCubit, ConceptosState>(
        listener: (context, state) => {
              if (state is SavedConceptosState)
                {
                  Navigator.pop(context),
                  f.showSnackbar(
                      context,
                      f.Snackbar(
                          content: Container(
                        child: const Text('Concepto guardado'),
                        color: const Color.fromARGB(0, 245, 73, 4),
                      ))),
                  BlocProvider.of<ConceptosCubit>(context).getConceptos()
                }
            },
        builder: (context, state) {
          return f.Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                        alignment: Alignment.center,
                        child: f.Button(
                          child: const f.Text('Nuevo'),
                          onPressed: () => editOrNewConceptoDetalle(
                              ConceptoEntity(
                                  id: 0,
                                  modalidad: 1,
                                  codigo: '',
                                  naturaleza: '',
                                  abreviatura: '',
                                  descripcion: '',
                                  tipo: 'Ingresos'),
                              context),
                        )),
                    const f.SizedBox(width: 10),
                    f.Button(
                        child: const f.Text('Actualizar'),
                        onPressed: () =>
                            BlocProvider.of<ConceptosCubit>(context)
                                .getConceptos()),
                  ],
                ),
                const f.SizedBox(height: 10),
                if (state is LoadingConceptosState)
                  const Center(child: CircularProgressIndicator())
                else if (state is LoadedConceptosState)
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
                            key: const ValueKey('conceptosKey'),
                            headingRowColor: MaterialStateColor.resolveWith(
                              (states) {
                                return f.Color.fromARGB(221, 201, 235, 235);
                              },
                            ),
                            /*border: const TableBorder(
                                verticalInside: BorderSide(color: Colors.black)),*/
                            //headingRowColor: MaterialStateColor.resolveWith((states) => Colors.amber[100]!),
                            columnSpacing: 0.0,
                            showCheckboxColumn: false,
                            headingRowHeight: 20,
                            dataRowHeight: 20,
                            columns: _createColumns(),
                            rows: _createRows(
                                (state as LoadedConceptosState).conceptos),
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          );
        });
  }

  List<DataColumn> _createColumns() {
    return const [
      DataColumn(label: Text('Modalidad', style: TextStyle(fontSize: 12))),
      DataColumn(label: Text('Codigo', style: TextStyle(fontSize: 12))),
      DataColumn(label: Text('Naturaleza', style: TextStyle(fontSize: 12))),
      DataColumn(label: Text('Abreviatura', style: TextStyle(fontSize: 12))),
      DataColumn(label: Text('Descripcion', style: TextStyle(fontSize: 12))),
      DataColumn(label: Text('Tipo', style: TextStyle(fontSize: 12))),
    ];
  }

  List<DataRow> _createRows(List<ConceptoEntity> _conceptosEntity) {
    return _conceptosEntity
        .mapIndexed((index, book) => DataRow(
            color: MaterialStateColor.resolveWith((states) {
              return book.codigo == 'Ingresos'
                  ? Colors.grey[200]!
                  : Colors.transparent; //make tha magic!
            }),
            cells: [
              (index == 0)
                  ? DataCell(Container(
                      width: 65,
                      decoration: const BoxDecoration(
                          border: Border(
                              bottom:
                                  BorderSide(color: Colors.blue, width: 2.0))),
                      child: Text(book.modalidad.toString()),
                      // color: Colors.green,
                    ))
                  : (_conceptosEntity[index].modalidad !=
                          _conceptosEntity[index - 1].modalidad)
                      ? DataCell(Container(
                          width: 65,
                          decoration: const BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      color: Colors.blue, width: 2.0))),
                          child: Text(book.modalidad.toString()),
                        ))
                      : DataCell(Container(
                          width: 65, child: Text(book.modalidad.toString()))),
              DataCell(
                  Container(width: 50.0, child: Text(book.codigo.toString()))),
              DataCell(Container(
                width: 70,
                child: Text(
                  book.naturaleza,
                ),
              )),
              DataCell(Container(
                width: 80.0,
                child: Text(
                  book.abreviatura,
                ),
              )),
              DataCell(Container(
                  alignment: Alignment.centerLeft,
                  child: Text(book.descripcion))),
              DataCell(Container(
                  width: 80.0,
                  alignment: Alignment.centerLeft,
                  child: Text(book.tipo)))
            ],
            onSelectChanged: (bool? selected) {
              if (selected!) {
                editConceptoDetalle(_conceptosEntity[index], context);
              }
              //setState(() {});
            }))
        .toList();
  }

  editConceptoDetalle(ConceptoEntity concepto, BuildContext _context) {
    return showDialog(
        context: _context,
        builder: (context) {
          return Center(
            child: Container(
                color: Colors.amber,
                height: 360,
                width: 350,
                child: ConceptoDetallePage(
                  context2: _context,
                  conceptoEntity: concepto,
                )),
          );
        });
  }

  editOrNewConceptoDetalle(ConceptoEntity concepto, BuildContext _context) {
    return showDialog(
        context: _context,
        builder: (context) {
          return Center(
            child: Container(
                color: Colors.amber,
                height: 360,
                width: 350,
                child: ConceptoDetallePage(
                    context2: _context, conceptoEntity: concepto)),
          );
        });
  }
}

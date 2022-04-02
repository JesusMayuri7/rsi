import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:fluent_ui/fluent_ui.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import 'bloc/import_bloc.dart';

class ImportPage extends StatefulWidget {
  ImportPage({Key? key}) : super(key: key);

  @override
  State<ImportPage> createState() => _ImportPageState();
}

class _ImportPageState extends State<ImportPage> {
  List<String> nameMeses = [
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
    'Diciembre'
  ];
  int mes = 0;
  var maskFormatter = MaskTextInputFormatter(
      mask: '####',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);
  TextEditingController anioSelected = TextEditingController();

  @override
  Widget build(BuildContext context) {
    appWindow.title = 'Importar Planilla';
    return BlocConsumer<ImportBloc, ImportState>(
      listener: (context, state) {
        if (state is ImportedPlanillaState) {
          showDialog(
              context: context,
              builder: (context) {
                return ContentDialog(
                    title: const Text('Planilla Importada'),
                    actions: [
                      Button(
                          child: const Text('Aceptar'),
                          onPressed: () {
                            Navigator.pop(context);
                          })
                    ],
                    content: Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Año: ' + state.anio.toString()),
                          Text('Mes ' + nameMeses[state.mes - 1]),
                          Text(
                              'Total registros: ' + state.registros.toString()),
                          Text('Total ingresos: S/. ' +
                              NumberFormat('#,##0.00', 'en_US')
                                  .format(state.resumenImportEntity.ingresos)),
                          Text('Total descuentos: S/. ' +
                              NumberFormat('#,##0.00', 'en_US').format(
                                  state.resumenImportEntity.descuentos)),
                          Text('Total aportes: S/. ' +
                              NumberFormat('#,##0.00', 'en_US')
                                  .format(state.resumenImportEntity.aportes)),
                        ],
                      ),
                    ));
              });
        }
        if (state is ErrorImportState) {
          showDialog(
              context: context,
              builder: (context) {
                return ContentDialog(
                    title: const Text('Error al importar'),
                    actions: [
                      Button(
                          child: const Text('Aceptar'),
                          onPressed: () {
                            Navigator.pop(context);
                          })
                    ],
                    content: Container(
                      child: Text('Error :  ' + state.message,
                          maxLines: 20, overflow: TextOverflow.ellipsis),
                    ));
              });
        }
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                      width: 60,
                      child: InfoLabel(
                        label: 'Año',
                        child: TextBox(
                          inputFormatters: [maskFormatter],
                          controller: anioSelected,
                          padding: const EdgeInsets.only(left: 2, bottom: 2),
                          style: const TextStyle(fontSize: 12),
                          textAlignVertical: TextAlignVertical.center,
                        ),
                      )),
                  const SizedBox(width: 10.0),
                  InfoLabel(label: 'Mes', child: mesesDropButton()),
                  const SizedBox(width: 10.0),
                  Container(
                    width: 100,
                    child: InfoLabel(
                      label: '',
                      child: Button(
                          onPressed: () {
                            if ((anioSelected.text.isEmpty) ||
                                (anioSelected.text.length != 4)) {
                              showSnackbar(
                                  context,
                                  Snackbar(
                                      content: Container(
                                    child: const Text('Año inválido'),
                                    color: const Color.fromARGB(0, 245, 73, 4),
                                  )));
                            } else {
                              (state is LoadingImportState)
                                  ? null
                                  : BlocProvider.of<ImportBloc>(context,
                                          listen: false)
                                      .insertPlanillaDetalle(
                                          int.parse(anioSelected.text),
                                          mes + 1);
                            }
                          },
                          child: (state is LoadingImportState)
                              ? const Center(
                                  child: SizedBox(
                                    height: 16,
                                    width: 16,
                                    child: ProgressRing(
                                      strokeWidth: 2.5,
                                      backgroundColor: Colors.transparent,
                                    ),
                                  ),
                                )
                              : const Text('Importar')),
                    ),
                  ),
                  Spacer(),
                  Container(
                    width: 100,
                    child: InfoLabel(
                      label: '',
                      child: Button(
                          onPressed: () {
                            if ((anioSelected.text.isEmpty) ||
                                (anioSelected.text.length != 4)) {
                              showSnackbar(
                                  context,
                                  Snackbar(
                                      content: Container(
                                    child: const Text('Año inválido'),
                                    color: const Color.fromARGB(0, 245, 73, 4),
                                  )));
                            } else {
                              (state is LoadingImportState)
                                  ? null
                                  : BlocProvider.of<ImportBloc>(context,
                                          listen: false)
                                      .deletePLanillaByAnioMes(
                                          int.parse(anioSelected.text),
                                          mes + 1);
                            }
                          },
                          child: (state is LoadingImportState)
                              ? const Center(
                                  child: SizedBox(
                                    height: 16,
                                    width: 16,
                                    child: ProgressRing(
                                      strokeWidth: 2.5,
                                      backgroundColor: Colors.transparent,
                                    ),
                                  ),
                                )
                              : const Text('Eliminar')),
                    ),
                  )
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget mesesDropButton() {
    return DropDownButton(
        title: Text(nameMeses[mes], style: TextStyle(fontSize: 12)),
        items: nameMeses
            .map((e) => DropDownButtonItem(
                title: Text(
                  e,
                  style: FluentTheme.of(context).typography.body,
                ),
                onTap: () => setState(() {
                      mes = nameMeses.indexOf(e);
                    })))
            .toList());
  }
}

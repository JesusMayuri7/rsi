import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

//import 'package:flutter/material.dart';

import 'bloc/resumen_cubit.dart';

class HeaderPage extends StatefulWidget {
  HeaderPage({Key? key}) : super(key: key);

  @override
  State<HeaderPage> createState() => _HeaderPageState();
}

class _HeaderPageState extends State<HeaderPage> {
  //var win = appWindow;

  TextEditingController dni = TextEditingController()..text = '';
  TextEditingController anioDesde = TextEditingController()..text = '';
  TextEditingController anioA = TextEditingController()..text = '';

  var maskFormatter = MaskTextInputFormatter(
      mask: '####',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);
  //final blocResumen = Modular.get<CounterCubit>();
  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.start, children: [
      Container(
          width: 80,
          child: TextBox(
            header: 'Dni',
            controller: dni,
            padding: const EdgeInsets.only(left: 2, bottom: 2),
            style: const TextStyle(fontSize: 12),
            textAlignVertical: TextAlignVertical.center,
          )),
      const SizedBox(width: 10),
      Container(
          width: 60,
          child: TextBox(
            //enabled: false,
            inputFormatters: <TextInputFormatter>[maskFormatter],
            controller: anioDesde,
            placeholder: 'Año',
            header: 'Desde',
            padding: const EdgeInsets.only(left: 2, bottom: 2),
            style: const TextStyle(fontSize: 12),
            textAlignVertical: TextAlignVertical.center,
          )),
      const SizedBox(width: 10),
      Container(
          width: 60,
          child: TextBox(
            //enabled: false,
            inputFormatters: <TextInputFormatter>[maskFormatter],
            controller: anioA,
            placeholder: 'Año',
            header: 'A',
            padding: const EdgeInsets.only(left: 2, bottom: 2),
            style: const TextStyle(fontSize: 12),
            textAlignVertical: TextAlignVertical.center,
          )),
      const SizedBox(
        width: 10,
      ),
      const SizedBox(width: 8.0),
      InfoLabel(
        label: '',
        child: Button(
            onPressed: () {
              if ((anioDesde.text.isEmpty) ||
                  (int.parse(anioDesde.text) > int.parse(anioA.text))) {
                showSnackbar(
                    context,
                    Snackbar(
                        content: Container(
                      child: const Text('Año inválido'),
                      color: const Color.fromARGB(0, 245, 73, 4),
                    )));
              } else {
                BlocProvider.of<ResumenCubit>(context, listen: false)
                    .getPlanillaDetalle(
                        int.parse(anioDesde.text),
                        int.parse(
                            anioA.text.isEmpty ? anioDesde.text : anioA.text),
                        dni.text);
              }
              /*
              sl.get<ResumenCubit>().getPlanillaDetalle(
                  int.parse(anioDesde.text),
                  int.parse(anioA.text.isEmpty ? anioDesde.text : anioA.text),
                  dni.text);

              context.read<ResumenCubit>().getPlanillaDetalle(
                  int.parse(anioDesde.text),
                  int.parse(anioA.text.isEmpty ? anioDesde.text : anioA.text),
                  dni.text);
                  */
            },
            child: const Text('Consultar')),
      ),
      Spacer(),
      InfoLabel(
        label: '',
        child: Button(
            onPressed: () {
              BlocProvider.of<ResumenCubit>(context, listen: false)
                  .exportConstancia();
            },
            child: const Text('Exportar')),
      ),
      const SizedBox(width: 10.0),
      InfoLabel(
        label: '',
        child: Button(
            onPressed: () {
              BlocProvider.of<ResumenCubit>(context, listen: false)
                  .printConstancia();
            },
            child: const Text('Imprimir')),
      ),
    ]);
  }
}

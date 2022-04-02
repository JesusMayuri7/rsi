import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:salud_ilo/app/modules/home/domain/concepto_entity.dart';

import 'cubit/conceptos_cubit.dart';

class ConceptoDetallePage extends StatefulWidget {
  const ConceptoDetallePage({
    Key? key,
    required this.context2,
    required this.conceptoEntity,
  }) : super(key: key);

  final BuildContext context2;
  final ConceptoEntity conceptoEntity;

  @override
  State<ConceptoDetallePage> createState() => _ConceptoDetallePageState();
}

class _ConceptoDetallePageState extends State<ConceptoDetallePage> {
  List<String> modalidad = [
    'Administrativo',
    'Contratado',
    'Pensionista',
    'Asistencial'
  ];
  List<String> tipos = [
    'Ingresos',
    'Descuentos',
    'Aportes',
  ];
  int modalidadSelected = 0;

  String tipoSelected = 'Ingresos';

  TextEditingController modalidadController = TextEditingController();
  TextEditingController codigoController = TextEditingController();
  TextEditingController naturalezaController = TextEditingController();
  TextEditingController abreviaturaController = TextEditingController();
  TextEditingController descripcionController = TextEditingController();
  TextEditingController tipoController = TextEditingController();

  @override
  void initState() {
    print(widget.conceptoEntity.toString());
    modalidadSelected = widget.conceptoEntity.modalidad - 1;
    codigoController.text = widget.conceptoEntity.codigo;
    naturalezaController.text = widget.conceptoEntity.naturaleza;
    abreviaturaController.text = widget.conceptoEntity.abreviatura;
    descripcionController.text = widget.conceptoEntity.descripcion;
    tipoSelected = widget.conceptoEntity.tipo[0].toUpperCase() +
        widget.conceptoEntity.tipo.substring(1).toLowerCase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Builder(builder: (context) {
          return Column(
            children: [
              Container(
                child: Text('Concepto'),
              ),
              modalidadDropButton(modalidad),
              codigoText(),
              naturalezaText(),
              abreviaturaText(),
              descripcionText(),
              tipoDropButton(tipos),
              const SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [saveButton(), cancelButton()],
              )
            ],
          );
        }),
      ),
    );
  }

  Widget codigoText() {
    return Container(
      alignment: Alignment.centerLeft,
      child: InfoLabel(
        label: 'Codigo',
        child: Container(
          width: 100,
          child: TextBox(
            controller: codigoController,
            placeholder: 'CXXXX',
            padding: const EdgeInsets.only(left: 2, bottom: 2),
            style: const TextStyle(fontSize: 12),
            textAlignVertical: TextAlignVertical.center,
          ),
        ),
      ),
    );
  }

  Widget naturalezaText() {
    return Container(
      alignment: Alignment.centerLeft,
      child: InfoLabel(
        label: 'Naturaleza',
        child: Container(
          width: 100,
          child: TextBox(
            controller: naturalezaController,
            placeholder: 'X',
            padding: const EdgeInsets.only(left: 2, bottom: 2),
            style: const TextStyle(fontSize: 12),
            textAlignVertical: TextAlignVertical.center,
          ),
        ),
      ),
    );
  }

  Widget abreviaturaText() {
    return Container(
      alignment: Alignment.centerLeft,
      child: InfoLabel(
        label: 'Abreviatura',
        child: Container(
          width: 100,
          child: TextBox(
            controller: abreviaturaController,
            placeholder: 'X',
            padding: const EdgeInsets.only(left: 2, bottom: 2),
            style: const TextStyle(fontSize: 12),
            textAlignVertical: TextAlignVertical.center,
          ),
        ),
      ),
    );
  }

  Widget descripcionText() {
    return Container(
      alignment: Alignment.centerLeft,
      child: InfoLabel(
        label: 'Descripcion',
        child: Container(
          width: 300,
          child: TextBox(
            controller: descripcionController,
            placeholder: 'X',
            padding: const EdgeInsets.only(left: 2, bottom: 2),
            style: const TextStyle(fontSize: 12),
            textAlignVertical: TextAlignVertical.center,
          ),
        ),
      ),
    );
  }

  Widget modalidadDropButton(List<String> modalidades) {
    return Container(
      alignment: Alignment.centerLeft,
      child: InfoLabel(
        label: 'Modalidad',
        child: DropDownButton(
            title: Text(modalidades[modalidadSelected],
                style: TextStyle(fontSize: 12)),
            items: modalidades
                .map((e) => DropDownButtonItem(
                    title: Text(
                      e,
                      style: FluentTheme.of(context).typography.body,
                    ),
                    onTap: () => setState(() {
                          modalidadSelected = modalidades.indexOf(e);
                        })))
                .toList()),
      ),
    );
  }

  Widget tipoDropButton(List<String> tipo) {
    return Container(
      alignment: Alignment.centerLeft,
      child: InfoLabel(
        label: 'Tipo',
        child: DropDownButton(
            title: Text(tipoSelected, style: TextStyle(fontSize: 12)),
            items: tipo
                .map((e) => DropDownButtonItem(
                    title: Text(
                      e,
                      style: FluentTheme.of(context).typography.body,
                    ),
                    onTap: () => setState(() {
                          tipoSelected = e;
                        })))
                .toList()),
      ),
    );
  }

  Widget saveButton() {
    return Button(
        child: Text('Guardar'),
        onPressed: () {
          print('id ' + widget.conceptoEntity.id.toString());
          /*
              context.read<ResumenCubit>().getPlanillaDetalle(
                  int.parse(anioDesde.text),
                  int.parse(anioA.text.isEmpty ? anioDesde.text : anioA.text),
                  dni.text);*/
          BlocProvider.of<ConceptosCubit>(widget.context2, listen: false)
              .saveConcepto(ParamConcepto(
                  id: widget.conceptoEntity.id == 0
                      ? null
                      : widget.conceptoEntity.id,
                  modalidad: modalidadSelected + 1,
                  codigo: codigoController.text,
                  naturaleza: naturalezaController.text,
                  abreviatura: abreviaturaController.text,
                  descripcion: descripcionController.text,
                  tipo: tipoSelected.toLowerCase()));
        });
  }

  Widget cancelButton() {
    return Button(
        child: const Text('Cancelar'), onPressed: () => Navigator.pop(context));
  }
}

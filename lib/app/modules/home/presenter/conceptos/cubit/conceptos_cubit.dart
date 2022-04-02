import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:salud_ilo/app/modules/home/domain/concepto_entity.dart';
import 'package:salud_ilo/core/uitls/db_provider.dart';

part 'conceptos_state.dart';

class ConceptosCubit extends Cubit<ConceptosState> {
  ConceptosCubit() : super(ConceptosInitial());

  getConceptos() async {
    emit(LoadingConceptosState());
    var res = await DBProvider.db.getConceptos();
    emit(LoadedConceptosState(conceptos: res));
  }

  saveConcepto(ParamConcepto params) async {
    var res = await DBProvider.db.newConcepto(ParamConcepto(
        id: params.id,
        modalidad: params.modalidad!,
        codigo: params.codigo!,
        naturaleza: params.naturaleza!,
        abreviatura: params.abreviatura!,
        descripcion: params.descripcion!,
        tipo: params.tipo!));
    if (res > 0) {
      emit(SavedConceptosState());
    } else {
      emit(ErrorConceptosState());
    }
  }
}

class ParamConcepto {
  int? id;
  int? modalidad;
  String? codigo;
  String? naturaleza;
  String? abreviatura;
  String? descripcion;
  String? tipo;
  ParamConcepto({
    this.id,
    this.modalidad,
    this.codigo,
    this.naturaleza,
    this.abreviatura,
    this.descripcion,
    this.tipo,
  });

  @override
  String toString() {
    return 'ParamConcepto(id: $id, modalidad: $modalidad, codigo: $codigo, naturaleza: $naturaleza, abreviatura: $abreviatura, descripcion: $descripcion, tipo: $tipo)';
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'modalidad': modalidad,
      'codigo': codigo,
      'naturaleza': naturaleza,
      'abreviatura': abreviatura,
      'descripcion': descripcion,
      'tipo': tipo,
    };
  }

  String toJson() => json.encode(toMap());
}

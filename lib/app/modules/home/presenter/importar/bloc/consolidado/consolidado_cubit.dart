import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:salud_ilo/app/modules/home/domain/consolidado_entity.dart';
import 'package:salud_ilo/app/modules/home/presenter/importar/bloc/import/import_bloc.dart';
import 'package:salud_ilo/core/uitls/db_provider.dart';

part 'consolidado_state.dart';

class ConsolidadoCubit extends Cubit<ConsolidadoState> {
  ConsolidadoCubit(this.importBloc) : super(ConsolidadoInitial()) {
    importBlocSubscription = importBloc.stream.listen((state) {
      print(state.toString());
      if (state is ImportedPlanillaState || state is DeletedImportState) {
        print('entro');
        getConsolidado();
      }
      // React to state changes here.
      // Add events here to trigger changes in MyBloc.
    });
  }

  final ImportBloc importBloc;
  late final StreamSubscription importBlocSubscription;

  getConsolidado() async {
    emit(ConsolidadoLoading());
    final consolidadoEntityList =
        await DBProvider.db.getConsolidadoByAnioAndMes();
    emit(ConsolidadoLoaded(consolidadoEntityList: consolidadoEntityList));
  }
}

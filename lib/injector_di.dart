import 'package:get_it/get_it.dart';
import 'package:salud_ilo/app/modules/home/presenter/importar/bloc/import_bloc.dart';

import 'app/modules/home/presenter/constancia/bloc/resumen_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features - Number Trivia
  // Bloc
  sl.registerLazySingleton(() => ResumenCubit());
  sl.registerFactory(() => ImportBloc());

  //TODO:  REVISAR EL CAMBIO DE PAGINA
}

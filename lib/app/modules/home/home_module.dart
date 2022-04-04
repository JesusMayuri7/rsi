import 'package:flutter_modular/flutter_modular.dart';
import 'package:salud_ilo/app/modules/home/navigation_home.dart';

import 'presenter/constancia/bloc/resumen_cubit.dart';

class HomeModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => ResumenCubit()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute,
        child: (context, args) => const NavigationHome()),
  ];
}

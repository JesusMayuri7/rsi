import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'presenter/conceptos/conceptos_page.dart';
import 'presenter/conceptos/cubit/conceptos_cubit.dart';
import 'presenter/constancia/bloc/resumen_cubit.dart';
import 'presenter/constancia/constancia_page.dart';
import 'presenter/importar/bloc/consolidado/consolidado_cubit.dart';
import 'presenter/importar/bloc/import/import_bloc.dart';
import 'presenter/importar/import_main_page.dart';

class NavigationHome extends StatefulWidget {
  const NavigationHome({Key? key}) : super(key: key);

  @override
  State<NavigationHome> createState() => _NavigationHomeState();
}

class _NavigationHomeState extends State<NavigationHome> {
  int _curretIndex = 0;
  @override
  Widget build(BuildContext context) {
    return FluentApp(
      color: Colors.blue,
      localizationsDelegates: const [DefaultFluentLocalizations.delegate],
      title: 'RED SALUD ILO - PLANILLAS',
      debugShowCheckedModeBanner: false,
      home: Builder(builder: (context) {
        return WindowBorder(
          width: 1,
          color: Color.fromARGB(179, 0, 199, 43),
          child: NavigationView(
            appBar: const NavigationAppBar(
                automaticallyImplyLeading: true,
                height: 30,
                leading: Center(
                  child: FlutterLogo(size: 20),
                )),
            content: MultiBlocProvider(
              providers: [
                BlocProvider(create: (context) => ResumenCubit()),
                BlocProvider(create: (context) => ImportBloc()),
                BlocProvider(
                    create: (context) =>
                        ConsolidadoCubit(BlocProvider.of<ImportBloc>(context))
                          ..getConsolidado()),
                BlocProvider(
                    create: (context) => ConceptosCubit()..getConceptos()),
              ],
              child: NavigationBody(
                index: _curretIndex,
                children: [ConstanciaPage(), ImportMainPage(), ConceptosPage()],
              ),
            ),
            pane: NavigationPane(
                displayMode: PaneDisplayMode.compact,
                onChanged: (i) {
                  setState(() {
                    _curretIndex = i;
                  });
                },
                header: Padding(
                  padding: EdgeInsets.all(8),
                  child: DefaultTextStyle(
                      style: FluentTheme.of(context).typography.title!,
                      child: const Text('Planillas')),
                ),
                items: [
                  PaneItem(
                      icon: const Icon(FluentIcons.a_t_p_logo),
                      title: const Text('Constancia')),
                  PaneItem(
                      icon: const Icon(FluentIcons.p_b_i_import),
                      title: const Text('Importar')),
                  PaneItem(
                      icon: const Icon(FluentIcons.list_mirrored),
                      title: const Text('Conceptos'))
                ]),
          ),
        );
      }),
    );
  }
}

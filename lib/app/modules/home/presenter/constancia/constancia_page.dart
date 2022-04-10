import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:salud_ilo/app/modules/home/presenter/constancia/constancia_grid_page.dart';

import 'grid_page.dart';
import 'header_page.dart';

class ConstanciaPage extends StatefulWidget {
  const ConstanciaPage({Key? key}) : super(key: key);

  @override
  State<ConstanciaPage> createState() => _ConstanciaPageState();
}

class _ConstanciaPageState extends State<ConstanciaPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    appWindow.title = 'Buscar Planilla';

    return Padding(
      padding: const EdgeInsets.only(left: 50, right: 50, top: 10, bottom: 10),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        HeaderPage(),
        const SizedBox(height: 15),
        ConstanciaGridPage(),
      ]),
    );
  }
}

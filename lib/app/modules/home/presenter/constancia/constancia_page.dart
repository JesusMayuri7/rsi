import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:fluent_ui/fluent_ui.dart';

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
    appWindow.title = 'Generar Constancia';

    return Padding(
      padding: const EdgeInsets.only(left: 50, right: 50, top: 10),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        HeaderPage(),
        const SizedBox(height: 15),
        Expanded(child: GridPage()),
      ]),
    );
  }
}

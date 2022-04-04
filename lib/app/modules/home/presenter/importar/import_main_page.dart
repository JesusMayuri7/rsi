import 'package:fluent_ui/fluent_ui.dart';
import 'package:salud_ilo/app/modules/home/presenter/importar/consolidado_grid_page.dart';
import 'package:salud_ilo/app/modules/home/presenter/importar/import_page.dart';

class ImportMainPage extends StatelessWidget {
  const ImportMainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [ImportPage(), ConsolidadoPage()],
    );
  }
}

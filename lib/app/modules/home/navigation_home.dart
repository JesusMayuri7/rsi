import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_modular/flutter_modular.dart';

class NavigationHome extends StatelessWidget {
  const NavigationHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NavigationView(
        appBar: const NavigationAppBar(
            automaticallyImplyLeading: true,
            height: 30,
            leading: Center(
              child: FlutterLogo(size: 20),
            )),
        content: RouterOutlet());
  }
}

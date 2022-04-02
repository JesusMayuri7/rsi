import 'package:fluent_ui/fluent_ui.dart';

class CustomContenDialog extends StatelessWidget {
  const CustomContenDialog({
    Key? key,
    required this.content,
  }) : super(key: key);

  final String content;

  @override
  Widget build(BuildContext context) {
    return ContentDialog(
      title: const Text('Planilla Importada'),
      content: Text(content),
    );
  }
}

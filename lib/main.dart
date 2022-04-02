import 'dart:io';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:flutter_acrylic/flutter_acrylic.dart' as flutter_acrylic;
import 'injector_di.dart' as di;

import 'app/app_module.dart';
import 'app/app_widget.dart';

const String appTitle = 'Fluent UI Showcase for Flutter';

bool get isDesktop {
  if (kIsWeb) return false;
  return [
    TargetPlatform.windows,
    TargetPlatform.linux,
    TargetPlatform.macOS,
  ].contains(defaultTargetPlatform);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setPathUrlStrategy();

  if (isDesktop) {
    await flutter_acrylic.Window.initialize();
  }
  //await di.init();
  //runApp(ModularApp(module: AppModule(), child: AppWidget()));
  runApp(AppWidget());

  if (isDesktop) {
    doWhenWindowReady(() {
      final win = appWindow;
      win.minSize = const Size(800, 600);
      win.size = const Size(800, 600);
      win.alignment = Alignment.center;
      win.title = appTitle;
      win.show();
    });
  }
}

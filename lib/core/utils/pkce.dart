import 'package:flutter/material.dart';
import 'package:flutter_authflow_pro/app.dart';
import 'package:flutter_authflow_pro/core/di/locator.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  runApp(const App());
}

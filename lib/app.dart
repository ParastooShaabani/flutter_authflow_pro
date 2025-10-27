import 'package:flutter/material.dart';
import 'routes/app_routes.dart';

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AuthFlow Pro',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.teal),
      onGenerateRoute: AppRoutes.onGenerateRoute,
      initialRoute: AppRoutes.login,
    );
  }
}

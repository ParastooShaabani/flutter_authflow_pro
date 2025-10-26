import 'package:flutter/material.dart';
import 'package:flutter_authflow_pro/features/auth/presentation/consent_page.dart';
import 'package:flutter_authflow_pro/features/auth/presentation/login_page.dart';
import 'package:flutter_authflow_pro/features/home/presentation/home_page.dart';

class AppRoutes {
  static const login = '/';
  static const consent = '/consent';
  static const callback = '/callback';
  static const home = '/home';

  static Route onGenerateRoute(RouteSettings s) {
    switch (s.name) {
      case login: return MaterialPageRoute(builder: (_) => const LoginPage());
      case consent: return MaterialPageRoute(builder: (_) => const ConsentPage());
      case callback: return MaterialPageRoute(builder: (_) => const CallbackPage());
      case home: return MaterialPageRoute(builder: (_) => const HomePage());
      default: return MaterialPageRoute(builder: (_) => const LoginPage());
    }
  }
}

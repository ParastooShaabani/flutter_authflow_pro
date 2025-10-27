import 'package:flutter/material.dart';
import 'package:flutter_authflow_pro/features/auth/presentation/callback_page.dart';
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
      case login:
        return MaterialPageRoute(
          builder: (_) => const LoginPage(),
          settings: s,
        );
      case consent:
        return MaterialPageRoute(
          builder: (_) => const ConsentPage(),
          settings: s,
        );
      case callback:
        return MaterialPageRoute(
          builder: (_) => const CallbackPage(),
          settings: s,
        );
      case home:
        return MaterialPageRoute(
          builder: (_) => const HomePage(),
          settings: s,
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const LoginPage(),
          settings: s,
        );
    }
  }
}

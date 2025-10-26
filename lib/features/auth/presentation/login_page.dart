import 'package:flutter/material.dart';
import 'package:flutter_authflow_pro/core/di/locator.dart';
import 'package:flutter_authflow_pro/features/auth/data/auth_repository.dart';
import 'package:flutter_authflow_pro/routes/app_routes.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final auth = sl<AuthRepository>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('AuthFlow Pro — Login')),
      body: Center(
        child: FilledButton(
          onPressed: () async {
            final code = await auth.beginAuth();
            if (!mounted) return;
            Navigator.pushNamed(context, AppRoutes.consent, arguments: code);
          },
          child: const Text('Sign in with MockOIDC'),
        ),
      ),
    );
  }
}

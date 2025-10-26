import 'package:flutter/material.dart';
import 'package:flutter_authflow_pro/core/di/locator.dart';
import 'package:flutter_authflow_pro/features/auth/data/auth_repository.dart';
import 'package:flutter_authflow_pro/routes/app_routes.dart';

class ConsentPage extends StatelessWidget {
  const ConsentPage({super.key});

  @override
  Widget build(BuildContext context) {
    final code = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(title: const Text('Grant Access')),
      body: Center(
        child: FilledButton(
          onPressed: () async {
            final auth = sl<AuthRepository>();
            await auth.exchangeCode(code);
            if (context.mounted) {
              Navigator.pushReplacementNamed(context, AppRoutes.home);
            }
          },
          child: const Text('Allow'),
        ),
      ),
    );
  }
}

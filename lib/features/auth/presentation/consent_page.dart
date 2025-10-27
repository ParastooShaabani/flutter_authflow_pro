import 'package:flutter/material.dart';
import 'package:flutter_authflow_pro/core/di/locator.dart';
import 'package:flutter_authflow_pro/features/auth/data/auth_repository.dart';
import 'package:flutter_authflow_pro/routes/app_routes.dart';

class ConsentPage extends StatelessWidget {
  const ConsentPage({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;
    final code = args is String ? args : null;

    if (code == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Grant Access')),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('No authorization code received.'),
              const SizedBox(height: 12),
              FilledButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Back to Login'),
              ),
            ],
          ),
        ),
      );
    }

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

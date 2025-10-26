import 'package:flutter/material.dart';
import 'package:flutter_authflow_pro/core/di/locator.dart';
import 'package:flutter_authflow_pro/features/auth/data/auth_repository.dart';
import 'package:flutter_authflow_pro/routes/app_routes.dart';

class CallbackPage extends StatefulWidget {
  const CallbackPage({super.key});

  @override
  State<CallbackPage> createState() => _CallbackPageState();
}

class _CallbackPageState extends State<CallbackPage> {
  String? message;

  @override
  void initState() {
    super.initState();
    _handleCallback();
  }

  Future<void> _handleCallback() async {
    // In a real OAuth flow, you’d extract `code` from URL parameters.
    // For now, just simulate success after short delay.
    await Future.delayed(const Duration(milliseconds: 500));

    // Exchange mock code for tokens.
    final auth = sl<AuthRepository>();
    final tokens = await auth.exchangeCode('mock_code_123');
    setState(() => message = 'Tokens saved. Access: ${tokens.accessToken}');
    await Future.delayed(const Duration(seconds: 1));

    if (mounted) {
      Navigator.pushReplacementNamed(context, AppRoutes.home);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Redirect Callback')),
      body: Center(
        child: message == null
            ? const CircularProgressIndicator()
            : Text(message!, textAlign: TextAlign.center),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_authflow_pro/core/di/locator.dart';
import 'package:flutter_authflow_pro/core/network/dio_client.dart';
import 'package:flutter_authflow_pro/features/auth/data/auth_repository.dart';
import 'package:flutter_authflow_pro/routes/app_routes.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? secret;
  String? error;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final ctx = context;

    final repo = sl<AuthRepository>();
    final tokens = await repo.current();

    if (tokens == null) {
      if (!ctx.mounted) return;
      Navigator.of(ctx).pushReplacementNamed(AppRoutes.login);
      return;
    }

    try {
      final dio = buildAuthedDio();
      final res = await dio.get('https://mockapi.local/secret');

      if (!ctx.mounted) return; // guard before setState
      setState(() => secret = res.data.toString());
    } catch (e) {
      if (!ctx.mounted) return;
      setState(() => error = e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home (Protected)')),
      body: Center(
        child: secret != null
            ? Text(secret!)
            : error != null
            ? Text('Error: $error')
            : const CircularProgressIndicator(),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final ctx = context;
          await sl<AuthRepository>().logout();
          if (!ctx.mounted) return;
          Navigator.of(ctx).pushReplacementNamed(AppRoutes.login);
        },
        label: const Text('Logout'),
        icon: const Icon(Icons.logout),
      ),
    );
  }
}

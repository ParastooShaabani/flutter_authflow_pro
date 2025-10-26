import 'package:flutter_authflow_pro/core/mock/mock_auth_server.dart';
import 'package:flutter_authflow_pro/core/storage/token_store.dart';
import 'package:flutter_authflow_pro/features/auth/data/auth_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';


final sl = GetIt.instance;

Future<void> setupLocator() async {
  final dio = Dio();
  sl.registerSingleton<Dio>(dio);

  final tokenStore = TokenStoreImpl();
  await tokenStore.init();
  sl.registerSingleton<TokenStore>(tokenStore);

  final authServer = MockAuthServer();
  sl.registerSingleton<MockAuthServer>(authServer);

  sl.registerSingleton<AuthRepository>(AuthRepository(
    auth: authServer,
    store: tokenStore,
  ));
}

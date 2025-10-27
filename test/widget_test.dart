import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_authflow_pro/app.dart';
import 'package:flutter_authflow_pro/core/di/locator.dart';

void main() {
  testWidgets('shows login button', (tester) async {
    // init DI just like in main()
    WidgetsFlutterBinding.ensureInitialized();
    await setupLocator();

    await tester.pumpWidget(const App());
    await tester.pumpAndSettle();

    expect(find.text('Sign in with MockOIDC'), findsOneWidget);
    expect(find.byType(FilledButton), findsOneWidget);
  });
}

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_demo/data/api.dart';
import 'package:flutter_demo/main.dart';

void main() {
  testWidgets('app boots and shows the home app bar', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        // Avoid a real network call in the test environment.
        overrides: [productsProvider.overrideWith((ref) async => [])],
        child: const FlutterDemoApp(),
      ),
    );
    await tester.pump();
    expect(find.text('Flutter Demo'), findsOneWidget);
  });
}

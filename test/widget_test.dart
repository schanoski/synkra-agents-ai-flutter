import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_ai_agent_synkra/app/app.dart';
import 'package:flutter_ai_agent_synkra/core/di/injection.dart';

void main() {
  setUpAll(() async {
    await setupDependencies();
  });

  testWidgets('App starts at login screen', (WidgetTester tester) async {
    await tester.pumpWidget(const App());
    await tester.pumpAndSettle();

    expect(find.text('Synkra Login'), findsOneWidget);
    expect(find.text('Entrar'), findsOneWidget);
  });
}

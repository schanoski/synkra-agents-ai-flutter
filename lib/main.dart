import 'package:flutter/widgets.dart';
import 'package:flutter_ai_agent_synkra/app/app.dart';
import 'package:flutter_ai_agent_synkra/core/di/injection.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupDependencies();
  runApp(const App());
}

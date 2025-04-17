import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'evaluate_robot.dart';

void main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('integrate search results', (WidgetTester tester) async {
    final evaluateRobot = EvaluateRobot(tester);

    await evaluateRobot.loadUI();

    await evaluateRobot.navigateSearch();

    final query = 'Kafe';
    await evaluateRobot.typeSearchQuery(query);
    await evaluateRobot.checkSearchResults(query);
  });

  testWidgets('integrate search not found', (WidgetTester tester) async {
    final evaluateRobot = EvaluateRobot(tester);

    await evaluateRobot.loadUI();

    await evaluateRobot.navigateSearch();

    await evaluateRobot.typeSearchQuery('Kuda Lumping');
    await evaluateRobot.checkSearchNoResults();
  });
}

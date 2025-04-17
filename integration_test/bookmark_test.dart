import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'evaluate_robot.dart';

void main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('integrate bookmark restaurant', (WidgetTester tester) async {
    final evaluateRobot = EvaluateRobot(tester);

    await evaluateRobot.loadUI();

    await evaluateRobot.navigateBookmark();
    await evaluateRobot.checkBookmarkEmpty();

    await evaluateRobot.navigateBack();

    await evaluateRobot.tapRestaurantCard();
    await evaluateRobot.tapBookmarkButton();

    await evaluateRobot.navigateBack();

    await evaluateRobot.navigateBookmark();
    await evaluateRobot.checkBookmarkNotEmpty();
  });
}
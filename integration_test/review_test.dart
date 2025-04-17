import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'evaluate_robot.dart';

void main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('integrate review restaurant', (WidgetTester tester) async {
    final evaluateRobot = EvaluateRobot(tester);

    await evaluateRobot.loadUI();

    await evaluateRobot.waitForApi();
    await evaluateRobot.tapRestaurantCard();

    final name = 'Sulis';
    await evaluateRobot.typeName(name);

    final review = 'Mantap';
    await evaluateRobot.typeReview(review);

    await evaluateRobot.tapSubmitReview();
    await evaluateRobot.checkReviewSubmission(name, review);
  });
}

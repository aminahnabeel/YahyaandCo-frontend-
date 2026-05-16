import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_application_1/core/constants/app_strings.dart';
import 'package:flutter_application_1/main.dart';

void main() {
  testWidgets('shows the splash logo screen initially', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const LedgerApp());

    expect(find.text(AppStrings.appName), findsOneWidget);
  });
}

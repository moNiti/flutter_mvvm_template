import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:template_app/pages/home/home_screen.dart';

import '../../helper/screen_helper.dart';

void main() {
  final screenSizeVariants = ValueVariant<ScreenSize>(basicPhone);
  testWidgets(
      "Given Home Screen, When inital page, Then should see a Submit button",
      (WidgetTester tester) async {
    // ASSEMBLE
    await tester.setScreenSize(screenSizeVariants.currentValue!);
    await tester.pumpWidget(const MaterialApp(home: HomeScreen()));
    await tester.pump(const Duration(seconds: 10));
    final submitButton = find.byKey(const Key("submit"));
    // ACT
    await tester.tap(submitButton);
    // EXPECT
    expect(find.text("Submit"), findsOneWidget);
  }, variant: screenSizeVariants);
}

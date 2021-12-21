import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('TemplateApp -', () {
    final submitButton = find.byValueKey('submit');
    FlutterDriver? driver;
    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });
    tearDownAll(() async {
      if (driver != null) {
        driver!.close();
      }
    });
    test(
        'Given the app run, When tap the submit button, Then toast will shown up. ',
        () async {
      await driver!.tap(submitButton);
      await driver!.waitFor(find.text("Success"));
    });
  });
}

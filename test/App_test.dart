import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/scaffolding.dart';
import 'package:test/test.dart';

void main() {
  group("Test Login", () {
    FlutterDriver? driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() {
      if (driver != null) {
        driver!.close();
      }
    });

    final nonLoginButton = find.byValueKey("test_key");
    test("Probaremos los botones aaa", () {});
  });
}

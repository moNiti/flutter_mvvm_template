import 'dart:ui';
import 'package:flutter_test/flutter_test.dart';

const iphone8Plus =
    ScreenSize(name: "Iphone 8 plus", width: 414, height: 736, pixelDensity: 3);
const iphone12Pro =
    ScreenSize(name: "Iphone 12 pro", width: 428, height: 926, pixelDensity: 3);
const samsungGalaxyS = ScreenSize(
    name: "Samsung Galaxy S", width: 480, height: 800, pixelDensity: 1);

final basicPhone = <ScreenSize>{iphone8Plus, iphone12Pro, samsungGalaxyS};

class ScreenSize {
  final String name;
  final double width, height, pixelDensity;

  const ScreenSize(
      {required this.name,
      required this.width,
      required this.height,
      required this.pixelDensity});

  @override
  String toString() {
    return name;
  }
}

extension ScreenSizeManger on WidgetTester {
  Future<void> setScreenSize(ScreenSize screenSize) async {
    final size = Size(screenSize.width, screenSize.height);
    await binding.setSurfaceSize(size);
    binding.window.physicalSizeTestValue = size;
    binding.window.devicePixelRatioTestValue = screenSize.pixelDensity;
  }
}

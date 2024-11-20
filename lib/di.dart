import 'package:flutter_pampotek/data/controller/base_controller.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void setup() {
  locator.registerSingleton<AuthController>(AuthController());
  locator.registerSingleton<Obatcontroller>(Obatcontroller());
}

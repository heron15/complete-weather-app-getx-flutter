import 'package:get/get.dart';
import 'package:modern_weather_getx/controller/global_controller.dart';

class DependencyInjection extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GlobalController(), fenix: true);
  }
}

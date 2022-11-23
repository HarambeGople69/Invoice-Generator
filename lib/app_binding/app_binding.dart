import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';

import '../controller/dashboard_index_controller.dart';
import '../controller/progress_indicator_controller.dart';

class MyBinding implements Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(
      () => ProgressIndicatorController(),
    );
    Get.lazyPut(
      () => DashboardIndexController(),
    );
  }
}

import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';

import '../controller/dashboard_index_controller.dart';
import '../controller/history_switch_controller.dart';
import '../controller/progress_indicator_controller.dart';
import '../services/network_connection/network_connection.dart';

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
    Get.lazyPut(
      () => CheckConnectivity(),
    );
    Get.lazyPut(
      () => HistorySwitchController(),
    );
    // HistorySwitchController
  }
}

import 'package:get/get.dart';

import '../controllers/client.controller.dart';

class RootBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ClientController());
  }
}
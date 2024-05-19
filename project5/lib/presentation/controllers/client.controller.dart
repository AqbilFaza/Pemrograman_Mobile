import 'package:appwrite/appwrite.dart';
import 'package:get/get.dart';

class ClientController extends GetxController {
  Client client = Client();

  @override
  void onInit() {
    super.onInit();

    // appwrite
    const endPoint = "https://cloud.appwrite.io/v1";
    const project = "project5";

    client.setEndpoint(endPoint).setProject(project).setSelfSigned(status: true);
  }
}
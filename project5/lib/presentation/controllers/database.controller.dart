import 'package:appwrite/appwrite.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import 'client.controller.dart';

class DatabaseController extends ClientController {
  Databases? databases;

  @override
  void onInit() {
    super.onInit();

    // appwrite
    databases = Databases(client);
  }

  Future storeUserName() async {
    try {
      final result = await databases!.createDocument(
        databaseId: "663b06080035bd3321a7",
        documentId: ID.unique(),
        collectionId: "663b0621001ed509af6b",
        data: {
          'name': "user_name",
        },
        permissions: [
          Permission.read(Role.user("user")),
          Permission.update(Role.user("user")),
          Permission.delete(Role.user("user")),
        ],
      );
      print("DatabaseController:: storeUserName $result");
    } catch (error) {
      Get.defaultDialog(
        title: "Error Database",
        titlePadding: const EdgeInsets.only(top: 15, bottom: 5),
        titleStyle: Get.context?.theme.textTheme.titleLarge,
        content: Text(
          "$error",
          style: Get.context?.theme.textTheme.bodyMedium,
          textAlign: TextAlign.center,
        ),
        contentPadding: const EdgeInsets.only(top: 5, left: 15, right: 15),
      );
    }
  }
}
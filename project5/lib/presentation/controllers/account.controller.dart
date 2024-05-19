import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';

import 'client.controller.dart';

class AccountController extends ClientController {
  Account? account;

  @override
  void onInit() {
    super.onInit();

    // appwrite
    account = Account(client);
  }

  Future<User> createAccount(Map map) async {
    return await account!.create(
      userId: map['userId'],
      email: map['email'],
      password: map['password'],
      name: map['name'],
    );
  }

  Future<Session> emailSession(Map map) async {
    return await account!.createEmailSession(
      email: map['email'],
      password: map['password'],
    );
  }

  Future<Session> getSession(Map map) async {
    return await account!.getSession(sessionId: map['sessionId']);
  }

  Future<User> getAccount() async {
    return await account!.get();
  }

  Future<dynamic> deleteSession(Map map) async {
    await account!.deleteSession(sessionId: map['sessionId']);
    return null;
  }
}
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: context.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("welcome".tr, style: const TextStyle(fontSize: 30)),
            Text("page_notfound".tr, style: const TextStyle(fontSize: 30)),
          ],
        ),
      ),
    );
  }
}
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:project5/presentation/bindings/root.binding.dart';
import 'package:project5/presentation/pages/notfound/notfound.dart';
import 'package:project5/presentation/pages/root/root.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      unknownRoute: GetPage(
        name: "/notfound",
        page: () => const NotFoundPage(),
      ),
      getPages: [
        // root
        GetPage(
          name: "/",
          page: () => const RootPage(),
          binding: RootBinding(),
        ),
      ],
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      translationsKeys: const {
        'en_US': {
          'welcome': 'Welcome',
          'page_root': 'Root Page',
          'page_login': 'Login Page',
          'page_register': 'Register Page',
          'page_notfound': 'Noutfound Page',
        },
      },
      locale: const Locale('en', 'US'),
    );
  }
}
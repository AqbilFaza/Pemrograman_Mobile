import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/records_provider.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => RecordsProvider(),
      child: MaterialApp(
        title: 'Tempat Sholat Id',
        theme: ThemeData(
          primarySwatch: Colors.brown,
        ),
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}

import 'package:covid/views/open_screen.dart';
import 'package:flutter/material.dart';
import 'theme/routes.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'COVIDCARE',
      routes: AppRoutes.define(),
      home: const OpeningScreen(),
    );
  }
}

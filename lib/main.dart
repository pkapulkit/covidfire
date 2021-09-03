import 'package:covid/theme/localdb.dart';
import 'package:covid/views/home_screen.dart';
import 'package:covid/views/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'theme/routes.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late bool isLogin = true;

  getLogInState() async {
    await LocalDataSaver.getLogData().then((value) {
      setState(() {
        isLogin = value!;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLogInState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'COVIDCARE',
      routes: AppRoutes.define(),
      home: isLogin ? LoginScreen() : HomeScreen(),
    );
  }
}

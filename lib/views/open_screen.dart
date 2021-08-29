import 'package:covid/theme/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class OpeningScreen extends StatelessWidget {
  const OpeningScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bg = MediaQuery.of(context);
    final logo = Image.asset(
      "assets/logo.png",
      height: bg.size.height / 2,
    );

    final loginButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(25.0),
      color: Colors.white,
      child: MaterialButton(
        minWidth: bg.size.width / 1.2,
        padding: const EdgeInsets.fromLTRB(0, 15, 10, 15),
        onPressed: () {
          Navigator.of(context).pushNamed(AppRoutes.authLogin);
        },
        child: const Text(
          "Login",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );

    final registerButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(25.0),
      color: Colors.white,
      child: MaterialButton(
        minWidth: bg.size.width / 1.2,
        padding: const EdgeInsets.fromLTRB(0, 15, 10, 15),
        onPressed: () {
          Navigator.of(context).pushNamed(AppRoutes.authRegister);
        },
        child: const Text(
          "Register",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );

    final anonyomusButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(25.0),
      color: Colors.white,
      child: MaterialButton(
        minWidth: bg.size.width / 1.2,
        padding: const EdgeInsets.fromLTRB(0, 15, 10, 15),
        onPressed: () async {
          UserCredential userCredential =
              await FirebaseAuth.instance.signInAnonymously();
          Navigator.of(context).pushNamed(AppRoutes.homeRoute);
        },
        child: const Text(
          "Anonymous",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
    final buttons = Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        loginButton,
        const SizedBox(
          height: 10,
        ),
        anonyomusButton,
        const SizedBox(
          height: 10,
        ),
        registerButton,
        const SizedBox(
          height: 70,
        )
      ],
    );
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: Padding(
        padding: const EdgeInsets.all(5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [logo, buttons],
        ),
      ),
    );
  }
}

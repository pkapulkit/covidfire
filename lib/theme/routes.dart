import 'package:covid/views/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:covid/views/login_screen.dart';
import 'package:covid/views/register_screen.dart';

class AppRoutes {
  AppRoutes._();

  static const String authLogin = '/auth-login';
  static const String authRegister = '/auth-register';
  static const String homeRoute = '/home_route';

  static Map<String, WidgetBuilder> define() {
    return {
      authLogin: (context) => const LoginScreen(),
      authRegister: (context) => const RegisterScreen(),
      homeRoute: (context) => const HomeScreen(),
    };
  }
}

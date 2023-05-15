import 'package:flutter/material.dart';
import 'package:iot_app_cusat/screens/forgot_password.dart';
import 'package:iot_app_cusat/screens/home.dart';
import 'package:iot_app_cusat/screens/intro.dart';
import 'package:iot_app_cusat/screens/log_screen.dart';
import 'package:iot_app_cusat/screens/login.dart';
import 'package:iot_app_cusat/screens/registration.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Farm Automation',
      initialRoute: '/home',
      routes: {
        '/': (context) => const IntroScreen(),
        '/register': (context) => const RegistrationScreen(),
        '/login': (context) => const LoginScreen(),
        '/forgot': (context) => const ForgotPasswordScreen(),
        '/home': (context) => const HomeScreen(),
        '/log': (context) => const LogScreen(),
      },
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
    );
  }
}

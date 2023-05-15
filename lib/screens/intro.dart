import 'package:flutter/material.dart';
import 'package:iot_app_cusat/values/colors.dart';
import 'package:iot_app_cusat/values/fonts.dart';
import 'package:iot_app_cusat/widgets/button.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorValues.bgColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Image.asset(
                  'assets/images/top_circle.png',
                )
              ],
            ),
            const Text(
              'IoT',
              style: FontValues.mainHead,
            ),
            Image.asset(
              'assets/images/intro_center.png',
              height: 200,
              width: 200,
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Manage your IoT Devices effectively',
                style: FontValues.subHead1,
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(50.0),
              child: Text(
                'IoT is all about IoT Device Management',
                style: FontValues.mainContent,
              ),
            ),
            InkWell(
                onTap: () {
                  Navigator.pushReplacementNamed(context, '/login');
                },
                child: const RectButton(text: 'Get Started')),
          ],
        ),
      ),
    );
  }
}

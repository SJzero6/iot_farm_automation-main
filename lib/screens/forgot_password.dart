import 'package:flutter/material.dart';
import 'package:iot_app_cusat/values/colors.dart';
import 'package:iot_app_cusat/values/fonts.dart';
import 'package:iot_app_cusat/widgets/button.dart';
import 'package:iot_app_cusat/widgets/input_field.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorValues.bgColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [Image.asset('assets/images/top_circle.png')],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 30),
              child: Text(
                'Forgot Password?',
                style: FontValues.subHead1,
              ),
            ),
            Image.asset(
              'assets/images/forgot_image.png',
              height: 150,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: InputField(hint: 'Email address'),
            ),
            InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/login');
                },
                child: const Text('Sign In', style: FontValues.linkStyle)),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: RectButton(text: 'Submit'),
            )
          ],
        ),
      ),
    );
  }
}

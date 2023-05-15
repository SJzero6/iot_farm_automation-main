import 'package:flutter/material.dart';
import 'package:iot_app_cusat/values/colors.dart';
import 'package:iot_app_cusat/values/conf.dart';
import 'package:iot_app_cusat/values/fonts.dart';
import 'package:iot_app_cusat/widgets/button.dart';
import 'package:iot_app_cusat/widgets/input_field.dart';
import 'package:http/http.dart' as http;

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final TextEditingController _nameController = TextEditingController(text: '');
  final TextEditingController _usernameController =
      TextEditingController(text: '');
  final TextEditingController _emailController =
      TextEditingController(text: '');
  final TextEditingController _passwordController =
      TextEditingController(text: '');
  final TextEditingController _confirmPasswordController =
      TextEditingController(text: '');
  _register(name, username, email, password, conf_password) async {
    if (name.isEmpty ||
        username.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        conf_password.isEmpty) {
      const snackBar = SnackBar(
        content: Text('Fields can\'t be empty!'),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return;
    }
    if (password != conf_password) {
      const snackBar = SnackBar(
        content: Text('Passwords don\'t match'),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return;
    }
    var headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    var request = http.Request('POST', Uri.parse(endpoint));
    request.bodyFields = {
      'name': '$name',
      'username': '$username',
      'email': '$email',
      'password': '$password'
    };
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }

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
              padding: EdgeInsets.symmetric(vertical: 15),
              child: Text(
                'Welcome to IoT',
                style: FontValues.subHead1,
              ),
            ),
            const Text(
              'How do you manage your IoT Devices?',
              style: FontValues.mainContent,
            ),
            const Text(
              'If don\'t know start from here',
              style: FontValues.mainContent,
            ),
            InputField(
              hint: 'Enter your Fullname',
              controller: _nameController,
              obscureText: false,
            ),
            InputField(
              hint: 'Enter your Username',
              controller: _usernameController,
              obscureText: false,
            ),
            InputField(
              hint: 'Enter your Email',
              controller: _emailController,
              obscureText: false,
            ),
            InputField(
              hint: 'Enter your Password',
              controller: _passwordController,
              obscureText: true,
            ),
            InputField(
              hint: 'Confirm Password',
              controller: _confirmPasswordController,
              obscureText: true,
            ),
            InkWell(
                onTap: (() {
                  _register(
                      _nameController.text,
                      _usernameController.text,
                      _emailController.text,
                      _passwordController.text,
                      _confirmPasswordController.text);
                }),
                child: const RectButton(text: 'Register')),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Already have an account? ',
                    style: FontValues.mainContent,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/login');
                    },
                    child: const Text(
                      ' Sign in',
                      style: FontValues.linkStyle,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

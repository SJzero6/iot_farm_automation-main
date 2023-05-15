import 'package:flutter/material.dart';
import 'package:iot_app_cusat/values/fonts.dart';

class InputField extends StatefulWidget {
  var hint;
  var controller;
  var obscureText;

  InputField(
      {super.key, required this.hint, this.controller, this.obscureText});

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  @override
  void initState() {
    super.initState();
    widget.obscureText = false;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: TextFormField(
        controller: widget.controller,
        obscureText: widget.obscureText,
        decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
            hintText: widget.hint,
            hintStyle: FontValues.hintStyle),
      ),
    );
  }
}

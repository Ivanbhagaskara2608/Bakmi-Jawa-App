import 'package:aplikasi_bakmi_jawa/utils/color.dart';
import 'package:flutter/material.dart';

class CustomTextFieldPassword extends StatefulWidget {
  final TextEditingController controller;
  final String title;
  const CustomTextFieldPassword(
      {super.key, required this.controller, required this.title});

  @override
  State<CustomTextFieldPassword> createState() =>
      _CustomTextFieldPasswordState();
}

class _CustomTextFieldPasswordState extends State<CustomTextFieldPassword> {
  bool isPasswordVisible = true;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: const TextStyle(fontSize: 16, color: AppColors.primaryColor),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: TextFormField(
            controller: widget.controller,
            obscureText: isPasswordVisible,
            decoration: InputDecoration(
                suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        isPasswordVisible = !isPasswordVisible;
                      });
                    },
                    icon: Icon(isPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off)),
                border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5)),
          ),
        ),
      ],
    );
  }
}

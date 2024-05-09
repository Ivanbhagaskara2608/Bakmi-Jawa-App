import 'package:aplikasi_bakmi_jawa/utils/color.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String title;
  const CustomTextField({super.key, required this.controller, required this.title});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
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
            decoration: const InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 10, vertical: 5)),
          ),
        ),
      ],
    );
  }
}
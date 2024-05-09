import 'package:aplikasi_bakmi_jawa/utils/color.dart';
import 'package:flutter/material.dart';

class CustomTextFieldPhone extends StatefulWidget {
  final TextEditingController controller;
  const CustomTextFieldPhone({super.key, required this.controller});

  @override
  State<CustomTextFieldPhone> createState() => _CustomTextFieldPhoneState();
}

class _CustomTextFieldPhoneState extends State<CustomTextFieldPhone> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Nomor Telepon",
          style: TextStyle(fontSize: 16, color: AppColors.primaryColor),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: TextFormField(
            controller: widget.controller,
            keyboardType: TextInputType.phone,
            decoration: const InputDecoration(
                prefixText: "+62 ",
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

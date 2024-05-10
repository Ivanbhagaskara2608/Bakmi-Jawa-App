import 'package:aplikasi_bakmi_jawa/utils/color.dart';
import 'package:aplikasi_bakmi_jawa/widgets/custom_textfield_password.dart';
import 'package:flutter/material.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final TextEditingController currentPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmNewPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
        title: const Text(
          "Ubah Password",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: AppColors.backgroundColor,
      ),body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Center(child: Image.asset("assets/images/lock.png", scale: 4)),
            const SizedBox(height: 40),
            CustomTextFieldPassword(controller: currentPasswordController, title: "Password Saat Ini",),
            CustomTextFieldPassword(controller: newPasswordController, title: "Password Baru",),
            CustomTextFieldPassword(controller: confirmNewPasswordController, title: "Konfirmasi Password Baru",),
          ],
        ),
      ),);
  }
}

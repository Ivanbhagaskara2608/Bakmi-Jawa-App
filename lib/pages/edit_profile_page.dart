import 'package:aplikasi_bakmi_jawa/utils/color.dart';
import 'package:aplikasi_bakmi_jawa/widgets/custom_textfield.dart';
import 'package:aplikasi_bakmi_jawa/widgets/custom_textfield_calendar.dart';
import 'package:aplikasi_bakmi_jawa/widgets/custom_textfield_phone.dart';
import 'package:flutter/material.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController birthDateController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Edit Profil",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: AppColors.backgroundColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Center(child: Image.asset("assets/images/user.png", scale: 4)),
            const SizedBox(height: 40),
            CustomTextFieldPhone(controller: phoneController),
            CustomTextField(controller: nameController, title: "Nama"),
            CustomTextFieldCalendar(
                controller: birthDateController, title: "Tanggal Lahir"),
          ],
        ),
      ),
    );
  }
}

import 'package:aplikasi_bakmi_jawa/utils/color.dart';
import 'package:aplikasi_bakmi_jawa/widgets/custom_textfield.dart';
import 'package:aplikasi_bakmi_jawa/widgets/custom_textfield_calendar.dart';
import 'package:aplikasi_bakmi_jawa/widgets/custom_textfield_password.dart';
import 'package:aplikasi_bakmi_jawa/widgets/custom_textfield_phone.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController birthdateController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Align(
              alignment: Alignment.topLeft,
              child: Image.asset(
                "assets/images/frame_atas.png",
                scale: 5,
              )),
          Align(
              alignment: Alignment.bottomRight,
              child: Image.asset("assets/images/frame_bawah.png", scale: 5)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              children: [
                Image.asset(
                  "assets/images/logo_bakmi.png",
                  width: 120,
                  height: 120,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: AppColors.primaryColor, width: 4))),
                      child: const Text(
                        "Daftar",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: AppColors.primaryColor),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    CustomTextFieldPhone(controller: phoneController),
                    CustomTextField(controller: nameController, title: "Nama"),
                    CustomTextFieldCalendar(
                        controller: birthdateController,
                        title: "Tanggal Lahir"),
                    CustomTextFieldPassword(
                        controller: passwordController, title: "Password"),
                    CustomTextFieldPassword(
                        controller: passwordConfirmController,
                        title: "Konfirmasi Password"),
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () {},
                        child: const Text("Lupa Password?",
                            style: TextStyle(
                                fontSize: 13, color: AppColors.primaryColor)),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                        child: const Text("Daftar",
                            style:
                                TextStyle(fontSize: 16, color: Colors.white)),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Sudah punya akun?",
                            style: TextStyle(
                                fontSize: 13, color: AppColors.textColor)),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Text(" Masuk",
                              style: TextStyle(
                                  fontSize: 13, color: AppColors.primaryColor)),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
